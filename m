Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378996116
	for <v9fs@lists.linux.dev>; Thu, 13 Jul 2023 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=6fCBR/LCO6RgZ91eDyNzhHUovpuyQ2t0BkcWAd3wYQM=; b=e8kWQ2F604NJvn3sqjcZ/93LUF
	5PO+bqO4dShWO6Bjgld4+EiqyZybYv3tYKzw3eVczY442Zl455bLWUBpS5B/lVWSlTpG2hy0MfnQp
	HeU86EyNg+h4bQFZhxFF4DUl6nevw9abK3jL9EeeN9+g7vtYXJ0eAFBZlxKlnap9k7VFIk80bGG13
	WkLEMh7HR9L3aRqE143VMNg6XM4m62Ew5VHXhBTVezoYy2dsqkMKM3Hjgny2kCWbZbyfDC1hKHMc0
	ZRl08E2tXeo4qqvWcaMR92yTmYBmz/CZ1JlguTcuszq96OT00KGIV2gi6EnEbopPVkQbeTX5zysHJ
	VnnFCC6eNMWHQ1NYFi7bcPOt0PsqfPmQMSTLqrN2ihtAhHFt8mJObm505c3EyVCWMr6ijBJfIUxI1
	v0PQSXtw64jbMSqwvrGlNGSgNgl+fKzf2y+OwzKS86ZS7jJTdoiWcSXFu1eY7LzDQ1o+r9gtv+Vnh
	ftWEf/zorixoA7wAy+aDiYk/p9E8X0BRhfokHrA3A1EpdSpv9Ii+GuRvMeao/DJlxJpOkOM+wrm56
	NI8OgeaCdZlOZgLzsjYlxzQuad6Qf5rJRvvYpt1WJmDpvM/RC80hnXO7qVxXrNf8DAh5yOcB/UXSJ
	O0ojgfgq6HzPVcl0iZBF0IZ9iUM77pcTaWF2sTahI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Date: Thu, 13 Jul 2023 09:50:42 +0200
Message-ID: <8322841.litLk3al4c@silver>
In-Reply-To: <ZK8mAe4O3LSfDQGl@pengutronix.de>
References:
 <ZK25XZ+GpR3KHIB/@pengutronix.de> <13302114.90OgOEUrqp@silver>
 <ZK8mAe4O3LSfDQGl@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, July 13, 2023 12:15:29 AM CEST Robert Schwebel wrote:
> On Wed, Jul 12, 2023 at 05:57:40PM +0200, Christian Schoenebeck wrote:
> > > On Wed, Jul 12, 2023 at 11:01:53AM +0200, Christian Schoenebeck wrote:
> > > > > TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> > > > > "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
> > > > 
> > > > What's the precise set of 9p mount options on guest, which 9p server is used
> > > > and what are 9p server's options respectively?
> > > 
> > > The server is qemu, started like this:
> > > 
> > > qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
> > > 
> > > This is qemu 8.0.2.
> > 
> > Does adding QEMU option "multidevs=remap" [1] resolve it?
> > 
> > [1] https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly
> 
> Unfortunately not:
> 
> + exec ./platform-v7a/sysroot-host/bin/qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device vi
> rtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file,multidevs=remap -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/
> root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'

I don't see any cache option here. I would expect at least cache=mmap here:

https://wiki.qemu.org/Documentation/9p_root_fs#Boot_the_9p_Root_FS_System

By default it's cache=none, which means no mmap() would be allowed either.

> [    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
> [    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
> [    0.004806] smp_twd: clock not found -2
> [    1.069767] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
> [    1.085798] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
> [    1.153420] physmap-flash 48000000.psram: map_probe failed
> [    1.535013] 9pnet_virtio: no channels available for device root
> 
>  ____                        _                   _
> |  _ \ ___ _ __   __ _ _   _| |_ _ __ ___  _ __ (_)_  __
> | |_) / _ \ '_ \ / _` | | | | __| '__/ _ \| '_ \| \ \/ /
> |  __/  __/ | | | (_| | |_| | |_| | | (_) | | | | |>  <
> |_|   \___|_| |_|\__, |\__,_|\__|_|  \___/|_| |_|_/_/\_\
>                  |___/
> 
>  ____  _     _             _  ___ _
> |  _ \(_)___| |_ _ __ ___ | |/ (_) |_
> | | | | / __| __| '__/ _ \| ' /| | __|
> | |_| | \__ \ |_| | | (_) | . \| | |_
> |____/|_|___/\__|_|  \___/|_|\_\_|\__|
> 
> 
> OSELAS(R)-DistroKit-2019.12.0-00429-g57ffae760eb9 / v7a-2019.12.0-00429-g57ffae760eb9
> ptxdist-2023.07.1/2023-07-11T19:56:50+0200
> 
> DistroKit login: root
> root@DistroKit:~ mount / -o remount,rw
> root@DistroKit:~ ldconfig
> ldconfig: Cannot mmap file /lib/libgcc_s.so.1.
> 
> ldconfig: Cannot mmap file /lib/libstdc++.so.

Again, effective 9p mount options are always useful, e.g. `mount | grep 9p`

> 
> [...]
> 
> rsc
> 


