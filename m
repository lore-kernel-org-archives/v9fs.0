Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B71847
	for <v9fs@lists.linux.dev>; Wed, 30 Aug 2023 07:59:37 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4013454fa93so46544465e9.0
        for <v9fs@lists.linux.dev>; Wed, 30 Aug 2023 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693382376; x=1693987176; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMMQyokSBoYi+7NtlQGYb+yVajJvpYPKJBULBUddiXM=;
        b=T5GDEhQqbhjwmCr8ZT+CrSGHn6mGRILLrN5RlJ5cyV9Q7jPGkZwML21hVDkiXmnbJH
         asushdp2m0uIBfYHK9Hkl8UhEwUvOmbI/RV7DRFlSlijTkMIklsgX0VoqN5C5WN+T+dl
         6DSawSmscXPS4oj7okUWbY1/k3pIpOur55gx5LrfBOJ4QzurZbWU2z5z/VwR73QD5qpH
         DjZdVgJ3Xt7Ye6B8ejwXunwislrTvDUmpUcO9zU5KBvCRMnOjbvXY1S0O3pb3OlSUrI3
         E9i5LDBMJOrtNJaL9XYKoPj+XEXYA9G9ZVensFWY9iFoCH0SHZiZQe35cQKqv2BPcFtm
         kCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693382376; x=1693987176;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMMQyokSBoYi+7NtlQGYb+yVajJvpYPKJBULBUddiXM=;
        b=ky7OpTMKKkP23Ts00918ri3uuL7UYCuY3sptlDPsMWsn/i6u8NrYkqWCanQzzlCqvM
         sta0DCQtFZwsTSLO8Wtte79XAAIB0ratEUXEskijfstcatzBS753BMpFBT2KsId21m9m
         gcnG8MPqkDQq+ScQfl+bLUJjDx+35TtSs32jfdfjnQQCUpUZKpH02xW+9XxgpI1Xdcqe
         2XvbiqglBJaPTtdKWyqXOQ2vsc0sA9tGMunAkgIVTCpqdt1/aAJa4NF34viyBKFQH2yi
         VW5EHu72+Urr/zDCTT0CYwX3rSgrKgcUqkMRYyTXka4ngLB+t3tB+DL/WYg4ZxMHq4fR
         4iMg==
X-Gm-Message-State: AOJu0YwY6JG3QEEPEQ/XcwMTR7uxueWj954Eaq1PcQblLpRiLIcYMzvN
	CvPXDQyJhtTWW9AAXrukCNlXpw==
X-Google-Smtp-Source: AGHT+IEjcIizQH3HgpknpZ6G1AFB4laTKJh2Uyrdj3Zs0MAtHyfmRBdqpsjNPzBAd35S2HBtWY8ifA==
X-Received: by 2002:a05:600c:2256:b0:400:6bee:f4fe with SMTP id a22-20020a05600c225600b004006beef4femr1225816wmm.21.1693382375870;
        Wed, 30 Aug 2023 00:59:35 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b003143c6e09ccsm15889160wrq.16.2023.08.30.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 00:59:35 -0700 (PDT)
Date: Wed, 30 Aug 2023 09:59:30 +0200
From: Marco Elver <elver@google.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, ericvh@kernel.org,
	kuba@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
Message-ID: <ZO724hKaHLCrSOa/@elver.google.com>
References: <000000000000d26ff606040c9719@google.com>
 <ZO3PFO_OpNfBW7bd@codewreck.org>
 <ZO38mqkS0TYUlpFp@elver.google.com>
 <ZO55o4lE2rKO5AlI@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO55o4lE2rKO5AlI@codewreck.org>
User-Agent: Mutt/2.2.9 (2022-11-12)

On Wed, Aug 30, 2023 at 08:05AM +0900, Dominique Martinet wrote:
> Marco Elver wrote on Tue, Aug 29, 2023 at 04:11:38PM +0200:
> > On Tue, Aug 29, 2023 at 07:57PM +0900, Dominique Martinet wrote:
> > [...]
> > > Yes well that doesn't seem too hard to hit, both threads are just
> > > setting O_NONBLOCK to the same fd in parallel (0x800 is 04000,
> > > O_NONBLOCK)
> > > 
> > > I'm not quite sure why that'd be a problem; and I'm also pretty sure
> > > that wouldn't work anyway (9p has no muxing or anything that'd allow
> > > sharing the same fd between multiple mounts)
> > > 
> > > Can this be flagged "don't care" ?
> > 
> > If it's an intentional data race, it could be marked data_race() [1].
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks!
> 
> > However, staring at this code for a bit, I wonder why the f_flags are
> > set on open, and not on initialization somewhere...
> 
> This open is during the mount initialization (mount/p9_client_create,
> full path in the stack); there's no more initialization-ish code we
> have.
> The problem here is that we allow to pass any old arbitrary fd, so the
> user can open their fd how they want and abuse mount to use it on
> multiple mounts, even if that has no way of working (as I mentionned,
> there's no control flow at all -- you'll create two completely separate
> client state machines that'll both try to read and/or write (separate
> fds) on the same fd, and it'll all get jumbled up.
> > 
> > Anyway, a patch like the below would document that the data race is
> > intended and we assume that there is no way (famous last words) the
> > compiler or the CPU can mess it up (and KCSAN won't report it again).
> 
> That's good enough for me as my position really is just "don't do
> that"... Would that also protect from syzcaller sending the fd to mount
> on one side, and calling fcntl(F_SETFL) on the side?

No, data_race() is only for marking intentional data races. In a
production kernel, it's a no-op (generated code is identical). In a
KCSAN kernel, it will make the tool not report such data races.

syzkaller doesn't care, and can still produce such programs (so that
other bug detectors can still see an issue if there is one somewhere).

> At this rate we might as well just take the file's f_lock as setfl does,
> but perhaps there's a way to steal the fd from userspace somehow?
> 
> It's not just "don't use this fd for another mount", it really is "don't
> use this fd anymore while it is used by a mount".
> 
> This is made complicated that we only want to steal half of the fd, you
> could imagine a weird setup like this:
> 
>  ┌────────────────────────────────────┐         ┌─────────────────┐
>  │                                    │         │                 │
>  │                                    │         │  kernel client  │
>  │   fd3 tcp to server                │         │                 │
>  │       write end  ◄─────────────────┼─────────┤                 │
>  │                                    │         │                 │
>  │       read end   ──┐               │         │                 │
>  │                    │               │         │                 │
>  │   fd4 pipeA        │ MITMing...    │         │                 │
>  │                    │               │         │                 │
>  │       write end  ◄─┘               │         │                 │
>  │                                    │         │                 │
>  │   fd5 pipeB                        │         │                 │
>  │                                    │         │                 │
>  │       read end  ───────────────────┼────────►│                 │
>  │                                    │         │                 │
>  │                                    │         │                 │
>  └────────────────────────────────────┘         └─────────────────┘
> 
> I'm not sure we actually want to support something like that, but it's
> currently possible and making mount act like close() on the fd would
> break this... :|
> 
> So, yeah, well; this is one of these "please don't do this" that
> syzcaller has no way of knowing about; it's good to test (please don't
> do this has no security guarantee so the kernel shouldn't blow up!),
> but if the only fallout is breakage then yeah data_race() is fine.

Right, if the only breakage is some corruption of the particular file in
user space, and the kernel is still in a good state, then I think this
is fine. However, if the kernel can potentially crash or corrupt
completely unrelated data, it may be a problem.

> Compilers and/or CPU might be able to blow this out of proportion, but
> hopefully they won't go around modifying another unrelated value in
> memory somewhere, and we do fdget so it shouldn't turn into a UAF, so I
> guess it's fine?...

No, the kernel strongly assumes "locally undefined behaviour" for data
races in the worst case, i.e. some garbage value being written into
f_flags. To guard against that we'd have to use READ_ONCE/WRITE_ONCE.

But given the best-effort nature of this based on "don't do this" i.e.
not really supported, data_race() is probably more than enough. You may
want to amend the patch I sent to clarify that (I wasn't aware of it).

> Just taking f_lock here won't solve anything and
> might give the impression we support concurrent uses.
> 
> 
> Sorry for rambling, and thanks for the patch; I'm not sure if Eric has
> anything planned for next cycle but either of us can take it and call it
> a day.

Thanks for the explanation!
