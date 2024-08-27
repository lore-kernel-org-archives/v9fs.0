Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5821C942C
	for <v9fs@lists.linux.dev>; Tue, 27 Aug 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791918; cv=none; b=ITPQm4U8sJ+prNwZsdBYAh8/xlcNQfWeZiUR5RuIZIDfPIekGIPi/GY5kiMmsx+PKzWfTyBLvku5MshICnBksm9r9GUrXMfUMlG/JIOdCxico2E8OWzD/AhNnL5weBikRHCQ+j/lKR2xg2H2nIBTakEintzrCfIzGP/uKsWlVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791918; c=relaxed/simple;
	bh=FhiYuMAttzKLPSgmu+aXcQP6ZavgO6GOLNGeyMVWLuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRDB03cAb4KHBfux4WceG80PwMdUXShZqC+MVpTtL2OM0IhrgMFZHlm/PtOcjMJ98jOzyPR8y5A5Wdn9jnRwr1BBNPr1RWFY59WFLLbhZLryDfTsv2Xq8rfeVMPGOhMAGTssoVJQAyUKxIYzud9Z1KB3vRn+HBjoWlFwvDfYMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sj3AK-0004aG-P7; Tue, 27 Aug 2024 22:51:48 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sj3AJ-003VwD-1p; Tue, 27 Aug 2024 22:51:47 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sj3AI-00Cxwt-1g;
	Tue, 27 Aug 2024 22:51:46 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 27 Aug 2024 22:51:41 +0200
Subject: [PATCH v11 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v11-1-b4890e06733a@pengutronix.de>
References: <20240116-ml-topic-u9p-v11-0-b4890e06733a@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v11-0-b4890e06733a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6088;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=FhiYuMAttzKLPSgmu+aXcQP6ZavgO6GOLNGeyMVWLuE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmzjxhu3okKyszVYOMCV2qvcdXncwYU8j/mbD2W
 HreWbNul4mJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZs48YQAKCRC/aVhE+XH0
 q3oPD/95qaxdBuKJnqkiI2QhYKYsO28DxGSuXI1nt0u9mW3Pmw7dfAJ+wFqMPqGg/qVQQuBoc82
 FYDrztLA49YZZd8brcSVFElNqXzlwaiP0SQA5+oEYBn2qDzJfHU0PNjlpgzbQynRVALXvvc6vTh
 9CLXIQqQw5jsRqw7hPxaxhZuVD3h0K9b7TjdW1ps5zCfD5pCkQ+Zvi37/wX9EE+840N12U735t0
 W7k1r/Uc7IOiMgm1jaZJ5Gtat2uSqZ4U+xAUEodjPcGVuCh4i8wHO7G3xU7O0F5GnwiCG5y59lR
 engT/a0n6kZpu+7HFHt43hJThy4Uz6Cyn+t6X9dPSLRBDK1ZvT2E/s2VpOlHOBps2dYr2yEqC40
 truIaICZ1OQN22DQ2RiFMSeZ+oO9u3ULOVO/9M7pRVtmRCa5M6m/76uEbd5TpOiFWL+z9GOTUSX
 6ox5vz05Zwy+52RY1RN9pHYJ7DHLQ7OV5n7pTSBHDcr/3fFiNNf/9rW2UXKXe5ln9xe9i/DuJiJ
 XVyHRcai+k76fH+Bf102saRX2pZ5FTbl1xB/cW0ihO1+YkwHi7KJQQOmG0KHSrtoDZLryxcPcFR
 ht6IUhV7ZcV3NSyAPu2OG0xf4XPriGg7P1gaIriv6iVSmb3WrmwTxoKqE+yohJexPyJ4RfsBqDF
 9CaAQVvTqGqsV/w==
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
v10 -> v11:
  - fixed the naming of the include guard in func_utils.h
v9  -> v10:
  - respect alphabetical order
  - correctly changed filename in func_utils.h itself
v5  -> v9: -
v4  -> v5:
  - renamed to func_utils.h
v3  -> v4: -
v1  -> v2:
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
 drivers/usb/gadget/u_f.h => include/linux/usb/func_utils.h | 8 ++++----
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 0e7c1e947c0a0..3b092078fc39a 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -6,10 +6,10 @@
 #include <linux/kstrtox.h>
 #include <linux/nls.h>
 #include <linux/usb/composite.h>
+#include <linux/usb/func_utils.h>
 #include <linux/usb/gadget_configfs.h>
 #include <linux/usb/webusb.h>
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
index 93dae017ae456..482bc88834151 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -15,9 +15,9 @@
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/usb/func_utils.h>
 #include <linux/usb/g_hid.h>
 
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
index 67052a664e746..1067847cc0799 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -30,11 +30,11 @@
 #include <sound/rawmidi.h>
 
 #include <linux/usb/ch9.h>
+#include <linux/usb/func_utils.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi.h>
 
-#include "u_f.h"
 #include "u_midi.h"
 
 MODULE_AUTHOR("Ben Williamson");
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 3f63253ad3e07..8285df9ed6fd7 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -15,11 +15,11 @@
 #include <sound/ump_convert.h>
 
 #include <linux/usb/ch9.h>
+#include <linux/usb/func_utils.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi-v2.h>
 
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
index 6aea1ecb39999..115d219c9c00c 100644
--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -8,8 +8,8 @@
  * Author: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  */
 
-#include "u_f.h"
 #include <linux/usb/ch9.h>
+#include <linux/usb/func_utils.h>
 
 struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len)
 {
diff --git a/drivers/usb/gadget/u_f.h b/include/linux/usb/func_utils.h
similarity index 96%
rename from drivers/usb/gadget/u_f.h
rename to include/linux/usb/func_utils.h
index e313c3b8dcb19..c8795c9651096 100644
--- a/drivers/usb/gadget/u_f.h
+++ b/include/linux/usb/func_utils.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * u_f.h
+ * func_utils.h
  *
  * Utility definitions for USB functions
  *
@@ -10,8 +10,8 @@
  * Author: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  */
 
-#ifndef __U_F_H__
-#define __U_F_H__
+#ifndef _FUNC_UTILS_H_
+#define _FUNC_UTILS_H_
 
 #include <linux/usb/gadget.h>
 #include <linux/overflow.h>
@@ -83,4 +83,4 @@ static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 	usb_ep_free_request(ep, req);
 }
 
-#endif /* __U_F_H__ */
+#endif /* _FUNC_UTILS_H_ */

-- 
2.39.2

