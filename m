Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067781;
	b=D7WqEDT0LflWtsMDobEU4NCsBM5Da7GokrFzgzd01kAKNgtBM8OjjbC/j926uM3Xsv0w
	 wYOZWecuFwlRFN9E5OqUNkWKoAKkipOqKDb3WqVZv53dm2welbcCYQ9aTtLFx8H7015ds
	 gS2Sjwf4WrmnU0Hdgh9JdOSj9nLmK9t+PuMtvb9R5KTOl4uavW3n2tV5MBesTVgEn29e4
	 10gzrb6COh7n5xo1QuHgmt2xMajydaKombUTSqE+SPk+b2Y5+7xWDbJdAMAouSY0JnULk
	 IQwT3bnIly5ed6l1Y8cdZvPpGSqodfaD+7eJyGR/7LNaZT1AcY+QjELrVMg+YhzX6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067781;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=B+LcU0iAB6zF1j5jKHzCoQfZKOaKDUALsypy6nIfsag=;
	b=NjVUJv+R28VhjPJnsCOPhqhuW4o81V4WeurhAc4kRe6p+vJjG113hvNoRAg6OQt8jLHy
	 aKSJ72KGiB66QbOqEETtUe8uApUrCwProhQEDy4ljU1wIKTz43ijnjOyk1R4lFRxfxD/F
	 Kcx/9fiMJVerIGi5RX6CDg90pQSoN9lha2vQSPaCM6VKm1liWBrHRhgKpT+RmmtaXynuR
	 IgI7QMOSe2UTM4F8hJyKCl+8sczDZvo4dVCazUsIw+1Qb3FPRxlbDesQZwelmYwhAhU8H
	 zXFh570YamR0bT1SaXG4OgoakMy8kM+ebZ+PCIbLYnn3Dt0/06kPgUUL1sYOPkBTpTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRK0Z7Op;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1660A6F7B
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 16:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F1660A6F7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRK0Z7Op
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794067779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+LcU0iAB6zF1j5jKHzCoQfZKOaKDUALsypy6nIfsag=;
	b=RRK0Z7OpCR9wXebUaQ7HkKunPXMEsUWkuM3no1rNn0evlcVx3GpQOifQtcey7EMZhpt7GL
	diFdnLja+JTUxWGNpeFV48kQGbIpYnS6IcwE3Mdrv+daKXEUc9Bf3UTHj9VqeYY1KbxKk8
	oDXZlkdD4VNSjhuA/Zc6Elr3fth1CBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-IVxLsQ3sPHS9fSngOuAmXA-1; Sat,
 07 Nov 2026 11:09:35 -0500
X-MC-Unique: IVxLsQ3sPHS9fSngOuAmXA-1
X-Mimecast-MFC-AGG-ID: IVxLsQ3sPHS9fSngOuAmXA_1794067772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 848E218002AB;
	Sat,  7 Nov 2026 16:09:32 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E4A43001DA7;
	Sat,  7 Nov 2026 16:09:28 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v16 11/15] smbdirect: Support ITER_BVECQ in smbdirect_map_sges_from_iter()
Date: Sat,  7 Nov 2026 16:08:14 +0000
Message-ID: <20261107160823.1465553-12-dhowells@redhat.com>
In-Reply-To: <20261107160823.1465553-1-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 2vj_CSskJZ_Jactvt1SFPlMsTxi85aVV-JOOTvUH4Ow_1794067772
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add support for ITER_BVECQ to smbdirect_map_sges_from_iter().

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stefan Metzmacher <metze@samba.org>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Namjae Jeon <linkinjeon@kernel.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/smbdirect/connection.c | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/smb/smbdirect/connection.c b/fs/smb/smbdirect/connection.c
index e6c7b343fe87..b13bd07ffb8c 100644
--- a/fs/smb/smbdirect/connection.c
+++ b/fs/smb/smbdirect/connection.c
@@ -5,6 +5,7 @@
  */
 
 #include "internal.h"
+#include <linux/bvecq.h>
 #include <linux/folio_queue.h>
 
 struct smbdirect_map_sges {
@@ -2015,6 +2016,69 @@ static ssize_t smbdirect_map_sges_from_bvec(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
+ * list.  The fragments are not pinned.
+ */
+static ssize_t smbdirect_map_sges_from_bvecq(struct iov_iter *iter,
+					     struct smbdirect_map_sges *state,
+					     ssize_t maxsize)
+{
+	const struct bvecq *bq = iter->bvecq, *next;
+	unsigned int slot = iter->bvecq_slot;
+	ssize_t extracted = 0;
+	size_t offset = iter->iov_offset;
+
+	maxsize = umin(maxsize, iov_iter_count(iter));
+
+	do {
+		struct bio_vec *bv;
+		size_t bsize;
+
+		while (slot >= bq->nr_slots) {
+			next = bvecq_next(bq);
+			if (!next) {
+				if (WARN_ON_ONCE(maxsize > 0))
+					return -EIO;
+				goto out;
+			}
+			bq = next;
+			slot = 0;
+		}
+
+		bv = &bq->bv[slot];
+		bsize = bv->bv_len;
+
+		if (offset < bsize) {
+			size_t part = umin(maxsize, bsize - offset);
+			bool ok;
+
+			ok = smbdirect_map_sges_single_page(state,
+							    bv->bv_page,
+							    bv->bv_offset + offset,
+							    part);
+			if (!ok)
+				return -EIO;
+
+			offset += part;
+			extracted += part;
+			maxsize -= part;
+		}
+
+		if (offset >= bsize) {
+			offset = 0;
+			slot++;
+		}
+	} while (state->num_sge < state->max_sge && maxsize > 0);
+
+out:
+	iter->bvecq = bq;
+	iter->bvecq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= extracted;
+	return extracted;
+}
+
 /*
  * Extract fragments from a KVEC-class iterator and add them to an ib_sge list.
  * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
@@ -2164,6 +2228,9 @@ static ssize_t smbdirect_map_sges_from_iter(struct iov_iter *iter, size_t len,
 	case ITER_BVEC:
 		ret = smbdirect_map_sges_from_bvec(iter, state, len);
 		break;
+	case ITER_BVECQ:
+		ret = smbdirect_map_sges_from_bvecq(iter, state, len);
+		break;
 	case ITER_KVEC:
 		ret = smbdirect_map_sges_from_kvec(iter, state, len);
 		break;

