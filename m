Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4363806B3
	for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366235; cv=none; b=eKSlNDWoLBs9QZh9CDo7f+NxZ8dVx7RhKAQawaYxmyHlrHtCxOJYHJ2ah27/UFJQOrAB2qbDG4cd6tSyNePgWhLSPN/roY5k1EI0RN5WTzzxCEbKsUiyEgJ3OH8Z0utFCKWyt0u9iq/7EdNCIIVTbXHBpMf5BCPLpwtj39gfzDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366235; c=relaxed/simple;
	bh=eBU630oFfSvL+Z7ajS9wK93mpaQK8s/AQJ3EawS9+Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDtDRFcAC8x+oSC50KsLxnjWnJyYlLHUZ+k1h3Tn7Ud4gQDaZIltSoX9GPsmEAqXa5f4SD4swd5w+PkGQVmu89LTN/yPRhEJkKMLXT6iERfyX9qYUFJGuSx7i0qm2uJl0WQPOp3J67MAOhtCpULQ5FkQsf6weVGwufdSlPG4UHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrale4IP; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrale4IP"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2c0f754e756so1705118eec.1
        for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366233; x=1774971033; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCn/MqHA11tVXJNjwUhww9VSY0nIMQtmkoUGALB7eDo=;
        b=Lrale4IPofvovNH5JKd8G7XD4LQ2Rm/+izvoXNBX+J5LZxSFb4hVg3hyAXQu9n0lOF
         uibYZW/y9S0YGWX1O4XqKivpFPQB80TbL41zUP4PfSEtQihf2U0jqUPTKctnmtEbfmmJ
         0P8jMBT4rIviz1Xcrj2sB8PdY4ztSDGThiioZNAbIaE2YLuHiQDIPYDkNM47+JtdgIUJ
         thPPgQukX4Kk3iWHxbzjOgEiPXVlbAQvGnsx1Hw6oYJwrXQLhOw75ZCoqwK97EI1Qgf0
         6IWpWC16f78Oh2//4Utak0fQ+580FwtgXo5YWT6E+jOFHmyQrBzgexv6EfgmnNE6Thqr
         YmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366233; x=1774971033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCn/MqHA11tVXJNjwUhww9VSY0nIMQtmkoUGALB7eDo=;
        b=NsMpq1cg7TLPzuXR6ofmR7oH8AvbVmxadIRpTri7SPUVsiG51cuhTjm8UxxnbdvbsL
         WNsBf2MyJjP4LULJSH6gMG7Bn6YNPBAMVFnAgocOskNnzszBq2BNIHoFJ6rBbtFcMqHW
         rbkeWLUP5lOCmvqTv4oO3zla0U0wiFxw1BM2TPPRC/Hg2Uku77JjzFFzS4d4E6mX9+1u
         +o+P2IerLyQHzv5Ag9kvKjVCRliI99Eo2kbRZyFFdcoGwQEJigaN3kN9G3irqLywfvod
         Mogn+7zKyr6/KXp0ii+Hbidvhf9ZsANgpq0B2PPEh1XGnBCJMJzaAczXxK+cT2VzeNxU
         tVew==
X-Forwarded-Encrypted: i=1; AJvYcCVV2Bh5u9Qr+a+dXThnYBQm1Xh33UOCHBdooahN17SnjPhuB4mQjiiZoz1KKGQ6TFvVrbJX@lists.linux.dev
X-Gm-Message-State: AOJu0YxoIQ7He12bRUrkgsPwRhGTFv6NYNiPatzyprhkm4qMRcoAvFnl
	845hpPlPw2nH6wOkIoiZU2KV4mR4VyQUjhJvObG/cBXdAT7h6dIcWZG9
X-Gm-Gg: ATEYQzz1Jjw2i6Kq7bUcKM2ixfqcNROQquKOJhrT5X4pVVlGHwCSrF4vzwk+29120dw
	1g8swf3PPXJ6yDMKNZWd0Dhx5JGSnHxMeQGhIAAo8VhU9KL1QFS+Lzaj2ltqYet2bCYygQmhRPR
	+sAXvcTQE7OIbxN63xHnFu67efZVzfJVwW4MqncEErKIlZFIXZDpeWHfPgX1mzx0MINnHVgZoPv
	qCrH5OZRAKkCro5Yw+vhOB/H7W7BL1Zrv/XGYPeaWd2KGz9+VOQKYQDwz31r296VQUSUymUE7Me
	OKSjAS7G9DYI4iI6gjb69r+dAQFhntbTgvy8zBgr4OP+nFYW/QaZKTn8bF+CGkaAEXxjioMBI18
	0F97e+/QR5QunAClsneo+To4NxT3aB6hVnfA3ns8596TlraU5W5e41gyGqQ6lyKTAsYmFSua3XB
	pryKSi9AiPnWuao1+/Q/KrWOTLHLfd4r62RE1FRxRYH/J6lUjWHBhuWrnnUCO1yr1UsFt1DP3ka
	UQnpMLW
X-Received: by 2002:a05:7300:bc8e:b0:2c0:ae1b:4573 with SMTP id 5a478bee46e88-2c1095a5baamr8160636eec.7.1774366232827;
        Tue, 24 Mar 2026 08:30:32 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10aefd778sm20842577eec.0.2026.03.24.08.30.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:32 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: asmadeus@codewreck.org,
	ericvh@kernel.org,
	lucho@ionkov.net
Cc: stefano.stabellini@amd.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 1/2] 9p/trans_xen: make cleanup idempotent after dataring alloc errors
Date: Tue, 24 Mar 2026 23:30:22 +0800
Message-ID: <20260324153023.86853-2-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153023.86853-1-ericterminal@gmail.com>
References: <20260324153023.86853-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=ericterminal@gmail.com; h=from:subject; bh=vDNsz/omUMmP3CEetrmU1J5yJISS/nuy98ia+ZC4Yh4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqup5XD67uNZ+3kEygTn/5jXPf/RBxHWc/9zl+u4y c5r2bfBrWMiC4MYF4OlmCLL3f/75uZ63ZpznftwLswcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o Z2ikY6BjzMDFKQBTXbyckeH+2XsLvjlGSr7pWGT1ZA33V+FQlkfz6s/cnMH7ucki1bGB4Z9awql U3Rg7wQ0b8v+qTf3gee+q8I9+M/beugd/Z/zMV+YGAA==
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
v3:
- Split from mixed series into a dedicated 9p/trans_xen series.
- No functional changes since v2.

 net/9p/trans_xen.c | 51 +++++++++++++++++++++++++++++++++-------------
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

