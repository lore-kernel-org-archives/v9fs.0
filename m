Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C5DF61
	for <v9fs@lists.linux.dev>; Wed, 12 Jul 2023 22:15:45 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qJi7P-0001Rs-T7; Thu, 13 Jul 2023 00:15:31 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qJi7N-005a8C-F2; Thu, 13 Jul 2023 00:15:29 +0200
Date: Thu, 13 Jul 2023 00:15:29 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Message-ID: <ZK8mAe4O3LSfDQGl@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <3123765.Wy8GRVaxaG@silver>
 <ZK61Kpii5To2zMJx@pengutronix.de>
 <13302114.90OgOEUrqp@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13302114.90OgOEUrqp@silver>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

On Wed, Jul 12, 2023 at 05:57:40PM +0200, Christian Schoenebeck wrote:
> > On Wed, Jul 12, 2023 at 11:01:53AM +0200, Christian Schoenebeck wrote:
> > > > TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> > > > "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
> > > 
> > > What's the precise set of 9p mount options on guest, which 9p server is used
> > > and what are 9p server's options respectively?
> > 
> > The server is qemu, started like this:
> > 
> > qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
> > 
> > This is qemu 8.0.2.
> 
> Does adding QEMU option "multidevs=remap" [1] resolve it?
> 
> [1] https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly

Unfortunately not:

+ exec ./platform-v7a/sysroot-host/bin/qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device vi
rtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file,multidevs=remap -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/
root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.004806] smp_twd: clock not found -2
[    1.069767] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    1.085798] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    1.153420] physmap-flash 48000000.psram: map_probe failed
[    1.535013] 9pnet_virtio: no channels available for device root

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
ldconfig: Cannot mmap file /lib/libgcc_s.so.1.

ldconfig: Cannot mmap file /lib/libstdc++.so.

[...]

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
