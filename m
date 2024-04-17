Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD7196
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313228; cv=none; b=OEPvo5T91MlmHd7f+yRTX+VQR3eTggfjvTIA6l/QXHKAd5hJHsYSSsbBYfJq5AadSvp4hrKxvIWgVeqbvP+NePawUnaiLBe+ldWLkAX27Ki4UMk0uOzPFaxTmx0ADQ8sxkK+jHC41cjUB1/+/3WdKcop13/1ZME3OqBXpWBsgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313228; c=relaxed/simple;
	bh=x9bkeoMuabzfVb7Gw+KIyS66JHqvpBnTYi78RhtvTno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBetk6fYHTvixZcHNXA31PsMtWu2v5jgvjiU76+c5jMXQvYrztk+KUNgz1yuXsVpmJbt5GeTkUjxwpbWz442Vm3L+kPmn9mcLRHR6yhLgyWxUiqVhtkd5MdH/9GNowchoNNSjACN3Onlc7ftZVhARIQg0gz8nVROsKiYIJWHhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKhZNNYY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKhZNNYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBECC113CE
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313227;
	bh=x9bkeoMuabzfVb7Gw+KIyS66JHqvpBnTYi78RhtvTno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EKhZNNYY/1t0VUQ3iTd3YU7jtdNca5mAashYBr+xSR5T2ZL9eexx/CCOzzcmAq7Oz
	 mk2i3OCU6cBtgaV7GtnfjGMbCTuqPKiJbAQwbnz91DLf8BmgjaMnt0dqoFcs+7Dfu4
	 P4vkMfjtvQrpQMNp/Zf2/sFPgn0w49pEwcDgeuKeyNJxUB7BOwE1vdrXM041lP1/nW
	 bQZwLtt60YEKxjeHK2+8ZN9OOGsmBHrCKfqvPJpOz/Y7Z+nqN/tBNmiL6SBThRf0wR
	 YwV44BJ2idaoN2xAcdBRiBaRhWSpt/v6If7hOJhhIhibAUBgS5FoEOK+5bELe22yli
	 zRN8DJbIN9yDA==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4349bba0ba3so31611051cf.3
        for <v9fs@lists.linux.dev>; Tue, 16 Apr 2024 17:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzjDOpsFJ9YRr2Hl77w0qPAnDf5h3yYvC3FYsiFAJbvuFVUcRWgZZARv7UzLzNw89JOX0qzLv1GaPW5TrC80LlJGjmmQ==
X-Gm-Message-State: AOJu0YxSVhs/RIsP+hRXkpzucPSgoqcUb2/KTAvfHu10GlUz/JzYZdV1
	Gfg34mhq1Nn0J8Gl4Ryzp56WnbqLD5+evRUO807+cB2nDGisAenE8B1la234p2bEzFpp5hxwAqH
	gI2DIvQNXguuZLF5pSoBPbC0fkWU=
X-Google-Smtp-Source: AGHT+IFOoWhqRkbUxpRpPqYKG3xNywrUiEiptfOvesV77DIzLb+VlOt15VgkSxkVfRL0E4tXaonel8X53/g5d1RGlqE=
X-Received: by 2002:a05:6214:19cb:b0:69b:76fa:d879 with SMTP id
 j11-20020a05621419cb00b0069b76fad879mr11338225qvc.21.1713313226916; Tue, 16
 Apr 2024 17:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org> <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev> <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev>
 <ZhmbZp827i8coxit@vm3>
In-Reply-To: <ZhmbZp827i8coxit@vm3>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 16 Apr 2024 19:20:15 -0500
X-Gmail-Original-Message-ID: <CAFkjPTmowPL3vSKSEveEEn9jE46Bo5wM5PXcTX98MkXzcc-zyw@mail.gmail.com>
Message-ID: <CAFkjPTmowPL3vSKSEveEEn9jE46Bo5wM5PXcTX98MkXzcc-zyw@mail.gmail.com>
Subject: Re: ftruncate fails
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, ryan.roberts@arm.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you confirm if this was a regression (ie. this used to work over
9p) or just that the behavior is different than a local file system?

     -eric

On Tue, Apr 16, 2024 at 7:10=E2=80=AFPM Itaru Kitayama <itaru.kitayama@linu=
x.dev> wrote:
>
> Hi Eric,
>
> On Tue, Apr 16, 2024 at 02:16:29PM +0000, Eric Van Hensbergen wrote:
> > Itaru,
> >
> > If you can, could confirm that your issues go away with the pending-fix=
es branch of the next tree?
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/?h=3Dpending-fixes
> >
> > I work for Arm as well, so if you could point me at the revision of FVP=
 you are seeing the problems on I could also have a look at the server side=
 of it and see if its breaking any assumptions we've been operating under u=
sing Qemu as our primary server.
> >
>
> I've tested the pending-fixes branch on FVP (FVP_Base_RevC-2xAEMvA), and
> confirm that binaries built on host are immediately reflected to the
> latest binary, but kselftests' mm gup_longterm test still fails. David
> Hildenbrand and Ryan were talking about detect fs type, ie 9p early as un=
supported and do SKIP, If I remember correctly.
>
> execve("./gup_longterm", ["./gup_longterm"], 0xffffdfdb6790 /* 12 vars */=
) =3D 0
> brk(NULL)                               =3D 0xaaaae4c10000
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xfff
> faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) =3D -1 ENOENT (No such fi=
le or dir
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (N=
o such fi
> openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\260\265\2\0\0\=
0\0\0".
> newfstatat(3, "", {st_mode=3DS_IFREG|0755, st_size=3D1605640, ...}, AT_EM=
PTY_PATH) =3D
> mmap(NULL, 1650608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0xff
> mmap(0xffff8900c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENY
> mmap(0xffff89011000, 49072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_ANON
> close(3)                                =3D 0
> set_tid_address(0xffff8901def0)         =3D 239
> set_robust_list(0xffff8901df00, 24)     =3D 0
> rseq(0xffff8901e540, 0x20, 0, 0xd428bc00) =3D 0
> mprotect(0xffff8900c000, 12288, PROT_READ) =3D 0
> mprotect(0xaaaabeaff000, 4096, PROT_READ) =3D 0
> mprotect(0xffff89048000, 8192, PROT_READ) =3D 0
> prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=3D8192*1024, rlim_max=3DRLIM64=
_INFINITY})
> openat(AT_FDCWD, "/sys/kernel/mm/hugepages/", O_RDONLY|O_NONBLOCK|O_CLOEX=
EC|O_DI
> newfstatat(3, "", {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}, AT_EMPTY_PA=
TH) =3D 0
> getrandom("\xb9\x24\x5d\x28\x15\xeb\x16\x8f", 8, GRND_NONBLOCK) =3D 8
> brk(NULL)                               =3D 0xaaaae4c10000
> brk(0xaaaae4c31000)                     =3D 0xaaaae4c31000
> getdents64(3, 0xaaaae4c102d0 /* 6 entries */, 32768) =3D 208
> newfstatat(1, "", {st_mode=3DS_IFIFO|0600, st_size=3D0, ...}, AT_EMPTY_PA=
TH) =3D 0
> getdents64(3, 0xaaaae4c102d0 /* 0 entries */, 32768) =3D 0
> close(3)                                =3D 0
> openat(AT_FDCWD, "/sys/kernel/debug/gup_test", O_RDWR) =3D 3
> memfd_create("test", 0)                 =3D 4
> fstatfs(4, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D0, f_bfree=
=3D0, f_bavail=3D0,
> ftruncate(4, 4096)                      =3D 0
> fallocate(4, 0, 0, 4096)                =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D 0xffff88e890=
00
> ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) =3D 0
> ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) =3D 0
> munmap(0xffff88e89000, 4096)            =3D 0
> close(4)                                =3D 0
> openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) =3D 4
> fcntl(4, F_GETFL)                       =3D 0x424002 (flags O_RDWR|O_LARG=
EFILE|O_T
> fstatfs(4, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D416015, f_bf=
ree=3D415998, f
> ftruncate(4, 4096)                      =3D 0
> fallocate(4, 0, 0, 4096)                =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D 0xffff88e890=
00
> ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) =3D 0
> ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) =3D 0
> munmap(0xffff88e89000, 4096)            =3D 0
> close(4)                                =3D 0
> openat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", O_RDWR|O_CREAT|O_EXCL, =
0600) =3D
> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", 0) =3D 0
> fstatfs(4, 0xffffdeb88760)              =3D -1 EOPNOTSUPP (Operation not =
supported
> ftruncate(4, 4096)                      =3D -1 ENOENT (No such file or di=
rectory)
>
> Thanks,
> Itaru.
>
> >      -eric
> >
> >
> > April 7, 2024 at 9:22 PM, "Itaru Kitayama" <itaru.kitayama@linux.dev> w=
rote:
> > >
> > > >
> > > > On Apr 8, 2024, at 11:08, Itaru Kitayama <itaru.kitayama@linux.dev>=
 wrote:
> > > >
> > > >
> > > >
> > > >  Hi,
> > > >
> > > >
> > > >
> > > > >
> > > > > On Apr 8, 2024, at 11:01, Dominique Martinet <asmadeus@codewreck.=
org> wrote:
> > > > >
> > > > >
> > > > >
> > > > >  Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
> > > > >
> > > >
> > > >  With a recent kernel I see below program fails (Bus error) if exec=
uted
> > > >
> > > >  from 9p mounted directory, not with the local filesystem (Ext4).
> > > >
> > > > >
> > > > > I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of optio=
ns.
> > > > >
> > > > >  Bus error would be some problem with the mmap of the executable =
given
> > > > >
> > > > >  this code? so probably doesn't have anything to do with the cont=
ent of
> > > > >
> > > > >  the program itself...
> > > > >
> > > > >
> > > > >
> > > > >  A few questions:
> > > > >
> > > > >  - What exact kernel are you running? (or closest approximation)
> > > > >
> > > >
> > > >
> > > >
> > > >  v6.9-rc3
> > > >
> > > >
> > > >
> > > > >
> > > > > - What server? (assuming qemu) what mount option? (tried default
> > > > >
> > > > >  cacheless and cache=3Dloose)
> > > > >
> > > >
> > > >
> > > >
> > > >  FVP and just mount -t 9p FM /mnt
> > > >
> > > >
> > > >
> > > > >
> > > > > - Does this reproduce right after boot/mounting the 9p filesystem=
?
> > > > >
> > > >
> > > >
> > > >
> > > >  Not immediately after the boot/mounting.
> > > >
> > >
> > > My reproducer wasn=E2=80=99t explaining what a kselftests was showing=
.
> > >
> > > If you build the =E2=80=9Cmm=E2=80=9D subsystem and execute one of th=
e programs, gup_longterm from the 9p mounted directory, you=E2=80=99ll noti=
ce the ftruncate error.
> > >
> > > Thanks,
> > >
> > > Itaru.
> > >
> > > >
> > > > Thanks,
> > > >
> > > >  Itaru.
> > > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >  --
> > > > >
> > > > >  Dominique Martinet | Asmadeus
> > > > >
> > > >
> > >
>
