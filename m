Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAF37B3ED
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912981; cv=none; b=o+sV0GursF6iZ5Z20oGGR4ctxuszl1n/75W75HKhTmh/RHrjnAo6+y8uvL2oc+WHO7lE1fFPIV8Z/HbI/N1xY9Tj0X/ZfZYJryZT1ZVQsKXFmTQk/tytlWXnqDmr/Xvl0OsIPmuF85mh980XB2RqSO/xYK+4aREVs5ej9hwUIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912981; c=relaxed/simple;
	bh=Xq09yPRW6ohQAn07W4V0qGHQ9lBgXxpNslpiZG9nZXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKK/Xy0FP+FeEYaQ0cFhbGXVq8u+pO53sPX0aqFNtNO4Xx3sAwsSmEf9+PVzh8/E76PYsRPI27Xaj3gnrkLyv86AdmndOIE1qNpqKAdl++yl4any0D9s+JcZtGzv5J5OsOLdZMp4WE4o6T9jNRwxF2nxgw45BR2wzMVY+RThzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003O6-OP; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013De-0u;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0aKO;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:03 +0100
Subject: [PATCH 06/11] net/9p/usbg: add timeout for usbg_request
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-6-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Xq09yPRW6ohQAn07W4V0qGHQ9lBgXxpNslpiZG9nZXM=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OHh3WiaQwDjw4Vd68NNiRlTlCjlHK2JdGwC
 Zg/bZFkTdOJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhwAKCRC/aVhE+XH0
 q6caD/9wMuD9d4l9JyD2q2yYo0UKUHFrwx/ZZt75DsBO6XrvXU/L80gTojK9II0pfqXiFCmSiAq
 GCQLkLh73RCCGm+hq/K37lVywLxYaeGMTDmZy/3aeoeQ6DWkFz3P9sRA1vrUQ2/J8Cvy2ATmlO/
 ZN8+jOICtnhGvtPKE35J1W8HzMQmw4gFCpsaU8H6VAVz6NS1jWjKm0lf99tTFwT5QHTdbLnWI7a
 avhUycSGYIZQ4Vq1jOsWZ47nXUdbjjSTTVlsGfHBa3DlrAGTTGXzPKpaziXf24lDc9pbxzZdJug
 tSbiUTgBJkuge1YnLIacAdGerQYM50s3ZaEIxaG8EfEuyu1Iyy2CExuXttR2RR+nqQYU6Exk2cE
 rBx47tftR3J9XzBBudclq/s18ipIwC/yVJkJFAGQi+In8fGG+jdHiaBHOA4hI6UuapSyq5gMgEA
 0DD8DKMYuVCgHN1Dwmysnm1bUU935XbEpwP+UjMB7Vf6LUHZl8uVqJd+m9uM+eX0KkKFpRKjyMe
 f2hpOoObORizpFoTE3/TvOGV3pEf/Lzoz+S3VK436eedFF+rQLLHhnrKF5P+pf7c25cPeJcOK6b
 gULzl6dKYBWFRGoI0k9MXSTUs7OWdTqblQ2+p8J/SIoF0L5+CF8lNB8m/c9OmRABKZPkM4FMcqt
 mG4KW3O/ik132HA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Move to wait_for_completion_killable_timeout to ensure that
a pending mount will not hang in there forever. If the host side is not
available after some time, the pending mount will come back with
-ETIMEDOUT.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 472f7452794d7ac0f7b1475f0da2f4605a28e062..c764e06ad4bf7ef7266160b06063a4a98226649c 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -502,14 +502,21 @@ static void p9_usbg_close(struct p9_client *client)
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
 {
 	struct f_usb9pfs *usb9pfs = client->trans;
+	struct usb_composite_dev *cdev =
+		usb9pfs->function.config->cdev;
 	int ret;
 
 	if (client->status != Connected)
 		return -EBUSY;
 
-	ret = wait_for_completion_killable(&usb9pfs->send);
-	if (ret)
+	ret = wait_for_completion_killable_timeout(&usb9pfs->send, HZ * 10);
+	if (ret < 0)
 		return ret;
+	if (!ret) {
+		dev_err(&cdev->gadget->dev,
+			"timeout while transferring 9p via usb\n");
+		return -ETIMEDOUT;
+	}
 
 	ret = usb9pfs_transmit(usb9pfs, p9_req);
 	if (ret)

-- 
2.47.3

