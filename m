Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CE14036E
	for <v9fs@lists.linux.dev>; Fri, 23 Aug 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398628; cv=none; b=RfU+RiZqORv+TqQ5gNrEqh8SmD1oqzjZKTHpPKI9N1iDZsdZgK4jLyUPjY4Uxl58W9SXlN/UhPQtue3/KFDO0eDp6W3/Z3ZrnqFKjniTDZtQTozM0gjzB1bEn6seQuw/E4gR2kJrFx4a8u8U7PAxXU2/apmz0zIInwT1TXhIVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398628; c=relaxed/simple;
	bh=9eBMCKlGTwUhw3wmdfPekwCyagi2vE6PHh1pfEDUoEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejO+R6zmRYCE1LxHvwNDY53ouu+xJEkuaHltDUF9+/+naxIgJ4RF8eZItNwSCjA+awd7JSmes6pYi5dW+OAnTkwdHMu9U08TG1D6uCgy3MWexWlAysIczUbjyzj8NQdtgLPZlduShmY2xNgoLBtWxIafEs+lFezAMsmx/HDMXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1shOqr-0004KV-Kz; Fri, 23 Aug 2024 09:36:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1shOqn-002R4M-60; Fri, 23 Aug 2024 09:36:49 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1shOqn-00AtQT-0K;
	Fri, 23 Aug 2024 09:36:49 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 23 Aug 2024 09:36:47 +0200
Subject: [PATCH v9 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v9-1-93d73f47b76b@pengutronix.de>
References: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, v9fs@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, kernel@pengutronix.de, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5304;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=9eBMCKlGTwUhw3wmdfPekwCyagi2vE6PHh1pfEDUoEQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmyDwQwmCl6t0rNTyax+t+0x2mr1x30jFatJmMp
 6Fi9G/tT1OJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZsg8EAAKCRC/aVhE+XH0
 qxbyD/0RiX3j17QGqddXoukA8lqwuM9DOmsEobozr+uST+WVylml4NCpN6R5TMBRUal5gKVB8dw
 693u+T1pGfJSgLp9eZteNwOqe7/mpv+69WtfMg0YOSU0gkTL3GuCF/LwtsVRnoDdzTmnUVKDLSv
 vZvrRdz1MSAf7X2Dpr+lhmQ9ruPwAH82IjGSqQcrNrQJyus5t4Watuq/apqlgq4fFU3wlwAqfMe
 YUFyb/UCBWaUYA9E+QY/Rj4RUqLbOmCs9BuzdhxU/vwnmpp5c/NBJtGse3/9qghlusLUQC0vpYV
 XT2CtwK/Zlhm0Gzrukc4WyiH1fNuFVs82LKd2DogZH/YD+G3qhLSfQoNRpgVn6AF4lom9iBglkJ
 w79Kt7BU+XYEnT29maFgzqgUw1gFr5RccQZkPjWKXi5jV2mi6d6TGScG4mbK1opgoPTMfXbkyRr
 xVYrl2v+Go7DiBiLRS+pQ7TCCy3ycARnuDuOKnine3t70sX//SGmjBUjGzU2YvzvupIE+KVNVVV
 FZ9JBZIqjJMsHjWKt1uDk1nxgXEyqyF9PhnsNQgHybJilAzH9hZzJd24z2Zu2yQPbc+c/aj6Xjl
 5KIFZtvxXvNDUuQziHiURR4vQzsuiti/e+K2DrNd5X47F7YLb4be1cX9R1exIBXlRRIRmswSaWX
 jcdIeVED9oT9Yvw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

We move the func_utils.h header to include/linux/usb to be
able to compile function drivers outside of the
drivers/usb/gadget/function directory.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v8 -> v9: -
v7 -> v8: -
v6 -> v7: -
v5 -> v6: -
v4 -> v5:
  - renamed to func_utils.h
v3 -> v4: -
v2 -> v3: -
v1 -> v2:
  - new introduced patch
---
 drivers/usb/gadget/configfs.c                              | 2 +-
 drivers/usb/gadget/function/f_fs.c                         | 2 +-
 drivers/usb/gadget/function/f_hid.c                        | 2 +-
 drivers/usb/gadget/function/f_loopback.c                   | 2 +-
 drivers/usb/gadget/function/f_midi.c                       | 2 +-
 drivers/usb/gadget/function/f_midi2.c                      | 2 +-
 drivers/usb/gadget/function/f_sourcesink.c                 | 2 +-
 drivers/usb/gadget/u_f.c                                   | 2 +-
 drivers/usb/gadget/u_f.h => include/linux/usb/func_utils.h | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 0e7c1e947c0a0..0f8553795a8ed 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -8,8 +8,8 @@
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
 #include <linux/usb/webusb.h>
+#include <linux/usb/func_utils.h>
 #include "configfs.h"
-#include "u_f.h"
 #include "u_os_desc.h"
 
 int check_user_usb_string(const char *name,
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e0ceaa7219493..411f0273d8d44 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -33,6 +33,7 @@
 #include <linux/usb/ccid.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/functionfs.h>
+#include <linux/usb/func_utils.h>
 
 #include <linux/aio.h>
 #include <linux/kthread.h>
@@ -40,7 +41,6 @@
 #include <linux/eventfd.h>
 
 #include "u_fs.h"
-#include "u_f.h"
 #include "u_os_desc.h"
 #include "configfs.h"
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 93dae017ae456..1293d8db07f6c 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -16,8 +16,8 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/usb/g_hid.h>
+#include <linux/usb/func_utils.h>
 
-#include "u_f.h"
 #include "u_hid.h"
 
 #define HIDG_MINORS	4
diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index 979b028edb99e..49b009a7d5d79 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -14,9 +14,9 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/usb/composite.h>
+#include <linux/usb/func_utils.h>
 
 #include "g_zero.h"
-#include "u_f.h"
 
 /*
  * LOOPBACK FUNCTION ... a testing vehicle for USB peripherals,
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 67052a664e746..1d7a955e990b4 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -33,8 +33,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi.h>
+#include <linux/usb/func_utils.h>
 
-#include "u_f.h"
 #include "u_midi.h"
 
 MODULE_AUTHOR("Ben Williamson");
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 3f63253ad3e07..3edc32c0e0983 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -18,8 +18,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi-v2.h>
+#include <linux/usb/func_utils.h>
 
-#include "u_f.h"
 #include "u_midi2.h"
 
 struct f_midi2;
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 6f3702210450f..ec5fd25020fdb 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -13,10 +13,10 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/usb/composite.h>
+#include <linux/usb/func_utils.h>
 #include <linux/err.h>
 
 #include "g_zero.h"
-#include "u_f.h"
 
 /*
  * SOURCE/SINK FUNCTION ... a primary testing vehicle for USB peripheral
diff --git a/drivers/usb/gadget/u_f.c b/drivers/usb/gadget/u_f.c
index 6aea1ecb39999..9f90665827945 100644
--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -8,7 +8,7 @@
  * Author: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  */
 
-#include "u_f.h"
+#include <linux/usb/func_utils.h>
 #include <linux/usb/ch9.h>
 
 struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len)
diff --git a/drivers/usb/gadget/u_f.h b/include/linux/usb/func_utils.h
similarity index 99%
rename from drivers/usb/gadget/u_f.h
rename to include/linux/usb/func_utils.h
index e313c3b8dcb19..9f2a32c765260 100644
--- a/drivers/usb/gadget/u_f.h
+++ b/include/linux/usb/func_utils.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * u_f.h
+ * usbf_utils.h
  *
  * Utility definitions for USB functions
  *

-- 
2.39.2

