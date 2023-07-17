Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4F253CD
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 18:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EA5C433C8
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689620374;
	bh=sTuriLWYJzSSE2jwnJH5JjhAaslcZk5G8VKUlMsh+Yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d56I2ITWUu1mVIOxiDtwfOtStc6XQPSzzK0PPZ9xRVpavIS6uoSXezKuKrIX2Mqo1
	 qf/LsJ59b7FMWtCHgYjmR4VjdWyiM0PZWKpcbCZoE8V+9ah49OFTvH8nZIgTq/HVo+
	 fFvFJICVWIzGRPhkX+azZyT4jslnWoEWz4bgpvRcSlCZr/jBbHkv5UWFzqy7PM9rJF
	 YCtJ8VcRzJUKPrXFJx0CBv7J7b9kjdVLQorbF6xtm8oTMS8l6gGGe+L/EaYJ+mVyrW
	 GI841eByj3rQmt3Dx24IIc0N5KGIzEbMBgnUzCIHcdviRC/OpE6syEjCb0mY0XgZmt
	 fAF5QXpsu5udw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-57a8080e4a7so48907817b3.0
        for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 11:59:34 -0700 (PDT)
X-Gm-Message-State: ABy/qLb7HXSZP7VwI27jB5pCQ55p6i7R4YrucCwDNV3Q8DNZm3aJvLZf
	hiIYu1Awbk9CaRuIWcLVujhpmI6YBK+gMFL8JAc=
X-Google-Smtp-Source: APBJJlHzyAZK+86bECGPSBDll+UNWcDd9FO5CEY4PjtnFom/DtR1BWJiZ2RNE0N6CzmBRz+ryCYIFBHIZs9CDKH+Z9w=
X-Received: by 2002:a0d:f543:0:b0:56d:2189:d87a with SMTP id
 e64-20020a0df543000000b0056d2189d87amr13867153ywf.15.1689620373760; Mon, 17
 Jul 2023 11:59:33 -0700 (PDT)
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
 <CAFkjPTkDn=uTEZaQ5HwfPb5sLqMgegoHo=_nsyy2G+3nRFB2OQ@mail.gmail.com>
In-Reply-To: <CAFkjPTkDn=uTEZaQ5HwfPb5sLqMgegoHo=_nsyy2G+3nRFB2OQ@mail.gmail.com>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 17 Jul 2023 13:59:22 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnTEjXiEnf+zNDEav_6SdRB7=72QOUBfbTvpJVC+0wn8g@mail.gmail.com>
Message-ID: <CAFkjPTnTEjXiEnf+zNDEav_6SdRB7=72QOUBfbTvpJVC+0wn8g@mail.gmail.com>
Subject: Re: mmap on 9p broken in 6.4
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de, v9fs@lists.linux.dev, 
	groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

forgot to add, while i was able to reproduce the problem I wasn't able
to reproduce ignoreqv solving it, so I'm going to try and stop
worrying about that bit.
I'm cleaning up the new regression test to add to my suite so
something like this doesn't creep in again.  If someone would kindly
review the patches I'll get them moved over into fixes/next so we can
try and get them upstream.

       -eric

On Mon, Jul 17, 2023 at 1:11=E2=80=AFPM Eric Van Hensbergen <ericvh@kernel.=
org> wrote:
>
> nevermind the bit about not being able to reproduce the problem, I
> figured out what I was doing wrong there now and can reliably
> reproduce the problem on v6.5-rc1 before applying any of my patches.
> The patches do appear to fix the problem - but I'm still at a loss as
> to why ignoreqv also seemed to solve the problem.
>
>         -eric
>
>
>
> On Mon, Jul 17, 2023 at 10:29=E2=80=AFAM Eric Van Hensbergen <ericvh@kern=
el.org> wrote:
> >
> > Thanks Robert, I was holding off on sending the patches out until I
> > could make sure they fixed the problem, but considering I've been
> > having trouble reproducing in my environment I'll send them out now.
> > They are also currently available on github on this branch if that
> > makes it any easier:
> > https://github.com/v9fs/linux/tree/b4/fixes-overly-restrictive-mmap
> >
> >         -eric
> >
> > On Mon, Jul 17, 2023 at 6:26=E2=80=AFAM Robert Schwebel
> > <r.schwebel@pengutronix.de> wrote:
> > >
> > > Hi Eric,
> > >
> > > On Sun, Jul 16, 2023 at 02:48:27PM -0500, Eric Van Hensbergen wrote:
> > > > A quick update on this, I have a patch and it passes regressions
> > >
> > > Thanks for taking care! If you send the patch(es), I can test them in=
 my
> > > setup.
> > >
> > > rsc
> > > --
> > > Pengutronix e.K.                           | Dipl.-Ing. Robert Schweb=
el  |
> > > Steuerwalder Str. 21                       | https://www.pengutronix.=
de/ |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0=
    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9=
    |
