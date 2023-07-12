Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B1214E0
	for <v9fs@lists.linux.dev>; Wed, 12 Jul 2023 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=2cfAazte1yvug2agssihFjXYbgBeJrTbmNht7OfVLFM=; b=hrLZv4vuvRDaUzplHKB50An06o
	d4Y7WajAX1+ZJMx8f26mExBX6Tyh0msjMrGiLjSr2900xSL+Fsck6PUqfJY0HbQM4F211h7wZUOcR
	In93ot/zk6d9D6mevN3lzZHqepcKIO82FxzIs+O6jKZggZgRDTgtTebjsnyiCcCEMf6j4HJS4M/w+
	XHyfVURTf2YMdQ3vnBbKznBUEiJEnSY2R5lkQw7aZfiXWtxGbvxHiJXdf8jr32a2OnP26PrTTCvz7
	WFvrdSaB54m+boqSDz3YfsxKOq/ToU1cEwEjeU+c4JRqFxA7woSJuqzRDEibl/BLBTipFOLUyXNim
	V11r9Lp2rQNWxEbmK0r4Z432kHtvf5Qe+Kq3cZvwslRrlM1AVeMY6SdFQlF7J2SmaEGZ+UqxAQdx/
	OWb4gNtAkZFZiHYKR1v/XmTFN9y9dGB1m6Biz4XGL5B70gCeaUJGYemjdy1nvburhB0NcnNaUzP8R
	m3nKV4dXMW8vxxky0SUicPBp5Wn27ZvJXv36wXXPbmjkzLNhcvTholKoFHR/1CduyAnfHPMgdBLtw
	9xVzywLegqFfN3Tr3lc2xRphbtJWMR6tVlQT7SeusdcFAgjGqrbTP8WWC8AU4jwftE829dTpw3qeE
	qMphf6evGpMZCk96aNwX0czhi5dZ9SycTWNysCH8Y=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 kernel@pengutronix.de
Subject: Re: mmap on 9p broken in 6.4
Date: Wed, 12 Jul 2023 17:57:40 +0200
Message-ID: <13302114.90OgOEUrqp@silver>
In-Reply-To: <ZK61Kpii5To2zMJx@pengutronix.de>
References:
 <ZK25XZ+GpR3KHIB/@pengutronix.de> <3123765.Wy8GRVaxaG@silver>
 <ZK61Kpii5To2zMJx@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, July 12, 2023 4:14:02 PM CEST Robert Schwebel wrote:
> Christian,
> 
> On Wed, Jul 12, 2023 at 11:01:53AM +0200, Christian Schoenebeck wrote:
> > > TL;DR: mmap() seems to be broken on 9pfs on Linux 6.4. setting
> > > "rootflags=ignoreqv" fixes it as well, but it feels like a regression.
> > 
> > What's the precise set of 9p mount options on guest, which 9p server is used
> > and what are 9p server's options respectively?
> 
> The server is qemu, started like this:
> 
> qemu-system-arm -machine vexpress-a9 -cpu cortex-a9 -smp 4 -m 1024M -nographic -no-reboot -net nic,netdev=net1 -netdev user,id=net1,hostfwd=tcp:127.0.0.1:27737-:22,hostfwd=tcp:127.0.0.1:12345-:12345 -rtc base=2000-01-01 -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-device,rng=rng0 -device virtio-scsi-device,id=scsi -fsdev local,id=rootfs,path=./platform-v7a/root,security_model=mapped-file -device virtio-9p-device,fsdev=rootfs,mount_tag=/dev/root -kernel ./platform-v7a/images/linuximage -dtb ./platform-v7a/images/vexpress-v2p-ca9.dtb -append 'root=/dev/root rootfstype=9p rootflags=trans=virtio console=ttyAMA0,115200 loglevel=5 systemd.show_status=auto'
> 
> This is qemu 8.0.2.

Does adding QEMU option "multidevs=remap" [1] resolve it?

[1] https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly

> > > I could track down the breakage to
> > > 
> > >   1543b4c5071c54d76aad7a7a26a6e43082269b0c
> > 
> > This patch is sensitive about 9p server transmitting a meaningful value for
> > file's QID version field. That's why more info about deployed 9p server would
> > help.
> 
> rsc
> 




