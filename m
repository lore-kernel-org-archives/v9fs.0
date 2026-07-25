Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666C33372A
	for <v9fs@lists.linux.dev>; Sat, 25 Jul 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943899; cv=none; b=I4geGwXieHhSuQYbSIlD+ODflyhtk/WTIq/wYtIO5DYtJDBNUSKnxIh8vafCwnFOoz2R7kx7A8PHE5sdmns73wUuEtvkcnHPRITWSRZX3ciLMZoG2l8sY1sHP/cerZ+GMeW0VgcoKUozhdNTJFkwQLE4e1zO7v68fwfVvg91A+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943899; c=relaxed/simple;
	bh=JC1RPRMvNmvIV9WziwHo2xygwz477pttSg/6YpjAA0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTCq295skXhUi9a1kI22CIq4lOaK0ivX0OLeiBzcvgm8bEPxbrzCbTEYf/eSq7Bh8Vw9RoJfYFDsX67ajsUK/P+E/KFexlnM5AxxVmBuAM9LdvaaKJfUcBxJ/275lSe638TYbsvyThHYZTWykDdAdXM3NUtLbWJnVJ5DhAf8cJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+HnB2Rp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+HnB2Rp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1392805a12.0
        for <v9fs@lists.linux.dev>; Fri, 24 Jul 2026 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784943898; x=1785548698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsycQkK3K/Sg2WBClWyOTHAiyU64+SefL9aiA1MnBEs=;
        b=O+HnB2RpOta652nqv7wK4j65F5Q9Mtln/mcuLM7Dqsx+kqWk5tx/Av+I3v7vQujCnf
         iD8044EgcWhO8T7f5o1P9pgGboGsSPkOltoIP0Efgh0GBx/67rK6xAaEpKxMX/f58kIb
         ywgVDRlAJi0H4ruHMLAjp4zki9ui8fx26KYIPErRYMqQv4uzBGuv1WjqNn7cLhMY/Kdn
         gJFRBz7qjwG1tjtDnkteq/iI/XXUgllG2oZREKKEdtdEmYZzcVSuKygCWGZAgyR3052o
         cvILhlu8hEUNb1/KW62V53v+g/YYiD/aZtjZx/kLfSfkOsQuFfkV14tgX7/gM5wOf7Iv
         CrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943898; x=1785548698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsycQkK3K/Sg2WBClWyOTHAiyU64+SefL9aiA1MnBEs=;
        b=HldlyGDSl05Z6cK9xxqoW67TWEXb7hLKrfOHxBy9a8/jk+iW6TrICcGGaTW9dEUakG
         DYm7LY42psMmeMgoQFxP6A4W1TUVQ8ebLCjX1OwGAaHna+kNPBBM6+M0zwqXvPBzHsWR
         YIq+JCkzX3YlQ49tU2lvNboKmvWd0Y8RsbwMVU1x95aFdWir+jxESQKEH5ePOR6Be3Q6
         GJQGbrx1jEw16cXd2KuTdfFB0si28om0Bg6HLCSFEAGu7ahh7kwCDRYGBN3J1kyiQbBx
         tNVeeFdPTmcCJq/GHauQgJCjRyKS3JUfKNjtppejIKOLKPIHZq0/cslzyHZtLStySPwU
         z9Bw==
X-Gm-Message-State: AOJu0Yy2eYb+oUy3CoONKClhkn8AFzzP8EyurNNilYs5enl7XEmRXxIF
	OhV1oGODdF/nNiVuQaiPsvGjr5aSE8ncu2+zbj8fPWNYJhsGwEi3RFKF
X-Gm-Gg: AR+sD11fnINRlGDcu6XY8dPlwlwZfbSnkhmJoVPjJlFpCdC/DC2csDP4K8U31eo1CYI
	g9q7jNuBQXSRo8XI3omxwwYCT4HmuWqkZk3X8bXxtTNAfOstvgx4renLGgBUYSkeIn0xAYRv35Z
	+lFggYvTci0GRE8ojD+L5ATyji2PR0jGuLa0JrWbqduygL9blBwhN8xm8D3lSbyMJpQxE7046Uf
	ciOqIfmXPMSGsTQVsDyGmqTD6ZrPPUp1E5pvWLcLS8j5VHyp1ST9wM396LvKU6qH73lpN9fD5oo
	LUUNrliYo5JIIeb05LxVT1uQqRYsEf7b0oCWah1IOy7bZLKQ9tTjbFfIbSSLhwTE75/DfoHcAsG
	XM8P3cOPznr7hC03vxm0BQyKYPg5yH4NunjSHFcRg1ST76DX02nsOwG9Uq3Kkj3nluWdPoODZq+
	1P2u93h7k7CzjdxFnm/9BCc9UbNC78F9Guau3WMU8cj2eymHRcde1wdtDI5Nk=
X-Received: by 2002:a17:90b:380e:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-38f1eaaa3e2mr2990188a91.5.1784943897637;
        Fri, 24 Jul 2026 18:44:57 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:30d2:c11f:7948:960a:6d92:5986])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e53094d65sm1378443c88.13.2026.07.24.18.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:44:56 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
Subject: [PATCH] 9p: don't WARN_ONCE on racy symlink fid lookup failure
Date: Sat, 25 Jul 2026 07:14:48 +0530
Message-ID: <20260725014448.18711-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9fs_init_request() WARN_ONCE()s when v9fs_fid_lookup() fails for a
symlink read via the page cache. This is a benign TOCTOU race: a
concurrent unlink()/rename() can remove the target between the walk
finding the dentry and p9_client_walk() completing, so the lookup
legitimately fails with -ENOENT (observed: dentry=/file0, err=-2).

With panic_on_warn=1, this WARN escalates to a full kernel panic --
an unprivileged local DoS reachable by racing mount() against a
concurrent unlink/rename.

Return the error directly instead of WARN_ONCE().

Reported-by: syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=344c09c64fcd8d3d2782
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/9p/vfs_addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 1ac0b3dcc077..121679488ab9 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -140,13 +140,16 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			goto no_fid;
 		p9_fid_get(fid);
 	} else if (S_ISLNK(rreq->inode->i_mode)) {
+		/* racing unlink/rename can make this fail with -ENOENT;
+		 * that's expected, not a kernel bug, so don't WARN
+		 */
 		dentry = d_find_any_alias(rreq->inode);
 		if (!dentry)
 			goto no_fid;
 		fid = v9fs_fid_lookup(dentry);
 		dput(dentry);
 		if (IS_ERR(fid))
-			goto no_fid;
+			return PTR_ERR(fid);
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
-- 
2.43.0

