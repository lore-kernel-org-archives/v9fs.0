Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9D34FF51
	for <v9fs@lists.linux.dev>; Tue, 21 Oct 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065789; cv=none; b=QAdM27pfriYqWB4mozHxfC/KLgIWMja9XumaV462w7EG6WIEoxLile9ENxSjTkbWgyX9zyXSalSlrP8TtN+MNeyybnCt6UDNnJhAEczHRVFy+tGHISS07pccUWqFG8K0K1J10aooQKgDvXu1eRKKuLPr3y1eAGk8xM80mCwDtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065789; c=relaxed/simple;
	bh=WCDM0Dh/P1MJegYmmTqfY461iQGVC1KbUiBxRCf+N9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFIVDu4PHp1DEPcEvwuj5V6Bbb09RWDOBzEo9Ut9QbqtUVL/ceoQ6cr1FkvRRz0zU4gJbmyHAyU/C09Nu54Gjfh2Yzj5ll0svaP7k7AuWVhYzqiuU68nltibm2EFEAF4eFdD5T9lffB5i3+TLMX9b7Eo0OhjRYzyTbGjTH44kIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5yWdxue; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5yWdxue"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426fc536b5dso3257913f8f.3
        for <v9fs@lists.linux.dev>; Tue, 21 Oct 2025 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065784; x=1761670584; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eulPDt+BGqCCZUMmq5c3Qn/igljkUZkpKio7rpKRew=;
        b=T5yWdxue9CtlqpplXYUKP4AGoz90rZHmKNJ/WhmgKvKHLdEqSfo4t7IfFBVWmMSdgB
         WNJ7Xxvl/GoR9so+rZJ0De+Z0pAAvCb5WCgas01k0k/qdNBKWclfuTv4oBUEyC0ybsMi
         ugYOR8g3fEl5v8N0Js++e+9SxT7y6i5JB5tlGv7avfgtMKr3/7SMR/aovDfLwqO46jzi
         VIZT7iO0jfpnT024tynxKWru2873a0Wu3Oh7om5GrpWPnUVVETH4lFgS9+g4Vp45wcY3
         9GME3dYsZ6zRI2Y1/WdAJQWNFR9Jpy/KnpfORV39+HroqsS3EgckPUxtBSLVviEiJpcb
         JIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065784; x=1761670584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eulPDt+BGqCCZUMmq5c3Qn/igljkUZkpKio7rpKRew=;
        b=Btvm+ICTmyegS48WKnnB09727mzCSeCzKbdw8Hak/71vHDBQ0mp4A/bVApRm/8hTOM
         PtUabPqbiEQO4CZYik41NFaXwc6oFrGgt7x+yc+nm+nIw7cx5x10To0J0sRSlvp9Hj9G
         BR8WV8109FfuKlZcPS5ehMp/mgE2y2d1hdUTA3alpUFXO/kE2fptmuNTd2UH44E1rgy8
         BYU/oBG6fpfg9BIFWbVSVSP9jx5wXdtHlT34GI4AEj/9RK+TsWyEGIpRiq/4LYPxfzvr
         jVbDdycuDX0oPOQrA8fk4g+JTDwJ9WRarAFXWLxZjd87ggsb5Dr0om5NgWLfIo9NxrRZ
         bt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAPnoKVWsxOA4uVDRRDjxznsoUo6QAEwvCg3XXoYXMXsKlpMWNFFMrRmMZ3ibL0AxsN2cu@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpo2PQ14OPjkvO2VrfPqHgJnI4Lhm/F+WsB+0gh0NB2bRpaMEx
	vdoKby/QIWCCn+KNrRSH/IU06HHnakv21QvzEuMrgvtC1a3cBUuNqg7xc7fIQ/kyvpPF2BcQmY0
	Ouna3x6d3MPFA7pd79IuT7Lj0DAnJgGA=
X-Gm-Gg: ASbGncsrVZB31MK/cphpUXaYiJQdCi/cCM1Rr+CjUpXggs4+BsyYWPzOVrSQuqHlFUy
	KgVt6TgaBiQ3kk44SRXr6msniPnMdQG6IqKvDjjerkI9fICjdy7sVDl48N40qOpjuT6EWyBfP/f
	qjZn4YIaEreAbLp9e+R4B8hK2mX894pOQ+xOiPrLXLdwzwDyrqdwT2xFpXUsT/6cWA4Yi9OMLns
	ScqkqUIg7FJ4IhMZ4uB+3Gid8CEivP2Wf1yqAVDjWb5iffLoSLv+dH+inMl71hNXJMI1sHLPxy8
	wpZR+3biTHM=
X-Google-Smtp-Source: AGHT+IEadp2PmK+XtjDgRfhWlPpP2KXyboEQ/xZ2EcD7NQBdN8VXo6Vfnfcn5ob2/xI2no+srLQzu+gtG6Xptg9UP9s=
X-Received: by 2002:a05:6000:2586:b0:403:8cc:db6b with SMTP id
 ffacd0b85a97d-42704db4467mr12927690f8f.35.1761065783956; Tue, 21 Oct 2025
 09:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org> <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
 <aPaqZpDtc_Thi6Pz@codewreck.org> <CAHzjS_uEhozUU-g62AkTfSMW58FphVO8udz8qsGzE33jqVpY+g@mail.gmail.com>
 <086bb120-22eb-43ff-a486-14e8eeb7dd80@maowtm.org> <CAHzjS_vrVJrphZqBMxVE4UEfOqgP8XPq6dRuBh9DdWL-SYtO2w@mail.gmail.com>
In-Reply-To: <CAHzjS_vrVJrphZqBMxVE4UEfOqgP8XPq6dRuBh9DdWL-SYtO2w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 09:56:10 -0700
X-Gm-Features: AS18NWBYHfGvvDiun6RLm7u4qqcsiuYJsoCSKClE1yohs0Ed4-TUGooDKRR6fSA
Message-ID: <CAADnVQKSJTAx-4T4WLFhLPcmJ-Ea5onKG+Z-d9iv48r4A6nJMQ@mail.gmail.com>
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
To: Song Liu <song@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:49=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi Tingmao,
>
> On Mon, Oct 20, 2025 at 5:54=E2=80=AFPM Tingmao Wang <m@maowtm.org> wrote=
:
> >
> > On 10/20/25 22:52, Song Liu wrote:
> > > Hi Dominique,
> > >
> > > On Mon, Oct 20, 2025 at 2:32=E2=80=AFPM Dominique Martinet
> > > <asmadeus@codewreck.org> wrote:
> > >>
> > >> Song Liu wrote on Mon, Oct 20, 2025 at 12:40:23PM -0700:
> > >>> I am running qemu 9.2.0 and bpftrace v0.24.0. I don't think anythin=
g is
> > >>> very special here.
> > >>
> > >> I don't reproduce either (qemu 9.2.4 and bpftrace v0.24.1, I even we=
nt
> > >> and installed vmtest to make sure), trying both my branch and a pris=
tine
> > >> v6.18-rc2 kernel -- what's the exact commit you're testing and could=
 you
> > >> attach your .config ?
> > >
> > > Attached, please find the config file.
> > >
> > > I tried to debug this, and found that the issue disappears when I rem=
ove
> > > v9fs_lookup_revalidate from v9fs_dentry_operations. But I couldn't fi=
gure
> > > out why d_revalidate() is causing such an issue.
> >
> > I've compiled qemu 9.2.0 and download the binary build of bpftrace v0.2=
4.0
> > from GitHub [1], and compiled kernel with your config, but unfortunatel=
y I
> > still can't reproduce it...
>
> Thanks for running these tests.
>
> > I do now get this message sometimes (probably unrelated?):
> > bpftrace (148) used greatest stack depth: 11624 bytes left
> >
> > I don't really know how to proceed right now but I will have it run in =
a
> > loop and see if I can hit it by chance.
> >
> > If you can reproduce it frequently and can debug exactly what is return=
ing
> > -EIO in v9fs_lookup_revalidate that would probably be very helpful, or =
if
> > you can enable 9p debug outputs and see what's happening around the tim=
e
> > of error (CONFIG_NET_9P_DEBUG=3Dy and also debug=3D5 mount options - I'=
m not
> > sure how to get vmtest to use a custom mount option but if it's
> > reproducible in plain QEMU that's also an option) that might also be
> > informative I think?  I'm happy to take a deeper look (although I'm of
> > course less of an expert than Dominique so hopefully he can also give s=
ome
> > opinion).
> >
> > I'm also curious if this can happen with just a usual `stat` or other
> > operations (not necessarily caused by dentry revalidation, and thus not
> > necessarily to do with my patch)
>
> I used strace to compare the behavior before and after the change.
> It appears to me that bpftrace didn't get -EIO in the error case. Instead=
,
> it got 0 bytes for a read that was supposed to return data.
>
> Success case:
> ...
> openat(AT_FDCWD, "/tmp/bpftrace.Rl1Vkg",
> O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600) =3D 3
> write(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0=
\0"...,
> 4352) =3D 4352
> openat(AT_FDCWD, "/tmp/bpftrace.Rl1Vkg", O_RDONLY|O_CLOEXEC) =3D 4
> newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D4352, ...}, AT_EMPTY=
_PATH) =3D 0
> read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0\=
0"...,
> 8192) =3D 4352
> close(4) =3D 0
> ...
>
> Failure case:
> ...
> openat(AT_FDCWD, "/tmp/bpftrace.LbbDxk",
> O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600) =3D 3
> write(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0=
\0"...,
> 4352) =3D 4352
> openat(AT_FDCWD, "/tmp/bpftrace.LbbDxk", O_RDONLY|O_CLOEXEC) =3D 4
> newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D0, ...}, AT_EMPTY_PA=
TH) =3D 0
> read(4, "", 8192) =3D 0
> ...
>
> So the failure case is basically:
> 1) open a file for write, and write something;
> 2) open the same file for read, and read() returns 0.
>
> I created a small program to reproduce this issue (attached below).
>
> Before [1], the program can read the data on the first read():
> [root@(none) ]# ./main xxx
> i: 0, read returns 4096
> i: 1, read returns 0
> i: 2, read returns 0
> i: 3, read returns 0
> i: 4, read returns 0
> i: 5, read returns 0
> i: 6, read returns 0
> i: 7, read returns 0
> i: 8, read returns 0
> i: 9, read returns 0
>
> After [1], the program cannot read the data, even after retry:
> [root@(none) ]# ./main yyy
> i: 0, read returns 0
> i: 1, read returns 0
> i: 2, read returns 0
> i: 3, read returns 0
> i: 4, read returns 0
> i: 5, read returns 0
> i: 6, read returns 0
> i: 7, read returns 0
> i: 8, read returns 0
> i: 9, read returns 0
>
> I am not sure what is the "right" behavior in this case. But this is
> clearly a change of behavior.
>
> Thanks,
> Song
>
> [1] https://lore.kernel.org/v9fs/cover.1743956147.git.m@maowtm.org/
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D reproducer =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> char buf[4096];
>
> int main(int argc, char *argv[])
> {
>         int ret, i;
>         int fdw, fdr;
>
>         if (argc < 2)
>                 return 1;
>
>         fdw =3D openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC=
, 0600);
>         if (fdw < 0) {
>                 fprintf(stderr, "cannot open fdw\n");
>                 return 1;
>         }
>         write(fdw, buf, sizeof(buf));
>
>         fdr =3D openat(AT_FDCWD, argv[1], O_RDONLY|O_CLOEXEC);
>
>         if (fdr < 0) {
>                 fprintf(stderr, "cannot open fdr\n");
>                 close(fdw);
>                 return 1;
>         }
>
>         for (i =3D 0; i < 10; i++) {
>                 ret =3D read(fdr, buf, sizeof(buf));
>                 fprintf(stderr, "i: %d, read returns %d\n", i, ret);
>         }
>
>         close(fdr);
>         close(fdw);
>         unlink(argv[1]);
>         return 0;
> }

Andrii reported the issue as well:
https://lore.kernel.org/bpf/CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixn=
OiLg@mail.gmail.com/

selftests/bpf was relying on the above behavior too
which we adjusted already, but
this looks to be a regression either in 9p or in vfs.
