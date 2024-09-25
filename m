Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE12193412
	for <v9fs@lists.linux.dev>; Wed, 25 Sep 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273781; cv=none; b=Jm+tO3SU4DbiQ1hKAjYcIQQO7merhyUw8bavCr0e4DAFAyufEbsf9LY3cBAw/jVlZ7ZAW3Ukj+9UqSENKn1iH37Gc0UqU9jmWbvevEa7mlHZ7pKKzCzfBiwc6TonkSsl4lB2Z0sIC/FcGbK8wEJ7Zk/wPyOzI7X07cSE+8V3HRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273781; c=relaxed/simple;
	bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0w7YoWOVFYEI1LfxOklsOy1lYdZI7QAYePEMPpeLNrGOvh3SfdBu4dD4jdgTYpgRamq+loVlSrAABcQ/Qufo4ZfG4/QVgGkdObppYRyBAriUac5TNo4uMDXpeVl40SukEe9/Pe8uGQeB3TwC7FrWqJ+5Plsu27KfzA+pQAjMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmDp5Msw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmDp5Msw"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9ac0092d9so796798885a.1
        for <v9fs@lists.linux.dev>; Wed, 25 Sep 2024 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727273778; x=1727878578; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
        b=LmDp5Mswz958gFcI7HHdjajT/Ls7h18jz9wzHGUlTwNZcNw7KnE95h5FuFSnt3QcC9
         EE4r9rUE5Zl8zCdSmCiHlSATbIAW8xa0AIVwQa8bfdcmrCIwupU8Jtkoeg9KbuXsCt49
         xy1BgMov96EEyxqzQImSEMwwSJMzwxrTF6pLHWnTH5CAvkLBDbBvtJHh4XMmxrqY07Q7
         VG+lpu2gtJou41lGRpqgopR8B+hM2BKO/jGLa6yj4I1bdMgx9C2Z0CvLaY/aGSRyufA3
         YRb4BzP7qMvwk7OScxt9/pTbNQyRyEp+wKY45wVghRTxknqLzjjBIM76tadjKFOqgJxo
         gI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273778; x=1727878578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
        b=XN+Pk1A5Mi++NpeyEen4Kk3kynjuN5c7tx5+PtLuI9YSYuUXv6EV96Wg5x0Rs13snm
         qI3F+EtsAVUvzQqtEN+UMeGPo3L8fTF/6iqzqnaRjrEAoVuSM6T3FyYXvVZtzNFyay5j
         RjZPgnSVjR0KwhPvO4o52gzXby/owGUTpJgzOzSJdt8NIl/O7CHM+4jcPHTeba8YVClk
         1jqyhJ1+YRpqeTdh+8yZCOnUZsYB59QJKKtZE4I26Z3TbJcvoOywvef/4LRN2JjYZY1G
         D0YU6C/V9jHSj23sRqGb9BRWDe/TIt879CIdxAjU/Y8zchX+F9kq7++UuYYupk7fLglw
         Okxg==
X-Forwarded-Encrypted: i=1; AJvYcCWyR7SLC21+h3LDpRp2i0YdLpmD6b4iHIT8wX2jpXQ/PcQwOmDfizhYjKVXjszuZY4XBh0C@lists.linux.dev
X-Gm-Message-State: AOJu0YwRhZ9fG76vrNfE4GhkwOaJANb/zf1UXz5aKVOQpohjhNk76+1a
	aNIMTFBf+2ZNrIcAqd7rOWZIJX6tRIe1EJ+wgK+c/K1BipXRHsuQbJet4YsH7FAlm/SaZborXZp
	ESMTfnM9hIp/aHYnAtAHD2dl71jE=
X-Google-Smtp-Source: AGHT+IF3zXbFwb9usZNQiYWwUWXQ2R8F+mTXhYQZHgcWCBzoOIkDRSsLnKCX2yep9/t0y2PvVnB3vaHwUXngmZ8c4Iw=
X-Received: by 2002:a05:620a:4105:b0:7ab:36c8:6607 with SMTP id
 af79cd13be357-7ace74598d0mr353955385a.54.1727273777942; Wed, 25 Sep 2024
 07:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 16:16:06 +0200
Message-ID: <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:04=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir, Jan Kara
>
> Thanks for the responses so far. Appreciated.
>
> I have taken step back, started afresh and performed another trial using =
the fanotify example program in another WSL2 setup.
>
> 1.) Uninstalled MDE software in WSL where FANOTIFY was initialized and th=
at marks the mount point using mask: FAN_CLOSE_WRITE only. Ensured no piece=
s of monitoring software is present
> 2.) Ran the fanotify example program(without any changes) on p9 mount poi=
nt and performed git clone on another session. Git clone was successful. Th=
is program was using mask FAN_OPEN_PERM and FAN_CLOSE_WRITE.
> 3.) Modified the fanotify example program to mark the mount point using m=
ask FAN_CLOSE_WRITE only. Ran the git clone. The operation fails.

I ran the rename_try reproducer only with FAN_CLOSE_WRITE events watched
and could not reproduce.

>
> Is it something to do with mask ?
>
> I didn't get a chance to run on standard linux kernel. Can you share the =
commands to do so of mounting 9p on standard linux
>

You'd need some 9p server.
I am using the 9p mount in the kvm test box that you can download from:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickst=
art.md

Thanks,
Amir.
