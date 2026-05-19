Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295F2EE262
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155880; cv=none; b=ay1elXHhVX23RSi4UBAH6e3kf6UVvFIT5HLX95n8T27RMJBE8eB8a2qMs+IaZybQF+B/oXfW9MyuaDIfNy74Y7r7o5VYKgjXRgQIYm6JrySr/a4cIq6VUHD+IV//MgaPXWwdiJXJY0tBClYpDxQPHevue/r7TQplYMW8S0v6+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155880; c=relaxed/simple;
	bh=ZmP2GVNQxmyWh28+5svtLhnVf59ZI1Et7Dqph5Oc4lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5CSJqVZ9I+1alqpLL8BqMpRr8/GUs6szjJzl9C6BixPFybckwlv1wVz/b2y62UUem9VySalwtg1PuklNCf4Sjie4NgHRe+l1tA0gN7MLhVCcGCwHDcyShtfkpuCR9t7t9XfY9H+WoSe4kYi0+hx4GSVCrPHVt0AVTL44pdrOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA0ENIsB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA0ENIsB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3664df32e91so3073153a91.3
        for <v9fs@lists.linux.dev>; Mon, 18 May 2026 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779155878; x=1779760678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWCy8XoZtO6zzmfkdQNcucAepPeXkJBlpgh0VJwhWow=;
        b=DA0ENIsBeM1M3YMiL0ari3K9sYqIcvUj1GlaWD1QnJpn5oI+0oCw8LYYuXmWF38uDZ
         eHwdbFfQpJiw3JE8pDzuhDfKS+/VjXgEChWs7zU+SecaWq222hu+meMOEj+vfu6bl7bg
         Y8sb3FKjB0W7J+lqlPqdqvDpt2vE6oZIbgUEIHvV0NMPyzwcvspKVFR1qz3UbGchdZAH
         mvhJ2iqOVDGGnpS8xnsgg4OTL8K1UgZDxdccWyb1B+ypZlx2Ojgd2lz98RYqEKyx6ixt
         bL0a3+yRlwQPqroOoqc7ivkM2ByAf9wO+DBo99L37MJgL7appDqneib4kRQn4qRcC/2s
         nhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155878; x=1779760678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWCy8XoZtO6zzmfkdQNcucAepPeXkJBlpgh0VJwhWow=;
        b=deN1/SiI54U9JiBvGgYfsL0W6XsaTTapAS/H9JWOqrPcNmd75G56eKZWo9JZrHipKE
         HvNQnMNE/tSwVAAxxxhcyHQ5haMUQt+PToglSjV5jM7rSzUs38qAfD2SOIjxVW+LvU3W
         Mo6LVh9l/EpVxU02OHJ4dlBlUJTWtUU1Ttdh5R39zFzmtuejqreEOBvQX0AfS/ko7iHo
         U5tBS8PEhDCWn4mtY/S7SNPjRYkQqjj289TnsivyA6MQr2hNSNZ7wrlhtSYrDL7UVp17
         9jWCSziCyIsNpbVNY2Zm8X6FLOMlbdD8TVv3oJ/0Ix3HHFcUxl3ULFVos63QVlI/6kO/
         +27Q==
X-Gm-Message-State: AOJu0YxY/HTzE2ngdK/5eUnRpd0+n40A/95eGj+Va0YWVSybwk89ejd7
	rCcNPOdZ+qwlemXQEWw5Vbc8uizFX7J51xJsPUz8YUoAuOaTLLZ1SoWZ0BZEFd39
X-Gm-Gg: Acq92OGeMSJ46vigKRXW2VA6yzzXLVa4TKCuwV0vUpcJ3TyeuXRbiSrZQPbulC7QM7G
	5of4EYk21hugfoe/ianzJCntXzCEaAa5LdkBllCa6rbZnGX5CMekx7h4hFMSDxLmJ8p8oQRTPJM
	wc7rLp/hRQ1T+riE3BlNxNjlDpI23EUdMV0MQHUnENQyE8c9l5us8qB5FS9dyJpTF5wYiQzZbJC
	6ncgmUgdwn3uhyk4Jb3bjLiqi++7mF3U5LP/kPYXNPJSgE39apRvQA/Tvfmu5rO82oTpAoMlOyN
	WA6vGku7R90Kjr4BptPWhRMZcyW8hiVgv6M3qJCntcACpQSnFsxhrCd69L05XJJaehQzUXuXHkR
	yAhMB0bCJj6TLqfJJIDk+Pb33uDEZLdqWfkmFLoeDvcSKPxQe4KP8iUpEiakFfcpU2Vml1D5ws+
	fq2Qh+FeJZHsW5CmKAZEhNokd0NG/zLXoNkPz3AR84PIZ/Stq68k++ShXjMMvHiQx6qGkh3GvyF
	yE3wGWtY+wxA2TCkOhBvkcq4zVPWIRxWWL8hZ7WU3mJxcaeH3bzuMQx
X-Received: by 2002:a17:90b:5848:b0:366:1172:597e with SMTP id 98e67ed59e1d1-369519f2d87mr16881054a91.9.1779155877904;
        Mon, 18 May 2026 18:57:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369572a2a57sm4801619a91.5.2026.05.18.18.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:57:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] 9p/xen: Use flexible array for data rings
Date: Mon, 18 May 2026 18:57:39 -0700
Message-ID: <20260519015739.634423-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the fixed set of Xen 9p data rings in the frontend private
allocation instead of allocating a separate rings array.

This keeps the data ring storage tied to the frontend lifetime and
simplifies the allocation and cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/9p/trans_xen.c | 68 ++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a066..5a110d71d18c 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -55,7 +55,7 @@ struct xen_9pfs_front_priv {
 	char *tag;
 	struct p9_client *client;
 
-	struct xen_9pfs_dataring *rings;
+	struct xen_9pfs_dataring rings[];
 };
 
 static LIST_HEAD(xen_9pfs_devs);
@@ -277,41 +277,38 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 {
 	int i, j;
 
-	if (priv->rings) {
-		for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
-			struct xen_9pfs_dataring *ring = &priv->rings[i];
+	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
+		struct xen_9pfs_dataring *ring = &priv->rings[i];
 
-			cancel_work_sync(&ring->work);
+		cancel_work_sync(&ring->work);
 
-			if (!ring->intf)
-				break;
-			if (ring->irq >= 0) {
-				unbind_from_irqhandler(ring->irq, ring);
-				ring->irq = -1;
-			}
-			if (ring->data.in) {
-				for (j = 0; j < (1 << ring->intf->ring_order);
-				     j++) {
-					grant_ref_t ref;
-
-					ref = ring->intf->ref[j];
-					gnttab_end_foreign_access(ref, NULL);
-					ring->intf->ref[j] = INVALID_GRANT_REF;
-				}
-				free_pages_exact(ring->data.in,
-						 1UL << (ring->intf->ring_order +
-							 XEN_PAGE_SHIFT));
-				ring->data.in = NULL;
-				ring->data.out = NULL;
-			}
-			if (ring->ref != INVALID_GRANT_REF) {
-				gnttab_end_foreign_access(ring->ref, NULL);
-				ring->ref = INVALID_GRANT_REF;
+		if (!ring->intf)
+			break;
+		if (ring->irq >= 0) {
+			unbind_from_irqhandler(ring->irq, ring);
+			ring->irq = -1;
+		}
+		if (ring->data.in) {
+			for (j = 0; j < (1 << ring->intf->ring_order);
+			     j++) {
+				grant_ref_t ref;
+
+				ref = ring->intf->ref[j];
+				gnttab_end_foreign_access(ref, NULL);
+				ring->intf->ref[j] = INVALID_GRANT_REF;
 			}
-			free_page((unsigned long)ring->intf);
-			ring->intf = NULL;
+			free_pages_exact(ring->data.in,
+					 1UL << (ring->intf->ring_order +
+						 XEN_PAGE_SHIFT));
+			ring->data.in = NULL;
+			ring->data.out = NULL;
 		}
-		kfree(priv->rings);
+		if (ring->ref != INVALID_GRANT_REF) {
+			gnttab_end_foreign_access(ring->ref, NULL);
+			ring->ref = INVALID_GRANT_REF;
+		}
+		free_page((unsigned long)ring->intf);
+		ring->intf = NULL;
 	}
 	kfree(priv->tag);
 	kfree(priv);
@@ -446,15 +443,10 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
 		p9_xen_trans.maxsize = XEN_FLEX_RING_SIZE(max_ring_order) / 2;
 
-	priv = kzalloc_obj(*priv);
+	priv = kzalloc_flex(*priv, rings, XEN_9PFS_NUM_RINGS);
 	if (!priv)
 		return -ENOMEM;
 	priv->dev = dev;
-	priv->rings = kzalloc_objs(*priv->rings, XEN_9PFS_NUM_RINGS);
-	if (!priv->rings) {
-		kfree(priv);
-		return -ENOMEM;
-	}
 
 	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 		priv->rings[i].priv = priv;
-- 
2.54.0

