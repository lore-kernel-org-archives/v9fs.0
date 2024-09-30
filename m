Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE13D52E
	for <v9fs@lists.linux.dev>; Mon, 30 Sep 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694517; cv=none; b=saAy01hnm3y9w9FBy6PB6STZvO7vN+0JXAHMoTCWAF2oKYv5mwUAUMiRFsO0awDiMd0tfVQH1HcVnbOhrTykq2v1Vw882pp/xHtQa3FnLb7lry7y9pQHbYackCjrXc7S4pvObPIgFiuyV23u7W/UwKKb+wBF3cdWqBgObSGX/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694517; c=relaxed/simple;
	bh=dUHXrAjaEgbJdnwfe10A/Ln6LcEHMun1Bgy2uHw0MUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBCNZ4qxbybUJa6l2HoMy8fneS52hgzLpKGOGz+1XX5fqT7pBhjpUG3BH/VrnzUXFIcEXPgZkSankG+Yr1U9g4hR88Gf00dreYYLPsVI92Dqi585Ntsj5KU/k/oKqiLt9DesNAGy0Mtuz1+BPhiuNhEpyJdX2WicAlxEv0hd6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1svEGS-0003CR-0j; Mon, 30 Sep 2024 13:08:28 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1svEGQ-002cHG-Tc; Mon, 30 Sep 2024 13:08:26 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1svEGQ-0033C8-2g;
	Mon, 30 Sep 2024 13:08:26 +0200
Date: Mon, 30 Sep 2024 13:08:26 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] net/9p/usbg: dont call usb9pfs_clear_tx if client is not
 connected
Message-ID: <ZvqGqilMi3Zpm_Fv@pengutronix.de>
References: <20240929-fixes9p-v1-1-40000d94d836@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sp3Y2y65ZqqPTOiT"
Content-Disposition: inline
In-Reply-To: <20240929-fixes9p-v1-1-40000d94d836@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--Sp3Y2y65ZqqPTOiT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please drop this patch for now. I will have to do some more testing
regarding the prompt connect mount and disconnect state changes
and will come back with a proper solution.

On Sun, Sep 29, 2024 at 09:22:55PM +0200, Michael Grzeschik wrote:
>When the client is not Connected it is not valid to call
>usb9pfs_clear_tx since the endpoints are not even allocated. By running
>into p9_usbg_close in that case we would dereference the in_req which is
>NULL when the client->status is Disconnected. Fix that by leaving
>usb9pfs_clear_tx immediately if the state is wrong.
>
>We also update the client->status after the for usb9pfs_clear_tx to
>check for the actual state when running from p9_usbg_close.
>
>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>---
> net/9p/trans_usbg.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
>index 975b76839dca1..64a5209943dbc 100644
>--- a/net/9p/trans_usbg.c
>+++ b/net/9p/trans_usbg.c
>@@ -417,6 +417,10 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pf=
s)
> {
> 	struct p9_req_t *req;
>
>+	/* we are not allocated - return */
>+	if (usb9pfs->client->status !=3D Connected)
>+		return;
>+
> 	guard(spinlock_irqsave)(&usb9pfs->lock);
>
> 	req =3D usb9pfs->in_req->context;
>@@ -442,10 +446,10 @@ static void p9_usbg_close(struct p9_client *client)
> 	if (!usb9pfs)
> 		return;
>
>-	client->status =3D Disconnected;
>-
> 	usb9pfs_clear_tx(usb9pfs);
>
>+	client->status =3D Disconnected;
>+
> 	opts =3D container_of(usb9pfs->function.fi,
> 			    struct f_usb9pfs_opts, func_inst);
>
>
>---
>base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
>change-id: 20240929-fixes9p-5d618bbe6d6b
>
>Best regards,
>--=20
>Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Sp3Y2y65ZqqPTOiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmb6hqYACgkQC+njFXoe
LGTacRAAorBN3ZIxPQ3yEJ94ySkNxxX09jnCW5UQLjldnQ4ibbet0lpmXShxpBc7
G9CubOZOJ6efYci8Kzd4dtM1WXI8/QM3Io1BYJJ8IQj3AT8CWFdARRhtviCianqQ
VOQPWXJhtId0l6TPHRMvc76blSF5F1eirAjV4PEHV/mWreNu1WypKVXanAJcApVI
f1qGfc9EcIDEWb9KJdB8x98SgCsaJR60SQfuiWQn2VtZnxFRMz+VwOn5gR20H56m
YWlMQsofkDf5J+KLPV9r48AZ2ArqUTWU5KMrIx7z9wOhzVmU4C3/b/exwT1Fmg9R
iloU4Toq2Mp9d6QNH+pkadGgMlxCB0LqUbh85sMKOj1DQvbrTkiCJqSK2RkxTLe/
Cp4nVUUavx7CjDY0JeAsVl4UdvoZN4KtHl3ftRoNU/48I69srdHMv+AefNN2OW7I
kbS0HI3cEW7uLb64IifD4QLEEuadCDUlfkNfkFapS+0DpshSFp2ldABTw6Rc7y6J
awUIiTAFiKSq0gPZZm7fR1CmFqgUvSRDnNv9Tcg7hm9r/WP6mqrfwx+aKWWAVLll
fEwpL45IomkKjqKUrYCNcd12obosgc1D5zkxcsBzmchet3QVvhPUQ5Gaj9vISGdc
9ddeZKCcLt8iBbWiDm82h54SwGtbI4iVXIpMtJy2WHEQ93ZO70U=
=SRyv
-----END PGP SIGNATURE-----

--Sp3Y2y65ZqqPTOiT--
