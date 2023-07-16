Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD93747F
	for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 14:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA74C433C8
	for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689519262;
	bh=9SKKq6ARUtdmiNlxWzKLBTLh391eubq39S1HqCtLU1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHihh3GXYdAlmma/a8mVR6JCpyQadm4P4e5fiIYQIPQCZ1MGZdCotYqEP+YYI/cqi
	 IL+maZyArJ+TsGdmmu1GQcP6jl7jW8E5YlIpl8KjyTMRZdTUTZKtTIRDqNaUTpHwCp
	 EJ7R6JquhceWrPVK9cnRsaYnXZko2DCH+FITcO8Z5qzKrcecUX7xmVombeKAXlP4+a
	 qv3P+WICmS4zTTE+oMOOXH1AZ5aEG6F5bUw9is95uXtWfR6lDFs/XILjQqKW24fMgG
	 JFDZOblLwDTEJ+DKWAuwchxRtTGzIa+J03tHcdl6b9TAM/Og6gteo29yk3Tduy3CUU
	 AHGHTAoFWIdKA==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-cb4de3bd997so4643114276.1
        for <v9fs@lists.linux.dev>; Sun, 16 Jul 2023 07:54:22 -0700 (PDT)
X-Gm-Message-State: ABy/qLYhjQQPvh4LlilrwDbKuw/IHbPe0L2BaXi+rUq/L0i1mqbN8QYp
	cZ+p0HcCPETXL64jXgHNYWf4PipX3lgI5dusQ8A=
X-Google-Smtp-Source: APBJJlGavgWSFsbeq0/LfFIgONRbHDZSwBGFTI5MZ64xAOUT5QgxQSyYMmmIKPdqqtXzojCZa/nHHbJ+vb7mctl3MIs=
X-Received: by 2002:a0d:d996:0:b0:56d:463b:7cf3 with SMTP id
 b144-20020a0dd996000000b0056d463b7cf3mr8091808ywe.13.1689519261662; Sun, 16
 Jul 2023 07:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZK25XZ+GpR3KHIB/@pengutronix.de> <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver> <ZLDe09znEIA9t+KF@pengutronix.de>
In-Reply-To: <ZLDe09znEIA9t+KF@pengutronix.de>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sun, 16 Jul 2023 09:54:10 -0500
X-Gmail-Original-Message-ID: <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
Message-ID: <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
Subject: Re: mmap on 9p broken in 6.4
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de, v9fs@lists.linux.dev, 
	groug@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, back after holiday and able to look at this on a proper sized
screen.  Still a bit jet-lagged, and things don't seem quite
consistent in my head with the observed behavior and the code.  Your
trace of the original problem has the error coming through as this:

| mmap2(NULL, 862228, PROT_READ, MAP_SHARED, 4, 0) =3D -1 ENODEV (No such d=
evice)

which I would think comes from v9fs_file_mmap:510 where it returns
ENODEV if it detects a shared mmap without writecaches enabled.  But
this seems overly restrictive - we should only worry about the case
where we have a writable shared mmap and no appropriate caching and
the mmap is clearly only PROT_READ.  Furthermore, I'm a little unsure
of why we don't just fall through to generic_file_readonly_mmap when
sufficient cache levels aren't enabled as this is what 9P2000 (without
dotL) does anyways and what we used to do when we had a seperate
file_operations table for cached versus uncached.  That common code
checks if the mmap is writable shared and provides -EINVAL, so the
check is vestigial anyways and the error code inconsistent.  So, the
first step is to remove v9fs_file:509-510 and that should sort us out.
Seems like the bug was introduced while I removed the writeback_fid
stuff, and the check for VM_WRITE got dropped.  But, like I said, the
whole check was vestigial, so better to just dump it.

The next line (v9fs_file:511) invalidate_inode_pages2 -- also feels
unnecessary since we are in a code block that has already checked if
we have writeback caches - so not sure why we need this.  So maybe it
should go too?  I don't see it in the old code, so I think it got
added when I was adding lots of extra flushes when tracking down cache
inconsistencies.

BUT - this doesn't explain why ignoreqv changes any behavior because
at this level we don't see any checks of fid level modes which this
impacts -- so I'm still a bit confused and will continue to try and
understand why that would impact any behavior and so there must be
another bug in there somewhere.  It may be some inconsistency between
the session flags and the fid modes -- perhaps it would have been more
consistent to use a fid->mode derived from the struct file * versus
using toplevel session flags -- but again I don't see why that would
have changed any behavior here.

However, it does seem like that is probably what we should be doing
because if the underlying file shouldn't be cached (regardless of what
session flags would have wanted) then we shouldn't be allowing
writable mmap and be using direct operations.  What I'm trying to
think through in my head is whether or not there would be a case where
we might have a cache-able file, but then opened it with ODIRECT
before calling mmap() -- not sure why anyone would do that but seems
like a case we might need to guard against?

TLDR; there are two patches I've identified which I think make sense:
1) remove vestigial check for shared and just drop into generic_readonly_mm=
ap
2) switch the check from being a session flag check to being a file mode ch=
eck

#1 should be all that is required to fix the regression, but #2 seems
like would be good practice.
Meanwhile I'll continue to dig and try and understand why ignoreqv
seemed to change the behavior.

       -eric



On Fri, Jul 14, 2023 at 12:36=E2=80=AFAM Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
>
> On Thu, Jul 13, 2023 at 12:54:44PM +0200, Christian Schoenebeck wrote:
> > About QEMU: unless the (actually unrelated) option `multidevs=3Dremap` =
option is
> > used, Rreaddir would return all directory entries with qid.version set =
to
> > zero. So that's a bug on QEMU side:
> >
> > https://github.com/qemu/qemu/blob/71d72ececa086114df80fe4cc04d701b59002=
eb2/hw/9pfs/9p.c#L2534
> >
> > I try to send a patch for this next week, such that qid.version is alwa=
ys
> > filled, no matter what the QEMU command line options are. In the meanti=
me
> > please use `multidevs=3Dremap` as workaround for testing.
>
> As said above in this thread: adding multidevs=3Dremap doesn't help.
>
> rsc
> --
> Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  =
|
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    =
|
