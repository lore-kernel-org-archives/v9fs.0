Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5C430BB6
	for <v9fs@lists.linux.dev>; Sun,  1 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360186; cv=pass; b=PCW58Ts7tG/KZpN0/2AKI5rLT4xh0PbtYd60EqnYIU258mC0HGMAqhOcTXQhi53QGcKclqT5dvBO4W6tfqSfJ149J7IX1QkxdiGteuqFyIf3hwgMK8d4ZwWwgUSJDSoOpbrPc7ZSmxoQvuadskQtb/eaojHxQLSPjOvBcUvqN5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360186; c=relaxed/simple;
	bh=s7rfjnPtFd6SU6xoPH3SYe9hNrVk5+6PWUoUYgGCnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQniZ0UHdc0Yizy9PmPTEGDp2OFhJKPCRjfPV77k/T8NkaKK0CYx4j4zfGA5VcMkTwo+u5cw5fnZth1nOiTaprVbahdfzXNqT7JIe/4JZ3QxORvLoWArORPsJUlqNitaMaFUbYxJ6pFnwY0h2lbZgVbGApa2k7Cxz2NrjD++9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCjkP2Rw; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCjkP2Rw"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ac5cb71feso1000589241.2
        for <v9fs@lists.linux.dev>; Sun, 01 Mar 2026 02:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360184; cv=none;
        d=google.com; s=arc-20240605;
        b=FsWROvny3V1ZetfT8NdiT9/YKjt7jJLbzh+npePl+Bqra7Qjlg6Jp7aUUoSDkyDlUH
         vp1CAc9ndN53+gy15swyeipcEvRA5iNp3/bHpw2DA8ZIDH7BD6mSUVq7PJ6Ad9Dt29jg
         1/9wI6orsHaPjKdgzBlofO0/hQ/XhlorstQxf/P1WV2EEb5mlkbdEaqSXiXH8hi7dL7K
         hVD/cIfeom/G8xqlXrXMOSvhPhnpJUbSHsvFNfQjV5p8Zvbu1+ZfHRagSRFvTR4+tA6T
         kiKni2fRzkdgWvuEyS6LS7PfCU/F9ZKLObqB4aulmvWxnF5wLBlDLk/yqME/axi80uuD
         TQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        fh=mFb9l8P46dy2kJdmWMJvp+LgKinSM0Y64E/YhKFGcoA=;
        b=IX0qsEOeJjz+ID0cIBfKNl+lsOXXDgX8svRd4TjyAc4DKUVxQ/O47+USWQSkeiTglY
         DFjvsesl5wodo8j9pxXKMOp6f2Gp2u/QG+69girRslgvhktrbJNkdEYZjE3ylMVBM8GA
         ZXLnexAEmRIap/5roavwgPg3J/EqDpA765FVZ/73/A713PJ9Jc/GD0vZTu44CkQc/gCL
         j8bYtxq1gLK6ts6swI6Nn9ZJXhwIPRPcfEW8NV1uK7lNp4JEbDQ8kl+oH89kCuNQAdSe
         dyoXloBOZuwsQesup4OAfmn9+rnrktYCGzHahfPYZwWlAKiMq/2/ISqtuqrLMligWQ8j
         C6Cw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360184; x=1772964984; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=cCjkP2RwvAsAb49uZATP1ijH2pyg4F7PddyreINN7A6VO2kSqw6i4NBoUzC8MNkQAh
         nP77TPevxGij4La/+zzEWGdhL9wpgNpvSFriVvoEo7ZHUEYIYj273RY8bY5OOlJpjiLz
         n010zgvbiQvySKUtxKTRd7PiDMG2U92djirLYQdtOwlfPdnZNZXXTMdI77dcjQOpdz25
         05irLPwS46LddEzaKzzGJ8HLqCuqKwsVod+3l5qY7sMGsf45hzepTedwGbYEXzfJXBfl
         CuEHqfCSNdgSJl9Y5XCzwAw/4SETHNTOIqseTyuR80nPtAihDX+zuP2rVG61rOC3GQ0q
         w4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360184; x=1772964984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=YI6wqz0sy2hUjvgR+QQAzrZPggUfEfamYibzvPri2F1T3QDd4tJkGMd5RjzqjwIoU2
         KF1AnM5p5xNvC0IGgAYej/yG29sNIrlNqvCjLijyLN4BThTXSxiYEUrAAMqFsWGqgkRE
         lVRWOdwkJ+G94OtxFg4DVvMKoCtgJH40Lad6hqMsPvvNMdHmrM8KlWokOf9hpmh5U/OL
         1vOxjCmb1kRSHjjwQNCMXmfaiQMqHDT8TmfFK8cC2ty3eqKUOp2k1XPVjr7vHNjPH4H/
         LpUmXHjOMz5fGhSGqCU/V8RrfwBuEFirmPJJ8KfF5rnGsB2e29nK7BVLByIcd3PYF47K
         dA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOMso/i2c9h7MaOznJcYZnUghPR2B/yFb19hcVgjHwQzC9gCUjtbAwXL4wbF1C7DhFEvL3@lists.linux.dev
X-Gm-Message-State: AOJu0YzulCFOBrVsEgQ6ZpzJvIRHK2NoVjnjwUTMVVYbfshbZKkOmMKi
	026d/zL/Dr+dzvmkkjSDV0lK3HJdEza4FQyp7/DwHMaAoUZ0icqnPBH/yPVxX13i6D6H+sYwHlw
	0rYV9PODheQwE4e7nRMNvhDXAsJgwBvU=
X-Gm-Gg: ATEYQzxrWztYmB3l1TyXEbWCJz/lgh/NQmdnwfvYa+RIqyvhL21A5Sfcx3BjGOaCl1W
	fnkCRcugpLYOPoII9GKsghECTlQgGmDjS6Bo1D1ABvfEH43LP+u+h/S4VOLUXiQIkyMaHpyj2Ry
	amGf5d06Cnqkpp6Rj6EpGRlPs3t3DCKROuv/XAEHCIxZTo/7hKRj0gL6YeOTVaPmNC6XaRPbyU2
	nbLEALPesCPjET3Z7zSmPCbu5yWapsBEUL9f6Q1YdXrt0zJV8hnriS5YsYoas3wXETB5C9p+HNT
	gHzGzKBXuBUme0bDEjQgESRjYxwzOnSfjtVHhfCXzg==
X-Received: by 2002:a05:6102:5091:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ff322bf4bdmr2863289137.7.1772360184080; Sun, 01 Mar 2026
 02:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 16:16:13 +0600
X-Gm-Features: AaiRm52S_i7uxGvz2GvDZgmu6T0jp37pcUwvZrAaDhnW-l9lgBlZerFtvlbrSME
Message-ID: <CAFfO_h6Y1QcW7mNGdCuY-_J6zrF_F8aW+Q8O9SvoBbXTxteFjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy

On Sat, Feb 21, 2026 at 8:59=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
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
> I only tested this new flag on my local system (fedora btrfs).
>
> Note that I had submitted a v4 previously (that had -EINVAL for the atomi=
c_open
> code paths) but did not do a get_maintainers.pl. It didn't get any review=
 and
> please ignore that one anyway. In this version, I have tried to properly =
update
> the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs=
2,
> fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
> (fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, mo=
st of
> the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |=3D=
 FMODE_CREATED
> for the O_CREAT code path which I assume means they always create new fil=
e which
> is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead=
 of working
> if path is either a directory or regular file) as it was easier to reason=
 about when
> making changes in all the filesystems.
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
>  fs/gfs2/inode.c                               |  2 +
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 +-
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 11 +++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 119 insertions(+), 32 deletions(-)
>
> --
> 2.53.0
>
