Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DC168C26
	for <v9fs@lists.linux.dev>; Mon, 27 May 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847737; cv=none; b=U0zpHYU4Ih23GgCJ9ACT2X0u25RWNYi4JpM0xaEnJ72WHTc7VRtImjl0KMhl69pJeAXGG8N7d46+ZaOBmIthtn6NSNwwdqN+hvUwGeA4ReTVbJq5i8HMdeSMxT8owz0D/wGtrQvcs38hA9soXKUNus0HuuFsxUpwglOH/vL46B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847737; c=relaxed/simple;
	bh=vG0kTDeJ5zV9j+YDmYBWDeIWp3ZeSeJjEjcK5jeV3fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vk1tAmfBFXASyrKt9uOHjGkphGWle8kHEy91yJf0do8Dcd5XfjTRHBsY+VPxmdnBqE3PhXSSMDwa1XN0XzpNCr52R0lRfHcrj7ED/5yNi5w0WFKxvxotboRvAGoByaavp7P+CHCiYUZhiLgrNBm4pvJCW7MBSphq38q8rzif3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sBiWH-0003jY-OH; Tue, 28 May 2024 00:08:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sBiWE-003FHC-Oj; Tue, 28 May 2024 00:08:38 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sBiWF-007MAH-0Z;
	Tue, 28 May 2024 00:08:38 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 28 May 2024 00:08:36 +0200
Subject: [PATCH v5 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v5-1-5ed0abd53ef5@pengutronix.de>
References: <20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5252;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=vG0kTDeJ5zV9j+YDmYBWDeIWp3ZeSeJjEjcK5jeV3fw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmVQRldfcb2QShLNzLOQYd8/oc8NFX4YL4wn8L3
 Q1KynSXGPKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZlUEZQAKCRC/aVhE+XH0
 q8JfEACkn2XZ1L2ZPMWDruZIdvWGwByji42VtFCqsnqqRJI1tqWOCZpMVfiY+go7NOiLrIbOtfh
 kYdPPef6vmgD7vvpb4Df53p79ex4LtI7ix8FNIxRgccqRYLyzZrLGqMaGCRcmfx9XfaPWwO21pL
 1r//baZIRSuci80QTLTWJFM6IH2ylcyUxUqquV8PsZBep8fsfvwrTjR5l/qMZN9lMT3p6GrN2E0
 ctYIxxEhsuL3YdZkH3MNXLwciWBJDbqMNYFL4KTeP8ximkngLL9Q4ste+3lqd9XVuvMSF4oVFzK
 kWFpnA9JRzksn+eYl81TK/3l/gWoB/qk34iV/BsK5ekBfbVQCtnb4rnz4NOMt7+LUm1l/6JWYS9
 S/NtQAZFMZzw2rTDy+x3VHeK1cHaxDsnuD2coVV1kLlI2QWBtnQEiBO3QxB5smqiMw8js0C+7tL
 M8yC9AHmzGNGli5Cukhr4RiZMGwuLcnGih0RFHgbP+E8H3ykfVKNFTr3ZF+JLw+Om/GJXGLhZpp
 FgTK81ncBntfJhvqCtUFP6dDwWWMk8JXFL12AzDjWUBe3vPDDEP903Bt/MXGvKF2UTEDUX9rl6U
 lnHX5u0S2Fgx0delWkPP/0Zto/Ik8wlIMEgfEXNuUSvV0fESdOgYZyYr2QRH4TvxRQnbjZwG4oL
 DyyL1jUx4jhcBAQ==
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
index ce3cfa1f36f51..e3cda6e0cd0d2 100644
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
index 1f21459b1188c..f06e6c4974a6a 100644
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
index 2db01e03bfbf0..0b7684c4a5b8b 100644
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
index 17ac6ace0cffa..8fce2c2fd18f7 100644
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
index 20c6fbd94f32d..9f8f3a334b579 100644
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
index ec8cd7c7bbfc1..830aa075c130f 100644
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
index 2edbd9b510d60..c9f38f24a92aa 100644
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

