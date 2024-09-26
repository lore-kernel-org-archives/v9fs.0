Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B441A4F18
	for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342524; cv=none; b=ng8frBUmhFpnv/4Pskvuu5maKLM3p+TgoRO33zGzLO0PD4vACKpQQovgFhNPze7UR1Y1rT/96ucOO0GdLgv0UR2DqBRYR18Ct65Hvp0ecgVojcSXiFAL6bd/ZVsPJhX4FCCrkmIwNyug1dLX955eFwdoetf4AwMb3eTZJRhGnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342524; c=relaxed/simple;
	bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebDRZpq0E5KTvhTEUJM7myEJbCm7PnJ0SZMRUKsSFZWBkNgiRKILg8B2N2ouj4tRhqoBYxg9f89Z4GPQpz+krd1Yfm4Y7updVY4QXrawNVVcI04zLVh6oKX+7xZ+l6zuXoSzhE6t5hflJNeBur0lPdogIq6MA3NHJaR5WxhqV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRk5kq4U; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRk5kq4U"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb284c1a37so6339656d6.1
        for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342522; x=1727947322; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
        b=JRk5kq4UYhKxnI9Yq3N3I+GH/fDdpV3CAOL+ex0qNNypBpp+ZdYx+ncd2Dh1jlPwM3
         LmmIAaHzMIRR7FPuIqhGDVYVFFoFlZmaG4Y2zAlpIKeoU+CGwe5a8vxgYBcQmatmvnVT
         nA8+fvS0gIk+2UYNa0Z8jUtEIz9z3y2DgCZCfWs1NHRU/PEF3xzlqbwKwfgf2ldq7jLo
         Up8SDveKoPU5I2YEk8cR7IYHtRMuvh8vP5lvlJ3LhHulVELuS1rX0nnIBV6frnsy2Et/
         ZeZ2fM2B6fInaqSB9VXJGUFD7kkJ2qbZE2Db0s1P/pKoGvMnlIA7LbbP7vdrLQFvoLfg
         ixSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342522; x=1727947322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
        b=qxcqUCtOTwCadjqjUNLYhDyAhE+ar11wYPY6QtvU6lMkH1snj64fSHJ/yduy8A4jbV
         TQoqcybGyqeS/cS+/oAiJIIpV+8tE8ItTD1KUHKIADdkvioEBvM88898uiX1ijZvz1Uc
         1vxAbk/BXxj9cy+n8ncludV/ZxQwgX5DAWhD4D4eL98RiiuQI1NwWIYYF6o5pwvbaOpA
         4QIje3LPbQ1FwXMhOaa+TXzjtSRXfWEmOe8K14InLgzv5ucUNCwPDaLtEZK1gAG0Kux8
         Y9jYclg2Cym5Dwy+4yHn65Mw9JebkEWp82aXVBvArO/OEG0DIpX31vllBrZLstTQ4qvW
         X/lg==
X-Forwarded-Encrypted: i=1; AJvYcCVJJ0kREzC8r5RFT+xfqzmjp/oZdjopUSY7wUssoet3qwnoJQuyCjmsd9hRw9PRrG54wgtW@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2Bu2zjRHd0e9jiXMnvBexbhLQkBvErlt3qW4+x2HSmof0O2Q7
	wTvk/TfF6thLFvn+BSCdccrSd1UT226oanbTTB/iCmRMzFnbXK+0c72MmI8KUxztLlYkcrwQFNi
	U3p7n9dtJKaC0EUqdcl642xPMVpA=
X-Google-Smtp-Source: AGHT+IGTGQbxnPkrcXwhC0RHu9JpOHoGPstrY7a/0JZjUnO55Bki5ImivLgmBuODE3d4woKLswJJJ0MSPaMokpOB0Rg=
X-Received: by 2002:a05:6214:3a83:b0:6cb:1b71:9446 with SMTP id
 6a1803df08f44-6cb1dd15bdcmr79793016d6.9.1727342521749; Thu, 26 Sep 2024
 02:22:01 -0700 (PDT)
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
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com> <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 11:21:50 +0200
Message-ID: <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:44=E2=80=AFAM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir
>
> Thanks for the outputs. From your analysis, it is found that there are so=
me dentry references that are causing issues in p9 to report ENOENT error.

Yes, and my guess is that the MDE software running on your machine had reac=
ted
fanotify_read() error as a threat and removed the .config file, that is why
it could not be found by the open syscall??

>
> Few questions:
> 1.) What is the kernel version of your setup ?

Latest upstream master.

> 2.) Is there any command/tool to check the marked mount points ?
>

Yes and no.
No "tool" that I know of, but the information is usually available.

There is a way to list all the fanotify group fds of a process or processes=
:

root@kvm-xfstests:~# ls -l /proc/*/fd/* 2>/dev/null |grep fanotify
lrwx------ 1 root root 64 Sep 26 09:02 /proc/1928/fd/3 -> anon_inode:[fanot=
ify]

and there is a way to list the marks set by this group:

root@kvm-xfstests:~# cat /proc/1928/fdinfo/3
pos: 0
flags: 02004002
mnt_id: 16
ino: 2058
fanotify flags:7 event-flags:8000
fanotify mnt_id:58 mflags:0 mask:40010008 ignored_mask:0

mnt_id is in hex (0x58), so it needs to be translated to mount point like t=
his:

root@kvm-xfstests:~# cat /proc/self/mountinfo |grep ^$((0x58))
88 21 0:34 / /vtmp rw,relatime shared:46 - 9p v_tmp
rw,access=3Dclient,msize=3D262144,trans=3Dvirtio

For inode and super_block marks, the identifier is the st_dev (also in hex)
so some more conversions are needed to map it to device number as 0:34.

lsof does come to mind as a tool that could be enhanced to provide
this information,
but perhaps a specialized fsnotify tool is in order.

I created https://github.com/amir73il/fsnotify-utils a long time ago
with the intention of writing some useful tools, but that never happened...

> What would be the next steps for this investigation ?
>

I need to find some time and to debug the reason for 9p open failure
so we can make sure the problem is in 9p code and report more details
of the bug to 9p maintainers, but since a simple reproducer exists,
they can also try to reproduce the issue right now.

Thanks,
Amir.
