Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4211E86F
	for <v9fs@lists.linux.dev>; Mon, 16 Sep 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502166; cv=none; b=iiQui05mSpusMVMig1Rb2jCm8sIaUEGeNRaNqX6+VPD5QZJVzctn37OD33XE54E0OTYthPEoNFIBdOCbWHcdaioY6RJdRNeQGGKQnU0H9Qb1+gQoMNdtEp1MAsFT8Fegx+/khy7RKbITkqtY9C1CLiKAI56sYenVF7g/e/SzGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502166; c=relaxed/simple;
	bh=gddqMA1HW6jsJyV9BMVWRs/OHSTXSaMOXtcnLrdV7Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diTD60/zeqNdXiF8Rk3vDG2r8vuQbj4/Va0kc9loTRuPjOoumXpovmP60IYXytmSPHUasS1VG6B6QDunaHqgocHjJNjXHjGn9aeRfKwIsP5NIKPEj3P+dGQYGBbI8b1R8zSKo6f/8AnTCgpW1jj2uyqQ/9QqGtTBAuW/Y3yLL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyWytJnL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyWytJnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0129EC4CEC4
	for <v9fs@lists.linux.dev>; Mon, 16 Sep 2024 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726502166;
	bh=gddqMA1HW6jsJyV9BMVWRs/OHSTXSaMOXtcnLrdV7Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FyWytJnL2Vlsxf0wWwSzA4J7FgvqSysk7ZK66cfR/ZXCm48U4XMSLxAE+ojwFipnW
	 TYNPq1/e795D6AzVqXAAR/Z526bMsDYcL1jdjqGj9w6QWhnyWBSpv3jAfBjj0heA0/
	 e8HwrCtP5eTteVHc0wiKiBq5qS7lLBYnthhQb6+SnJWo3BIl2Of3CypWgaBs4wgl+/
	 Ogel+Io2/yH6y1YHd0EBIE15jAfyfZGuUOZAs3QVM2TZOvLXGF1bakBHOmOmkX4DrG
	 wRi6HANoZit6rCrCs/99QPtUYewLWjKaGANFL/ZA8rQL4hVi7c3+SgORYi4z2rUVQo
	 hQx1OM9aroDYg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6db67400db4so38443707b3.1
        for <v9fs@lists.linux.dev>; Mon, 16 Sep 2024 08:56:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjitJSxRiuaaScIKerIzFvSafh0G5RCxgDzsqPpCZsBAMJUg8/
	59Q3jM3WHCiw1ihBsdhu3JhN+NUaWGmWm/KqBkYD2VfQOn0TdGFvb8NuXl4ISecwBDjsWlhIYKK
	Xm4UOTSZkqIV7MS/MdExmdCCMBzs=
X-Google-Smtp-Source: AGHT+IFWuWq7/sjTEpr0lGc+KBhR4Jb3aOaJt6B1fthA/F1h/dulclwNdc1aogQRa8BRvNvEZq2txba+PVuTKQnRdZM=
X-Received: by 2002:a05:690c:2c88:b0:6db:db7b:891c with SMTP id
 00721157ae682-6dbdb7b8f51mr56665117b3.14.1726502165325; Mon, 16 Sep 2024
 08:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2P153MB0718323CDDFEA160D7DC892AD4602@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SI2P153MB0718323CDDFEA160D7DC892AD4602@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 16 Sep 2024 10:55:53 -0500
X-Gmail-Original-Message-ID: <CAFkjPTm2edfEfiABJYGa7RbYCFdn_NuDzUXx91oBugB8Wcq1dQ@mail.gmail.com>
Message-ID: <CAFkjPTm2edfEfiABJYGa7RbYCFdn_NuDzUXx91oBugB8Wcq1dQ@mail.gmail.com>
Subject: Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reporting this.  I'll have a look at the code -- but from
the protocol perspective there may be issues with any sort of
asynchronous event reporting (as I expect FANOTIFY to be doing) since
the 9P protocol doesn't support server generated async events.  But
its been a while since I've looked at these code paths so I'll double
check.

Do we know if git has a backup for filesystems that don't support
FANOTIFY (or is it even git that is marking the filesystem)?  The
mitigation might be to have your server report an error when it is
used and then ideally git uses a fallback mechanism.  I expect what is
likely happening is the protocol is presenting FANOTIFY to the server
which is setting up a similar mechanism on the underlying file system
-- but then has no way to propagate back the event(s) -- and so the
client proceeds as if there wasn't notification and is blowing up
later on.

If at all possible it would be good to see a 9P trace from either the
client or server perspective (or both) when reproducing this.  This
can be enabled on the linux side by enabling 9P debug in the kernel
and then passing debug=3D<flag> to get the appropriate verbosity.  I'll
admit I'm less familiar with how to get WSL2 server side to give you
similar telemetry.

Thanks,
    -eric

On Mon, Sep 16, 2024 at 10:22=E2=80=AFAM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
>
>
> Hi experts,
>
>
>
> Need your help in identifying the root cause for issue.
>
>
>
> We=E2=80=99ve seen multiple reports of git repositories failing to clone =
/ getting corrupted in p9 file system (in WSL 2). The mount points under th=
is file system are marked for FANOTIFY to intercept file system events
>
>
>
> When we remove the marking on these mount points, git clone succeeds.
>
>
>
> Following is the system information
>
>
>
> root@DESKTOP-OOHD5UG [ ~ ]# cat /etc/os-release
>
> NAME=3D"Common Base Linux Mariner"
>
> VERSION=3D"2.0.20240609"
>
> ID=3Dmariner
>
> VERSION_ID=3D"2.0"
>
> PRETTY_NAME=3D"CBL-Mariner/Linux"
>
> ANSI_COLOR=3D"1;34"
>
> HOME_URL=3Dhttps://aka.ms/cbl-mariner
>
> BUG_REPORT_URL=3Dhttps://aka.ms/cbl-mariner
>
> SUPPORT_URL=3Dhttps://aka.ms/cbl-mariner
>
>
>
> root@DESKTOP-OOHD5UG [ ~ ]# uname -a
>
> Linux DESKTOP-OOHD5UG 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 2=
9 23:14:13 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>
>
>
> On collecting the strace of the operation(git clone <repo link>), it is f=
ound that renaming file name from .git/config.lock to .git/config and subse=
quent read of that latter is failing.
>
>
>
> Any known issues in this regard ?
>
>
>
> Let us know if you require further information.
>
>
>
>
>
> Thank you,
>
> Krishna Vivek
>
>
