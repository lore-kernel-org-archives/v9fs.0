Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F232E134
	for <v9fs@lists.linux.dev>; Sun,  1 Mar 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374633; cv=pass; b=SiDVM8knc3QeWVLEVatOaQdU/KyjhGRkzHDE5vxnx7Eqwo1VhqwMmPnH3k/wBLtVPL6EpitALcyZZNR2fVF9qxOjJWafdyB0WPQKs+NZPy/VpdC8fIqYV03QqDyt7W+4pf9CDsJOZSZITVXKX/nGr+Q79Iak0BJGPhK48e4y45U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374633; c=relaxed/simple;
	bh=SMxg0/OH4xIlvKgwlrN+FwO3idaXn0crhP3eBKT/aqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB+A6yYFiK7YQWISe9i5StYfSc+loaT3wCbqfoxoANMYGxGlWSKw/IlSZ9Lxsu1/Rk6zWPNNFie/3OgIKSbjXUKw4dUYuwFRwtuABRNimIeF0Vz/7r3JoVI7Jl35lJvmt+IoJH5pa2td0bw6ZbbTphwrZHlq/WNIeZKH7OiIWI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/oXBn0z; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/oXBn0z"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ddffda372so3298152241.1
        for <v9fs@lists.linux.dev>; Sun, 01 Mar 2026 06:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772374630; cv=none;
        d=google.com; s=arc-20240605;
        b=Xd+4Jde0MIYCUDD3xnEd7hX928NfDhsQwbDiKu4jLHt8cWKgtkEqCpc+VzwPAimB5i
         x9cfMT6YfrChfazYL/iRLCIuTnrddsHhnvqzMpZ9uRt8xWitmcuuu1kFPIjDIwi14ZJT
         tRqmhHNLn01zLcXx5EWHVrnTVSyVTDBOEnMgW/smF5NqbRJk33hfM9mFcwbE0pFFUPkd
         APSXFT1dNZ/dYtVwHYvuxlIcAYGBhLpO0gVug/SitFWOJ78AYVXx7jp3dedNm6oy+Lrm
         hbev2jKP8aOH5eJvqMH8NL0LgmgAN0rH8VuPbyxpuFBqqR5wms30/W3KEXoJ/aiEF37H
         Jdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        fh=wv26apM9EtfaHgHpCt/wL3yi8bgnTHRxoeAyeOPm2e0=;
        b=PE0qb6BzcBji4abjKo55QOYWFQuNDBPIEfmA0jFWh/EPBbZbyag/QCUOOmA+FRs+qd
         Q4/4L91FRQSmTDpA8WdX7ik2due55944sCvyJsFAJ2LNYwaL77dcMIbC8s7T7fA5HffK
         XPRR+Mkg0Yi6SSi7by0X9FV9ofdLlkvZURbO8WVplDnpiLgffSWHxdw54ZkJ85VsYTag
         6WkwiTAWNZs27pLf1FnCQ1/1BjqZxHAO+INHqBOqPOMVwfh1GtTMTF12eW1/6snTapoX
         OrP2WiEZ++1BZKZNVxtkSIK8n7YhFskgZpMccKQxNnTaScV2MN7xbVIiIveYXln06RCy
         vp/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772374630; x=1772979430; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        b=T/oXBn0zmxV3p5d1+n8T3CCuOkwEIVMB9jq/fPGtJiBgY773/2W1gyHsw7pd5A6nkg
         4UKkgyg9JP33CDnhXwpdVUC1MhIqjqqBODBOcgYjtrP0zuY5EN5b6Kdvq5vQpZSSYiMX
         Jdx3CfTUSYl1FJFf/D0Y19S3SMhvJGtoDWRkzLr8SKqNegWdaVpOUrXsZmDszKxflo/l
         sCQ8D25aI43Lq2wZHpAYOwptlhrFia+B2gKvfY4Z+YsK49E3fedyHi4tJQeRK38JgWkT
         cHaB3aiw8vtYqtSgV/djuSuKLh4A19piXszPea5sM8Mw0cAqhLXHxVwPwIvou9OAswCZ
         /VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772374630; x=1772979430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        b=CjmSAduaMV6skh/m8P+wMl3XUWWnEphrC5VcHUmITVH3gPzYjzVHvWfA2jSK67v9d2
         mJkMtSBagXFJPf7UDW/FOIGPULIpwbaVQ7P5kMbbnI10ZT5cEjPjoSQ8+Tq28TsebAkL
         UMq+yZlnHOJLbOF9jsuQxWmOPsFeu841rECFvTlfyw9xNsFFxc/YjGcIDfVWJ2tBjLU5
         e4ur9hie2yPqYohv2gCLTCGZTkebeQQzjFfEUE9m/KsZCQpgO6M04mITAy4FVi00nJxL
         JW4n0Hb/srp8jXlcLilb1CguRe0jjBa7asAmoh0WIDpwyB9OEIGbj161t5S0nS26gqYe
         d8uw==
X-Forwarded-Encrypted: i=1; AJvYcCXcSS0qD1gH+H1nsKt6UnkWroJJFviv078w1dh/u15DcnXnNyU/quyifx9FC0vm1apiJK9n@lists.linux.dev
X-Gm-Message-State: AOJu0YxpBJMqH90WQnLvzvP04RVCCB+0UJlzfuZqYCneG1QR8nOcBHIf
	hlSwMU8jHrAl2ki1XqO+ZA9NykWb3l3q3uLjW7udK+Ju4fLR19Y6iCk3P3Y5G71DxYw+ei1g/dH
	ZLJRDecfE3U6GzfymQK4e1d+Dt6dY4kA=
X-Gm-Gg: ATEYQzxTn0Mt3uLEMxRyBLlaG8lNGZT/ixJC8TK7X96ge/LQNWk3+xtSU5h3xupiA6c
	oJtvLuk07vmDmsjbptuK0tmtQmOaKw91q9F+jmsF+h7++6yadZng60Li1bxdBwva1aKMtKrAeQ/
	qOaFJfcNUkNhHRyiaw3wQ2E/qT9cxkvJbx/QugoeJK+rZcXoRP3Hh+0aSRhDkdOCbms3kAPVKgb
	/M3zrGSX53LGZAVHWNStQjSQZhn29tKSwEv5H9KBGA/8MUB7+auYpn5N7hk0S7FxwoD5mc6Lhci
	/hYJmlYEUA+hjPDHCGhAHBQjkcjI9IGUgKMshpePc7xL1sqRXLuj
X-Received: by 2002:a05:6102:2ad0:b0:5db:d36c:89d4 with SMTP id
 ada2fe7eead31-5ff33481927mr4431039137.3.1772374630288; Sun, 01 Mar 2026
 06:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
In-Reply-To: <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 20:16:59 +0600
X-Gm-Features: AaiRm523Vu6ZFdfEO8O_fCfURMW-nzweMn1jJ9AAv3XTYzZCngEPlvc0eYJc-g0
Message-ID: <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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

On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
>
> It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> When an error code is already supported in another UNIX-y OS, then it
> bolsters the case for adding it here.
>

Good suggestion. Yes, I can include this information in the commit
message during the next posting.

> Your cover letter mentions that you only tested this on btrfs. At the
> very least, you should test NFS and SMB. It should be fairly easy to
> set up mounts over loopback for those cases.
>

I used virtme-ng (which I think reuses the host's filesystem) to run
the compiled bzImage and ran the openat2 kselftests there to verify
it's working. Is there a similar way I can test NFS/SMB by adding
kselftests? Or would I need to setup NFS/SMB inside a full VM distro
with a modified kernel to test this? I would appreciate any suggestion
on this.

> There are some places where it doesn't seem like -EFTYPE will be
> returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> cases as well. With a new API like this, I think we ought to strive for
> consistency.
>

Good point. There was a comment in a previous posting of this patch
series "The most useful behavior would indicate what was found (e.g.,
a pipe)."
(ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4dxpb3=
n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
)
So I thought maybe it would be useful to return -EISDIR where it was
already doing that. But it is a good point about consistency that we
won't be doing this for other different types so I guess it's better
to return -EFTYPE for all the cases anyway as you mention. Any
thoughts?


> Should this API return -EFTYPE for all cases where it's not S_IFREG? If
> not, then what other errors are allowed? Bear in mind that you'll need
> to document this in the manpages too.
>

Are the manpages in the kernel git repository or in a separate
repository? Do I make separate patch series for that? Sorry I don't
know about this in detail.

> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> >  fs/ceph/file.c                             |  4 ++++
> >  fs/gfs2/inode.c                            |  2 ++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 +++-
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 11 ++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 55 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/u=
api/asm/errno.h
> > index 6791f6508632..1a99f38813c7 100644
> > --- a/arch/alpha/include/uapi/asm/errno.h
> > +++ b/arch/alpha/include/uapi/asm/errno.h
> > @@ -127,4 +127,6 @@
> >
> >  #define EHWPOISON    139     /* Memory page has hardware error */
> >
> > +#define EFTYPE               140     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
> >  #define F_GETLK              7
> >  #define F_SETLK              8
> > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uap=
i/asm/errno.h
> > index c01ed91b1ef4..1835a50b69ce 100644
> > --- a/arch/mips/include/uapi/asm/errno.h
> > +++ b/arch/mips/include/uapi/asm/errno.h
> > @@ -126,6 +126,8 @@
> >
> >  #define EHWPOISON    168     /* Memory page has hardware error */
> >
> > +#define EFTYPE               169     /* Wrong file type for the intend=
ed operation */
> > +
> >  #define EDQUOT               1133    /* Quota exceeded */
> >
> >
> > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include=
/uapi/asm/errno.h
> > index 8cbc07c1903e..93194fbb0a80 100644
> > --- a/arch/parisc/include/uapi/asm/errno.h
> > +++ b/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >
> >  #define EHWPOISON    257     /* Memory page has hardware error */
> >
> > +#define EFTYPE               258     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include=
/uapi/asm/fcntl.h
> > index 03dee816cb13..d46812f2f0f4 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH               020000000
> >  #define __O_TMPFILE  040000000
> > +#define OPENAT2_REGULAR      0100000000
> >
> >  #define F_GETLK64    8
> >  #define F_SETLK64    9
> > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/u=
api/asm/errno.h
> > index 4a41e7835fd5..71940ec9130b 100644
> > --- a/arch/sparc/include/uapi/asm/errno.h
> > +++ b/arch/sparc/include/uapi/asm/errno.h
> > @@ -117,4 +117,6 @@
> >
> >  #define EHWPOISON    135     /* Memory page has hardware error */
> >
> > +#define EFTYPE               136     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/u=
api/asm/fcntl.h
> > index 67dae75e5274..bb6e9fa94bc9 100644
> > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > @@ -37,6 +37,7 @@
> >
> >  #define O_PATH               0x1000000
> >  #define __O_TMPFILE  0x2000000
> > +#define OPENAT2_REGULAR      0x4000000
> >
> >  #define F_GETOWN     5       /*  for sockets. */
> >  #define F_SETOWN     6       /*  for sockets. */
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 31b691b2aea2..0a4220f72ada 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct den=
try *dentry,
> >                       ceph_init_inode_acls(newino, &as_ctx);
> >                       file->f_mode |=3D FMODE_CREATED;
> >               }
> > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> > +                     err =3D -EFTYPE;
> > +                     goto out_req;
> > +             }
> >               err =3D finish_open(file, dentry, ceph_open);
> >       }
> >  out_req:
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 8344040ecaf7..0dc3e4240d9e 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, str=
uct dentry *dentry,
> >               if (file) {
> >                       if (S_ISREG(inode->i_mode))
> >                               error =3D finish_open(file, dentry, gfs2_=
open_common);
> > +                     else if (file->f_flags & OPENAT2_REGULAR)
> > +                             error =3D -EFTYPE;
> >                       else
> >                               error =3D finish_no_open(file, NULL);
> >               }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 5fe6cac48df8..aa5fb2672881 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
> >               if (unlikely(error))
> >                       return error;
> >       }
> > +
> > +     if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
> > +             return -EFTYPE;
> > +
> >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dent=
ry))
> >               return -ENOTDIR;
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index b3f5c9461204..ef61db67d06e 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct den=
try *dentry,
> >                       break;
> >               case -EISDIR:
> >               case -ENOTDIR:
> > -                     goto no_open;
> > +                     if (!(open_flags & OPENAT2_REGULAR))
> > +                             goto no_open;
> > +                     break;
>
> Shouldn't this also set the error to -EFTYPE?
>
> >               case -ELOOP:
> >                       if (!(open_flags & O_NOFOLLOW))
> >                               goto no_open;
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591ab..1524f52a1773 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> >        * values before calling build_open_flags(), but openat2(2) check=
s all
> >        * of its arguments.
> >        */
> > -     if (flags & ~VALID_OPEN_FLAGS)
> > +     if (flags & ~VALID_OPENAT2_FLAGS)
> >               return -EINVAL;
> >       if (how->resolve & ~VALID_RESOLVE_FLAGS)
> >               return -EINVAL;
> > @@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> >                       return -EINVAL;
> >               if (!(acc_mode & MAY_WRITE))
> >                       return -EINVAL;
> > +     } else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
> > +             return -EINVAL;
> >       }
> >       if (flags & O_PATH) {
> >               /* O_PATH only permits certain other flags to be set. */
> > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > index cb10088197d2..d12ed0c87599 100644
> > --- a/fs/smb/client/dir.c
> > +++ b/fs/smb/client/dir.c
> > @@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, str=
uct dentry *direntry, unsigned
> >                                * lookup.
> >                                */
> >                               CIFSSMBClose(xid, tcon, fid->netfid);
> > +                             if (oflags & OPENAT2_REGULAR) {
> > +                                     iput(newinode);
> > +                                     rc =3D -EFTYPE;
> > +                                     goto out;
> > +                             }
> >                               goto cifs_create_get_file_info;
> >                       }
> >                       /* success, no need to query */
> > @@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, st=
ruct dentry *direntry, unsigned
> >               goto out_err;
> >       }
> >
> > -     if (newinode)
> > +     if (newinode) {
> >               if (S_ISDIR(newinode->i_mode)) {
> >                       rc =3D -EISDIR;
> >                       goto out_err;
>
> This logic doesn't look quite right. If you do a create and race with a
> directory create, then it looks like you'll send back -EISDIR here
> instead of -EFTYPE?
>

Yes, I thought it would be useful for the caller to know what type of
file it actually is so I had kept this the same. Let me know if it is
preferable to return -EFTYPE always.

Thanks for reviewing!

Regards,
Dorjoy
