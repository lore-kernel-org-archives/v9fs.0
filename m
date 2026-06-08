Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A047ECCD
	for <v9fs@lists.linux.dev>; Mon,  8 Jun 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930552; cv=none; b=abj7IICgJ7v5bQur4c1NmF4t5YPBqlhwltINioazf20Gi/fVWxUpWvURxwP93Mr3G+4tX5pVFLUJSGymR+zdI6J0Bm64c5onlygj7YOxVM6UGoX7m0PRPdstEZJb+4ltNwgMKEREXSrbLt1cI8xis6siT/q2SP1fWrFfuf/PCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930552; c=relaxed/simple;
	bh=SqwxklJ83o+kHGOaNAJRUgJP9VhfEJ76YUfw/s63bUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nN0c0RhT/OPSLSrN40sPq00WoDrmJTyljX06FSqoWonHmdZzaAhlA5OR/+a0pcRqB9vR7WBlNuPe0p2vHMO4M884RIw/56C9smxAoeEb2wjgZfwwd/4jUMU9bD9xkxjdObgtTlLZdbVbhtbV0tGqvQqO+4qfO/AYL986D+NFbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAl14Pdw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAl14Pdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780930546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7WyxlyafAfljSXx2zE5evSFbmc9/FNDO8/ZJyEWYy0=;
	b=cAl14PdwpIkGlKBW3TNjUOdf3aDft24HSLckslL2T+qlZl8ZtcaLBK8PMRP/dT16gpnP8G
	/UfqkgDWnu/OzU60krjHadcViELXQAWHdYT0q6GeOFV0608m9azofGBOANcOF11/tvb0Y1
	lqz/cOP7V0qixqzy/7pIajDh0f+hHu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-7hFZL4NDMYK6OKyZssoBEw-1; Mon,
 08 Jun 2026 10:55:42 -0400
X-MC-Unique: 7hFZL4NDMYK6OKyZssoBEw-1
X-Mimecast-MFC-AGG-ID: 7hFZL4NDMYK6OKyZssoBEw_1780930539
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1AB11956058;
	Mon,  8 Jun 2026 14:55:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E2241955BC0;
	Mon,  8 Jun 2026 14:55:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v3 06/22] Add a function to kmap one page of a multipage bio_vec
Date: Mon,  8 Jun 2026 15:54:14 +0100
Message-ID: <20260608145432.681865-7-dhowells@redhat.com>
In-Reply-To: <20260608145432.681865-1-dhowells@redhat.com>
References: <20260608145432.681865-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: J65t-mAiABZXapZGAZboFZWJCTc5d2CXDyn7UwM_Sbw_1780930539
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a function to kmap one page of a multipage bio_vec by offset (which is
added to the offset in the bio_vec internally).  The caller is responsible
for calculating how much of the page is then available.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d36dd476feda..f834a862224e 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -299,4 +299,22 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * bvec_kmap_partial - Map part of a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ * @offset: Offset into bvec
+ *
+ * Map the page containing the byte at @offset into the kernel virtual address
+ * space.  The caller is responsible for making sure this doesn't overrun.
+ *
+ * Call kunmap_local on the returned address to unmap.
+ */
+static inline void *bvec_kmap_partial(struct bio_vec *bvec, size_t offset)
+{
+	offset += bvec->bv_offset;
+
+	return kmap_local_page(bvec->bv_page + (offset >> PAGE_SHIFT)) +
+		(offset & ~PAGE_MASK);
+}
+
 #endif /* __LINUX_BVEC_H */

