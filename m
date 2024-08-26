Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275B143734
	for <v9fs@lists.linux.dev>; Mon, 26 Aug 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708861; cv=none; b=aWoQueC3rq/DTmq6ADG9tCanIJHjBW+amzJxk5x86PML7FWM5nI8DXirKd8b7McqxnWqh27uzF+umGcuih3uXAiW0h5ScSVE+YluHspWo2R2fXmm9Z0cVRYNsbAHr9E+RqJrN7gdfWWWPDiWi5AF3JYFVeRoIX52N0G8GEHhsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708861; c=relaxed/simple;
	bh=z9Qj6g2XE9CkSoh4IAgKWVyXEJOCoh/lnRNr0i3+ucQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwjdyYK512gLH1aAq46jpy2zk2Y1SVtnuzSnENqO+vsBPWkC3PLfXzd3ecccdWq3rN/fPKYNgrnxfXREpzkyjJ67wrcWvYiNTmCRPLwetLL8qRB+U1ZQCXIu/IyMRJMzxwv92OeUmw088oOknXMn0mdvVSEHOrDBvRyUV55Jkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sihYj-0006Uv-Ml; Mon, 26 Aug 2024 23:47:33 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sihYh-003HK6-Rk; Mon, 26 Aug 2024 23:47:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sihYh-002LCx-13;
	Mon, 26 Aug 2024 23:47:31 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 26 Aug 2024 23:47:29 +0200
Subject: [PATCH v10 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v10-1-a85fdeac2c52@pengutronix.de>
References: <20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5570;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=z9Qj6g2XE9CkSoh4IAgKWVyXEJOCoh/lnRNr0i3+ucQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmzPfy4pTLcH5ZgibPz5A3CYzspiME2s+yv8KqB
 5PeAKsSM9WJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZsz38gAKCRC/aVhE+XH0
 q4rBD/9LpWq8N4dArhFX7s9cDqzXrb66LGJO1O3tS68fhbmnSXajwbBHeNq/dbCCSpIOjSTnPDM
 SfMdM2+f/sjaYLFNcP7+FUgBOURIyJcdM8Q5lWGDoPSsZDCm72hqojBaEiFKIhvoDV4J2KjTfQV
 pQYPGaz0stnq3AQEKua9NTcIKT15EO07EEaDpWRb302qfhjYiUfsyU3PCR0iNZMYHOuSsMuj456
 eGmervcKiTLtGB5XXCVjGSQT7d3QmrrL/LLoX0y00zZAe6ubyBLdCm3GFp2yWGitr18Jlw2tSVX
 +0/SnG+scHNKnc8LLxc0vbaQ0T1G8XzblwKT4jZ//vWmYospuOzCblbMb77sq59BISIBPewaTN8
 5VxeVGEL306v3PCyQ+0y8nfCxwyVBctsa9pF5AQk+ZADgnSDkqgX8H3f0rruYlbDAD4Tmb6IRyB
 zWFp4+z8gqiZ0YUFcyL91zAit9OtgBtYbbOJngXOsF61lrFEFOqqzp7Q6hKD+NQ3hPRGYYuHi2u
 iaaIyR3raxJHIi78YcrMHoH4mc8bxsMXoI/4tBv4lVCXgsAcS2yFw+wHzITtd1pNzXUnd9CZ5tn
 X8ehj+KTd3nL1iH0wFNgb2R75NxpsXeiQ3VkqFEAabs9XBo0c+ASVwsROVqYKghMP9Sb/dPck+N
 31jW0o3lp2GMxjQ==
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
v9 -> v10:
  - respect alphabetical order
  - correctly changed filename in func_utils.h itself
v5 -> v9: -
v4 -> v5:
  - renamed to func_utils.h
v3 -> v4: -
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
similarity index 99%
rename from drivers/usb/gadget/u_f.h
rename to include/linux/usb/func_utils.h
index e313c3b8dcb19..e7b69e3145c07 100644
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

-- 
2.39.2

