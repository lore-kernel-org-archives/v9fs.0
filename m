Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388416C84C
	for <v9fs@lists.linux.dev>; Sun, 21 Jul 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599731; cv=none; b=itMYhf3ttb2EyzETVE3TZthgjgGP3bGUxiPa7iNxpuVQwmfVk3WtNMTbQZgkEU0O8HwT6C1rioSsOBGPuIIZgACDAiVriB2BmBwAvhY3zTewQKPhIZG7F/OKLdYl0845xpNZK6SIP1UTlPehUxpKFXbhCM61goVXsTD5RxbvXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599731; c=relaxed/simple;
	bh=3cX0kwDU5b8rcZZ955opofqi6LaYdUQoIbhhqN5BgBg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jKWRaOyFPNbuJTDLdI1yiGzyBbESyzH5xVC8Rzd/hXItJqoGMaxyW6eIDCuZgD7j5eXH+s5CQbb0EzaPD9q2R7YufB2+DDqbBv/LwSnaNfby+yA+GK3IFLFOrA9CWn+M9qYKXWh1AAp4VgUd88GQWccyw4xYSoGGcUsHlWP9DfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVejC-00032t-UZ; Mon, 22 Jul 2024 00:08:26 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVej8-001EsY-As; Mon, 22 Jul 2024 00:08:22 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVej8-00FrrZ-0y;
	Mon, 22 Jul 2024 00:08:22 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v7 0/3] usb: gadget: 9pfs transport
Date: Mon, 22 Jul 2024 00:08:16 +0200
Message-Id: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCGnWYC/33PyW7DIBQF0F+JWJcGHlPoqv9RdcHwiJE8CTtWq
 sj/XuxtXS8vuu9c8SITlowT+bi8SMElT3noazBvFxIa19+R5lgzAQaSca5p19J5GHOgDzvSm1V
 gpBIMPSf1xLsJqS+uD8121LVde93b19reCmPBlJ/73td3zU2e5qH87PML317/WVo4ZdTFWxBMJ
 +skfo7Y3x9zGfr8fI9INm2BMwGq4KUOPikLVsOhIM4EUYWgwQmNIUTHDwV5JsgqGACMcPPMxeN
 fqDNBVUFhZM5HJTCpQ0GfCboK2iprTDQ6pvRHWNf1Fy3S2EYYAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5135;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=3cX0kwDU5b8rcZZ955opofqi6LaYdUQoIbhhqN5BgBg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmnYbR3Uh79e1ZCyJnyO/OFLUPnjQIm0qcam8qJ
 is/9ERDo8qJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZp2G0QAKCRC/aVhE+XH0
 q4DCD/96ozjKJyLgTMTB4I6AtbzdKKDqNptoPcCYUSu4kmixGTTeDvSD9tfRH4pCIO7u9A2uCtW
 DTCJC46AxfLNXs3CIRb+KNz3vtWzpeRdVEY0S4lvMNJ/ONxtCugygfwToBdO3TKNbB7bJqZAzXY
 fdSUrr4TARcGHsaJSMottN7CzX6TwekEiL+Cm6F2L2ioHWgfpVCVFhLVYlOO1bWtHz3IMUxSE88
 qJwnlIV70+kbgciH3GKD2stVPKKwZQTAIhHdNaA692Rq05p/kcesTLAYrSVUuOnSDkrbGRbXMdJ
 +39rhcdULffBrdGsyq2+yKBYUp9/XYZ+z6I6RMqU8g3P94cMUZJAfvhOWFA31RZJY0nD5ERPo1Z
 03TEO68mfHD1oBPTuLhZyziEj5AToqDAQ5ys/6AR8BFb0+eNm9pxCaweti6sqd+NkXSwv4RmNXl
 CI9lCkAs2Ua2kG6osbd8lpXYcS7CmGyjT0DD7cyXfwC6B7PdRKvoVpfqHUuQTHfhFtIa8fJzKVz
 y0An/ftmzJnKAfykBKOZ+1THeN76Yd2D5VcLna+wWZ0BynBSoQxn+IShNXwgyS914I0JLcpGF0T
 w9/wd+cGPMqq/2ueaoHQOTD6iEjIlzoGMbQahxVL1wGVIG4a7gMgfKQgcvV7LlGZNoZCWKnelHl
 kYV54pNBXrNB/9A==
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
 .../gadget/u_f.h => include/linux/usb/func_utils.h |   2 +-
 net/9p/Kconfig                                     |   6 +
 net/9p/Makefile                                    |   4 +
 net/9p/trans_usbg.c                                | 985 +++++++++++++++++++++
 tools/usb/p9_fwd.py                                | 243 +++++
 14 files changed, 1304 insertions(+), 10 deletions(-)
---
base-commit: 2c9b3512402ed192d1f43f4531fb5da947e72bd0
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

