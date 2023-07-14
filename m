Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65774C8C
	for <v9fs@lists.linux.dev>; Fri, 14 Jul 2023 05:36:26 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qKBTZ-0002OH-Fs; Fri, 14 Jul 2023 07:36:21 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qKBTX-008oTd-VR; Fri, 14 Jul 2023 07:36:19 +0200
Date: Fri, 14 Jul 2023 07:36:19 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de,
	v9fs@lists.linux.dev, groug@kaod.org
Subject: Re: mmap on 9p broken in 6.4
Message-ID: <ZLDe09znEIA9t+KF@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11571626.Ud7ZN73ssd@silver>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

On Thu, Jul 13, 2023 at 12:54:44PM +0200, Christian Schoenebeck wrote:
> About QEMU: unless the (actually unrelated) option `multidevs=remap` option is
> used, Rreaddir would return all directory entries with qid.version set to
> zero. So that's a bug on QEMU side:
>
> https://github.com/qemu/qemu/blob/71d72ececa086114df80fe4cc04d701b59002eb2/hw/9pfs/9p.c#L2534
>
> I try to send a patch for this next week, such that qid.version is always
> filled, no matter what the QEMU command line options are. In the meantime
> please use `multidevs=remap` as workaround for testing.

As said above in this thread: adding multidevs=remap doesn't help.

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
