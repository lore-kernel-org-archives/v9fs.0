Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645E100AE
	for <v9fs@lists.linux.dev>; Wed, 12 Jul 2023 14:14:10 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=leda.hi.pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <r.schwebel@pengutronix.de>)
	id 1qJabV-0000ud-A4; Wed, 12 Jul 2023 16:14:05 +0200
Received: by leda.hi.pengutronix.de (Postfix, from userid 1006)
	id E298D2C803CC; Wed, 12 Jul 2023 16:14:02 +0200 (CEST)
Date: Wed, 12 Jul 2023 16:14:02 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Message-ID: <ZK61Kpii5To2zMJx@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <3123765.Wy8GRVaxaG@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3123765.Wy8GRVaxaG@silver>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.schwebel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Christian,

On Wed, Jul 12, 2023 at 11:01:53AM +0200, Christian Schoenebeck wrote:
> > TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> > "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
> 
> What's the precise set of 9p mount options on guest, which 9p server is used
> and what are 9p server's options respectively?

The server is qemu, started like this:

qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'

This is qemu 8.0.2.

> > I could track down the breakage to
> > 
> >   1543b4c5071c54d76aad7a7a26a6e43082269b0c
> 
> This patch is sensitive about 9p server transmitting a meaningful value for
> file's QID version field. That's why more info about deployed 9p server would
> help.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
