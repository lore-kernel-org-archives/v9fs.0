Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0A71B45
	for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188905; cv=none; b=Rmv0Qc5ozKK6K3OhC/aEXUlWaoEvuO7GGz4Itgfwa+4yPwTfgV8RSGCnMtHiph06nWC4IdxYkqwABS1a1A8x6FTGHK6R4zn8fM9ubDfZZNwqoe25/PzNhBD3BNkzKjjv1Qlhl5MkgAnjE/kJ6XeqVaE//qX11E0tdyxTfEcNq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188905; c=relaxed/simple;
	bh=AXaWMPmKRYLrHAQ/xoxKaj9w5wLY5CbIDW57NyIt45c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er07OMuHE8zQnjO1xXeZMzt6PFZ0I/ANXh4wkACTGZWEqz95lgCm/szaKREnbr7I0UuHJCSP1Q2wZVgPa549rf/Faod1POfrHuImEEJqFPowpebARAPbIUxWG64+hDLo4fuwyXwnGcVIKbaMmOYk1rTmlBep+MnrRlYTANbkfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUJoY+UL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUJoY+UL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A99C2BD10
	for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188904;
	bh=AXaWMPmKRYLrHAQ/xoxKaj9w5wLY5CbIDW57NyIt45c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fUJoY+ULX8Q4dOLCytL3tDT7IHFRaUvABriRWJBx008XvFeb/53KU/22wN8wRwCM9
	 9J9pZH3kAZgIJ21PZr1kGBtPi+Y34XuajYfkWv38hRbdJ02mKnPl6FwL88WGmR7xmz
	 T9YkYQmlioWH7DFmsAgrumuiUnEFJfB0QmvfbXzLFpBav2193+dNZgTZICv8uIgDoi
	 BgxEto/HGOJE/IE9SCmXN1VT3yS5LZFQx7zCiTaz6sP6k5CSWTdD7OkbJWLYNCWqOt
	 nbpqIu4KTOaM+rboqKIUS13ymPCwL/YHdHDfXDgOpx/tQFmueiBevpX1VTRIUy58Sy
	 T5bPFZ8wtjcZg==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61ae6c615aaso2091657b3.0
        for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 06:48:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YyECVZ4Ur8fVMNJigHTcKh3cbOwgHwvJ9IsK47n07SqHIkDVGv/
	62C2p1qWH+scrLbzQgrwhvBcWHJkVYclDW0f8Arf3t3DuHIZW6krEbi9GfeZKtwx2hVj7QMHyqQ
	IVGEtjbCgDPmg/Xv+u69N40xVs9I=
X-Google-Smtp-Source: AGHT+IHLWAfXV+yhU0X7/ZkvLtrM3+sdonheTHALG9QaagzdzVN82R3gg1NmGsxoGJ5JXwVqv2efxqJKe2cRaxyDd5w=
X-Received: by 2002:a81:b387:0:b0:614:cd12:d55d with SMTP id
 r129-20020a81b387000000b00614cd12d55dmr9903997ywh.10.1713188903258; Mon, 15
 Apr 2024 06:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev> <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
In-Reply-To: <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 15 Apr 2024 08:48:11 -0500
X-Gmail-Original-Message-ID: <CAFkjPTkibDH+NVW2ZDOH-0rPLQ+NshEtX_794g49coeO8bd77w@mail.gmail.com>
Message-ID: <CAFkjPTkibDH+NVW2ZDOH-0rPLQ+NshEtX_794g49coeO8bd77w@mail.gmail.com>
Subject: Re: new 9p kasan splat in 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kent - can you do me a favor and see if the current pending-fixes next
tree (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/l=
og/?h=3Dpending-fixes)
solves your issues?  I'm still chasing some bugs when caches are
enabled, but your config is without caches and I think the single
patch revert should solve the problem for you.  If not, I'll revert
the other major patch from this series until I can track down whatever
race condition is causing the instability.  It would also be useful to
know the underlying file system configuration on your setup (is it
single device, which filesystem, etc.)

      -eric

On Mon, Apr 1, 2024 at 7:07=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Apr 02, 2024 at 12:02:43AM +0000, Eric Van Hensbergen wrote:
> > This should be fixed in -rc2.
>
> I'm still seeing sporadic weird fstests failures on rc2 though - note
> that I'm not testing 9p specifically, but using it for copying results
> to the host.
>
> Example:
> https://evilpiepirate.org/~testdashboard/c/cecfed9b446da5fba9d73e6448c9f0=
d1ff5d95ff/xfstests-nocow.generic.035/log.br
>
> I see runs where this causes the number of test failures to jump from
> the typical ~30 all the way up to 50; IOW, these happen all in a row
> when they happen.
>
> https://evilpiepirate.org/~testdashboard/ci?branch=3Dbcachefs-testing&com=
mit=3Dcecfed9b446da5fba9d73e6448c9f0d1ff5d95ff
>
> What's going on with 9p testing? It seems we've got multiple bugs that
> made it to rc1 that would have been caught with only moderate testing.
>
