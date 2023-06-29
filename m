Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB55399
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 08:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CA0C433C0
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688028374;
	bh=ppYkk0ikzSgqpP0Wqmd16usy/zjQPviquU40rt/TF1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W7+vHmIldRv6RPhXoBCp2Gp1rKfUDt+Z/nSyK+XnCMBa6b5SsvIIMZ4itjreqermH
	 96r5EG3CVEj851uiPPn2q79uiW3szWCjXRt2EF6hfzrviLZsoFQQKHrny+ZFmMiqSL
	 iH+KFQWAHpQJNhsk3NnYp7UFK+mXqqTTrdjS2m2PLW37QU8x26lYz0Uf94R5+FFz8L
	 q5LAAtG7LXHxyPGZDD2nopxDyj1qT1FwF6tBCIxG1aZUlXaC5xpz2RCG0ZFnlKqKWz
	 Qzdy8xZjXRL5F45SthA8AsowvZe26ntqQuhKf5mMsLqfa6lqhw23VbSIHIOTgWALBf
	 44z+XO7omUy9w==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5703d12ab9aso4091887b3.2
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 01:46:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDwFF3Fo0SuVzKvHzZYurnkdulsUFlBnX9FC/uqPAG38aia3ylpE
	9Z5TnbG+bmtSjG7raZgJh864tIVhUAHRC/3AFwU=
X-Google-Smtp-Source: ACHHUZ4MAV0U2DcgJd3YUqKhCc+16rwTlLKMQ0mzypBe/mUpSeb4F6Dy7oPzWlHSAxe1bbyczztgzmA6cqmfPWW6RUU=
X-Received: by 2002:a0d:da46:0:b0:573:400f:959 with SMTP id
 c67-20020a0dda46000000b00573400f0959mr30553805ywe.27.1688028373654; Thu, 29
 Jun 2023 01:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
In-Reply-To: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Thu, 29 Jun 2023 10:46:02 +0200
X-Gmail-Original-Message-ID: <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
Message-ID: <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(repost so it actually goes to the list and making sure gmail doesn't send =
html)

So, I've not completely reproduced your environment as I've been
traveling and its been a bit more difficult.  I have done some
relative performance regressions (in a virtualized environment just
running qemu inside a docker container on my M1 so perf isn't going to
be fantastic) -- but even in that case when I'm running unloaded I see
very little difference between v6.3 and v6.4.

v6.3 dbench no-cache:
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX       1752    15.403    65.686
 Close           1276     1.521    16.334
 Rename            74    27.324    58.181
 Unlink           362    16.717    55.471
 Qpathinfo       1588     6.463    72.369
 Qfileinfo        271     0.814     9.844
 Qfsinfo          297     0.775     1.393
 Sfileinfo        137     1.632     2.466
 Find             609    13.964    43.251
 WriteX           840     0.759     6.753
 ReadX           2801     0.581     2.184
 LockX              6     0.591     0.769
 UnlockX            6     0.587     0.819
 Flush            125     0.661     1.329

Throughput 0.924965 MB/sec  1 clients  1 procs  max_latency=3D87.798 ms

v6.4 bench no-cache:
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX       1695    15.939    68.052
 Close           1229     1.557     5.368
 Rename            72    27.350    54.836
 Unlink           357    17.159    43.353
 Qpathinfo       1513     6.780    54.292
 Qfileinfo        260     0.787     1.361
 Qfsinfo          296     0.809     1.898
 Sfileinfo        134     1.664     2.122
 Find             590    14.467    61.693
 WriteX           822     0.792     7.848
 ReadX           2728     0.589     1.564
 LockX              6     0.652     1.011
 UnlockX            6     0.506     0.559
 Flush            122     0.688     1.248

Throughput 0.917066 MB/sec  1 clients  1 procs  max_latency=3D68.164 ms

So, there is some slight perturbation in average latency, but nothing
that I would think would be significant (particularly in a simulated
platform which carries with it a certain amount of noise).  I'm
working on automated the regressions so I can try them on multiple
platforms and add some rigor to the results but I don't see anything
here that jumps out at me as being an obvious concern.  Of course
there may be differences in your kernel config that could be
perturbing the behavior, I'll continue to try and run with the virtme
configs but my internet is currently on the end of a cocktail straw so
pulling and/or building docker images is challenging.  I may go ahead
and just temporarily rent an aws instance to try and speed that part
of the process up.

       -Eric


On Tue, Jun 6, 2023 at 4:30=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Eric and other 9p devs,
>
> TL;DR: it looks like there is a (small?) problem with the new 9p
> features you recently sent and it causes MPTCP tests to be unstable. It
> is tracked there: https://github.com/multipath-tcp/mptcp_net-next/issues/=
400
>
>
> First, thank you very much for maintaining this very useful FS!
>
> For the MPTCP subsystem, we are running various tests. Many are ran by a
> public CI [1] in a VM by using QEmu with 9p thanks to Virtme [2].
> Virtme, its dependences and a script to compile the kernel and run the
> tests are "packaged" in a Docker container which eases the deployment
> and the reproduction of issues using the same environment [3].
>
>
> Since v6.4-rc1, we noticed that our public CI was reporting various
> instabilities, mainly with Packetdrill tests. Packetdrill [4] allows us
> to easily call some system calls, craft and "inject" some network
> packets and verify that the kernel generates the expected ones. It was
> difficult to reproduce the issue but after investigations, it looks like
> since v6.4-rc1, Packetdrill is slower to craft and inject packets,
> causing the kernel to retransmit packets (retransmission timeout) that
> are not expected and tests are then marked as failed. For more details,
> a ticket [5] has been opened in our public bugs tracker.
>
> I ran a 'git bisect' and found out that it seems to be caused by the new
> 9p features for 6.4:
>
>   8e15605be8ba ("Merge tag '9p-6.4-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs")
>
>
> If I revert these commits on top of our "export" branch, I can no longer
> reproduce the bug:
>
>   $ git log --oneline --reverse v6.3-rc1..21e26d5e54ab
>   d9bc0d11e33b fs/9p: Consolidate file operations and add readahead and
> writeback
>   740b8bf87322 fs/9p: Remove unnecessary superblock flags
>   8142db4f2792 fs/9p: allow disable of xattr support on mount
>   46c30cb8f539 9p: Add additional debug flags and open modes
>   6deffc8924b5 fs/9p: Add new mount modes
>   1543b4c5071c fs/9p: remove writeback fid and fix per-file modes
>   4eb3117888a9 fs/9p: Rework cache modes and add new options to
> Documentation
>   21e26d5e54ab fs/9p: Fix bit operation logic error
>
> 'git bisect' seems to suggest the issue is due to the first commit
> d9bc0d11e33b ("fs/9p: Consolidate file operations and add readahead and
> writeback").
>
> It is not clear why these modifications are causing such issues because
> the Packetdrill tests are not doing intensive read and no write on the
> disk (only stdout). Not so much info has to be read from the disk: one
> small Python script (255 lines [6]) launches multiple threads, each
> executing the same bash script (22 lines [7]) launching the same
> "packetdrill" binary (1.1 MB) in a newly created and dedicated netns.
> Then each test reads a different test script of ~30 lines, e.g. [8]. I
> think most of the time the problem is seen at the end of a test. From
> what I see [9], Packetdrill tries to read the whole test script. This is
> confirmed by quickly looking at the output of strace available on the
> ticket [5].
>
>
> It is unclear to me what else I can do and share with you to help fixing
> this "regression". I can quite easily reproduce the issue on my side and
> provide more info if needed.
>
> Just in case you wish to reproduce it on your side using our docker
> container [3], it is easy:
>
>   $ cd [kernel source code]
>   $ cat <<'EOF' > .virtme-exec-run
> for z in $(seq 15); do
>   run_packetdrill_one mptcp/dss || true
>   grep -q "[l]ive packet payload:" "${OUTPUT_VIRTME}" && break
>   rm "${RESULTS_DIR}"/*.tap; done
> EOF
>   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-debug
>
> This will compile the kernel in ".virtme" dir with the required .config.
> The VM will start and run a category of packetdrill tests 15 times. On
> my side, I was able to reproduce the issue with a busy machine and
> packetdrill had to run ~5 times. To stress my machine, I ran stress-ng
> in parallel (outside the VM) when the tests were being executed (after
> the compilation not to slow down everything), e.g. with
>
>   nproc2=3D$(nproc); nproc2=3D$((nproc2 * 2))
>   stress-ng --cpu "${nproc2}" --io "${nproc2}" --vm "${nproc2}" \
>             --vm-bytes 1G --timeout 60m
>
>
> I hope you don't mind if I cc the regression ML: this is probably not an
> important regression but I would not have guessed the issues we had when
> running network tests were due to 9p, this report might help others with
> similar issues :)
>
> #regzbot introduced: d9bc0d11e33b
>
>
> Cheers,
> Matt
>
> [1] https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net
> [2] https://github.com/amluto/virtme
> [3] https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> [4] https://github.com/google/packetdrill/
> [5] https://github.com/multipath-tcp/mptcp_net-next/issues/400
> [6]
> https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/n=
et/packetdrill/run_all.py
> [7]
> https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/n=
et/packetdrill/in_netns.sh
> [8]
> https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/n=
et/mptcp/dss/mpc_with_data_client.pkt
> [9]
> https://github.com/google/packetdrill/blob/master/gtests/net/packetdrill/=
parser.y#L168
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
