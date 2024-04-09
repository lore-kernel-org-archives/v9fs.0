Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAA158209
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696236; cv=none; b=r4QnN3/vhHNrMTpuEq5S5m3HS0TUcqHC9uFmHhJsytLzeI/xYSE77oYAYYyZRwwhtF+jj4NR1dtEyPmpMcf+xVeFKoG6sY+tKo+lZeesbDniJIDXepnW0T9VpHRLAGKBFZAa7Nj6VRwKK7F16NT1Gm1FSYVQq4Zr4QWSjVRRlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696236; c=relaxed/simple;
	bh=M05KXxe7ePMLCYUdpVHByaz7tjN9dwqhYeeOllK16Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSR18nbn3xFR7EG1/cJm/cZ/0BZE+S6IKUNMv3y+dK9P2cHpYJxUaE082scU47PEh5bERe+pXsu5gTvut1a9kW47tPRyjzHNyMOR1IhKMqRYMpXn/FPwOCbKbcYQc8JGqPw22m+rjSXZpnWEyqrDGHlKp5poVTaNisd3quKRkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEjTySuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEjTySuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E8EC433F1
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712696236;
	bh=M05KXxe7ePMLCYUdpVHByaz7tjN9dwqhYeeOllK16Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TEjTySuJQUmkWfYbwZ09wQBKKRN6ek5FMCIUvGTwG9WPl4Rnwl0fF9sONO79hO6fD
	 1SlxhzsPZlL/46ndqWt6UQ/XLKkvKSk2p2ZQJnRfjBVRcrk/mNcwnA4xWfeZFQB8yd
	 pA2btGtXcYOK8LPP/SFiq3T1/Z1XSrGODL6oHgxGrQqyx1MRpk4TYNIUTRTUm4SFCE
	 b3EunDcrpA8+RrUWJoyvIAhc7JVvp/YK4+iGWK3ujf9USEOfKU1B0KCEQaphjEZaLL
	 1a/qwLGfDDkqydNxqsa3TC4Z5uFqTKb7Rb6/MeMxgF7+6qAV6dFQ0zopoJCDMyqVys
	 lW9zFlBPmOhJw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617f8a59a24so28586827b3.1
        for <v9fs@lists.linux.dev>; Tue, 09 Apr 2024 13:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaaqfIwqLPsb6bIEPwQ5E7vK340mt6nodtgJyPjpnMCHS1sKfIIftomk/u8AJ3Rm6fhtdnh73LdzrjMCx7v72A2ZG/1w==
X-Gm-Message-State: AOJu0YyjmD+Q5ZIEhcqABu33M9fNwE1Hu+qHLr/3Q4OZa+vrlY2ULhK3
	xWtoWd6wDr7phjZmD0NkFsLLyyTp+DRNTfXJWdRyxuNdlzOlpQWohwDl23SUB9rEANGOXOdLGIl
	G0PSwDpEDfijJPBYAkxDXMTVveak=
X-Google-Smtp-Source: AGHT+IHQUca0AugzzAz4v6w/CgZ+kuSHQ6uWd7umk2jk4x/fbEiENQH38v9VaRGWvGawQHdljqM6z3A0DDvj+eM/cak=
X-Received: by 2002:a0d:e64a:0:b0:617:cb98:f9b2 with SMTP id
 p71-20020a0de64a000000b00617cb98f9b2mr846078ywe.43.1712696235797; Tue, 09 Apr
 2024 13:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZhNvwwYRN4-EczYi@codewreck.org> <7b4724a5be3a5a5f4ab550741741ecf3479f7139@linux.dev>
 <ZhSi8cq-uFpXdTwE@codewreck.org> <ee6adbc32495bf76d7a943752ec5eed152eafd1e@linux.dev>
In-Reply-To: <ee6adbc32495bf76d7a943752ec5eed152eafd1e@linux.dev>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 9 Apr 2024 15:57:04 -0500
X-Gmail-Original-Message-ID: <CAFkjPT=A=rYG7UfYrBZEWTesf6wBmcECM4P4E0AAqzjzYhZoLA@mail.gmail.com>
Message-ID: <CAFkjPT=A=rYG7UfYrBZEWTesf6wBmcECM4P4E0AAqzjzYhZoLA@mail.gmail.com>
Subject: Re: recap of 9p problems in 6.9
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also just realized that this patch dropped out of my merges -- wonder
if this would help with the nlink race conditions:
https://patchwork.kernel.org/project/v9fs-devel/patch/20240108-fix-nlink-ha=
ndling-v2-1-8718b4c7199a@kernel.org/

     -eric

On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Eric Van Hensbergen
<eric.vanhensbergen@linux.dev> wrote:
>
> April 8, 2024 at 9:07 PM, "Dominique Martinet" <asmadeus@codewreck.org> w=
rote:
> > Replying to both mails at once
> > Eric Van Hensbergen wrote on Mon, Apr 08, 2024 at 11:14:07PM +0000:
> > > Thanks for looking into these Dominique - I've got the reports queued
> > >  up and am just looking to ring fence some time to dig into them befo=
re
> > >  I commit to a revert. The change in handling of inode matching and
> > >  keeping inodes around in the cache longer are likely the root of all
> > >  of these, but the old code had so much unexplained corner cases I
> > >  really want to understand the problems before revert.
> > My opinion here is that there's been quite a few people reporting to be
> > impacted, so while I agree we need to understand the old cruft
> > eventually I think it's time to rollback and try harder to reproduce
> > the various errors we've been reported and investigate in another branc=
h
> > (not even -next, as that is also used by people for non-reg -- breaking
> > other parts of the kernel's non-reg will just make people stop using 9p=
)
> > And when we do finally manage to reproduce this that'll make another
> > workload we can test regularly for future regressions, I think we need
> > more of these (like my parallel unlink code); everything I'm running is
> > either too nice (e.g. proper build without parallel write accesses
> > within a file) or too synthetic (fsstress etc); more "real-world" tests
> > can't hurt.
> >
>
> I do agree with this, but want one more day before I give up.  I'm going =
to work on this today and tomorrow to see if I can fix Kent and Oleg's prob=
lems, including looking at a partial revert (as you suggest, maybe just rev=
erting the inode_drop patch would clean up most of these for the time being=
 since everyone doesn't seem to be operating in cached mode anyways).
>
> Sorry for diving down the rat hole last night, I should have just looked =
at the trace.  I've added access=3Dclient to my test sweeps so I can see if=
 Kent's problem is related to acls.  fstest just takes so long to run.
>
>      -eric
>
