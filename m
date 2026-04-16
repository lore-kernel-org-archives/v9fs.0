Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72C334C17
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333369; cv=none; b=VBsBL/kULpxQLT/Pi+4iWVJwLbjpuYqOoyjQsI0v9J6bs4/rrChyd0acj1U+ccbdNzPDZLqx66nhzgDS75jkyxFyHgf7tE6rwvcnzJ4+15gMdnCioSD+Lb8Uxw7iw7mlrPOU1qzVl+VG+LeljUk/dzsR7Xc9neoqunupN5H6x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333369; c=relaxed/simple;
	bh=k+Y6VnPryLUzw8oRXtv+RXbcFKzrzOgcSLkbwdOUzjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioYsKVSxxR0qCv2IeNG4A6jq1KwQltgmQs+RoS2DlPD5InLrTEe+kQQjAy/UvMvawXhSgq2WhyrfVYLt6VK4sL6KuLCMvtK5MHcXWzWCF7HZqBOOgyiOYWRrkV3UD+6XWQsZH5i38qvMQTtpjLg4NWXCkbgUfNMB5HFd6NRv8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1wDJS8-000382-Om; Thu, 16 Apr 2026 11:56:04 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1wDJS7-005enY-2B;
	Thu, 16 Apr 2026 11:56:03 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1wDJS7-0000000DfDZ-2Otg;
	Thu, 16 Apr 2026 11:56:03 +0200
Date: Thu, 16 Apr 2026 11:56:03 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, Pierre Barre <pierre@barre.sh>,
	sandeen@redhat.com, Remi Pommarel <repk@triplefau.lt>,
	David Howells <dhowells@redhat.com>
Subject: Re: 9p patches in flight recap/what did I miss
Message-ID: <aeCyM2ReRaofLO2h@pengutronix.de>
References: <aeBToj14IBI6jh6Q@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MX7ilkxMjicSZ20D"
Content-Disposition: inline
In-Reply-To: <aeBToj14IBI6jh6Q@codewreck.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--MX7ilkxMjicSZ20D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 12:12:34PM +0900, Dominique Martinet wrote:
>Hi all,
>
>This is mostly for myself as I can't keep up, please tell me if I'm
>missing anything obvious.
>
>I have these queued for 7.1-rc1 (will send early next week to Linus)
>
>https://lore.kernel.org/r/20260225135745.351984-1-sashal@kernel.org/
>* 0fd76f1be20d 9p: fix memory leak in v9fs_init_fs_context error path
>https://lore.kernel.org/r/0ddc72da-d196-4f01-8755-0086f670e779@app.fastmai=
l.com/
>* da2346a48a5a 9p: fix access mode flags being ORed instead of replaced
>https://lore.kernel.org/r/20260315190633.73536-1-xaum.io@gmail.com/
>* 890d56964c62 9p: document missing enum values in kernel-doc comments
>https://lore.kernel.org/r/20260324153023.86853-2-ericterminal@gmail.com/
>* 72cb9ee4f6d8 9p/trans_xen: make cleanup idempotent after dataring alloc =
errors
>* 8fc518e489c1 9p/trans_xen: replace simple_strto* with kstrtouintq
>
>I have these queued for 7.2
>
>https://lore.kernel.org/r/551c057c5dbcc83f19b9c8a3b508bd971598f657.1774380=
535.git.repk@triplefau.lt/
>* fabe6e8af53a 9p: Cache negative dentries for lookup performance
>* 2e624a12ba29 9p: Add mount option for negative dentry cache retention
>* 060ba5a058cb 9p: Set default negative dentry retention time for cache=3D=
loose
>* 47a37d360868 9p: Enable symlink caching in page cache
>
>And these that need some work/help sorting out
>- usb fixes 20260319-9pfixes-v1-0-c977a7433185@pengutronix.de
>** I don't have the bandwidth for such a big rework, happy to just trust
>Michael here given I can't test usb...

I just worked in some feedback from sashiko. And sashiko really got some
points. Although I have embedded devices to further test this, I am
about to leave Pengutronix in the end of April I don't know if I will be
able to solve all the obstacles in the series until then.

>- writeback corruption 20251227083751.715152-1-pierre@barre.sh
>** David sent another patch but honestly it's too complex for a quick
>review, my gut feeling is to prefer Pierre's simpler approach first and
>take the time to iterate (if we ever find time to...), but I just
>haven't the time to check even that.
>- lifting virtio msize limit
>cover.1657920926.git.linux_oss@crudebyte.com and/or virtio buffer
>iteration 20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org
>** Once again ENOTIME stikes so I didn't check, but do your patches also
>address the invalid access problem? Should we get Chris to test with
>your patches?
>I still think it's a shame to duplicate all this code and it should be
>possible to do a bit better, but I agree improving sg_table is an
>elephant I don't want to fight...
>
>
>Thank you all,
>
>by the way if anyone wants to take over for (at least) the next few
>cycles I wouldn't mind at all, having a shiny new baby and a jealous 3yo
>doesn't help :p
>--=20
>Dominique
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--MX7ilkxMjicSZ20D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmngsisACgkQC+njFXoe
LGSRFxAAv93Ad029XMJRQuagh0PG1SmJzH3sbutesRUqDKLLZGqbVQAvwp1qDCao
Vb16QQekWz4am68sEFkMnrxmZ+uRA5x21/vLNz6UaL5OW8vW+LeLGqtY7vRZScdj
zELyxR8+U3KWGYrXjgNMQ1M93HMpXvp/A9obUS3el7ysMMyzCnMZmxQSxBFvE31R
bo0qpachlWpMglK/V3gyZaP5/lTP/IMu9lj4tu1Xg7PtmHruLHFnFQ5A6sog4I2i
soWe813t8hPQTwH0B6d233E4OukO1DBIlFZqI3TxFQ5LQbtMY3WOEQVZJ/GXXVf+
yqGjNoWyRpZ4nt6blvLVcnrGAzFHgCKLjY9WNZbMCaPdF1OmboT+vUza58kZpqef
U0+YPFxJom5QlBpW9uVCDxNRXtAUJ1tTl8tpRwlUG2sGRhemQ4kWuFWjW20PNLco
jtFkNtkiv0PY8zq/fiM17oPMQuV+UEuGLidIDBFGdYs1+MBe7I8tT3naxio+wtxr
kfxlAoSccDEaR9Ae8Civ+JwaXvs+imSUX5dz9UG2QeQEOnow4DfgK8q4Y2CaPXIi
y7pIfx2PI4MHyjixyKb3QNv0fO9D+c4e+XMsHG/X/9hLlg3b3m04oaDfCHUW461L
p2p4mAVg+fLXKtDrfSqoDBYYuGOnAv5KvoaW602JOqYHwNIrE4Y=
=1uoj
-----END PGP SIGNATURE-----

--MX7ilkxMjicSZ20D--
