Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1414199949
	for <v9fs@lists.linux.dev>; Wed, 25 Feb 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981751; cv=none; b=LA39O1ZQAi72Bw8iuozKrhBv0M4FdfJu1FydanNAI6WFYBfTwrkQ9gWFgxuH11ap/nVW6nf9rRRrtO5QHlZh/2HvL/Nv2jq8wIJitUuak9f6ZNVNEN8Tbf8Grm+x1J0+LVRFNcrYcEBHikRDLDpLbJCkrUoA4U1TJmo/OqlnNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981751; c=relaxed/simple;
	bh=UzebxA6/a7fg3sjOiWp/u7lzb1dFODtxX1sVJYsce3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecy0YzuMjWXzG0EsjmnupadximgUtiH2h/PPkgjheNE8SHZcMw3kNeV1sWtMX+0+wCr5DkV2EP3AvycpfaAJHVp31z7TnWBOjUU/NAnn3kpEokInlptNxYT+qo4UZ+nbxi+vpH34keirb9NYaTHCYZTg4qbjOtAmUFjKaO6uoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHjzlqUI; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHjzlqUI"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-358f5aeb46eso395298a91.1
        for <v9fs@lists.linux.dev>; Tue, 24 Feb 2026 17:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771981750; x=1772586550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=DHjzlqUIHi98cYgYCEr0SckUJrBv5QopTCNcUzMUD3EnHANE6r/H/a4Jz8UbzpghVK
         LwTpjlf7i94XXEC8KIxv0qHkkQdz7ZwTRDqGcv56vBBYIx7VsJ/XSG++EGtfomxGryqb
         rg40TyIAxO8rU+a45FPEuXkBazZZr1dWpCN1VATcxLNodIq8qg8wwbLEXbaw95eGPJt3
         c2JcyW6usokDizEeNSYkYst+H4h+sHIzUxTV6RB6YvCxq4+eX3ylCIKaZF8wqW+M/keG
         /N8BH7/NRrT6LnqBufZ+DDHDrhZr3uBWYN3thCVFRq4/j7CJXo5u94INN/mIXZigubxU
         ZHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771981750; x=1772586550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=CXcolIyKB6PncbFhbeXpyh4H7l3cRDwmA7SyUz7tA3Og4L1U8+H4+LS8TF9fr/UcIx
         GP75faq5b17YT29CW2O8uIU5C94axSG8FxL9mY0W9jHwTPAQNkUqHefHBrdc1cBXEE+5
         xMYs1KuTTDv1VQ/y6WXyfyztVGBkyK4SktskTDba8pzS91XhwlQcxFH7w6uY+vxTqLoe
         D0AVpYZDjzuR+NIyi+Shwl7P5Wu8spVO5JTSdnX+fkMimMDkc4D0lfYNWev3Ik+7R9Tw
         QV6bq5e207xYQu3LBVAX70w+yLpK3isKFPDjiInoNl9jzQUzpfd1t+8k7rIrFhqLV8UE
         BM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcBYAf8uw/B3srhf7F/TbJZ+GGlTg2LZ81TvaEbZf9KdRj3S3U8fSzBGo+oE2DoYHz4XO3@lists.linux.dev
X-Gm-Message-State: AOJu0YwEqpEKRCgB7qAn7qnR4bhadh5WV68797xTWdG53KmMH8IwdIDN
	uf5fPhFdmCFcwoYELYFa6wGtG/twfJs/vDUuZitBeedHsLllhyaS4PzZ
X-Gm-Gg: ATEYQzyr7+Lvq2+l2vA6yBzu3o1e/V5Zm8WxIfelCysOLhXPwuIsfJyADuVLjw8jnnb
	wbJ50DxXr9S5UdWIvil/0DwTz6H+ykbHfvWWbrwt7Tp5c6V3h+crdebxYzrT6B7NUK6G26zUIgN
	Blu4Z0n50WeN1Tgl6tkx2iteVR+Fce1hPkbMCuIPYALeJISS6wk8FuOVFxCbM47IpMEjzAP0p3I
	pVWKnOPMGqkXWrM562p4NntQllOQEtulMKn6bYBSuWDZdsQyWIMdbTvb5EBRv2F28jzP21AIozF
	jZbvIfrVQdM+RcV/KG0UjW29kAC2GImY60p2b/FlYiop0qMLn1VXb4jJlyfclvbCGUBPWLIzMj5
	3yFlofKREGBlh6YwSddKis9Mg8WiSRqRwayR8CRw9DNH2hE/Oqa5VXB+9khM0vs6vBvDnOUloSp
	Y9PzVPdj9Sp06dKKNQN9DvTN4KUexI+ZDYwpvkj8xI9FkMTt7ADYbI5j+wGF5N0jfuppigx9P43
	Wo/M3T8
X-Received: by 2002:a17:90b:5847:b0:358:ee2d:df2d with SMTP id 98e67ed59e1d1-3590f069d87mr523046a91.8.1771981749874;
        Tue, 24 Feb 2026 17:09:09 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359034bbfd4sm913979a91.10.2026.02.24.17.09.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 17:09:09 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH] 9p/trans_xen: make cleanup idempotent after dataring alloc errors
Date: Wed, 25 Feb 2026 09:08:53 +0800
Message-ID: <20260225010853.15916-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3411; i=ericterminal@gmail.com; h=from:subject; bh=Gu0MyqKlwATaZLTHkAVxYELyEu7nRq9nuCfzTHc2Ad8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTO8/ymNvFnBEdYb9COjg8Tnm/nDXv7WiK3993d/QqzR JOnnbOz6yhlYRDjYpAVU2S5+3/f3FyvW3Oucx/OhZnDygQyhIGLUwAm8raZ4Z+WWAhP1R273cFR uhP8En8G3s8z53vxSH++4artOQqy/kWMDD2753rVvbh2x9z8VZOtzzVtIa52jYM1gm3592b5Xt8 vyAQA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

xen_9pfs_front_alloc_dataring() tears down resources on failure but
leaves ring fields stale. If xen_9pfs_front_init() later jumps to the
common error path, xen_9pfs_front_free() may touch the same resources
again, causing duplicate/invalid gnttab_end_foreign_access() calls and
potentially dereferencing a freed intf pointer.

Initialize dataring sentinels before allocation, gate teardown on those
sentinels, and clear ref/intf/data/irq immediately after each release.

This keeps cleanup idempotent for partially initialized rings and
prevents repeated teardown during init failure handling.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/9p/trans_xen.c | 51 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 47af5a10e..85b9ebfaa 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -283,25 +283,33 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 
 			cancel_work_sync(&ring->work);
 
-			if (!priv->rings[i].intf)
+			if (!ring->intf)
 				break;
-			if (priv->rings[i].irq > 0)
-				unbind_from_irqhandler(priv->rings[i].irq, ring);
-			if (priv->rings[i].data.in) {
-				for (j = 0;
-				     j < (1 << priv->rings[i].intf->ring_order);
+			if (ring->irq >= 0) {
+				unbind_from_irqhandler(ring->irq, ring);
+				ring->irq = -1;
+			}
+			if (ring->data.in) {
+				for (j = 0; j < (1 << ring->intf->ring_order);
 				     j++) {
 					grant_ref_t ref;
 
-					ref = priv->rings[i].intf->ref[j];
+					ref = ring->intf->ref[j];
 					gnttab_end_foreign_access(ref, NULL);
+					ring->intf->ref[j] = INVALID_GRANT_REF;
 				}
-				free_pages_exact(priv->rings[i].data.in,
-				   1UL << (priv->rings[i].intf->ring_order +
-					   XEN_PAGE_SHIFT));
+				free_pages_exact(ring->data.in,
+						 1UL << (ring->intf->ring_order +
+							 XEN_PAGE_SHIFT));
+				ring->data.in = NULL;
+				ring->data.out = NULL;
+			}
+			if (ring->ref != INVALID_GRANT_REF) {
+				gnttab_end_foreign_access(ring->ref, NULL);
+				ring->ref = INVALID_GRANT_REF;
 			}
-			gnttab_end_foreign_access(priv->rings[i].ref, NULL);
-			free_page((unsigned long)priv->rings[i].intf);
+			free_page((unsigned long)ring->intf);
+			ring->intf = NULL;
 		}
 		kfree(priv->rings);
 	}
@@ -334,6 +342,12 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 	int ret = -ENOMEM;
 	void *bytes = NULL;
 
+	ring->intf = NULL;
+	ring->data.in = NULL;
+	ring->data.out = NULL;
+	ring->ref = INVALID_GRANT_REF;
+	ring->irq = -1;
+
 	init_waitqueue_head(&ring->wq);
 	spin_lock_init(&ring->lock);
 	INIT_WORK(&ring->work, p9_xen_response);
@@ -379,9 +393,18 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 		for (i--; i >= 0; i--)
 			gnttab_end_foreign_access(ring->intf->ref[i], NULL);
 		free_pages_exact(bytes, 1UL << (order + XEN_PAGE_SHIFT));
+		ring->data.in = NULL;
+		ring->data.out = NULL;
+	}
+	if (ring->ref != INVALID_GRANT_REF) {
+		gnttab_end_foreign_access(ring->ref, NULL);
+		ring->ref = INVALID_GRANT_REF;
+	}
+	if (ring->intf) {
+		free_page((unsigned long)ring->intf);
+		ring->intf = NULL;
 	}
-	gnttab_end_foreign_access(ring->ref, NULL);
-	free_page((unsigned long)ring->intf);
+	ring->irq = -1;
 	return ret;
 }
 
-- 
2.47.3

