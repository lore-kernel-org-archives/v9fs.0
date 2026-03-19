Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33F3B895E
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912985; cv=none; b=kBoEITHH8CAvlzgmsVral7ZjXf6m7ujSFV/e5LeRTXRc5Nz+XcQz8hMXhh9X/7h9NZJDArcNIcFLxmY/uM8x01NKrsB8Ipmm8MWbwA02U8WnAX0xQdNy4oUeCXcsOVYx6Nv0Aef1SonY+mwlvahpBR1a9cbWLUhf12xvGwNshkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912985; c=relaxed/simple;
	bh=iOsjrh+7fT7eBiA8uBPw6vm41mDYgIncXBJx75Kg3PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX27sntfhfzjzVeoTR7e8/GRTwkJtglUcBdb7ScBL80ZhRxjH/1/cdLdh6pcZBA9VTC/mMIVknAInwuV7kNR+JSViquc7bU4ssZ9u2Q5vsMcFro0ccY0CQbHcfr3YjAOu+pXVCOIHAX4/sg5sGl3gKhYUqxvN591ctGFbH7CGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003O7-OP; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013DZ-0u;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0Xqh;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:35:59 +0100
Subject: [PATCH 02/11] net/9p/usbg: also disable endpoints on p9_usbg_close
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-2-c977a7433185@pengutronix.de>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=iOsjrh+7fT7eBiA8uBPw6vm41mDYgIncXBJx75Kg3PI=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OF8S1QKoQ23PyuWNvolvuq74l/AtJHo+WwI
 fNs7nHMUByJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhQAKCRC/aVhE+XH0
 q4iREACd4nb0rMWY8R5eaXv7LBnyJDWi9VS6cbJAqTyB1Wr0Ec3rEN258gDb2ZJMkJywVQPXzcE
 EnvcLhDxd/aKSVpri7IV+MRGRInshl84WhMC4xTQBfBkO0ay1MGCktnHRVzuqOO1NrgTeodeNpQ
 zT3qi1M4ECekponmuGekhyZvA8tcJqLic2M35mOH9gPrVK6F8rDwrcdCgX4Fjiipyk79gV0Z6ND
 dntC3ZhpyOpOb0Em+s8nrEtS/wbyoJlHCNawwXMKmW0Y1YNVKE9pKkmuE2UvE8otJ7qokcfx+7M
 DfF8/Iei5gDhfscxCPt9NL/vVrzCA5i/BdCNXSFvMD7MAD9irQEeP3GaPgZiAtuc/sq9gjbnkyD
 pP7a7lj6q+bnxfI38Dhi8s99lGVyaa8srDX6USLpFitG97EgFGn1PensrMBJJKqCuKQzuMTVuN+
 t9dk5YC4GRYl5Wq5eAwcLr2dIlkZ8Pi6UU6iA3XXobzs29C3/yMbA/EQGuOp6Irgt0fI6hyjITR
 jDnyEHo8kpG3d9ickOR4J2ahV0JEWfQ1oWGYkoqa3H+zF5XLZQjwBo1hgnRs+i6a0/pjzVCUn8X
 td0rRCspT304sUd3akU1YkPun/7RL5FIqPV3uSIYde3LpTtQQBADaIeWhhi78ypbHxJcL0MQ5M+
 YKVTFbYhOlcR3qw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

The close function has to fully reverse the state change of 9p_create
(mount) and the potential call of set_alt(1). This includes to ensure
that the usage of the endpoints is not active any more.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index f7a94572013e7d1015d75fb5dbdde5eb81f7d7d0..fb05198dc2a7d604cfad2db26a63e40e632651a2 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -495,6 +495,8 @@ static void p9_usbg_close(struct p9_client *client)
 	mutex_lock(&usb9pfs_lock);
 	dev->inuse = false;
 	mutex_unlock(&usb9pfs_lock);
+
+	disable_usb9pfs(usb9pfs);
 }
 
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)

-- 
2.47.3

