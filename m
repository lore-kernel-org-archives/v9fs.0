Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F0748C
	for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 19:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFF6C433CC
	for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689536919;
	bh=y7WL2JQlFFNJ2wE56Bv1Cu/eeN7LOU4VeSrwK6eUAaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FKJsEuhpLQPwhPz6Af26TtmgeBmnT3AA6JHsP6RhfIXqQvHzqDySckrHoY+QRUxbH
	 tCzXAEcHmw5MzUcLk+hNVy1TssCfFhXP2sp23peRJR+DFqg9Ut3/WVo1e/vDxHrl8y
	 l24H4KNloaAexUfnniWob/rAx9fLYaDFIWsFuOeUbvXWb+KGXxkpZD99F7oMu2v9Bk
	 Afm+dMaM8Ut7j0VVoxX8Y6DiyFr/Uvj5IQD5ggEPCXWzXdL5wdQTa6MRT6zsNgrlJv
	 3ZPuHqimXA0bUYJK5X2s9qpg0RA5AvaTwaOomIP3173qEIBzakAx5HAYF5akVNvnFj
	 rOReMMm9/m3Xw==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so4028038276.2
        for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 12:48:39 -0700 (PDT)
X-Gm-Message-State: ABy/qLal1TSzG3zFejzr4JfaowstjKv8ZxxUoL3q7pbv/iIEtcj/+MzK
	mWeB2AGEjwFGahJhTB66QwMDqGIebhlotNaz0oM=
X-Google-Smtp-Source: APBJJlFho7nIl86B/t35lKLgQ2OrYaDjBynjnpQmrtr0FW0DHjVmcw3fVK2eDWC+BpSVlc0vh/lsMTW5gVjGouaoefs=
X-Received: by 2002:a81:a081:0:b0:570:3b:a545 with SMTP id x123-20020a81a081000000b00570003ba545mr10925734ywg.51.1689536918405;
 Sun, 16 Jul 2023 12:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZK25XZ+GpR3KHIB/@pengutronix.de> <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver> <ZLDe09znEIA9t+KF@pengutronix.de> <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
In-Reply-To: <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sun, 16 Jul 2023 14:48:27 -0500
X-Gmail-Original-Message-ID: <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com>
Message-ID: <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com>
Subject: Re: mmap on 9p broken in 6.4
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de, v9fs@lists.linux.dev, 
	groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A quick update on this, I have a patch and it passes regressions but I
never really reproduced the problem.  I was seeing issues reproducing
on x86_64 and aarch64 and so was immediately suspicious noting that
the original report was from armv7 -- so I started looking at data
types and getting embarrassed by my own sloppiness but then also
realized we never upstreamed
https://lore.kernel.org/all/80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.168240=
5206.git.christophe.jaillet@wanadoo.fr/
which is still sitting in fixes/next and fixes at least one of these
type issues.

I'm building an armv7 environment and kernel right now to make sure I
can reproduce the problem before I see if cleaning up the broader type
story fixes things.  But it does look like fid_addmode session
arguments are wrong and should both be unsigned int.  I do wonder if I
should be a bit more aggressive and take everything to u8/u32/u64 as
part of the process, but maybe that should be left for a different set
of cleanups so that we can focus code review on fixing the immediate
problem.  Again though it doesn't immediately appear obvious to me
that any of the type problems are root-cause in the mmap code path so
probably something still lurking.

As part of all this I'll also make sure we have a 32-bit arm
regression run in the test suite (maybe I should just base it off of
distrokit) and am looking at incorporating separate regression actions
for qemu roots and builds with all warnings enabled.

       -eric


On Sun, Jul 16, 2023 at 9:54=E2=80=AFAM Eric Van Hensbergen <ericvh@kernel.=
org> wrote:
>
> Okay, back after holiday and able to look at this on a proper sized
> screen.  Still a bit jet-lagged, and things don't seem quite
> consistent in my head with the observed behavior and the code.  Your
> trace of the original problem has the error coming through as this:
>
> | mmap2(NULL, 862228, PROT_READ, MAP_SHARED, 4, 0) =3D -1 ENODEV (No such=
 device)
>
> which I would think comes from v9fs_file_mmap:510 where it returns
> ENODEV if it detects a shared mmap without writecaches enabled.  But
> this seems overly restrictive - we should only worry about the case
> where we have a writable shared mmap and no appropriate caching and
> the mmap is clearly only PROT_READ.  Furthermore, I'm a little unsure
> of why we don't just fall through to generic_file_readonly_mmap when
> sufficient cache levels aren't enabled as this is what 9P2000 (without
> dotL) does anyways and what we used to do when we had a seperate
> file_operations table for cached versus uncached.  That common code
> checks if the mmap is writable shared and provides -EINVAL, so the
> check is vestigial anyways and the error code inconsistent.  So, the
> first step is to remove v9fs_file:509-510 and that should sort us out.
> Seems like the bug was introduced while I removed the writeback_fid
> stuff, and the check for VM_WRITE got dropped.  But, like I said, the
> whole check was vestigial, so better to just dump it.
>
> The next line (v9fs_file:511) invalidate_inode_pages2 -- also feels
> unnecessary since we are in a code block that has already checked if
> we have writeback caches - so not sure why we need this.  So maybe it
> should go too?  I don't see it in the old code, so I think it got
> added when I was adding lots of extra flushes when tracking down cache
> inconsistencies.
>
> BUT - this doesn't explain why ignoreqv changes any behavior because
> at this level we don't see any checks of fid level modes which this
> impacts -- so I'm still a bit confused and will continue to try and
> understand why that would impact any behavior and so there must be
> another bug in there somewhere.  It may be some inconsistency between
> the session flags and the fid modes -- perhaps it would have been more
> consistent to use a fid->mode derived from the struct file * versus
> using toplevel session flags -- but again I don't see why that would
> have changed any behavior here.
>
> However, it does seem like that is probably what we should be doing
> because if the underlying file shouldn't be cached (regardless of what
> session flags would have wanted) then we shouldn't be allowing
> writable mmap and be using direct operations.  What I'm trying to
> think through in my head is whether or not there would be a case where
> we might have a cache-able file, but then opened it with ODIRECT
> before calling mmap() -- not sure why anyone would do that but seems
> like a case we might need to guard against?
>
> TLDR; there are two patches I've identified which I think make sense:
> 1) remove vestigial check for shared and just drop into generic_readonly_=
mmap
> 2) switch the check from being a session flag check to being a file mode =
check
>
> #1 should be all that is required to fix the regression, but #2 seems
> like would be good practice.
> Meanwhile I'll continue to dig and try and understand why ignoreqv
> seemed to change the behavior.
>
>        -eric
>
>
>
> On Fri, Jul 14, 2023 at 12:36=E2=80=AFAM Robert Schwebel
> <r.schwebel@pengutronix.de> wrote:
> >
> > On Thu, Jul 13, 2023 at 12:54:44PM +0200, Christian Schoenebeck wrote:
> > > About QEMU: unless the (actually unrelated) option `multidevs=3Dremap=
` option is
> > > used, Rreaddir would return all directory entries with qid.version se=
t to
> > > zero. So that's a bug on QEMU side:
> > >
> > > https://github.com/qemu/qemu/blob/71d72ececa086114df80fe4cc04d701b590=
02eb2/hw/9pfs/9p.c#L2534
> > >
> > > I try to send a patch for this next week, such that qid.version is al=
ways
> > > filled, no matter what the QEMU command line options are. In the mean=
time
> > > please use `multidevs=3Dremap` as workaround for testing.
> >
> > As said above in this thread: adding multidevs=3Dremap doesn't help.
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
