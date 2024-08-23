Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806713CF8E
	for <v9fs@lists.linux.dev>; Fri, 23 Aug 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398679; cv=none; b=q2SCeKDzd6cK8roT/ndZsMoL/jlbBoGi1M3pdfDOdOOP7hIuswU+P1zvPjwygOtvRthMX0yQnR2/j7UdmWK0UOB0cvIS9vpKS3YQxeWG1u4Gttb1fH8AxGn+7rm8OAUQKPtXsmUkUOzVWsCNCxqgjqM1NLyN1FgxccTp0Mdxc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398679; c=relaxed/simple;
	bh=egKHUZlmytHXwTivCp/yeSvrli/L3WSL3K8qWnOP3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9WXMS1X1einAQX5mMAn05C9ydsA6Ehb6Y/pEq2Rkt7zL1476/rWCQvv15sX8mBx1J9+ssIBLp3T0wonow9vSjgp437ZyOUNcSSeziGh+j3qAY9fnod7PCWpc0mUr14nj7MTs0cC2KSM3jCYaWJCOS8DnQ3IS9YqygbLLkCCgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1shOro-0004iZ-2K; Fri, 23 Aug 2024 09:37:52 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1shOrn-002R4d-He; Fri, 23 Aug 2024 09:37:51 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1shOrn-001YWA-1M;
	Fri, 23 Aug 2024 09:37:51 +0200
Date: Fri, 23 Aug 2024 09:37:51 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v7 2/3] net/9p/usbg: Add new usb gadget function transport
Message-ID: <Zsg8T4HgshCpVqd8@pengutronix.de>
References: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
 <20240116-ml-topic-u9p-v7-2-3a1eeef77fbe@pengutronix.de>
 <82f03be5-b8b1-4df2-8b4b-0cae5d6d67ba@suse.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="31YaXo8OCBXodDG2"
Content-Disposition: inline
In-Reply-To: <82f03be5-b8b1-4df2-8b4b-0cae5d6d67ba@suse.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--31YaXo8OCBXodDG2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Thanks for your feedback!

Based on your feedback I just send v9:

https://lore.kernel.org/r/20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutron=
ix.de


On Mon, Jul 22, 2024 at 10:49:49AM +0200, Oliver Neukum wrote:
>On 22.07.24 00:08, Michael Grzeschik wrote:
>
>>+
>>+static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_reques=
t *req,
>>+			    gfp_t gfp_flags)
>>+{
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	int ret =3D -ENOMEM;
>
>No need. This will be overwritten.

Right.

>>+
>>+	if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacket))
>>+		req->zero =3D 1;
>>+
>>+	req->buf =3D usb9pfs->p9_tx_req->tc.sdata;
>>+	req->length =3D usb9pfs->p9_tx_req->tc.size;
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero: %d\n",
>>+		usb9pfs->in_ep->name, req->actual, req->length, req->zero);
>>+
>>+	ret =3D usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
>>+
>>+	dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", ret);
>>+
>>+	return ret;
>>+}
>>+
>>+static int usb9pfs_queue_rx(struct f_usb9pfs *usb9pfs, struct usb_reques=
t *req,
>>+			    gfp_t gfp_flags)
>>+{
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	int ret =3D -ENOMEM;
>
>Overwritten in literally the next statement.

Right.

>>+	ret =3D usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
>>+
>>+	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
>>+
>>+	return ret;
>>+}
>>+
>>+static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
>>+{
>>+	struct p9_req_t *p9_req =3D NULL;
>>+	unsigned long flags;
>>+	int ret =3D 0;
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+	if (usb9pfs->p9_tx_req) {
>>+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+		return -EBUSY;
>>+	}
>>+
>>+	p9_req =3D list_first_entry_or_null(&usb9pfs->tx_req_list,
>>+					  struct p9_req_t, req_list);
>>+	if (!p9_req) {
>>+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+		return -ENOENT;
>>+	}
>>+
>>+	list_del(&p9_req->req_list);
>
>You have deleted it from the list
>
>>+	usb9pfs->p9_tx_req =3D p9_req;
>>+
>>+	p9_req_get(usb9pfs->p9_tx_req);
>>+
>>+	ret =3D usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);
>
>This means that if this function returns an error, the deletion
>from the list may or may not have happened.

I refactored this.

>>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+
>>+	return ret;
>>+}
>>+
>>+static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *r=
eq)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	int ret =3D 0;
>>+
>>+	if (req->status) {
>>+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+			ep->name, req->status, req->actual, req->length);
>>+		return;
>>+	}
>>+
>>+	/* reset zero packages */
>>+	req->zero =3D 0;
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+		ep->name, req->status, req->actual, req->length);
>>+
>>+	WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
>>+
>>+	p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
>>+
>>+	ret =3D usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
>>+	if (ret)
>>+		return;
>
>Ehhh ? Could you explain the error handling here?

Yeah, not much to explain here. It is just worthless.
Also I was not thinking through how to handle an errornous transfer
to the upper vfs layer if some tx/rx path wath broken.

I now have fixed this by not calling any enqueue from the complete
handlers but am using the wait_for_complete functions to directly
expect finished transfers and response to them. This makes error
handling much easier and is also easier on the eye to read and
understand what is actually going on. It also solves most of
the request locking issues I had to begin with.

>>+
>>+	return;
>>+}
>>+
>>+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, voi=
d *buf)
>>+{
>>+	struct p9_req_t *p9_rx_req;
>>+	struct p9_fcall	rc;
>>+	int ret;
>>+
>>+	/* start by reading header */
>>+	rc.sdata =3D buf;
>>+	rc.offset =3D 0;
>>+	rc.capacity =3D P9_HDRSZ;
>>+	rc.size =3D P9_HDRSZ;
>>+
>>+	p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
>>+		 rc.capacity - rc.offset);
>>+
>>+	ret =3D p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
>>+	if (ret) {
>>+		p9_debug(P9_DEBUG_ERROR,
>>+			 "error parsing header: %d\n", ret);
>>+		return NULL;
>>+	}
>>+
>>+	p9_debug(P9_DEBUG_TRANS,
>>+		 "mux %p pkt: size: %d bytes tag: %d\n",
>>+		 usb9pfs, rc.size, rc.tag);
>>+
>>+	p9_rx_req =3D p9_tag_lookup(usb9pfs->client, rc.tag);
>>+	if (!p9_rx_req || p9_rx_req->status !=3D REQ_STATUS_SENT) {
>>+		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
>>+		return NULL;
>>+	}
>>+
>>+	if (rc.size > p9_rx_req->rc.capacity) {
>>+		p9_debug(P9_DEBUG_ERROR,
>>+			 "requested packet size too big: %d for tag %d with capacity %zd\n",
>>+			 rc.size, rc.tag, p9_rx_req->rc.capacity);
>>+		p9_req_put(usb9pfs->client, p9_rx_req);
>>+		return NULL;
>>+	}
>>+
>>+	if (!p9_rx_req->rc.sdata) {
>>+		p9_debug(P9_DEBUG_ERROR,
>>+			 "No recv fcall for tag %d (req %p), disconnecting!\n",
>>+			 rc.tag, p9_rx_req);
>>+		p9_req_put(usb9pfs->client, p9_rx_req);
>>+		return NULL;
>>+	}
>>+
>>+	return p9_rx_req;
>>+}
>>+
>>+static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *r=
eq)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	struct p9_req_t *p9_rx_req;
>>+	unsigned long flags;
>>+
>>+	if (req->status) {
>>+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+			ep->name, req->status, req->actual, req->length);
>>+		return;
>>+	}
>>+
>>+	p9_rx_req =3D usb9pfs_rx_header(usb9pfs, req->buf);
>>+	if (!p9_rx_req)
>>+		return;
>>+
>>+	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
>>+
>>+	p9_rx_req->rc.size =3D req->actual;
>>+
>>+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
>>+	p9_req_put(usb9pfs->client, p9_rx_req);
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+	usb9pfs->p9_tx_req =3D NULL;
>>+
>>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>
>Why can usb9pfs_tx_complete() touch this without taking the spinlock?

I fixed that.

>>+
>>+	usb9pfs_transmit(usb9pfs);
>
>This can fail. What happens then?


This won't fail here anymore, due to the change I explained above.

>>+
>>+	return;
>>+}
>>+
>
>
>[..]
>
>>+static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
>
>This ought to be boolean

It can't for now since it is an 9p callback, which is currently
expecting int.

>>+{
>>+	struct f_usb9pfs *usb9pfs =3D client->trans;
>>+	unsigned long flags;
>>+	int ret =3D 1;
>>+
>>+	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+
>>+	if (req->status =3D=3D REQ_STATUS_UNSENT) {
>>+		list_del(&req->req_list);
>>+		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
>>+		p9_req_put(client, req);
>>+		ret =3D 0;
>>+	}
>>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+
>>+	return ret;
>>+}
>
>	Regards
>		Oliver
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--31YaXo8OCBXodDG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmbIPEoACgkQC+njFXoe
LGT2rxAAlUrNbz/B7Ppej4PJSoCQeQXV/gu0gi8ViB21aYim1CMiQNs49n9OAhH9
soMvuFEVLbsT6cP2S9Deeln8hnGB4bZk/Bi0E9C8BOhB0UVF8KHrBJ08/vqfQBrn
vhSVHVJPx30iG0ywzEi7IUcjGELm2rD/+5YcMZO7smZfeRALZBVVfrBY8hG8gfBI
TuJZ/u9xEVWGIDlsEBVMCIwenVmwpdgBmGXmowJki0Q965bCiZGR+hnH1bKzL2Zf
diFJSXSZaoRGjxBff924nZsY95CA2JL51ieP6lG3yuGiIpg8/Hh2ogHOUs/0eR2q
5mGUMfjaSdbWndjG6mnkyS/3BKOH1uqSkg2LuZzIYEeRt2zWbgbpw1gxrWq6Xzsf
Zs9wLF/n5HUgq4yxw9U1ynxWZ2QcyL4lSGV6IBngnsOh7jxkPawWuBycW9k3OqME
pDxaqBor3AVOlHVNuWcwgkA+ljYUc7OZyxXyb8t0KWPGRFpzJvrwC+aZozYhI5Y4
dJCg5jJYunES4lJrjL/FgUWi5Yeqn9Ye+AWzuvMx/zS1Ne8UDyA8ZQOMY++xP0cG
Hib/6pZv6xF1zc7Ryxn4JkN1DbIcwh0DBKKTV3Ra3WoZfIfW+XrRhwQxQrOZTs9Y
pTGjYifkq+hBqCaqmStcLA4Lc3PWRLQ12aqiMP3Log/w1Bc+8zk=
=oiQm
-----END PGP SIGNATURE-----

--31YaXo8OCBXodDG2--
