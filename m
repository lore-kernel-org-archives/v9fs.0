Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3D2DB7AE
	for <v9fs@lists.linux.dev>; Sat,  7 Mar 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892476; cv=none; b=q3l2Yu9f55KrTfEVXBdN/MV2JBByenHtZfw+ayJmA8WLGiNhSCcaCMD3bbr0zlctXU1Za4OtM16yp1+rIAueHB7JEs9yFO7f7MwebnHOVnshs/g8wbxQlsWL/HYdzVEUIvWi9IkQqpLtC88t3t+6atSNXTeSpmRWRUj+vFKl/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892476; c=relaxed/simple;
	bh=q0HizNdLQtkBg+6I2Uwr71BFH46+Qf7XsNZYRKQhaSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHsu/Nq+8fXxdq48rIyavZvOplOIjLQMq5vgsdSOK2L0hIFvurH/eRra/NGvu7Fq6uMP3mphlmh4hV+ZPf/T8v7BdSP8xLkISnrzJog8bWtQHm7GdwGGV6a2C+EELxfKdOXPBTwHj+CaHFtQx85zGpBCpaEIfIlA20X2Q8BbNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guyB+8S0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guyB+8S0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827270d50d4so10399660b3a.3
        for <v9fs@lists.linux.dev>; Sat, 07 Mar 2026 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892474; x=1773497274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdS9yl/p7UlIdGAR7tR/qX6v6/HUi/AMSzKRwMf8jaY=;
        b=guyB+8S0PubweMCUjoPsF+ZJYBO7buWRQxRpl6kPqsqSxh+FWGk09mysgEQ+OXxLTR
         23DRzJaAP3PiW1JSeTSL9m9jYLQGqfzIMtjYqOiaEafp9YFTSu/pBg+R8xoS1sNqFK2y
         SOWl8wbaPrcmfTae5JckVyT+T+rhJWYikqjRd8LSMkRVbnKz388KN5dhZslxtVthjVNw
         D8UReeq1simiCDQQOiJocRvzByVMqbXqQEHrBTjdG2BCsGlYpRnEeTIsNIYqhyyqbnYI
         hOZ89pnO+Tm++hmMdmutpczEnuyjBfmubmX4GQ1f1QCcG33Gk5kEMaJstKfXYn/v7cBW
         69sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892474; x=1773497274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdS9yl/p7UlIdGAR7tR/qX6v6/HUi/AMSzKRwMf8jaY=;
        b=fpYC31Fr2Qj189dehq7PJyWPxLugtAdcw0UuV0JzQKP0qmhZBwAoRS7CvoIB7suZTx
         BV505SUCQyTluPMi74XQ5VkcAB+lLR//PrJzlzeou5UmWeUkDeycMQlwl+r6NSndvOgv
         inlynMluAOm9cuUBfeMIQ8HpYNgINMgTvV22pWWp19hdlog9/mGYy7sHixL3KEDSaOGJ
         nz1G20TNwcmJ2L/zk3ffswDrc39T9InjChKa3Vl+++WOYi2jMNt/d/6788iThXrUAUHl
         ysEQ4PfpdorhAZJix+6D+o1j94l/7zx8hHuKFxqdCjiKOItH+UBfHchn5/BU9lbAwk4M
         426A==
X-Forwarded-Encrypted: i=1; AJvYcCXLU8LRWWvhNOlOcvat8kKPTBt8tadhmr4S90fHy7gnUQg/XNobAkYsUCMv0Xl6XZarjhAB@lists.linux.dev
X-Gm-Message-State: AOJu0YxKca3vlRTA9KE7gr9WTDAWt4F8MGHd/zug9BGWiG2nOcBGmJA/
	nhFJXOim8i6aH2xCQMsZAkYEi5QEQpJxBvdZ+bY7GKkpZsvrXBOr1qD5
X-Gm-Gg: ATEYQzzFsYejjIu0+X/NEwxoSdXsGlWFEDXEvun71Xu5z1fmcxjOJ4n5rzgKMM5z0E5
	vTPScnSylnl1PAjDylyZJmEPKay94XotdD6iQC/PpEDpBp0wvbxOJ1M8V5+284b2ZDep603JXhq
	Uf3n6bEmbVlB7LACt4Nw8DbjUKxN8imP4yd3A0Q+wVxTB0/3xkxjqyWz2d8i8plXLcfCvBr7WL5
	PA4rUi1fPh3dKUhJvSaKwTdEZieKbzj9HhoU2Nwr9JktcvSqPshyxrj0rZ4hWF7y2nkgGIt49FH
	bgLJjoAlKYoWLNIfs33BPaU/jsshlR6BrhIel0dKmoRwp1Aqe4oHTAzdFef4ijv8euoav53uQhR
	ZL1LXZHSHrbEBOL9yrHvhmtt3SHc4d8oX9JyFxIcFDPMQQT9lvaS3547kdDgQnucOKpi5yv9PBT
	R7NpvmBen01bwZ3ayFLAZnjrJu3IuoFvWdDTQ7sn749PGxxTL5BmOfnpdtrj5+iRxHiQ==
X-Received: by 2002:a05:6a00:1581:b0:827:26b0:58d6 with SMTP id d2e1a72fcca58-829a30bf515mr4247393b3a.47.1772892473854;
        Sat, 07 Mar 2026 06:07:53 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:07:53 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat,  7 Mar 2026 20:06:42 +0600
Message-ID: <20260307140726.70219-1-dorjoychy111@gmail.com>
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

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems

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
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 127 insertions(+), 31 deletions(-)

-- 
2.53.0

