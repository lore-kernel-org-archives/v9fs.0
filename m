Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F801DDFB
	for <v9fs@lists.linux.dev>; Tue, 11 Jul 2023 20:19:55 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qJJpo-0001th-5R; Tue, 11 Jul 2023 22:19:44 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qJJpm-003i1t-0z; Tue, 11 Jul 2023 22:19:42 +0200
Date: Tue, 11 Jul 2023 22:19:41 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel@pengutronix.de
Subject: mmap on 9p broken in 6.4
Message-ID: <ZK25XZ+GpR3KHIB/@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Hi Eric,

TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
"rootflags=ignoreqv" fixes it as well, but it feels like a regression.

I'm tracking down an issue which recently turned up in DistroKit [1] (an
embedded Linux distro based on the ptxdist build system). The issue was a bit
uggly, as my CI didn't find it (systems boot up normally after a while, and I
only use 9p for virtual qemu machines, while most of the test farm is real
hardware).

The qemu machine in question is qemu-system-arm, emulating an ARM v7a machine.

When starting the systems interactively, I get a lot of error output from
ldconfig, like this:

[   17.412964] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libgcc_s.so.1.
[   17.418851] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.
[   17.425009] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.0.30.
[   17.436671] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libstdc++.so.6.
[   17.448451] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.
[   17.456418] systemd-rc-once[127]: ldconfig: Cannot mmap file /lib/libatomic.so.1.2.0.
...

Running ldconfig with strace shows this, for all libraries::

| statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_SYMLINK_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFLNK|0777, stx_size=14, ...}) = 0
| statx(AT_FDCWD, "/lib/libnm.so.0", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|064 4, stx_size=862228, ...}) = 0
| openat(AT_FDCWD, "/lib/libnm.so.0", O_RDONLY|O_LARGEFILE) = 4
| statx(4, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0644, stx_s ize=862228, ...}) = 0
| mmap2(NULL, 862228, PROT_READ, MAP_SHARED, 4, 0) = -1 ENODEV (No such device)
| write(2, "ldconfig: ", 10ldconfig: )              = 10
| write(2, "Cannot mmap file /lib/libnm.so.0"..., 34Cannot mmap file /lib/libnm.so.0.) = 34
| write(2, "\n", 1)                       = 1
| close(4)                                = 0

I could track down the breakage to

  1543b4c5071c54d76aad7a7a26a6e43082269b0c

My test setup has, in addition to the patch above, the following patches also
reverted on top of a vanilla 6.4 kernel:

  4eb3117888a923f6b9b1ad2dd093641c49a63ae5
  21e26d5e54ab7cfe6b488fd27d4d70956d07e03b

as 1543b cannot be reverted without those; however, the effect only goes away
when I also revert 1543b. The kernel has no other patches applied, only these
three reverts.

Do you have an idea what happens?

I have the setup easily available, so I could quickly test patches.

Thanks,

rsc

[1] https://git.pengutronix.de/cgit/DistroKit/
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
