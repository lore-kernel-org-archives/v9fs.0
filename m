Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE393C02
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 13:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE9EC4339C
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680443688;
	bh=Gq9KMbBMAkP7nUOI5Gqy9NByOXxD/rN+Ny3KY8IlvqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KsA+/lyhLjqSyJL0mTIZYEdCTmvOutCXDBF6IuuOFdSjm4xd8nyGDUnZF35oi8FZx
	 E+DDc5FskQ+bLYo1CuFumf6RUgw1vV7ghjtHi8ew038Ue5JTSqxeaKXt5HQ6w368YC
	 paYKHb/zIi45MH8wEx8lPmskxKduHX8Z7a2bvyfR6t1KNwm+VGmfR6OxtKAb4LQa5c
	 ixCsk8W1BbITQ/ATqPp+2/7VZONt3urY6q45ws13GO3zf3lXbdJFHdxu/dFdufbgSK
	 vbMmia7DaytWM6to0ZK+174QDMa7mm0KBtEGXrTCIK+AjHWEnp6MfT+nQBx6ISoY7b
	 JqqpoKoNt/Otw==
Received: by mail-yb1-f170.google.com with SMTP id e65so31952531ybh.10
        for <v9fs@lists.linux.dev>; Sun, 02 Apr 2023 06:54:48 -0700 (PDT)
X-Gm-Message-State: AAQBX9fbEysfXUuoq5YX6iyJa3aqRlsL63XPW8bJGq0UBcG4XAO2Ufmy
	Sav2fmb2dTuYVK+MYiAve3cBZEhV1joMRbn/4JY=
X-Google-Smtp-Source: AKy350awHyrBi2UMw+hiBvXbz2WK9UaYf3hLpubK1TSczBJADrIssDG2aNj4cQ+AMntKaCQIk2+ue54+A7YZrnIWcvY=
X-Received: by 2002:a05:6902:10c3:b0:b79:4826:e8e3 with SMTP id
 w3-20020a05690210c300b00b794826e8e3mr15018678ybu.1.1680443687563; Sun, 02 Apr
 2023 06:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org> <4901173.k3S2UP3QcN@silver>
In-Reply-To: <4901173.k3S2UP3QcN@silver>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sun, 2 Apr 2023 08:54:36 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnvWzpPEiLW=2RZyOcJJakdTFhZ5vORKJcEhWQJBuUS+w@mail.gmail.com>
Message-ID: <CAFkjPTnvWzpPEiLW=2RZyOcJJakdTFhZ5vORKJcEhWQJBuUS+w@mail.gmail.com>
Subject: Re: [PATCH] Update email address and mailing list for v9fs
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev, 
	lucho@ionkov.net, asmadeus@codewreck.org, rminnich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, migrating and deprecated I'd say.  The lists.linux.dev interface
is fairly spartan so I can't invite former members of v9fs-developer.
My plan was to maybe advertise the migration of the list in a footer
on v9fs-developer, and then after a period of time (a release cycle?)
put an auto-responder on it asking folks to use the new list.  But the
intention is to stop using the old list. I'd migrate the archives if
sourceforge.net allowed me too, but they really don't (and that's yet
another reason to leave sf.net)

         -eric

On Sun, Apr 2, 2023 at 8:48=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Saturday, April 1, 2023 9:06:25 PM CEST Eric Van Hensbergen wrote:
> > We've recently moved the mailing list to lists.linux.dev to move away
> > from the sourceforge infrastructure.  This also updates the website
> > from the (no longer v9fs relevant?) swik.net address to the github
> > group which contains pointers to test cases, the protocol, servers,
> > etc.  This also changes my email from my gmail to my kernel.org
> > address.
> >
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
>
> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
>
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d5bc223f305..6567bae7137b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -224,13 +224,13 @@ S:      Orphan / Obsolete
> >  F:   drivers/net/ethernet/8390/
> >
> >  9P FILE SYSTEM
> > -M:   Eric Van Hensbergen <ericvh@gmail.com>
> > +M:   Eric Van Hensbergen <ericvh@kernel.org>
> >  M:   Latchesar Ionkov <lucho@ionkov.net>
> >  M:   Dominique Martinet <asmadeus@codewreck.org>
> >  R:   Christian Schoenebeck <linux_oss@crudebyte.com>
> > -L:   v9fs-developer@lists.sourceforge.net
> > +L:   v9fs@lists.linux.dev <v9fs@lists.linux.dev>
>
> So the old list is officially dead? Migrated?
>
> >  S:   Maintained
> > -W:   http://swik.net/v9fs
> > +W:   http://github.com/v9fs
> >  Q:   http://patchwork.kernel.org/project/v9fs-devel/list/
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
> >  T:   git git://github.com/martinetd/linux.git
> >
> > ---
> > base-commit: 707823e7f22f3864ddc7d85e8e9b614afe4f1b16
> > change-id: 20230401-ericvh-fix-maintainers-865452e6c43a
> >
> > Best regards,
> >
>
>
>
>
