Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BC1096F
	for <v9fs@lists.linux.dev>; Thu, 12 Dec 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733962916; cv=none; b=TX4nMFPyFH55j59Ws4sU7PBmukgQQSv8ebRQUdx4ydPgKkO5k/vEQ6HGJyC59EHW05j8nbZzGADUwXpxlWQCVIimayQTXQXBma4ex0Y6qu7DUqbqD6dyIs56NgIE3uhxNjLNtgvIsXnm7CtUldhSQqK2OC6f2xCdnifjpj0pRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733962916; c=relaxed/simple;
	bh=uln1aLpbwm/yBjgvBJAUrJVEanXA3yCbq8lbO5GlSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUGAyk38nrwp4C/MYI2Dc5eV+JKpp0DqsEfoqZ1ClW+9ma4EpSAlGWulwC7r2POGZVSIqIEgerDvUHWMOB75MBA3ez6k81eihny91TgTuMNPehztZJ64ziLqHxV/WYyAWpDlv6FoE6Ble1DhrJCQTVhU6YbRRdXBcd+xdlUyTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVRxpVPy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVRxpVPy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd377ff3c5so1056019a12.0
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733962914; x=1734567714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bketrtpeW6UKdUyWO3MVWt53PVBe2dVx+Pr4cx7LBI=;
        b=HVRxpVPy6TxcGPfDYBBb5X0x5qs/r8zjDgGSxQyfZy+V48beEpGnbA0iJrkDGgR66W
         kLUJeWg0oLn/KNU+4vEOlY5gtlKPv+zMLFyiIu39KwztempctIdBxs9cTDywhGjcpcUk
         mN/X/07vYyqtuBjPwNop+RozWV3pr42JO3QhJu4b4HmGL7CMVU5/qGzBtxCa2iFp3HD/
         PwgercNw/sECC8smTgIBEmYfjQIGW3EyRvwP5fL2ajDn+tagHvUZ3+aFst8dILFJF1KY
         YHma3mJf4Thi+8vJQY5uIYHHqr/7DGQV5772KLxGSN1qwtBBvlDxZi7WSUG41NhJpIlE
         yeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733962914; x=1734567714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bketrtpeW6UKdUyWO3MVWt53PVBe2dVx+Pr4cx7LBI=;
        b=fbL3z4ikDMKRqXiGZJcEr1twz3ySEXZKrk971KITI5xZLSx5T8uGAWEs+cTHtePbma
         iPXiZFEUYMCcawA1Abm9YLDP34AlDckeXzKIozcwKQ7g6DIddpLsthcJwlUp0Up9J3Ty
         kgqjOe5rOmMRxnLIGQJdwIkS6XZlwviaqZL7w0tMjjVqe6i8Dzwg76aAKuMV/uoDIRQJ
         ZAxLNlsK3arQXfmiAqR+R7DGqbVWadiRua1YK7SAONR0Qtsdt60gULkU2EopNrzh/fDe
         KYpBCbWfCLamuAKbHycUYc//iFbRMvq2ObrzvIh+cLitOxpyG55bE1hmlOZ63gpZs7xK
         P5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1HzFTpkCi2YQP6kPrz8eGbVVwK+oPb7G6CtzslxZSkxIZKIuLqIAOLyShRXzO2heOoX8@lists.linux.dev
X-Gm-Message-State: AOJu0YwHfcLYZyQcgOSvrLFGonjk+wGnbODCDwKGyJuhUD0MiriG9dDB
	9YvyebJS3Gz/5T2gJvNckAsvrrQbHWMXQqrRLtI01Ud0vV6hI3/11gb26PHunD8=
X-Gm-Gg: ASbGncuwjj9/F2EKJ3GChuMZeZS6fHq7nW3v/uBAothHwuNRiIKTI6K+0F7NG/ddUKh
	BiMmrbdOdVD2ZbrsyrUKO6nvMEiDd2ykxHfzIiEo7w5DvMkYPC/5Vi8TS+/IcG6N0qaCTo2OWx1
	3O8qbDUrV7dmt8ZgikxVWXcIDDCKVFIaDMt/j5f0G+bY5F0Q8Fw1qmd5Sskgryf+0ISj4oqaBQ6
	0SnUNhptHJSlC9obULdvxtsyZUIahbOVrQQ4IhbzKSEtbdcKnMuBeIIUEI+mgQPHS4W+SEV
X-Google-Smtp-Source: AGHT+IEIh2pxGWlSntUWbdtNDDz1buQFg4Adw/CcEXsV5276tbuH02ZNbu5Nd1bQ7IEod2fpr1de0Q==
X-Received: by 2002:a17:90b:38cb:b0:2ef:83df:bb3b with SMTP id 98e67ed59e1d1-2f13aba96a6mr1882157a91.8.1733962914123;
        Wed, 11 Dec 2024 16:21:54 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a69f:44ab:93c9:b027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8d84224bsm8241413a91.42.2024.12.11.16.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:21:53 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org,
	ericvh@gmail.com,
	ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org,
	v9fs-developer@lists.sourceforge.net,
	v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk,
	Leo Stone <leocstone@gmail.com>
Subject: [PATCH] 9p: Limit xattr size to XATTR_SIZE_MAX
Date: Wed, 11 Dec 2024 16:20:22 -0800
Message-ID: <20241212002022.209049-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675963eb.050a0220.17f54a.0038.GAE@google.com>
References: <675963eb.050a0220.17f54a.0038.GAE@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot triggered a warning in kmalloc by trying to mount a v9fs
filesystem from a pipe, after specifying an ACL size of 9TB for the
root inode in the data written to the pipe.

An xattr larger than XATTR_SIZE_MAX is considered invalid by the VFS
layer anyway. See do_getxattr():
>        } else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
>                /* The file system tried to returned a value bigger
>                   than XATTR_SIZE_MAX bytes. Not possible. */
>                error = -E2BIG;
>        }

Reported-by: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
Fixes: ebf46264a004 ("fs/9p: Add support user. xattr") 
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
See: https://lore.kernel.org/all/675963eb.050a0220.17f54a.0038.GAE@google.com/T/ 
---
 fs/9p/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 8604e3377ee7..97f60b73bf16 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -37,8 +37,8 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	if (attr_size > buffer_size) {
 		if (buffer_size)
 			retval = -ERANGE;
-		else if (attr_size > SSIZE_MAX)
-			retval = -EOVERFLOW;
+		else if (attr_size > XATTR_SIZE_MAX)
+			retval = -E2BIG;
 		else /* request to get the attr_size */
 			retval = attr_size;
 	} else {
-- 
2.43.0

