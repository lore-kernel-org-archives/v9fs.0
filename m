Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F964482D7
	for <v9fs@lists.linux.dev>; Sun,  1 Sep 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725217899; cv=none; b=BbJ67OkbM3OQWY3/TmswdvOKjbOtlBq8SsCxcjLwsu7PkfQT+BJINunWeglIHuGnIYYsCYUqM9ko4f47uuqRgim6xOu/fKDVN3EHj8pRBw872hs+PbPTAZxHXEDwqhHav7HqiLXq+LnmryAivr7BigZ83eCWuSvriR66M58S15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725217899; c=relaxed/simple;
	bh=7Dqnzu4OI88UdtAfkzrUCgMAN8G6HbgriW4lk9+LvSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eug4/0pHWuXSt4HXlnsao4JmatL8oruKnbUgx9OWZetF0Y9RdKRFn4v4KUkGWSXmYLgCZoVySZ82Vy5bcvuJTKKS/H0Xx8T6hDkj8Ea72wDwfU74mQYqIKTCRpjTl7uPE7EPwe1l9krOKnORy8Y3xthVUM7LBtquBcXn8Bmz0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1skpyy-0006ZW-E3; Sun, 01 Sep 2024 21:11:28 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1skpyw-004jEq-R6; Sun, 01 Sep 2024 21:11:26 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1skpyw-00727u-0z;
	Sun, 01 Sep 2024 21:11:26 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v12 0/3] usb: gadget: 9pfs transport
Date: Sun, 01 Sep 2024 21:11:15 +0200
Message-Id: <20240116-ml-topic-u9p-v12-0-9a27de5160e0@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFO81GYC/33SO27DMAwG4KsEmqtG70en3qPoIIlUIiCxDTsxU
 gS5e2WvVTWSID+CwP8kC84FF/JxeJIZ17KUcagFF28Hks5hOCEtUBtEMKEY54ZeL/Q2TiXRu5+
 o81pYpSXDyEldiWFBGucwpPO2dL1cL8d9+lint4Fpxlwe+8Gv71qfy3Ib55/9/sq37j+XVk4ZD
 eCSZCb7oPBzwuF0v83jUB7vgGTTVtETRBWiMilm7YU3oinIniCrkIwI0mBKEHhTUD1BVcEKgSB
 cZAHaX+ieoKugEViIoCVm3RRMTzBVMF57a8EayLkp2J5gqyADR8RsbY7tL1xPcFVQzKPRPgUF0
 BR8T/BV8BKszMpGa2JT4KwbKbZlyukMGJJIup0I3o8l31PlPENmrJThj/F6vX4BTrIToGcDAAA
 =
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, v9fs@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, kernel@pengutronix.de, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 Jan Luebbe <jlu@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6221;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=7Dqnzu4OI88UdtAfkzrUCgMAN8G6HbgriW4lk9+LvSU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm1LxZCkKV+/Nyjbxp7/bq/Ju4h9r7Luoeoncv5
 1/RhU2pqZ+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZtS8WQAKCRC/aVhE+XH0
 q5amD/487D24Hws8Qhmt39tdMri4cSMPbDrLtY8lyffuiFce3TObo22nnFSw6BJzvRqhBfQzoT1
 O84c4q5d0wxagalEgftcdIn0AR2SdkLqNK9bzi0nK80OrZlsTt/CSNqs5NAaPnAZy0CUXvycHzv
 afz4q6Ze2UdsggGFXKMwhqWk3RV7h3XOyuOta2t9sEs2uC89SdqDSaKxqoEurV5wBOMj4loj1rM
 oz0/dr+CvV8PE/bXWzAgfH9lJSZ7zRMAWCuudU0wDGtCJ/NpEOvY1QZ3yMLL/jbLH9d7q+XqJ8A
 fiBFLo3998HDnvTT9zprVgCLRIKPqkqdGNCBXJNa/A2rbYmeqOAomK7p7Zygo98e/lstuejXXlh
 S1/vqg7mmYrdS+OtQSUjE47Tn3g2+B1iL1ckUlipBm6R3BlAZOJDMvJJFWISbVZVAjSrss0KojB
 cU3g6qpKzZBZBP7kCLf26+bk7cMqRBAtfBUqAZTnx95VJmNsgyraCte6IZTflj9oVrn8yFbYvFr
 huPIIitlzN3Nmsf8DYLwxbbjZ42p29bO05PwVo7A6HVOuvRXxuCU9X36RjG8Gg5FcDCc1N1TsNb
 0WyTjXNstR0Kx/tuL96GGjr6n2jLZb5LZ5zHsamx6ppBoTFi0cyn/OIC/KxBmUnAbQnOeacLF8I
 Q/G6n7R6jYneSsQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev

This series is adding support to mount usb hostside exported 9pfs
filesystems via the usb gadget interface. It also includes a simple tool
(p9_fwd.py) to translate an tcp 9pfs transport and reuse it via the usb
interface.

    +--------------------------+    |    +--------------------------+
    |  9PFS mounting client    |    |    |  9PFS exporting server   |
 SW |                          |    |    |                          |
    |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
    +-------------^------------+    |    +-------------^------------+
                  |                 |                  |
                  |                 |           +------v------+
                  |                 |           |  p9_fwd.py  |
                  |                 |           +------^------+
                  |                 |                  |
------------------|------------------------------------|-------------
                  |                 |                  |
    +-------------v------------+    |    +-------------v------------+
    |                          |    |    |                          |
 HW |   USB Device Controller  <--------->   USB Host Controller    |
    |                          |    |    |                          |
    +--------------------------+    |    +--------------------------+

The USB host exports a filesystem, while the gadget on the USB device
side makes it mountable.

Diod (9pfs server) and the forwarder are on the development host, where
the root filesystem is actually stored. The gadget is initialized during
boot (or later) on the embedded board. Then the forwarder will find it
on the USB bus and start forwarding requests.

In this case the 9p requests come from the device and are handled by the
host. The reason is that USB device ports are normally not available on
PCs, so a connection in the other direction would not work.

One use-case is to use it as an alternative to NFS root booting during
the development of embedded Linux devices.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v12:
- removed the unused "struct usb_function *f" catched by kbuild test robot
- Link to v11: https://lore.kernel.org/r/20240116-ml-topic-u9p-v11-0-b4890e06733a@pengutronix.de

Changes in v11:
- fixed the include guard in func_utils.h
- Link to v10: https://lore.kernel.org/r/20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengutronix.de

Changes in v10:
- fixed reset of tx req context in complete handler
- added suggestions from Cristoph JAILLET from v9 review
- Link to v9: https://lore.kernel.org/r/20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de

Changes in v9:
- solved the error return path by using wait_for_completion instead of
  running in the usb complete callback in a loop
- by using wait_for_completion solves the req_lock
- using req->context instead of using a state variable
- Link to v8: https://lore.kernel.org/r/20240116-ml-topic-u9p-v8-0-409e659ca4dd@pengutronix.de

Changes in v8:
- this time really added the req_lock spinlock
- Link to v7: https://lore.kernel.org/r/20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de

Changes in v7:
- added back the req_lock spinlock
- Link to v6: https://lore.kernel.org/r/20240116-ml-topic-u9p-v6-0-695977d76dff@pengutronix.de

Changes in v6:
- fixed the python script not to have path set by default
- improved the lock init
- fixed usb9pfs status change to connected
- Link to v5: https://lore.kernel.org/r/20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutronix.de

Changes in v5:
- fixed lockup in mount -> remount -> monut scenario
- improved p9_fwd transport script with more options
- Link to v4: https://lore.kernel.org/r/20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de

Changes in v4:
- reworked the naming scheme to be set by the configfs instance
- added conn_cancel function to properly stop the transfers
- ensured that umount -f will work even when the host side has crahed
- added all the review feedback from Andrzej Pietrasiewicz
- Link to v3: https://lore.kernel.org/r/20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de

Changes in v3:
- dropped patch "usb: gadget: legacy: add 9pfs multi gadget" as discussed with gregkh
- Link to v2: https://lore.kernel.org/r/20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de

Changes in v2:
- improved the commit messages
- introduced an patch to move the header u_f.h to include/linux/usb to compile usb gadget functions treewide
- moved usbg gadget function to net/9p/
- adderessed several comments in function driver, like the cleanup path and kbuild errors
- improved the documentation in Documentation/filesystems/9p.rst
- Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de

---
Michael Grzeschik (3):
      usb: gadget: function: move u_f.h to include/linux/usb/func_utils.h
      net/9p/usbg: Add new usb gadget function transport
      tools: usb: p9_fwd: add usb gadget packet forwarder script

 Documentation/filesystems/9p.rst                   |  58 +-
 drivers/usb/gadget/configfs.c                      |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/gadget/function/f_hid.c                |   2 +-
 drivers/usb/gadget/function/f_loopback.c           |   2 +-
 drivers/usb/gadget/function/f_midi.c               |   2 +-
 drivers/usb/gadget/function/f_midi2.c              |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c         |   2 +-
 drivers/usb/gadget/u_f.c                           |   2 +-
 .../gadget/u_f.h => include/linux/usb/func_utils.h |   8 +-
 net/9p/Kconfig                                     |   6 +
 net/9p/Makefile                                    |   4 +
 net/9p/trans_usbg.c                                | 956 +++++++++++++++++++++
 tools/usb/p9_fwd.py                                | 243 ++++++
 14 files changed, 1278 insertions(+), 13 deletions(-)
---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

