Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833738;
	b=SARjdSGdDd2RqKEtH4+JZyeiIMPPSZMDr2KarYGUqBJwkTZMjHQvCfSG34d8lcfKBiaw
	 v4TIMPv/UwgzzdO32W8ZpGL+vzdE3FVYwFd8iH8+QJuirRrdwI0VMwsksbh3GeLtbDzCH
	 vyC8ggSpBY2wGAgo5sGVbuKFpjfcoQXVbNygJnUPexGbyRZiIdLD2CE6xjMhG0VG3HHdS
	 PbTOAZcXT9/+PuKkkcUJbAhTKkqtJQss7ykBETn1/hOzl6AnKG8xTBrb43Icu2hTK79GS
	 R9aTeg3rL0BKroVyjGEZNn9U7tHchBR6mFUbnaqL7qfYYYwXgxkzFqXibVKZQVD1ubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YJsmZX1McOF2pOnvr2C6ZlYhQtDabJGRiQqmWYszNws=;
	b=3nZUP3mMwRtenR7f4IgrjrCmKTGspujF9d2CiZNGNfjN+vDoueKLhpV59uLXALaYbeTY
	 fbkUqp9t+lnrqKfBliK63f7jzVg0ZVMiwYiZT0et4gWQZ8ttgxerhvHAWwVPn/m7xEyK1
	 PaygPf98QFont8i1k9zR17WI+oeKfeOzOJ3XRvVMmQCeS/xTWAChY7LYX2pbFCYP4kDmh
	 J3MZZjZuZl1M7LXm9YYsLpMGkSlGeSe5zh4iAp+kKk5MuuEf+lEFd0rozcopYpAMMfnZF
	 Mzk9k8S+KobAWl20iKSg0zc9xEZSfDm65g1afKu+C3uzfC7Om5P/yJToT2Gqx3Zy+4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrnqCMPh;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70B606A322
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB70B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrnqCMPh
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35ef6b49813so2418113eec.0
        for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833737; x=1793438537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJsmZX1McOF2pOnvr2C6ZlYhQtDabJGRiQqmWYszNws=;
        b=VrnqCMPhhITHcvMlRve2j0ppFsKZBt8ywE84XVvprkXLfqHYo2iq/PGOAouXbEijU6
         pQPruqkC+Gx2ju4i28oS2E/5Oe7p4kxnr29MjsaUV0Edf6LiKGdKkNf3JyEYyAS80WkY
         Kvj358UO+yypjgvF7lZEiEclkbKsJH8UdLf+6NBzVzOefFKh8+hMupoNZ8g7spD3syjg
         D049bzwYSG+MoHOwyo1uwHMqVEUjiO8qKnQOEWoh0XhTZLif6gNCdQLf4EG5KjM7mdSZ
         xdLWYRh+/lCnGYzoYE3VFNo9bbk4nYHenx1wV7vpm4N8qJAqdKcd//vKnXRZm//fs3wE
         wa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833737; x=1793438537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJsmZX1McOF2pOnvr2C6ZlYhQtDabJGRiQqmWYszNws=;
        b=CRR6vyHzZDIC0altXhjhDueNpg0Cdlnz3xLp8uKfUK/snVHHW8J9e5Mdotj7QtQ+5Z
         WFNnIhdu+Qva2BI606iSCsvrO3PLOw9x+MG1WAgZVIpQ9wqEHG4UTzjlB7Rkgf5E8jx3
         v1JrvCiiLsx4XQ0aIzlpILXb5OsyQIkFBZehF3giOvsNpqtplzdKMPCdNIcbofs/X6yi
         sZC+0m0mxO4Jd6h4zM6ybU2F6GmCW1g37C3pdJBPsE8hkbnS4/q+IEn68IMwpypQ6rfW
         ZB6JT/tj6lK8SlUqXCDu+N0KRLngTU7UMMJqLHUu15ftvASg1oP3PLXGInsSS5SnXmTy
         IhZw==
X-Forwarded-Encrypted: i=1; AKwUvBwgvfdPYcX5KRxNSE0b+9n9Sb8SVlu0rgjBWUWm7soHKUMdjlE901h53HXcLTmUxftucacK@lists.linux.dev
X-Gm-Message-State: AFq9FYLuGPFLMQth7kO+nlzB1J9cEBKY8d/J8141lifgfPBm73Qg8Bbp
	ye/qBref4H2CYdj195oIWG6tX1ZtfbtlVcdsNYM3U9iMEWDbd9WeEBk+
X-Gm-Gg: AYBFou15AZV3WW7OdcMk3drIxWalVzqft1czMARe5RVtBxZ8YJCadGGx0hdIv6IcpiN
	H1mb6IYiSIluXSAFZRdsUYHK2wGWF5flAEPqfL3+2bERHA3cSLSSD9tpnLkgG3Xz+Nf6/VDqJ/D
	XbwAhNhIBv000JpzQ2j7Ezb/2UFhSiqWycfdaRDXrk4C+ajlZK8rrnbvdvWH1o37aFsCv467wTw
	98rkEj9G/sU5Jr8t3xpf12bMEK/S0dgILqgwUFLfPLDr1fX67iMh68cV8WXR1ZVELlwRkQwbyPz
	V0VVu9KtOrn/BAeVoG26vaGy8yHdVLT9TjoDfzv8173yT3CYuXUK9ZOZB9IrzTBg6Sv3NfKfb4Y
	MRJKMWeqSXrol+/kJWP60xXDc4Z4jqpwqtYexE6N2Cy0irq7c3B4SrkNvsGj1HvLeKvs7m9w+b0
	Svi19uvUuCifQXMUBx2GVGKjagI/+J/u7/kYml07YVxABYb8rLHxYQx3arzyn469BjH238jbXsw
	RWhdOLnhxXvKMGpaGX89dhEs3T3EBUvqW08uAR+FphqyfAJgiuVtyVpDDOLnT+qu19ZO6Hxd9Ub
	Jo1PrDXw+CPS5KzuD+xB2Ou2qaoApuzoCNkRBxD/qiFTVVssSvsfulKTTlPZVX7d56cZsfIX3JN
	8XU1DJ1/T9Zl5k5pA1gJAwNE1iQ==
X-Received: by 2002:a05:693c:408b:b0:35c:ba31:6fef with SMTP id 5a478bee46e88-369e86749a5mr2838749eec.36.1792833736816;
        Sat, 24 Oct 2026 02:22:16 -0700 (PDT)
Received: from LAPTOP-VN8JNK11 ([111.223.26.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db450bsm5108584eec.17.2026.10.24.02.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:22:16 -0700 (PDT)
From: Ankit Thakur <codeankit.thakur@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ankit Thakur <codeankit.thakur@gmail.com>
Subject: [PATCH 2/4] 9p: fix typos and wrong parameter docs in vfs_inode.c
Date: Sat, 24 Oct 2026 14:51:52 +0530
Message-ID: <20261024092154.1844-2-codeankit.thakur@gmail.com>
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

Fix spelling mistakes in comments (functon -> function, Hadlink ->
Hardlink).

Also fix the kernel-doc of v9fs_vfs_mkdir(), which described @dir and
@dentry as being unlinked instead of being the parent directory and the
directory being created.

Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>
---
 fs/9p/vfs_inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 537cb22ac..0585cc915 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -481,7 +481,7 @@ static int v9fs_at_to_dotl_flags(int flags)
 }
 
 /**
- * v9fs_dec_count - helper functon to drop i_nlink.
+ * v9fs_dec_count - helper function to drop i_nlink.
  *
  * If a directory had nlink <= 2 (including . and ..), then we should not drop
  * the link count, which indicates the underlying exported fs doesn't maintain
@@ -673,8 +673,8 @@ v9fs_vfs_create(const struct mnt_idmap *idmap, struct inode *dir,
 /**
  * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
  * @idmap: idmap of the mount
- * @dir:  inode that is being unlinked
- * @dentry: dentry that is being unlinked
+ * @dir: inode of the parent directory
+ * @dentry: dentry representing the directory being created
  * @mode: mode for new directory
  *
  */
@@ -1134,7 +1134,7 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 		if (v9fs_proto_dotu(v9ses)) {
 			unsigned int i_nlink;
 			/*
-			 * Hadlink support got added later to the .u extension.
+			 * Hardlink support got added later to the .u extension.
 			 * So there can be a server out there that doesn't
 			 * support this even with .u extension. That would
 			 * just leave us with stat->extension being an empty
-- 
2.55.0.windows.3

