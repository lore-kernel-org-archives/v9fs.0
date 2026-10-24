Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833746;
	b=kxaimSL9+WuTooCPgvktywdXMeYe1BWa7mv3nP3arrh7Fff80L5iduNA3D5QGpr4aNM8
	 6tmVZYIWpNbUzdCpdq3MbiDVvFGVKBqoLBiBFQO3Vzl3HlwstkXfgW4TTUim9BZ8XURtS
	 iFRFs7B+uxqMwt7lmFf8ii24QJCXD2PSW6hfE1Ef647Lgz7sJ2milZkG0L0v3rxUE7rvI
	 QABczr00GYcVg583jZlbnMiGcS4Zl/nL0dyRC3Ey+S7aiM3zxp30AGi7wUwHqZA4kz9TS
	 T84djvOcFdP+lmXF3zAjs1W5+D6FGVtKbTCHJFpQvLkeTbGTvhL0fwQ2CJZDuiUbDHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=btz/2vSJcEYUBSOnVcWOhmgZ9TgiUEWaYHmTTBOv25c=;
	b=PbKRCZfjjpb9yVkXWK2Em2KIx2gPm3xNvEmEA7+Erm3Zi6ReCSQtNOWWKJAemenhIC+2
	 EYtm8QmF3gxIitiydExjqUadvibNkp62Xu/797H+Zl6OyzgrsXJuKB2Cp8ULFxKvrC/pn
	 MAD2rvjuslPzRX1XAcga9h72wg0N1DhU74crWCB4FTx/3jUlXN5BNHA/QI2gugvq6bLWx
	 SdmNdVfgNRx1p16aFK/QjLvvk4e6SLcItH/FUffAmToTlZWVeIdFHGhQQ7HhSw6J5DO4r
	 Hd+xGBIoLxwqi3teSFP+XQoQPhJ4MtbtZQY1PNzYmFAA7WGHy7eSBeE1rGbyOGRosKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMG85nCN;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD0606A31F
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94BD0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMG85nCN
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35d0be18c71so2926543eec.1
        for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833746; x=1793438546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btz/2vSJcEYUBSOnVcWOhmgZ9TgiUEWaYHmTTBOv25c=;
        b=YMG85nCNM3qC7BpiqJTdtVQ5cYGezrpDaJo+MWZVEqgwQJYve+MYLyIJzVupWNxAYH
         mpV7bBGr9jMorgtItLssVAzjlpPApexyoxVikhk9CwmnnNiJRUDPqyQYgsZXjtaYC1bg
         er2I9UMbG7JwqNNN6SgoSBQL6nVWkYLTaEYU/YTpRp8N2cdgucTFKjDt10wEfp5rzViP
         Hb5QKRa5pS1ak70dQ2WbN2JV996CT8gDDv1cFbF5uBnZkJMBYdxBhNSlw64rMIqhMZIA
         1AMjN7Ffki1W3KXl3jLMC6mx57ksc+HmFjutA+3WpaT0rNoeCsuwZVFJstTYBXtFJvu2
         FpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833746; x=1793438546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btz/2vSJcEYUBSOnVcWOhmgZ9TgiUEWaYHmTTBOv25c=;
        b=qfSU2MR7BQQLPdJP/EgO24JKaIwNZWfrUUy86PFDOR+/45FSSpopEQZ7FhnZ97SkKU
         G50AdMYOdBl4g/RJPjY7XbrgE5nwfoQPdS0VMUycCH8zyMe76aP0PSZoP2GoxZ1ZV8sf
         CuUWmXq5ZLoe0xdKZ/Mxp2sPnf/YHJrfhPx7DDcDS/Ta/vIYL8bGPUydTCfaQltGBhGG
         Qjp6eYp7q1jJdS3UmO0DWc4Zz4Mbd/RFc4LVGd517laSZU8kGjB2cmf+DnypiMT7w1QR
         mv7v2qPNweSMSmCnLIZ6gpExwDljv5SjNA03mr1GMhi02poKiMJScsygDhRt0pyrDB6s
         q4tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnu/p7n/ytsS6nGa/B8qOz4XDaydgxT+DaWYW3Pi+a1LkGGraOWdgs7n9NqA5FYJYhwPLW@lists.linux.dev
X-Gm-Message-State: AFq9FYJQa0hgfljc4wD1P9MnCGYa1IVkcCow2qePujvNwPY3x6p0b2Mv
	BVqJ5NdXJLERrr9xrk5pk6o730A7Ti8s+aPlWlB2JLb3hPHMVEst5dSh
X-Gm-Gg: AYBFou19MO5fIBj0TXLIDFL5Op5Rsyi+5na0ZW90bHdZrReCgKOIW9W73an2IK9KmSs
	Pz9yTDJwFKU8qOCvQr0sJNCDnJFb65vEl6ihpwZkozFFgmDleZhffOtSZNhWcOJc2rgpavbwxOZ
	BMMZ6RCIFvmrBsHHzaUvoUKDIitqeKHx64OXwnmH5XVZ7tzPamzxfsbdSmBKC9QF3pS7t06oqif
	PsYZeG9V6NlfUgFDgmN+QtLV8yhfHjbi1oAzFQNTQ71JjV8y4mWJfZId+b3DvSlLjYiDtWwkDEy
	tqaFY4ml1mMA5ctMygeRkJel6YRWRNVB9uJBCAlCbLOPVNmyX9ngOcn/8kknf8U2wvDKn52kEPA
	W2NEkDpjSHvRg5F+wBcV1itZXn6wbCjc8vUpiOoLustCqdjh/uh4fzsgdB55yl6AtPgQpYV78G+
	K0+s3B/Bh9tK92aDHU5KUgapZ/OeyX0I9NAzvh/GeESZtJnl9A3lB5P/KaroaEqMbVjdF+8citx
	NC2zK+Yt5yMEFzkt4I1AteH6czfIXeQIaW/j2BkDvpdLCJjOg7W8mvJGfBRd/Yjm3XhkxCkywoe
	CpYlBXHQDqMg8lmLs77AsMNkUqcIuUTeHBwf3MOtb7IYLNIIXntEQPKWfMzrvLbPM0oVAx5yEH7
	Uhxo4meE5jL5vsxMM/4UUwBRFRw==
X-Received: by 2002:a05:7300:7aa0:b0:343:5f5f:eef0 with SMTP id 5a478bee46e88-369e84f9962mr2354642eec.21.1792833745636;
        Sat, 24 Oct 2026 02:22:25 -0700 (PDT)
Received: from LAPTOP-VN8JNK11 ([111.223.26.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db450bsm5108584eec.17.2026.10.24.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:22:25 -0700 (PDT)
From: Ankit Thakur <codeankit.thakur@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ankit Thakur <codeankit.thakur@gmail.com>
Subject: [PATCH 4/4] 9p: fix typo in file header comments
Date: Sat, 24 Oct 2026 14:51:54 +0530
Message-ID: <20261024092154.1844-4-codeankit.thakur@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261024092154.1844-1-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the spelling mistake contians -> contains in the header comments
of vfs_addr.c, vfs_dentry.c and vfs_file.c.

Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>
---
 fs/9p/vfs_addr.c   | 2 +-
 fs/9p/vfs_dentry.c | 2 +-
 fs/9p/vfs_file.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 170a2b91c..3723c827c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * This file contians vfs address (mmap) ops for 9P2000.
+ * This file contains vfs address (mmap) ops for 9P2000.
  *
  *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index fa6b7143d..5b05fa7bb 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * This file contians vfs dentry ops for the 9P2000 protocol.
+ * This file contains vfs dentry ops for the 9P2000 protocol.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index cddfb4b7c..a983ef866 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * This file contians vfs file ops for 9P2000.
+ * This file contains vfs file ops for 9P2000.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
-- 
2.55.0.windows.3

