Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3B3CAE7D
	for <v9fs@lists.linux.dev>; Fri, 13 Mar 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422242; cv=none; b=GSQ48JRmfHR5S7VQB1vp8hK7/ck96DXnlChav4xVFCY/JZQ/REY8vCXEu5E6bBlCoOyHsz7sHKK1Ttx/a3emTWXdU5tYW313e5VSUfYJ17vxJGV9rzHJnDueG+jUrtX5heHxJVk78KD8dCaDzM7Jv0maFzeUU0TRgq3KbYByRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422242; c=relaxed/simple;
	bh=z9C/vbvIS5TY0XOjnQzdtr2PoKMmOdHy1mekRGEFKvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQQKgmxXGx8/u92xMXFegjiEVNSmDzyM/WFR8/Ir2l5c3O96muGIzeMt4JEpaNgEEiHVWXMBYfwNoD0/d6lzRuaZxqCUl86qd9d6qlsu2bRl5/Wrmbvto1EvJbBcFku7rwSOfcY4atUIySgHdpwdnBJ+bMjLW/Y91Ui97nyIKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhHxC00N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhHxC00N"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so2275344b3a.3
        for <v9fs@lists.linux.dev>; Fri, 13 Mar 2026 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773422240; x=1774027040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWzkTz+o6MJ580k/Lw2tM48DPyYfCvZ1bzdyNrOoVFg=;
        b=mhHxC00NDxHtyv4wtDOgSmUoMBkMaaQQALvQfPHh+9EhhLCCgBnAHT6cXY0O5BWU1l
         qx0RB75+f9yDMb25WBFKgA/kvfu/q/SzbQtU7YOW1AOZe/i+tWE6U+s5yzf3QMS4UsTF
         ONbXM724iJypNiEEXacfo4zt2uhPdLMsqHCKV6JcMs9QAJsu3uNGzkY6/e+KbKBGnqUN
         ohjkxkai7qC0vymYKfJf0s4Z07usGKqmj+Blb2v1Nccp1UVeUzYw+QxfBURyirzwwta1
         SLspJWvi8Gk2sSTFk6wSBMvjiBcfMddUzTymt7ky2cBDWmqMizuZ0UDjbykv5ORFwYXD
         v4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773422240; x=1774027040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWzkTz+o6MJ580k/Lw2tM48DPyYfCvZ1bzdyNrOoVFg=;
        b=kx2MQzxZue7fbWTPyrDieuylPYXfTzBZZ2KCBybGUviX1P7BR/S8cX9m8j6dTHSo9P
         pkTroDREW24XeFwDWfu4UQjiD55NOpQc0+fqfpHSX/tpa7l2gcw2GMg5aPJpP1JZgGHn
         BudKhCtDylG5mglXQAUiqfB35Z5retBI0cj1yPwbDYgTnl+1wq3lZb5Tf/Qn43FP8qHo
         rEoJmSCLSVOmx9ojSvyjRbJIlajbXcsG+q2K3BkZzxRsXHajhe/ZS5HmQqS6oGpVCFK7
         ODY7FDuq2aClh8bcH2EgFyWjx1CCwbswL+SQHXKoJIdSInFxwT2qBtsOEp9d6Q9bObNN
         ixRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrXgx0EP6tmZTHRFO3BLj2kmR6SrlhNoRWIiSZS9ezxTSX/NUbsonXRcR5WlVTZs71goy@lists.linux.dev
X-Gm-Message-State: AOJu0YyQAoly76Lg/wkrtHVU79zuhwX96Oz8rihYulej9zlhfp4hPItQ
	yesS8zgPrv0ZGIcyc7HVnYy8jhPUC+PmFygH1VIapeMkflI/BpAYezU9
X-Gm-Gg: ATEYQzxnTKJU0ik2gmKHr7OPksfS7MHIxx4dnyCOcGr5owf/NZMYnw/GIXhsl1m6Yzu
	WGClDQeoOI68AZD+fYWNzPQE9Ui8Rom3udc+vBa6rD1mPBS+Xh7YwzahbgQWJhUj3Y0XGYYpB8+
	fDP5nyo75AR93C2SAG1mBcnjXTm016goh50K9gnqibpCeyi/UgZE+dzZ8KZ27HivWC0PZhF5A/4
	OvfnGpi4cV+ZOAG6HnYUx7U7HxLJzFXjuRId2/9cDf0G/vdrtQ275kpna//mOIU2s+FxbkyO2ic
	7+5NFHFk7gQWqkGLEmkYZTpPpCSPz2+tYK1VskQ38ebVDlsbUiW+bCT0OPl74dSkQkAATvWdOcs
	8Nid2JjnUgX8dii0c9yl7JVi9SRXu/JaKOI6BSMDyPyhJKKoX8wo5QbRPZQby8ZqPKI+DILQY1Z
	yzWRyFimEmMvA70e1FNcOsgCpqs3noUCA=
X-Received: by 2002:a05:6a00:9081:b0:827:3f01:d1ca with SMTP id d2e1a72fcca58-82a196d2facmr3485382b3a.4.1773422240081;
        Fri, 13 Mar 2026 10:17:20 -0700 (PDT)
Received: from JooHJ-PC.localdomain ([121.65.54.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727f2fcsm6330485b3a.28.2026.03.13.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:17:19 -0700 (PDT)
From: Hyungjung Joo <jhj140711@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	m.grzeschik@pengutronix.de,
	gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyungjung Joo <jhj140711@gmail.com>
Subject: [PATCH] net: 9p: usbg: clear stale client pointer on close
Date: Sat, 14 Mar 2026 02:16:59 +0900
Message-Id: <20260313171659.1225180-1-jhj140711@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_usbg_close() tears down the client transport, but usb9pfs keeps
using usb9pfs->client from asynchronous TX and RX completion handlers.
A late completion can therefore dereference a client that has already
been freed during mount teardown.

Clear usb9pfs->client under usb9pfs->lock when closing the transport,
detach any pending TX request from in_req->context, and make the TX/RX
completion handlers bail out once the transport has been detached. This
keeps late completions from touching a freed or rebound p9_client.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
---
 net/9p/trans_usbg.c | 63 +++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c..3c2aa1943f93 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -149,7 +149,8 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
-	struct p9_req_t *p9_tx_req = req->context;
+	struct p9_client *client;
+	struct p9_req_t *p9_tx_req;
 	unsigned long flags;
 
 	/* reset zero packages */
@@ -165,18 +166,27 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 		ep->name, req->status, req->actual, req->length);
 
 	spin_lock_irqsave(&usb9pfs->lock, flags);
-	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+	client = usb9pfs->client;
+	p9_tx_req = req->context;
+	req->context = NULL;
 
-	p9_req_put(usb9pfs->client, p9_tx_req);
+	if (!client || !p9_tx_req) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
+		complete(&usb9pfs->send);
+		return;
+	}
 
-	req->context = NULL;
+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+
+	p9_req_put(client, p9_tx_req);
 
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->send);
 }
 
-static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
+					  struct p9_client *client, void *buf)
 {
 	struct p9_req_t *p9_rx_req;
 	struct p9_fcall	rc;
@@ -202,7 +212,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 "mux %p pkt: size: %d bytes tag: %d\n",
 		 usb9pfs, rc.size, rc.tag);
 
-	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
+	p9_rx_req = p9_tag_lookup(client, rc.tag);
 	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
@@ -212,7 +222,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
 			 rc.size, rc.tag, p9_rx_req->rc.capacity);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -220,7 +230,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "No recv fcall for tag %d (req %p), disconnecting!\n",
 			 rc.tag, p9_rx_req);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -231,8 +241,10 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	struct p9_client *client;
 	struct p9_req_t *p9_rx_req;
 	unsigned int req_size = req->actual;
+	unsigned long flags;
 	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
@@ -241,9 +253,16 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
-	if (!p9_rx_req)
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	if (!client) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
 		return;
+	}
+
+	p9_rx_req = usb9pfs_rx_header(usb9pfs, client, req->buf);
+	if (!p9_rx_req)
+		goto out_unlock;
 
 	if (req_size > p9_rx_req->rc.capacity) {
 		dev_err(&cdev->gadget->dev,
@@ -257,8 +276,11 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	p9_rx_req->rc.size = req_size;
 
-	p9_client_cb(usb9pfs->client, p9_rx_req, status);
-	p9_req_put(usb9pfs->client, p9_rx_req);
+	p9_client_cb(client, p9_rx_req, status);
+	p9_req_put(client, p9_rx_req);
+
+out_unlock:
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->received);
 }
@@ -416,7 +438,9 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 		client->status = Disconnected;
 	else
 		client->status = Connected;
+	spin_lock_irq(&usb9pfs->lock);
 	usb9pfs->client = client;
+	spin_unlock_irq(&usb9pfs->lock);
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
@@ -427,18 +451,25 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 
 static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 {
+	struct p9_client *client;
 	struct p9_req_t *req;
+	unsigned long flags;
 
-	guard(spinlock_irqsave)(&usb9pfs->lock);
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	usb9pfs->client = NULL;
+	req = usb9pfs->in_req ? usb9pfs->in_req->context : NULL;
+	if (usb9pfs->in_req)
+		usb9pfs->in_req->context = NULL;
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
-	req = usb9pfs->in_req->context;
-	if (!req)
+	if (!req || !client)
 		return;
 
 	if (!req->t_err)
 		req->t_err = -ECONNRESET;
 
-	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	p9_client_cb(client, req, REQ_STATUS_ERROR);
 }
 
 static void p9_usbg_close(struct p9_client *client)
-- 
2.34.1
