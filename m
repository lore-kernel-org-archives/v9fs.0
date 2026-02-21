Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440D244679
	for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688981; cv=pass; b=gnRjrPgO2C2NC7+E2HKB1lhjzUk7j4EmuK9oXV5oYgQma59IXp6Fo6MluXkmsM/xUNxJBfLPpJH2VODMufk5iT1maL5aDoWdldNTnDfvnf7wAtQQyvMqVuProXNx59tmCJ77M4N+qg0YC2/lgjDXXRjGR6DRXoUc+BH2m705RcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688981; c=relaxed/simple;
	bh=23P6V3/EZFsgY+c1DhMXwm+sT4gSINYfgO8QSA/c/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EX2TGw/Is/Q14l96xhlvgaBsaUw1MoYdq2jo423qz3Xa81JfibPDD5DM3wmHSyaE0COIEZUR4ZpnxKPYJ122EYZhhkrMXqDFP+svHw4XKOYVCo2YHruY+h8+HIpRhsTtrqtVw70FSmF2cYRi3eyZG5ur+PPOq4mKI/ngfKgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZtwSLXZ; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZtwSLXZ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94acd026e45so682139241.3
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 07:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771688979; cv=none;
        d=google.com; s=arc-20240605;
        b=W+S3s4k5vXft80rUUphSO6laWxLM7UVDGHmnh4jmAhtCamu8uT7mx+qhNqNTWEocTn
         JWjOJP6zLwXlN8O7OO6jzakaHPPROm4Eylb4tH6pBA70lG+EJttHY24LZVrPJvpTdF8W
         eQDH63clYvMCSTAiBD0jeCsCzCo5wGgCYs6eciBneV5CH/FZ39838vhJSCOFaPVQFhFB
         6jgYXHuBdDVPfp+8i+J9sPYdeT+927WWGMdl+H+q69GfsEGENUJRsRlRv32L5FevdPFD
         0A56dmlsCtfoaLeTeaF9e9kHgKekSff7nGysNBYuHRGXvfBRwb3WZkQI4zpeLfq8lQzF
         AxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        fh=BxA04w1L5flZoP34JCAwo+kCAfKTHHY5IW28E2xDkCw=;
        b=VyVFr4Uoaq8LEpIVwdWxfhuCcSzOqReQHobWcUW3k3Wxmd8NQ1IMuc3Ek2ntMyZr6T
         TKwjb7p39MoZvxWFUv4EAUzRSRypPMI44H9QYqMStWCTXYsVnxxc59N9RFk1ZyGpW+ld
         Gi2CWh+jVLoq5YV9KRQmHu/n2tvxwk7kcbmwI5mmuitxJTTRXSoWQteowxGYprSVCAMY
         NqvVBPPUymmaNIUVU+wco6lki2x5U3YAkADI9BNsGRGHyEJY0SBc440Xj03FsY9MwIM8
         PoIXaDFmuSEAZ7lbesPMyd8lX3m+QOmLLp0kYgpTYUOwNxX6pAl6Urk3ssz68qVt3l4j
         FA5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771688979; x=1772293779; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=ZZtwSLXZvtS/aNr/yOjUoSzVUnWrBpVrC0GMEhy02Hl7+uAE3Tl6um2JQ2wMCj0upP
         jOlfwiAz+BOuSglkTpF/Opw8SmrUdk4qMpqy5DmyaI0RgYd7WB671Ze6vQJxXf3NZvEe
         6N1mA8ZwAoN7IghYkp2HAOA/YWl7rS1ReQi6nFlibhMhcd/aSP//L6lohhd0ZszN+WXx
         eDYGuiOYvYJZXrUSrudb7IoKSQLmV6iyl0G3dKnzEk4pCBLQHbIMu8gkrmc3gZjhfBa8
         /QcWrwbwghl6RNuqkWAqnIa6jHI+0VigkYuQPlIEv9z+LV10ov0CRwXrOjl73tmg2MAl
         jAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688979; x=1772293779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=eum4c2l+K/T3WOCJTRSZCSI7nH0O5ju90fonUKHBpD3IJ6Zpn+Z4lyhCSoI0hM86Na
         js+7fH8YGs0SCaIQmqyFQa9o5BE3cta5XcsQCtXo1mSVphN1MqG9m96FcYG+mi1ro45s
         3B/ZAbEXrH4cXZ3/YUAzMu5Jf6HKbvZk/WecELf9sYvOMe/kl4kXyCh0UGFVFGGOvVoX
         rcPRpfysPfRFnoY5JIXEWp/ONTmh+xDQgf+Ji3yeKL0sMLkuAv5ULiAbXv0qWSuGCmSh
         kkc1giTo3E1qQuRcQhtD6Ll/xDihjpKFw1T84KXHszvESjwWqW7CYW7WD37hylUrBSAY
         z9dA==
X-Forwarded-Encrypted: i=1; AJvYcCWzFs00r1ZmRpD42NLeQF0mnAc+Pev+iyTy1knkIdqsBopoMxFDfOVsaGv+IrQb83SaJ8WD@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr+ZnmUVmrUNG9eioI6bsnjPSLctJ1bZlw363LGWpyBeNpJMwx
	7ccCtiRjrwx/SzYVk6biLxOwi2428KSLVA+FdNzRmS0w/OEJlbblBu4EpTxIKKlg2yPLTrVjYuo
	5id9jNF37a72phZoU0TqTRO3Tdu0jjfY=
X-Gm-Gg: AZuq6aILi21EhcDGa6FCCDlzzNbXBzCZZ9gciwhQKwSvalcqddG99/2OPsLiu0QzzsT
	th1MxfUZHzUNcegM26nKbXGd0/GhWI5n8tzJCcFqvADezL9ujFYNH2lEiqmQQ2vZo7qHJcROxzX
	TQI3/STWDzGqZ0+YzdUu86KmkNVNC+knfu30d+rqq8FPtm2AMNzLgrDpCMd7Czg8+RI4Lc6jHCT
	uJsSAiPF55j6wxEvqT4zrZJqYNgDbkeafYIrMbA0NUu/A33yMjeldMNF1A7fu26Zxg3/LJeYn/0
	lt+JgTrbsJDRrCtTeEduOnrQ7zPcpwJRvc3LhHv0O14=
X-Received: by 2002:a05:6102:6cd:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5feb30aa44cmr1230671137.29.1771688978916; Sat, 21 Feb 2026
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 21 Feb 2026 21:49:27 +0600
X-Gm-Features: AaiRm52uxICzwXE4h2cG-NB71vMvoLaBUhNK0X1besn-bhoE2jLckvjHX39jcu4
Message-ID: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
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

I am not sure if my patch series made it properly to the mailing
lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
The patch series does have a big cc list (what I got from
get_maintainers.pl excluding commit-signers) and I used git send-email
to send to everyone. It's also showing properly in my gmail inbox. Is
it just the website that's not showing it properly? Should I prune the
cc list and resend? is there any limitations to sending patches to
mailing lists with many cc-s via gmail?
