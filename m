Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86119CCF4
	for <v9fs@lists.linux.dev>; Mon, 26 Aug 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709002; cv=none; b=oGu9le6y7jnC92XAikVRkqcLdtiqZkl3tWasE9ueR2ndc9PrOUmMnKtOEk+EW0sLXWR+/XUlKZ1KBUF4LQBEywqQYWGopQ2JLxJDwFTYs9+885xPbAAtFJuB6w0F+gewErMfNAA5eVjxT8L+zqiTfgB0RMrDH9Vcln9xqwMmj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709002; c=relaxed/simple;
	bh=YJ3tRDhtDoPbJA9n+5dj1xKdtRMfYbLpSbQxBnF0Q0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS0yYYQeBo/henasC2gxEoWlBcRyFTPbgqPIKm+kwBEP2DPUy7Z5OV6W4VNUOfQ+WG//4YWco6Uc37NYvP7EK2M2jSq/hj0z2ZiC0zNsyKny2/Ya8r2VnIOoOLN/Vgro05qMpanuWQPxMsge0ojMPMs9KqACkL5rOAdhJNNHBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihau-0001Gp-Gu; Mon, 26 Aug 2024 23:49:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihau-003HKY-35; Mon, 26 Aug 2024 23:49:48 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihat-007ByZ-38;
	Mon, 26 Aug 2024 23:49:47 +0200
Date: Mon, 26 Aug 2024 23:49:47 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrzej.p@collabora.com, asmadeus@codewreck.org, corbet@lwn.net,
	ericvh@kernel.org, gregkh@linuxfoundation.org,
	kernel@pengutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, v9fs@lists.linux.dev
Subject: Re: [PATCH v9 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Message-ID: <Zsz4e0RUZ9M1OT7v@pengutronix.de>
References: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
 <20240116-ml-topic-u9p-v9-1-93d73f47b76b@pengutronix.de>
 <5fce67e8-5687-4fde-b6ee-b564a335283e@wanadoo.fr>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4m+YBvvTd+UQ/49"
Content-Disposition: inline
In-Reply-To: <5fce67e8-5687-4fde-b6ee-b564a335283e@wanadoo.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--x4m+YBvvTd+UQ/49
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:30:09AM +0200, Christophe JAILLET wrote:
>Le 23/08/2024 =E0 09:36, Michael Grzeschik a =E9crit=A0:
>>We move the func_utils.h header to include/linux/usb to be
>>able to compile function drivers outside of the
>>drivers/usb/gadget/function directory.
>>
>>Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@publ=
ic.gmane.org>
>>
>>---
>>v8 -> v9: -
>>v7 -> v8: -
>>v6 -> v7: -
>>v5 -> v6: -
>>v4 -> v5:
>>   - renamed to func_utils.h
>>v3 -> v4: -
>>v2 -> v3: -
>>v1 -> v2:
>>   - new introduced patch
>>---
>>  drivers/usb/gadget/configfs.c                              | 2 +-
>>  drivers/usb/gadget/function/f_fs.c                         | 2 +-
>>  drivers/usb/gadget/function/f_hid.c                        | 2 +-
>>  drivers/usb/gadget/function/f_loopback.c                   | 2 +-
>>  drivers/usb/gadget/function/f_midi.c                       | 2 +-
>>  drivers/usb/gadget/function/f_midi2.c                      | 2 +-
>>  drivers/usb/gadget/function/f_sourcesink.c                 | 2 +-
>>  drivers/usb/gadget/u_f.c                                   | 2 +-
>>  drivers/usb/gadget/u_f.h =3D> include/linux/usb/func_utils.h | 2 +-
>>  9 files changed, 9 insertions(+), 9 deletions(-)
>>
>>diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
>>index 0e7c1e947c0a0..0f8553795a8ed 100644
>>--- a/drivers/usb/gadget/configfs.c
>>+++ b/drivers/usb/gadget/configfs.c
>>@@ -8,8 +8,8 @@
>>  #include <linux/usb/composite.h>
>>  #include <linux/usb/gadget_configfs.h>
>>  #include <linux/usb/webusb.h>
>>+#include <linux/usb/func_utils.h>
>
>Hi,
>
>Here and in the other files, maybe, keep alphabetic order?
>(even if it is not already completely sorted)
>
>>  #include "configfs.h"
>>-#include "u_f.h"
>>  #include "u_os_desc.h"
>>  int check_user_usb_string(const char *name,
>
>...
>
>>rename from drivers/usb/gadget/u_f.h
>>rename to include/linux/usb/func_utils.h
>>index e313c3b8dcb19..9f2a32c765260 100644
>>--- a/drivers/usb/gadget/u_f.h
>>+++ b/include/linux/usb/func_utils.h
>>@@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>- * u_f.h
>>+ * usbf_utils.h
>>   *
>>   * Utility definitions for USB functions
>>   *
>>
>
>Maybe the include guard could be updated as-well?
>

I reworked it in v10:

https://lore.kernel.org/all/20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengut=
ronix.de/

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--x4m+YBvvTd+UQ/49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmbM+HsACgkQC+njFXoe
LGQESg/+KuIbwRo818qLCBM8owS/IjkRfm9s/NM5VBCHQW3B0SdIadvD4dsoXlnt
S99xcOXKzm4zLqbHGej3cHSgUkefTBEfm/1ipbbPRo4Tcppn8EmcA7cwFkkz3SIt
0tFSaLScIAvOnVAC8dTZTyGSfQH9WfEdzlBxzs/Zv1mHPYMLHIY+zPsNAANqmvrS
fFGZiohGwv7AkEgrcJ1iWCyFcJqDInQDeriMdMTdy26HX2N1ptbUAM2r1Bxhb/FW
+yO4H8cRU8WVEpgxY7S3ppy6fAyvQjBdlMUHpJlb0GHeJlwx+KmgLWhSI7Yxw+gC
cOLqnZruuO3DAge9dv6Y73xj5WZeTG50AeER37ih9AYc4YEFeSG6U/z+OCATRZJD
6JEd/UZu5W89PTRoyq4nnN8/98td/B2YVGHVrDYSXXqBUrxsFU/GQ3Y+H2w394qz
GXMCNg0JJOFAv4dxNfW7w/cTEB5EzjiFuaEsJ+G1s1AhSh+2khDGfnAIupXAhnAT
FiwgY9+bxZFlGZtmuaDXWzcr6NZvFkUB5XW7HSTv0FWI+hjvNk/GTVWucq+T5nF3
eeINgs0Sq4yxG4j4wQ4o8idnEBkr32la3XROqVWRTN8383O9pRyEwjuMGU9vB6S1
Eo74RD0JJJ+5cQpWkazz9Tpur+3c5+YCf4sU/cJMpJPqqn+uk2I=
=QduD
-----END PGP SIGNATURE-----

--x4m+YBvvTd+UQ/49--
