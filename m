Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D31635A9
	for <v9fs@lists.linux.dev>; Fri, 10 May 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335909; cv=none; b=hnh8nFxoSjJIaP84Qi+jLjOxJPrMPPpLX1Hk8dOk2w/rBBc28pURk+MIGkE8h3ibAYIA7wZUc8DPvotDyKFXHQgDnn3A+P+2H4+TeGv2gceRmiym7zg/6vPKtBU58adhRwOLySjc1Tu9E9xwmNuaLxLQZX1mFRfLKWZW7ZskuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335909; c=relaxed/simple;
	bh=iCYHXbVKWUg7RKPjKoQ7KMNf66go+lSQRjBDDpXHjss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHON+pY1ow7qwMNTjwpoUHgSrgV05tNZsdFkxFjWQ+za/oCSZ+mhzRAZ1DmwcojhcRgC4BwPQDxso2u+d7kqe5CPL3O42ChqHyHto2TXOMFZOBZ0llESOTylo9fsF9EzKgzcbPbD5g2JSNYjwtx+HAisnaKRJrIJMNgl82v1jbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5NDw-0000Ni-VA; Fri, 10 May 2024 12:11:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5NDv-000cCT-MD; Fri, 10 May 2024 12:11:31 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s5NDv-0049yD-1s;
	Fri, 10 May 2024 12:11:31 +0200
Date: Fri, 10 May 2024 12:11:31 +0200
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
Message-ID: <Zj3y04btf16BGZAJ@pengutronix.de>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-2-722ed28b0ade@pengutronix.de>
 <c78c9e88-bd53-4ae5-8f78-d8b1c468a5cd@collabora.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1z2uXq6Dxh82l/0P"
Content-Disposition: inline
In-Reply-To: <c78c9e88-bd53-4ae5-8f78-d8b1c468a5cd@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--1z2uXq6Dxh82l/0P
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:25:47AM +0200, Andrzej Pietrasiewicz wrote:
>Hi Michael,
>
>W dniu 30.04.2024 o=A001:33, Michael Grzeschik pisze:
>>Add the new gadget function for 9pfs transport. This function is
>>defining an simple 9pfs transport interface that consists of one in and
>>one out endpoint. The endpoints transmit and receive the 9pfs protocol
>>payload when mounting a 9p filesystem over usb.
>>
>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>>---
>>v3 -> v4:
>>   - implemented conn_cancel
>
>I tried this scenario:
>
>1) run all the components and have 9pfs up and running
>2) stop the forwarder
>3) umount -f at the gadget side - this indeed succeeds now in v4
>4) start the forwarder again
>5) mount at the gadget side - this hangs.
>
>Did this scenario work for you?

I actually tested this exact scenario. So this is
suprising. I will try this again just to be sure
that I did send the latest version.

My latest testsetup included the dummy_hcd. Did you test on real hardware?


Michael

>>   - moved from mount_tag to device name like ffs does
>>   - renamed function_list to usb9pfs_instance
>>   - renamed usbg_function_list to usb9pfs_instance_list
>>   - renamed rx/tx_fill to queue_rx/tx
>>   - added use of retvals
>>   - added locking comment over usb9pfs_transmit
>>   - using if_else instead of two pathed switch calls
>>   - fixed return values of completion handler
>>   - using void pointer as parameter in rx_header
>>   - added a missed req_put in rx_header
>>   - removed extra disable function but call disable_ep directly
>>   - repaired several return values
>>   - remove the suspicious disable / enable path in usbg_create
>>v2 -> v3: -
>>v1 -> v2:
>>   - move the driver to net/9p/trans_usbg.c
>>   - fixed the commit title
>>   - fix %zu usage in p9_debug for size_t type
>>   - define functions static that are only used localy
>>   - return 0 in alloc_requests
>>   - use id_alloc_max instead of ida_simple_get
>>   - call ida_free in usb9pfs_free_func
>>   - call kfree for usb9pfs->tag and usb9pfs in usb9pfs_free_func
>>   - add MODULE_ALIAS_9P to load this module automatic when mounting
>>   - improved the documentation
>>   - added depends on USB_GADGET in Kconfig
>>---
>>  Documentation/filesystems/9p.rst |  17 +-
>>  net/9p/Kconfig                   |   6 +
>>  net/9p/Makefile                  |   4 +
>>  net/9p/trans_usbg.c              | 983 ++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 1009 insertions(+), 1 deletion(-)
>>
>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems=
/9p.rst
>>index 1e0e0bb6fdf91..10cf79dc287f8 100644
>>--- a/Documentation/filesystems/9p.rst
>>+++ b/Documentation/filesystems/9p.rst
>>@@ -48,11 +48,25 @@ For server running on QEMU host with virtio transport=
::
>>  	mount -t 9p -o trans=3Dvirtio <mount_tag> /mnt/9
>>-where mount_tag is the tag associated by the server to each of the expor=
ted
>>+where mount_tag is the tag generated by the server to each of the export=
ed
>>  mount points. Each 9P export is seen by the client as a virtio device w=
ith an
>>  associated "mount_tag" property. Available mount tags can be
>>  seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_ta=
g files.
>>+USBG Usage
>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>+
>>+To mount a 9p FS on a USB Host accessible via the gadget at runtime::
>>+
>>+	mount -t 9p -o trans=3Dusbg,aname=3D/path/to/fs <device> /mnt/9
>>+
>>+To mount a 9p FS on a USB Host accessible via the gadget as root filesys=
tem::
>>+
>>+	root=3D<device> rootfstype=3D9p rootflags=3Dtrans=3Dusbg,cache=3Dloose,=
uname=3Droot,access=3D0,dfltuid=3D0,dfltgid=3D0,aname=3D/path/to/rootfs
>>+
>>+where <device> is the tag associated by the usb gadget transport.
>>+It is defined by the configfs instance name.
>>+
>>  Options
>>  =3D=3D=3D=3D=3D=3D=3D
>>@@ -68,6 +82,7 @@ Options
>>  			virtio	  connect to the next virtio channel available
>>  				  (from QEMU with trans_virtio module)
>>  			rdma	  connect to a specified RDMA channel
>>+			usbg	  connect to a specified usb gadget channel
>>  			=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>    uname=3Dname	user name to attempt mount as on the remote server.  The
>>diff --git a/net/9p/Kconfig b/net/9p/Kconfig
>>index 00ebce9e5a657..c3d357eb8bb37 100644
>>--- a/net/9p/Kconfig
>>+++ b/net/9p/Kconfig
>>@@ -39,6 +39,12 @@ config NET_9P_XEN
>>  	  This builds support for a transport for 9pfs between
>>  	  two Xen domains.
>>+config NET_9P_USBG
>>+	bool "9P USB Gadget Transport"
>>+	depends on USB_GADGET
>>+	help
>>+	  This builds support for a transport for 9pfs over
>>+	  usb gadget.
>>  config NET_9P_RDMA
>>  	depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
>>diff --git a/net/9p/Makefile b/net/9p/Makefile
>>index 1df9b344c30bd..22794a451c3f7 100644
>>--- a/net/9p/Makefile
>>+++ b/net/9p/Makefile
>>@@ -4,6 +4,7 @@ obj-$(CONFIG_NET_9P_FD) +=3D 9pnet_fd.o
>>  obj-$(CONFIG_NET_9P_XEN) +=3D 9pnet_xen.o
>>  obj-$(CONFIG_NET_9P_VIRTIO) +=3D 9pnet_virtio.o
>>  obj-$(CONFIG_NET_9P_RDMA) +=3D 9pnet_rdma.o
>>+obj-$(CONFIG_NET_9P_USBG) +=3D 9pnet_usbg.o
>>  9pnet-objs :=3D \
>>  	mod.o \
>>@@ -23,3 +24,6 @@ obj-$(CONFIG_NET_9P_RDMA) +=3D 9pnet_rdma.o
>>  9pnet_rdma-objs :=3D \
>>  	trans_rdma.o \
>>+
>>+9pnet_usbg-objs :=3D \
>>+	trans_usbg.o \
>>diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
>>new file mode 100644
>>index 0000000000000..bc440033cbe68
>>--- /dev/null
>>+++ b/net/9p/trans_usbg.c
>>@@ -0,0 +1,983 @@
>>+// SPDX-License-Identifier: GPL-2.0+
>>+/*
>>+ * trans_usbg.c - USB peripheral usb9pfs configuration driver and transp=
ort.
>>+ *
>>+ * Copyright (C) 2024 Michael Grzeschik <m.grzeschik@pengutronix.de>
>>+ */
>>+
>>+/* Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs
>>+ * transport to mount host exported filesystem via usb gadget.
>>+ */
>>+
>>+/*     +--------------------------+    |    +--------------------------+
>>+ *     |  9PFS mounting client    |    |    |  9PFS exporting server   |
>>+ *  SW |                          |    |    |                          |
>>+ *     |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
>>+ *     +-------------^------------+    |    +-------------^------------+
>>+ *                   |                 |                  |
>>+ * ------------------|------------------------------------|-------------
>>+ *                   |                 |                  |
>>+ *     +-------------v------------+    |    +-------------v------------+
>>+ *     |                          |    |    |                          |
>>+ *  HW |   USB Device Controller  <--------->   USB Host Controller    |
>>+ *     |                          |    |    |                          |
>>+ *     +--------------------------+    |    +--------------------------+
>>+ */
>>+
>>+#include <linux/slab.h>
>>+#include <linux/kernel.h>
>>+#include <linux/device.h>
>>+#include <linux/module.h>
>>+#include <linux/err.h>
>>+#include <linux/usb/composite.h>
>>+#include <linux/usb/u_f.h>
>>+
>>+#include <net/9p/9p.h>
>>+#include <net/9p/client.h>
>>+#include <net/9p/transport.h>
>>+
>>+#define DEFAULT_BUFLEN        16384
>>+
>>+struct f_usb9pfs {
>>+	struct p9_client *client;
>>+
>>+	struct p9_req_t *p9_tx_req;
>>+
>>+	struct list_head tx_req_list;
>>+
>>+	/* 9p request lock for en/dequeue */
>>+	spinlock_t lock;
>>+	/* usb request lock for en/dequeue */
>>+	spinlock_t req_lock;
>>+
>>+	struct usb_request *in_req;
>>+	struct usb_request *out_req;
>>+
>>+	struct usb_ep *in_ep;
>>+	struct usb_ep *out_ep;
>>+
>>+	unsigned int buflen;
>>+
>>+	struct usb_function function;
>>+};
>>+
>>+static inline struct f_usb9pfs *func_to_usb9pfs(struct usb_function *f)
>>+{
>>+	return container_of(f, struct f_usb9pfs, function);
>>+}
>>+
>>+struct f_usb9pfs_opts {
>>+	struct usb_function_instance func_inst;
>>+	unsigned int buflen;
>>+
>>+	struct f_usb9pfs_dev *dev;
>>+
>>+	/* Read/write access to configfs attributes is handled by configfs.
>>+	 *
>>+	 * This is to protect the data from concurrent access by read/write
>>+	 * and create symlink/remove symlink.
>>+	 */
>>+	struct mutex lock;
>>+	int refcnt;
>>+};
>>+
>>+struct f_usb9pfs_dev {
>>+	struct f_usb9pfs *usb9pfs;
>>+	struct f_usb9pfs_opts *opts;
>>+	char tag[41];
>>+	bool inuse;
>>+
>>+	struct list_head usb9pfs_instance;
>>+};
>>+
>>+static DEFINE_MUTEX(usb9pfs_lock);
>>+static struct list_head usbg_instance_list;
>>+
>>+static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_reques=
t *req,
>>+			    gfp_t gfp_flags)
>>+{
>>+	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>>+	int ret =3D -ENOMEM;
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
>>+
>>+	ret =3D usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
>>+
>>+	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
>>+
>>+	return ret;
>>+}
>>+
>>+/* This needs to be called with usb9pfs->req_lock held */
>>+static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
>>+{
>>+	struct p9_req_t *p9_req =3D NULL;
>>+	unsigned long flags;
>>+	int ret =3D 0;
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+
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
>>+
>>+	usb9pfs->p9_tx_req =3D p9_req;
>>+
>>+	p9_req_get(usb9pfs->p9_tx_req);
>>+
>>+	ret =3D usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);
>>+
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
>>+		goto free_req;
>>+	}
>>+
>>+	/* reset zero packages */
>>+	req->zero =3D 0;
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+		ep->name, req->status, req->actual, req->length);
>>+
>>+	spin_lock(&usb9pfs->req_lock);
>>+
>>+	WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
>>+
>>+	p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
>>+
>>+	ret =3D usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
>>+	if (ret) {
>>+		spin_unlock(&usb9pfs->req_lock);
>>+		goto free_req;
>>+	}
>>+
>>+	spin_unlock(&usb9pfs->req_lock);
>>+
>>+	return;
>>+
>>+free_req:
>>+	usb_ep_free_request(ep =3D=3D usb9pfs->in_ep ?
>>+			    usb9pfs->out_ep : usb9pfs->in_ep,
>>+			    req->context);
>>+	free_ep_req(ep, req);
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
>>+	int ret =3D 0;
>>+
>>+	if (req->status) {
>>+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
>>+			ep->name, req->status, req->actual, req->length);
>>+		goto free_req;
>>+	}
>>+
>>+	spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>+
>>+	p9_rx_req =3D usb9pfs_rx_header(usb9pfs, req->buf);
>>+	if (!p9_rx_req) {
>>+		spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>+		goto free_req;
>>+	}
>>+
>>+	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
>>+
>>+	p9_rx_req->rc.size =3D req->actual;
>>+
>>+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
>>+	p9_req_put(usb9pfs->client, p9_rx_req);
>>+
>>+	usb9pfs->p9_tx_req =3D NULL;
>>+
>>+	ret =3D usb9pfs_transmit(usb9pfs);
>>+	if (ret) {
>>+		spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>+		return;
>>+	}
>>+
>>+	spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>+
>>+	return;
>>+
>>+free_req:
>>+	usb_ep_free_request(ep =3D=3D usb9pfs->in_ep ?
>>+			    usb9pfs->out_ep : usb9pfs->in_ep,
>>+			    req->context);
>>+	free_ep_req(ep, req);
>>+
>>+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_ERROR);
>>+}
>>+
>>+static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
>>+{
>>+	int value;
>>+
>>+	value =3D usb_ep_disable(ep);
>>+	if (value < 0)
>>+		dev_info(&cdev->gadget->dev,
>>+			 "disable %s --> %d\n", ep->name, value);
>>+}
>>+
>>+static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
>>+{
>>+	struct usb_composite_dev *cdev =3D
>>+		usb9pfs->function.config->cdev;
>>+
>>+	disable_ep(cdev, usb9pfs->in_ep);
>>+	disable_ep(cdev, usb9pfs->out_ep);
>>+	dev_dbg(&cdev->gadget->dev, "%s disabled\n",
>>+		usb9pfs->function.name);
>>+}
>>+
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
>>+}
>>+
>>+static int
>>+enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
>>+{
>>+	int result =3D 0;
>>+
>>+	result =3D enable_endpoint(cdev, usb9pfs, usb9pfs->in_ep);
>>+	if (result)
>>+		goto out;
>>+
>>+	result =3D enable_endpoint(cdev, usb9pfs, usb9pfs->out_ep);
>>+	if (result)
>>+		goto disable_in;
>>+
>>+	result =3D alloc_requests(cdev, usb9pfs);
>>+	if (result)
>>+		goto disable_out;
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s enabled\n", usb9pfs->function.name);
>>+	return 0;
>>+
>>+disable_out:
>>+	usb_ep_disable(usb9pfs->out_ep);
>>+disable_in:
>>+	usb_ep_disable(usb9pfs->in_ep);
>>+out:
>>+	return result;
>>+}
>>+
>>+static int p9_usbg_create(struct p9_client *client, const char *devname,=
 char *args)
>>+{
>>+	struct usb_composite_dev *cdev;
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
>>+	list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9pfs_instanc=
e) {
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
>>+	mutex_unlock(&usb9pfs_lock);
>>+
>>+	if (!found) {
>>+		pr_err("no channels available for device %s\n", devname);
>>+		return ret;
>>+	}
>>+
>>+	usb9pfs =3D dev->usb9pfs;
>>+	if (!usb9pfs)
>>+		return -EINVAL;
>>+
>>+	INIT_LIST_HEAD(&usb9pfs->tx_req_list);
>>+
>>+	spin_lock_init(&usb9pfs->lock);
>>+	spin_lock_init(&usb9pfs->req_lock);
>>+
>>+	f =3D &usb9pfs->function;
>>+	cdev =3D f->config->cdev;
>>+
>>+	client->trans =3D (void *)usb9pfs;
>>+	client->status =3D Connected;
>>+	usb9pfs->client =3D client;
>>+
>>+	client->trans_mod->maxsize =3D usb9pfs->buflen;
>>+
>>+	return enable_usb9pfs(cdev, usb9pfs);
>>+}
>>+
>>+static void p9_usbg_close(struct p9_client *client)
>>+{
>>+	struct f_usb9pfs *usb9pfs;
>>+	struct f_usb9pfs_dev *dev;
>>+	struct p9_req_t *req;
>>+	struct f_usb9pfs_opts *opts;
>>+
>>+	if (!client)
>>+		return;
>>+
>>+	usb9pfs =3D client->trans;
>>+	if (!usb9pfs)
>>+		return;
>>+
>>+	client->status =3D Disconnected;
>>+
>>+	spin_lock(&usb9pfs->req_lock);
>>+
>>+	req =3D usb9pfs->p9_tx_req;
>>+	if (req) {
>>+		if (!req->t_err)
>>+			req->t_err =3D -ECONNRESET;
>>+		p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
>>+	}
>>+
>>+	spin_unlock(&usb9pfs->req_lock);
>>+
>>+	disable_usb9pfs(usb9pfs);
>>+
>>+	opts =3D container_of(usb9pfs->function.fi,
>>+			    struct f_usb9pfs_opts, func_inst);
>>+
>>+	dev =3D opts->dev;
>>+
>>+	mutex_lock(&usb9pfs_lock);
>>+	dev->inuse =3D false;
>>+	mutex_unlock(&usb9pfs_lock);
>>+}
>>+
>>+static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9=
_req)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D client->trans;
>>+	unsigned long flags;
>>+
>>+	if (client->status !=3D Connected)
>>+		return -EBUSY;
>>+
>>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>>+	list_add_tail(&p9_req->req_list, &usb9pfs->tx_req_list);
>>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>+
>>+	spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>+	usb9pfs_transmit(usb9pfs);
>>+	spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>+
>>+	return 0;
>>+}
>>+
>>+static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D client->trans;
>>+	int ret =3D 1;
>>+
>>+	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
>>+
>>+	spin_lock(&usb9pfs->req_lock);
>>+
>>+	if (req->status =3D=3D REQ_STATUS_UNSENT) {
>>+		list_del(&req->req_list);
>>+		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
>>+		p9_req_put(client, req);
>>+		ret =3D 0;
>>+	}
>>+	spin_unlock(&usb9pfs->req_lock);
>>+
>>+	return ret;
>>+}
>>+
>>+static struct p9_trans_module p9_usbg_trans =3D {
>>+	.name =3D "usbg",
>>+	.create =3D p9_usbg_create,
>>+	.close =3D p9_usbg_close,
>>+	.request =3D p9_usbg_request,
>>+	.cancel =3D p9_usbg_cancel,
>>+	.owner =3D THIS_MODULE,
>>+};
>>+
>>+/*----------------------------------------------------------------------=
---*/
>>+
>>+#define USB_PROTOCOL_9PFS	0x09
>>+
>>+static struct usb_interface_descriptor usb9pfs_intf =3D {
>>+	.bLength =3D		sizeof(usb9pfs_intf),
>>+	.bDescriptorType =3D	USB_DT_INTERFACE,
>>+
>>+	.bNumEndpoints =3D	2,
>>+	.bInterfaceClass =3D	USB_CLASS_VENDOR_SPEC,
>>+	.bInterfaceSubClass =3D	USB_SUBCLASS_VENDOR_SPEC,
>>+	.bInterfaceProtocol =3D   USB_PROTOCOL_9PFS,
>>+
>>+	/* .iInterface =3D DYNAMIC */
>>+};
>>+
>>+/* full speed support: */
>>+
>>+static struct usb_endpoint_descriptor fs_usb9pfs_source_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bEndpointAddress =3D	USB_DIR_IN,
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+};
>>+
>>+static struct usb_endpoint_descriptor fs_usb9pfs_sink_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bEndpointAddress =3D	USB_DIR_OUT,
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+};
>>+
>>+static struct usb_descriptor_header *fs_usb9pfs_descs[] =3D {
>>+	(struct usb_descriptor_header *)&usb9pfs_intf,
>>+	(struct usb_descriptor_header *)&fs_usb9pfs_sink_desc,
>>+	(struct usb_descriptor_header *)&fs_usb9pfs_source_desc,
>>+	NULL,
>>+};
>>+
>>+/* high speed support: */
>>+
>>+static struct usb_endpoint_descriptor hs_usb9pfs_source_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+	.wMaxPacketSize =3D	cpu_to_le16(512),
>>+};
>>+
>>+static struct usb_endpoint_descriptor hs_usb9pfs_sink_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+	.wMaxPacketSize =3D	cpu_to_le16(512),
>>+};
>>+
>>+static struct usb_descriptor_header *hs_usb9pfs_descs[] =3D {
>>+	(struct usb_descriptor_header *)&usb9pfs_intf,
>>+	(struct usb_descriptor_header *)&hs_usb9pfs_source_desc,
>>+	(struct usb_descriptor_header *)&hs_usb9pfs_sink_desc,
>>+	NULL,
>>+};
>>+
>>+/* super speed support: */
>>+
>>+static struct usb_endpoint_descriptor ss_usb9pfs_source_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+	.wMaxPacketSize =3D	cpu_to_le16(1024),
>>+};
>>+
>>+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_source_comp_desc =3D {
>>+	.bLength =3D		USB_DT_SS_EP_COMP_SIZE,
>>+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
>>+	.bMaxBurst =3D		0,
>>+	.bmAttributes =3D		0,
>>+	.wBytesPerInterval =3D	0,
>>+};
>>+
>>+static struct usb_endpoint_descriptor ss_usb9pfs_sink_desc =3D {
>>+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
>>+	.bDescriptorType =3D	USB_DT_ENDPOINT,
>>+
>>+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
>>+	.wMaxPacketSize =3D	cpu_to_le16(1024),
>>+};
>>+
>>+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_sink_comp_desc =3D {
>>+	.bLength =3D		USB_DT_SS_EP_COMP_SIZE,
>>+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
>>+	.bMaxBurst =3D		0,
>>+	.bmAttributes =3D		0,
>>+	.wBytesPerInterval =3D	0,
>>+};
>>+
>>+static struct usb_descriptor_header *ss_usb9pfs_descs[] =3D {
>>+	(struct usb_descriptor_header *)&usb9pfs_intf,
>>+	(struct usb_descriptor_header *)&ss_usb9pfs_source_desc,
>>+	(struct usb_descriptor_header *)&ss_usb9pfs_source_comp_desc,
>>+	(struct usb_descriptor_header *)&ss_usb9pfs_sink_desc,
>>+	(struct usb_descriptor_header *)&ss_usb9pfs_sink_comp_desc,
>>+	NULL,
>>+};
>>+
>>+/* function-specific strings: */
>>+static struct usb_string strings_usb9pfs[] =3D {
>>+	[0].s =3D "usb9pfs input to output",
>>+	{  }			/* end of list */
>>+};
>>+
>>+static struct usb_gadget_strings stringtab_usb9pfs =3D {
>>+	.language	=3D 0x0409,	/* en-us */
>>+	.strings	=3D strings_usb9pfs,
>>+};
>>+
>>+static struct usb_gadget_strings *usb9pfs_strings[] =3D {
>>+	&stringtab_usb9pfs,
>>+	NULL,
>>+};
>>+
>>+/*----------------------------------------------------------------------=
---*/
>>+
>>+static int usb9pfs_func_bind(struct usb_configuration *c,
>>+			     struct usb_function *f)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>+	struct f_usb9pfs_opts *opts;
>>+	struct usb_composite_dev *cdev =3D c->cdev;
>>+	int ret;
>>+	int id;
>>+
>>+	/* allocate interface ID(s) */
>>+	id =3D usb_interface_id(c, f);
>>+	if (id < 0)
>>+		return id;
>>+	usb9pfs_intf.bInterfaceNumber =3D id;
>>+
>>+	id =3D usb_string_id(cdev);
>>+	if (id < 0)
>>+		return id;
>>+	strings_usb9pfs[0].id =3D id;
>>+	usb9pfs_intf.iInterface =3D id;
>>+
>>+	/* allocate endpoints */
>>+	usb9pfs->in_ep =3D usb_ep_autoconfig(cdev->gadget,
>>+					   &fs_usb9pfs_source_desc);
>>+	if (!usb9pfs->in_ep)
>>+		goto autoconf_fail;
>>+
>>+	usb9pfs->out_ep =3D usb_ep_autoconfig(cdev->gadget,
>>+					    &fs_usb9pfs_sink_desc);
>>+	if (!usb9pfs->out_ep)
>>+		goto autoconf_fail;
>>+
>>+	/* support high speed hardware */
>>+	hs_usb9pfs_source_desc.bEndpointAddress =3D
>>+		fs_usb9pfs_source_desc.bEndpointAddress;
>>+	hs_usb9pfs_sink_desc.bEndpointAddress =3D
>>+		fs_usb9pfs_sink_desc.bEndpointAddress;
>>+
>>+	/* support super speed hardware */
>>+	ss_usb9pfs_source_desc.bEndpointAddress =3D
>>+		fs_usb9pfs_source_desc.bEndpointAddress;
>>+	ss_usb9pfs_sink_desc.bEndpointAddress =3D
>>+		fs_usb9pfs_sink_desc.bEndpointAddress;
>>+
>>+	ret =3D usb_assign_descriptors(f, fs_usb9pfs_descs, hs_usb9pfs_descs,
>>+				     ss_usb9pfs_descs, ss_usb9pfs_descs);
>>+	if (ret)
>>+		return ret;
>>+
>>+	opts =3D container_of(f->fi, struct f_usb9pfs_opts, func_inst);
>>+	opts->dev->usb9pfs =3D usb9pfs;
>>+
>>+	dev_dbg(&cdev->gadget->dev, "%s speed %s: IN/%s, OUT/%s\n",
>>+		(gadget_is_superspeed(c->cdev->gadget) ? "super" :
>>+		(gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full")),
>>+			f->name, usb9pfs->in_ep->name, usb9pfs->out_ep->name);
>>+
>>+	return 0;
>>+
>>+autoconf_fail:
>>+	ERROR(cdev, "%s: can't autoconfigure on %s\n",
>>+	      f->name, cdev->gadget->name);
>>+	return -ENODEV;
>>+}
>>+
>>+static void usb9pfs_free_func(struct usb_function *f)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>+	struct f_usb9pfs_opts *opts;
>>+
>>+	kfree(usb9pfs);
>>+
>>+	opts =3D container_of(f->fi, struct f_usb9pfs_opts, func_inst);
>>+
>>+	mutex_lock(&opts->lock);
>>+	opts->refcnt--;
>>+	mutex_unlock(&opts->lock);
>>+
>>+	usb_free_all_descriptors(f);
>>+}
>>+
>>+static int usb9pfs_set_alt(struct usb_function *f,
>>+			   unsigned int intf, unsigned int alt)
>>+{
>>+	return 0;
>>+}
>>+
>>+static void usb9pfs_disable(struct usb_function *f)
>>+{
>>+	struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>+	struct p9_req_t *req;
>>+
>>+	spin_lock(&usb9pfs->req_lock);
>>+
>>+	req =3D usb9pfs->p9_tx_req;
>>+
>>+	if (!req->t_err)
>>+		req->t_err =3D -ECONNRESET;
>>+	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
>>+
>>+	spin_unlock(&usb9pfs->req_lock);
>>+}
>>+
>>+static struct usb_function *usb9pfs_alloc(struct usb_function_instance *=
fi)
>>+{
>>+	struct f_usb9pfs_opts *usb9pfs_opts;
>>+	struct f_usb9pfs *usb9pfs;
>>+
>>+	usb9pfs =3D kzalloc(sizeof(*usb9pfs), GFP_KERNEL);
>>+	if (!usb9pfs)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	usb9pfs_opts =3D container_of(fi, struct f_usb9pfs_opts, func_inst);
>>+
>>+	mutex_lock(&usb9pfs_opts->lock);
>>+	usb9pfs_opts->refcnt++;
>>+	mutex_unlock(&usb9pfs_opts->lock);
>>+
>>+	usb9pfs->buflen =3D usb9pfs_opts->buflen;
>>+
>>+	usb9pfs->function.name =3D "usb9pfs";
>>+	usb9pfs->function.bind =3D usb9pfs_func_bind;
>>+	usb9pfs->function.set_alt =3D usb9pfs_set_alt;
>>+	usb9pfs->function.disable =3D usb9pfs_disable;
>>+	usb9pfs->function.strings =3D usb9pfs_strings;
>>+
>>+	usb9pfs->function.free_func =3D usb9pfs_free_func;
>>+
>>+	return &usb9pfs->function;
>>+}
>>+
>>+static inline struct f_usb9pfs_opts *to_f_usb9pfs_opts(struct config_ite=
m *item)
>>+{
>>+	return container_of(to_config_group(item), struct f_usb9pfs_opts,
>>+			    func_inst.group);
>>+}
>>+
>>+static inline struct f_usb9pfs_opts *fi_to_f_usb9pfs_opts(struct usb_fun=
ction_instance *fi)
>>+{
>>+	return container_of(fi, struct f_usb9pfs_opts, func_inst);
>>+}
>>+
>>+static void usb9pfs_attr_release(struct config_item *item)
>>+{
>>+	struct f_usb9pfs_opts *usb9pfs_opts =3D to_f_usb9pfs_opts(item);
>>+
>>+	usb_put_function_instance(&usb9pfs_opts->func_inst);
>>+}
>>+
>>+static struct configfs_item_operations usb9pfs_item_ops =3D {
>>+	.release		=3D usb9pfs_attr_release,
>>+};
>>+
>>+static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, char=
 *page)
>>+{
>>+	struct f_usb9pfs_opts *opts =3D to_f_usb9pfs_opts(item);
>>+	int result;
>>+
>>+	mutex_lock(&opts->lock);
>>+	result =3D sprintf(page, "%d\n", opts->buflen);
>>+	mutex_unlock(&opts->lock);
>>+
>>+	return result;
>>+}
>>+
>>+static ssize_t f_usb9pfs_opts_buflen_store(struct config_item *item,
>>+					   const char *page, size_t len)
>>+{
>>+	struct f_usb9pfs_opts *opts =3D to_f_usb9pfs_opts(item);
>>+	int ret;
>>+	u32 num;
>>+
>>+	mutex_lock(&opts->lock);
>>+	if (opts->refcnt) {
>>+		ret =3D -EBUSY;
>>+		goto end;
>>+	}
>>+
>>+	ret =3D kstrtou32(page, 0, &num);
>>+	if (ret)
>>+		goto end;
>>+
>>+	opts->buflen =3D num;
>>+	ret =3D len;
>>+end:
>>+	mutex_unlock(&opts->lock);
>>+	return ret;
>>+}
>>+
>>+CONFIGFS_ATTR(f_usb9pfs_opts_, buflen);
>>+
>>+static struct configfs_attribute *usb9pfs_attrs[] =3D {
>>+	&f_usb9pfs_opts_attr_buflen,
>>+	NULL,
>>+};
>>+
>>+static const struct config_item_type usb9pfs_func_type =3D {
>>+	.ct_item_ops	=3D &usb9pfs_item_ops,
>>+	.ct_attrs	=3D usb9pfs_attrs,
>>+	.ct_owner	=3D THIS_MODULE,
>>+};
>>+
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
>>+		if (strcmp(usb9pfs_dev->tag, tag) =3D=3D 0)
>>+			return usb9pfs_dev;
>>+	}
>>+
>>+	return NULL;
>>+}
>>+
>>+static int usb9pfs_tag_instance(struct f_usb9pfs_dev *dev, const char *t=
ag)
>>+{
>>+	struct f_usb9pfs_dev *existing;
>>+	int ret =3D 0;
>>+
>>+	mutex_lock(&usb9pfs_lock);
>>+	existing =3D _usb9pfs_do_find_dev(tag);
>>+	if (!existing)
>>+		strscpy(dev->tag, tag, ARRAY_SIZE(dev->tag));
>>+	else if (existing !=3D dev)
>>+		ret =3D -EBUSY;
>>+	mutex_unlock(&usb9pfs_lock);
>>+
>>+	return ret;
>>+}
>>+
>>+static int usb9pfs_set_inst_tag(struct usb_function_instance *fi, const =
char *tag)
>>+{
>>+	if (strlen(tag) >=3D sizeof_field(struct f_usb9pfs_dev, tag))
>>+		return -ENAMETOOLONG;
>>+	return usb9pfs_tag_instance(fi_to_f_usb9pfs_opts(fi)->dev, tag);
>>+}
>>+
>>+static void usb9pfs_free_instance(struct usb_function_instance *fi)
>>+{
>>+	struct f_usb9pfs_opts *usb9pfs_opts;
>>+
>>+	usb9pfs_opts =3D container_of(fi, struct f_usb9pfs_opts, func_inst);
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
>>+
>>+	config_group_init_type_name(&usb9pfs_opts->func_inst.group, "",
>>+				    &usb9pfs_func_type);
>>+
>>+	return &usb9pfs_opts->func_inst;
>>+}
>>+DECLARE_USB_FUNCTION(usb9pfs, usb9pfs_alloc_instance, usb9pfs_alloc);
>>+
>>+static int __init usb9pfs_modinit(void)
>>+{
>>+	int ret;
>>+
>>+	INIT_LIST_HEAD(&usbg_instance_list);
>>+
>>+	ret =3D usb_function_register(&usb9pfsusb_func);
>>+	if (!ret)
>>+		v9fs_register_trans(&p9_usbg_trans);
>>+
>>+	return ret;
>>+}
>>+
>>+static void __exit usb9pfs_modexit(void)
>>+{
>>+	usb_function_unregister(&usb9pfsusb_func);
>>+	v9fs_unregister_trans(&p9_usbg_trans);
>>+}
>>+
>>+module_init(usb9pfs_modinit);
>>+module_exit(usb9pfs_modexit);
>>+
>>+MODULE_ALIAS_9P("usbg");
>>+MODULE_LICENSE("GPL");
>>+MODULE_DESCRIPTION("USB gadget 9pfs transport");
>>+MODULE_AUTHOR("Michael Grzeschik");
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--1z2uXq6Dxh82l/0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY98tAACgkQC+njFXoe
LGTCNA/9EOsQr8xLXQ7SqMlHY0xSytxgaMRl4Sk0xMX1bMABr3O5OhjQeME65Ckh
GQcTmulYXr2SyTlol0+cwNyyXVxsg58vAv0cXdjkAN/P7u56HjW2Eb+kTMrJa2xO
2FnS4YiREEFRQrrdzLM6e59/oZwzo5xeT2Y49RUHH3lRuUwViuXUSmm4QK03MCE2
ydyWukzcK3nIiwWXCfNLMLalm+LqgQ8gfJZplhwiraasIBL7WOCVDOMjtgof0GE6
zOZNFiHqzB/pz0Eut8J7dGn0mCilQf2Pq6ueQyQ+CTMROR5sgEx099SbNCyEDEkz
+77G4JolXLBh4ru+Dmc+WhI8VCAcBupSIOpcgVaWkYGAoT4fP+hGWGdA0SZb7Q1n
MsgdDYWxm6Os3rm5jDDp4eVWFt4xk/vnk+IaQ0B/WHq4CWwcLNU+SJi0PVfx+h5g
VgaE5FfnWQ/CqqoJcPa+zSXZVHMt5XwB9TAzkXOtyuy/ufZnGu8HC/O3+txhtNIv
DnOgBX09ens87OvJyNWIF6pA4oDk3etoKhViTA/ej4hFNCedJPZbIrPpNcEFsIaF
jSo++OSDDMYH4AT+4rOPSYJ+CfQYFDeWhEEfp96panJ8xovhpGBJMRJVjfE/o1zb
TtKSYBRMs8GNlY8EppQMYN1X29L6xVgKgjfrccpGe7U6ZVbXuSU=
=1gWi
-----END PGP SIGNATURE-----

--1z2uXq6Dxh82l/0P--
