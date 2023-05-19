Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB442109
	for <v9fs@lists.linux.dev>; Fri, 19 May 2023 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684482107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g820KSNTP7OMqJOKF462B/JivphTXg8NZzTw8fVuImA=;
	b=R/9hXCCXtpKiiCyOj89qjCGxva3IsayFNYa6nm8WHlkCda1WFeA7XyrZukBIZIMzBttN0o
	0X117DU4VUKDBdAiUpItWlhtVZE87j3Q2P97eXZqtj9wkzOWl9jFZMRUxIYlP9DOvkYYRH
	oU6oZAYB0jVnoWv5GMULeDw7nOZ1gv8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-CWsHB0HDM6aXruJL4c8kbg-1; Fri, 19 May 2023 03:41:40 -0400
X-MC-Unique: CWsHB0HDM6aXruJL4c8kbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8C7E29AB3F4;
	Fri, 19 May 2023 07:41:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D58D7C0004B;
	Fri, 19 May 2023 07:41:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH v20 11/32] 9p:  Add splice_read stub
Date: Fri, 19 May 2023 08:40:26 +0100
Message-Id: <20230519074047.1739879-12-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8

Add a splice_read stub for 9p.  We should use direct_splice_read() if
9PL_DIRECT is set and filemap_splice_read() otherwise.  Note that this
doesn't seem to be particularly related to O_DIRECT.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_file.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6c31b8c8112d..0f3cb439ab2d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -374,6 +374,28 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * v9fs_file_splice_read - splice-read from a file
+ * @in: The 9p file to read from
+ * @ppos: Where to find/update the file position
+ * @pipe: The pipe to splice into
+ * @len: The maximum amount of data to splice
+ * @flags: SPLICE_F_* flags
+ */
+static ssize_t v9fs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct p9_fid *fid = in->private_data;
+
+	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
+		 fid->fid, len, *ppos);
+
+	if (fid->mode & P9L_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 /**
  * v9fs_file_write_iter - write to a file
  * @iocb: The operation parameters
@@ -569,7 +591,7 @@ const struct file_operations v9fs_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
@@ -583,7 +605,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };

