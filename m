Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E26C8C0
	for <v9fs@lists.linux.dev>; Sun, 21 Jul 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721600260; cv=none; b=UHxcQ7bkwJw6QaNlCaDOB157RcOvAEecLXIMJ5IAmenp6U4w2oJEq7B23lId1CYqbyhMtX3aKPBAIhJpkeugJ8RlNZEuOz6VJ1ul/zMc4k6CunUI6qg5v4GCbN6O1du8M6VRCwNtswQ7AP326Lv+mVRIh2MU9shPXRm+pYtHObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721600260; c=relaxed/simple;
	bh=TZ9/3rxca7T59QaRL6ArlZNruw3gmw8YLU7BBeCByLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG726tnBAv0J7CbUgkx53mXSDSUgdHBT6zz5RBJ60kru+2Y503xAaLR6t5s1ieRtDe0uTg84NdvGtiQCvcEa+TbegMxcKhYKfgcG1DswkMGYbZOKsfhcR3iHJ+dlGakdX/2ezjdYX2/HD4HIbUBIygPVxK0TSBV/lKxsnNGJm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sVes0-0003eg-89; Mon, 22 Jul 2024 00:17:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sVerz-001ExY-IE; Mon, 22 Jul 2024 00:17:31 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sVerz-009lYD-19;
	Mon, 22 Jul 2024 00:17:31 +0200
Date: Mon, 22 Jul 2024 00:17:31 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [PATCH v7 0/3] usb: gadget: 9pfs transport
Message-ID: <Zp2I-5dOO0cwrbDt@pengutronix.de>
References: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dn6xeIo9RQ42v8oe"
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--Dn6xeIo9RQ42v8oe
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ignore this series. There is no difference to v6 here. I will send
v8 in a sec.

On Mon, Jul 22, 2024 at 12:08:16AM +0200, Michael Grzeschik wrote:
>This series is adding support to mount usb hostside exported 9pfs
>filesystems via the usb gadget interface. It also includes a simple tool
>(p9_fwd.py) to translate an tcp 9pfs transport and reuse it via the usb
>interface.
>
>    +--------------------------+    |    +--------------------------+
>    |  9PFS mounting client    |    |    |  9PFS exporting server   |
> SW |                          |    |    |                          |
>    |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
>    +-------------^------------+    |    +-------------^------------+
>                  |                 |                  |
>                  |                 |           +------v------+
>                  |                 |           |  p9_fwd.py  |
>                  |                 |           +------^------+
>                  |                 |                  |
>------------------|------------------------------------|-------------
>                  |                 |                  |
>    +-------------v------------+    |    +-------------v------------+
>    |                          |    |    |                          |
> HW |   USB Device Controller  <--------->   USB Host Controller    |
>    |                          |    |    |                          |
>    +--------------------------+    |    +--------------------------+
>
>The USB host exports a filesystem, while the gadget on the USB device
>side makes it mountable.
>
>Diod (9pfs server) and the forwarder are on the development host, where
>the root filesystem is actually stored. The gadget is initialized during
>boot (or later) on the embedded board. Then the forwarder will find it
>on the USB bus and start forwarding requests.
>
>In this case the 9p requests come from the device and are handled by the
>host. The reason is that USB device ports are normally not available on
>PCs, so a connection in the other direction would not work.
>
>One use-case is to use it as an alternative to NFS root booting during
>the development of embedded Linux devices.
>
>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>---
>Changes in v7:
>- added back the req_lock spinlock
>- Link to v6: https://lore.kernel.org/r/20240116-ml-topic-u9p-v6-0-695977d=
76dff@pengutronix.de
>
>Changes in v6:
>- fixed the python script not to have path set by default
>- improved the lock init
>- fixed usb9pfs status change to connected
>- Link to v5: https://lore.kernel.org/r/20240116-ml-topic-u9p-v5-0-5ed0abd=
53ef5@pengutronix.de
>
>Changes in v5:
>- fixed lockup in mount -> remount -> monut scenario
>- improved p9_fwd transport script with more options
>- Link to v4: https://lore.kernel.org/r/20240116-ml-topic-u9p-v4-0-722ed28=
b0ade@pengutronix.de
>
>Changes in v4:
>- reworked the naming scheme to be set by the configfs instance
>- added conn_cancel function to properly stop the transfers
>- ensured that umount -f will work even when the host side has crahed
>- added all the review feedback from Andrzej Pietrasiewicz
>- Link to v3: https://lore.kernel.org/r/20240116-ml-topic-u9p-v3-0-c62a36e=
ccda1@pengutronix.de
>
>Changes in v3:
>- dropped patch "usb: gadget: legacy: add 9pfs multi gadget" as discussed =
with gregkh
>- Link to v2: https://lore.kernel.org/r/20240116-ml-topic-u9p-v2-0-b46cbf5=
92962@pengutronix.de
>
>Changes in v2:
>- improved the commit messages
>- introduced an patch to move the header u_f.h to include/linux/usb to com=
pile usb gadget functions treewide
>- moved usbg gadget function to net/9p/
>- adderessed several comments in function driver, like the cleanup path an=
d kbuild errors
>- improved the documentation in Documentation/filesystems/9p.rst
>- Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306=
f9a4e@pengutronix.de
>
>---
>Michael Grzeschik (3):
>      usb: gadget: function: move u_f.h to include/linux/usb/func_utils.h
>      net/9p/usbg: Add new usb gadget function transport
>      tools: usb: p9_fwd: add usb gadget packet forwarder script
>
> Documentation/filesystems/9p.rst                   |  58 +-
> drivers/usb/gadget/configfs.c                      |   2 +-
> drivers/usb/gadget/function/f_fs.c                 |   2 +-
> drivers/usb/gadget/function/f_hid.c                |   2 +-
> drivers/usb/gadget/function/f_loopback.c           |   2 +-
> drivers/usb/gadget/function/f_midi.c               |   2 +-
> drivers/usb/gadget/function/f_midi2.c              |   2 +-
> drivers/usb/gadget/function/f_sourcesink.c         |   2 +-
> drivers/usb/gadget/u_f.c                           |   2 +-
> .../gadget/u_f.h =3D> include/linux/usb/func_utils.h |   2 +-
> net/9p/Kconfig                                     |   6 +
> net/9p/Makefile                                    |   4 +
> net/9p/trans_usbg.c                                | 985 ++++++++++++++++=
+++++
> tools/usb/p9_fwd.py                                | 243 +++++
> 14 files changed, 1304 insertions(+), 10 deletions(-)
>---
>base-commit: 2c9b3512402ed192d1f43f4531fb5da947e72bd0
>change-id: 20240116-ml-topic-u9p-895274530eb1
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

--Dn6xeIo9RQ42v8oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmadiPgACgkQC+njFXoe
LGR6MA/+NZfqAPqThG3QqfRrO6HDJ5Xm4ju9b2dHnNHpkDGotIxq+/qlL7Oky5e1
uSDbPTsSCmYokfqIqdPcmhTbLqKfIXQMhRkOysn4p0bBI5bcWrzT/hs5AW9xJl2P
PS7dKEcyPNutmPSpv8tcwUaham9mv8sP3jfSO8jt6YLzSPu2vHkTB7s/cOMaQEFp
+vhE93Ftj/2H3h0DQWs09+cVkg7F4MJS/9dz8O6Erg/DQlWReBdrSGPX7QS06hsP
3oPseZ+gh7PvkuDzMENx5xYbi02jQAHSh6IFzCxzYxcZSIz6wtNCFZu3KgiDAmdm
LAy9VeeMmlqpBQYEbk86IWuuC22GRek6CHR78B7dsJ61KZ2hh/bnW7/Yh+ff6Lty
SQyCAwGSYAnYIb+4x7e0BPhfj7ajzk+/63owwrn4l+v0DniGjhrKylBaKva/+kFE
dHWsQtK1gBUy+tCsNE3oLVU5TzDlNZ4p5Y7da/h37zGo4g+T0/hWBWUcWwWbHAcC
pFshb6WIrQSmzUU+ezVuvc5fF6/kfZ7QdqQopI9F/dA5h4NYtne3WotNTwfcfMJL
TGOmP5TzzyR6Gnl6rVIu0BGwkPCu+8wFWNcJO9ZDti+9/dHHT9fdyfaKL7Jf2iS5
EK5HF5xGV9QZLoPj5H8qH6GG63+/8n8UGg2UyAQvpq2F87Ks0SM=
=F69B
-----END PGP SIGNATURE-----

--Dn6xeIo9RQ42v8oe--
