Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1C10A1F
	for <v9fs@lists.linux.dev>; Sun, 21 Jul 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721600336; cv=none; b=b6kvbNaGSb0PepRcq+IeXbFjQFBJ5bJbz5SJi6MSWUWIDrCm7srAt1Ne+ou1YjBDjD7PqxFDnPX/+hnSP/YgrKVVX+OdaSCBNFjgqNctZL/oJxJHEmhRgjQPYBTYHGne/rtW10CdzViJnB9l3a7jsCRdeAw9AAfP0UfcYwRc6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721600336; c=relaxed/simple;
	bh=9KnzjSx6ou4jWVL/ZB//sZX/KPHWUIS0oCjZkadbBCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pcn6yEUOxvIoochebNfSoGHqMaPA808edBsZJnzir8sffrdFjFbwX/zm6B9hkmP4068vbtfYDDqydYDxgzz7mK/Wx96TztfU8YadA6EElJUkQ8S1Bw1gAuU2BGvsBoDvahH+CWjSxWzmQoHMi+YOLQKlUilB90+a2WEyo7DCOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetI-0003m8-C5; Mon, 22 Jul 2024 00:18:52 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetH-001Exh-Sh; Mon, 22 Jul 2024 00:18:51 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sVetH-00FvCr-2c;
	Mon, 22 Jul 2024 00:18:51 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v8 0/3] usb: gadget: 9pfs transport
Date: Mon, 22 Jul 2024 00:18:45 +0200
Message-Id: <20240116-ml-topic-u9p-v8-0-409e659ca4dd@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWJnWYC/33PSW7DMAwF0KsEWleNZlld9R5FFhqoWIAnyI6RI
 vDdI3tbV8tPfD6CLzRDTjCjr8sLZVjTnMahhObjgnxrhzvgFEpGjDBBKFW47/AyTsnjh5lwYyT
 TQnICjqKy4uwM2GU7+HZf6ru+ux7ta2nvhSlDTM/j3s+t5DbNy5h/j/Mr3af/XFopJtiGxnOio
 rECvicY7o8lj0N6fgZAu7aymsCK4ITyLkrDjGKnAq8JvAheMcsVeB8sPRVETRBF0IxBYI0jNpx
 /IWuCLIKEQKwLkkOUp4KqCaoIykijddAqxHgq6Jqgi8AtBYCodXR/v9i27Q3VesU8WgIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5310;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=9KnzjSx6ou4jWVL/ZB//sZX/KPHWUIS0oCjZkadbBCI=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmnYlGqxlcngzzezro7W919GQgZDfdx4LjyTV/F
 zA+GEyhk3eJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZp2JRgAKCRC/aVhE+XH0
 q3qgD/9LJ3irKPOtQHVz1/9rVyux4rUdnlRapIlB8P19dtB9X1nnqpRZvnmmhyciMsOdWLOE4AH
 LhUEiPfToXQqliSMCw7J9AFmoiyC8TZ44Gf+V4W9z5u0PchJkpPqT0Qe6I/J7rxWX4E4/DD5rXq
 LCnW4lJHBWT94byV+ZouVWdSQioKa9fjcF+oPdg5hSKJh3KgcCt6wkSlrOrUggVq7R4HGac7oeM
 /va9LktvaOowlDPivfb2cj2oVqzy93DFf3v6KMx4JvNWcpp8Z1Y+EfztnwwUdT1scDL1+/D3Ndo
 U0utsLP1g3QXby5RDSDJks6QhoCnT1+33j7I1YdoQCHoXfFQHa6ELgHk1u9JBFYQk6s3lEkOn2C
 ye/5SWuhciLxG8I0H/4k0LMp8rgZ+YDGQ22kdBFhlxOokHQElYtr/bgpp352A2POiIMHFbmirQg
 Pj7rQBgGKCK7pL/eyWiQTOpDzpBoUx68tWXckBdkxQ+BTQVbVeRgP0KHQ3Qf1wmk3aEl2DfjiU5
 0cmjukZhWed6LNG48NoVgrHinf2sLeiwl4TZ3U8WYYRRCDcimgl7ML2aUH/atFQL5G3KlbaBrWp
 pwOF/agChUJIN7VPREQuNqyHXh8ad4gKY6wdDhv+X+c9M50Xxb5GNaJ839duFOMr/rzDYjEOaco
 vGHxCmerngPhT5Q==
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

 Documentation/filesystems/9p.rst                   |   58 +-
 drivers/usb/gadget/configfs.c                      |    2 +-
 drivers/usb/gadget/function/f_fs.c                 |    2 +-
 drivers/usb/gadget/function/f_hid.c                |    2 +-
 drivers/usb/gadget/function/f_loopback.c           |    2 +-
 drivers/usb/gadget/function/f_midi.c               |    2 +-
 drivers/usb/gadget/function/f_midi2.c              |    2 +-
 drivers/usb/gadget/function/f_sourcesink.c         |    2 +-
 drivers/usb/gadget/u_f.c                           |    2 +-
 .../gadget/u_f.h => include/linux/usb/func_utils.h |    2 +-
 net/9p/Kconfig                                     |    6 +
 net/9p/Makefile                                    |    4 +
 net/9p/trans_usbg.c                                | 1006 ++++++++++++++++++++
 tools/usb/p9_fwd.py                                |  243 +++++
 14 files changed, 1325 insertions(+), 10 deletions(-)
---
base-commit: 2c9b3512402ed192d1f43f4531fb5da947e72bd0
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

