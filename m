Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840DBE55
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379849; cv=none; b=fDHFH7nAX8nfr7e69reL7mN7429gvNaG6pUA7pJi5gPFnGlFBwixCODpjHiSB4EFfcSj3UOsMZJsa8XD0YhYHLlwIlonWhp792tGcGZzZu4SyzdWruaN0Hc+05IeEJj7iE02KlkNAruaZ6rJi5Kp7prAXzrREy2g7KW9PEYHZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379849; c=relaxed/simple;
	bh=wQ4xk+vYL9gvZQsHSLqHG1L6ZA0lwXNkIGJADiDeGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQDYpXhEl9NgmiU6KPhjQLZBFeUbdWMK+Tcj0jIp4BK2wCgOQKsJZLanfwm7ezBvYSw8T35y6EKkSp7TG/jNbML3BexeABWqI6c4bRbZEBYzdiGuZ1uWFM6O3zb09AHBfqb8+y3hId3Qbkc+sFQ4y8EbFOuPzln/FPi8iPQVoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCDP1Frz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCDP1Frz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862CFC072AA
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379848;
	bh=wQ4xk+vYL9gvZQsHSLqHG1L6ZA0lwXNkIGJADiDeGPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vCDP1FrzqvTHWmfYdHOaMx0OnPJeTERRV+LRasparMcauCjCjfQsQ9H3Suw1EmWhx
	 TApgclEpIYTHD+nJoAg7E/hoSH2UzXxy0ptRdrCk3SenyDTmW0mZ2cQRR3SqqCBtU4
	 OWw7rP3EVVmfcsnyx0UjqJKkhGZtkCrOHYL/d3ST6+R4t+7RnMW5OUZBsPTVPvDhkm
	 7iKwMCxLYQlvCxoym7a59RhGip5Tmiyg83WrBGhSVHy41tky/pEoiS6R8yTq64Xvbe
	 IXeG4RCAdla/+PgppI1jj127lpoKhWowdV1xa3TsIOe7y4rOqDMLDfPvbB4/3VmVms
	 qP/4HuvSGPXqA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-615019cd427so45182917b3.3
        for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 11:50:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YwNZLnu27WcE7Xc5peTZJygah6W5LC1RNbqAwvBPjC0WV4Wff43
	W4R8FpDIMT05Phv6E7+vjmLN7jnO6OrNHHBCGHA9ARrr9qN7Q0n+iWooCumtirqlIS15jxUK9H7
	lKlcZBXYwk71q5ZuxgdTm8w1VOR4=
X-Google-Smtp-Source: AGHT+IF2ntNYghwCg7tLF2YeX1zbvBMgvt4sYKF3oEMHTbaUTaDopbD93n1Nxrq5wphwZ9JErDoTDlJBlpnee3RT5xI=
X-Received: by 2002:a05:690c:6c8c:b0:615:e0e:d234 with SMTP id
 is12-20020a05690c6c8c00b006150e0ed234mr139449ywb.16.1713379847883; Wed, 17
 Apr 2024 11:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5d527d1e-95de-4e36-845a-897cabdcaccd@moroto.mountain>
In-Reply-To: <5d527d1e-95de-4e36-845a-897cabdcaccd@moroto.mountain>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 17 Apr 2024 13:50:34 -0500
X-Gmail-Original-Message-ID: <CAFkjPTkWEV6aBAzgcgOB_fX_6C7notJB55y-m0tkQOHCnPMe9A@mail.gmail.com>
Message-ID: <CAFkjPTkWEV6aBAzgcgOB_fX_6C7notJB55y-m0tkQOHCnPMe9A@mail.gmail.com>
Subject: Re: [bug report] fs/9p: mitigate inode collisions
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:12=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Eric Van Hensbergen,
>
> Commit 6ae7784008d9 (" fs/9p: mitigate inode collisions") from Apr
> 15, 2024 (linux-next), leads to the following Smatch static checker
> warning:
>
>         fs/9p/vfs_inode.c:513 v9fs_remove()
>         error: uninitialized symbol 'v9fid'.
>

Thanks for this, I've amended the patch to remove the print in
question since it was actually vestigial telemetry while I was
debugging and shouldn't have been in the patch in the first place.

     -eric
