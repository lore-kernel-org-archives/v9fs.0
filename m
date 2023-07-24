Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03DDDC8
	for <v9fs@lists.linux.dev>; Mon, 24 Jul 2023 21:17:42 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qO2vw-0007nO-2D; Mon, 24 Jul 2023 23:17:36 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qO2vt-009q1A-8O; Mon, 24 Jul 2023 23:17:33 +0200
Date: Mon, 24 Jul 2023 23:17:33 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 0/4] fs/9p: fix mmap regression
Message-ID: <ZL7qbTU7D1mAJePi@pengutronix.de>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Hi Eric,

On Wed, Jul 19, 2023 at 03:17:04PM +0000, Eric Van Hensbergen wrote:
> This series attempts to fix a reported exception with mmap
> on newer kernels.
>
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
> Changes in v3:
> - Clarify debug print to read-only mmap mode versus no mmap mode in
>   v9fs_file_mmap
> - Fix suggested regression tags and propagate across series
> - Link to v2: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org
>
> Changes in v2:
> - fix requested changes in commit messages
> - add patch to remove unnecessary invalidate_inode_pages in mmap readonly path
> - Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org

I've tested this patch series with my qemu setup and it resolves the
issue. Thanks for taking care!

Tested-by: Robert Schwebel <r.schwebel@pengutronix.de>

----------8<----------

rsc@dude05:~/work/DistroKit$ configs/platform-v7a/run
Forwarding SSH port 127.0.0.1:24910 -> qemu:22
[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.004896] smp_twd: clock not found -2
[    0.726397] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.742338] simple-pm-bus bus@40000000:motherboard-bus@40000000:iofpga@7,00000000: Failed to create device link (0x180) with dcc:tcrefclk
[    0.809910] physmap-flash 48000000.psram: map_probe failed
[    1.201306] 9pnet_virtio: no channels available for device root

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
root@DistroKit:~ uname -a
Linux DistroKit 6.4.0 #1 SMP PREEMPT 2023-07-01T00:00:00+00:00 armv7l GNU/Linux

----------8<----------

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
