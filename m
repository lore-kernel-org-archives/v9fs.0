Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF917F385
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773042; cv=none; b=mru71MAMpRIM6ToYbP1W/+pWvCATCeJGn6jZq2XzN1//bt+0qGQnY5xGKQYs6mPLkv2hrFIISYEeTB2Ee5+SITAPrFt8Vu2SD+1A9+gLAucCCLiCub4s9H6Ts1w96sWQt7asY9+T3BFLDPOmevThScdwXeMFYRA+EodV9sazqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773042; c=relaxed/simple;
	bh=UcovFORWET3D8n+RL1slisUBJ9XkVXR93eBjNnaKppI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpFIIOGiCT5ixuiPCxINz5WvrQ2UdmoE/jvyMnXAhirabtZkDbdXIVDn2ubzJi5bF2FtFNuV3oYIqrj6IRrKD5gQoAgG5+EFfokDFwzZ8jKxrUl/qpHGBSnc/lAib3QExEcP5A4TYLyOUumStZBlgNqQrm8sEUJejgTnppYgL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOMS0Akm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOMS0Akm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F770C433F1
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712773042;
	bh=UcovFORWET3D8n+RL1slisUBJ9XkVXR93eBjNnaKppI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gOMS0AkmL7XsZmRNoXmGCkH+AGSfWc1xctCu887mX4y31ZH4VXY9GL9OU1XqAxGf+
	 oej1jTbC6gLlLsxbxbVj4EnalrH6df+0iI+3TkboqFNBDg+emOzEieQISHFoCGKN/7
	 5cqc1+o33N5n4UWe9eHbh3E33k3GTOLVTxijg35d0n4uO+MVyOBVuVLYhkOQS2B3od
	 /JSZo8BimZH3bNe2joWG01WFG3XgJGzCHoDlEv0RZD41WWwSUbQD64QHSjLANaZ5BA
	 4XNphpChnHoBIwYH1oxkodB1SPVXi50clNzal78VPclWQJmNMQ8TgBheJ48QyTItSP
	 Y/1OsyU5Uzh9w==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6154a1812ffso74870577b3.1
        for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 11:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1z5mBMdrD0kpQII/y4ITF3QkPvXiwaY3fif/X+sft9za7cFljyvmPjjYZgzGODKUnXiG0FKsWK28Ygl+ImooSx502CA==
X-Gm-Message-State: AOJu0YxVX9sGIwszEnJSaVVAEQ+EDjRu+IUA1trAWKl9lnB0TK1B5cAz
	QJd4n/+a+fz2C5CY511mWtyImZ029INb8EG7xAsdV2bES33fGZwQSAY0AfvV3BGLSkM8WuPz9ii
	9Vgr+zYoh9rkc5J2pske9BoDRQcU=
X-Google-Smtp-Source: AGHT+IGpsE776EKyvygTqetlCWIEH0ZEUTjIxwJoHob4h0lvFqNl3Mb0mB3fpyALupQatYoqbaYnUhDivfBkn9xG5Rw=
X-Received: by 2002:a0d:cd87:0:b0:615:3d97:275f with SMTP id
 p129-20020a0dcd87000000b006153d97275fmr3562949ywd.14.1712773041487; Wed, 10
 Apr 2024 11:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev> <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
 <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
 <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev> <29d9bb670a489a38dc9112e21dcf73d44b67d2f6@linux.dev>
 <ahtzctuhy25ptcztbbzmbjhkrh3sjpsjz4ixvrtmpl64iq4hej@vox2llmlv5im>
In-Reply-To: <ahtzctuhy25ptcztbbzmbjhkrh3sjpsjz4ixvrtmpl64iq4hej@vox2llmlv5im>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 10 Apr 2024 13:17:09 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnFqmQQN3jZJPbg0gHajZ2D7EaBvjQ0wFy04uKcq9nz-Q@mail.gmail.com>
Message-ID: <CAFkjPTnFqmQQN3jZJPbg0gHajZ2D7EaBvjQ0wFy04uKcq9nz-Q@mail.gmail.com>
Subject: Re: new 9p kasan splat in 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.  That's useful, that is the same kernel config my regressions
run with (and helps me discount ACLs somewhat since they aren't
configured so I won't waste any more time on that rathole).  Oleg's
report (https://lore.kernel.org/v9fs/20240408141436.GA17022@redhat.com/)
seems to have a reproducible ELOOP (which looks like it was underlying
at least one of your reports as well) so I'm trying to reproduce that
now).

      -eric

On Wed, Apr 10, 2024 at 12:02=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Apr 10, 2024 at 11:43:44AM +0000, Eric Van Hensbergen wrote:
> > I'm having a hard time reproducing the
> >
> > April 1, 2024 at 8:27 PM, "Eric Van Hensbergen" <eric.vanhensbergen@lin=
ux.dev> wrote:
> > >
> > > April 1, 2024 at 8:12 PM, "Kent Overstreet" <kent.overstreet@linux.de=
v> wrote:
> > > >
> > > > Any other details you can give me from your environment (how is
> > > >  9p mounted, is this qemu?, etc.)?
> > > >  It's qemu, standard mount options:
> > > >
> > > >  host /host 9p rw,relatime,access=3Dclient,trans=3Dvirtio 0 0
> > > >
> > >
> >
> > I'm continuing to have a hard time reproducing on my test system -
> > I've added a bunch of BUG_ON to the code to catch where I thought
> > potential problems might be and have not tripped across any of them.
> > Can I get two pieces of data:
> >   a) which 9P CONFIG options are enabled in your kernel?
>
> $ grep 9P ktest-out/kernel_build.x86_64/.config
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> # CONFIG_NET_9P_DEBUG is not set
> CONFIG_9P_FS=3Dy
> # CONFIG_9P_FS_POSIX_ACL is not set
> # CONFIG_9P_FS_SECURITY is not set
>
> >   b) what is the underlying file system on the server
>
> ext4
>
> >   c) what version of qemu are you running
>
> QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-1)
>
> > I'm going to try to spend all day today chasing this down, I may
> > revert anyways if I can't reproduce since there's clearly degraded
> > behavior -- I'd just feel better about it if I understood what the
> > problem was.  In your reverted version that doesn't experience the
> > problem, was it just the last two patches that you reverted or the
> > whole series?
>
> Whole series. I've tested each revert individually, but unfortunately
> the bug is so sporadic that none of them jumped out as the culprit (and
> I'm running 1600 tests on each commit).
>
> I don't have a way to tell my CI "run this test x number of times" or
> I'd try to give you better information.
>
