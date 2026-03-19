Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341E3AD507
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911780; cv=none; b=Svsm/MwBxNGDlK4napuas12KOifiTtzop3qtKc20BZZ98n+oYdj/+TwvGMzTT+pgMheBtntrDsFc0R9FKX9xzjDjHfjhjGyMUvxowoCuQdCMc8k5kHLob6XWw4Wx/BZxWK5saYEbR7HZeQkvaSJ6uLsJmX+9Kbx9XdN2L+w7SU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911780; c=relaxed/simple;
	bh=LVkjrkJ9IPdMj7LZgIaPDS8LSm5H1bYTo56ynT6WiO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXiNW54IPfphBU7LvbWA/HziD7THpuWj+QiejcRdDOe4YtkABGfgdgSfHxCc+HU+YoSItRC9gkclOJHtFdpBV1AXrX1s6GJjfyua3iV6UqDAAXnPpmAxWuy6HK6YfZrT8P5D6+/fuQ+TFQdCD7LosFIRepu8pi/T8xsmFjmZKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U6-0000CU-2G; Thu, 19 Mar 2026 10:16:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U5-00136C-1T;
	Thu, 19 Mar 2026 10:16:05 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1w39U5-0000000AzAZ-1Rqi;
	Thu, 19 Mar 2026 10:16:05 +0100
Date: Thu, 19 Mar 2026 10:16:05 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Hyungjung Joo <jhj140711@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com,
	gregkh@linuxfoundation.org, v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abu-1VmxKlRgHcyX@pengutronix.de>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
 <abs0Q2Sw3WvLYFbe@pengutronix.de>
 <abtDrEQ4ySmhujwG@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4WYxWkQe8rtZPHj"
Content-Disposition: inline
In-Reply-To: <abtDrEQ4ySmhujwG@codewreck.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--i4WYxWkQe8rtZPHj
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 09:30:36AM +0900, Dominique Martinet wrote:
>Michael Grzeschik wrote on Thu, Mar 19, 2026 at 12:24:51AM +0100:
>> On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
>> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> I wonder where greg did this review? Was this in another thread?
>
>Yes, it was when Hyungjung Joo sent this to security@, so the review was
>not public

Since the patch was already reviewed by greg, I decided to keep it
as much as it is and include it in one in my series. This way I can keep
the Reviewed-by and the Fixes tag for stable.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--i4WYxWkQe8rtZPHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmm7vtIACgkQC+njFXoe
LGQMMw//Y75flWnO9S/ayzdszgGvjtGyUBIPxPS2u4qWDL3rkz+MsILQy2MhEVtJ
6UCJ1qNFWE6i6fmlIiP4OtUPqqn8lbeYmevVQQoyDrzSH/MVpv7cwdxtsBZNeM+j
inSJaKd2HTh4BwaIY110NIUomWM7oGONdujN6zTHEQNPyhge5rlRefrhVjN3ksg8
K1b7zlqjak0hE1cZhyQW1XwF7ZRbDPw7h0Q1xXULS1JAKxLyXsmsuDg79rvOIybd
cx/vgZDjgbyZwYPV5R+LpbWu5L91j/VkrstfWX84fKuopcpts+rNbZshEmdlIQ4V
mHkfZMpKJISUzKIvPZNaW53b7rmMy1TE9OybJOm/E4Fd7F4XC/ZxTj/6UQ6IBOwn
RJzyzUOjjkMpts1d/t1SGSBMnAxqVyC/iWFSU1p5XecwAQwk3dNaBF020fpDmc/i
3N6TSfbRpkGyfl2mcAExtdj6DHK4iOBbMyKwr6YeXPPmipdAhoURzbY04zpo/D/N
xxcckrAMbjSE3Q3JJTzAxFdpoMBjgjMDYp08iMvHkoZzU45gn83RfqsexX9RpgOZ
Ats76O/mKnMnKNX8WAl2CJI8QMn9TojU4S+a3xSk5f5hEvKEeETtFS8tiA2HQEkq
K33lgF8d0yo/DCAjvHJF3/PwnOfwH84RKdhGQfqu8BOAuimDce8=
=KKPF
-----END PGP SIGNATURE-----

--i4WYxWkQe8rtZPHj--
