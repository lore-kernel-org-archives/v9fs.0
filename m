Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E544605F
	for <v9fs@lists.linux.dev>; Tue,  4 Aug 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837811; cv=none; b=ogLGgaThbuWHN8q8Qgkrg5pPOSbh6spQS792P6f/I2mfkDjVSfL0LiTRrWcaB0yTScYb9TrwjKbS1tqc+LmJyZnh5OhFlWGvalyojRKB31YCAhBn2GlkHaWVYgNThnOIoepKKx1QyvvI6Auu0Y1o/hAPUEMemd/peBufGIyqHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837811; c=relaxed/simple;
	bh=W2r34cI+XaaQUdqCi3aOgKHvzlTyAT8XuHNk4YjX+HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IAms7UZ8uXxWdiK0qqTDnIJD8RgByJf5UO9GC73wN3eJAzXJIkUHkMZt1JGZFcOABhSXWaNXrE7A3rVvrbmjON4+SwjBZINjCsCYt5+zkZPl1S0yQt2EyOzWKsVYbZsYKlEPoUyxnvg8rvVdVC1JBuYsDyhk8eTBeliEovy+Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7upPiOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7upPiOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785837809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=forfFVNHXdcKUrAO6tYWFvQxC3xkWQUr9XOJVlaCNVg=;
	b=L7upPiOiZslocxbBGfO3y3y9EHlWqlimd+Px0PABtN+mYpfn9nQ3VNAyTgTPtMRi/f88A5
	STSZr7jicj8FF+5tFIl4loEQZAnWzWVMZrHjTOshQRDoJIiimxb6Ys24dXR+BaNJwXAtjj
	d1ZQ+06tDFfMEVnzrCd5mZsvY1x+Pwk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-D9vewdzqPTqtYuFKpPv8iQ-1; Tue,
 04 Aug 2026 06:03:09 -0400
X-MC-Unique: D9vewdzqPTqtYuFKpPv8iQ-1
X-Mimecast-MFC-AGG-ID: D9vewdzqPTqtYuFKpPv8iQ_1785837786
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 247EA1956096;
	Tue,  4 Aug 2026 10:03:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 514F430001B9;
	Tue,  4 Aug 2026 10:02:58 +0000 (UTC)
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
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v8 03/25] Add a function to kmap one page of a multipage bio_vec
Date: Tue,  4 Aug 2026 11:01:58 +0100
Message-ID: <20260804100224.2748935-4-dhowells@redhat.com>
In-Reply-To: <20260804100224.2748935-1-dhowells@redhat.com>
References: <20260804100224.2748935-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: dttSHkUt1rWbKvA4-JAv5M9UmosLX0lKOiR0sLdjMww_1785837786
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
index 92837e2743f1..53cf36e73967 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -343,4 +343,22 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
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

