Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665A188CB2
	for <v9fs@lists.linux.dev>; Wed,  5 Jun 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594398; cv=none; b=lnbVVUwiY5GsbOAEKsFo6sKEAlgJBjEamZFmdHFRbCLpsJVzFDPjwHXLHybrqlDvDacSRpN6pQDObkwg2CnUXFyi9KfJlRfCjYJUjF+Fwe2BZjTCunw6MLcj9MAqxXzwez3twNG3IwIyJ/MEafRH5qIAF2sArQoLWvMHAzoVPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594398; c=relaxed/simple;
	bh=p2eIkxWkr0okujv0oX87RM3pnW6yELVr3CaaRbhgb4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQnkfpiFoBlIx1Vsuawou+GhmbiyusQT+xE4Xd/wgg0Aj3Ve+tft7kn86I4MWFw+xgf5yR7x/pm708sovQKwh2A/eywH3Hs/3fHueVucELrep3arzYzroRaDGcPXAjXHz4WFZGMBKqN8iP37SFXstSrx4+Lx3d0aw/HLcyPU4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sEql4-0006Vh-Br; Wed, 05 Jun 2024 15:32:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sEql3-000LFg-7U; Wed, 05 Jun 2024 15:32:53 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sEql3-00FRCH-25;
	Wed, 05 Jun 2024 15:32:53 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v6 0/3] usb: gadget: 9pfs transport
Date: Wed, 05 Jun 2024 15:32:46 +0200
Message-Id: <20240116-ml-topic-u9p-v6-0-695977d76dff@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9oYGYC/33PzW6EIBQF4FeZsC4duPyMdNX3aLrg5zqSKBpwz
 DQT373ottblIed+J7xIwRyxkI/Li2RcYoljqkG/XYjvbLojjaFmAgwk41zToafzOEVPH2aijVF
 wk0owdJzUE2cLUpdt8t12NPRDf93b19reClPGNj73va/vmrtY5jH/7PML317/WVo4ZdSGxgumW
 2Mlfk6Y7o85jyk+3wOSTVvgTIAqOKm9a5UBo+FQEGeCqILXYIVG74Plh4I8E2QVbgAYoHHMhuN
 fqDNBVUFhYNYFJbBVf4R1XX8B6Zu/CNYBAAA=
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 Jan Luebbe <jlu@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4985;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=p2eIkxWkr0okujv0oX87RM3pnW6yELVr3CaaRbhgb4w=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmYGkAWBqwWK074vANdlY6zoHUwrOsOfy08+eNY
 H2Z1wY2iDeJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZmBpAAAKCRC/aVhE+XH0
 q9D1EADCNkgjuwX0GvV+865QKFLH92gw2I3dBhfsc0XFjzumDLGU71fCuC8YV0hnkXD7iL2mYNd
 Hm1LGSlu4Uv6URkqk4kGYnKWEm5eNDad7HqkeLOvZy/s3nOR1jpYYZTfQem7WjrBfwqXHxrH2S9
 Kkjw2i9r4jE6pQXqfnpaurH/PrPO3yvq4WBh6YTcD5cj8GpbDJD5wWnlT8+bjIzE/hOItCHQSl6
 01PrTGHrKNdn0JlKF3gRe/pKAbT7JnaVxaQvry2xovltLgeYHHoO298AkBqXPFzTNKwP+hHlRxK
 xgwJ3rLLvW+05J4VPW3XqxDS9/KVZ7lgiQPuamyce/wjDQpfT4rf6caP5f4OSXHSNIiN7nVg4PW
 dIbvfLBnb13aYyiyLb4kF2wxyISJAe2uVfscdJS8KmPzZSd6ccFPoVHd9Mvk+Nic0bp4JgTBRHd
 jE2Xbo+lDO2MLuCpC8SZr1xISOd2jlTmaCvJP1CAMGgT0j/Hfg2yQgQop/ap48t6hxo1GNyEZnH
 3uuURv2cshDgjI7I2pzaOWIUl0OtPkSxdKMvN7ZjY7jB4qYAcw8ssLYTcHcDyIPj4GVjN+HCgpT
 uMQRflNn2mBdynXgJUAb7fotaDpbY72mGDybv0DaTLf6/ZF7LcJdVMXaWznp4mRXXZ0wvPGymUg
 0uJHFw+7IvhRxRQ==
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
base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

