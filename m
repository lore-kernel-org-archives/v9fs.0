Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C351C1F22
	for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947421; cv=none; b=M+aYX5fCXQfwu+Exuowndsv/Y0xHCfadI0jKW3vqgjuzaXx80400YfYIXK5VRMzA9FisD60macLo0vxaqDl4Kg2HlG+1YR+04WJ+YmmdcIn6/ITDKalciWLZuKeXUbdOS21+QipNQSrotS0ChT5k3ptIO5xiYpK2HiDixgF7Lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947421; c=relaxed/simple;
	bh=c+2c10RP4eGxCZIDeYuweNxkKIm5rRVnujDbzoBRRQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lctoM4N7lcm6ZYW7jl5o4qzwzVcDffFXvi7oSwjSzpMKkuyx9hwxdGNH5gAUadxodukULkm51tnGi9NFG8bGQ/OmorILGKC8hMf7X8AkII6JQvImRFMEYPIEDjIoUP9X3IYBv6F2fASw/UOjXJWF0HeuDO3SLncEFJ9KILuKcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKmvQJ6n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKmvQJ6n"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso4364278a12.3
        for <v9fs@lists.linux.dev>; Wed, 11 Dec 2024 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733947419; x=1734552219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpNgAxO5KyvvV+aPXyUgI2o0mazz3K0LzFSUucmqIA=;
        b=bKmvQJ6nZf0z08+JUDQNzih42QS6XXEosUcMJ253rueh0pL9SL5t7erzN32MM7vuzl
         a/WsVp3NV3Cur1XPPNQ2OTgiGq/q63Ma7L/i4dWcwMAHaji7UDbG1urbyyGFIzJzdtYE
         uDS7S3fOGMKlUdpn1mnqEtTYWFgJ3J0IL29nb9oZr5imnf6SblTGuSdjNePG0H5p0LCM
         0H/o2wLfmE+06L+oOHOf5Hp7knHsHyH3kx0putEMX8r/cgeKD/4x0NsCDEF6i5CgGV+r
         b9ic1skI1/hAKeag7yy3V6Iz0lD+2RHJnMMhcJn9wO9n2IMwF2oGWEpyNzNW005GNrq/
         zxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947419; x=1734552219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjpNgAxO5KyvvV+aPXyUgI2o0mazz3K0LzFSUucmqIA=;
        b=KCOSxeEcrs+JEoQm5PkaFXMzIsNVfglzhLwkDOUozq5+UDQ1tZTG3ZM6g1TD16FzGk
         Np5pLFULZ9Sw38nR+AXCiQl6b0EmXSxgmfLzm00b6cPOpndwNRGuVmGT1gNzsW7n64Ra
         dFEQDPDHppTjudUhD+v8G4aHVrgvPk+b12UKfSo8BNVTAq92Pj2K+Cz7n25dstGd4Ba3
         Gse20mICZ7dVM7zm81PBsGRH3qawU38gvFqqgvn/h0TnSNqhHrAkDw/vROW2bzx1p3Mk
         76wTrKMF4nxFICfGbPiGAiMgQrnfKo7iWh2CMBKnVuwnotw1Bdobih0SgcucTMkJCoWT
         Lclw==
X-Forwarded-Encrypted: i=1; AJvYcCXvcagHxjoQX94YIi0PkQYDZHUUANk9zNaCWBiCmf22ayC1/uy6hM7HIjIR6TeePlymKdCK@lists.linux.dev
X-Gm-Message-State: AOJu0YzO9eU3lZWlBrESxcM9GyIVhrXoIYD7PQAxDK7OBctNPhWXcuJ7
	wU1VU1I2gmlcyR4n+n2B+dkQMKCmFT0eOS2BX37nFtCMRU5ClK4e
X-Gm-Gg: ASbGncsZ8tHJj0Cgi2y7MhzVdZEN4s2gV/liGot1hmSDeyi1OL3srUipPcr8YwYFwnx
	dlJ8HYBohjy2HwsyoNV/ETKBpUK/Ruphx3XIdLtWOF53ZtMXcpvIeThkWaXHDbXakUsYddHYrIi
	3Txgzc8QeU+cj0lmdEJ6T7X8EpoqaT7bUiXBibewDWzgLeibe8tnJg2U+0R8L4EbnICc4D0zwgO
	KPxiNPsdQUy7bfhXTo6UjCQqADs+Qz2YyGwomukNHUw84bX8nqGf8tsVUofVji4uJJHnA==
X-Google-Smtp-Source: AGHT+IFkpFW//odQIKH7vFlXlfPhvueJRWLMq59qElOmOHMBZNOyfMpmd6lTVOFk+xCH3IcDg/u63A==
X-Received: by 2002:a17:90b:1c87:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f127f7e587mr6242980a91.6.1733947418716;
        Wed, 11 Dec 2024 12:03:38 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a69f:44ab:93c9:b027])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4757691dsm6158725a12.18.2024.12.11.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:03:38 -0800 (PST)
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
Subject: Re: WARNING in __alloc_frozen_pages_noprof
Date: Wed, 11 Dec 2024 12:02:40 -0800
Message-ID: <20241211200240.103853-1-leocstone@gmail.com>
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

syzbot creates a pipe and writes some data to it. It then creates a v9fs
mount using the pipe as transport. The data in the pipe specifies an ACL
of size 9 TB (9895604649984 bytes) for the root inode, causing kmalloc
to fail.

KMALLOC_MAX_SIZE is probably too loose of an upper bound for the size of
an ACL, but I didn't see an existing limit for V9FS like in e.g. NFS:

include/linux/nfsacl.h:
>/* Maximum number of ACL entries over NFS */
>#define NFS_ACL_MAX_ENTRIES     1024
>
>#define NFSACL_MAXWORDS         (2*(2+3*NFS_ACL_MAX_ENTRIES))
>#define NFSACL_MAXPAGES         ((2*(8+12*NFS_ACL_MAX_ENTRIES) + PAGE_SIZE-1) \
>                                 >> PAGE_SHIFT)
>        
>#define NFS_ACL_MAX_ENTRIES_INLINE      (5)
>#define NFS_ACL_INLINE_BUFSIZE  ((2*(2+3*NFS_ACL_MAX_ENTRIES_INLINE)) << 2)

#syz test

---
 fs/9p/acl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index eed551d8555f..1b9681d58f8d 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -28,6 +28,8 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 		return ERR_PTR(size);
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
+	if (size > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-ERANGE);
 
 	value = kzalloc(size, GFP_NOFS);
 	if (!value)
-- 
2.43.0

