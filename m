Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF426233D6B
	for <v9fs@lists.linux.dev>; Sat,  9 Nov 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731187227; cv=none; b=eLa4rhwy2y1tQ7rLDmczn7rC4lQYCHpYJwOhinFFo/JGvSB5d9t53VwpSfHcc+Cuj3sIloEXtkaPnKESJMOTArrjA8mHwkY/gdJKuIx2aGQ8Lu1hbLb1AEXaZ8KKlKi5OkG1nBQXDZNAaP/MobqlGQ943V+UE1g7EwabiDcVdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731187227; c=relaxed/simple;
	bh=zX6YE+/DDtNfVrgMGSZcRMfqOuc0nTcDRyL0ymhSzz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDVQVehYq0LwhHihw3sFEdAGqybnkBPL/YX/IAscAwK7XRaRVTwxl4kvh5LX6Mm7PUQ9dzl4uwz7sDcJ8LolSqtgu2dxxea6Ohtop9Zjs30tsfNjjcxMm0+dovGZmI0TKBfP5l/lqlgQMxF/cGWW5gw0DnlMeIkJROIrpEs6fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enU47vxd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enU47vxd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a4031f69fso541344766b.0
        for <v9fs@lists.linux.dev>; Sat, 09 Nov 2024 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731187224; x=1731792024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFZmkyoCv2kVb7ODlAwqK+9+SWXoO1Y9sGe1uejDVg4=;
        b=enU47vxd/avhqjHDK6cpOLaQ3VIp8albGTm8KK0Zxh9F6/twK041d57RH5MoM3ifJv
         SS/filgh7h+HYFwYU1+TsUJo9I/2MjaJgdn24wqsje7lkJDEiHEwKwiAEseUgHP8svrA
         BMxq1MgWmv2R9K9wgZETC3b+ZR6gdCZXp6ok2t0iHVEGVT3UAZi1u4bSKiZklH1jMdCz
         T40D4KQlqW742d1Xuwm2sUIRYiSf5yqfC1PXdAAidMI3pUZI93QcvR3A+nQBK+jywnmS
         9+xq46vlAUFY+ILwERs+Xnbsi97lgT6RYStZnaheSg3dWgUOJHhAHQP28ehiPGKdbd0j
         dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731187224; x=1731792024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFZmkyoCv2kVb7ODlAwqK+9+SWXoO1Y9sGe1uejDVg4=;
        b=ivmvZl8/NJwCeCt9ZiAr8DtV8FbYefXO0jLUNiyXcMe7bSJdXJUD0PtkOnYqumejq8
         Pt8PQ6juzHELEdGiyIdI3tR6oYzde4XlaeXcTKTfWZkJtM73kJjMn3t6kUa43gHaWqmv
         ZiiWLYp/ONkPOttcSOznD0V0p/hRIealmxzwmmDodNS4jVTc3AJ1VMhvY5NgtLfTQnBO
         7DDlQ13Px8cd0syJz+pXoo1wkteXTbLNpFaea00tD7udoa0Azwt0528ExNF75P9DZUZO
         JHI7fiO0CmrJztVSCupvu59jC9ctfO6Tnq1waiJJTzpMlDCf1K1e6PksbLXLaFUnBK58
         46MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd6MUN4dq/5JWvkJvB3vMSGIkxUjkRWbvzpiCHoLda7uU3h0zp7a7GgJWCBAG9HakbSR+j@lists.linux.dev
X-Gm-Message-State: AOJu0YxgmPCv+t9NBL8GOV1xlZLLFP2BB6rKREt5tOmeaNFncoG3F/sy
	pwdNbj+uP/+opgWU0Fbi3Tlj0T8PFzwnrAYS2lQQgjkH1YpnyPV9
X-Google-Smtp-Source: AGHT+IEX0KiXpqhnHtQQDp+D5+tK7VGAsz5Td/YIo4FS77MqvFvBxzCgmHMQtCMZOw+Ifb5t3zzFAA==
X-Received: by 2002:a17:907:608a:b0:a99:fb10:1269 with SMTP id a640c23a62f3a-a9eeff0eac2mr684321066b.17.1731187223612;
        Sat, 09 Nov 2024 13:20:23 -0800 (PST)
Received: from localhost (dh207-40-48.xnet.hr. [88.207.40.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17624sm406441566b.24.2024.11.09.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 13:20:23 -0800 (PST)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH v1 1/1] net/9p/usbg: fix handling of the failed kzalloc() memory allocation
Date: Sat,  9 Nov 2024 22:18:41 +0100
Message-ID: <20241109211840.721226-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the linux-next, next-20241108 vanilla kernel, the coccinelle tool gave the
following error report:

./net/9p/trans_usbg.c:912:5-11: ERROR: allocation function on line 911 returns
NULL not ERR_PTR on failure

kzalloc() failure is fixed to handle the NULL return case on the memory exhaustion.

Fixes: a3be076dc174d ("net/9p/usbg: Add new usb gadget function transport")
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
    initial version.

 net/9p/trans_usbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 975b76839dca..6b694f117aef 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -909,9 +909,9 @@ static struct usb_function_instance *usb9pfs_alloc_instance(void)
 	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (IS_ERR(dev)) {
+	if (!dev) {
 		kfree(usb9pfs_opts);
-		return ERR_CAST(dev);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	usb9pfs_opts->dev = dev;
-- 
2.43.0

