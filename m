Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9141457E6C
	for <v9fs@lists.linux.dev>; Wed, 30 Sep 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799318; cv=none; b=NP7Sj2ZlwXn3arWVodO3MNUViQHgogJkeg8kkWSn5TMM1k0fYf+ueGPNOt/knpNKK4xMOJsfRZehEjehrPa85FgCRVNxI5nD9A3grl/BSeBhlNW7khMGRyEYXGezpVoCd91aNgUOJy0Vj2Yr/IbQmEsWzu61wGljhwrnA2BzV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799318; c=relaxed/simple;
	bh=dkl74J2iGAfgs5zwrml4l7A6bTNzb1g1T7sdU85oCTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQ/TvvQN1CKkhbTEZbFnD4lfvpuYpd66OWkdRE1YPmtjvOMvPHD8ssRTCAbvuP+PY4rwVQLIe5yM/OtVTFmRZbwusa4E18EaT6+DWTbg1HS6iS63LcVae5iTp7EBm1cAAf6PmnF5Vkkzv3/78WSekRXaoxIzpNuVBryfyBpUd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=kzj5VrLh; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="kzj5VrLh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=U5331XFavrhG70kE99m0/AzAYBB0fxfgmvEAiEWpiw0=; b=kzj5VrLh0IYfIYuSTLN4Ncyr1e
	p8wcQExUx0sBaxeTgvND5CmjlGjPR83zq+P9ASKupEaieHV7ubm6JuIPmnzKTvbalmJgATRFGCQEE
	S+yYrcrNCOZU/gbSw95foEgaEjzud8dL3r5MskEshwpu+MKnTqMpftv+zQQaUeMjno4iDqGMbWQPd
	POdPr63i37KYqHflK8iKZ50dEg05DkEgZ7vmeQeIDPjZv0f3yu3aGTGG1Bk9qirm7JbXlileIzDsx
	HlXugteEUqoV/AEa1SCm9Fgnyx5Ewj5+t3HEKAwpDm9cSEULPMT765dlyRybyOn1peHDH42RAqbgx
	gAa38U5g==;
Received: from [151.115.150.205] (port=55214 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xC0hw-0000000BVHF-35sh;
	Wed, 30 Sep 2026 22:15:14 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@kernel.org
Subject: [PATCH] 9p: pin request under client lock in p9_tag_lookup
Date: Wed, 30 Sep 2026 20:13:58 +0000
Message-ID: <20260930201357.590469-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

9P clients keep separate request tables but share one request cache.
p9_tag_lookup() can race with the final p9_req_put() and pin a request
reused by another client. Both clients can then complete it, freeing
its response while the caller still parses it, creating a UAF that
KASAN reports as:

  BUG: KASAN: slab-use-after-free in p9pdu_readf+0x362/0x2130
  Read of size 4 at addr ffff888009520000 by task repro/82

  Freed by task 50:
   p9_req_put+0x1a4/0x1f0
   p9_read_work+0x916/0xf80

Hold the client lock while finding and pinning the request, preventing
removal and reuse between these operations.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/9p/client.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52..fd72f05128d1 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,24 +235,18 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
 {
 	struct p9_req_t *req;
+	unsigned long flags;
 
-	rcu_read_lock();
-again:
+	/*
+	 * Pin the request while removal from this client's IDR is excluded.
+	 * Tag equality alone cannot distinguish a request recycled for another
+	 * client from the same SLAB_TYPESAFE_BY_RCU cache.
+	 */
+	spin_lock_irqsave(&c->lock, flags);
 	req = idr_find(&c->reqs, tag);
-	if (req) {
-		/* We have to be careful with the req found under rcu_read_lock
-		 * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to get the
-		 * ref again without corrupting other data, then check again
-		 * that the tag matches once we have the ref
-		 */
-		if (!p9_req_try_get(req))
-			goto again;
-		if (req->tc.tag != tag) {
-			p9_req_put(c, req);
-			goto again;
-		}
-	}
-	rcu_read_unlock();
+	if (req && !p9_req_try_get(req))
+		req = NULL;
+	spin_unlock_irqrestore(&c->lock, flags);
 
 	return req;
 }
-- 
2.47.3

