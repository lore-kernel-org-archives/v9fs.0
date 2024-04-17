Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8B747F
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313535; cv=none; b=tDUc+CoPaljgd6NhgviZDKv4qXl7BWdJ4P9y5kn8TSsgzdTj/0PAiVK52Lgfk7lRegy6gxsgg4fSwjm1bKTy6VWyfMbmImWOWvq/7JPsjY0gSXi12fVv8OQ+w/2SxDtFps/bvrQ4zFaAlU1QxOMVn9uZbqw2AyWzq9S4XK+WeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313535; c=relaxed/simple;
	bh=Sn6VRSEGeAN6A379QW2dSIx1NtvYJoxIuv2jg89wkn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NGMpoKyRJiayjC3o3AXN+IyTHxLP+fhMQSZPcwC8hb96tDAnVJswVKtaXpwp3RQt7r0AHKcvltaNMhgB++hTA6S4xilHpD57dmHE7w1ZLdsNx907MdhC/1YSatpetETVuVw/UVApKh0CCdltLrzxzFgnXLu/23SsBODvzs7XQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikUHUds6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikUHUds6"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713313531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yfQVh99xp8tvTcayc0NaUQ9RVJH8L0CPQYzo4qLIyc=;
	b=ikUHUds6Fd6VNm7XG7lJ98/fg11SbHoQFLmdZlgnFEUHZIt+kHFkaUWDvm60hZaxwq1dQd
	I7a6sXEf30yTh6cGmzBBrJpcmI63z9FIuCjHkTvsxf6WH+ovGQXtfkkqFReBBtLGk+sYza
	pnrsTIB9QQujqTfAqBvDIFYj+3FTOhs=
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: ftruncate fails
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <CAFkjPTmowPL3vSKSEveEEn9jE46Bo5wM5PXcTX98MkXzcc-zyw@mail.gmail.com>
Date: Wed, 17 Apr 2024 09:25:12 +0900
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>,
 Dominique Martinet <asmadeus@codewreck.org>,
 v9fs@lists.linux.dev,
 Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B23BE9F-87A1-4434-9191-E5FC71031892@linux.dev>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
 <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
 <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev> <ZhmbZp827i8coxit@vm3>
 <CAFkjPTmowPL3vSKSEveEEn9jE46Bo5wM5PXcTX98MkXzcc-zyw@mail.gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 17, 2024, at 9:20, Eric Van Hensbergen <ericvh@kernel.org> =
wrote:
>=20
> Can you confirm if this was a regression (ie. this used to work over
> 9p) or just that the behavior is different than a local file system?

It=E2=80=99s not a regression, I=E2=80=99ve tested that program on 9p =
only, and it=E2=80=99s been that way for a while.
I am curious to know whether the 9p folk permit this as a bug or not.

Itaru.

>     -eric
>=20
> On Tue, Apr 16, 2024 at 7:10=E2=80=AFPM Itaru Kitayama =
<itaru.kitayama@linux.dev> wrote:
>>=20
>> Hi Eric,
>>=20
>> On Tue, Apr 16, 2024 at 02:16:29PM +0000, Eric Van Hensbergen wrote:
>>> Itaru,
>>>=20
>>> If you can, could confirm that your issues go away with the =
pending-fixes branch of the next tree?
>>> =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=
=3Dpending-fixes
>>>=20
>>> I work for Arm as well, so if you could point me at the revision of =
FVP you are seeing the problems on I could also have a look at the =
server side of it and see if its breaking any assumptions we've been =
operating under using Qemu as our primary server.
>>>=20
>>=20
>> I've tested the pending-fixes branch on FVP (FVP_Base_RevC-2xAEMvA), =
and
>> confirm that binaries built on host are immediately reflected to the
>> latest binary, but kselftests' mm gup_longterm test still fails. =
David
>> Hildenbrand and Ryan were talking about detect fs type, ie 9p early =
as unsupported and do SKIP, If I remember correctly.
>>=20
>> execve("./gup_longterm", ["./gup_longterm"], 0xffffdfdb6790 /* 12 =
vars */) =3D 0
>> brk(NULL)                               =3D 0xaaaae4c10000
>> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0xfff
>> faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) =3D -1 ENOENT (No =
such file or dir
>> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D -1 =
ENOENT (No such fi
>> openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
>> read(3, =
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\260\265\2\0\0\0\0\0".
>> newfstatat(3, "", {st_mode=3DS_IFREG|0755, st_size=3D1605640, ...}, =
AT_EMPTY_PATH) =3D
>> mmap(NULL, 1650608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xff
>> mmap(0xffff8900c000, 20480, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_DENY
>> mmap(0xffff89011000, 49072, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANON
>> close(3)                                =3D 0
>> set_tid_address(0xffff8901def0)         =3D 239
>> set_robust_list(0xffff8901df00, 24)     =3D 0
>> rseq(0xffff8901e540, 0x20, 0, 0xd428bc00) =3D 0
>> mprotect(0xffff8900c000, 12288, PROT_READ) =3D 0
>> mprotect(0xaaaabeaff000, 4096, PROT_READ) =3D 0
>> mprotect(0xffff89048000, 8192, PROT_READ) =3D 0
>> prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM64_INFINITY})
>> openat(AT_FDCWD, "/sys/kernel/mm/hugepages/", =
O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DI
>> newfstatat(3, "", {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}, =
AT_EMPTY_PATH) =3D 0
>> getrandom("\xb9\x24\x5d\x28\x15\xeb\x16\x8f", 8, GRND_NONBLOCK) =3D 8
>> brk(NULL)                               =3D 0xaaaae4c10000
>> brk(0xaaaae4c31000)                     =3D 0xaaaae4c31000
>> getdents64(3, 0xaaaae4c102d0 /* 6 entries */, 32768) =3D 208
>> newfstatat(1, "", {st_mode=3DS_IFIFO|0600, st_size=3D0, ...}, =
AT_EMPTY_PATH) =3D 0
>> getdents64(3, 0xaaaae4c102d0 /* 0 entries */, 32768) =3D 0
>> close(3)                                =3D 0
>> openat(AT_FDCWD, "/sys/kernel/debug/gup_test", O_RDWR) =3D 3
>> memfd_create("test", 0)                 =3D 4
>> fstatfs(4, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D0, =
f_bfree=3D0, f_bavail=3D0,
>> ftruncate(4, 4096)                      =3D 0
>> fallocate(4, 0, 0, 4096)                =3D 0
>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D =
0xffff88e89000
>> ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) =3D 0
>> ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) =3D 0
>> munmap(0xffff88e89000, 4096)            =3D 0
>> close(4)                                =3D 0
>> openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) =3D 4
>> fcntl(4, F_GETFL)                       =3D 0x424002 (flags =
O_RDWR|O_LARGEFILE|O_T
>> fstatfs(4, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D416015, =
f_bfree=3D415998, f
>> ftruncate(4, 4096)                      =3D 0
>> fallocate(4, 0, 0, 4096)                =3D 0
>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D =
0xffff88e89000
>> ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) =3D 0
>> ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) =3D 0
>> munmap(0xffff88e89000, 4096)            =3D 0
>> close(4)                                =3D 0
>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", =
O_RDWR|O_CREAT|O_EXCL, 0600) =3D
>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", 0) =3D 0
>> fstatfs(4, 0xffffdeb88760)              =3D -1 EOPNOTSUPP (Operation =
not supported
>> ftruncate(4, 4096)                      =3D -1 ENOENT (No such file =
or directory)
>>=20
>> Thanks,
>> Itaru.
>>=20
>>>     -eric
>>>=20
>>>=20
>>> April 7, 2024 at 9:22 PM, "Itaru Kitayama" =
<itaru.kitayama@linux.dev> wrote:
>>>>=20
>>>>>=20
>>>>> On Apr 8, 2024, at 11:08, Itaru Kitayama =
<itaru.kitayama@linux.dev> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> On Apr 8, 2024, at 11:01, Dominique Martinet =
<asmadeus@codewreck.org> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
>>>>>>=20
>>>>>=20
>>>>> With a recent kernel I see below program fails (Bus error) if =
executed
>>>>>=20
>>>>> from 9p mounted directory, not with the local filesystem (Ext4).
>>>>>=20
>>>>>>=20
>>>>>> I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of =
options.
>>>>>>=20
>>>>>> Bus error would be some problem with the mmap of the executable =
given
>>>>>>=20
>>>>>> this code? so probably doesn't have anything to do with the =
content of
>>>>>>=20
>>>>>> the program itself...
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> A few questions:
>>>>>>=20
>>>>>> - What exact kernel are you running? (or closest approximation)
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> v6.9-rc3
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> - What server? (assuming qemu) what mount option? (tried default
>>>>>>=20
>>>>>> cacheless and cache=3Dloose)
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> FVP and just mount -t 9p FM /mnt
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> - Does this reproduce right after boot/mounting the 9p =
filesystem?
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Not immediately after the boot/mounting.
>>>>>=20
>>>>=20
>>>> My reproducer wasn=E2=80=99t explaining what a kselftests was =
showing.
>>>>=20
>>>> If you build the =E2=80=9Cmm=E2=80=9D subsystem and execute one of =
the programs, gup_longterm from the 9p mounted directory, you=E2=80=99ll =
notice the ftruncate error.
>>>>=20
>>>> Thanks,
>>>>=20
>>>> Itaru.
>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>>=20
>>>>> Itaru.
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> Thanks
>>>>>>=20
>>>>>> --
>>>>>>=20
>>>>>> Dominique Martinet | Asmadeus
>>>>>>=20
>>>>>=20
>>>>=20
>>=20

