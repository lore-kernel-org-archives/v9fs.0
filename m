Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68B1E379F
	for <v9fs@lists.linux.dev>; Fri, 13 Dec 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097872; cv=none; b=duxOT56cfTHTP2ElDXGtboi7bZlGkKlbEkHX9K0YLJImzkRAQDJMGyViUsQvTqM6b7nnoNgjbWuDjIaxSHXD690KQv7kaHFK5J1xwokleE7QET8ps9MPMpPc9FR9/B39w8tY9X5HJxPjeTF9wonWGZy0ZWg1CZQaIHd1M5tmIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097872; c=relaxed/simple;
	bh=uaeI9J7rEoRhi5ZksmwE/88jFR1W/T6sdc10RyCTsN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4lxAkBv++G9dELMg4X3oSLWPo7WCxbUDLKDSZQ6jOrjUvaDCCb5Y2ahiNieblT3Podgr66f5yRDR2bb6c/n24S8V6k/nVgSnq5v78JWUJXZM6s1RclC43p1c0fZkPKZyHUi37QcH95ux74GstwR2pZbDCFEvTIfxvujK7rvZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Opmb7oMZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opmb7oMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahqI5gLkGfD05TuY+PqQn3pxJDwXGZGfLY3MOFYgVE=;
	b=Opmb7oMZAhU19zFew4Q9s26TEEmklbZ5TZuYFqxDphnYwpLHeZXyUlUyScVyHcke6r3zbL
	VHWOeS36i2WmfsHH/Bx0ky0XZ28jnIWBIa4wJbLZ0+IUMlhvv0Xlq2eIkTeHfKiJc9gm0D
	u8KznsG5+25p0n4DvHaG3V2MMw6MUYk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-NQm--YxLM0SK64NOpZx29g-1; Fri,
 13 Dec 2024 08:51:06 -0500
X-MC-Unique: NQm--YxLM0SK64NOpZx29g-1
X-Mimecast-MFC-AGG-ID: NQm--YxLM0SK64NOpZx29g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4CD19560B5;
	Fri, 13 Dec 2024 13:51:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 058071955F40;
	Fri, 13 Dec 2024 13:50:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
Date: Fri, 13 Dec 2024 13:50:06 +0000
Message-ID: <20241213135013.2964079-7-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Zilin Guan <zilin@seu.edu.cn>

The function netfs_unbuffered_write_iter_locked() in
fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
that ensures the flag update is visible before the function returns, the
smp_rmb() provides no additional benefit and incurs unnecessary overhead.

This patch removes the redundant barrier to simplify and optimize the code.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
---
 fs/netfs/direct_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..173e8b5e6a93 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
-		smp_rmb(); /* Read error/transferred after RIP flag */
 		ret = wreq->error;
 		if (ret == 0) {
 			ret = wreq->transferred;

