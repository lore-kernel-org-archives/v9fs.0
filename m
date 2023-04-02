Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334587C
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 00:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C642BC4339E
	for <v9fs@lists.linux.dev>; Sun,  2 Apr 2023 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680395823;
	bh=g36iodHELiE84Hchrb3SuzR2bPv+F3xB7NDd76qJRsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ns6LrNoeNFJKAITRa/nkUthFm7zQt2klZrjNN6PDXizHib8nnZJ/3uRMagGmTtKDo
	 zSevmLzf9lfjIWtUY/YlyTHnfx6WzvNTBXC/QviLl0Iisexm5teHeZMz+3N/YWnC/T
	 zWMBl5CWruOHuWpMf0x46Ia+Hlznk/xUbg6pmJxy/9uuFEvXeBz6RfMioCqFyeZtRe
	 XaCrbymZyofzU+QSAMZOve/SXyI02Iu1dhCzS+tClhmaU6fZBZ7nfpvI78xrrbPm6R
	 BFZnI4M8tBvFh8tPuy+DnVwrzjnD0KFXj0V5wRf2FqhD2at+wIt5qeI3Q7wBsunC5D
	 EDg+cSNnrxA2g==
Received: by mail-yb1-f171.google.com with SMTP id n125so31184174ybg.7
        for <v9fs@lists.linux.dev>; Sat, 01 Apr 2023 17:37:03 -0700 (PDT)
X-Gm-Message-State: AAQBX9dTcWJ0TVGzxxD+a6V9NTTEOWrry0aOinj7V0wrZ4auQVYDgDtB
	knFBcwBJA1F380zCuMir+BHI3A6djDfqs6RjnqA=
X-Google-Smtp-Source: AKy350aT15/GENEwtXQcjprcmQpYLuAfOY2SdA8HuJGuQco8gz9LBnU65797sB9lwxdJIIMm+2A2v39a7ct73BshRPE=
X-Received: by 2002:a05:6902:18d5:b0:b75:3fd4:1b31 with SMTP id
 ck21-20020a05690218d500b00b753fd41b31mr21166579ybb.1.1680395822871; Sat, 01
 Apr 2023 17:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230401-ericvh-fix-maintainers-v1-1-e3c535b2b5cf@kernel.org> <ZCibRa/WlySRnSF4@codewreck.org>
In-Reply-To: <ZCibRa/WlySRnSF4@codewreck.org>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 1 Apr 2023 19:36:52 -0500
X-Gmail-Original-Message-ID: <CAFkjPT=mGXbvUVw7VDLXsi+SUFQugMBXLDmZU5sC_eV1VB3s0A@mail.gmail.com>
Message-ID: <CAFkjPT=mGXbvUVw7VDLXsi+SUFQugMBXLDmZU5sC_eV1VB3s0A@mail.gmail.com>
Subject: Re: [PATCH] Update email address and mailing list for v9fs
To: asmadeus@codewreck.org
Cc: v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev, 
	lucho@ionkov.net, linux_oss@crudebyte.com, rminnich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. - updated in my branch to remove the duplication.

This was my first attempt at b4, the documentation / cache-arguments
rework was the second (couldn't figure out a way to link it back to
the original stream).  Need to get more savvy with the maintainer side
of it too.

        -eric

On Sat, Apr 1, 2023 at 4:00=E2=80=AFPM <asmadeus@codewreck.org> wrote:
>
> Eric Van Hensbergen wrote on Sat, Apr 01, 2023 at 07:06:25PM +0000:
> > We've recently moved the mailing list to lists.linux.dev to move away
> > from the sourceforge infrastructure.  This also updates the website
> > from the (no longer v9fs relevant?) swik.net address to the github
> > group which contains pointers to test cases, the protocol, servers,
> > etc.  This also changes my email from my gmail to my kernel.org
> > address.
> >
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
>
> Acked-by: Dominique Martinet <asmadeus@codewreck.org>
>
> Just a nit below.
> (BTW, I think we can de facto start using only the new list pretty
> quickly, there's little reason to stay on the old one)
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
> As far as as I can see there are no other list (or mail) that has the
> same descripion as <mail> field; you can either drop the repeated
> `<v9fs@lists.linux.dev>` entierly or we can give the list a name
> like some (few) others do e.g. "9p filesystem developers <v9fs@...>"
>
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
>
> Oh, I was wondering what added that, it looks like a b4 feature?
> That's interesting, I didn't know b4 also had whistles for sending mails
> as well. I like more infos in here, I'll have to give it a try...
>
> --
> Dominique
