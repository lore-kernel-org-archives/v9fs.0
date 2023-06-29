Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905413AC3
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 17:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16EAC433C8
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688058287;
	bh=W0mxEfbyindhWHCwf6Y2WlWdGb10FbEVlaSRMRxxYvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iGRT7dOIJpMOBcfd3tXeh2Jvt6720YUIfRXjAizv4mNSx50cU4f2XA4/c2UDD3S+C
	 Z3gAZPt11HVEyA64Abxca+eW0ExZr3oZVLTUwvgIpHTmHi7uv8pJ5fR8SmPqLyo7d9
	 9Y08haDcngD0n39r405PXJe9PnvFh2R65tVO5zrdn2VU/Gj/qJooiYqwRhR6NFdQ6f
	 Ih+ZH2NijKsqJ428seraHmVXvUpkh/0GJgLyl+43iP4KoT71b9qn6OSBBI1rQYI1eQ
	 XeioX8Cv6d+V394hbt1i/9dO6RsYTU8ibOT6paNjsr1iwB8pa3YLfA9xGq9xRm5MsV
	 ITo0t/FrU0vUw==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c3896b4dbd0so777537276.0
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 10:04:47 -0700 (PDT)
X-Gm-Message-State: ABy/qLae5kWdoPZbNmQ9F/kADEkJW+ERCjVo0wuXuFvWbbgbyq+MWkE9
	dhPt+hzsKTOpSBSuzfbFpMjeNguEvtgXSf5jxHw=
X-Google-Smtp-Source: APBJJlENO8TDCYMuDmQUOD/QHPcsqL1yTeF1LsvseLMdAovn8W9cklTQwte/hHEgq1duMX53qxgYA8vlBzOZ/znct80=
X-Received: by 2002:a25:ac0c:0:b0:c3e:8e3d:f605 with SMTP id
 w12-20020a25ac0c000000b00c3e8e3df605mr492743ybi.48.1688058286794; Thu, 29 Jun
 2023 10:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
 <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net> <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
 <34d5623d-b7e7-aa9e-88fb-42cb9993bc0e@tessares.net>
In-Reply-To: <34d5623d-b7e7-aa9e-88fb-42cb9993bc0e@tessares.net>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Thu, 29 Jun 2023 19:04:35 +0200
X-Gmail-Original-Message-ID: <CAFkjPTk_7ceY5495Ro0BdLVwN_xKQG-um0ny=5PrZOwYXjM1vg@mail.gmail.com>
Message-ID: <CAFkjPTk_7ceY5495Ro0BdLVwN_xKQG-um0ny=5PrZOwYXjM1vg@mail.gmail.com>
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

inline

On Thu, Jun 29, 2023 at 6:42=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Eric,
>
> On 29/06/2023 17:17, Eric Van Hensbergen wrote:
> > one thing that may be worth taking a look at in your test environment
> > is confirming that there is no "accidental access" to the synthetic
> > file systems (/sys or /dev) via 9p -- usually the /dev ones wouldn't
> > be problematic, but if they were being accessed via 9p that may be a
> > corner case perturbing performance in a way we don't typically test.
>
> Interesting, I didn't even know it was possible to do that :)
>

Well, there is a special mode which usually isn't enabled on mount which
is nodevmap which does allow you to access the devices on the host,
without that, even if you were accessing devices on the host file system,
they should still be serviced by the devices inside the vm.  sysfs a bit
more complicated as those are treated as files.  But from your mount
list, it looks like you have stuff mounted in a way that shouldn't be a
problem.  Thanks for cross-checking, its one less thing to worry about.

> > The other would be to cross check there is no log file writing via 9p
> > -- again, this should be something that works, but I could imagine the
> > more synchronous write behavior which we are now doing a better job of
> > enforcing when cache=3Dnone could cause synchronous delays that might
> > perturb performance of your tests.  A workaround for the latter would
> > be to write the log to a tmpfs and then copy to 9p when done.  The
> > other potential is just to enable caching (cache=3Dmmap should be
> > sufficient) in your virtme configurations.  The new readahead and
> > writeback cache modes should be consistent enough for your use case.
> > I didn't suggest that earlier because I wanted (and still want to)
> > understand the problems you are seeing.
>
> Thank you for the idea. We are writing the output of qEmu from the host
> (docker), not from the VM. We are writing it in the same directory as
> the one mounted in the VM with 9p in RW mode but I guess that's not an
> issue, right?
>

Yeah, if its writing to the underlying filesystem not through the 9p
mount, this shouldn't cause any problems.

> When we execute a test, the output is also written in a dedicated file
> but this time from the VM and into the same directory as the one mounted
> in the VM with 9p in RW mode. But when we reproduce the original issue
> with Packetdrill, Packetdrill is not printing anything in stdout until
> the end of the test or until an error happened. So likely before or
> after. Also, Packetdrill is not writing anything in the FS when
> executing tests as far as I know.
>

Okay, then not likely a write versus writeback problem.

> So I think not so much is written in the FS when executing the tests.
> But there is a bit of text (~15 lines) printed just before executing the
> next one: to reproduce the issue, the tests are executed in a loop.
> Could this have an impact?

I wouldn't think so, I was more worried about it printing something
which gets synchronously written to a log in between packet writes
which might delay them...but doesn't sound like its doing anything
like that.

> If yes, I can look at adding "cache=3Dmmap" but for that, I guess I need
> to modify virtme to change how the directories are mounted, I don't have
> a direct control on that and I guess I cannot do a remount once the VM
> is ready, no?
>

That's correct, mount -o remount probably behaves badly with 9p as a
root file system mount.

The conference I am at with horrible internet is over tomorrow so
perhaps I'll be able to get a proper virtme / mptcp regression
environment going over the weekend to try and continue to drill down
on what might be the problem.
In the meantime I'm fixing up my own regression infrastructure to
start recording latency information to make sure we aren't getting any
performance regressions from either latency or bandwidth as we
continue to work on 9p in the future.

        -eric
