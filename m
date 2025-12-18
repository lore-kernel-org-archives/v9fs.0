Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B01BC41
	for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041832; cv=none; b=YjReLMOxtYp4VKCrOxw5EyqNj09+EMF7j+b2w7rUAmY0VcHBsoZi/qSYR0ODFKub3kNwjylvemVKVPcC5AkiV+ykSApDDqEHgogQk8kNht6ZSM/vu35P9pM6junkI6/lTfuiAJvmmN+LMlXe1ciErgnfjyDuMOWRaxFYaSKsxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041832; c=relaxed/simple;
	bh=joPt+IYkaekfl4lW+66p2Gw93AStAybZNzNAH0JBqNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBWARuLGDlLEHRiiwtVLb55Byutk82rOiYUPP5imoekYe53NOtxDeyHytpeqeg8C7niam3kTD9Z3EYAlUMNbT7mE2VIjI1QmZx4qZGbuFywC/37vZ8iXVK+LUSqQWzHwvFL4xOKtFbBMnWoLeJE8LI28oKdii7ZuxnKPDugu4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG5lqo4N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG5lqo4N"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so292208b3a.1
        for <v9fs@lists.linux.dev>; Wed, 17 Dec 2025 23:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766041830; x=1766646630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjAFv0QKtkflVYFaWJ20PgTj2cwSrrus5uOPKMHPwKc=;
        b=NG5lqo4Nfjxe8OI7bDLCmpr/tK2LnKvkA0SnBoh+ti4GnKAsmI8I0J1vFwGBvh6Blx
         heARkJ9HoN2eP8t63iet78xWGMEolBkcA3oVGcTw7IA9uK+D8gXyN7bLOy+1+UnWyhVp
         wB8tqcLU2zApjFjwtikhg6m1s9fXRFuZJ7Q53LwEAbYk8OypKd+pa3RIeiT/J+kBnWZI
         +aHA3iwPw6cS4bvnFhFiw26VhG+mvLwckPhcOjW5E+fl+6KEGPisaMhczGUl/LkKHwtI
         Bzzbmn63FO3D87LHTfGZQmgF8F9m+X/Y/+skMhgRMcZ3UhBzzbUOL097MArq4ENFu6f3
         3X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041830; x=1766646630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjAFv0QKtkflVYFaWJ20PgTj2cwSrrus5uOPKMHPwKc=;
        b=Z7l6S3xY7PE/NgY4Gvn1g1Kf8VJ4omMdiQsVPjh+LkqFY/9Frzv+Fbp8VKZo/HagEP
         XAQsPGdjVACM6A2xIA7j5c/a2NekgG+KOgqXJS1c/hV+87J2okYQLq/hHqaF5jwUS/y/
         Mpk84QUB+yPLf4STMeHvl1gKnFjlV/E+i9FaAYUp/oSnJW0IqwUhk1aG+Gm3RA7MJVQB
         b4/GvVZj76UBRKGS7whgs3kOohYN9GmC99DaWVHP6SoAbc/1tLZ74ANkiRA/8pkdOQCA
         kucGXjrnA9h0gzzpM7CcWss1lTrCF7tAdFN9AfcTsZl7Mwu/KS4FhK9XUWJ0a8a+ZIWB
         y7ng==
X-Gm-Message-State: AOJu0YxfmjS/eY2eOI+Oo3m1EgSSaqoaVwI/h/qxrejnGS0NQAB4Q3/e
	OwG9DhXiqo1rePH9W8UzLnlx4XIwpDY/68xSKcNPNx28v8BQMNfc7nYD
X-Gm-Gg: AY/fxX5VKwikLwXpx/mEz1d9C/r4I5dfQT8eLriOt6dzgUIiFztdaHcHY3EgRq6hRdM
	5/swqyII/kQmBKCjEDn3UC2G+svEmDQRbgjvNR6wh+s1mWrLb8cnkukNqu0r3xG5mV9z/jLpC0j
	J6Q3AfCkmMbLWpsU8rCNQt93L64/TRk/3KsKK2F+EB+SnXWwMaZWv2qI+ryB/g1/T+z10JR256k
	qEFn0Im8rLuwCQceklnh0V8L+qyeTc38aJ96bNUp+FmjikvHPpUSUNS9fZrlVf/NG7y8VCAxzTO
	ADOuVeRsaKlK/eRxV3PJn7Q1qjdEP1LTCB1O13tnLUVFtdp5D0aZo2oGf9UTUheqMp6IDwmcIvs
	Yv2iSXAl24nlGflb9X0D+WVaxS1hS4a5N4Ng8ggjUiB7PPrbhHl+uWT7mkojJdzx9DxJuIUQUzz
	DULMtCw3CNuedAzW557jLdasrIC3C8cNuc4oYIU4yXFo5VccLGRT65HidBAeM3I43J3wbSLsVF2
	FbIHj23hlM=
X-Google-Smtp-Source: AGHT+IFA3UHX0tZ8UWfWWP13jkKC0r7UAQ4hTsrexcVQhqx1ouVA8jdY1hI0u52ipk7ifMEJnuzntg==
X-Received: by 2002:a05:6a20:548d:b0:34e:cc0a:40b2 with SMTP id adf61e73a8af0-369adfb4e79mr20088915637.30.1766041830073;
        Wed, 17 Dec 2025 23:10:30 -0800 (PST)
Received: from oslab.mshome.net (n058152022071.netvigator.com. [58.152.22.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2dc9e0d7sm1351218a12.9.2025.12.17.23.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:10:29 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] net: 9p: Fix a possible null-pointer dereference in p9_cm_event_handler()
Date: Thu, 18 Dec 2025 15:10:12 +0800
Message-ID: <20251218071012.7740-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In p9_cm_event_handler(), rdma is checked in the RDMA_CM_EVENT_DISCONNECTED
case, indicating that it may be NULL. If this happens, a null-pointer
dereference can occur when complete() is called:

  complete(&rdma->cm_done);

To prevent such a potential null-pointer dereference, add a defensive check
before invoking complete().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 net/9p/trans_rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 4d406479f83b..b5ceae1cccbb 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -170,7 +170,8 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	default:
 		BUG();
 	}
-	complete(&rdma->cm_done);
+	if (rdma)
+		complete(&rdma->cm_done);
 	return 0;
 }
 
-- 
2.43.0

