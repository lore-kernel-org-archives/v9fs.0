Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F103B8BA5
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912987; cv=none; b=azWfQEyIpn/UbZjcExb4J+qL/p1icBmtaDTWOJgoXZerZRX/FtJsS7NWLb1YCCBz5tiMpPwb9e/qoJRDiqmGRbhN+5eT1T66pVVivvmAzjzMwOf8ianohm+IFfw1Khs9tFuLH1zYJdKAmyXwuGQcCtj9q/GXZWgMiLDk+mE4n7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912987; c=relaxed/simple;
	bh=D48QkosbP3dN6C+gVRCxkYXxDKA7n5rlntVO57LmSiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwPmpa9vHEVFn+HO3t5zOCF9qL01Rbk/zaHJzqw7J+1MwOjidq0CYat3zgPsLAi+W+COkj1eWt2n8VClWI6W9VqNPknBCrHO0Du30+x9Gjcb4ph5o7vD8JLzNtSYzhOsZMJqhO0myn7eAC2EYt8dHWXyadq2X4B9lHYL0rle3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OF-OQ; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Dg-0z;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0b49;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:04 +0100
Subject: [PATCH 07/11] net/9p/usbg: add extra interface for status change
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-7-c977a7433185@pengutronix.de>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9584;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=D48QkosbP3dN6C+gVRCxkYXxDKA7n5rlntVO57LmSiw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OHjv6o5kvErDrP+cdn31qoZGCFdANLpa7v9
 pCDd14fZaCJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhwAKCRC/aVhE+XH0
 q77wEACIGiYa06Ac1ocsjNtJEy61cRg3r0y3eKlwQRsXbpbm/vcOkgPpDayWuaTFNK2KNksdFHh
 E/O9wjTHbiljH3EO9wTzjxqRQ/vS2C8K/mxzgLUbgLOGVZTVhFXwzWi25i+UvlW07gX1ZT3t3j1
 bXelE6qX69TcUnfVzAbuvQ6s/nLWziUeHRT2ZqJiEYlc15fqtZI7u/KlLnQLzB5TokY18Ct0Hor
 cKcZ1xq0IzvZGGDBM9rBvhQIcd6HpyjQRL3roIyPjLHTruOFVRXUOWcISShiQHwGtz5ATKLIlwE
 vyeeJOU094XXgdUTuHyZ8H5La8duQXiwn44HSrurzMAvwjyn45SBA4LA7+hcy8da7yQjs8ohgMJ
 t9A4J2vgN5wZfbHdf4TVAEf4WLgobAc4PwfGAvYFaL7ALStb7yrM4Og+7leywR9X6R02070YfeK
 KCfhQ6KY/DpBpXuLA9AN/2FzQsoR59KKPDUOdvjtK+4Vq7Sj78m9sKtJK1YnUIN1kZjueDvgkOw
 8QFuKvp0u35yw+MOZRym5TxtS+xJ42eAmsBggp0OmJNrQQgn48ei/zDnCln1PJt7VscDzyHaWwg
 8wXu+jyhx+sPHmr+6+3wZxuAnPNAg/WK6kMsaw4OY6IDrBNS0nNpVFde8AaQHRNXjb6rqiDjFSB
 bCtAjvKWxgNwNzQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

In the current implementation of the trans_usbg the status "connected",
when all components are ready to transfer, is not well chosen.

For now the 9p_usbg_create function looks if the in_ep is enabled, if
not, it sets the 9p as disconnected. On the other side when the set_alt
function calls ep_enable it checks if usbg_create was already called and
client is set, if so it then sets the client as connected.

With the Disconnected 9pfs layer a mount would always fail. However,
after the set_alt to 0, the mount would still fail. Since it is unsure
if there is actually something running to transfer data. For this
constraint to overcome, the trans_usbg is working with an completion in
the p9_usbg_request callback.

This has many limitations, since from the usb perspective it is true
that the wire connection is triggering the initial set_alt to 0 and
therefor can tell the 9pfs protocol that the instance now is physically
connected. This still does not tell anything about the connection and
availability of the 9pfs transport that is providing the protocol over
the usb.

To solve this issue, this patch is adding an extra interface, that
actually is containing the endpoints which will transfer the data in an
separate alt mode. This is likewise to other standards as e.g. the ncm
gadget.

The 9p transport host, that will make the 9pfs protocol available over
the two endpoints will then have to call set_alt(1) on this data
interface.

With this approach the gadget has the proper status change and
knows when to expect to receive data via the endpoints.

- don't allow set_alt when client is not ready

Avoid letting the endpoints to be enabled, when the client is not yet
prepared.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 119 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 18 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index c764e06ad4bf7ef7266160b06063a4a98226649c..5c954749ddba23d03eed85b9f9f94add9c5f9bf4 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -40,6 +40,7 @@
 struct f_usb9pfs {
 	struct p9_client *client;
 
+	u8 ctrl_id, data_id;
 	/* 9p request lock for en/dequeue */
 	spinlock_t lock;
 
@@ -85,6 +86,12 @@ struct f_usb9pfs_dev {
 	struct list_head usb9pfs_instance;
 };
 
+static inline struct f_usb9pfs_dev *usb9pfs_to_usb9pfs_dev(struct f_usb9pfs *usb9pfs)
+{
+	return container_of(usb9pfs->function.fi,
+			    struct f_usb9pfs_opts, func_inst)->dev;
+}
+
 static DEFINE_MUTEX(usb9pfs_lock);
 static struct list_head usbg_instance_list;
 
@@ -364,9 +371,11 @@ static int enable_endpoint(struct usb_composite_dev *cdev,
 }
 
 static int
-enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
+enable_usb9pfs(struct f_usb9pfs *usb9pfs)
 {
-	struct p9_client *client;
+	struct usb_composite_dev *cdev =
+		usb9pfs->function.config->cdev;
+
 	int ret = 0;
 
 	ret = enable_endpoint(cdev, usb9pfs, usb9pfs->in_ep);
@@ -381,10 +390,6 @@ enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
 	if (ret)
 		goto disable_out;
 
-	client = usb9pfs->client;
-	if (client)
-		client->status = Connected;
-
 	dev_dbg(&cdev->gadget->dev, "%s enabled\n", usb9pfs->function.name);
 	return 0;
 
@@ -431,17 +436,13 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 		return -EINVAL;
 
 	client->trans = (void *)usb9pfs;
-	if (!usb9pfs->in_req)
-		client->status = Disconnected;
-	else
-		client->status = Connected;
+	client->status = Connected;
 	spin_lock_irq(&usb9pfs->lock);
 	usb9pfs->client = client;
 	spin_unlock_irq(&usb9pfs->lock);
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
-	complete(&usb9pfs->send);
 
 	return 0;
 }
@@ -563,7 +564,7 @@ static struct usb_interface_descriptor usb9pfs_intf = {
 	.bLength =		sizeof(usb9pfs_intf),
 	.bDescriptorType =	USB_DT_INTERFACE,
 
-	.bNumEndpoints =	2,
+	.bNumEndpoints =	0,
 	.bInterfaceClass =	USB_CLASS_VENDOR_SPEC,
 	.bInterfaceSubClass =	USB_SUBCLASS_VENDOR_SPEC,
 	.bInterfaceProtocol =   USB_PROTOCOL_9PFS,
@@ -571,6 +572,36 @@ static struct usb_interface_descriptor usb9pfs_intf = {
 	/* .iInterface = DYNAMIC */
 };
 
+/* the default data interface has no endpoints ... */
+
+static struct usb_interface_descriptor usb9pfs_data_nop_intf = {
+	.bLength =		sizeof(usb9pfs_data_nop_intf),
+	.bDescriptorType =	USB_DT_INTERFACE,
+
+	.bInterfaceNumber =	1,
+	.bAlternateSetting =	0,
+	.bNumEndpoints =	0,
+	.bInterfaceClass =	USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass =	USB_SUBCLASS_VENDOR_SPEC,
+	.bInterfaceProtocol =   USB_PROTOCOL_9PFS,
+	/* .iInterface = DYNAMIC */
+};
+
+/* ... but the "real" data interface has two bulk endpoints */
+
+static struct usb_interface_descriptor usb9pfs_data_intf = {
+	.bLength =		sizeof(usb9pfs_data_intf),
+	.bDescriptorType =	USB_DT_INTERFACE,
+
+	.bInterfaceNumber =	1,
+	.bAlternateSetting =	1,
+	.bNumEndpoints =	2,
+	.bInterfaceClass =	USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass =	USB_SUBCLASS_VENDOR_SPEC,
+	.bInterfaceProtocol =   USB_PROTOCOL_9PFS,
+	/* .iInterface = DYNAMIC */
+};
+
 /* full speed support: */
 
 static struct usb_endpoint_descriptor fs_usb9pfs_source_desc = {
@@ -591,6 +622,8 @@ static struct usb_endpoint_descriptor fs_usb9pfs_sink_desc = {
 
 static struct usb_descriptor_header *fs_usb9pfs_descs[] = {
 	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_nop_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_intf,
 	(struct usb_descriptor_header *)&fs_usb9pfs_sink_desc,
 	(struct usb_descriptor_header *)&fs_usb9pfs_source_desc,
 	NULL,
@@ -616,6 +649,8 @@ static struct usb_endpoint_descriptor hs_usb9pfs_sink_desc = {
 
 static struct usb_descriptor_header *hs_usb9pfs_descs[] = {
 	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_nop_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_intf,
 	(struct usb_descriptor_header *)&hs_usb9pfs_source_desc,
 	(struct usb_descriptor_header *)&hs_usb9pfs_sink_desc,
 	NULL,
@@ -657,6 +692,8 @@ static struct usb_ss_ep_comp_descriptor ss_usb9pfs_sink_comp_desc = {
 
 static struct usb_descriptor_header *ss_usb9pfs_descs[] = {
 	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_nop_intf,
+	(struct usb_descriptor_header *)&usb9pfs_data_intf,
 	(struct usb_descriptor_header *)&ss_usb9pfs_source_desc,
 	(struct usb_descriptor_header *)&ss_usb9pfs_source_comp_desc,
 	(struct usb_descriptor_header *)&ss_usb9pfs_sink_desc,
@@ -666,7 +703,9 @@ static struct usb_descriptor_header *ss_usb9pfs_descs[] = {
 
 /* function-specific strings: */
 static struct usb_string strings_usb9pfs[] = {
-	[0].s = "usb9pfs input to output",
+	[0].s = "usb9pfs control",
+	[1].s = "usb9pfs nop",
+	[2].s = "usb9pfs data",
 	{  }			/* end of list */
 };
 
@@ -688,20 +727,34 @@ static int usb9pfs_func_bind(struct usb_configuration *c,
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
 	struct f_usb9pfs_opts *opts;
 	struct usb_composite_dev *cdev = c->cdev;
+	struct usb_string *us;
 	int ret;
 	int id;
 
+	us = usb_gstrings_attach(cdev, usb9pfs_strings,
+				 ARRAY_SIZE(strings_usb9pfs));
+	if (IS_ERR(us))
+		return PTR_ERR(us);
+
+	usb9pfs_intf.iInterface = us[0].id;
+	usb9pfs_data_nop_intf.iInterface = us[1].id;
+	usb9pfs_data_intf.iInterface = us[2].id;
+
 	/* allocate interface ID(s) */
 	id = usb_interface_id(c, f);
 	if (id < 0)
 		return id;
+
+	usb9pfs->ctrl_id = id;
 	usb9pfs_intf.bInterfaceNumber = id;
 
-	id = usb_string_id(cdev);
+	id = usb_interface_id(c, f);
 	if (id < 0)
 		return id;
-	strings_usb9pfs[0].id = id;
-	usb9pfs_intf.iInterface = id;
+
+	usb9pfs->data_id = id;
+	usb9pfs_data_nop_intf.bInterfaceNumber = id;
+	usb9pfs_data_intf.bInterfaceNumber = id;
 
 	/* allocate endpoints */
 	usb9pfs->in_ep = usb_ep_autoconfig(cdev->gadget,
@@ -775,9 +828,38 @@ static int usb9pfs_set_alt(struct usb_function *f,
 			   unsigned int intf, unsigned int alt)
 {
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
-	struct usb_composite_dev *cdev = f->config->cdev;
+	int ret;
+
+	if (!alt) {
+		if (intf == usb9pfs->data_id &&
+		    usb9pfs->in_ep->enabled)
+			disable_usb9pfs(usb9pfs);
+		return 0;
+	}
+
+	if (!usb9pfs->client || !usb9pfs_to_usb9pfs_dev(usb9pfs)->inuse)
+		return -EINVAL;
+
+	ret = enable_usb9pfs(usb9pfs);
+	if (ret)
+		return ret;
+
+	complete(&usb9pfs->send);
+
+	return 0;
+}
+
+/*
+ * Because the data interface supports multiple altsettings,
+ * this 9pfs function *MUST* implement a get_alt() method.
+ */
+static int usb9pfs_get_alt(struct usb_function *f, unsigned int intf)
+{
+	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
 
-	return enable_usb9pfs(cdev, usb9pfs);
+	if (intf == usb9pfs->ctrl_id)
+		return 0;
+	return usb9pfs->in_ep->enabled ? 1 : 0;
 }
 
 static void usb9pfs_disable(struct usb_function *f)
@@ -818,6 +900,7 @@ static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)
 	usb9pfs->function.bind = usb9pfs_func_bind;
 	usb9pfs->function.unbind = usb9pfs_func_unbind;
 	usb9pfs->function.set_alt = usb9pfs_set_alt;
+	usb9pfs->function.get_alt = usb9pfs_get_alt;
 	usb9pfs->function.disable = usb9pfs_disable;
 	usb9pfs->function.strings = usb9pfs_strings;
 

-- 
2.47.3

