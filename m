Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181017FD
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712018043; cv=none; b=KfKtcEpYF+IfaxwHcFp/aYnIprMKYjtL1hcuf9aJsat5Nqlw8Wttgm6jXHW/2JstYqyhgzMP8i3Nom1iy56lJT7RM9C1mxlSedJr9cEGkhZSecsz/ONviRTpIL7O6BlCzt1PiAe15IzBevS7dJnpLC1X/xqr5TdJHanckbf43lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712018043; c=relaxed/simple;
	bh=vXgGpViAJTJS8fdQKKwSdZ5D4SGdNV2+PXMHBMT5MfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jozdWM1cHmkgVcfo0s7tqzYPjgT1U885TvORUMQj2rwgT/jcJJ1nWhqwvHMAJQBN12H7Bqckqw817tlFMCnodE+3k0iiQXdmn80im8jCHS+G15lPlP5/W73CYiPbpBBBv/dI1hcROz5T4hyg/Je02e10ymOqKqyY2gRjrPMiBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLwXnDMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLwXnDMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640FC433F1
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712018042;
	bh=vXgGpViAJTJS8fdQKKwSdZ5D4SGdNV2+PXMHBMT5MfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gLwXnDMYSNhgVd5aF05BMqjT0y5wNpwO8XrCPvtbI6qbGFM6K8VPYEy9SEwY1AcYs
	 C3FHefzJrvZeDCxUqJUkMhjGnot3n3TN4XXVv/6UAuTyv/T446cJQc7r8yVyoENp+y
	 w4R9asgRIwyrQSEZDnA6qir7Lu+NhTwk9ZS9lHFI6ZAcE9MKjTCbyj2unEJxAES9v7
	 j8xjX34gnE27HI40rgRu0ktsxUrI9CBFZJnPHTEE3wjrHGYECx/hUI6lyJ06IvJkC6
	 Y0oVmspvlOcShOPUiltLuUDFCUkALULfD4oIVlO+19pyb+/bEm9Gd3m/reg3abwlbj
	 elkWpf/8GU9jQ==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61471853539so12152057b3.0
        for <v9fs@lists.linux.dev>; Mon, 01 Apr 2024 17:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWID3lHJpBQtBZ79yw5X2KC9G47B493VcVYtb2zI6rnCcMveFnKvrqJAKbK1O3hY+KtKUNCop/zfqNwj9EkhFJifmN1pw==
X-Gm-Message-State: AOJu0YyB4/Nqdvk1CgPaymx5hA2+1EEtyKQL9FiI/cKV+z8+wYLVJbp0
	7KQ68TD90XpHbTxNKfDX2KWAF8EoamNYtSpuRPe3jFo2Qo4cqi5qVrwUwW59lF+S5zKtwRe2H36
	2UCnFt1m9NAZSZlUFguROIk6WbQk=
X-Google-Smtp-Source: AGHT+IFqAdEhKO0BRRn7TcNSvpCNaW6SKnzhrJrfd66euY750KE+Bxkb4cO7qg0yrGzy27/n1r4zw9/FlsGQ0CbPQIQ=
X-Received: by 2002:a0d:fd85:0:b0:614:2c9b:4c89 with SMTP id
 n127-20020a0dfd85000000b006142c9b4c89mr8903790ywf.11.1712018041763; Mon, 01
 Apr 2024 17:34:01 -0700 (PDT)
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
Date: Mon, 1 Apr 2024 19:33:50 -0500
X-Gmail-Original-Message-ID: <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
Message-ID: <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
Subject: Re: new 9p kasan splat in 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've got standard regression runs with dbench, fsx, postmark and a few
special case ones to check problem areas we've had in the past.  There
was a pretty extensive rework of some of the caching mechanisms -- so
I was expecting this to be a busy cycle.  There were a couple of fixes
that were in the pipe but missed -rc1 because of day-job deadlines
landing same time as kernel merge window, but these are mostly
upstream now except for a few legacy fixes which are still in my
fixes/next tree.

Looking at your example above -- is it the case that most of these,
there is essentially a missing log file that isn't being created by
9p?  Any other details you can give me from your environment (how is
9p mounted, is this qemu?, etc.)?

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
