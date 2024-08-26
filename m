Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882219D88E
	for <v9fs@lists.linux.dev>; Mon, 26 Aug 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708960; cv=none; b=JBNL+jppurPlBLBxK0HLHARv4qJlxKlcDKd8Fo1Toe1Mqogbl1O756KyTfGADKnUq97lYLhUHrfhUpSfjU15TARLH3aY9v2t4GHFPDzY2bwpu8h5iAEyGHkKxOnBc16BIGu2ArLA6+A70lwuQRzfr2PAbCoD1xB793ewC5dsyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708960; c=relaxed/simple;
	bh=7FRZdrTBAJxGbrev3kbxN9txdjRT1IBa9NHDOYCUlow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWGY3Ob9RyRKw5XVZGsSBKxK0OJi2eIeTaYXL1P6qBafNoA1QaMhx0d+e7k/8IQqU0sUQci1KnXlrxSbIJhbFSSojXvvAw9hX9SM6yuhVzTmovVFOYseCxVz3VHptOjqUQrJU5bGve2yL0CAK56vdojt5TrmVBydF5U3fDrsEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihaD-0000Jb-Cb; Mon, 26 Aug 2024 23:49:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihaC-003HKU-Q6; Mon, 26 Aug 2024 23:49:04 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sihaC-007Bxv-2F;
	Mon, 26 Aug 2024 23:49:04 +0200
Date: Mon, 26 Aug 2024 23:49:04 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrzej.p@collabora.com, asmadeus@codewreck.org, corbet@lwn.net,
	ericvh@kernel.org, gregkh@linuxfoundation.org,
	kernel@pengutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, v9fs@lists.linux.dev
Subject: Re: [PATCH v9 2/3] net/9p/usbg: Add new usb gadget function transport
Message-ID: <Zsz4UKIOf5li0bb0@pengutronix.de>
References: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
 <20240116-ml-topic-u9p-v9-2-93d73f47b76b@pengutronix.de>
 <645bd24f-b86e-4cc1-b65f-7b48d81e633e@wanadoo.fr>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPnHP9l0rAOi/RZz"
Content-Disposition: inline
In-Reply-To: <645bd24f-b86e-4cc1-b65f-7b48d81e633e@wanadoo.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--GPnHP9l0rAOi/RZz
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the review!

I just send out v10 with your suggestions:

https://lore.kernel.org/all/20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengut=
ronix.de/

On Fri, Aug 23, 2024 at 11:45:23AM +0200, Christophe JAILLET wrote:
>Le 23/08/2024 =E0 09:36, Michael Grzeschik a =E9crit=A0:
>>Add the new gadget function for 9pfs transport. This function is
>>defining an simple 9pfs transport interface that consists of one in and
>>one out endpoint. The endpoints transmit and receive the 9pfs protocol
>>payload when mounting a 9p filesystem over usb.
>>
>>Tested-by: Andrzej Pietrasiewicz <andrzej.p-ZGY8ohtN/8qB+jHODAdFcQ@public=
=2Egmane.org>
>>Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@publ=
ic.gmane.org>
>>
>>---
>
>Hi,
>
>a few nitpicks below and 1 or 2 real questions.
>
>>+#include <linux/slab.h>
>>+#include <linux/kernel.h>
>>+#include <linux/device.h>
>>+#include <linux/module.h>
>>+#include <linux/err.h>
>>+#include <linux/usb/composite.h>
>>+#include <linux/usb/func_utils.h>
>>+#include <linux/completion.h>
>
>Keep it in alphabetic order?
>

Did that!

>>+
>>+#include <net/9p/9p.h>
>>+#include <net/9p/client.h>
>>+#include <net/9p/transport.h>
>>+
>
>...
>
>>+static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *r=
eq)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	struct p9_req_t *p9_tx_req =3D req->context;
>>+	unsigned long flags;
>>+
>>+	/* reset zero packages */
>>+	req->zero =3D 0;
>>+
>>+	if (req->status) {
>>+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+			ep->name, req->status, req->actual, req->length);
>>+		return;
>>+	}
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+		ep->name, req->status, req->actual, req->length);
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
>>+
>>+	p9_req_put(usb9pfs->client, p9_tx_req);
>>+
>>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+
>>+	complete(&usb9pfs->send);
>>+
>>+	return;
>
>Is it needed?

Nope, gone!

>>+}
>
>...
>
>>+static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *r=
eq)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	struct p9_req_t *p9_rx_req;
>>+
>>+	if (req->status) {
>>+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+			ep->name, req->status, req->actual, req->length);
>>+		return;
>>+	}
>>+
>>+	p9_rx_req =3D usb9pfs_rx_header(usb9pfs, req->buf);
>>+	if (!p9_rx_req) {
>>+		return;
>>+	}
>
>The { } could be removd.

Done!

>>+
>>+	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
>>+
>>+	p9_rx_req->rc.size =3D req->actual;
>>+
>>+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
>>+	p9_req_put(usb9pfs->client, p9_rx_req);
>>+
>>+	complete(&usb9pfs->received);
>>+
>>+	return;
>
>Is it needed?

No.

>>+}
>
>...
>
>>+static int alloc_requests(struct usb_composite_dev *cdev,
>>+			  struct f_usb9pfs *usb9pfs)
>>+{
>>+	int ret =3D 0;
>>+
>>+	usb9pfs->in_req =3D usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
>>+	if (!usb9pfs->in_req) {
>>+		ret =3D -ENOENT;
>>+		goto fail;
>>+	}
>>+
>>+	usb9pfs->out_req =3D alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
>>+	if (!usb9pfs->out_req) {
>>+		ret =3D -ENOENT;
>>+		goto fail_in;
>>+	}
>>+
>>+	usb9pfs->in_req->complete =3D usb9pfs_tx_complete;
>>+	usb9pfs->out_req->complete =3D usb9pfs_rx_complete;
>>+
>>+	/* length will be set in complete routine */
>>+	usb9pfs->in_req->context =3D usb9pfs;
>>+	usb9pfs->out_req->context =3D usb9pfs;
>>+
>>+	return ret;
>
>return 0; to be more explicit?
>(and would avoid the =3D 0 when declared)

Good point. Did that.

>>+
>>+fail_in:
>>+	usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
>>+fail:
>>+	return ret;
>>+}
>>+
>>+static int enable_endpoint(struct usb_composite_dev *cdev,
>>+			   struct f_usb9pfs *usb9pfs, struct usb_ep *ep)
>>+{
>>+	int ret;
>>+
>>+	ret =3D config_ep_by_speed(cdev->gadget, &usb9pfs->function, ep);
>>+	if (ret)
>>+		return ret;
>>+
>>+	ret =3D usb_ep_enable(ep);
>>+	if (ret < 0)
>>+		return ret;
>>+
>>+	ep->driver_data =3D usb9pfs;
>>+
>>+	return ret;
>
>return 0; to be more explicit?

Agreed!

>>+}
>
>...
>
>>+static int p9_usbg_create(struct p9_client *client, const char *devname,=
 char *args)
>>+{
>>+	struct f_usb9pfs_dev *dev;
>>+	struct f_usb9pfs_dev *tmp;
>>+	struct f_usb9pfs *usb9pfs;
>>+	struct usb_function *f;
>>+	int ret =3D -ENOENT;
>>+	int found =3D 0;
>>+
>>+	if (!devname)
>>+		return -EINVAL;
>>+
>>+	mutex_lock(&usb9pfs_lock);
>
>Using cleanup.h would simplify locking in early exit paths.

Whoo, cleanup.h is a peace of art. I totally forgot about that.

I also addressed the the spinlocks which seemed obvious.

>>+	list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9pfs_instanc=
e) {
>
>Why the _safe version is used here?
>The list is not modify here directly.

No need. I used the non safe version instead.

>>+		if (!strncmp(devname, dev->tag, strlen(devname))) {
>>+			if (!dev->inuse) {
>>+				dev->inuse =3D true;
>>+				found =3D 1;
>>+				break;
>>+			}
>>+			ret =3D -EBUSY;
>>+			break;
>>+		}
>>+	}
>>+
>>+	if (!found) {
>>+		mutex_unlock(&usb9pfs_lock);
>>+		pr_err("no channels available for device %s\n", devname);
>>+		return ret;
>>+	}
>>+
>>+	usb9pfs =3D dev->usb9pfs;
>>+	if (!usb9pfs) {
>>+		mutex_unlock(&usb9pfs_lock);
>>+		return -EINVAL;
>>+	}
>>+
>>+	f =3D &usb9pfs->function;
>>+
>>+	client->trans =3D (void *)usb9pfs;
>>+	if (!usb9pfs->in_req)
>>+		client->status =3D Disconnected;
>>+	else
>>+		client->status =3D Connected;
>>+	usb9pfs->client =3D client;
>>+
>>+	client->trans_mod->maxsize =3D usb9pfs->buflen;
>>+
>>+	complete(&usb9pfs->received);
>>+	mutex_unlock(&usb9pfs_lock);
>>+
>>+	return 0;
>>+}
>
>...
>
>>+static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, char=
 *page)
>>+{
>>+	struct f_usb9pfs_opts *opts =3D to_f_usb9pfs_opts(item);
>>+	int ret;
>>+
>>+	mutex_lock(&opts->lock);
>>+	ret =3D sprintf(page, "%d\n", opts->buflen);
>
>sysfs_emit()?
>

Good point!

>>+	mutex_unlock(&opts->lock);
>>+
>>+	return ret;
>>+}
>
>...
>
>>+static struct f_usb9pfs_dev *_usb9pfs_do_find_dev(const char *tag)
>>+{
>>+	struct f_usb9pfs_dev *usb9pfs_dev;
>>+	struct f_usb9pfs_dev *tmp;
>>+
>>+	if (!tag)
>>+		return NULL;
>>+
>>+	list_for_each_entry_safe(usb9pfs_dev, tmp, &usbg_instance_list, usb9pfs=
_instance) {
>
>Why the _safe version is used here?
>The list is not modify here directly.

No need for _safe. I switched back to the generic version.

>>+		if (strcmp(usb9pfs_dev->tag, tag) =3D=3D 0)
>>+			return usb9pfs_dev;
>>+	}
>>+
>>+	return NULL;
>>+}
>
>...
>
>>+static void usb9pfs_free_instance(struct usb_function_instance *fi)
>>+{
>>+	struct f_usb9pfs_opts *usb9pfs_opts =3D
>>+		container_of(fi, struct f_usb9pfs_opts, func_inst);
>>+	struct f_usb9pfs_dev *dev =3D usb9pfs_opts->dev;
>>+
>>+	list_del(&dev->usb9pfs_instance);
>
>When it is added in the usbg_instance_list list below, it is protected=20
>by the usb9pfs_lock mutex. Should it be also protected when it is=20
>removed?
>

Using the mutex here is valid.

>>+	kfree(usb9pfs_opts);
>>+}
>>+
>>+static struct usb_function_instance *usb9pfs_alloc_instance(void)
>>+{
>>+	struct f_usb9pfs_opts *usb9pfs_opts;
>>+	struct f_usb9pfs_dev *dev;
>>+
>>+	usb9pfs_opts =3D kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
>>+	if (!usb9pfs_opts)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	mutex_init(&usb9pfs_opts->lock);
>>+
>>+	usb9pfs_opts->func_inst.set_inst_name =3D usb9pfs_set_inst_tag;
>>+	usb9pfs_opts->func_inst.free_func_inst =3D usb9pfs_free_instance;
>>+
>>+	usb9pfs_opts->buflen =3D DEFAULT_BUFLEN;
>>+
>>+	mutex_lock(&usb9pfs_lock);
>>+	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>
>If kzalloc() was called outside of the mutex, it would be slightly=20
>simpler, IMHO.

Totally. I do the alloc and ..
>
>>+	if (IS_ERR(dev)) {
>>+		mutex_unlock(&usb9pfs_lock);
>>+		kfree(usb9pfs_opts);
>>+		return ERR_CAST(dev);
>>+	}
>>+	list_add_tail(&dev->usb9pfs_instance, &usbg_instance_list);
>>+	mutex_unlock(&usb9pfs_lock);
>>+
>>+	usb9pfs_opts->dev =3D dev;
>>+	dev->opts =3D usb9pfs_opts;
>
>'dev' is added to the usbg_instance_list list within a mutex section,=20
>so it looks possible that this list is also accessed from somewhere=20
>else.
>
>Would it make sense to initialize dev->opts also within the mutex=20
>section, to avoid concurrent access to this new item, when dev->opts=20
>is still NULL?

=2E. the allocation all before even adding the prepared instance to the
list. This should make it safe. I actually moved the list alternation
to be the last operation in this function.

>>+
>>+	config_group_init_type_name(&usb9pfs_opts->func_inst.group, "",
>>+				    &usb9pfs_func_type);
>>+
>>+	return &usb9pfs_opts->func_inst;
>>+}
>
>...
>
>CJ
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--GPnHP9l0rAOi/RZz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmbM+EkACgkQC+njFXoe
LGSgpRAAhrCulzEsujQVmu2etzCkEOSRWic7JNK8FPPIvYri3ZDUl6tkFPSfkFel
5H85lrUd2u5uoCbaKK51w+qpYGmVl/4N4eFViOAO9Yp/i9c1Hk2m5/2H1U9jMeJt
2WBqHYP89b14FUbOFP0JKoZxBM/KrPIUq4qfGUEISrwb7wIgwGi2sjyWFQDnPLsO
Rm+k2Q6cD5tjLBP6qaakV6T9WVJe6OBnGAKnQ7arqHKRkm6bx6dbtLCTS6dVvWBh
MrjhRFAZsfwsGM/9iLClrcnzl1HG2CieADrgWjBu4dRqteGfTdP8Hly8Bo1pRKa3
3vdwwkfka0Zy7mSnRk6H3dWnHUkMmpjy0liTianuhv2eB/k7sOlOhRZXlDMX2Pwl
mkYZUWRtv/slWBfk0EoOu7TKxRBNDotNXRSxnmG/ze8hpF9Y9l4O4A2Mf7lDb+b7
xgcJtw1kTkH4syGxNgsAQWOZvO0rPC+4pnjohL015ugP1o5yWgvsuerNthnbu5qS
q+6lkXDpq5SGTtXpVyA02mkchVoG1pII/6mGDLC2A9254Yc7E6Fn6amHYqblWb50
xS9MuX4yo7Ce6PB6HWItTue5Df/Ik520LKOyZcWtWRSaUEorYa8N5HXAm5Atl8GC
Az8QXRQ4s1nEHVAyrwDYI159qP7xD21xjeUvu6RsQnkw8g/4D2Q=
=llQ8
-----END PGP SIGNATURE-----

--GPnHP9l0rAOi/RZz--
