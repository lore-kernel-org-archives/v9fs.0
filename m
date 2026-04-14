Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76473F0746
	for <v9fs@lists.linux.dev>; Tue, 14 Apr 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188046; cv=pass; b=G1eImIinUB53zeWU5C2Lm1PJZO3EZlk03fJ8v2OnaMUckqgK6cxXQw/wOaGKiQ6f3r5BLpZmRdw/fag3nuj74Wa+AwmqyIBejcMpHOAZ8ovJMx0dOnVljp2g4bg0Zfxgm3B8unWBjMBUMaZVueELPsoIirfDIjX/vOM6GgHnQJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188046; c=relaxed/simple;
	bh=aqzzp+0vLBh3YuoQvULxfP8uzdG3c/fQ3+lDAhEwwZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvLK9TxrXshGMbpDcr0J+EUMzBh1GraCspbwTG3sA6bTeOplc8ZLdkuZTRbViDa5AVGWE5Q4hUl1V1fEaNIETyxShNBnmTDE9nSPOpgJHYvBtVlINhtGyJrCt4v7bQiIQ5M02QzJTDavyscmHqJNUNYlS+ivC7S2qsixKEnAu2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGJS9aqo; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGJS9aqo"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-60fea0840f3so1279939137.0
        for <v9fs@lists.linux.dev>; Tue, 14 Apr 2026 10:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188044; cv=none;
        d=google.com; s=arc-20240605;
        b=BDLdiKbvgEp0A7iTP8lZccGdA61aA9lmDvkGR3Dvcj/wpo3TMubBI3XGeuszqm4epM
         Tisn4l2G50UdRIkyscwdPNrBmEUu4x27geo+puwannyRlOrQX+0sJipoVlJ8kha67Ppp
         krXfZpT8TQj344t4OoclEoGa4kJdZboJYwZSOMN9l2rOpNSQI1/5xtUvorpltclgDR3b
         f69x+GTjQpDbj0VUwmrLJX8WFEY8oocYZXvyqTlQdZpo5suE5t1vxA9BqyTTJbFWinSq
         SJUdSqfKEJVkQvPyjBkZmvdgklDQhXyhgntb0Mr+6MD4M6bjJCeJtWeHT2mOpkAEj1aK
         fvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wipA6JR7QuvB/7F2g+7cyOg5TyFlmr55ecUXy0B0Xes=;
        fh=Py7x2siVcf5WLi2jBwFFPJYRdFH0hZiDxRCJDxvdsik=;
        b=ZzljDMjoHd+pjMqoB5sikmL0mzwEuzEw4sTIkPzDSb0PLqf3FWP/PFubz6k3c/K5n8
         sdfITyxsVomjFpqZzoklSicTvW+g+jhbqTnEg5rRSqfm+i7WtOeHj8MMYK7lUWLCyo72
         otkQ22nFm0FB82/suSalzyKQZt+9CpgUp6cuzi079gqHrUhwsc6sKII0aF+PeIr+MokQ
         g51QyTtba6pOEv2kfK1ifRvWG+2uAq+EUuq+2p5KYt8kXMNDDOWexBhyXy7TYg0prWF0
         qL9RR59VD0ZE71AGemn509xww/QrlvT/d5N0fAPhG4A3kg+HFRJtZAWErQC9eVn2mj/M
         z3UA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188044; x=1776792844; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wipA6JR7QuvB/7F2g+7cyOg5TyFlmr55ecUXy0B0Xes=;
        b=FGJS9aqo67H6VJNrSfvAmMWZ+z7yYXrt7meGndoUbkI73NLVCN25/fPJ72lS7rbBui
         yorXe3J5Sb1w9fpnEvNvVl+7cdmwl6kjuFvc9Rlpg81o1Wa0BOS6L4tPzLrqKi7y9+3y
         44woMpKE9aCK3tLIwgVHhWBYiUT9qBucCOZe0VAl3ysvTDzSNWC8ZIOsnTxjSKe3vzI+
         vRsYEy5YZszNcxTRoYxD6+UQwYzaDc+pRZySrgkM5H91cgeAb2O4ECYqKgN55bFhKIju
         ExkhOyhcIUl2Jgq3FXLP8omT5L8jWZA7NY2a35kPqLqmx5sll8Lbw5En6W/MxOw+cgO6
         23ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188044; x=1776792844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wipA6JR7QuvB/7F2g+7cyOg5TyFlmr55ecUXy0B0Xes=;
        b=d0CFb2EEPa6CKQPJotMuN7YXzGcQh+gtYYa0zQsjA7Mpt9/ukdPzYSnqFSNXY+OP6/
         kLSe9Xnzqw1EMoenXR1H1onI7Eke5m+6XaHkI5hMqxfjTGzM+hLzej92+4wZYK4+4f29
         MvJowwgSG0LO7O4sq7tqcz8Nz4IDbQrrbxh7/csM6F34ieskhEwc2WtQsgE7ia/t8GxZ
         s8btGhfezYhWs2ihQzU4YQzaBQtNsXLqlOy7/v5ALuyJ9BYgSXkmoO7fTRPobJqUrmFj
         mHMqM2388vMgwdp8tx4b7qRKx9Kj3n8R1j4DdWjzkfgb+ZpYrmbxj7lRbvjVaxsJ9IJe
         L6Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8S4goWZXj1R3urpuTPET3+10ycw5mvxWG0LE07wF0cnFT17FxidCNdyEhVeCRHMUZRcocb@lists.linux.dev
X-Gm-Message-State: AOJu0YwbQ+wJblm//AjQAVecF9VnOvvQ6e+x2kbQ7S/c6xTY1id0kZgi
	gP1S7Eff2Wgp6U4Gh2/k6NO0d3kFFhPJ8iqAoo5jWsYnEKQYavkoAQ/GBUQj7TZbSMh7lsEZZsz
	6m5l7BoG4ABdrgrldV9Vc3AxDIjVPkDA=
X-Gm-Gg: AeBDiesrk6aJQl6OkT/sHhJm5YxL14tnfrXkVe3IpECLS1PkBrwdWbH4td4GFnBrRVf
	BZZnYuDGZgml0spmmtPCVpqIsmT2EQTyl5ZTfSdHgiV1VKRXMqSbbRZrrHMvsF5kB+yWt98LX+V
	it3nKzRC8r7KDpU8WifCtRvnaOnKEcdGAqyCOCCrdjyJ0ir1WK5U3H6NU6VfKmHvAv7BMLE/zgH
	1F5Bc6vP6ltbNrtMh3gerS7mOMDDnKo3uJFL5uJSUmbHlv3M1ahYsfaa1h51eWmRUhPgBMl9zdz
	31EtnZT4aCyPWmi6M4Kwv9AlbchsFhnXQ9GRIvfVFg==
X-Received: by 2002:a05:6102:c8f:b0:5fd:eacf:27df with SMTP id
 ada2fe7eead31-60a0aae09b1mr6274707137.10.1776188043491; Tue, 14 Apr 2026
 10:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
 <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com>
 <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
 <CAFfO_h4dhsXji=+FjO9EikX0_oUUDkWe8tC1F7u4WqhNAjRB=g@mail.gmail.com>
 <ce36e877adf7a639bc4e61090d148c06fed63bf7.camel@kernel.org> <CAFfO_h5FOTv-VMbh2Dmwkp04BFxQu192gsvFLohDFXAWPccRNA@mail.gmail.com>
In-Reply-To: <CAFfO_h5FOTv-VMbh2Dmwkp04BFxQu192gsvFLohDFXAWPccRNA@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 14 Apr 2026 23:33:52 +0600
X-Gm-Features: AQROBzAPq6lrkXdB5aGpvZdh9ex-ri9hhZLo6oK5cSe7bhKl-nNcQlGucluVdVQ
Message-ID: <CAFfO_h5hZ00XAOY1Gen+HGLDNSWGz2PH_H-0YspOkuaRT1ULsA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
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

On Mon, Apr 6, 2026 at 9:30=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> On Mon, Apr 6, 2026 at 5:27=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Sat, 2026-04-04 at 21:17 +0600, Dorjoy Chowdhury wrote:
> > > On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > >
> > > > On Mon, 2026-03-30 at 21:07 +0600, Dorjoy Chowdhury wrote:
> > > > > On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > >
> > > > > > On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> > > > > > > This flag indicates the path should be opened if it's a regul=
ar file.
> > > > > > > This is useful to write secure programs that want to avoid be=
ing
> > > > > > > tricked into opening device nodes with special semantics whil=
e thinking
> > > > > > > they operate on regular files. This is a requested feature fr=
om the
> > > > > > > uapi-group[1].
> > > > > > >
> > > > > > > A corresponding error code EFTYPE has been introduced. For ex=
ample, if
> > > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in t=
he flag
> > > > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD =
systems
> > > > > > > like FreeBSD, macOS.
> > > > > > >
> > > > > > > When used in combination with O_CREAT, either the regular fil=
e is
> > > > > > > created, or if the path already exists, it is opened if it's =
a regular
> > > > > > > file. Otherwise, -EFTYPE is returned.
> > > > > > >
> > > > > > > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is=
 returned
> > > > > > > as it doesn't make sense to open a path that is both a direct=
ory and a
> > > > > > > regular file.
> > > > > > >
> > > > > > > [1]: https://uapi-group.org/kernel-features/#ability-to-only-=
open-regular-files
> > > > > > >
> > > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > > ---
> > > > > > >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> > > > > > >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> > > > > > >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> > > > > > >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> > > > > > >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> > > > > > >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> > > > > > >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> > > > > > >  fs/ceph/file.c                             |  4 ++++
> > > > > > >  fs/fcntl.c                                 |  4 ++--
> > > > > > >  fs/gfs2/inode.c                            |  6 ++++++
> > > > > > >  fs/namei.c                                 |  4 ++++
> > > > > > >  fs/nfs/dir.c                               |  4 ++++
> > > > > > >  fs/open.c                                  |  8 +++++---
> > > > > > >  fs/smb/client/dir.c                        | 14 ++++++++++++=
+-
> > > > > > >  include/linux/fcntl.h                      |  2 ++
> > > > > > >  include/uapi/asm-generic/errno.h           |  2 ++
> > > > > > >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> > > > > > >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> > > > > > >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> > > > > > >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> > > > > > >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> > > > > > >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> > > > > > >  22 files changed, 67 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha=
/include/uapi/asm/errno.h
> > > > > > > index 6791f6508632..1a99f38813c7 100644
> > > > > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > > > > @@ -127,4 +127,6 @@
> > > > > > >
> > > > > > >  #define EHWPOISON    139     /* Memory page has hardware err=
or */
> > > > > > >
> > > > > > > +#define EFTYPE               140     /* Wrong file type for =
the intended operation */
> > > > > > > +
> > > > > > >  #endif
> > > > > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha=
/include/uapi/asm/fcntl.h
> > > > > > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > > > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > > @@ -34,6 +34,7 @@
> > > > > > >
> > > > > > >  #define O_PATH               040000000
> > > > > > >  #define __O_TMPFILE  0100000000
> > > > > > > +#define OPENAT2_REGULAR      0200000000
> > > > > > >
> > > > > > >  #define F_GETLK              7
> > > > > > >  #define F_SETLK              8
> > > > > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/i=
nclude/uapi/asm/errno.h
> > > > > > > index c01ed91b1ef4..1835a50b69ce 100644
> > > > > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > > > > @@ -126,6 +126,8 @@
> > > > > > >
> > > > > > >  #define EHWPOISON    168     /* Memory page has hardware err=
or */
> > > > > > >
> > > > > > > +#define EFTYPE               169     /* Wrong file type for =
the intended operation */
> > > > > > > +
> > > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > > >
> > > > > > >
> > > > > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/pari=
sc/include/uapi/asm/errno.h
> > > > > > > index 8cbc07c1903e..93194fbb0a80 100644
> > > > > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > > > > @@ -124,4 +124,6 @@
> > > > > > >
> > > > > > >  #define EHWPOISON    257     /* Memory page has hardware err=
or */
> > > > > > >
> > > > > > > +#define EFTYPE               258     /* Wrong file type for =
the intended operation */
> > > > > > > +
> > > > > > >  #endif
> > > > > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/pari=
sc/include/uapi/asm/fcntl.h
> > > > > > > index 03dee816cb13..d46812f2f0f4 100644
> > > > > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > > @@ -19,6 +19,7 @@
> > > > > > >
> > > > > > >  #define O_PATH               020000000
> > > > > > >  #define __O_TMPFILE  040000000
> > > > > > > +#define OPENAT2_REGULAR      0100000000
> > > > > > >
> > > > > > >  #define F_GETLK64    8
> > > > > > >  #define F_SETLK64    9
> > > > > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc=
/include/uapi/asm/errno.h
> > > > > > > index 4a41e7835fd5..71940ec9130b 100644
> > > > > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > > > > @@ -117,4 +117,6 @@
> > > > > > >
> > > > > > >  #define EHWPOISON    135     /* Memory page has hardware err=
or */
> > > > > > >
> > > > > > > +#define EFTYPE               136     /* Wrong file type for =
the intended operation */
> > > > > > > +
> > > > > > >  #endif
> > > > > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc=
/include/uapi/asm/fcntl.h
> > > > > > > index 67dae75e5274..bb6e9fa94bc9 100644
> > > > > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > > @@ -37,6 +37,7 @@
> > > > > > >
> > > > > > >  #define O_PATH               0x1000000
> > > > > > >  #define __O_TMPFILE  0x2000000
> > > > > > > +#define OPENAT2_REGULAR      0x4000000
> > > > > > >
> > > > > > >  #define F_GETOWN     5       /*  for sockets. */
> > > > > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > > > index 66bbf6d517a9..6d8d4c7765e6 100644
> > > > > > > --- a/fs/ceph/file.c
> > > > > > > +++ b/fs/ceph/file.c
> > > > > > > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, =
struct dentry *dentry,
> > > > > > >                       ceph_init_inode_acls(newino, &as_ctx);
> > > > > > >                       file->f_mode |=3D FMODE_CREATED;
> > > > > > >               }
> > > > > > > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dent=
ry)) {
> > > > > > > +                     err =3D -EFTYPE;
> > > > > > > +                     goto out_req;
> > > > > > > +             }
> > > > > >
> > > > > > ^^^
> > > > > > This doesn't look quite right. Here's a larger chunk of the cod=
e:
> > > > > >
> > > > > > -------------------------8<--------------------------
> > > > > >         if (d_in_lookup(dentry)) {
> > > > > >                 dn =3D ceph_finish_lookup(req, dentry, err);
> > > > > >                 if (IS_ERR(dn))
> > > > > >                         err =3D PTR_ERR(dn);
> > > > > >         } else {
> > > > > >                 /* we were given a hashed negative dentry */
> > > > > >                 dn =3D NULL;
> > > > > >         }
> > > > > >         if (err)
> > > > > >                 goto out_req;
> > > > > >         if (dn || d_really_is_negative(dentry) || d_is_symlink(=
dentry)) {
> > > > > >                 /* make vfs retry on splice, ENOENT, or symlink=
 */
> > > > > >                 doutc(cl, "finish_no_open on dn %p\n", dn);
> > > > > >                 err =3D finish_no_open(file, dn);
> > > > > >         } else {
> > > > > >                 if (IS_ENCRYPTED(dir) &&
> > > > > >                     !fscrypt_has_permitted_context(dir, d_inode=
(dentry))) {
> > > > > >                         pr_warn_client(cl,
> > > > > >                                 "Inconsistent encryption contex=
t (parent %llx:%llx child %llx:%llx)\n",
> > > > > >                                 ceph_vinop(dir), ceph_vinop(d_i=
node(dentry)));
> > > > > >                         goto out_req;
> > > > > >                 }
> > > > > >
> > > > > >                 doutc(cl, "finish_open on dn %p\n", dn);
> > > > > >                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req-=
>r_reply_info.has_create_ino) {
> > > > > >                         struct inode *newino =3D d_inode(dentry=
);
> > > > > >
> > > > > >                         cache_file_layout(dir, newino);
> > > > > >                         ceph_init_inode_acls(newino, &as_ctx);
> > > > > >                         file->f_mode |=3D FMODE_CREATED;
> > > > > >                 }
> > > > > >                 err =3D finish_open(file, dentry, ceph_open);
> > > > > >         }
> > > > > > -------------------------8<--------------------------
> > > > > >
> > > > > > It looks like this won't handle it correctly if the pathwalk te=
rminates
> > > > > > on a symlink (re: d_is_symlink() case). You should either set u=
p a test
> > > > > > ceph cluster on your own, or reach out to the ceph community an=
d ask
> > > > > > them to test this.
> > > > > >
> > > > >
> > > > > Thanks for reviewing. The d_is_symlink() case seems to be calling
> > > > > finish_no_open so shouldn't this be okay?
> > > > >
> > > >
> > > > My mistake -- you're correct. I keep forgetting that finish_no_open=
()
> > > > will handle this case regardless of what else happens.
> > > >
> > > > > > >               err =3D finish_open(file, dentry, ceph_open);
> > > > > > >       }
> > > > > > >  out_req:
> > > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > > index beab8080badf..240bb511557a 100644
> > > > > > > --- a/fs/fcntl.c
> > > > > > > +++ b/fs/fcntl.c
> > > > > > > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> > > > > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc=
; O_NDELAY
> > > > > > >        * is defined as O_NONBLOCK on some platforms and not o=
n others.
> > > > > > >        */
> > > > > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > >               HWEIGHT32(
> > > > > > > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_ND=
ELAY)) |
> > > > > > > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O=
_NDELAY)) |
> > > > > > >                       __FMODE_EXEC));
> > > > > > >
> > > > > > >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > > > > > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > > > > > index 8344040ecaf7..4604e2e8a9cc 100644
> > > > > > > --- a/fs/gfs2/inode.c
> > > > > > > +++ b/fs/gfs2/inode.c
> > > > > > > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inod=
e *dir, struct dentry *dentry,
> > > > > > >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISRE=
G(mode) || excl);
> > > > > > >       error =3D PTR_ERR(inode);
> > > > > > >       if (!IS_ERR(inode)) {
> > > > > > > +             if (file && (file->f_flags & OPENAT2_REGULAR) &=
& !S_ISREG(inode->i_mode)) {
> > > > > >
> > > > > > Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
> > > > > >
> > > > > Yes, I thought the masking off was happening after this codepath =
got
> > > > > executed. Maybe it's better anyway to pass another flags param to=
 this
> > > > > function and forward the flags from the gfs2_atomic_open function=
 and
> > > > > in other call sites pass 0 ? What do you think?
> > > > >
> > > >
> > > > Also my mistake. That happens in do_dentry_open() which happens in
> > > > finish_open(), so you should be OK here.
> > > >
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > >
> > > Thanks for patiently reviewing this! I am planning on sending patches
> > > for man-pages and looking into some xfs-tests for this. But I am not
> > > sure if this patch series will get more reviews from others or if it
> > > will be picked up in the vfs branch?
> > >
> >
> > This is a change to rather core VFS infrastructure so yes, you should
> > expect some more review. Assuming no major issues are found, then yes,
> > this should eventually get picked up by the VFS maintainers.
> >
> > Cheers,
> > --
> > Jeff Layton <jlayton@kernel.org>
>
> Ping....
> This patch series got a "Reviewed-by" from Jeff Layton but it probably
> requires more reviews from other maintainers/reviewers as well. So
> requesting for review on this patch series. Thanks!
>

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy
