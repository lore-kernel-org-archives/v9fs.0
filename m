Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58796399364
	for <v9fs@lists.linux.dev>; Mon,  6 Jul 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351701; cv=none; b=S2Tc1DyXqbCgVxPBXO6gR8h2vGg6PH6vttxLI6ES3aPPosA+Ai0W/cWLnfM2fW7/ILJQEXiSAx+i01FT6B2u8TE6ANQBNckOzIbGmm7gQ3itOOph2qiI6wFi/G9Yvj33lJgLg32IFXdX0fIOnp1OZqPEv+/JzNMYrLSOmyjQZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351701; c=relaxed/simple;
	bh=WnUrIoFsPW78MzYAVx0FrQKBJh5ob5aqpScAtxwFRGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=U9dD2i2Qe9N8x3b6yeM2BPdkFQOEevNGKdOrPz09jYc1LkhgTsotmPheS82lV1fvb3gcyWvTNnMTZMsgtkStjJAsELrtCvdjxonYGMIiyoNPlF/8qhOmkfGk8G3X6yR4EnkZPDhj0LcU4gGdHqF8gkJeiLOj8rbkB7g3iVJ+swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVorDcYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVorDcYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783351699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAh3PBs47lZUHcwbeGXM5gS5ZzePV60tR0gQfqSs8Ac=;
	b=dVorDcYp/o7UuWI7wOdZz39DwKcpkgpZ+k5eGZR1vKaNyjgXDeSx71IC44OqMN5XrnAJqa
	Sp5eA2tEdprP2872Ea8JnXsUUUUeDwTsZkyF9eLXphPREdwGb7q0ONnDGgNBRLJaSsFvqI
	CxMH7g0rELMJ2kjDpKqRKHU4EVHAmjQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-QcHcavJwNXO9huLoueR7NQ-1; Mon,
 06 Jul 2026 11:28:12 -0400
X-MC-Unique: QcHcavJwNXO9huLoueR7NQ-1
X-Mimecast-MFC-AGG-ID: QcHcavJwNXO9huLoueR7NQ_1783351689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B65E18052D0;
	Mon,  6 Jul 2026 15:28:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9039E18005A5;
	Mon,  6 Jul 2026 15:27:57 +0000 (UTC)
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
	linux-mm@kvack.org
Subject: [PATCH v5 01/21] mm: Make readahead store folio count in readahead_control
Date: Mon,  6 Jul 2026 16:27:16 +0100
Message-ID: <20260706152737.1231312-2-dhowells@redhat.com>
In-Reply-To: <20260706152737.1231312-1-dhowells@redhat.com>
References: <20260706152737.1231312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: zhK8pQIW8eSjDsQ-GLZqHVQ7X1eYrm3cmKlHzAAQ_EA_1783351689
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make readahead store folio count in readahead_control so that the
filesystem can know in advance how many folios it needs to keep track of.

This is cleared by read_pages() in case it is called from a loop.

The count is accessed by the filesystem with readahead_folio_count().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/pagemap.h | 10 ++++++++++
 mm/readahead.c          |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..e1e51bace388 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1348,6 +1348,7 @@ struct readahead_control {
 	struct file_ra_state *ra;
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
+	unsigned int _nr_folios;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
 	bool dropbehind;
@@ -1527,6 +1528,15 @@ static inline size_t readahead_batch_length(const struct readahead_control *rac)
 	return rac->_batch_count * PAGE_SIZE;
 }
 
+/**
+ * readahead_folio_count - Get the number of folios in this readahead request.
+ * @rac: The readahead request.
+ */
+static inline unsigned int readahead_folio_count(const struct readahead_control *rac)
+{
+	return rac->_nr_folios;
+}
+
 static inline unsigned long dir_pages(const struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
diff --git a/mm/readahead.c b/mm/readahead.c
index 558c92957518..069ded56fd80 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,7 @@ static void read_pages(struct readahead_control *rac)
 	if (unlikely(rac->_workingset))
 		psi_memstall_leave(&rac->_pflags);
 	rac->_workingset = false;
+	rac->_nr_folios = 0;
 
 	BUG_ON(readahead_count(rac));
 }
@@ -303,6 +304,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (i == mark)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
+		ractl->_nr_folios++;
 		ractl->_nr_pages += min_nrpages;
 		i += min_nrpages;
 	}
@@ -473,6 +475,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		return err;
 	}
 
+	ractl->_nr_folios++;
 	ractl->_nr_pages += 1UL << order;
 	ractl->_workingset |= folio_test_workingset(folio);
 	return 0;
@@ -822,6 +825,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
+		ractl->_nr_folios++;
 		ractl->_nr_pages += min_nrpages;
 		ractl->_index = folio->index;
 	}
@@ -851,6 +855,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
+		ractl->_nr_folios++;
 		ractl->_nr_pages += min_nrpages;
 		if (ra) {
 			ra->size += min_nrpages;

