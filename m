Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2338886C
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327664; cv=none; b=hY4E8niGbPRDHoWR7dRMJFrwpYwd74ZEVn7yIuuH/VZzCq84xOqtjZDgZ6cIpQAZ0o6mZE7//r9dhlpXFkXBuS3qcKuFK+Izrc3QE2GJa/ejJlm9HhHl286k6wJzubtBMgz5rVnu+BsxHZhzdCPriqJW5lEc8UvjdWbYuiLdYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327664; c=relaxed/simple;
	bh=okO7J18w1eikmbz5Y9dLJaxGfgc7gaxydAYfM/rl3Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vfq1LOY0j8fexxLplYRdNPsx7tAnNhGeZ3Ipyhf7wwxhPXnICw6JtXr9URgam9YlvHVRYed95fqW228cEQpkogluSGnMxs31eE/6HFm9NhJANVjU2AUspuZym/o1weYwIRDC5jgWtLkEFIVB3gkM60iPmC5VzegOfAJYWCHArhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbO0Ug83; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbO0Ug83"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1308351a91.3
        for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327663; x=1789932463; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFIuFlYyGwgxhlN4dUa6fA3JL/Nyeb33Qy5mdvlrTGw=;
        b=JbO0Ug834QwkUYUSDU7k9WZEHlEsfLM2Xu/w08FwB8pvPLJnpDp1NVvuHPvv9Y9zmh
         k78JNMRjR6pnRuI+JbatzmcOjUfHnQUEQ4NJq9dXV5SiY1ilFhajL6nl9oglTiM1Yhe5
         /OYb3XAXl6wkofhLKAB2jKd7sPFscBPx6Y02+CAq+a67bC1Q7oWNxKqSSUexgSn1h5Wn
         3YhpNQxXul+b6ZUVrC3NuQ17NyzpdMpZWmDlMZ/hUyTUMqmqXFxrdo1droQ8Yi7oOnnz
         +Db+xmZvR1nFqIeC/rBRAMWDEAuwGQpitgqOSTwL3Y3dKxTGQzk5YjbgXx90MSfLeQFG
         0OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327663; x=1789932463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFIuFlYyGwgxhlN4dUa6fA3JL/Nyeb33Qy5mdvlrTGw=;
        b=VDOQPlE8R5S736aLlmsxQU8VB/rm80/mnqdBbPwUzaQLwfBeu6btiZgXYpTukc6uwC
         XXK6Lxo78CUz/wSnRXZnaGzNEdEymUyLYm/6cp6giAF+1YgQORfsQbGebhhHgfzzyEiC
         cmjVhzph9aMY9yjK5uoKDzVk6BzyfnUsjYwUFUeK1IfiqTfLl6ThJzX3ofPti0lo9hgm
         +/4IaD853XliXC6EZoh788/4RVGXxH6KlCfROVLmk3sRrrTvDgtusC0bRsZxWF6u7Ohp
         ZUFvCVecw1yiPMBGEtYnka1yyJcwEZmLgdJyoJmynleEvBAvFd/TTVHnjq/0NF3vbsPm
         f4mg==
X-Gm-Message-State: AFuF++np0A95p+dbDspKAJRXzWzE8TUUBpF/PvbQZPlgxVcx0yC6DqP8
	RausObr1NJSH7A8hyZJstrpl5DU4h/p32dA4Up1N6xp9K7P+wlNKrCYFbHdnag==
X-Gm-Gg: AYBFou0llJhN4kB5X46sw/L6Z+Ogd7fFa82yZioQyUe5BPex7AWFnD8N5LVwl8HMMIH
	sjNyiO87RgAV8vAZFhtF3b3tYEiTlP21onuyEGBkHzxYbMOR1+PF6x1lK5VpzDDBdZR3q9SCLCF
	qXDV5a7L3np0W8FKzV9AH/X180iz3pNLl3bsMpxPey+QhofOJYMNMB4MnhqAH4WKbHC9F4geIw5
	5vuuXHW7JXRib8hweJU9AmnOhTLGkQDLyjwcUXClPtktlLmZPKSpDYn5T32Dx7C3yrh6pfRA3Ac
	eTAzRRxAVdGPXXrPiv2rFzFEAh65qRwc3e3wmfke8CEJEyYKZqd0ZsnOao1CjBeMHEJpX//lLyu
	Z7lGozlUUo78h2SKxMUXsvpTeGvjmiAooM4gUVnaEMyiMB5Td+UT8KC1kJ6ENPabvEL0XnnFset
	iSDaIXvTxXvmm8jmLMHcP2ixqeJggDqn7GkRfy7BYlG83CxnDrCQUqYtKziXg1TN1LBUc9kM9tT
	t2hSij0jOvYMMRtJf2CkqWlkyz+gqVHuC7RQrOtSTH2xrOosDkfEWcAipYHLl7wuoV92+DMTEaX
	lDDGggT/2q+EXUyvMrFEpQJBGN8pB03DGZh/3fpuazEXHVcn
X-Received: by 2002:a17:90b:588d:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39d9c3771a8mr25400733a91.19.1789327662690;
        Sun, 13 Sep 2026 12:27:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95864b4fsm17425657a91.15.2026.09.13.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:27:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] 9p/xen: Use array for data rings
Date: Sun, 13 Sep 2026 12:27:40 -0700
Message-ID: <20260913192740.29668-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 v2: switch to normal array.
 net/9p/trans_xen.c | 66 ++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a066..1e87a55e6042 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -55,7 +55,7 @@ struct xen_9pfs_front_priv {
 	char *tag;
 	struct p9_client *client;
 
-	struct xen_9pfs_dataring *rings;
+	struct xen_9pfs_dataring rings[XEN_9PFS_NUM_RINGS];
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
@@ -450,11 +447,6 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
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
2.55.0

