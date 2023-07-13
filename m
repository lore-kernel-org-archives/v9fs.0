Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42C100B5
	for <v9fs@lists.linux.dev>; Thu, 13 Jul 2023 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=0wnw1t5wFYFGkKcQkAP7bUhNMU12fQ3lBHNCSqRWsU0=; b=tpgtgCH3CVIPfdxREKUHw3Q9az
	JIkDzgPZgs+dCKb/psLipUV6YBpPcgJ+70lP9ejRDk4J1EtwuwxDbo7MkYBj0b8M9lAriJc+Dd5ro
	pt4Vy19srUsUOYsCI6SEq9bZKX85Z15otl2He0G6/Z5fId8ROrky1oHP/8fBx/weu7c/0X1XWf/rz
	myKJaijTkpxLmD7qKvgXQeCsa4RPcV29LZl8oU/hWF8rEOhYwOZmK5FdYr1BxI/I6ExgvXZdCHjRe
	Fmp1xuyS8yO3eW58m3pXUUAU1Y4aailuxQ3AD1PY3HKikBOAN/aX4qsEsimm0xK/SSOuXX1vre5r9
	QnB5Eg2Q1pmYZNKfVxDRRjOoXN+BcIqrdjmQ/3pjfprUMHUp+5T4xbiEYxNDsAkFnaoQkJO+Q9BIq
	RxEpB9o1AGcTD3BON751SJTlM5/sPY3CfZ6PULTq8sSFKGGzQAULJzHacGZCWEf3+pjBlLEYs0bhL
	A8EvqaZbOOD4VedZOLm520CBW82Q2cZauJDnp03Sg52DWAznuK4gS0RXw+mgzMPNCSSLVLLV7ZKK3
	h6Cm0/PpZKO+Q0yXkRESyhfDTrNNPqqiOtKplFMFCjO6X/aBMXlEYd/FaEWIRjuggFKMHLvZHvw5a
	j/YAiqjYICbKAqM43801JMcaeGIH7kXQFXS3I7qeY=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Robert Schwebel <r.schwebel@pengutronix.de>, kernel@pengutronix.de,
 v9fs@lists.linux.dev, groug@kaod.org
Subject: Re: mmap on 9p broken in 6.4
Date: Thu, 13 Jul 2023 12:54:44 +0200
Message-ID: <11571626.Ud7ZN73ssd@silver>
In-Reply-To:
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
References:
 <ZK25XZ+GpR3KHIB/@pengutronix.de> <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, July 13, 2023 11:51:24 AM CEST Eric Van Hensbergen wrote:
> I=E2=80=99m traveling so haven=E2=80=99t been able to dig in, but somethi=
ng funny going
> on.  I would have expected ignoreqv to not have any impact in default cac=
he
> mode (nocache) - so there=E2=80=99s a bug in there somewhere.  in this ca=
se its
> read mmap thats failing and that should work without cache=3Dmmap (which =
is
> only required for writable mmaps) - I did do bunch of reorganization in
> this code path, I=E2=80=99ll try to eyeball the bug when I get back from =
travel but
> sounds like I also need to
> integrate a test path with a server that doesn't populate qid.vers so this
> case is covered by our regressions.

Or a runtime warning in general if server always just sends qid.version zer=
o.

About QEMU: unless the (actually unrelated) option `multidevs=3Dremap` opti=
on is
used, Rreaddir would return all directory entries with qid.version set to
zero. So that's a bug on QEMU side:

https://github.com/qemu/qemu/blob/71d72ececa086114df80fe4cc04d701b59002eb2/=
hw/9pfs/9p.c#L2534

I try to send a patch for this next week, such that qid.version is always
filled, no matter what the QEMU command line options are. In the meantime
please use `multidevs=3Dremap` as workaround for testing.

=2D Christian

> On Thu, Jul 13, 2023 at 8:50 AM Christian Schoenebeck <
> linux_oss@crudebyte.com> wrote:
>=20
> > On Thursday, July 13, 2023 12:15:29 AM CEST Robert Schwebel wrote:
> > > On Wed, Jul 12, 2023 at 05:57:40PM +0200, Christian Schoenebeck wrote:
> > > > > On Wed, Jul 12, 2023 at 11:01:53AM +0200, Christian Schoenebeck
> > wrote:
> > > > > > > TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> > > > > > > "rootflags=3Dignoreqv" fixes it as well, but it feels like a
> > regression.
> > > > > >
> > > > > > What's the precise set of 9p mount options on guest, which 9p
> > server is used
> > > > > > and what are 9p server's options respectively?
> > > > >
> > > > > The server is qemu, started like this:
> > > > >
> > > > > qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 102=
4M
> > -nographic -no-reboot -net nic,netdev=3Dnet1 -netdev
> > user,id=3Dnet1,hostfwd=3Dtcp:127.0.0.1:27737-:22,hostfwd=3Dtcp:127.0.0.=
1:12345-:12345
> > -rtc base=3D2000-01-01 -object rng-random,filename=3D/dev/random,id=3Dr=
ng0
> > -device virtio-rng-device,rng=3Drng0 -device virtio-scsi-device,id=3Dsc=
si
> > -fsdev local,id=3Drootfs,path=3D./platform-v7a/root,security_model=3Dma=
pped-file
> > -device virtio-9p-device,fsdev=3Drootfs,mount_tag=3D/dev/root -kernel
> > ./platform-v7a/images/linuximage -dtb
> > ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=3D/dev/root
> > rootfstype=3D9p rootflags=3Dtrans=3Dvirtio console=3DttyAMA0,115200 log=
level=3D5
> > systemd.show_status=3Dauto'
> > > > >
> > > > > This is qemu 8.0.2.
> > > >
> > > > Does adding QEMU option "multidevs=3Dremap" [1] resolve it?
> > > >
> > > > [1]
> > https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly
> > >
> > > Unfortunately not:
> > >
> > > + exec ./platform-v7a/sysroot-host/bin/qemu-system-arm -machine
> > vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net
> > nic,netdev=3Dnet1 -netdev user,id=3Dnet1,hostfwd=3Dtcp:127.0.0.1:27737
> > -:22,hostfwd=3Dtcp:127.0.0.1:12345-:12345 -rtc base=3D2000-01-01 -object
> > rng-random,filename=3D/dev/random,id=3Drng0 -device vi
> > > rtio-rng-device,rng=3Drng0 -device virtio-scsi-device,id=3Dscsi -fsdev
> > local,id=3Drootfs,path=3D./platform-v7a/root,security_model=3Dmapped-fi=
le,multidevs=3Dremap
> > -device virtio-9p-device,fsdev=3Drootfs,mount_tag=3D/dev/root -kernel
> > ./platform-v7a/images/linuximage -dtb
> > ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=3D/dev/
> > > root rootfstype=3D9p rootflags=3Dtrans=3Dvirtio console=3DttyAMA0,115=
200
> > loglevel=3D5 systemd.show_status=3Dauto'
> >
> > I don't see any cache option here. I would expect at least cache=3Dmmap=
 here:
> >
> > https://wiki.qemu.org/Documentation/9p_root_fs#Boot_the_9p_Root_FS_Syst=
em
> >
> > By default it's cache=3Dnone, which means no mmap() would be allowed ei=
ther.
> >
> > > [    0.000000] L2C: platform modifies aux control register: 0x02020000
> > -> 0x02420000
> > > [    0.000000] L2C: DT/platform modifies aux control register:
> > 0x02020000 -> 0x02420000
> > > [    0.004806] smp_twd: clock not found -2
> > > [    1.069767] simple-pm-bus bus@40000000:motherboard-bus@40000000
> > :iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcref=
clk
> > > [    1.085798] simple-pm-bus bus@40000000:motherboard-bus@40000000
> > :iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcref=
clk
> > > [    1.153420] physmap-flash 48000000.psram: map_probe failed
> > > [    1.535013] 9pnet_virtio: no channels available for device root
> > >
> > >  ____                        _                   _
> > > |  _ \ ___ _ __   __ _ _   _| |_ _ __ ___  _ __ (_)_  __
> > > | |_) / _ \ '_ \ / _` | | | | __| '__/ _ \| '_ \| \ \/ /
> > > |  __/  __/ | | | (_| | |_| | |_| | | (_) | | | | |>  <
> > > |_|   \___|_| |_|\__, |\__,_|\__|_|  \___/|_| |_|_/_/\_\
> > >                  |___/
> > >
> > >  ____  _     _             _  ___ _
> > > |  _ \(_)___| |_ _ __ ___ | |/ (_) |_
> > > | | | | / __| __| '__/ _ \| ' /| | __|
> > > | |_| | \__ \ |_| | | (_) | . \| | |_
> > > |____/|_|___/\__|_|  \___/|_|\_\_|\__|
> > >
> > >
> > > OSELAS(R)-DistroKit-2019.12.0-00429-g57ffae760eb9 /
> > v7a-2019.12.0-00429-g57ffae760eb9
> > > ptxdist-2023.07.1/2023-07-11T19:56:50+0200
> > >
> > > DistroKit login: root
> > > root@DistroKit:~ mount / -o remount,rw
> > > root@DistroKit:~ ldconfig
> > > ldconfig: Cannot mmap file /lib/libgcc_s.so.1.
> > >
> > > ldconfig: Cannot mmap file /lib/libstdc++.so.
> >
> > Again, effective 9p mount options are always useful, e.g. `mount | grep=
 9p`
> >
> > >
> > > [...]
> > >
> > > rsc
> > >
> >
> >
> >
>=20




