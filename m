Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7903B8921
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912984; cv=none; b=Gk1h0YEqhSUurGvsqAVl4s1iRbGZX3kdYjqG0ee1yplpzOkBudpvpjTc6s1e9vD8CdiMGHjO58aOcRUbCtD5kN6LvzdPdyogGpQa7Hpta5OTkMDkWPH1J5nW+anK51vbeVxHGv+6TIowy980mXUmUnLZeCFv8w83Idy/zUDsZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912984; c=relaxed/simple;
	bh=wZ8kqff4Tn5aYGgU0or96rH1C5tq1zBPpMaQeLzDnK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlnId3VhPkod0ZrpQfWKPhejxlpQrMIeFwnFcVxTFT7PsZkLkcuCn4qXOtdjpCS2rAbEiBhIZCkDsBye8vrNXYskSNQU/xP1yybBBszPlLwT1Et15XkN73MYtsC98533MFtT2ABlkbdLzcMqc6kgj//OSAUgOb5ZfEXKbN8Lym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OB-OQ; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Df-0v;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0ZiI;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:02 +0100
Subject: [PATCH 05/11] net/9p/usbg: only rely on one completion
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-5-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=wZ8kqff4Tn5aYGgU0or96rH1C5tq1zBPpMaQeLzDnK8=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OGNztRgg/EXk9VNqRwfeW1udJUXzyrAXhWd
 VVpHetREjqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhgAKCRC/aVhE+XH0
 q+eGEACGg+snTyz1zkgO7P0fmYFjKVjwlnqUj2Qrj7zH12UfYUVhOJbTJR+OO2dng/1NI/Y7PST
 oWw5pu3zhKm3IDF+W5Ly4cQfRXX4vRvt7tNTwRTR4UiOIweavIi877a3wm5QMlKFAoDV0+QNniv
 0+csH68qj06ZabIwsGEQ7+NlBQ9WAp50g9cG2OJuvPOsy+F5tpRQNcVGn22SOusuttcsVsrfOxy
 QCDQMbq8ktM6KinH1wMYxVbmTFuLgQLKjuGKUEOB4K6j8zAuTKuOB6Mo1ePra6H1wiP1vyzpUGA
 FZsO3pdy2xYY2OLCj7b+rv5iy5DJ5GE8ll+5GtefmNoNbzfoU8LWwiQ5DuEVfJ39D1NRxXkj7W3
 yxPGmQ+eeSt4GWgBsqMFnb4/qJ9ilomR0zCVpHxwpfw+uMqiwkGgLDAC1xrEBqCO5+iYTZN/HDw
 0HmQPMwIcycv6EYG9Ilmj+oK99b++3L1TCzFsc3ulPNlUSWhOMJCT+eYdkSQkNom+uXev5mm6i/
 nPQAuglAhvbwjn3t9mDSlUOYFpcjCub3GNxHnzZWQBQEVnRnDpCsUSISbFsJWPSnTas5rkDAX+1
 5BG5YhWRFoo7PIAE3+EBvYuJerSh5QhnJGdn03NKOolFxbmfXJWz8umqp9ZriQFV4AaEtAQVSaK
 5YjXGaFt67q9ydQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

The 9pfs protocol is specified that each request is answered with one
response. Since there is only one pair of tx and rx requests for the usb
stack, the stack complete callback of the tx request can be used to
queue the response.

The current approach is using an extra completion barrier to ensure that
the tx complete callback came back, before enqueuing the rx request.
This all was done in the initial 9p_usbg_request callback of the 9pfs
protocol.

Moving the ep_queue of the rx request removes one extra completion
barrier and is less complex. Other than the complete this call has to be
guarded by the spinlock.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index d6391db6d5d96a1609a3405646f66d82c93d35f1..472f7452794d7ac0f7b1475f0da2f4605a28e062 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -50,7 +50,6 @@ struct f_usb9pfs {
 	struct usb_ep *out_ep;
 
 	struct completion send;
-	struct completion received;
 
 	unsigned int buflen;
 
@@ -180,7 +179,7 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 unlock_complete:
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
-	complete(&usb9pfs->send);
+	usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
 }
 
 static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
@@ -280,7 +279,7 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 out_unlock:
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
-	complete(&usb9pfs->received);
+	complete(&usb9pfs->send);
 }
 
 static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
@@ -442,7 +441,7 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
-	complete(&usb9pfs->received);
+	complete(&usb9pfs->send);
 
 	return 0;
 }
@@ -508,7 +507,7 @@ static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
 	if (client->status != Connected)
 		return -EBUSY;
 
-	ret = wait_for_completion_killable(&usb9pfs->received);
+	ret = wait_for_completion_killable(&usb9pfs->send);
 	if (ret)
 		return ret;
 
@@ -516,11 +515,8 @@ static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
 	if (ret)
 		return ret;
 
-	ret = wait_for_completion_killable(&usb9pfs->send);
-	if (ret)
-		return ret;
+	return 0;
 
-	return usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
 }
 
 static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
@@ -802,7 +798,6 @@ static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)
 	spin_lock_init(&usb9pfs->lock);
 
 	init_completion(&usb9pfs->send);
-	init_completion(&usb9pfs->received);
 
 	usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
 

-- 
2.47.3

