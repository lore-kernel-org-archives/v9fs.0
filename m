Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626F111BB
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 15:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC70C433C9
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688051851;
	bh=s3ac5bI8zx04UkljAZCTaWqkxZYoDuxzApvYJTJYNKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XVzeQ6M1Ev78GWrXPrlQ9udfcrd0Wjq4S4qqE8ODwpNF46sSw5NOGDlYWrisgjQ06
	 XwuS6C3fUc7iWx576qtnxaX81WQCytSB4xgOtDdQRobSFADPrja3zGI6TxuNTETL3F
	 ykw9R+L44kpu9pIiTzJJxe4rH0qKAxffWq6V9/E8LUhh66WSzGvJItd74Ih5aZcrgt
	 85mTMUVI98fflvasp3pDvsCj7qxnrzVtbqBx7hZrYEBE/zy7a2XFHdk5ZAzmYqa6V5
	 nSyeJbRnQ8at7ZJm4cdQSNISZNyQvCdKPj4hwZsWio5eRNTnJxyyYg0hLEw0ScwrF+
	 N44sZK+HcNrig==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a0642e4695so430739b6e.2
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 08:17:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDyliSe+xVLB0GkI8al0UK8gMNl8oHyr0OMW5QG15EE6aKpZR82u
	HuJmgXTJMPVxpXRR6Irllb1vJNxXMti5Y+7JsDU=
X-Google-Smtp-Source: ACHHUZ6v1BhjRv82ovluadtgvgdQcSXINqLrWRkyfvHo5hCbeMvow7YWjWalYGLEmxvyoMQ9zsrgAeKnEqHLjbrYc3M=
X-Received: by 2002:a05:6808:55:b0:39b:bcbc:8943 with SMTP id
 v21-20020a056808005500b0039bbcbc8943mr33606500oic.1.1688051850868; Thu, 29
 Jun 2023 08:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com> <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net>
In-Reply-To: <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Thu, 29 Jun 2023 17:17:19 +0200
X-Gmail-Original-Message-ID: <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
Message-ID: <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

one thing that may be worth taking a look at in your test environment
is confirming that there is no "accidental access" to the synthetic
file systems (/sys or /dev) via 9p -- usually the /dev ones wouldn't
be problematic, but if they were being accessed via 9p that may be a
corner case perturbing performance in a way we don't typically test.
The other would be to cross check there is no log file writing via 9p
-- again, this should be something that works, but I could imagine the
more synchronous write behavior which we are now doing a better job of
enforcing when cache=3Dnone could cause synchronous delays that might
perturb performance of your tests.  A workaround for the latter would
be to write the log to a tmpfs and then copy to 9p when done.  The
other potential is just to enable caching (cache=3Dmmap should be
sufficient) in your virtme configurations.  The new readahead and
writeback cache modes should be consistent enough for your use case.
I didn't suggest that earlier because I wanted (and still want to)
understand the problems you are seeing.

      -eric

On Thu, Jun 29, 2023 at 3:26=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Eric,
>
> On 29/06/2023 10:46, Eric Van Hensbergen wrote:
> > (repost so it actually goes to the list and making sure gmail doesn't s=
end html)
> >
> > So, I've not completely reproduced your environment as I've been
> > traveling and its been a bit more difficult.  I have done some
> > relative performance regressions (in a virtualized environment just
> > running qemu inside a docker container on my M1 so perf isn't going to
> > be fantastic) -- but even in that case when I'm running unloaded I see
> > very little difference between v6.3 and v6.4.
>
> Thank you for looking at that!
>
> > So, there is some slight perturbation in average latency, but nothing
> > that I would think would be significant (particularly in a simulated
> > platform which carries with it a certain amount of noise).  I'm
> > working on automated the regressions so I can try them on multiple
> > platforms and add some rigor to the results but I don't see anything
> > here that jumps out at me as being an obvious concern.  Of course
> > there may be differences in your kernel config that could be
> > perturbing the behavior, I'll continue to try and run with the virtme
> > configs but my internet is currently on the end of a cocktail straw so
> > pulling and/or building docker images is challenging.  I may go ahead
> > and just temporarily rent an aws instance to try and speed that part
> > of the process up.
>
> Thank you for that! If it helps, I can easily run additional tests using
> our test environment having the performance issue. I can run these tests
> with and without your modifications in 9p from v6.4 and compare the
> results: maybe the issue we have is not "cover" by your tests. But I
> don't know how portable your benchmark tests are :)
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
