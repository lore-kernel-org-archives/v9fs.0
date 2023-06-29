Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF212B90
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 16:41:56 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso13858391fa.1
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688056914; x=1690648914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1N1iL/2PbgASPq1t2DLiZ0Jv3eUwUEMrBITeFNZBr0=;
        b=lKdRj/cTRX/bAk2TDCqL/oC5u2nBNMWZPqhwcqk06ia26TkBtiFDc2ze2DPoSHetA0
         pjpJVZRdtuZFwly/0w12+Jd5oKV3cLHGfv2dMYcRbrXlYt9WDsrK4IlviOyErz6qdWUW
         kIGCbOseCfSYM/N5txtzytU0Uh56pznY3r0PF43fv2uTXCXKrXEzMd3371tAN4u4jnYn
         ACyqp363PW3mYX13jVCzOg4NXrFFSRz76c1zf6AMqJRMyVK1/aUc0rLFB28nf5Yrdu07
         48vaFMfw/yHjWRE6jZjfXnP8fRO2VDO6HszjHK5rldYSeftplbACN4EF8OTPWd0RNixS
         Dj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056914; x=1690648914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1N1iL/2PbgASPq1t2DLiZ0Jv3eUwUEMrBITeFNZBr0=;
        b=AWaEc0zNTHS7iZ+I1ox5OoxnKstxWk0p+ZspLLICNdUlamOlQHtFpNCd0TSM2WeZFo
         3iI3P3U/tMgF+a+lyE3ufZ9HTmwJaWGjidVdT9Z45ktVSelegYdQlVGGv+FqSJm3Ih0T
         gyaUBRDXWEAbpvS+5IbwK92QIopSw+Vw/y+RJ3V7v2hCOP9px+2eaHvgdbQk3JTzFcr5
         d+lk3A961nq/ihFmHPi+fnMyvgEFSwGzwrbHuKuIfh+O46Tha+qCwg9yJkuM6HLKRUUB
         tCwOPE39xiMqxvnyRzEb6WgsR8ZqgxfIpZfquPNUsZA5UQY8J4gTWRgs2UysH+z4eNjj
         ghIQ==
X-Gm-Message-State: ABy/qLaaMGkNr0TqzYNfTOwFAG2+5EYjRKrSUt8WgExBq7ctXVEA75MV
	laRRU2KMkr0osF/B9m6+y4UD54zdQ3b6xTE/WPwLtA==
X-Google-Smtp-Source: APBJJlFWHdaDfqUfeTKH+vBq7rsRq+y0haLhdWy0UYYOC0QASs6MpYmPSsF4NPkei2meeTxlZoRJUQ==
X-Received: by 2002:a2e:9844:0:b0:2b6:ccc1:39e with SMTP id e4-20020a2e9844000000b002b6ccc1039emr154255ljj.53.1688056913910;
        Thu, 29 Jun 2023 09:41:53 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id lh8-20020a170906f8c800b009923998c8acsm2870155ejb.20.2023.06.29.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 09:41:53 -0700 (PDT)
Message-ID: <34d5623d-b7e7-aa9e-88fb-42cb9993bc0e@tessares.net>
Date: Thu, 29 Jun 2023 18:41:52 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
 <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net>
 <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 29/06/2023 17:17, Eric Van Hensbergen wrote:
> one thing that may be worth taking a look at in your test environment
> is confirming that there is no "accidental access" to the synthetic
> file systems (/sys or /dev) via 9p -- usually the /dev ones wouldn't
> be problematic, but if they were being accessed via 9p that may be a
> corner case perturbing performance in a way we don't typically test.

Interesting, I didn't even know it was possible to do that :)

I guess we are OK on our side because even if the root partition is
mounted with 9p, /dev and /sys have their own mounting points:

> # mount
> /dev/root on / type 9p (ro,relatime,sync,dirsync,access=any,trans=virtio)
> devtmpfs on /dev type devtmpfs (rw,relatime,size=1011372k,nr_inodes=252843,mode=755)
> run on /run type tmpfs (rw,relatime)
> virtme.guesttools on /run/virtme/guesttools type 9p (ro,relatime,sync,dirsync,access=any,trans=virtio)
> sys on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
> none on /usr/lib/modules type tmpfs (rw,relatime)
> tmpfs on /tmp type tmpfs (rw,relatime)
> tmpfs on /var/log type tmpfs (rw,relatime)
> tmpfs on /etc/fstab type tmpfs (rw,relatime)
> tmpfs on /etc/shadow type tmpfs (rw,relatime)
> proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
> virtme.initmount0 on /home/(...)/mptcp_net-next type 9p (rw,relatime,sync,dirsync,access=any,trans=virtio)
> debugfs on /sys/kernel/debug type debugfs (rw,relatime)
> tracefs on /sys/kernel/tracing type tracefs (rw,relatime)
> tmpfs on /sys/fs/cgroup type tmpfs (rw,relatime)
> cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,relatime)
> devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
> tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,relatime)
> tmpfs on /etc/resolv.conf type tmpfs (rw,relatime)

Or is this already an issue?

> The other would be to cross check there is no log file writing via 9p
> -- again, this should be something that works, but I could imagine the
> more synchronous write behavior which we are now doing a better job of
> enforcing when cache=none could cause synchronous delays that might
> perturb performance of your tests.  A workaround for the latter would
> be to write the log to a tmpfs and then copy to 9p when done.  The
> other potential is just to enable caching (cache=mmap should be
> sufficient) in your virtme configurations.  The new readahead and
> writeback cache modes should be consistent enough for your use case.
> I didn't suggest that earlier because I wanted (and still want to)
> understand the problems you are seeing.

Thank you for the idea. We are writing the output of qEmu from the host
(docker), not from the VM. We are writing it in the same directory as
the one mounted in the VM with 9p in RW mode but I guess that's not an
issue, right?

When we execute a test, the output is also written in a dedicated file
but this time from the VM and into the same directory as the one mounted
in the VM with 9p in RW mode. But when we reproduce the original issue
with Packetdrill, Packetdrill is not printing anything in stdout until
the end of the test or until an error happened. So likely before or
after. Also, Packetdrill is not writing anything in the FS when
executing tests as far as I know.

So I think not so much is written in the FS when executing the tests.
But there is a bit of text (~15 lines) printed just before executing the
next one: to reproduce the issue, the tests are executed in a loop.
Could this have an impact?
If yes, I can look at adding "cache=mmap" but for that, I guess I need
to modify virtme to change how the directories are mounted, I don't have
a direct control on that and I guess I cannot do a remount once the VM
is ready, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
