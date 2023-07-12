Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0F1F947
	for <v9fs@lists.linux.dev>; Wed, 12 Jul 2023 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=8wobL/nw6/Ztr6EuDj6EU5p+jSo6gaDfS81VplNyjG0=; b=hghkOnUB8CVKll02WYaxvQ91/Y
	BEr1YZEZ6mLqVN8pYNoJvBkBmgQdPOYH468RMz9UPocvwZZ/CqKVmWqrPBiy8kQpzknFHxdxJoFd/
	/d3UHqL2ry2mrynmmS1ef21cONpj3ZZc+bipRnTt9benI7kUxrNQYOg0yogvcCinXkqtb9VlGR1d2
	pcYLp4uOFuHGlUOSKtYPFYEzFcbeUflUqGU56Fh3j49ZJXjfxvngUvyFNduuAbs2QcKn9i31jgPc3
	6YtZrlEpkOFk7i7ikLD9dUEZBz0AZt30Nojb4+yrDZ6nFUuPmrlzlRXwzJExJZnVTMhlSfzwHmyP2
	r3eGyO/UyTfJ7+2IEM3/J59JvO6BLtrXU3dyb3oc71RcVcBJq4luMXqw9A5ypyUiA/PwLnj/kI0ar
	x5jy2hXxhBz3lZe71VBima17/e5eVcZQLJLEacXFgiiKNIbdgQ58jjvIIK1CGWKl1EENzzJyQLwuL
	YuVX8QPf14pGhiOkXi/R813u/2VUHHRP87YSYiWGTSLtFfuaYzS5erKedOuwkw8DedeqzEgS+YD6a
	Qx1+I6mtFbrNKSgy68wK4pEtQkwSiMLcfB7GdCsqDoB4FifE7AE+YD8cPGW+6hpIMYs3KtQlSngsX
	s+bk3O6l3LEdhpdA09mKq7oynCkFbQcecoJhslkE4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Date: Wed, 12 Jul 2023 11:01:53 +0200
Message-ID: <3123765.Wy8GRVaxaG@silver>
In-Reply-To: <ZK25XZ+GpR3KHIB/@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 11, 2023 10:19:41 PM CEST Robert Schwebel wrote:
> Hi Eric,
> 
> TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> "rootflags=ignoreqv" fixes it as well, but it feels like a regression.

What's the precise set of 9p mount options on guest, which 9p server is used
and what are 9p server's options respectively?

> I'm tracking down an issue which recently turned up in DistroKit [1] (an
> embedded Linux distro based on the ptxdist build system). The issue was a bit
> uggly, as my CI didn't find it (systems boot up normally after a while, and I
> only use 9p for virtual qemu machines, while most of the test farm is real
> hardware).
> 
> The qemu machine in question is qemu-system-arm, emulating an ARM v7a machine.
> 
> When starting the systems interactively, I get a lot of error output from
> ldconfig, like this:
> 
> [   17.412964] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libgcc_s.so.1.
> [   17.418851] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.
> [   17.425009] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.0.30.
> [   17.436671] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.
> [   17.448451] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.
> [   17.456418] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.1.2.0.
> ...
> 
> Running ldconfig with strace shows this, for all libraries::
> 
> | statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_SYMLINK_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFLNK|0777, stx_size=14, ...}) = 0
> | statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|064 4, stx_size=862228, ...}) = 0
> | openat(AT_FDCWD, "/lib/libnm.so.0", O_RDONLY|O_LARGEFILE) = 4
> | statx(4, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0644, stx_s ize=862228, ...}) = 0
> | mmap2(NULL, 862228, PROT_READ, MAP_SHARED, 4, 0) = -1 ENODEV (No such device)
> | write(2, "ldconfig: ", 10ldconfig: )              = 10
> | write(2, "Cannot mmap file /lib/libnm.so.0"..., 34Cannot mmap file /lib/libnm.so.0.) = 34
> | write(2, "\n", 1)                       = 1
> | close(4)                                = 0
> 
> I could track down the breakage to
> 
>   1543b4c5071c54d76aad7a7a26a6e43082269b0c

This patch is sensitive about 9p server transmitting a meaningful value for
file's QID version field. That's why more info about deployed 9p server would
help.

> My test setup has, in addition to the patch above, the following patches also
> reverted on top of a vanilla 6.4 kernel:
> 
>   4eb3117888a923f6b9b1ad2dd093641c49a63ae5
>   21e26d5e54ab7cfe6b488fd27d4d70956d07e03b
> 
> as 1543b cannot be reverted without those; however, the effect only goes away
> when I also revert 1543b. The kernel has no other patches applied, only these
> three reverts.
> 
> Do you have an idea what happens?
> 
> I have the setup easily available, so I could quickly test patches.
> 
> Thanks,
> 
> rsc
> 
> [1] https://git.pengutronix.de/cgit/DistroKit/
> 




