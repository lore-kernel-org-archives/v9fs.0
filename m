Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5650284
	for <v9fs@lists.linux.dev>; Tue, 28 May 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873719; cv=none; b=PlbnOZS3o3A8vG+nYXJ8WyDlc3IBBmScSJogU/fSHtLi8dt595EtCWHi1SuKecUw4HG0k/P97xO/Jni4w6agKWevKvIbzbOl1cX9WB4TZJ4nXKJKiYCN5IIRonCH/qoaNFnrp6rYoGSjHpQBWoKVfSY/JvDo97nKsir5QQY8Hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873719; c=relaxed/simple;
	bh=fiD33xhC/rCQwvTNf4StFg1z1yS/raQA//+cyqgObCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+k8sj4m+zhMfCRbxsY3UeC/4zIfyIClhXuqC7CK2RbLkYThHtZhryMfdcLDKxvWgQAt/7ZXJMi24n0O/Ybs2jt6TDFLG91bOTKktJWwRcEn05V0sD1YpG2Np7kSltVDArAy8RtMsVdSz24Q5peRa9cJ8o5Ri1rPlN7LjhqA7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpHP-0005Rd-Ka; Tue, 28 May 2024 07:21:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpHP-003Hdr-4h; Tue, 28 May 2024 07:21:47 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpHP-001G4x-0A;
	Tue, 28 May 2024 07:21:47 +0200
Date: Tue, 28 May 2024 07:21:47 +0200
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
Message-ID: <ZlVp643uEIy2Ikbb@pengutronix.de>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-2-722ed28b0ade@pengutronix.de>
 <c78c9e88-bd53-4ae5-8f78-d8b1c468a5cd@collabora.com>
 <Zj3y04btf16BGZAJ@pengutronix.de>
 <2f36e766-054c-4001-addf-fe388916d858@collabora.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CXYm3VvaaUbdovYY"
Content-Disposition: inline
In-Reply-To: <2f36e766-054c-4001-addf-fe388916d858@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--CXYm3VvaaUbdovYY
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:11:27PM +0200, Andrzej Pietrasiewicz wrote:
>Hi,
>
>W dniu 10.05.2024 o=A012:11, Michael Grzeschik pisze:
>>On Fri, May 10, 2024 at 11:25:47AM +0200, Andrzej Pietrasiewicz wrote:
>>>Hi Michael,
>>>
>>>W dniu 30.04.2024 o=A001:33, Michael Grzeschik pisze:
>>>>Add the new gadget function for 9pfs transport. This function is
>>>>defining an simple 9pfs transport interface that consists of one in and
>>>>one out endpoint. The endpoints transmit and receive the 9pfs protocol
>>>>payload when mounting a 9p filesystem over usb.
>>>>
>>>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>>
>>>>---
>>>>v3 -> v4:
>>>>=A0 - implemented conn_cancel
>>>
>>>I tried this scenario:
>>>
>>>1) run all the components and have 9pfs up and running
>>>2) stop the forwarder
>>>3) umount -f at the gadget side - this indeed succeeds now in v4
>>>4) start the forwarder again
>>>5) mount at the gadget side - this hangs.
>>>
>>>Did this scenario work for you?
>>
>>I actually tested this exact scenario. So this is
>>suprising. I will try this again just to be sure
>>that I did send the latest version.
>>
>>My latest testsetup included the dummy_hcd. Did you test on real hardware?
>
>Yes, I did.

I found out that the issue lies in the current disable/enable endpoint
mechanism the layer was using to stop and enable the endpoint every
time the fs was unmounted or mounted. I changed this to only disable
the endpoint on unbind and enable it on set alt callback.

This should work fine now with v5.

https://lore.kernel.org/all/20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutr=
onix.de/

Regards,
Michael

>>>>=A0 - moved from mount_tag to device name like ffs does
>>>>=A0 - renamed function_list to usb9pfs_instance
>>>>=A0 - renamed usbg_function_list to usb9pfs_instance_list
>>>>=A0 - renamed rx/tx_fill to queue_rx/tx
>>>>=A0 - added use of retvals
>>>>=A0 - added locking comment over usb9pfs_transmit
>>>>=A0 - using if_else instead of two pathed switch calls
>>>>=A0 - fixed return values of completion handler
>>>>=A0 - using void pointer as parameter in rx_header
>>>>=A0 - added a missed req_put in rx_header
>>>>=A0 - removed extra disable function but call disable_ep directly
>>>>=A0 - repaired several return values
>>>>=A0 - remove the suspicious disable / enable path in usbg_create
>>>>v2 -> v3: -
>>>>v1 -> v2:
>>>>=A0 - move the driver to net/9p/trans_usbg.c
>>>>=A0 - fixed the commit title
>>>>=A0 - fix %zu usage in p9_debug for size_t type
>>>>=A0 - define functions static that are only used localy
>>>>=A0 - return 0 in alloc_requests
>>>>=A0 - use id_alloc_max instead of ida_simple_get
>>>>=A0 - call ida_free in usb9pfs_free_func
>>>>=A0 - call kfree for usb9pfs->tag and usb9pfs in usb9pfs_free_func
>>>>=A0 - add MODULE_ALIAS_9P to load this module automatic when mounting
>>>>=A0 - improved the documentation
>>>>=A0 - added depends on USB_GADGET in Kconfig
>>>>---
>>>>=A0Documentation/filesystems/9p.rst |=A0 17 +-
>>>>=A0net/9p/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0 6 +
>>>>=A0net/9p/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 4 +
>>>>=A0net/9p/trans_usbg.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 983 +++=
++++++++++++++++++++++++++++++++++++
>>>>=A04 files changed, 1009 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesyste=
ms/9p.rst
>>>>index 1e0e0bb6fdf91..10cf79dc287f8 100644
>>>>--- a/Documentation/filesystems/9p.rst
>>>>+++ b/Documentation/filesystems/9p.rst
>>>>@@ -48,11 +48,25 @@ For server running on QEMU host with virtio transpo=
rt::
>>>>=A0=A0=A0=A0 mount -t 9p -o trans=3Dvirtio <mount_tag> /mnt/9
>>>>-where mount_tag is the tag associated by the server to each of the exp=
orted
>>>>+where mount_tag is the tag generated by the server to each of the expo=
rted
>>>>=A0mount points. Each 9P export is seen by the client as a virtio devic=
e with an
>>>>=A0associated "mount_tag" property. Available mount tags can be
>>>>=A0seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount=
_tag files.
>>>>+USBG Usage
>>>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>+
>>>>+To mount a 9p FS on a USB Host accessible via the gadget at runtime::
>>>>+
>>>>+=A0=A0=A0 mount -t 9p -o trans=3Dusbg,aname=3D/path/to/fs <device> /mn=
t/9
>>>>+
>>>>+To mount a 9p FS on a USB Host accessible via the gadget as root files=
ystem::
>>>>+
>>>>+=A0=A0=A0 root=3D<device> rootfstype=3D9p rootflags=3Dtrans=3Dusbg,cac=
he=3Dloose,uname=3Droot,access=3D0,dfltuid=3D0,dfltgid=3D0,aname=3D/path/to=
/rootfs
>>>>+
>>>>+where <device> is the tag associated by the usb gadget transport.
>>>>+It is defined by the configfs instance name.
>>>>+
>>>>=A0Options
>>>>=A0=3D=3D=3D=3D=3D=3D=3D
>>>>@@ -68,6 +82,7 @@ Options
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virtio=A0=A0=A0=A0=A0 connect to t=
he next virtio channel available
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (from QEMU with =
trans_virtio module)
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rdma=A0=A0=A0=A0=A0 connect to a s=
pecified RDMA channel
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usbg=A0=A0=A0=A0=A0 connect to a spe=
cified usb gadget channel
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>=A0=A0 uname=3Dname=A0=A0=A0 user name to attempt mount as on the remot=
e server.=A0 The
>>>>diff --git a/net/9p/Kconfig b/net/9p/Kconfig
>>>>index 00ebce9e5a657..c3d357eb8bb37 100644
>>>>--- a/net/9p/Kconfig
>>>>+++ b/net/9p/Kconfig
>>>>@@ -39,6 +39,12 @@ config NET_9P_XEN
>>>>=A0=A0=A0=A0=A0=A0 This builds support for a transport for 9pfs between
>>>>=A0=A0=A0=A0=A0=A0 two Xen domains.
>>>>+config NET_9P_USBG
>>>>+=A0=A0=A0 bool "9P USB Gadget Transport"
>>>>+=A0=A0=A0 depends on USB_GADGET
>>>>+=A0=A0=A0 help
>>>>+=A0=A0=A0=A0=A0 This builds support for a transport for 9pfs over
>>>>+=A0=A0=A0=A0=A0 usb gadget.
>>>>=A0config NET_9P_RDMA
>>>>=A0=A0=A0=A0 depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
>>>>diff --git a/net/9p/Makefile b/net/9p/Makefile
>>>>index 1df9b344c30bd..22794a451c3f7 100644
>>>>--- a/net/9p/Makefile
>>>>+++ b/net/9p/Makefile
>>>>@@ -4,6 +4,7 @@ obj-$(CONFIG_NET_9P_FD) +=3D 9pnet_fd.o
>>>>=A0obj-$(CONFIG_NET_9P_XEN) +=3D 9pnet_xen.o
>>>>=A0obj-$(CONFIG_NET_9P_VIRTIO) +=3D 9pnet_virtio.o
>>>>=A0obj-$(CONFIG_NET_9P_RDMA) +=3D 9pnet_rdma.o
>>>>+obj-$(CONFIG_NET_9P_USBG) +=3D 9pnet_usbg.o
>>>>=A09pnet-objs :=3D \
>>>>=A0=A0=A0=A0 mod.o \
>>>>@@ -23,3 +24,6 @@ obj-$(CONFIG_NET_9P_RDMA) +=3D 9pnet_rdma.o
>>>>=A09pnet_rdma-objs :=3D \
>>>>=A0=A0=A0=A0 trans_rdma.o \
>>>>+
>>>>+9pnet_usbg-objs :=3D \
>>>>+=A0=A0=A0 trans_usbg.o \
>>>>diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
>>>>new file mode 100644
>>>>index 0000000000000..bc440033cbe68
>>>>--- /dev/null
>>>>+++ b/net/9p/trans_usbg.c
>>>>@@ -0,0 +1,983 @@
>>>>+// SPDX-License-Identifier: GPL-2.0+
>>>>+/*
>>>>+ * trans_usbg.c - USB peripheral usb9pfs configuration driver and tran=
sport.
>>>>+ *
>>>>+ * Copyright (C) 2024 Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>>+ */
>>>>+
>>>>+/* Gadget usb9pfs only needs two bulk endpoints, and will use the usb9=
pfs
>>>>+ * transport to mount host exported filesystem via usb gadget.
>>>>+ */
>>>>+
>>>>+/*=A0=A0=A0=A0 +--------------------------+=A0=A0=A0 |=A0=A0=A0 +-----=
---------------------+
>>>>+ *=A0=A0=A0=A0 |=A0 9PFS mounting client=A0=A0=A0 |=A0=A0=A0 |=A0=A0=
=A0 |=A0 9PFS exporting server=A0=A0 |
>>>>+ *=A0 SW |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>>>>+ *=A0=A0=A0=A0 |=A0=A0 (this:trans_usbg)=A0=A0=A0=A0=A0 |=A0=A0=A0 |=
=A0=A0=A0 |(e.g. diod or nfs-ganesha)|
>>>>+ *=A0=A0=A0=A0 +-------------^------------+=A0=A0=A0 |=A0=A0=A0 +-----=
--------^------------+
>>>>+ *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |
>>>>+ * ------------------|------------------------------------|-----------=
--
>>>>+ *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |
>>>>+ *=A0=A0=A0=A0 +-------------v------------+=A0=A0=A0 |=A0=A0=A0 +-----=
--------v------------+
>>>>+ *=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>>>>+ *=A0 HW |=A0=A0 USB Device Controller=A0 <--------->=A0=A0 USB Host C=
ontroller=A0=A0=A0 |
>>>>+ *=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>>>>+ *=A0=A0=A0=A0 +--------------------------+=A0=A0=A0 |=A0=A0=A0 +-----=
---------------------+
>>>>+ */
>>>>+
>>>>+#include <linux/slab.h>
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/device.h>
>>>>+#include <linux/module.h>
>>>>+#include <linux/err.h>
>>>>+#include <linux/usb/composite.h>
>>>>+#include <linux/usb/u_f.h>
>>>>+
>>>>+#include <net/9p/9p.h>
>>>>+#include <net/9p/client.h>
>>>>+#include <net/9p/transport.h>
>>>>+
>>>>+#define DEFAULT_BUFLEN=A0=A0=A0=A0=A0=A0=A0 16384
>>>>+
>>>>+struct f_usb9pfs {
>>>>+=A0=A0=A0 struct p9_client *client;
>>>>+
>>>>+=A0=A0=A0 struct p9_req_t *p9_tx_req;
>>>>+
>>>>+=A0=A0=A0 struct list_head tx_req_list;
>>>>+
>>>>+=A0=A0=A0 /* 9p request lock for en/dequeue */
>>>>+=A0=A0=A0 spinlock_t lock;
>>>>+=A0=A0=A0 /* usb request lock for en/dequeue */
>>>>+=A0=A0=A0 spinlock_t req_lock;
>>>>+
>>>>+=A0=A0=A0 struct usb_request *in_req;
>>>>+=A0=A0=A0 struct usb_request *out_req;
>>>>+
>>>>+=A0=A0=A0 struct usb_ep *in_ep;
>>>>+=A0=A0=A0 struct usb_ep *out_ep;
>>>>+
>>>>+=A0=A0=A0 unsigned int buflen;
>>>>+
>>>>+=A0=A0=A0 struct usb_function function;
>>>>+};
>>>>+
>>>>+static inline struct f_usb9pfs *func_to_usb9pfs(struct usb_function *f)
>>>>+{
>>>>+=A0=A0=A0 return container_of(f, struct f_usb9pfs, function);
>>>>+}
>>>>+
>>>>+struct f_usb9pfs_opts {
>>>>+=A0=A0=A0 struct usb_function_instance func_inst;
>>>>+=A0=A0=A0 unsigned int buflen;
>>>>+
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *dev;
>>>>+
>>>>+=A0=A0=A0 /* Read/write access to configfs attributes is handled by co=
nfigfs.
>>>>+=A0=A0=A0=A0 *
>>>>+=A0=A0=A0=A0 * This is to protect the data from concurrent access by r=
ead/write
>>>>+=A0=A0=A0=A0 * and create symlink/remove symlink.
>>>>+=A0=A0=A0=A0 */
>>>>+=A0=A0=A0 struct mutex lock;
>>>>+=A0=A0=A0 int refcnt;
>>>>+};
>>>>+
>>>>+struct f_usb9pfs_dev {
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs;
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts;
>>>>+=A0=A0=A0 char tag[41];
>>>>+=A0=A0=A0 bool inuse;
>>>>+
>>>>+=A0=A0=A0 struct list_head usb9pfs_instance;
>>>>+};
>>>>+
>>>>+static DEFINE_MUTEX(usb9pfs_lock);
>>>>+static struct list_head usbg_instance_list;
>>>>+
>>>>+static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_requ=
est *req,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gfp_t gfp_flags)
>>>>+{
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D usb9pfs->function.config-=
>cdev;
>>>>+=A0=A0=A0 int ret =3D -ENOMEM;
>>>>+
>>>>+=A0=A0=A0 if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacke=
t))
>>>>+=A0=A0=A0=A0=A0=A0=A0 req->zero =3D 1;
>>>>+
>>>>+=A0=A0=A0 req->buf =3D usb9pfs->p9_tx_req->tc.sdata;
>>>>+=A0=A0=A0 req->length =3D usb9pfs->p9_tx_req->tc.size;
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero=
: %d\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0 usb9pfs->in_ep->name, req->actual, req->length, =
req->zero);
>>>>+
>>>>+=A0=A0=A0 ret =3D usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", ret);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static int usb9pfs_queue_rx(struct f_usb9pfs *usb9pfs, struct usb_requ=
est *req,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gfp_t gfp_flags)
>>>>+{
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D usb9pfs->function.config-=
>cdev;
>>>>+=A0=A0=A0 int ret =3D -ENOMEM;
>>>>+
>>>>+=A0=A0=A0 ret =3D usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+/* This needs to be called with usb9pfs->req_lock held */
>>>>+static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
>>>>+{
>>>>+=A0=A0=A0 struct p9_req_t *p9_req =3D NULL;
>>>>+=A0=A0=A0 unsigned long flags;
>>>>+=A0=A0=A0 int ret =3D 0;
>>>>+
>>>>+=A0=A0=A0 spin_lock_irqsave(&usb9pfs->lock, flags);
>>>>+
>>>>+=A0=A0=A0 if (usb9pfs->p9_tx_req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -EBUSY;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 p9_req =3D list_first_entry_or_null(&usb9pfs->tx_req_list,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct=
 p9_req_t, req_list);
>>>>+=A0=A0=A0 if (!p9_req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -ENOENT;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 list_del(&p9_req->req_list);
>>>>+
>>>>+=A0=A0=A0 usb9pfs->p9_tx_req =3D p9_req;
>>>>+
>>>>+=A0=A0=A0 p9_req_get(usb9pfs->p9_tx_req);
>>>>+
>>>>+=A0=A0=A0 ret =3D usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMI=
C);
>>>>+
>>>>+=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request =
*req)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D usb9pfs->function.config-=
>cdev;
>>>>+=A0=A0=A0 int ret =3D 0;
>>>>+
>>>>+=A0=A0=A0 if (req->status) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 dev_err(&cdev->gadget->dev, "%s usb9pfs complete=
 --> %d, %d/%d\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ep->name, req->status, req->actual, =
req->length);
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto free_req;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 /* reset zero packages */
>>>>+=A0=A0=A0 req->zero =3D 0;
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/=
%d\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0 ep->name, req->status, req->actual, req->length);
>>>>+
>>>>+=A0=A0=A0 spin_lock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
>>>>+
>>>>+=A0=A0=A0 p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
>>>>+
>>>>+=A0=A0=A0 ret =3D usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOM=
IC);
>>>>+=A0=A0=A0 if (ret) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&usb9pfs->req_lock);
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto free_req;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 spin_unlock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 return;
>>>>+
>>>>+free_req:
>>>>+=A0=A0=A0 usb_ep_free_request(ep =3D=3D usb9pfs->in_ep ?
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs->out_ep : usb9pf=
s->in_ep,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 req->context);
>>>>+=A0=A0=A0 free_ep_req(ep, req);
>>>>+}
>>>>+
>>>>+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, v=
oid *buf)
>>>>+{
>>>>+=A0=A0=A0 struct p9_req_t *p9_rx_req;
>>>>+=A0=A0=A0 struct p9_fcall=A0=A0=A0 rc;
>>>>+=A0=A0=A0 int ret;
>>>>+
>>>>+=A0=A0=A0 /* start by reading header */
>>>>+=A0=A0=A0 rc.sdata =3D buf;
>>>>+=A0=A0=A0 rc.offset =3D 0;
>>>>+=A0=A0=A0 rc.capacity =3D P9_HDRSZ;
>>>>+=A0=A0=A0 rc.size =3D P9_HDRSZ;
>>>>+
>>>>+=A0=A0=A0 p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0 rc.capacity - rc.offset);
>>>>+
>>>>+=A0=A0=A0 ret =3D p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
>>>>+=A0=A0=A0 if (ret) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_debug(P9_DEBUG_ERROR,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "error parsing header: %d\n", ret=
);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 p9_debug(P9_DEBUG_TRANS,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0 "mux %p pkt: size: %d bytes tag: %d\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs, rc.size, rc.tag);
>>>>+
>>>>+=A0=A0=A0 p9_rx_req =3D p9_tag_lookup(usb9pfs->client, rc.tag);
>>>>+=A0=A0=A0 if (!p9_rx_req || p9_rx_req->status !=3D REQ_STATUS_SENT) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag =
%d\n", rc.tag);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 if (rc.size > p9_rx_req->rc.capacity) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_debug(P9_DEBUG_ERROR,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "requested packet size too big: %=
d for tag %d with=20
>>>>capacity %zd\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc.size, rc.tag, p9_rx_req->rc.ca=
pacity);
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_req_put(usb9pfs->client, p9_rx_req);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 if (!p9_rx_req->rc.sdata) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_debug(P9_DEBUG_ERROR,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "No recv fcall for tag %d (req %p=
), disconnecting!\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc.tag, p9_rx_req);
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_req_put(usb9pfs->client, p9_rx_req);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 return p9_rx_req;
>>>>+}
>>>>+
>>>>+static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request =
*req)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D ep->driver_data;
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D usb9pfs->function.config-=
>cdev;
>>>>+=A0=A0=A0 struct p9_req_t *p9_rx_req;
>>>>+=A0=A0=A0 unsigned long flags;
>>>>+=A0=A0=A0 int ret =3D 0;
>>>>+
>>>>+=A0=A0=A0 if (req->status) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 dev_err(&cdev->gadget->dev, "%s usb9pfs complete=
 --> %d, %d/%d\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ep->name, req->status, req->actual, =
req->length);
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto free_req;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>>>+
>>>>+=A0=A0=A0 p9_rx_req =3D usb9pfs_rx_header(usb9pfs, req->buf);
>>>>+=A0=A0=A0 if (!p9_rx_req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->req_lock, flags=
);
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto free_req;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
>>>>+
>>>>+=A0=A0=A0 p9_rx_req->rc.size =3D req->actual;
>>>>+
>>>>+=A0=A0=A0 p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
>>>>+=A0=A0=A0 p9_req_put(usb9pfs->client, p9_rx_req);
>>>>+
>>>>+=A0=A0=A0 usb9pfs->p9_tx_req =3D NULL;
>>>>+
>>>>+=A0=A0=A0 ret =3D usb9pfs_transmit(usb9pfs);
>>>>+=A0=A0=A0 if (ret) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->req_lock, flags=
);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>>>+
>>>>+=A0=A0=A0 return;
>>>>+
>>>>+free_req:
>>>>+=A0=A0=A0 usb_ep_free_request(ep =3D=3D usb9pfs->in_ep ?
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs->out_ep : usb9pf=
s->in_ep,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 req->context);
>>>>+=A0=A0=A0 free_ep_req(ep, req);
>>>>+
>>>>+=A0=A0=A0 p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_ERROR);
>>>>+}
>>>>+
>>>>+static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *=
ep)
>>>>+{
>>>>+=A0=A0=A0 int value;
>>>>+
>>>>+=A0=A0=A0 value =3D usb_ep_disable(ep);
>>>>+=A0=A0=A0 if (value < 0)
>>>>+=A0=A0=A0=A0=A0=A0=A0 dev_info(&cdev->gadget->dev,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "disable %s --> %d\n", ep->name, =
value);
>>>>+}
>>>>+
>>>>+static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
>>>>+{
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D
>>>>+=A0=A0=A0=A0=A0=A0=A0 usb9pfs->function.config->cdev;
>>>>+
>>>>+=A0=A0=A0 disable_ep(cdev, usb9pfs->in_ep);
>>>>+=A0=A0=A0 disable_ep(cdev, usb9pfs->out_ep);
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "%s disabled\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0 usb9pfs->function.name);
>>>>+}
>>>>+
>>>>+static int alloc_requests(struct usb_composite_dev *cdev,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct f_usb9pfs *usb9pfs)
>>>>+{
>>>>+=A0=A0=A0 int ret =3D 0;
>>>>+
>>>>+=A0=A0=A0 usb9pfs->in_req =3D usb_ep_alloc_request(usb9pfs->in_ep, GFP=
_ATOMIC);
>>>>+=A0=A0=A0 if (!usb9pfs->in_req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOENT;
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto fail;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 usb9pfs->out_req =3D alloc_ep_req(usb9pfs->out_ep, usb9pfs->=
buflen);
>>>>+=A0=A0=A0 if (!usb9pfs->out_req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOENT;
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto fail_in;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 usb9pfs->in_req->complete =3D usb9pfs_tx_complete;
>>>>+=A0=A0=A0 usb9pfs->out_req->complete =3D usb9pfs_rx_complete;
>>>>+
>>>>+=A0=A0=A0 /* length will be set in complete routine */
>>>>+=A0=A0=A0 usb9pfs->in_req->context =3D usb9pfs;
>>>>+=A0=A0=A0 usb9pfs->out_req->context =3D usb9pfs;
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+
>>>>+fail_in:
>>>>+=A0=A0=A0 usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
>>>>+fail:
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static int enable_endpoint(struct usb_composite_dev *cdev,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct f_usb9pfs *usb9pfs, =
struct usb_ep *ep)
>>>>+{
>>>>+=A0=A0=A0 int ret;
>>>>+
>>>>+=A0=A0=A0 ret =3D config_ep_by_speed(cdev->gadget, &usb9pfs->function,=
 ep);
>>>>+=A0=A0=A0 if (ret)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ret;
>>>>+
>>>>+=A0=A0=A0 ret =3D usb_ep_enable(ep);
>>>>+=A0=A0=A0 if (ret < 0)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ret;
>>>>+
>>>>+=A0=A0=A0 ep->driver_data =3D usb9pfs;
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static int
>>>>+enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9p=
fs)
>>>>+{
>>>>+=A0=A0=A0 int result =3D 0;
>>>>+
>>>>+=A0=A0=A0 result =3D enable_endpoint(cdev, usb9pfs, usb9pfs->in_ep);
>>>>+=A0=A0=A0 if (result)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>+
>>>>+=A0=A0=A0 result =3D enable_endpoint(cdev, usb9pfs, usb9pfs->out_ep);
>>>>+=A0=A0=A0 if (result)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto disable_in;
>>>>+
>>>>+=A0=A0=A0 result =3D alloc_requests(cdev, usb9pfs);
>>>>+=A0=A0=A0 if (result)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto disable_out;
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "%s enabled\n", usb9pfs->functio=
n.name);
>>>>+=A0=A0=A0 return 0;
>>>>+
>>>>+disable_out:
>>>>+=A0=A0=A0 usb_ep_disable(usb9pfs->out_ep);
>>>>+disable_in:
>>>>+=A0=A0=A0 usb_ep_disable(usb9pfs->in_ep);
>>>>+out:
>>>>+=A0=A0=A0 return result;
>>>>+}
>>>>+
>>>>+static int p9_usbg_create(struct p9_client *client, const char=20
>>>>*devname, char *args)
>>>>+{
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev;
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *dev;
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *tmp;
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs;
>>>>+=A0=A0=A0 struct usb_function *f;
>>>>+=A0=A0=A0 int ret =3D -ENOENT;
>>>>+=A0=A0=A0 int found =3D 0;
>>>>+
>>>>+=A0=A0=A0 if (!devname)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&usb9pfs_lock);
>>>>+=A0=A0=A0 list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9=
pfs_instance) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 if (!strncmp(devname, dev->tag, strlen(devname))=
) {
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!dev->inuse) {
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->inuse =3D true;
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 found =3D 1;
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>+=A0=A0=A0=A0=A0=A0=A0 }
>>>>+=A0=A0=A0 }
>>>>+=A0=A0=A0 mutex_unlock(&usb9pfs_lock);
>>>>+
>>>>+=A0=A0=A0 if (!found) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 pr_err("no channels available for device %s\n", =
devname);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ret;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 usb9pfs =3D dev->usb9pfs;
>>>>+=A0=A0=A0 if (!usb9pfs)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>>>+
>>>>+=A0=A0=A0 INIT_LIST_HEAD(&usb9pfs->tx_req_list);
>>>>+
>>>>+=A0=A0=A0 spin_lock_init(&usb9pfs->lock);
>>>>+=A0=A0=A0 spin_lock_init(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 f =3D &usb9pfs->function;
>>>>+=A0=A0=A0 cdev =3D f->config->cdev;
>>>>+
>>>>+=A0=A0=A0 client->trans =3D (void *)usb9pfs;
>>>>+=A0=A0=A0 client->status =3D Connected;
>>>>+=A0=A0=A0 usb9pfs->client =3D client;
>>>>+
>>>>+=A0=A0=A0 client->trans_mod->maxsize =3D usb9pfs->buflen;
>>>>+
>>>>+=A0=A0=A0 return enable_usb9pfs(cdev, usb9pfs);
>>>>+}
>>>>+
>>>>+static void p9_usbg_close(struct p9_client *client)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs;
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *dev;
>>>>+=A0=A0=A0 struct p9_req_t *req;
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts;
>>>>+
>>>>+=A0=A0=A0 if (!client)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return;
>>>>+
>>>>+=A0=A0=A0 usb9pfs =3D client->trans;
>>>>+=A0=A0=A0 if (!usb9pfs)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return;
>>>>+
>>>>+=A0=A0=A0 client->status =3D Disconnected;
>>>>+
>>>>+=A0=A0=A0 spin_lock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 req =3D usb9pfs->p9_tx_req;
>>>>+=A0=A0=A0 if (req) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 if (!req->t_err)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 req->t_err =3D -ECONNRESET;
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_client_cb(usb9pfs->client, req, REQ_STATUS_ER=
ROR);
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 spin_unlock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 disable_usb9pfs(usb9pfs);
>>>>+
>>>>+=A0=A0=A0 opts =3D container_of(usb9pfs->function.fi,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct f_usb9pfs_opts, f=
unc_inst);
>>>>+
>>>>+=A0=A0=A0 dev =3D opts->dev;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&usb9pfs_lock);
>>>>+=A0=A0=A0 dev->inuse =3D false;
>>>>+=A0=A0=A0 mutex_unlock(&usb9pfs_lock);
>>>>+}
>>>>+
>>>>+static int p9_usbg_request(struct p9_client *client, struct p9_req_t *=
p9_req)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D client->trans;
>>>>+=A0=A0=A0 unsigned long flags;
>>>>+
>>>>+=A0=A0=A0 if (client->status !=3D Connected)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -EBUSY;
>>>>+
>>>>+=A0=A0=A0 spin_lock_irqsave(&usb9pfs->lock, flags);
>>>>+=A0=A0=A0 list_add_tail(&p9_req->req_list, &usb9pfs->tx_req_list);
>>>>+=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->lock, flags);
>>>>+
>>>>+=A0=A0=A0 spin_lock_irqsave(&usb9pfs->req_lock, flags);
>>>>+=A0=A0=A0 usb9pfs_transmit(usb9pfs);
>>>>+=A0=A0=A0 spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
>>>>+
>>>>+=A0=A0=A0 return 0;
>>>>+}
>>>>+
>>>>+static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *r=
eq)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D client->trans;
>>>>+=A0=A0=A0 int ret =3D 1;
>>>>+
>>>>+=A0=A0=A0 p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
>>>>+
>>>>+=A0=A0=A0 spin_lock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 if (req->status =3D=3D REQ_STATUS_UNSENT) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 list_del(&req->req_list);
>>>>+=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
>>>>+=A0=A0=A0=A0=A0=A0=A0 p9_req_put(client, req);
>>>>+=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
>>>>+=A0=A0=A0 }
>>>>+=A0=A0=A0 spin_unlock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static struct p9_trans_module p9_usbg_trans =3D {
>>>>+=A0=A0=A0 .name =3D "usbg",
>>>>+=A0=A0=A0 .create =3D p9_usbg_create,
>>>>+=A0=A0=A0 .close =3D p9_usbg_close,
>>>>+=A0=A0=A0 .request =3D p9_usbg_request,
>>>>+=A0=A0=A0 .cancel =3D p9_usbg_cancel,
>>>>+=A0=A0=A0 .owner =3D THIS_MODULE,
>>>>+};
>>>>+
>>>>+/*--------------------------------------------------------------------=
-----*/
>>>>+
>>>>+#define USB_PROTOCOL_9PFS=A0=A0=A0 0x09
>>>>+
>>>>+static struct usb_interface_descriptor usb9pfs_intf =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 sizeof(usb9pfs_intf),
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_INTERFACE,
>>>>+
>>>>+=A0=A0=A0 .bNumEndpoints =3D=A0=A0=A0 2,
>>>>+=A0=A0=A0 .bInterfaceClass =3D=A0=A0=A0 USB_CLASS_VENDOR_SPEC,
>>>>+=A0=A0=A0 .bInterfaceSubClass =3D=A0=A0=A0 USB_SUBCLASS_VENDOR_SPEC,
>>>>+=A0=A0=A0 .bInterfaceProtocol =3D=A0=A0 USB_PROTOCOL_9PFS,
>>>>+
>>>>+=A0=A0=A0 /* .iInterface =3D DYNAMIC */
>>>>+};
>>>>+
>>>>+/* full speed support: */
>>>>+
>>>>+static struct usb_endpoint_descriptor fs_usb9pfs_source_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bEndpointAddress =3D=A0=A0=A0 USB_DIR_IN,
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+};
>>>>+
>>>>+static struct usb_endpoint_descriptor fs_usb9pfs_sink_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bEndpointAddress =3D=A0=A0=A0 USB_DIR_OUT,
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+};
>>>>+
>>>>+static struct usb_descriptor_header *fs_usb9pfs_descs[] =3D {
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&usb9pfs_intf,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&fs_usb9pfs_sink_desc,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&fs_usb9pfs_source_desc,
>>>>+=A0=A0=A0 NULL,
>>>>+};
>>>>+
>>>>+/* high speed support: */
>>>>+
>>>>+static struct usb_endpoint_descriptor hs_usb9pfs_source_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+=A0=A0=A0 .wMaxPacketSize =3D=A0=A0=A0 cpu_to_le16(512),
>>>>+};
>>>>+
>>>>+static struct usb_endpoint_descriptor hs_usb9pfs_sink_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+=A0=A0=A0 .wMaxPacketSize =3D=A0=A0=A0 cpu_to_le16(512),
>>>>+};
>>>>+
>>>>+static struct usb_descriptor_header *hs_usb9pfs_descs[] =3D {
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&usb9pfs_intf,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&hs_usb9pfs_source_desc,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&hs_usb9pfs_sink_desc,
>>>>+=A0=A0=A0 NULL,
>>>>+};
>>>>+
>>>>+/* super speed support: */
>>>>+
>>>>+static struct usb_endpoint_descriptor ss_usb9pfs_source_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+=A0=A0=A0 .wMaxPacketSize =3D=A0=A0=A0 cpu_to_le16(1024),
>>>>+};
>>>>+
>>>>+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_source_comp_desc =
=3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_SS_EP_COMP_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_SS_ENDPOINT_COMP,
>>>>+=A0=A0=A0 .bMaxBurst =3D=A0=A0=A0=A0=A0=A0=A0 0,
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 0,
>>>>+=A0=A0=A0 .wBytesPerInterval =3D=A0=A0=A0 0,
>>>>+};
>>>>+
>>>>+static struct usb_endpoint_descriptor ss_usb9pfs_sink_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_ENDPOINT_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_ENDPOINT,
>>>>+
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 USB_ENDPOINT_XFER_BUL=
K,
>>>>+=A0=A0=A0 .wMaxPacketSize =3D=A0=A0=A0 cpu_to_le16(1024),
>>>>+};
>>>>+
>>>>+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_sink_comp_desc =3D {
>>>>+=A0=A0=A0 .bLength =3D=A0=A0=A0=A0=A0=A0=A0 USB_DT_SS_EP_COMP_SIZE,
>>>>+=A0=A0=A0 .bDescriptorType =3D=A0=A0=A0 USB_DT_SS_ENDPOINT_COMP,
>>>>+=A0=A0=A0 .bMaxBurst =3D=A0=A0=A0=A0=A0=A0=A0 0,
>>>>+=A0=A0=A0 .bmAttributes =3D=A0=A0=A0=A0=A0=A0=A0 0,
>>>>+=A0=A0=A0 .wBytesPerInterval =3D=A0=A0=A0 0,
>>>>+};
>>>>+
>>>>+static struct usb_descriptor_header *ss_usb9pfs_descs[] =3D {
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&usb9pfs_intf,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&ss_usb9pfs_source_desc,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&ss_usb9pfs_source_comp_desc,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&ss_usb9pfs_sink_desc,
>>>>+=A0=A0=A0 (struct usb_descriptor_header *)&ss_usb9pfs_sink_comp_desc,
>>>>+=A0=A0=A0 NULL,
>>>>+};
>>>>+
>>>>+/* function-specific strings: */
>>>>+static struct usb_string strings_usb9pfs[] =3D {
>>>>+=A0=A0=A0 [0].s =3D "usb9pfs input to output",
>>>>+=A0=A0=A0 {=A0 }=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* end of list */
>>>>+};
>>>>+
>>>>+static struct usb_gadget_strings stringtab_usb9pfs =3D {
>>>>+=A0=A0=A0 .language=A0=A0=A0 =3D 0x0409,=A0=A0=A0 /* en-us */
>>>>+=A0=A0=A0 .strings=A0=A0=A0 =3D strings_usb9pfs,
>>>>+};
>>>>+
>>>>+static struct usb_gadget_strings *usb9pfs_strings[] =3D {
>>>>+=A0=A0=A0 &stringtab_usb9pfs,
>>>>+=A0=A0=A0 NULL,
>>>>+};
>>>>+
>>>>+/*--------------------------------------------------------------------=
-----*/
>>>>+
>>>>+static int usb9pfs_func_bind(struct usb_configuration *c,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct usb_function *=
f)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts;
>>>>+=A0=A0=A0 struct usb_composite_dev *cdev =3D c->cdev;
>>>>+=A0=A0=A0 int ret;
>>>>+=A0=A0=A0 int id;
>>>>+
>>>>+=A0=A0=A0 /* allocate interface ID(s) */
>>>>+=A0=A0=A0 id =3D usb_interface_id(c, f);
>>>>+=A0=A0=A0 if (id < 0)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return id;
>>>>+=A0=A0=A0 usb9pfs_intf.bInterfaceNumber =3D id;
>>>>+
>>>>+=A0=A0=A0 id =3D usb_string_id(cdev);
>>>>+=A0=A0=A0 if (id < 0)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return id;
>>>>+=A0=A0=A0 strings_usb9pfs[0].id =3D id;
>>>>+=A0=A0=A0 usb9pfs_intf.iInterface =3D id;
>>>>+
>>>>+=A0=A0=A0 /* allocate endpoints */
>>>>+=A0=A0=A0 usb9pfs->in_ep =3D usb_ep_autoconfig(cdev->gadget,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &fs=
_usb9pfs_source_desc);
>>>>+=A0=A0=A0 if (!usb9pfs->in_ep)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto autoconf_fail;
>>>>+
>>>>+=A0=A0=A0 usb9pfs->out_ep =3D usb_ep_autoconfig(cdev->gadget,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
&fs_usb9pfs_sink_desc);
>>>>+=A0=A0=A0 if (!usb9pfs->out_ep)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto autoconf_fail;
>>>>+
>>>>+=A0=A0=A0 /* support high speed hardware */
>>>>+=A0=A0=A0 hs_usb9pfs_source_desc.bEndpointAddress =3D
>>>>+=A0=A0=A0=A0=A0=A0=A0 fs_usb9pfs_source_desc.bEndpointAddress;
>>>>+=A0=A0=A0 hs_usb9pfs_sink_desc.bEndpointAddress =3D
>>>>+=A0=A0=A0=A0=A0=A0=A0 fs_usb9pfs_sink_desc.bEndpointAddress;
>>>>+
>>>>+=A0=A0=A0 /* support super speed hardware */
>>>>+=A0=A0=A0 ss_usb9pfs_source_desc.bEndpointAddress =3D
>>>>+=A0=A0=A0=A0=A0=A0=A0 fs_usb9pfs_source_desc.bEndpointAddress;
>>>>+=A0=A0=A0 ss_usb9pfs_sink_desc.bEndpointAddress =3D
>>>>+=A0=A0=A0=A0=A0=A0=A0 fs_usb9pfs_sink_desc.bEndpointAddress;
>>>>+
>>>>+=A0=A0=A0 ret =3D usb_assign_descriptors(f, fs_usb9pfs_descs, hs_usb9p=
fs_descs,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ss_usb9pf=
s_descs, ss_usb9pfs_descs);
>>>>+=A0=A0=A0 if (ret)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ret;
>>>>+
>>>>+=A0=A0=A0 opts =3D container_of(f->fi, struct f_usb9pfs_opts, func_ins=
t);
>>>>+=A0=A0=A0 opts->dev->usb9pfs =3D usb9pfs;
>>>>+
>>>>+=A0=A0=A0 dev_dbg(&cdev->gadget->dev, "%s speed %s: IN/%s, OUT/%s\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0 (gadget_is_superspeed(c->cdev->gadget) ? "super"=
 :
>>>>+=A0=A0=A0=A0=A0=A0=A0 (gadget_is_dualspeed(c->cdev->gadget) ? "dual" :=
 "full")),
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f->name, usb9pfs->in_ep->name, usb9p=
fs->out_ep->name);
>>>>+
>>>>+=A0=A0=A0 return 0;
>>>>+
>>>>+autoconf_fail:
>>>>+=A0=A0=A0 ERROR(cdev, "%s: can't autoconfigure on %s\n",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0 f->name, cdev->gadget->name);
>>>>+=A0=A0=A0 return -ENODEV;
>>>>+}
>>>>+
>>>>+static void usb9pfs_free_func(struct usb_function *f)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts;
>>>>+
>>>>+=A0=A0=A0 kfree(usb9pfs);
>>>>+
>>>>+=A0=A0=A0 opts =3D container_of(f->fi, struct f_usb9pfs_opts, func_ins=
t);
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&opts->lock);
>>>>+=A0=A0=A0 opts->refcnt--;
>>>>+=A0=A0=A0 mutex_unlock(&opts->lock);
>>>>+
>>>>+=A0=A0=A0 usb_free_all_descriptors(f);
>>>>+}
>>>>+
>>>>+static int usb9pfs_set_alt(struct usb_function *f,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int intf, unsigned=
 int alt)
>>>>+{
>>>>+=A0=A0=A0 return 0;
>>>>+}
>>>>+
>>>>+static void usb9pfs_disable(struct usb_function *f)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs =3D func_to_usb9pfs(f);
>>>>+=A0=A0=A0 struct p9_req_t *req;
>>>>+
>>>>+=A0=A0=A0 spin_lock(&usb9pfs->req_lock);
>>>>+
>>>>+=A0=A0=A0 req =3D usb9pfs->p9_tx_req;
>>>>+
>>>>+=A0=A0=A0 if (!req->t_err)
>>>>+=A0=A0=A0=A0=A0=A0=A0 req->t_err =3D -ECONNRESET;
>>>>+=A0=A0=A0 p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
>>>>+
>>>>+=A0=A0=A0 spin_unlock(&usb9pfs->req_lock);
>>>>+}
>>>>+
>>>>+static struct usb_function *usb9pfs_alloc(struct usb_function_instance=
 *fi)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *usb9pfs_opts;
>>>>+=A0=A0=A0 struct f_usb9pfs *usb9pfs;
>>>>+
>>>>+=A0=A0=A0 usb9pfs =3D kzalloc(sizeof(*usb9pfs), GFP_KERNEL);
>>>>+=A0=A0=A0 if (!usb9pfs)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(-ENOMEM);
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts =3D container_of(fi, struct f_usb9pfs_opts, fun=
c_inst);
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&usb9pfs_opts->lock);
>>>>+=A0=A0=A0 usb9pfs_opts->refcnt++;
>>>>+=A0=A0=A0 mutex_unlock(&usb9pfs_opts->lock);
>>>>+
>>>>+=A0=A0=A0 usb9pfs->buflen =3D usb9pfs_opts->buflen;
>>>>+
>>>>+=A0=A0=A0 usb9pfs->function.name =3D "usb9pfs";
>>>>+=A0=A0=A0 usb9pfs->function.bind =3D usb9pfs_func_bind;
>>>>+=A0=A0=A0 usb9pfs->function.set_alt =3D usb9pfs_set_alt;
>>>>+=A0=A0=A0 usb9pfs->function.disable =3D usb9pfs_disable;
>>>>+=A0=A0=A0 usb9pfs->function.strings =3D usb9pfs_strings;
>>>>+
>>>>+=A0=A0=A0 usb9pfs->function.free_func =3D usb9pfs_free_func;
>>>>+
>>>>+=A0=A0=A0 return &usb9pfs->function;
>>>>+}
>>>>+
>>>>+static inline struct f_usb9pfs_opts *to_f_usb9pfs_opts(struct=20
>>>>config_item *item)
>>>>+{
>>>>+=A0=A0=A0 return container_of(to_config_group(item), struct f_usb9pfs_=
opts,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 func_inst.group);
>>>>+}
>>>>+
>>>>+static inline struct f_usb9pfs_opts=20
>>>>*fi_to_f_usb9pfs_opts(struct usb_function_instance *fi)
>>>>+{
>>>>+=A0=A0=A0 return container_of(fi, struct f_usb9pfs_opts, func_inst);
>>>>+}
>>>>+
>>>>+static void usb9pfs_attr_release(struct config_item *item)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *usb9pfs_opts =3D to_f_usb9pfs_opts(it=
em);
>>>>+
>>>>+=A0=A0=A0 usb_put_function_instance(&usb9pfs_opts->func_inst);
>>>>+}
>>>>+
>>>>+static struct configfs_item_operations usb9pfs_item_ops =3D {
>>>>+=A0=A0=A0 .release=A0=A0=A0=A0=A0=A0=A0 =3D usb9pfs_attr_release,
>>>>+};
>>>>+
>>>>+static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, ch=
ar *page)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts =3D to_f_usb9pfs_opts(item);
>>>>+=A0=A0=A0 int result;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&opts->lock);
>>>>+=A0=A0=A0 result =3D sprintf(page, "%d\n", opts->buflen);
>>>>+=A0=A0=A0 mutex_unlock(&opts->lock);
>>>>+
>>>>+=A0=A0=A0 return result;
>>>>+}
>>>>+
>>>>+static ssize_t f_usb9pfs_opts_buflen_store(struct config_item *item,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 con=
st char *page, size_t len)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *opts =3D to_f_usb9pfs_opts(item);
>>>>+=A0=A0=A0 int ret;
>>>>+=A0=A0=A0 u32 num;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&opts->lock);
>>>>+=A0=A0=A0 if (opts->refcnt) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto end;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 ret =3D kstrtou32(page, 0, &num);
>>>>+=A0=A0=A0 if (ret)
>>>>+=A0=A0=A0=A0=A0=A0=A0 goto end;
>>>>+
>>>>+=A0=A0=A0 opts->buflen =3D num;
>>>>+=A0=A0=A0 ret =3D len;
>>>>+end:
>>>>+=A0=A0=A0 mutex_unlock(&opts->lock);
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+CONFIGFS_ATTR(f_usb9pfs_opts_, buflen);
>>>>+
>>>>+static struct configfs_attribute *usb9pfs_attrs[] =3D {
>>>>+=A0=A0=A0 &f_usb9pfs_opts_attr_buflen,
>>>>+=A0=A0=A0 NULL,
>>>>+};
>>>>+
>>>>+static const struct config_item_type usb9pfs_func_type =3D {
>>>>+=A0=A0=A0 .ct_item_ops=A0=A0=A0 =3D &usb9pfs_item_ops,
>>>>+=A0=A0=A0 .ct_attrs=A0=A0=A0 =3D usb9pfs_attrs,
>>>>+=A0=A0=A0 .ct_owner=A0=A0=A0 =3D THIS_MODULE,
>>>>+};
>>>>+
>>>>+static struct f_usb9pfs_dev *_usb9pfs_do_find_dev(const char *tag)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *usb9pfs_dev;
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *tmp;
>>>>+
>>>>+=A0=A0=A0 if (!tag)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>+
>>>>+=A0=A0=A0 list_for_each_entry_safe(usb9pfs_dev, tmp,=20
>>>>&usbg_instance_list, usb9pfs_instance) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 if (strcmp(usb9pfs_dev->tag, tag) =3D=3D 0)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return usb9pfs_dev;
>>>>+=A0=A0=A0 }
>>>>+
>>>>+=A0=A0=A0 return NULL;
>>>>+}
>>>>+
>>>>+static int usb9pfs_tag_instance(struct f_usb9pfs_dev *dev, const char =
*tag)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *existing;
>>>>+=A0=A0=A0 int ret =3D 0;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&usb9pfs_lock);
>>>>+=A0=A0=A0 existing =3D _usb9pfs_do_find_dev(tag);
>>>>+=A0=A0=A0 if (!existing)
>>>>+=A0=A0=A0=A0=A0=A0=A0 strscpy(dev->tag, tag, ARRAY_SIZE(dev->tag));
>>>>+=A0=A0=A0 else if (existing !=3D dev)
>>>>+=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
>>>>+=A0=A0=A0 mutex_unlock(&usb9pfs_lock);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static int usb9pfs_set_inst_tag(struct usb_function_instance=20
>>>>*fi, const char *tag)
>>>>+{
>>>>+=A0=A0=A0 if (strlen(tag) >=3D sizeof_field(struct f_usb9pfs_dev, tag))
>>>>+=A0=A0=A0=A0=A0=A0=A0 return -ENAMETOOLONG;
>>>>+=A0=A0=A0 return usb9pfs_tag_instance(fi_to_f_usb9pfs_opts(fi)->dev, t=
ag);
>>>>+}
>>>>+
>>>>+static void usb9pfs_free_instance(struct usb_function_instance *fi)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *usb9pfs_opts;
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts =3D container_of(fi, struct f_usb9pfs_opts, fun=
c_inst);
>>>>+=A0=A0=A0 kfree(usb9pfs_opts);
>>>>+}
>>>>+
>>>>+static struct usb_function_instance *usb9pfs_alloc_instance(void)
>>>>+{
>>>>+=A0=A0=A0 struct f_usb9pfs_opts *usb9pfs_opts;
>>>>+=A0=A0=A0 struct f_usb9pfs_dev *dev;
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts =3D kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
>>>>+=A0=A0=A0 if (!usb9pfs_opts)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(-ENOMEM);
>>>>+
>>>>+=A0=A0=A0 mutex_init(&usb9pfs_opts->lock);
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts->func_inst.set_inst_name =3D usb9pfs_set_inst_t=
ag;
>>>>+=A0=A0=A0 usb9pfs_opts->func_inst.free_func_inst =3D usb9pfs_free_inst=
ance;
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts->buflen =3D DEFAULT_BUFLEN;
>>>>+
>>>>+=A0=A0=A0 mutex_lock(&usb9pfs_lock);
>>>>+=A0=A0=A0 dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>>>>+=A0=A0=A0 if (IS_ERR(dev)) {
>>>>+=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&usb9pfs_lock);
>>>>+=A0=A0=A0=A0=A0=A0=A0 kfree(usb9pfs_opts);
>>>>+=A0=A0=A0=A0=A0=A0=A0 return ERR_CAST(dev);
>>>>+=A0=A0=A0 }
>>>>+=A0=A0=A0 list_add_tail(&dev->usb9pfs_instance, &usbg_instance_list);
>>>>+=A0=A0=A0 mutex_unlock(&usb9pfs_lock);
>>>>+
>>>>+=A0=A0=A0 usb9pfs_opts->dev =3D dev;
>>>>+=A0=A0=A0 dev->opts =3D usb9pfs_opts;
>>>>+
>>>>+=A0=A0=A0 config_group_init_type_name(&usb9pfs_opts->func_inst.group, =
"",
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &usb9pfs_fun=
c_type);
>>>>+
>>>>+=A0=A0=A0 return &usb9pfs_opts->func_inst;
>>>>+}
>>>>+DECLARE_USB_FUNCTION(usb9pfs, usb9pfs_alloc_instance, usb9pfs_alloc);
>>>>+
>>>>+static int __init usb9pfs_modinit(void)
>>>>+{
>>>>+=A0=A0=A0 int ret;
>>>>+
>>>>+=A0=A0=A0 INIT_LIST_HEAD(&usbg_instance_list);
>>>>+
>>>>+=A0=A0=A0 ret =3D usb_function_register(&usb9pfsusb_func);
>>>>+=A0=A0=A0 if (!ret)
>>>>+=A0=A0=A0=A0=A0=A0=A0 v9fs_register_trans(&p9_usbg_trans);
>>>>+
>>>>+=A0=A0=A0 return ret;
>>>>+}
>>>>+
>>>>+static void __exit usb9pfs_modexit(void)
>>>>+{
>>>>+=A0=A0=A0 usb_function_unregister(&usb9pfsusb_func);
>>>>+=A0=A0=A0 v9fs_unregister_trans(&p9_usbg_trans);
>>>>+}
>>>>+
>>>>+module_init(usb9pfs_modinit);
>>>>+module_exit(usb9pfs_modexit);
>>>>+
>>>>+MODULE_ALIAS_9P("usbg");
>>>>+MODULE_LICENSE("GPL");
>>>>+MODULE_DESCRIPTION("USB gadget 9pfs transport");
>>>>+MODULE_AUTHOR("Michael Grzeschik");
>>>>
>>>
>>>
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--CXYm3VvaaUbdovYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZVaeoACgkQC+njFXoe
LGQjfRAAyxXw9TjhhwVJP8cw05wJ+3XEpJPBnO8wC0su+1QDdFPzUWU5JmPMbScx
FjmYXD9JyLY+TzrR3aUe6LwKwYb4MU27pVqm645JLETgujF+F0PDY27rpeJgpDU1
ni71a189SoUiuZ6wTEkgCDtlStINVNYlwsUzeSllQ5b54QWlxK35LByqwe9E5+7x
ByBs7Qn9xCNsDnjbuBmU4LFwZyA8MQVeCqapURXVrWbScrWebi5/KB0o07pqVba+
JZ6M83nDzPoSB1cNT/x8+xg6COLz6vDsk8SUdqmlbwud3EwznNw/1ZPqYJPeymLl
ObXf29lUoI7EfYq0pCQDlILBjbMpQH6+chEcgTGC+20/cEZPH+NHF8QejFiRNsOU
/XwnC4ugG7RRsN6B1rIuhqOdrfYxQdbCY3F/P1uCFr2ilZd/RsJDCC5ML8rLl7Wy
HBEfFr6kE4g8JUlTkyirXxeMUJhd4Anp4SN6JcNFUg2N7pTFynbdzjXb+hHakUnD
zkXMmAVRUTdg6+KNuBTnibnGc3Q/BVruXY9sRRp9yhRp+Od28+eUzH6erlMpeYqz
yoEjGawTsSd3Bx4XVB4cVwymkzq38rCAlxQhZdrtX3tV0l7JeR4gTWBtkH8TCtvw
5QE7DF7pMLk+KHmVTatQuDeUBnDzynSDnzg77yAqiI2y/Zm1RkE=
=XFfS
-----END PGP SIGNATURE-----

--CXYm3VvaaUbdovYY--
