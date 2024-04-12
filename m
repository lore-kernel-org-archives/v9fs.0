Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EA17F7
	for <v9fs@lists.linux.dev>; Wed, 17 Apr 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312614; cv=none; b=VaoqWO6mQv0BgMgq3/mFvMG5iiL2deqhV+CCPWoa3Yr8iIWRq6qOhHUbD5E33BWGKpGELoUsI3j5BhmcZCWFwSEBzrNyta4OiuIZ+zhCtmOLmvuPywBY54NhTaIOhxVdCQBjTIeYUfyka7f5RQuW5yZFf3BMY6z5Umsl8yD5Tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312614; c=relaxed/simple;
	bh=RSvRoEb21ldnuqQhMlNae9iqRSBlpfcX682Zrg+uRS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmfrXG1MVFL/zbtqGLv/lRf5ynGe/0JhoOw3yt/LpKhSVZd4isu7MfktSEmhdHZO1++yq0yfKN9fooLBAQnYiT3u2mRXYPESmnUGEfzZDo5naK2XO4e4otDf9o5D6CO8r6ZYW72sSK7HtNn49KIW/EUKZJIWLzL3hoLHFKCQjac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJlotUWN; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJlotUWN"
Date: Sat, 13 Apr 2024 05:36:54 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713312608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZhO+ahvFGqzRgvaQs9T8J+MdOLwr4xPZC1hc+R9pc=;
	b=GJlotUWNegUWxpGM6wdvt370LgVmINn1nmxJo5VjQUQ9IxIIwyRLi9TCuSouWNiOCVbLYi
	rwrgFBZc/gftQR3ChWjrjDR9BExB6l7hmfKVOm2ZKn9VhxBhhv4wCm9QI6R8oItZR/LvOa
	ytkbFLdZ3bxJcqK/qVwp7kWW+ZcHF38=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	ryan.roberts@arm.com, david@redhat.com
Subject: Re: ftruncate fails
Message-ID: <ZhmbZp827i8coxit@vm3>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
 <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
 <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
 <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7164a3abce2d194041d9179a9ef153d75edb099@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Eric,

On Tue, Apr 16, 2024 at 02:16:29PM +0000, Eric Van Hensbergen wrote:
> Itaru,
> 
> If you can, could confirm that your issues go away with the pending-fixes branch of the next tree?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=pending-fixes
> 
> I work for Arm as well, so if you could point me at the revision of FVP you are seeing the problems on I could also have a look at the server side of it and see if its breaking any assumptions we've been operating under using Qemu as our primary server.
> 

I've tested the pending-fixes branch on FVP (FVP_Base_RevC-2xAEMvA), and
confirm that binaries built on host are immediately reflected to the
latest binary, but kselftests' mm gup_longterm test still fails. David
Hildenbrand and Ryan were talking about detect fs type, ie 9p early as unsupported and do SKIP, If I remember correctly.

execve("./gup_longterm", ["./gup_longterm"], 0xffffdfdb6790 /* 12 vars */) = 0
brk(NULL)                               = 0xaaaae4c10000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfff
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or dir
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such fi
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\260\265\2\0\0\0\0\0".
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=1605640, ...}, AT_EMPTY_PATH) =
mmap(NULL, 1650608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xff
mmap(0xffff8900c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENY
mmap(0xffff89011000, 49072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANON
close(3)                                = 0
set_tid_address(0xffff8901def0)         = 239
set_robust_list(0xffff8901df00, 24)     = 0
rseq(0xffff8901e540, 0x20, 0, 0xd428bc00) = 0
mprotect(0xffff8900c000, 12288, PROT_READ) = 0
mprotect(0xaaaabeaff000, 4096, PROT_READ) = 0
mprotect(0xffff89048000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY})
openat(AT_FDCWD, "/sys/kernel/mm/hugepages/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DI
newfstatat(3, "", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_EMPTY_PATH) = 0
getrandom("\xb9\x24\x5d\x28\x15\xeb\x16\x8f", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0xaaaae4c10000
brk(0xaaaae4c31000)                     = 0xaaaae4c31000
getdents64(3, 0xaaaae4c102d0 /* 6 entries */, 32768) = 208
newfstatat(1, "", {st_mode=S_IFIFO|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
getdents64(3, 0xaaaae4c102d0 /* 0 entries */, 32768) = 0
close(3)                                = 0
openat(AT_FDCWD, "/sys/kernel/debug/gup_test", O_RDWR) = 3
memfd_create("test", 0)                 = 4
fstatfs(4, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0,
ftruncate(4, 4096)                      = 0
fallocate(4, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0xffff88e89000
ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) = 0
ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) = 0
munmap(0xffff88e89000, 4096)            = 0
close(4)                                = 0
openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 4
fcntl(4, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_T
fstatfs(4, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415998, f
ftruncate(4, 4096)                      = 0
fallocate(4, 0, 0, 4096)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0xffff88e89000
ioctl(3, _IOC(_IOC_WRITE, 0x67, 0x7, 0x18), 0xffffdeb88850) = 0
ioctl(3, _IOC(_IOC_NONE, 0x67, 0x8, 0), 0xffffdeb88850) = 0
munmap(0xffff88e89000, 4096)            = 0
close(4)                                = 0
openat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", O_RDWR|O_CREAT|O_EXCL, 0600) =
unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_Jbjlxi", 0) = 0
fstatfs(4, 0xffffdeb88760)              = -1 EOPNOTSUPP (Operation not supported
ftruncate(4, 4096)                      = -1 ENOENT (No such file or directory)

Thanks,
Itaru.

>      -eric
> 
> 
> April 7, 2024 at 9:22 PM, "Itaru Kitayama" <itaru.kitayama@linux.dev> wrote:
> > 
> > > 
> > > On Apr 8, 2024, at 11:08, Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
> > > 
> > >  
> > > 
> > >  Hi,
> > > 
> > >  
> > > 
> > > > 
> > > > On Apr 8, 2024, at 11:01, Dominique Martinet <asmadeus@codewreck.org> wrote:
> > > > 
> > > >  
> > > > 
> > > >  Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
> > > > 
> > > 
> > >  With a recent kernel I see below program fails (Bus error) if executed
> > > 
> > >  from 9p mounted directory, not with the local filesystem (Ext4).
> > > 
> > > > 
> > > > I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of options.
> > > > 
> > > >  Bus error would be some problem with the mmap of the executable given
> > > > 
> > > >  this code? so probably doesn't have anything to do with the content of
> > > > 
> > > >  the program itself...
> > > > 
> > > >  
> > > > 
> > > >  A few questions:
> > > > 
> > > >  - What exact kernel are you running? (or closest approximation)
> > > > 
> > > 
> > >  
> > > 
> > >  v6.9-rc3
> > > 
> > >  
> > > 
> > > > 
> > > > - What server? (assuming qemu) what mount option? (tried default
> > > > 
> > > >  cacheless and cache=loose)
> > > > 
> > > 
> > >  
> > > 
> > >  FVP and just mount -t 9p FM /mnt
> > > 
> > >  
> > > 
> > > > 
> > > > - Does this reproduce right after boot/mounting the 9p filesystem?
> > > > 
> > > 
> > >  
> > > 
> > >  Not immediately after the boot/mounting.
> > > 
> > 
> > My reproducer wasn’t explaining what a kselftests was showing.
> > 
> > If you build the “mm” subsystem and execute one of the programs, gup_longterm from the 9p mounted directory, you’ll notice the ftruncate error.
> > 
> > Thanks,
> > 
> > Itaru.
> > 
> > > 
> > > Thanks,
> > > 
> > >  Itaru.
> > > 
> > >  
> > > 
> > > > 
> > > > Thanks
> > > > 
> > > >  -- 
> > > > 
> > > >  Dominique Martinet | Asmadeus
> > > >
> > >
> >
