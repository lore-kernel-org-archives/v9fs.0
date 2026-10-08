Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEE472F62
	for <v9fs@lists.linux.dev>; Thu,  8 Oct 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449301; cv=none; b=WP8VYS3iHV3cC0ZMd5V/tpflepaPo+xcObabX7BW8UZ7fIrmEdJL7V31dFZxz/8FKZPpmnyH9NpMic6DVLzbXH3GVbNJ5NZSzSiQ+zwmBBNkfPplWMnqi1lH5duCRv5+A9bhhAitdl0m/1oFQWQeJ0I3wC/KbZqX24En+AcZ0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449301; c=relaxed/simple;
	bh=Ju0Yv+Fjhbwhlq/OKXJEkW3OwfQP3yyXW+rrdIOJEG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ilOOmXy/hYvvfbi80VLVbXlAwPWXIsQQ5O3xYkH6j9da6Hd/3x3xhN9jJyEHJ9hBXLZhwdtu3pDbVM9yBvNtksJsNwytb+bnfe8Rwxw3XY1u9V25sp8iYredj+LOShIi+wAYGHjRbutg403t1eJafo3c0dZ4ax+3bPj2Q9HNpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu2TE3dT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu2TE3dT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791449299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh+3Gh0Y56agn0p+tkm2VTt40sFPbeE+JMnvEBDgDWQ=;
	b=Tu2TE3dT1JQd5zIjCi1j7kGLkPqi3LiWSQ1EKcaEVKCbB2kI3RhhoiNlu8kBl0wDqLgfUe
	zNHDxFRR0VJLLbtxZPkgNC4sN3j+wdfCyHa0ds23w61k6EiHNN0a1gD/ocGdJrStzHdpx5
	MyHdGEO8jzJwxupv2FTwHiMZY86QmLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-xiFIL3ksPzuRcdo44D1s1Q-1; Thu,
 08 Oct 2026 04:48:13 -0400
X-MC-Unique: xiFIL3ksPzuRcdo44D1s1Q-1
X-Mimecast-MFC-AGG-ID: xiFIL3ksPzuRcdo44D1s1Q_1791449291
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3BF71956056;
	Thu,  8 Oct 2026 08:48:10 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1281426;
	Thu,  8 Oct 2026 08:48:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v16 5/8] netfs: Provide a func to load the readahead buffers into a bvecq chain
Date: Thu,  8 Oct 2026 09:47:17 +0100
Message-ID: <20261008084722.963948-6-dhowells@redhat.com>
In-Reply-To: <20261008084722.963948-1-dhowells@redhat.com>
References: <20261008084722.963948-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: GmXiSbZphBJ8H_ZSE8x3BrnrEqX34jpEL5quD4imdQw_1791449291
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In netfslib, provide a function to load the readahead buffers into a bvecq
chain by preallocating the bvecq chain and then iterating directly over the
pagecache to extract all the folios.  This builds on the preceding patch to
note the folio count in the readahead_control struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/bvecq.c      | 60 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/bvecq.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
index 2d58aa368167..fa03de044974 100644
--- a/fs/netfs/bvecq.c
+++ b/fs/netfs/bvecq.c
@@ -604,3 +604,63 @@ size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
 	pos->offset = offset;
 	return size;
 }
+
+/**
+ * bvecq_load_from_ra - Allocate a bvecq chain and load from readahead
+ * @pos: Blank position object to attach the new chain to.
+ * @ractl: The readahead control context.
+ *
+ * Decant the set of folios to be read from the readahead context into a bvecq
+ * chain.  Each folio occupies one bio_vec element.
+ *
+ * Return: Amount of data loaded or -ENOMEM on allocation failure.
+ */
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos, struct readahead_control *ractl)
+{
+	XA_STATE(xas, &ractl->mapping->i_pages, ractl->_index);
+	struct folio *folio;
+	struct bvecq *bq;
+	unsigned int slot = 0;
+	size_t loaded = 0;
+
+	bq = bvecq_alloc_chain(ractl->_nr_folios, GFP_KERNEL, false);
+	if (!bq)
+		return -ENOMEM;
+
+	pos->bvecq  = bq;
+	pos->slot   = 0;
+	pos->offset = 0;
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, folio, ractl->_index + ractl->_nr_pages - 1) {
+		size_t len;
+
+		if (xas_retry(&xas, folio))
+			continue;
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+		len = folio_size(folio);
+		bvec_set_folio(&bq->bv[slot], folio, len, 0);
+		loaded += len;
+		slot++;
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+
+		if (slot >= bq->max_slots) {
+			bvecq_filled_to(bq, slot);
+			bq = bq->next;
+			if (!bq)
+				break;
+			slot = 0;
+		}
+	}
+
+	rcu_read_unlock();
+
+	if (bq)
+		bvecq_filled_to(bq, slot);
+
+	ractl->_index += ractl->_nr_pages;
+	ractl->_nr_pages = 0;
+	return loaded;
+}
diff --git a/include/linux/bvecq.h b/include/linux/bvecq.h
index 6a50bba8b23a..cb198ad01c8f 100644
--- a/include/linux/bvecq.h
+++ b/include/linux/bvecq.h
@@ -77,6 +77,7 @@ void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount);
 ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount);
 size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
 		   unsigned int max_slots, unsigned int *_nr_slots);
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos, struct readahead_control *ractl);
 
 /**
  * bvecq_alloc_buffer - Allocate a bvecq chain and populate with buffers

