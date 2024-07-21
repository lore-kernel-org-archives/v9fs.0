Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDAD529
	for <v9fs@lists.linux.dev>; Sun, 21 Jul 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721600335; cv=none; b=tG6Eeunu95Bq6dirjHAMd9mtDS0tamoRgU5SvvyAvoLR1Nr/yrv5ZgIc6PzOBVKUR64PHgFoLDlZVPEcCuIvJKuJOHT1gMoaSjuhH/n2wpeilR4lCMMb0+u/i/wjZzViLo08O338/hu+BkTITeVTjzhO/qpkp/7pKGGXnu8wLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721600335; c=relaxed/simple;
	bh=7sEEETgVT/SMXMtvIcfhlQ4Ld/tSfVi12H3adoBMXas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p52mxlUMLw8zzJXZVugK4CIsmPUFYCoZpfxMSOJASdLfoBa96YPLIz2gDSQ68KKmv1JauJl0kVwSiXtQN7UzXxnEeJOHz/dg8fa+LkmjG6jMuj0IFihu/ZfKFtMlf7BmfV80WiLCAMZBOqciD1Y1Er/cTuX+8qA9FRj9xGP8ypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetI-0003mB-C3; Mon, 22 Jul 2024 00:18:52 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetH-001Exi-Sv; Mon, 22 Jul 2024 00:18:51 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetH-00FvCr-2d;
	Mon, 22 Jul 2024 00:18:51 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 22 Jul 2024 00:18:46 +0200
Subject: [PATCH v8 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v8-1-409e659ca4dd@pengutronix.de>
References: <20240116-ml-topic-u9p-v8-0-409e659ca4dd@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v8-0-409e659ca4dd@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5291;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=7sEEETgVT/SMXMtvIcfhlQ4Ld/tSfVi12H3adoBMXas=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmnYlKQLMvJQwtGu3eCIxBX8ZeGH8fZtLn4y1IU
 siW24RProGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZp2JSgAKCRC/aVhE+XH0
 q2csEACUJYUdNvnF4T+5A+AHI9a3FGd87EZpEcCOqR0AGWejpasqoq1wsUUwltEfX/CG1mcFOfk
 ZwcAey5IAREMzHmjLHEvIQb9cjn3hlVSLtoafgF+IEaXb500ikHgWHMlTCApnnn2BScXWUO+kLe
 2I+efIDgbUQe7Ung7f1BTzcMfZr8abrUndQ6uzSbtVm3pvreohVWARdfvk2D39GElI2iec/65N0
 NEhEQ0SGP2ohDWoavIu5DWBNZxU2VKCiH3Tyf78T8/7/ndlxdCS8DlOy9O5HV8vf8uppi5UshxU
 oa+ulw1vRK9i0NfckenkBU9m8jq/1UhrZ1/qs/hJD6kBu0vNF+se6swHJfaX9b+gimRlvGt0oOP
 Xt8twsdDe2+6mZHfCW7HflTlGOBde5QomLzSYaVL2VgPay1lvhV+MxLJBPjrAota6U0Ek1347Vo
 sLipBkIXz+X/nL/H2puTWn0TiVlwbkuX9tuWd956SdnpZT/LYlilQabgDQ2aYmPRPSz8yBviwGd
 pM7/P5IhK5ql+xmm/0iOeZqvCDA06BzxTAg2iUjjOq1UAvR6zG71kuLGI8xXE3OpxmDLkaBxA1J
 BqBcA5BzyQ4z/t0ZMEgmPlEWrqDWizUZE/yy8KnXRynmgL8lShKIC+92UA8USwH7ficknFx/jhn
 obHZVHNR/FXF6hg==
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
index d8b0968593379..4952c78ddcd32 100644
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
index 38e8ed3144f06..faa246304f90d 100644
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

