Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8432E6A3
	for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771692299; cv=none; b=PpEqZ9eVox8QoTGQRaaCgPsxaDw6LVHJzhbvZ+lXUaWhW1t21FXyedgMdnxNs6tlNp4TU1oP1/0pdfMVufYmSllbCTwsjwFQ9Mlw+PeV66uKwghcld0NWs7qCby660mbtCb2xv/lypkzfpvN5vFSwYKpzWbXn/MTqzs0OjW8/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771692299; c=relaxed/simple;
	bh=Q8LjG5w0LfBzA+qqIJUKX9oy/FN75Vn0W7VHoH69Qv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3JQ/g1J1yGxSiccm1/6UkFOAQdlN6Ajc/lINNCVeFgGUondkhUnqBoZprO3Gvu+wv8QKAHQ1ln1qXM4YfNrddT8Kl8eBcdzay4ACKIzX13WNPvdaR5VYW8iR+w2U2dUxAvzILrXgj0lKJqato0AnB3VMxEDqIfI6CaFxv+Hk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0NyK4ql; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0NyK4ql"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fd05e8d317so1940100137.1
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771692296; x=1772297096; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=A0NyK4ql+7NIDWu0cOQgcsmSgnWXC1P9rN+tuIEWRQ9jqkqgAq7zh8m0KsPhVgvn5r
         wri7KO8l5ibuB8blcg5qbC9WabhMvqPdQe13gF3vtyyN31+OHC4oSRU3BbYc7BvZMoql
         HkH9+KBe+vh6Oq+A2JZ1peTYA8UZDkL8OOE7L9H2vw3GleAwmPdNz5O/9NJ+FheDTbsi
         lXrU/xKSGFXYIs21loUbr21wbrrngNfISinqcBAXDsjg9cocy/XcKl/6BjNVcLXhkq7l
         NKy0wP1Jn5/MWK7YkCibgSH0CCau2pcLcsX14SF8cE5iiNjuC7aPprhRYy6LsWa033qx
         5Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771692296; x=1772297096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=oF0OH0O+k6wLKuqBl1girNkNSH8JXT8H6BcccOVd8GFNJ1zK+8R6ci5WIsNDuyCkTx
         RrRoVjOQ6WGoNslWAiNyjWb0mVZHm4dd8AFZCpHsw4oa1jSU+5EsfigKExr/WUCUMqgC
         twLBVDsPMZXA3KZCByxpouvV1cZA6PpoHu+uulDgf/mCxHoc2Dy37pe09aV21cEFsbxa
         Q5dp3Vr+sl8WdJ2Zv7JRH3DhBHTw6QGCUaljukDv13Vx9y0OxI6rIuZCOk9LUkWV0oZf
         amVpO3Y1bvvURsTNt+Pk14hIVls7Un5Awkxr1bVlMtvsvzoR/kPLBLTw7c0BuZdnV/C7
         5sQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8/TDdA7ZPPM2zs5EvnizJiPTl1VzanhqNWLdRCgIs25Xpz83QYxyTHRjKPNEWlD+ePiHJ@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9FqSWUq5K3HBd9K3SpnOikn8SOzHaL27qNwtG5D0LEmhCmOl0
	2sa0+s/spUt8cfIONc9FQnWpIOeuif8rh2Or5hWioXdAzd7PsBf1YSVEJmlsDQ==
X-Gm-Gg: AZuq6aKThZaKtvQhjCCNGrinWhGhdFODY6dcD7MDfF+CienLRlreATMa9gZEgNRn+QD
	C5nkET497rb5hQ3jdVLg/3Q3sgwZO4H972zriNETa2ki7qikQZnqK0LBSFhf6KFkKZYkbLgJY/u
	KhOAKXX1e6mCiLXJ50mDUWA4UdXXiLV3nwoqISzDntZuGwUESzbakq+3/tfVPguBmhPwXEoP9u3
	SzC4rA3JQksoZ1KExFHT1HjSuFMWQSzLZkuyB3u/xZctqzZ+l5b28vNM8rx7ZOoBdCJuOUErlm8
	qUb5w9fKT2bRne8HObxUWjW8cyIcWJpyl6rKaoxOWJvPqmJJT4TIjk0MLdf0DUo0KnTyH9Qc2DI
	lc8nTQ/xwj9Ick52JIGZQCDPVeX2PctktAnAmpnhVyNYKnHpii62jm2dRIfjy2b5txvFibBW34m
	6J5WFkrbHzVzpigUHD5WuLbwDMwVCa4EXZPhboKPEDV+RLmYmatggBLyl6eJQhX5eV0A==
X-Received: by 2002:a17:903:1d2:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2ad74458fa3mr31285505ad.22.1771685983010;
        Sat, 21 Feb 2026 06:59:43 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sat, 21 Feb 2026 20:45:42 +0600
Message-ID: <20260221145915.81749-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

I only tested this new flag on my local system (fedora btrfs).

Note that I had submitted a v4 previously (that had -EINVAL for the atomic_open
code paths) but did not do a get_maintainers.pl. It didn't get any review and
please ignore that one anyway. In this version, I have tried to properly update
the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs2,
fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
(fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, most of
the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |= FMODE_CREATED
for the O_CREAT code path which I assume means they always create new file which
is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead of working
if path is either a directory or regular file) as it was easier to reason about when
making changes in all the filesystems.

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/gfs2/inode.c                               |  2 +
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 +-
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 11 +++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.53.0

