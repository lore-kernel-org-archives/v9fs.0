Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888A2DBF73
	for <v9fs@lists.linux.dev>; Mon, 16 Jun 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080352; cv=none; b=EXTeXaxG4d7Mp0wYBiCIxhzgpaKr3udfsb1aEhr9aVBvk6vjYtfSCyD6r/JNA+6z9E7BNrxsazAf2A/ov5V2buFH56LadSKbEe5tcAlr9YcxGSWUIqP0ORJfepXXMY2hKqnewynBjUqeGCceGym6UVAVdAJJTLeJxCwyc5uQNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080352; c=relaxed/simple;
	bh=td7khtP98l7Q2qh50OlQWBKZ7UZjfxc2FqvRip6lP7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DATvBFFDmDkcBVJn39f2QdhzNmnrMgjyls85SgWvsWxMYg023h+JBJXcJ2kvXoU3rdIEqEkFfEKBVa8BBpZ3aREHfKRcjD9SOA9+G0p/dFWc0ByZrmS57DIDdl86hYAy0tbZboECrsigELmZMjG/K3rp79DuNfZj0l0PUygDzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAvYQBNk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAvYQBNk"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748a42f718aso1390414b3a.2
        for <v9fs@lists.linux.dev>; Mon, 16 Jun 2025 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080350; x=1750685150; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=AAvYQBNkET8Mkzcl5WifQ3Ny3L+1MIkzxMsqfiorqtO16jeelWqphG6ihOISxdZfDe
         miHqNMKNFxToebthZb2CSpBnV/Q88ygU1c/FYxw/ki09szR1rnqSv8RNo6TST7YbcpOD
         6HH4hsa7k5t29MkFkDjjnDl14M9P4TPNlr3iUooIh2GM62qFK2m3br81+E3FNFW1z9K5
         NmgdNnZNeImrGcqKL3UmblJIzf+rr9zSCXFy7HhtDMzkqSiGcfMC1srUe+2+LL/SrotE
         E6WVg0E8A9vlRhVb3h6QWunxNtbS1dD7ZkQJRU3X3VCym3D3y4XTysokxd+1mjHETrs0
         hiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080350; x=1750685150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=hfgZeIuMuN+eT2C8iBIOTD0KEj0yax89GH4Q+fqmxVni9C5k21KXT0zFwSVOWZ4T48
         xis439Z+zf4QUeC+BEuYYGF1tRrY9u/CqR7N2+8x1UXuNFpxibj8YfzAREdc8Ltnrn20
         tfnw3NLhbG7jH3kbu+JzIBfmqUX2caVgWMnASrMCs4l428OuKwjxO7zmU55dvUBt5ROj
         TT5oobBnPHygIRTw0hY4hcDPylRyTT7HfGmjUAFAdje5SOhLbQziB2FgQuezPEl2RMIA
         Ra0NUmB4in2+X4556B3UanVuj55qj7dGuF6L595vxESjo9K27Kob9Q86EFdD5IGTzzzc
         CnOw==
X-Forwarded-Encrypted: i=1; AJvYcCXps2uOLG3qUAZjoi5jeuMpV9y+XoO9zuoaJ/HBLGS7w+W4qHaxuOqOBf9w60cU49bGDo8e@lists.linux.dev
X-Gm-Message-State: AOJu0YxwTV1vkOESBTUhiu4wiWP8NtlyaX1o5JvjX8w9I7M55P2FMuSy
	M4zkaYtc1z+IaltR2ME5bkyhQAkVFn4VddAbgeYE09f8K3IDxM5wvsY4
X-Gm-Gg: ASbGncv6r2sN4EemGRpZhM+/xosOS9Hm9t41umYIw+fhUcoaJov2LcoUAEYJtSlbLmd
	9kQDRsGkIOZYR6mn9rg6RJz6Cu10BMiCZAHcunZvF0Pvi04QVM9uVp4jPhG/s8aJT3iWiJDODqJ
	KmkYqD0WAikGxtpVtWL7WimXc7cq4hx+QlF1bh3ZbC3hDm89H3O4PRup5v4OEg0UI6ZheGsmBIt
	/y/hkOIAigfp5M9JKJ5WDM5o2UpAU9weJI1KPYjtq7GT2aIIzAtd3ykpCh0UfvE0EOCfRoQlKpV
	m6vc6jeex92js91tf9vpEbdAgzj162wfuFFjhxRBMMvGgLK7pPsYmz877fhmpfHwuBHDfQ==
X-Google-Smtp-Source: AGHT+IGGC0yG9eWTrvC96f40RZCC+M7NlH4ZHN5h3TAKdLDn6BgEURju/EiL6fGQTx8qNnzcyUZCzQ==
X-Received: by 2002:a05:6a00:846:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-7489cf5a90fmr12310846b3a.5.1750080350538;
        Mon, 16 Jun 2025 06:25:50 -0700 (PDT)
Received: from localhost ([42.120.103.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9c6sm6750467b3a.9.2025.06.16.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:25:50 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Date: Mon, 16 Jun 2025 21:25:39 +0800
Message-ID: <20250616132539.63434-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buffer overflow vulnerability exists in the USB 9pfs transport layer
where inconsistent size validation between packet header parsing and
actual data copying allows a malicious USB host to overflow heap buffers.

The issue occurs because:
- usb9pfs_rx_header() validates only the declared size in packet header
- usb9pfs_rx_complete() uses req->actual (actual received bytes) for memcpy

This allows an attacker to craft packets with small declared size (bypassing
validation) but large actual payload (triggering overflow in memcpy).

Add validation in usb9pfs_rx_complete() to ensure req->actual does not
exceed the buffer capacity before copying data.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 net/9p/trans_usbg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef..047a2862fc84 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!p9_rx_req)
 		return;
 
+	/* Validate actual received size against buffer capacity */
+	if (req->actual > p9_rx_req->rc.capacity) {
+		dev_err(&cdev->gadget->dev,
+			"received data size %u exceeds buffer capacity %zu\n",
+			req->actual, p9_rx_req->rc.capacity);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+		return;
+	}
+
 	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
 
 	p9_rx_req->rc.size = req->actual;
-- 
2.43.0

