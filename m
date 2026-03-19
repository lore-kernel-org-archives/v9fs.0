Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6663750CB
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913810; cv=none; b=GVaAeDB+utdNRK8HqentQpE1sCR9pdL4eh7hGFDUCxMmB0RvtOdnDkc4w5T5hephlUUmXgNzYSLXmqmcbsgSTFtWFhglrUP3aabzwJEbwVO0XRArcr+Mx/2euBxDxqHPnXG0RK8ZJ/mPq4diNp1zX/0jW5NZmMChEg9bq+/vEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913810; c=relaxed/simple;
	bh=8Zax87K//ORxmeg06r3rNRaT1WBU7RmDo8PXURzaH8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHkwZ1gX8DQs5gUCIf1JUlzdcGbHhkrpq19mDw9h2JPV+b1cRrigcZn20pnHd5Mrq3Y0jKAlpJ48+eDe0pw9oDlW2eRPK6o6bEoZ8LIstMxAhPSTCZ5Dze9K8pmC04vaD0Iza7FxUR3+njHMffHX4mVliqff3/TqZV/ZzE6oi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w3A0w-0006Ma-L2; Thu, 19 Mar 2026 10:50:02 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w3A0w-0013Fl-1N;
	Thu, 19 Mar 2026 10:50:02 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0d4y;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:08 +0100
Subject: [PATCH 11/11] tools/usb/p9_fwd: set new introduced alt mode 1 on
 interface 1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-11-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=8Zax87K//ORxmeg06r3rNRaT1WBU7RmDo8PXURzaH8E=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OIPcKS4kamSdRfiWc6vfyXW3dOkiz920itT
 +YZ/sOf0YSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDiAAKCRC/aVhE+XH0
 q4IqD/9X/Dk2r4HjV+Il4B7nq/FQEdUGUZM6ouaR8YWvmDpRirhneSfoQmPHROBO5a19Pp2XJWx
 6/uBxw8IfXPBA9HxKgCsZvk+S87wp1uFrkJiZHNnKe7ZmS1TSbZEdNsG/tOGfm3ZwYs9Xx4egiw
 PaMZcgu2l3Hm0YjcwbzAjtTNggfVpszuIf8Bm64l+yhpumeIGknxz0ofAhyalFU3g9ipVZIgiyc
 489zg9PmPabi9j4j2GG+QwELkwQtTDKQ+YYTqlVYzOFXdMki9XPsCHo0Dt5GVVRKglTFklbyPZJ
 thuNlZUe7s/7L6VwAfk/ZQlVPRvR1tL1e+/wG9fHxh/DkD+3wvQToCNixv8A8iu8TJhqMbOUImi
 QcMHy3OjwJj2ZuNDiRgA8Gn3ou+aAOihgJNfNs41gtH+jsQ0aBs2lLnciMb0KReOoR9qhhefhI/
 3lnApyAruO3xnLxR+aXTA3Jd5yUs8yDc8nN1pNH1L02wjJtL6J0fvMQ3ZiLzrLDkdBaUnzn8rzi
 7B0gNGODEVPFbCs1tBtY8C+XmoNZ9sZDMjLNLItzkDru2+qPcCcddWzFZOXVxQYwMvDXOqHXaHy
 Gz6GhBkPmHjrlFtW10S7bAEU1VclB8xZGxj4PWP2K4M22m+WMFDeFFRRR0LiGKEk+cb4wAEzI6s
 ujYGHC+80+UKrzw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

Check for the right interface with the two endpoints and
enable the altmode 1 to tell the gadget it can mount now.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 tools/usb/p9_fwd.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
index 1b479c931df9bfb0f7e7f2cf5a612764408f0828..32b138976e0da0f395d25036fce8fd7faffdadad 100755
--- a/tools/usb/p9_fwd.py
+++ b/tools/usb/p9_fwd.py
@@ -74,7 +74,7 @@ class Forwarder:
                 if dev.is_kernel_driver_active(intf.bInterfaceNumber):
                     dev.detach_kernel_driver(intf.bInterfaceNumber)
 
-            if intf.bInterfaceClass == 0xFF and intf.bInterfaceSubClass == 0xFF and intf.bInterfaceProtocol == 0x09:
+            if intf.bInterfaceClass == 0xFF and intf.bInterfaceSubClass == 0xFF and intf.bInterfaceProtocol == 0x09 and intf.bNumEndpoints == 2:
                 usb9pfs = intf
         if usb9pfs is None:
             raise ValueError("Interface not found")
@@ -103,6 +103,14 @@ class Forwarder:
         self.ep_in = ep_in
         self.dev = dev
 
+        logging.info(f"setting alt mode 1 interface:\n{usb9pfs}")
+        try:
+            self.dev.set_interface_altsetting(usb9pfs.bInterfaceNumber, 1)
+        except usb.core.USBError as e:
+            if e.errno == None:
+                logging.debug("could not switch to alt 1 retry", repr(e))
+                raise ValueError("mount is not ready yet")
+
         # create and connect socket
         self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
         self.s.connect(server)

-- 
2.47.3

