Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C0441D
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 18:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD775C43391
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689617495;
	bh=x6Od1TZbGxl+321HBiuZy1eehJ2SStph7ULJvv4jaYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lVROgEW4SdcCeH/kOQrIrYPj8UY5F/6pLwCDYvBG7uujel5CkhBQwVRDQFwioYscl
	 TC8i70EHMfwBazvcsxHZiy+Dva/kjfT4SF08QpgfkKW4UKKIciMBlxHbkPGr4PU3+n
	 +37nTk3mDrD91coz1n4Ll/GnV0BwaP92nmRZ0/QI609GMn4ViJeqkc8n569obMDrb5
	 AoRXKjivsLw3DxzqLzVl5qxe4Xu7Pm7NCq/X2rUe8K9nnIGNMFucuLlO53f3UwQYZt
	 W0YvArTzKP/0liyNNVdNAU/J4/UPmKv3eoXl8/l46SlLoCHoY/6s1QqyLB/z75gUft
	 sTEzsH1D7VmAw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b9defb36a2so368956a34.2
        for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 11:11:35 -0700 (PDT)
X-Gm-Message-State: ABy/qLbUjQpKrV1FvDLspb7Ng2q88ECN9Q5DQNPEKyQbEwkN7lP29c4c
	2Oy6hVQDnY3J/lsgf2xdQccAWMuycW62Pz9Zwx0=
X-Google-Smtp-Source: APBJJlGhnA4AuAqBr3YNugJNMVrceJJNNBCBw/ikZJ9qKDe1PYhssueQYMKWjbDNBcDoxvCE322EpnpzEjgwqiCqU/M=
X-Received: by 2002:a05:6358:931a:b0:130:ebb9:4283 with SMTP id
 x26-20020a056358931a00b00130ebb94283mr10894538rwa.22.1689617495084; Mon, 17
 Jul 2023 11:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZK25XZ+GpR3KHIB/@pengutronix.de> <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver> <ZLDe09znEIA9t+KF@pengutronix.de>
 <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
 <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com>
 <ZLUlWpnmM6068KV3@pengutronix.de> <CAFkjPTkYKeTHk8DUJBCk8T9nmFV27onyU+j9DbcNQPMYAw8sAw@mail.gmail.com>
In-Reply-To: <CAFkjPTkYKeTHk8DUJBCk8T9nmFV27onyU+j9DbcNQPMYAw8sAw@mail.gmail.com>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 17 Jul 2023 13:11:23 -0500
X-Gmail-Original-Message-ID: <CAFkjPTkDn=uTEZaQ5HwfPb5sLqMgegoHo=_nsyy2G+3nRFB2OQ@mail.gmail.com>
Message-ID: <CAFkjPTkDn=uTEZaQ5HwfPb5sLqMgegoHo=_nsyy2G+3nRFB2OQ@mail.gmail.com>
Subject: Re: mmap on 9p broken in 6.4
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de, v9fs@lists.linux.dev, 
	groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

nevermind the bit about not being able to reproduce the problem, I
figured out what I was doing wrong there now and can reliably
reproduce the problem on v6.5-rc1 before applying any of my patches.
The patches do appear to fix the problem - but I'm still at a loss as
to why ignoreqv also seemed to solve the problem.

        -eric



On Mon, Jul 17, 2023 at 10:29=E2=80=AFAM Eric Van Hensbergen <ericvh@kernel=
.org> wrote:
>
> Thanks Robert, I was holding off on sending the patches out until I
> could make sure they fixed the problem, but considering I've been
> having trouble reproducing in my environment I'll send them out now.
> They are also currently available on github on this branch if that
> makes it any easier:
> https://github.com/v9fs/linux/tree/b4/fixes-overly-restrictive-mmap
>
>         -eric
>
> On Mon, Jul 17, 2023 at 6:26=E2=80=AFAM Robert Schwebel
> <r.schwebel@pengutronix.de> wrote:
> >
> > Hi Eric,
> >
> > On Sun, Jul 16, 2023 at 02:48:27PM -0500, Eric Van Hensbergen wrote:
> > > A quick update on this, I have a patch and it passes regressions
> >
> > Thanks for taking care! If you send the patch(es), I can test them in m=
y
> > setup.
> >
> > rsc
> > --
> > Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel=
  |
> > Steuerwalder Str. 21                       | https://www.pengutronix.de=
/ |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9  =
  |
