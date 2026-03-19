Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAD37CD42
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913809; cv=none; b=Q2Ga7MSAWPhT4Rr7Wo87RmVHveLbSHUoZDIw7NFpfZbFhZH9n3C8Amc9h7i2naAp6KunrIYNRHbwzomS5FonMElojheHQJzEKCQzpkEXzHGpuC3tzgcfQzsM51Av6sqIuxmBtLtDeng5YULVVju+2fgnWRPZ5vwXZC8uhN02R1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913809; c=relaxed/simple;
	bh=GyqDNhylFQSVWEuAeaqUwe51g5CUWJ9CALmCsPTp0C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8oF+/9lERE+WELJwfPBK3D88Mw7sS8HE2pZXHkByOYaQBCtqpiHIQ3Ulx6roRZPxiOh1KLk1TXrdxZmun/b122E1F6Em2WYYSx7ssU13RZU7H4q7ogDS7FEwp89zJV9CFfYPMBOQJC19p7MmGGANiZc06hWLHL2t1T0Y1Q7yVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w3A0w-0006Mb-Nd; Thu, 19 Mar 2026 10:50:02 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w3A0w-0013Fo-1i;
	Thu, 19 Mar 2026 10:50:02 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0cjR;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:07 +0100
Subject: [PATCH 10/11] tools/usb/p9_fwd: add daemon loop
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-10-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=GyqDNhylFQSVWEuAeaqUwe51g5CUWJ9CALmCsPTp0C0=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OIBFaKA4+IRFrOKAmliuRxxT34zQ+thi9oi
 xF/fOzejCOJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDiAAKCRC/aVhE+XH0
 q8IGD/0WnYtjd0wNzcPnRzApl1ZUljnzV9mtwAkS5bo/uNkxSNQXuqp3xnxjIOf6aNNY8NMlt5d
 b46WG6li+q3UdiZQYdgNNbRURS1r9M0LalasZmwIt+7xzR7Kxan8f9AgaDjbce1fz0PSusxFDHI
 3QFlu6PYHpaT7IdhlgCm3nPKMKMELTm1zrQGJPmwk9Xo2kCrvHbKGzTLyohrrAk+IJSTQ1HOAN7
 Wu3fi6RHL68eN+Fwch6nOO1r6sJ9EKgSQ68iIHQQajqy4HuEO+pHbsixxVM9R4A8NdhSQ0Ym6WF
 Pvx+fS9add/SF7vjlelkN23VHySVr3/eEIMegPwPm20NkadYY/SVq0aNXYjZ7oENAEOWbBzSFV1
 9u5z5XXZutD/d0Zq6UDecyY5pH4qXOYkqBygDMl7qNACj1xaq4k8B69ut0VD1s8mKSPjdFWbXvF
 VZrs+xhIgu0ob+4NXLXR92gSGYubOcyshc5ANcUr8cpVLHiaN0ZFizzHGYN5XGs4zuA0ivxHGS8
 aKP43THzWZZynb5rcmlMcnmbT+YdazaMnt8EFudJNEEWGy8wdRGzZQYCer5QHXKeZG4SqPpsPF/
 lh2CnuI8ApHfN5pGoWib/OC3NfMDKj3UWxr7XbP7PjQryUFjM3X9tg8ZhjJ3RPYzsQnomzSJ0Ov
 XlNRbWIqykKHIQg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

When the tool is started always catch connection and transfer
errors and recover. We also log in one line, how long the
Forwarder was not able to connect.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 tools/usb/p9_fwd.py | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
index c2c2afbf45df68376907ea2ae8c022614e4508f7..1b479c931df9bfb0f7e7f2cf5a612764408f0828 100755
--- a/tools/usb/p9_fwd.py
+++ b/tools/usb/p9_fwd.py
@@ -7,6 +7,7 @@ import logging
 import socket
 import struct
 import time
+import sys
 
 import usb.core
 import usb.util
@@ -59,7 +60,7 @@ class Forwarder:
         if dev is None:
             raise ValueError("Device not found")
 
-        logging.info(f"found device: {dev.bus}/{dev.address} located at {path_from_usb_dev(dev)}")
+        logging.info(f"\nfound device: {dev.bus}/{dev.address} located at {path_from_usb_dev(dev)}")
 
         # dev.set_configuration() is not necessary since g_multi has only one
         usb9pfs = None
@@ -201,16 +202,28 @@ def list_usb(args):
 def connect(args):
     vid, pid = [int(x, 16) for x in args.id.split(":", 1)]
 
-    f = Forwarder(server=(args.server, args.port), vid=vid, pid=pid, path=args.path)
-
-    try:
-        while True:
-            f.c2s()
-            f.s2c()
-            f.log_stats_interval()
-    finally:
-        f.log_stats()
+    i = 0
+    while True:
+        try:
+            f = Forwarder(server=(args.server, args.port), vid=vid, pid=pid, path=args.path)
+        except ValueError as ve:
+            time.sleep(1)
+            print(f"\rdevice not found since {i} seconds, retrying",end="")
+            sys.stdout.flush()
+            i = i + 1
+            continue
 
+        try:
+            while True:
+                f.c2s()
+                f.s2c()
+                f.log_stats_interval()
+        except ValueError as ve:
+            logging.info("disconnected, retrying")
+            continue
+        finally:
+            i = 0
+            f.log_stats()
 
 def main():
     parser = argparse.ArgumentParser(

-- 
2.47.3

