Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59414D710
	for <v9fs@lists.linux.dev>; Wed,  5 Jun 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594652; cv=none; b=aWmo1bcJsaOS/GzLYnp3KYqAiWYSeC/MAHhh9j7A1e9QSdGxy7mPIvY/ZB2v9KnX63TvN8zbu4Gc7V+gQZNbbagU345h3Q8l9AV51bvh88GARY4wkzuyHLpzsO2eLMAYpyvuaVsgCmyDjEePp/nihEeT50nIoASYCKUMlB6E98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594652; c=relaxed/simple;
	bh=dDH1CR3qK4c8i2ya6OhV3BwfuNZ0XL5RgsWDSNg4HYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQU0N3E+zPR0kscteh0+yNPj50hJtCnk2l2YpKtsCuM+/PvG2x9gNmjz6M2DNHc37K73tjo26BW/UV+reP7NpXc2rA+XldcGDb5OzwtYu1Np9TkHvmvMlrHRf2a0Sp964LaXnjfmTJk6LG03mHmm5ZJZUm6VsG+DEQRARztkbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sEqpO-0006va-4V; Wed, 05 Jun 2024 15:37:22 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sEqpN-000LIW-Bu; Wed, 05 Jun 2024 15:37:21 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sEqpN-00B9A4-0s;
	Wed, 05 Jun 2024 15:37:21 +0200
Date: Wed, 5 Jun 2024 15:37:21 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de, Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [PATCH v5 3/3] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
Message-ID: <ZmBqEbOBNS_ZsV7Y@pengutronix.de>
References: <20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutronix.de>
 <20240116-ml-topic-u9p-v5-3-5ed0abd53ef5@pengutronix.de>
 <50c62db3-060d-4b21-ae28-629003611e1a@collabora.com>
 <ZlehszQxJ5I0AvcE@pengutronix.de>
 <a4b04982-6fac-4492-8454-0878a143d80f@collabora.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KJKLLktfMCG4dMDv"
Content-Disposition: inline
In-Reply-To: <a4b04982-6fac-4492-8454-0878a143d80f@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--KJKLLktfMCG4dMDv
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 09:37:23AM +0200, Andrzej Pietrasiewicz wrote:
>Hi,
>
>W dniu 29.05.2024 o=A023:44, Michael Grzeschik pisze:
>>On Tue, May 28, 2024 at 08:41:12PM +0200, Andrzej Pietrasiewicz wrote:
>>>Hi,
>>>
>>>W dniu 28.05.2024 o=A000:08, Michael Grzeschik pisze:
>>>>This patch is adding an small python tool to forward 9pfs requests
>>>>from the USB gadget to an existing 9pfs TCP server. Since currently all
>>>>9pfs servers lack support for the usb transport this tool is an useful
>>>>helper to get started.
>>>>
>>>>Refer the Documentation section "USBG Example" in
>>>>Documentation/filesystems/9p.rst on how to use it.
>>>>
>>>>Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>>
>>>>---
>>>>v4 -> v5:
>>>>=A0 - updated documentation for new subcommands list/connect
>>>>=A0 - run ruff format
>>>>=A0 - make vid and pid parameterized
>>>
>>>Thanks for adding that.
>>>
>>>>=A0 - add list as subcommand to scan for devices
>>>>=A0 - move connect to extra subcommand
>>>>v3 -> v4: -
>>>>v2 -> v3: -
>>>>v1 -> v2:
>>>>=A0 - added usbg 9pfs detailed instructions to 9p.rst doc
>>>>---
>>>>=A0Documentation/filesystems/9p.rst |=A0 41 +++++++
>>>>=A0tools/usb/p9_fwd.py=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 243 +++=
++++++++++++++++++++++++++++++++++++
>>>>=A02 files changed, 284 insertions(+)
>>>>
>>>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesyste=
ms/9p.rst
>>>>index 10cf79dc287f8..2cc85f3e8659f 100644
>>>>--- a/Documentation/filesystems/9p.rst
>>>>+++ b/Documentation/filesystems/9p.rst
>>>>@@ -67,6 +67,47 @@ To mount a 9p FS on a USB Host accessible via the ga=
dget as root filesystem::
>>>>=A0where <device> is the tag associated by the usb gadget transport.
>>>>=A0It is defined by the configfs instance name.
>>>>+USBG Example
>>>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>+
>>>>+The USB host exports a filesystem, while the gadget on the USB device
>>>>+side makes it mountable.
>>>>+
>>>>+Diod (9pfs server) and the forwarder are on the development host, where
>>>>+the root filesystem is actually stored. The gadget is initialized duri=
ng
>>>>+boot (or later) on the embedded board. Then the forwarder will find it
>>>>+on the USB bus and start forwarding requests.
>>>>+
>>>>+In this case the 9p requests come from the device and are handled by t=
he
>>>>+host. The reason is that USB device ports are normally not available on
>>>>+PCs, so a connection in the other direction would not work.
>>>>+
>>>>+When using the usbg transport, for now there is no native usb host
>>>>+service capable to handle the requests from the gadget driver. For
>>>>+this we have to use the extra python tool p9_fwd.py from tools/usb.
>>>>+
>>>>+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 $ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
>>>>+
>>>>+Optionaly scan your bus if there are more then one usbg gadgets to fin=
d their path:
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 $ python $kernel_dir/tools/usb/p9_fwd.py list
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 Bus | Addr | Manufacturer=A0=A0=A0=A0 | Product=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 | ID=A0=A0=A0=A0=A0=A0=A0 | Path
>>>>+=A0=A0=A0=A0=A0=A0=A0 --- | ---- | ---------------- | ----------------=
 | --------- | ----
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 |=A0=A0 67 | unknown=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1d6b:0109 | 2-1.1.2
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 |=A0=A0 68 | unknown=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | unknown=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1d6b:0109 | 2-1.1.3
>>>>+
>>>>+Then start the python transport:
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 $ python $kernel_dir/tools/usb/p9_fwd.py --path =
2-1.1.2 connect -p 9999
>>>>+
>>>>+After that the gadget driver can be used as described above.
>>>>+
>>>>+One use-case is to use it as an alternative to NFS root booting during
>>>>+the development of embedded Linux devices.
>>>>+
>>>>=A0Options
>>>>=A0=3D=3D=3D=3D=3D=3D=3D
>>>>diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
>>>>new file mode 100755
>>>>index 0000000000000..7bedefce75c7b
>>>>--- /dev/null
>>>>+++ b/tools/usb/p9_fwd.py
>>>>@@ -0,0 +1,243 @@
>>>>+#!/usr/bin/env python3
>>>>+# SPDX-License-Identifier: GPL-2.0
>>>>+
>>>>+import argparse
>>>>+import errno
>>>>+import logging
>>>>+import socket
>>>>+import struct
>>>>+import time
>>>>+
>>>>+import usb.core
>>>>+import usb.util
>>>>+
>>>>+
>>>>+def path_from_usb_dev(dev):
>>>>+=A0=A0=A0 """Takes a pyUSB device as argument and returns a string.
>>>>+=A0=A0=A0 The string is a Path representation of the position of the U=
SB device on the USB bus tree.
>>>>+
>>>>+=A0=A0=A0 This path is used to find a USB device on the bus or all dev=
ices connected to a HUB.
>>>>+=A0=A0=A0 The path is made up of the number of the USB controller foll=
owed be the ports of the HUB tree."""
>>>>+=A0=A0=A0 if dev.port_numbers:
>>>>+=A0=A0=A0=A0=A0=A0=A0 dev_path =3D ".".join(str(i) for i in dev.port_n=
umbers)
>>>>+=A0=A0=A0=A0=A0=A0=A0 return f"{dev.bus}-{dev_path}"
>>>>+=A0=A0=A0 return ""
>>>>+
>>>>+
>>>>+HEXDUMP_FILTER =3D "".join(chr(x).isprintable() and chr(x) or "." for =
x in range(128)) + "." * 128
>>>>+
>>>>+
>>>>+class Forwarder:
>>>>+=A0=A0=A0 @staticmethod
>>>>+=A0=A0=A0 def _log_hexdump(data):
>>>>+=A0=A0=A0=A0=A0=A0=A0 if not logging.root.isEnabledFor(logging.TRACE):
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return
>>>>+=A0=A0=A0=A0=A0=A0=A0 L =3D 16
>>>>+=A0=A0=A0=A0=A0=A0=A0 for c in range(0, len(data), L):
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chars =3D data[c : c + L]
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dump =3D " ".join(f"{x:02x}" for x i=
n chars)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printable =3D "".join(HEXDUMP_FILTER=
[x] for x in chars)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 line =3D f"{c:08x}=A0 {dump:{L*3}s} =
|{printable:{L}s}|"
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.root.log(logging.TRACE, "%s"=
, line)
>>>>+
>>>>+=A0=A0=A0 def __init__(self, server, vid, pid, path):
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats =3D {
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "c2s packets": 0,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "c2s bytes": 0,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "s2c packets": 0,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "s2c bytes": 0,
>>>>+=A0=A0=A0=A0=A0=A0=A0 }
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats_logged =3D time.monotonic()
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 def find_filter(dev):
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_path =3D path_from_usb_dev(dev)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if path is not None:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_path =3D=3D p=
ath
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return True
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 dev =3D usb.core.find(idVendor=3Dvid, idProduct=
=3Dpid, custom_match=3Dfind_filter)
>>>>+=A0=A0=A0=A0=A0=A0=A0 if dev is None:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise ValueError("Device not found")
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"found device: {dev.bus}/{dev.addr=
ess} located at {path_from_usb_dev(dev)}")
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 # dev.set_configuration() is not necessary since=
 g_multi has only one
>>>>+=A0=A0=A0=A0=A0=A0=A0 usb9pfs =3D None
>>>>+=A0=A0=A0=A0=A0=A0=A0 # g_multi adds 9pfs as last interface
>>>>+=A0=A0=A0=A0=A0=A0=A0 cfg =3D dev.get_active_configuration()
>>>>+=A0=A0=A0=A0=A0=A0=A0 for intf in cfg:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # we have to detach the usb-storage =
driver from multi gadget since
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # stall option could be set, which w=
ill lead to spontaneous port
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # resets and our transfers will run =
dead
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if intf.bInterfaceClass =3D=3D 0x08:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if dev.is_kernel_driver_=
active(intf.bInterfaceNumber):
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev.detach_k=
ernel_driver(intf.bInterfaceNumber)
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if intf.bInterfaceClass =3D=3D 0xFF =
and intf.bInterfaceSubClass =3D=3D 0xFF and intf.bInterfaceProtocol =3D=3D =
0x09:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs =3D intf
>>>>+=A0=A0=A0=A0=A0=A0=A0 if usb9pfs is None:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise ValueError("Interface not foun=
d")
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"claiming interface:\n{usb9pfs}")
>>>>+=A0=A0=A0=A0=A0=A0=A0 usb.util.claim_interface(dev, usb9pfs.bInterface=
Number)
>>>>+=A0=A0=A0=A0=A0=A0=A0 ep_out =3D usb.util.find_descriptor(
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 custom_match=3Dlambda e: usb.util.en=
dpoint_direction(e.bEndpointAddress) =3D=3D usb.util.ENDPOINT_OUT,
>>>>+=A0=A0=A0=A0=A0=A0=A0 )
>>>>+=A0=A0=A0=A0=A0=A0=A0 assert ep_out is not None
>>>>+=A0=A0=A0=A0=A0=A0=A0 ep_in =3D usb.util.find_descriptor(
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs,
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 custom_match=3Dlambda e: usb.util.en=
dpoint_direction(e.bEndpointAddress) =3D=3D usb.util.ENDPOINT_IN,
>>>>+=A0=A0=A0=A0=A0=A0=A0 )
>>>>+=A0=A0=A0=A0=A0=A0=A0 assert ep_in is not None
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info("interface claimed")
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.ep_out =3D ep_out
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.ep_in =3D ep_in
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.dev =3D dev
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 # create and connect socket
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.s =3D socket.socket(socket.AF_INET, socket.=
SOCK_STREAM)
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.s.connect(server)
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info("connected to server")
>>>>+
>>>>+=A0=A0=A0 def c2s(self):
>>>>+=A0=A0=A0=A0=A0=A0=A0 """forward a request from the USB client to the =
TCP server"""
>>>>+=A0=A0=A0=A0=A0=A0=A0 data =3D None
>>>>+=A0=A0=A0=A0=A0=A0=A0 while data is None:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 try:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRAC=
E, "c2s: reading")
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data =3D self.ep_in.read=
(self.ep_in.wMaxPacketSize)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 except usb.core.USBTimeoutError:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRAC=
E, "c2s: reading timed out")
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 except usb.core.USBError as e:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if e.errno =3D=3D errno.=
EIO:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.debu=
g("c2s: reading failed with %s, retrying", repr(e))
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 time.sleep(0=
=2E5)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.error("c2s: read=
ing failed with %s, aborting", repr(e))
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise
>>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D struct.unpack("<I", data[:4])[0]
>>>>+=A0=A0=A0=A0=A0=A0=A0 while len(data) < size:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data +=3D self.ep_in.read(size - len=
(data))
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "c2s: writing")
>>>>+=A0=A0=A0=A0=A0=A0=A0 self._log_hexdump(data)
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.s.send(data)
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.debug("c2s: forwarded %i bytes", size)
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["c2s packets"] +=3D 1
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["c2s bytes"] +=3D size
>>>>+
>>>>+=A0=A0=A0 def s2c(self):
>>>>+=A0=A0=A0=A0=A0=A0=A0 """forward a response from the TCP server to the=
 USB client"""
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "s2c: reading")
>>>>+=A0=A0=A0=A0=A0=A0=A0 data =3D self.s.recv(4)
>>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D struct.unpack("<I", data[:4])[0]
>>>>+=A0=A0=A0=A0=A0=A0=A0 while len(data) < size:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data +=3D self.s.recv(size - len(dat=
a))
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "s2c: writing")
>>>>+=A0=A0=A0=A0=A0=A0=A0 self._log_hexdump(data)
>>>>+=A0=A0=A0=A0=A0=A0=A0 while data:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 written =3D self.ep_out.write(data)
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert written > 0
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data =3D data[written:]
>>>>+=A0=A0=A0=A0=A0=A0=A0 if size % self.ep_out.wMaxPacketSize =3D=3D 0:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "sending =
zero length packet")
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.ep_out.write(b"")
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.debug("s2c: forwarded %i bytes", size)
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["s2c packets"] +=3D 1
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["s2c bytes"] +=3D size
>>>>+
>>>>+=A0=A0=A0 def log_stats(self):
>>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info("statistics:")
>>>>+=A0=A0=A0=A0=A0=A0=A0 for k, v in self.stats.items():
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.info(f"=A0 {k+':':14s} {v}")
>>>>+
>>>>+=A0=A0=A0 def log_stats_interval(self, interval=3D5):
>>>>+=A0=A0=A0=A0=A0=A0=A0 if (time.monotonic() - self.stats_logged) < inte=
rval:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return
>>>>+
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.log_stats()
>>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats_logged =3D time.monotonic()
>>>>+
>>>>+
>>>>+def try_get_usb_str(dev, name):
>>>>+=A0=A0=A0 try:
>>>>+=A0=A0=A0=A0=A0=A0=A0 with open(f"/sys/bus/usb/devices/{dev.bus}-{dev.=
address}/{name}") as f:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return f.read().strip()
>>>>+=A0=A0=A0 except FileNotFoundError:
>>>>+=A0=A0=A0=A0=A0=A0=A0 return None
>>>>+
>>>>+
>>>>+def list_usb(args):
>>>>+=A0=A0=A0 vid, pid =3D [int(x, 16) for x in args.id.split(":", 1)]
>>>>+
>>>>+=A0=A0=A0 print("Bus | Addr | Manufacturer=A0=A0=A0=A0 | Product=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | ID=A0=A0=A0=A0=A0=A0=A0 | Path")
>>>>+=A0=A0=A0 print("--- | ---- | ---------------- | ---------------- | --=
------- | ----")
>>>>+=A0=A0=A0 for dev in usb.core.find(find_all=3DTrue, idVendor=3Dvid, id=
Product=3Dpid):
>>>>+=A0=A0=A0=A0=A0=A0=A0 path =3D path_from_usb_dev(dev) or ""
>>>>+=A0=A0=A0=A0=A0=A0=A0 manufacturer =3D try_get_usb_str(dev, "manufactu=
rer") or "unknown"
>>>>+=A0=A0=A0=A0=A0=A0=A0 product =3D try_get_usb_str(dev, "product") or "=
unknown"
>>>>+=A0=A0=A0=A0=A0=A0=A0 print(
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f"{dev.bus:3} | {dev.address:4} | {m=
anufacturer:16} | {product:16} | {dev.idVendor:04x}:{dev.idProduct:04x} | {=
path:18}"
>>>>+=A0=A0=A0=A0=A0=A0=A0 )
>>>>+
>>>>+
>>>>+def connect(args):
>>>>+=A0=A0=A0 vid, pid =3D [int(x, 16) for x in args.id.split(":", 1)]
>>>>+
>>>>+=A0=A0=A0 f =3D Forwarder(server=3D(args.server, args.port), vid=3Dvid=
, pid=3Dpid, path=3Dargs.path)
>>>>+
>>>>+=A0=A0=A0 try:
>>>>+=A0=A0=A0=A0=A0=A0=A0 while True:
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.c2s()
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.s2c()
>>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.log_stats_interval()
>>>>+=A0=A0=A0 finally:
>>>>+=A0=A0=A0=A0=A0=A0=A0 f.log_stats()
>>>>+
>>>>+
>>>>+def main():
>>>>+=A0=A0=A0 parser =3D argparse.ArgumentParser(
>>>>+=A0=A0=A0=A0=A0=A0=A0 description=3D"Forward 9PFS requests from USB to=
 TCP",
>>>>+=A0=A0=A0 )
>>>>+
>>>>+=A0=A0=A0 parser.add_argument("--id", type=3Dstr, default=3D"1d6b:0109=
", help=3D"vid:pid of target device")
>>>>+=A0=A0=A0 parser.add_argument("--path", type=3Dstr, default=3D"", help=
=3D"path of target device")
>>>
>>>I had to specify both --id and --path, otherwise I was getting
>>>"device not found".
>>
>>This is odd. What was your list command saying about the available
>>devices?
>>
>
><snip>
>
>[ 4260.577064] usb 3-1.3.3.5.4: new high-speed USB device number 25 using =
xhci_hcd
>[ 4260.677769] usb 3-1.3.3.5.4: New USB device found, idVendor=3Dabcd, idP=
roduct=3Def01, bcdDevice=3D 6.09
>[ 4260.677788] usb 3-1.3.3.5.4: New USB device strings: Mfr=3D0, Product=
=3D0, SerialNumber=3D0
>
><snip>
>
>$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 list
>Bus | Addr | Manufacturer     | Product          | ID        | Path
>--- | ---- | ---------------- | ---------------- | --------- | ----
>  3 |   25 | unknown          | unknown          | abcd:ef01 | 3-1.3.3.5.4
>
>
>$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 connect -p 9999
>Traceback (most recent call last):
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 243, in <m=
odule>
>    main()
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 239, in ma=
in
>    args.func(args)
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 190, in co=
nnect
>    f =3D Forwarder(server=3D(args.server, args.port), vid=3Dvid, pid=3Dpi=
d, path=3Dargs.path)
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 60, in __i=
nit__
>    raise ValueError("Device not found")
>ValueError: Device not found
>
>$ sudo python3 tools/usb/p9_fwd.py --path 3-1.3.3.5.4 connect -p 9999
>Traceback (most recent call last):
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 243, in <m=
odule>
>    main()
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 239, in ma=
in
>    args.func(args)
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 190, in co=
nnect
>    f =3D Forwarder(server=3D(args.server, args.port), vid=3Dvid, pid=3Dpi=
d, path=3Dargs.path)
>  File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 60, in __i=
nit__
>    raise ValueError("Device not found")
>ValueError: Device not found
>
>$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 --path 3-1.3.3.5.4 c=
onnect -p 9999
>2024-05-31 09:34:44,047 INFO     found device: 3/25 located at 3-1.3.3.5.4
>2024-05-31 09:34:44,053 INFO     claiming interface:
>    INTERFACE 0: Vendor Specific =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     bLength            :    0x9 (9 bytes)
>     bDescriptorType    :    0x4 Interface
>     bInterfaceNumber   :    0x0
>     bAlternateSetting  :    0x0
>     bNumEndpoints      :    0x2
>     bInterfaceClass    :   0xff Vendor Specific
>     bInterfaceSubClass :   0xff
>     bInterfaceProtocol :    0x9
>     iInterface         :    0x1 usb9pfs input to output
>      ENDPOINT 0x81: Bulk IN =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       bLength          :    0x7 (7 bytes)
>       bDescriptorType  :    0x5 Endpoint
>       bEndpointAddress :   0x81 IN
>       bmAttributes     :    0x2 Bulk
>       wMaxPacketSize   :  0x200 (512 bytes)
>       bInterval        :    0x0
>      ENDPOINT 0x1: Bulk OUT =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>       bLength          :    0x7 (7 bytes)
>       bDescriptorType  :    0x5 Endpoint
>       bEndpointAddress :    0x1 OUT
>       bmAttributes     :    0x2 Bulk
>       wMaxPacketSize   :  0x200 (512 bytes)
>       bInterval        :    0x0
>2024-05-31 09:34:44,054 INFO     interface claimed
>2024-05-31 09:34:44,054 INFO     connected to server

Ok, there was a bug that args.path wath never None. Therefor it was
always necessary. While there I also fixed the short window
between gadget load and mount, where the user could actually
use unprepared endpoints which led to some NULL pointer derefs.

Please try my last series v6:

https://lore.kernel.org/all/20240116-ml-topic-u9p-v6-0-695977d76dff@pengutr=
onix.de/

Regards,
Michael

>>I tested this with the default vid:pid as described above (1d6b:0109)
>>which worked fine with path alone.
>>
>>Michael
>>
>>>>+=A0=A0=A0 parser.add_argument("-v", "--verbose", action=3D"count", def=
ault=3D0)
>>>>+
>>>>+=A0=A0=A0 subparsers =3D parser.add_subparsers()
>>>>+=A0=A0=A0 subparsers.required =3D True
>>>>+=A0=A0=A0 subparsers.dest =3D "command"
>>>>+
>>>>+=A0=A0=A0 parser_list =3D subparsers.add_parser("list", help=3D"List a=
ll connected 9p gadgets")
>>>>+=A0=A0=A0 parser_list.set_defaults(func=3Dlist_usb)
>>>>+
>>>>+=A0=A0=A0 parser_connect =3D subparsers.add_parser(
>>>>+=A0=A0=A0=A0=A0=A0=A0 "connect", help=3D"Forward messages between the =
usb9pfs gadget and the 9p server"
>>>>+=A0=A0=A0 )
>>>>+=A0=A0=A0 parser_connect.set_defaults(func=3Dconnect)
>>>>+=A0=A0=A0 connect_group =3D parser_connect.add_argument_group()
>>>>+=A0=A0=A0 connect_group.required =3D True
>>>>+=A0=A0=A0 parser_connect.add_argument("-s", "--server", type=3Dstr, de=
fault=3D"127.0.0.1", help=3D"server hostname")
>>>>+=A0=A0=A0 parser_connect.add_argument("-p", "--port", type=3Dint, defa=
ult=3D564, help=3D"server port")> +
>>>>+=A0=A0=A0 args =3D parser.parse_args()
>>>>+
>>>>+=A0=A0=A0 logging.TRACE =3D logging.DEBUG - 5
>>>>+=A0=A0=A0 logging.addLevelName(logging.TRACE, "TRACE")
>>>>+
>>>>+=A0=A0=A0 if args.verbose >=3D 2:
>>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.TRACE
>>>>+=A0=A0=A0 elif args.verbose:
>>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.DEBUG
>>>>+=A0=A0=A0 else:
>>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.INFO
>>>>+=A0=A0=A0 logging.basicConfig(level=3Dlevel, format=3D"%(asctime)-15s =
%(levelname)-8s %(message)s")
>>>>+
>>>>+=A0=A0=A0 args.func(args)
>>>>+
>>>>+
>>>>+if __name__ =3D=3D "__main__":
>>>>+=A0=A0=A0 main()
>>>>
>>>
>>>
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--KJKLLktfMCG4dMDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZgagoACgkQC+njFXoe
LGS+7A/7BvKk7JuuayflF7hSdbW40zF97SwqwXRHGNg0PNDL17EL98tG3h9H1Otj
Ih8H7nFniaXnBLWrykKtDXAqKhdzxFQc8vKBNktox2TOu1roBW7IwV9ZLs9tSuBG
E/YYHB8gLoA79ORC/c4Jxzg/LCKskVO+Y8XitKEMmEiAHcNOrncJ9va0TOoSL/sz
iroZuLc4oiJ5VxAYTGy5IynXMtd2E5yCgMvW5rIGAPbcBiYzfk7DCsbj+Dk28YsV
oqoarmeLqF2q8K7+J+JXKpMhVTKPBMYH5oN+7qqBn9Brvz0gU3u7t5GNsl4nGGZR
H4GqPHzNgw6gF1+WLF3RTscjD2JmqKn5w2QoJjaaOJrB5vzOSl+QneTKuP/Bta6k
66bK8x35/W2PkSQkIH1MT6jQbPpc3nXC+s9d5YZGsD5clbvZjwN8OyZedh7BpRuj
wZktfrBBJojSQ5TmfI5ggP/1uhQFYYfQPBfw15mOF7bfEFThxuipxFy8D1aVKW4P
foE/b3wH9q2th/sja7nP992/f2OUIfcgaU8gfxRx2aDH1pYweN0vVBGwYabywYX2
tssti/yKdql3rpI/wywWCmOg1PT62kpOb3Els1WqJlyWxmyl2uHSolWFPhNJD8qz
gV1Zy5kXQdntO4eMi6V7MAysTpb3qDwwy1e+0TOPPhJgbO7mzrs=
=utz9
-----END PGP SIGNATURE-----

--KJKLLktfMCG4dMDv--
