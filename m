Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17345D271
	for <v9fs@lists.linux.dev>; Thu, 16 May 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889110; cv=none; b=m1n/mcVH+bAKvlL+B+TYohiG8bFmVf2KSlHw/MHpjbNY0UU6k/NCP0WJH9g0IIquDKd+10QEJlag8Bqk4MN2VZGSgTB6FMzwEZHiqBEiXtNdXP9Y1yYDOZEmdHE7uFlmoSovW+x0aQPv/8rcxnaZHmtwSEibqkvaXT/SFY44EWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889110; c=relaxed/simple;
	bh=s0VpWl+ubeSr9Wh6Ks9w3sfKCAJcIdouKzCfod5VvHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNF38vw/RMkbut9UB4LJLjzjlqHJZxI3jexxyHjyfwcZzX6TGaBcoTYHw7W+/htfApouvhB/ge0J9Eq2jBJOxzpK/i+4xzA5txNCWgJ20YunJETYrH/xYR4X6TDnfqhDYP4JqMVkyHg1m3paYd0rWSfEgmCK/RKY2HyJWizyQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s7h8V-0004Kf-9Z; Thu, 16 May 2024 21:51:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s7h8T-001lyt-UL; Thu, 16 May 2024 21:51:29 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s7h8T-00ExOe-2j;
	Thu, 16 May 2024 21:51:29 +0200
Date: Thu, 16 May 2024 21:51:29 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v4 2/3] net/9p/usbg: Add new usb gadget function transport
Message-ID: <ZkZjwcd95fYKdm-w@pengutronix.de>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-2-722ed28b0ade@pengutronix.de>
 <c78c9e88-bd53-4ae5-8f78-d8b1c468a5cd@collabora.com>
 <Zj3y04btf16BGZAJ@pengutronix.de>
 <2f36e766-054c-4001-addf-fe388916d858@collabora.com>
 <ZkZVHoHcdoNF6T2-@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JjFffksc5WuBgX2B"
Content-Disposition: inline
In-Reply-To: <ZkZVHoHcdoNF6T2-@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--JjFffksc5WuBgX2B
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 08:49:02PM +0200, Michael Grzeschik wrote:
>Hi
>
>On Fri, May 10, 2024 at 04:11:27PM +0200, Andrzej Pietrasiewicz wrote:
>>W dniu 10.05.2024 o=A012:11, Michael Grzeschik pisze:
>>>On Fri, May 10, 2024 at 11:25:47AM +0200, Andrzej Pietrasiewicz wrote:
>>>>Hi Michael,
>>>>
>>>>W dniu 30.04.2024 o=A001:33, Michael Grzeschik pisze:
>>>>>Add the new gadget function for 9pfs transport. This function is
>>>>>defining an simple 9pfs transport interface that consists of one in and
>>>>>one out endpoint. The endpoints transmit and receive the 9pfs protocol
>>>>>payload when mounting a 9p filesystem over usb.
>>>>>
>>>>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>>>
>>>>>---
>>>>>v3 -> v4:
>>>>>=A0 - implemented conn_cancel
>>>>
>>>>I tried this scenario:
>>>>
>>>>1) run all the components and have 9pfs up and running
>>>>2) stop the forwarder
>>>>3) umount -f at the gadget side - this indeed succeeds now in v4
>>>>4) start the forwarder again
>>>>5) mount at the gadget side - this hangs.
>>>>
>>>>Did this scenario work for you?
>>>
>>>I actually tested this exact scenario. So this is
>>>suprising. I will try this again just to be sure
>>>that I did send the latest version.
>>>
>>>My latest testsetup included the dummy_hcd. Did you test on real hardwar=
e?
>>
>>Yes, I did.
>
>I just also tested this again on real hardware. With the imx6 chipidea
>udc I indeed see that this is stuck after the first round of mount and
>remount. With the musb core on the beaglebone this seems to be fine.
>
>While debugging this I also ran into some shutdown issues and lockdep
>issues I see because the complete handler is possible to be resumed
>immedeatly on musb, which is odd. However I fixed/fix them and send an
>v5 afterwards.
>
>Regarding the hang on the imx6, which hardware did you test this on?

Nevermind. I can also reproduce the hang with the musb.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--JjFffksc5WuBgX2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZGY78ACgkQC+njFXoe
LGSTWQ//WxyTQBPN02DdbwotbPTfWvYawG2G3/I0tqgV3BX/q6shqvOCiFL5nmDo
8fkMDfi6+csGacPtPeZBvDUFzfL66laRSO/sdH+ZAKEJK/chv7pufRBUMYdQlz15
qRaaLvAK1hvuONCjA2bw4WDDaNm/GgUymAogjE9yQlDsj8F6QSt252F3ZQBQKaCM
uWZy+eUUm83h/rNYkvZqN3oCVbo43HpFXrDKQSAOpPJ+TT32wVBba7HgkYjVNimN
hSfLDKxAUJdqUfAGToj59eF63rUe+t31iZN1vgk/k3HJXmEP+nvuxes+N2cx8xVH
2v7cpIEJacspSRuGiAL+fY4xRCXJyAtlQGgllfhKZitrLAUjzDHL9mP4lK7Z7Y5q
cSGa4006jogsQSSHdQCsVfZyHUqs6ZTgJYVNSeND/ezDiAEowmdR3vq65BaRRSec
kmkQ2A9kzZmdR/PwlgyrwcP1RbHybgZH0pc9mkDFbPMzGS+XIm0w7ZWF9IX1zN5w
sKepQa+XzLfvlX0d5JVYROfXBOhEozP0s7pPQqvY/sy8B5qYZADuO5OSnA4eYRdi
M0gf6Cxj/CFCGuqKCBH5QqIrzOeB54edNFEF5Y5UzFD7T5c09GgvOd3zgaTqPxRy
MA94+dooEc/8bbHNZZuV7D8UC94YhDwWQmXZfbhNJ4piRYQSjf8=
=zqmW
-----END PGP SIGNATURE-----

--JjFffksc5WuBgX2B--
