Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED91C6899
	for <v9fs@lists.linux.dev>; Wed,  7 Aug 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024053; cv=none; b=n55U7DHG6I6MKC5M0NjwvlNhBxVq4XgTy7r6C/cLAVmZAKvK2+/O8/WVLhmlR76fcrlarTdeIB5Gc3hheKkCQEqi9DKAKYqlT0ZciypipQ8f5zIoNuMs7IyZJKf4ZPUlAHF6K6BrLOlm10uHpSp7PCIAtWZk5BVShgovAK7wQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024053; c=relaxed/simple;
	bh=ioksRDqwNLk17P3K0C/NbICBneuR8qlCZWl6hNhU3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMQQaD+HzkFu7ddP2sI1RwJU+TZ9mFG3JjDIfPr0wwZbZR83+QlAtkH6bddx/BerEzDlFL1vKMzDEX2Zr7g3XnywMSyjP+b8tGZ+xV9DaJjg8D4rta6Z3A8cJA8pMi41mVV+6oyKZNDWatlaY5ZgZVYid+FJdYSxbew68vgqG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0xNCXZq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0xNCXZq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso15070235e9.3
        for <v9fs@lists.linux.dev>; Wed, 07 Aug 2024 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024050; x=1723628850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62SrWCnNhxclSxuLWcVToN8VEVDl6BzHuN80K65dNUg=;
        b=Z0xNCXZqS1Ya/DsbAYTYJnqV79jjHXhBghqt5wUTKUkXDh70hMvU6OHjgR9DAX2GO5
         EnnWRBrpK0QGpPXCrVfX7aJxNJ06+0sh2z8XtktAod5fnLRo/yaqHyb6MISk2EK+SNBv
         Mo/9FrJG+FCuMbTrgUILElT+6kGFPgKjYOCjD3jyQfM2IjT6gf4AVuy6iii+EHXyo2nt
         TeWCYp5QR3CDUy4Lsj3eXRZNJ3led+9Sqf6yLiBH2WTaQg7PHw26U6IDYbMcjd1JbRJB
         oabl99qfsdsDpUte374YRka1/xT6XyRi1TCgkgHTAQoDx8MVAtva9riTR3yAjMKUclrr
         61FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024050; x=1723628850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62SrWCnNhxclSxuLWcVToN8VEVDl6BzHuN80K65dNUg=;
        b=NuSBrhFWhIo5gg0vk89NgEILLZ6eXmf1xj05dcb2IGSPVBXkpO6IxjAi5mzjM1vRJJ
         GsSVkuWroNdRXZrOi3Lbcb05TU5AKXPi8WMOMIXARLX7wjHxTNfM4tDFupBc35aP71Bp
         nC6l4aUYd9EsKQBqQJNwHYSquW9iPy/f+ftua2+arHR4H/xlTzFDtM6yT8Nnh9fkzm7h
         Oj+DW2yUEqpEar9D9FyJiOy4qDkv4aL+rowHxo9ZJ8xkAS4brb6JzhXVqklT3EhjUbMc
         jw7S9QFAp+dvT2m43MkQO64ZDLUNk/jFteKq4/pnXG8bckr8PcaZHyoDXF0dyN9RH6Bu
         YcPw==
X-Gm-Message-State: AOJu0Yz3Y3Oab5LrlpDWukzFFyZL8VRvv4tQE2QBb4Q33zT5C3fYCauC
	VMUYFGS/IGN07c7C9zgsYeDbD9Ix7RD7euGT2TtCXllrjf5GWZuw
X-Google-Smtp-Source: AGHT+IHHiCLygoa5Cy0kG4Ocdj4Rt8Aj3T1Zf7ZwIMSu/V2JXiJj0SzeBsGgeuQCLQrUwtO+HDNpTQ==
X-Received: by 2002:a05:600c:4e87:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-428e6b02594mr161877885e9.10.1723024050150;
        Wed, 07 Aug 2024 02:47:30 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059a3e99sm20860085e9.31.2024.08.07.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:47:29 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] 9p: Avoid creating multiple slab caches with the same name
Date: Wed,  7 Aug 2024 10:47:25 +0100
Message-ID: <20240807094725.2193423-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the spirit of [1], avoid creating multiple slab caches with the same
name. Instead, add the dev_name into the mix.

[1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 net/9p/client.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5cd94721d97..9e7b9151816 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -979,6 +979,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -1035,15 +1036,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
+	if (!cache_name) {
+		err = -ENOMEM;
+		goto close_trans;
+	}
+
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(cache_name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	kfree(cache_name);
 	return clnt;
 
 close_trans:
-- 
2.46.0

