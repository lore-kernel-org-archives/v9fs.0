Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91185947B
	for <v9fs@lists.linux.dev>; Mon, 17 Jul 2023 11:26:26 +0000 (UTC)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rsc@pengutronix.de>)
	id 1qLMMu-0002WB-FS; Mon, 17 Jul 2023 13:26:20 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <rsc@pengutronix.de>)
	id 1qLMMs-00EUIi-TX; Mon, 17 Jul 2023 13:26:18 +0200
Date: Mon, 17 Jul 2023 13:26:18 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>, kernel@pengutronix.de,
	v9fs@lists.linux.dev, groug@kaod.org
Subject: Re: mmap on 9p broken in 6.4
Message-ID: <ZLUlWpnmM6068KV3@pengutronix.de>
References: <ZK25XZ+GpR3KHIB/@pengutronix.de>
 <8322841.litLk3al4c@silver>
 <CAFkjPTmrbe9Djs_iYf=vu1xbTLhey0OmePR2Jw=C_dbQVYnAhQ@mail.gmail.com>
 <11571626.Ud7ZN73ssd@silver>
 <ZLDe09znEIA9t+KF@pengutronix.de>
 <CAFkjPTkNhGEDVyozHbVCkkFEkuQKiO6tn8Qjt4occMoupUupZw@mail.gmail.com>
 <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkjPTmyo0yXy2cGN9Zzic6Jd3QXLdhj5bUtNpQCvAudShx+Rw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Hi Eric,

On Sun, Jul 16, 2023 at 02:48:27PM -0500, Eric Van Hensbergen wrote:
> A quick update on this, I have a patch and it passes regressions

Thanks for taking care! If you send the patch(es), I can test them in my
setup.

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
