Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4F770ED
	for <v9fs@lists.linux.dev>; Sun, 29 Sep 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727637783; cv=none; b=XG6PINXiqVaSSiNyFgDW2TPfcjsFQEZDKBOusxKyefm2VAcDMBbDoegC4HYMSJ93j4PhC1zG3VbKQM5F/nPn46a4keDMoTx4rtsbsyODI2xLThbVHQilxyYeRRbYeJe6SXVUv212LDoVyYRto8/E8pdh/qlTHnvniUTeA+G9QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727637783; c=relaxed/simple;
	bh=L7mjGuTuTjqihi6ACzkDkfLo81I9/BYiSeA+V8+nmqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TszV+sYy1gWMPvPENSWSZZev59OBJNG2mn5moRB7B750GjKJLwdffwYs0HrgyWFZx/to2EDB35XB086OEdb20JeVQrGgT+pOTeHYfAdDgNCZUyhVYGLpK99Ce2F0YoR5JnLlUmP713KfpLDDXbbo60hgicJ+rlYj5/BkW+aFylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suzVR-0005Js-Me; Sun, 29 Sep 2024 21:22:57 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suzVQ-002SFV-Nd; Sun, 29 Sep 2024 21:22:56 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suzVQ-002EdD-2A;
	Sun, 29 Sep 2024 21:22:56 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 21:22:55 +0200
Subject: [PATCH] net/9p/usbg: dont call usb9pfs_clear_tx if client is not
 connected
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-fixes9p-v1-1-40000d94d836@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAA6p+WYC/x3KQQqAIBCF4avErJNKSrKrRAsnp5qNiQMRSHfPW
 v7vfRmEEpPAVGVIdLHwGUp0dQXr4cJOin1p0K3uW6ut2vgmsVEN3nQjIhlvEIpGJ6QwubAen/9
 ZY+N3xUR/ln1enucFZH/nW3QAAAA=
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=L7mjGuTuTjqihi6ACzkDkfLo81I9/BYiSeA+V8+nmqQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+akQflDQxctyPd1jgK+LgafzXC35sy/dS9k/Y
 /1yLCGTak+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmpEAAKCRC/aVhE+XH0
 q0wIEACAhZdYrodVxhcqNZFb267ESH5exofxgfnqpWCbpHmYVjyBzt42uiEH2dA2+J2uVgaLZW/
 al+6YbKo3c8+5OgusNLioELTiKmkqPSxs6XDoZ9rFCtsXlWXbO8AtSiZJ+MitkcXtdLeVfqxbCY
 BEy1DpHRwx2zTusd1vKEueKWlR+FkUeKiHAVvnO+e1TkjgUfpS6hlMiuALlVMNQ+wc1QXV23WuZ
 A13H903kxDsD4UuHQcxkZ2yw27lXzF3MRdm0+rf520Tb7/y/PLLCoiE2RvkmmbtkbfrlKI6NYRi
 x7NKJMNGpdRAjx7LJhKwnFv9kM8YVRapVCXWs4qERrcIAsRAJq50v9cKK4RyncCYudr7hnNTuCB
 ssgKPkXOXu/IOkfb1bcmAdMu+nxaXM4wlT3unfx9opPywSWfRQLPgKmNfVCYFSa2wUrH47ChNPi
 L70GWMXWK36zrRnX7QhP7osmIEVZPc80sGpvkaZK2N3VD1a3dN8M9otCirOpiFIPU9SgtLYvecD
 9ZUqS6+dafCZhygXGNK3qKYOdYVYiorOdP2tfYCdrtcgB6n5pjitab+7aOeAmfRUUWsqj4XQ/r7
 fsU3JQo7ZM4P19U4c9sUoA7oY5CwJfZhXNla5M53/c5/tyIImPtSoHacDudzCnLt7kgsDaCvfnT
 vJb2SXCNBq/zumw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

When the client is not Connected it is not valid to call
usb9pfs_clear_tx since the endpoints are not even allocated. By running
into p9_usbg_close in that case we would dereference the in_req which is
NULL when the client->status is Disconnected. Fix that by leaving
usb9pfs_clear_tx immediately if the state is wrong.

We also update the client->status after the for usb9pfs_clear_tx to
check for the actual state when running from p9_usbg_close.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 975b76839dca1..64a5209943dbc 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -417,6 +417,10 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 {
 	struct p9_req_t *req;
 
+	/* we are not allocated - return */
+	if (usb9pfs->client->status != Connected)
+		return;
+
 	guard(spinlock_irqsave)(&usb9pfs->lock);
 
 	req = usb9pfs->in_req->context;
@@ -442,10 +446,10 @@ static void p9_usbg_close(struct p9_client *client)
 	if (!usb9pfs)
 		return;
 
-	client->status = Disconnected;
-
 	usb9pfs_clear_tx(usb9pfs);
 
+	client->status = Disconnected;
+
 	opts = container_of(usb9pfs->function.fi,
 			    struct f_usb9pfs_opts, func_inst);
 

---
base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
change-id: 20240929-fixes9p-5d618bbe6d6b

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

