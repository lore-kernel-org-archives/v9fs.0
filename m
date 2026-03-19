Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580137E2E8
	for <v9fs@lists.linux.dev>; Thu, 19 Mar 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912981; cv=none; b=m/UkaS5uiAAbBbNSyzd44OFDN+b/UX13shgOEUPIAmZcGPIANnIm/Us/7LOR8XMwGAiDS2IVBJHcnwdaTV9k3ncZuRtXe39N3/jHWKRYtw8X0N6QBNrBj35NKcz7V+9vfojYoqbTVVxa1N6dDlVFEe2xUms9xXm6kcezlSLiyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912981; c=relaxed/simple;
	bh=qrYZhBm7vvapeXCeNfgLYOrA28EGANyGRVUbws0YH34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pV86iX4EicZgou7eEmrNkEzb68yWxAR3ndkCDQyKMEqm1bHVbtIhtX7RAd9hqKuNTDA8Wqgx8Lsq8twoZ9DZ1yHLytpgJu7dZgsJWGfClklNloWE7YietmQv8U65vxrbQp+bKSVwin3w8dAbEfF7hokhRr/ch4FVXbfx+oGh10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003O9-OQ; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Dh-0z;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0bmI;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:05 +0100
Subject: [PATCH 08/11] tools/usb/p9_fwd: catch if claim_interface is not
 working
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-8-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=qrYZhBm7vvapeXCeNfgLYOrA28EGANyGRVUbws0YH34=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OHPLut8Ep/i76pfseXehdynLorUH6l8dqBJ
 Rir9jAjONKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhwAKCRC/aVhE+XH0
 q/xrD/90xBGiCoIFTBL1wI4QVraAS7enBQBHpia1Zs1jXNrjLM5JOxV2IoTeUJ6vY600xmoS+AZ
 zZxp9Mx0mRxeq6wU3Rw3cvE131WxgVjYqG1frrLq/afFd+t9hzF0sDEDVK7CXZdX56oy/hEkZWJ
 8+JY4NZgoaIy8ViKMYm71iriS37KGQimVQ/jC6G2xvy0qPzf12MWF5knbyeV72Gmho44hKGXJM/
 w8fP/OZST4AM3ys0ABUDexdb4bjTNWfbuqBayRflHY09EmDU2lJb4K6A88NI87XZXZcVcPBW+QH
 5s6Yp10gJ2FhSajf74xY/jkU6fX+bS1bPUioqf9eRyA3+mLVNZ5Dty2ex487pb7bfViI8L7o3FW
 2ewrT34OJ+2HcymdFiVmEEZompVlcOnsqQaUgvJ5wYf8XJsCMauYk/9YnPVHRHRiIwvoCciZ537
 Wi+OwNPJ6Wn4L62h/vETeWCqzLQX62Of8KSfUZuhWVIvpSNmTVugU3AbUyVoqrh+Gcbi8amkIUN
 C/sUOWVZUm40fm/NBJjceB6NF8bCaVRyQJ6zjgg7tZ30Y/x0RjCAz1L2416aBV4/JEyPJ1F0O7Q
 Ng1PqQua6XgOFGGSv0l678HFTNZozIDZ7MaeB6vQFEeIu2C795zzHEh9lIWMB/0ClF2BpsqzyxR
 c0Cv7YivWGwsP3Q==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

It is possible that some other tool was already claiming the interface.
Bail out gracefully if this happens.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 tools/usb/p9_fwd.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
index 12c76cbb046b7277bdd0ec39b663a041c9a1fc89..6a0104935ee995ec4159e27e1cfb7d93db422a33 100755
--- a/tools/usb/p9_fwd.py
+++ b/tools/usb/p9_fwd.py
@@ -79,7 +79,13 @@ class Forwarder:
             raise ValueError("Interface not found")
 
         logging.info(f"claiming interface:\n{usb9pfs}")
-        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
+        try:
+            usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
+        except usb.core.USBError as e:
+            if e.errno == errno.EBUSY:
+                logging.debug("old connection was hanging", repr(e))
+                raise ValueError("disconnected")
+
         ep_out = usb.util.find_descriptor(
             usb9pfs,
             custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_OUT,

-- 
2.47.3

