Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DF3321BF
	for <v9fs@lists.linux.dev>; Mon, 16 Mar 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677572; cv=pass; b=MNvfb3h0MNG60xk0y/Ad3zy3dj36ovB2QEjgtW7KGHp/6o1fgWF4GXEvZB9v+lQMIOyVDtLYXXbm3A+m+7fZSLP4EXWgBPFIwk/Z2uAO9bLcSBm4pMghLJ7mHz4ejBOFx4Z4MKVibss+EQ+YAEMMGou7gNVBnJ3ajMJ6Clc4YN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677572; c=relaxed/simple;
	bh=mngjUXyQIGRdPpzvMVY93piHPQBoPK11l7fLKRKjC7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtNZY2v+9ml9dGnt/J98yKRlEwqCFmC1soAaX35FBGlOzFCXpov85rWI1DQ2sFhm4qKmRbxn0m7xhY1c04OnzeTnFoMBy4rkarxUJW/tzzh8NTcJ1Al9MkVURX5elfjt3Ra/EMJe39Y465ZzgIEihBxSBR5DtOyDtYaMevtW2E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBdBIDKm; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBdBIDKm"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so1028865241.1
        for <v9fs@lists.linux.dev>; Mon, 16 Mar 2026 09:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773677570; cv=none;
        d=google.com; s=arc-20240605;
        b=T6+l2VXMOh8raHCOOlxzWQh+XzliLRW57hs5x1omyO2mL/wpNXxh4c7+FGOa+7FsJa
         MC0i+aREOf/IG4/YKIgVzyh1dn6mpvql6MwRBdFCRvM0Eq2KW4suRIRDImerb9Fqy3MD
         eyYQ9RmDMi8pbGDUtZX1d34aSTGVuNwDHuGfXoEjcQ9YE57C2MRkTjnM/FFcj40ZvMcK
         POdnVLlgIMv8xqTAfOXmw5L2gYhg/CvGTus3TzsZDpTEnEhuYAw8wy/O8FwjxLshcdRu
         4Jbw1Op0DwvH7U1Bjwr4kMezGWeiyybXt8k0TMJh6wYpZB38UkV4oZCdMNnYivvFN6Y0
         dtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        fh=dNRajY4XSNXHGgpl2UmW9KLuH6xpyH9WigjJyZIR2fE=;
        b=KJHqZx0MQgjajs+sekNJ0MechDgTPZXAhYxeJvyji2xsD5Sh62ro3ZO2mCX8qcRayH
         QZHfSGZcOURPCIw4eUDaexbQVg5yNz3GGOBYUej+BzGkOz2VHhqAX9hmMkHHtSNqf21d
         h/Kxf5DpWUJjfihZUvoSxJpRzbc4UmVZD3s8euVoKh4KYTLngZyr4K6UOTEqUc6zXSjp
         DrGI4w+zXVVpvKOADOoOA8JntJcnkbvTIdypbJhnVQLG+cbVTApwU6X1gIj1MCRZ3dN8
         hnsP3kNbFH/6RvXhyrR8cJ7CNVqvVwLIl6l9sSLg2xu67FOwoMkk6jRs+qJHulIe0KsD
         85IA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773677570; x=1774282370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=EBdBIDKm08+z2y6drgLzhUDVWK2iqyDa9AcyzM+kAb2o1OQyc3YguxxEGoBe+5tpqB
         DSwRDx8RRHDj7/wL0QEMXlqBZ1B+WVndm5ecyJZrJ14qauk30HniDPGNjxGs5ux5c81+
         GLQ9wHE+xRIT87GP9MlEcLenB0TrmCXfUzflndAl87POU1fMC6F5bvg/T7ubX2S1agVL
         YCW0i2dU4IUD8OORWyTI3jb29O91JJozMz/8dEESeBJbGKYCwrUrnFjpYXv8cTvW0Tr0
         ZQyvhaalEW6HhmeXdGtUoWYhgkg5Xs30+i76qxLf3YUrwgzy31hPfkc1wN76vOWAH+BF
         QudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677570; x=1774282370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=rkKE96x1/UyN1yS2vdsLJJs3HW4Cwi8/sPKe7fiP0452+/+XNVq+6LIRQtEuGiMuEN
         Pszz/+nqxwGXwXaagxDjWdsc2Oq382/ILH6LYoafRqeNArav79XJnY0sOqadq7jCsh1v
         G++AkmvwKf+Mp5iPPr0Hp3VYiWJkbKn8ZnNxh2GAVa7J5M9UWds07FoMwruTKB3E0EZb
         UDDTueB7rd2lH9mEnFm3NCoZJaPuzWoNcqh+INoJReGv3rgU2OY0704gmVs0b2Fxdhih
         vYrWIJ4UuFXev+QQD4j9nhUopmEg1WzhI7tNvi2L6pvRMHJFNMmrm+WzeQfPGTx/m+/9
         j7xA==
X-Forwarded-Encrypted: i=1; AJvYcCX3uVRB88QegTcsj42rHYK2czwKtkibZnFgQIkiCtfjWMlJPCtsWTpqjF2+haPBFzJhf90z@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6AxdbQh/7MTQxDqw7vEo/KnEZ2JdQvJcoKNbX7IihqYlBFmPz
	ox50VmHZJsBDQbjpwQo37uBeO4vZLSS/IvOaIcpclYLx0LAbD6WFqeqhrvl0bij/ctQhWncKSbH
	TrS3tFvmpAIiofjLgbGDIJixg+9iEVts=
X-Gm-Gg: ATEYQzwllSD8LaggjcMKAGopFufxSrzdDpr/zJZheRnZKZMo5Zohn3j8LD7RPZyB9KS
	nkTO6pdZ+1cOdXPsQI2CWrOyruFVv2XvkaVf2xdiCvh1BRykFfCSW6XxdP1P3hBNOFMEJVpaS6A
	JhoKCnh4JzBOVqVe1luI/KIwiUU1zZeJvmjq45fCpz2Midbad8rF4Z30+B/3d9aNRI7ma3jUDD/
	sOswL26fveWzoD7IHisA6EkRQgR0lnWPUyKXyA8jtC/CHihl3WKU3WvtWE8/9I5imhr+YuBo3db
	nSAQ4jTwLJc41FvjE5oHhLDtfKEb/YdVwqrMdT/25xoV
X-Received: by 2002:a05:6102:b0f:b0:5ff:fbe4:8a7 with SMTP id
 ada2fe7eead31-6020e52bc2cmr4525326137.24.1773677569597; Mon, 16 Mar 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 22:12:38 +0600
X-Gm-Features: AaiRm53PnIFKVZg8YyfIZR4HMQW1Q6cca8fQLreG4GsNHelMK8lmfHxNIAUkk-o
Message-ID: <CAFfO_h6iNKbcKUi+Em2emRvXdZCfxcm7HnCenpTg9pSsHMb6YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy


On Sat, Mar 7, 2026 at 8:07=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> The following filesystems have been tested by building and booting the ke=
rnel
> x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR=
 that
> regular files can be successfully opened and non-regular files (directory=
, fifo etc)
> return -EFTYPE.
> - btrfs
> - NFS (loopback)
> - SMB (loopback)
>
> Changes in v5:
> - EFTYPE is already used in BSDs mentioned in commit message
> - consistently return -EFTYPE in all filesystems
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - atomic_open codepaths updated to work properly for OPENAT2_REGULAR
> - commit message includes the uapi-group URL
> - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v3:
> - included motivation about O_REGULAR flag in commit message e.g., progra=
ms not wanting to be tricked into opening device nodes
> - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
> - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 0=
60000000 to 0100000000
> - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O=
_* macros from hex to octal
> - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v2:
> - rename ENOTREGULAR to ENOTREG
> - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) an=
d in arch/*/include/uapi/asm/errno.h files
> - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.=
h due to clash with include/uapi/asm-generic/fcntl.h
> - I have kept the kselftest but now that O_REGULAR and ENOTREG can have d=
ifferent value on different architectures I am not sure if it's right
> - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-=
dorjoychy111@gmail.com/T/
>
> Thanks.
>
> Regards,
> Dorjoy
>
> Dorjoy Chowdhury (4):
>   openat2: new OPENAT2_REGULAR flag support
>   kselftest/openat2: test for OPENAT2_REGULAR flag
>   sparc/fcntl.h: convert O_* flag macros from hex to octal
>   mips/fcntl.h: convert O_* flag macros from hex to octal
>
>  arch/alpha/include/uapi/asm/errno.h           |  2 +
>  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
>  arch/mips/include/uapi/asm/errno.h            |  2 +
>  arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
>  fs/ceph/file.c                                |  4 ++
>  fs/gfs2/inode.c                               |  6 +++
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 ++
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 14 ++++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 127 insertions(+), 31 deletions(-)
>
> --
> 2.53.0
>
