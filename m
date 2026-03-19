Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB73B8920
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912983; cv=none; b=JqdUJnOFOOFQLyPBIcGxhP89utJJ/KWup7bwpcot7AH10vo7J84G3NMKXq7KdtvDzoDxfLDfqDaqzKjd9lCLnaEnTlgyIE9SqkgKZ7r8VDZpf6WaDSCWwCqih41SYwEBnUvSS2qZURv8Tf2hgl/2l0PRZjdjA3GgI6xL6KE4/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912983; c=relaxed/simple;
	bh=zVeUD1ENGLPUpi02yQLpQxvzyfHc4I64+29LpmnDPRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnrqhxHnAilw9Nta0Apc5R45zJBOp7lFSE3BUQKiLCM7jOSLsGoCRCYafz7wrqNOg9V3MiX7TSGsbg42UrT5I2wtprvh6JVC0LYc6B3vTi6DYXX0NnhFkCM5pR04o7D46PQ4FydX7a/1xYotwnW3co/luY0P/T4NeUBHNshEVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OG-Pw; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Di-12;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0cD1;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:06 +0100
Subject: [PATCH 09/11] tools/usb/p9_fwd: catch write or read errors on
 disconnect
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-9-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=zVeUD1ENGLPUpi02yQLpQxvzyfHc4I64+29LpmnDPRA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OIskogG332H0xRY2BZOeoXqGpS3SrKw54kX
 3FfcRs3qbOJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDiAAKCRC/aVhE+XH0
 q8SZD/4xWQvsLmae3+yc0JgsCq4by28ODAVzJNrco3Yok39qOw5rFVTnsYoYbcF9h9UIDS9klAv
 2PVzspgyuxytIhA9isncW21fXJ9LpH6lhfAZBgLritxUKhW7tdN02JXjz2tFcPzpxaaBOvcDpGi
 HqSKvc6w1UFNgpJ36P95UecYaeff6yIVshdJRakxKKTcVuD8CwZK7BZ/3UDSk0gKMD16y1qz2Ty
 u9Tu5kNhTiL/Gblvm2wOEBFnVqT/Qxc5kT+uQ4QbQpxa9ezyY6+oLKo6SCUTSC2pET1H3A6M4RA
 x7/YWScQUAOAmSHF4A5/+7WEjz4uH7NHvr81AOraHWZ2+013JcgRjzSq1bxkHoe3+BbjwZjpDB8
 ktMLfLyWlMOMbwePzD9at1w75Xg+o6TdF5cqISQKuyMFg+2gesJbX+hEv3wPmfjSK0+2Mect6gY
 nrcOw0nSpNuS6S+Y5Niet4yJsztbfPu2kcJltjSy39DWhXdeetEggOWFA8A458SvVcGguWHLIK6
 vDeBGvx1b1xGh9gL/gGi+OIaJHC4xMPYpZVDlcZGlPD4wvm1mOb1q7EWsHjuXs7IPQrnC9aZTUc
 srJHYhxByFNAQ+0ZPe2IfG8+megWgAqU9qP5d4GrmFu08Gj7qrAaZZe3K+4G2f1uULc6JFBOOA0
 YDzD3aEqJKCLOqA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

When unplugging the gadget or the gadget is not available
since the controller is reset, running transfers will return
with errno ENODEV. We catch this issues and report the problem
gracefully.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 tools/usb/p9_fwd.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
index 6a0104935ee995ec4159e27e1cfb7d93db422a33..c2c2afbf45df68376907ea2ae8c022614e4508f7 100755
--- a/tools/usb/p9_fwd.py
+++ b/tools/usb/p9_fwd.py
@@ -123,6 +123,9 @@ class Forwarder:
                     logging.debug("c2s: reading failed with %s, retrying", repr(e))
                     time.sleep(0.5)
                     continue
+                elif e.errno == errno.ENODEV:
+                    logging.debug("c2s: reading failed with %s", repr(e))
+                    raise ValueError("disconnected")
                 logging.error("c2s: reading failed with %s, aborting", repr(e))
                 raise
         size = struct.unpack("<I", data[:4])[0]
@@ -145,9 +148,14 @@ class Forwarder:
         logging.log(logging.TRACE, "s2c: writing")
         self._log_hexdump(data)
         while data:
-            written = self.ep_out.write(data)
-            assert written > 0
-            data = data[written:]
+            try:
+                written = self.ep_out.write(data)
+                assert written > 0
+                data = data[written:]
+            except usb.core.USBError as e:
+                if e.errno == errno.EIO or e.errno == errno.ENODEV:
+                   raise ValueError("disconnected")
+                raise
         if size % self.ep_out.wMaxPacketSize == 0:
             logging.log(logging.TRACE, "sending zero length packet")
             self.ep_out.write(b"")

-- 
2.47.3

