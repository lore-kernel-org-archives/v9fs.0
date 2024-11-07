Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E611DFE2C
	for <v9fs@lists.linux.dev>; Thu,  7 Nov 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973480; cv=none; b=l2qVrj2i8PSDjuih+8r+d/DFG+52RjvrSaF4aap36soEPA5VxGa/XlbDnOkXVR2f7UtX9nm3eCrsZeRnf9vgwIc0u1gGD8RUK+7VoCtr+BLinjhsD+0Ml63LkQpYDINz4h5dZDhVLbQWtvyZkc6uskacB5kbmI82/C5kmnjAGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973480; c=relaxed/simple;
	bh=gHV9IguVe4/fNXzmzpXujryVT7rjBVHv1XiIwGs67K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UJHydKaCop7vkYYUsnJhQ4yKtLx0UFs4R151DvABVOHaEBPS9v81XnGRmsohGqFLnOerK3V1Qk8gRDth4+5FfH3zA7RDfCx5LP4d3PO8jVq264IJ1T1D8i6zww6NpqW1Z3o9BtOSR8kDCzhFI6tIjtQFUt+iqQgPxKknYNBX+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV5x8pPe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV5x8pPe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso6428065e9.0
        for <v9fs@lists.linux.dev>; Thu, 07 Nov 2024 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730973477; x=1731578277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpKqltND5M1sTSxc7zhIf0AXALdPonkygyogIkTEVY4=;
        b=OV5x8pPe9VWh6jEMKGX4XqlNJAwp6fBX/o8bFyEgDg1azdkEQxd6GKrj6kWLutLMbS
         hG52NLpn4ONYA94zPS8NFpfdqIhDFOo+qA8MUP1WGJKJvRIzyv0jKNRUQWjxVop4dCls
         trA5M7j5j5E0JaEkw1Fg3CNPTH/9XCY7Cg3oBr52wiHeZUAzAP+DtBDmO5IgCX2OZaFF
         z5iYYlK6EVU9S2M4d4NhNnz954GuID3Wm5oVoyAYFqHTqhe9oI+3qwytq3n5DepkESr4
         rdLevgiPrjhe4zC3liWLwpx2RHqc7Y5Mtv7YrPDlQmCzjgs0YxEYMGSQLgnCcrklYvkm
         2e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973477; x=1731578277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpKqltND5M1sTSxc7zhIf0AXALdPonkygyogIkTEVY4=;
        b=LHaZkn4IHqCnIyd0amjICgnFFa2dlAIG8qcovv/ravlS9TicEKgfFUPsRNswoRsn6P
         Zes4JUlWifewDBn6hZZ550ivN0kyrH1/E9CCoW1YRyRPX6sd8reWWpUdzZTyjIVUClV9
         /OWDvq0o20QjZY8MTS0dJnZ03b8ZpqjcOmDF3AIsHcrVhzv7WlEKSjXXANzGysNKla9+
         x9IQkncrvcHXU01Qx+BuM8TSya4sbK+qmTDYudL/KfA+Gkfb1obzeudhtj6ALOMk8FtC
         kHin2Z7VTDPme7WR+AmX0R/9wT+BzE05if7igXw4LQ55VwC8US2EhqYiTEemEN57OAxz
         HCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/NzLstOS5qKSG1QrQ5I/Ztb7TSz1cmQF+OJuVZXIBksgG7xQUOqKR4BaKmHqkBL0/RULV@lists.linux.dev
X-Gm-Message-State: AOJu0YxBw8re9d1+vkN/jp03W/0GZVSof74s96ZJx007XkmJYGAaGBvK
	4+GyrFGPh/q2elyLeDbL5LHfIEl9wLSSFzgyMfXkHeEycUjdl8n+
X-Google-Smtp-Source: AGHT+IGzLToOEcix7DkuYcrqXxDDjq6bxBUxopWjxkVCGQdAefWYR0OGNd28kso8FNdruwrZQL4QuA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr374619435e9.17.1730973477180;
        Thu, 07 Nov 2024 01:57:57 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm1248509f8f.33.2024.11.07.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:57:56 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] fs/9p: replace functions v9fs_cache_{register|unregister} with direct calls
Date: Thu,  7 Nov 2024 09:57:56 +0000
Message-Id: <20241107095756.10261-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The helper functions v9fs_cache_register and v9fs_cache_unregister are
trivial helper functions that don't offer any extra functionality and
are unncessary. Replace them with direct calls to v9fs_init_inode_cache
and v9fs_destroy_inode_cache respectively to simplify the code.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V1: originally cleaned up v9fs_cache_register to just a direct call
    to v9fs_init_inode_cache.
V2: replace v9fs_cache_register and v9fs_cache_unregister with direct
    calls and change subject line

---
 fs/9p/v9fs.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 281a1ed03a04..77e9c4387c1d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -659,21 +659,6 @@ static void v9fs_destroy_inode_cache(void)
 	kmem_cache_destroy(v9fs_inode_cache);
 }
 
-static int v9fs_cache_register(void)
-{
-	int ret;
-
-	ret = v9fs_init_inode_cache();
-	if (ret < 0)
-		return ret;
-	return ret;
-}
-
-static void v9fs_cache_unregister(void)
-{
-	v9fs_destroy_inode_cache();
-}
-
 /**
  * init_v9fs - Initialize module
  *
@@ -686,7 +671,7 @@ static int __init init_v9fs(void)
 	pr_info("Installing v9fs 9p2000 file system support\n");
 	/* TODO: Setup list of registered trasnport modules */
 
-	err = v9fs_cache_register();
+	err = v9fs_init_inode_cache();
 	if (err < 0) {
 		pr_err("Failed to register v9fs for caching\n");
 		return err;
@@ -709,7 +694,7 @@ static int __init init_v9fs(void)
 	v9fs_sysfs_cleanup();
 
 out_cache:
-	v9fs_cache_unregister();
+	v9fs_destroy_inode_cache();
 
 	return err;
 }
@@ -722,7 +707,7 @@ static int __init init_v9fs(void)
 static void __exit exit_v9fs(void)
 {
 	v9fs_sysfs_cleanup();
-	v9fs_cache_unregister();
+	v9fs_destroy_inode_cache();
 	unregister_filesystem(&v9fs_fs_type);
 }
 
-- 
2.39.5

