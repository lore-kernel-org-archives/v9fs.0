Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E74C8C
	for <v9fs@lists.linux.dev>; Fri, 14 Jul 2023 05:34:40 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qKBRd-0001x0-6I; Fri, 14 Jul 2023 07:34:21 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qKBRb-008oMw-Ms; Fri, 14 Jul 2023 07:34:19 +0200
Date: Fri, 14 Jul 2023 07:34:19 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Message-ID: <ZLDeW/5dkFR3crBc@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <13302114.90OgOEUrqp@silver>
 <ZK8mAe4O3LSfDQGl@pengutronix.de>
 <8322841.litLk3al4c@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8322841.litLk3al4c@silver>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Christian,

On Thu, Jul 13, 2023 at 09:50:42AM +0200, Christian Schoenebeck wrote:
> > > Does adding QEMU option "multidevs=remap" [1] resolve it?
> > >
> > > [1] https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly
> >
> > Unfortunately not:
> >
> > + exec ./platform-v7a/sysroot-host/bin/qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device vi
> > rtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file,multidevs=remap -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/
> > root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
>
> I don't see any cache option here. I would expect at least cache=mmap here:
>
> https://wiki.qemu.org/Documentation/9p_root_fs#Boot_the_9p_Root_FS_System
>
> By default it's cache=none, which means no mmap() would be allowed either.

This does help:

----------8<----------
+ exec ./platform-v7a/sysroot-host/bin/qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,ho
stfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-device,rng=rng0 -dev
ice virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file,multidevs=remap -device virtio-9p-device,fsdev=rootfs,mount_tag=/de
v/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/root rootfstype=9p rootflags=trans=virtio,cache=mmap conso
le=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.004881] smp_twd: clock not found -2
[    0.793281] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.809253] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.879343] physmap-flash 48000000.psram: map_probe failed
[    1.267846] 9pnet_virtio: no channels available for device root

 ____                        _                   _
|  _ \ ___ _ __   __ _ _   _| |_ _ __ ___  _ __ (_)_  __
| |_) / _ \ '_ \ / _` | | | | __| '__/ _ \| '_ \| \ \/ /
|  __/  __/ | | | (_| | |_| | |_| | | (_) | | | | |>  <
|_|   \___|_| |_|\__, |\__,_|\__|_|  \___/|_| |_|_/_/\_\
                 |___/

 ____  _     _             _  ___ _
|  _ \(_)___| |_ _ __ ___ | |/ (_) |_
| | | | / __| __| '__/ _ \| ' /| | __|
| |_| | \__ \ |_| | | (_) | . \| | |_
|____/|_|___/\__|_|  \___/|_|\_\_|\__|


OSELAS(R)-DistroKit-2019.12.0-00429-g57ffae760eb9 / v7a-2019.12.0-00429-g57ffae760eb9
ptxdist-2023.07.1/2023-07-11T19:56:50+0200

DistroKit login: root
root@DistroKit:~ mount / -o remount,rw
root@DistroKit:~ ldconfig
root@DistroKit:~
----------8<----------

However, the default behaviour has changed. With 6.3, mmap worked without
cache=mmap.

> Again, effective 9p mount options are always useful, e.g. `mount | grep 9p`

With the change:
/dev/root on / type 9p (rw,relatime,cache=mmap,access=client,trans=virtio)

Without the change:
/dev/root on / type 9p (rw,relatime,access=client,trans=virtio)

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
