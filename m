Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B14433C7
	for <v9fs@lists.linux.dev>; Tue, 28 May 2024 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873590; cv=none; b=OiZxWr4U5QqwpEEdqrzgm3/XgC9+Dfok+WbApNyQR9xnUxLg1vlsj+wO8jNFSJdT+dVbBH71vaYXSzNcNTeQvxjl8jhYvPGmHdU6SFtJKjxvT+yj3kYut3DPK9LIvqH+SgVpDxkDKwNMwI/DduLyeZPwBZgi+SbPmdva0zbIjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873590; c=relaxed/simple;
	bh=S2Fz2uaP+vZPWzzsBx2XnlWH/OJKX78ArEZDsqBHl3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg9fh3QQQ+IP76D8w0K+wJEZ1sx08MZDcKWjJqsrzMcMNgGxsf+QloZed5xMcPm8OqZsBM/iOOEVBrKviT/ZLOqUZUqLB1Eu9M2yx4uJmzk2/eUDCzIJPLAvdSg47nuuZqSlMQR/atQSNk8iYkchZHegnpbdc715qKKf0F514Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpFG-0005EO-Qc; Tue, 28 May 2024 07:19:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpFF-003Hdh-Py; Tue, 28 May 2024 07:19:33 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sBpFF-001G3p-2G;
	Tue, 28 May 2024 07:19:33 +0200
Date: Tue, 28 May 2024 07:19:33 +0200
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
	kernel@pengutronix.de
Subject: Re: [PATCH v4 3/3] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
Message-ID: <ZlVpZdMHiKoO-pht@pengutronix.de>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-3-722ed28b0ade@pengutronix.de>
 <e1c8cc99-47e3-4780-87c8-9f4da370ac4b@collabora.com>
 <cc5073ea-40b4-47a8-845b-95ee70846560@collabora.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mkw9ISFGf4nloy4Q"
Content-Disposition: inline
In-Reply-To: <cc5073ea-40b4-47a8-845b-95ee70846560@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--Mkw9ISFGf4nloy4Q
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:32:11AM +0200, Andrzej Pietrasiewicz wrote:
>Hi Michael,
>
>W dniu 10.05.2024 o=A010:29, Andrzej Pietrasiewicz pisze:
>>Hi Michael,
>>
>>W dniu 30.04.2024 o=A001:33, Michael Grzeschik pisze:
>>>This patch is adding an small python tool to forward 9pfs requests
>>>from the USB gadget to an existing 9pfs TCP server. Since currently all
>>>9pfs servers lack support for the usb transport this tool is an useful
>>>helper to get started.
>>>
>>>Refer the Documentation section "USBG Example" in
>>>Documentation/filesystems/9p.rst on how to use it.
>>>
>>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>
>>>---
>>>v3 -> v4: -
>>>v2 -> v3: -
>>>v1 -> v2:
>>>=A0=A0 - added usbg 9pfs detailed instructions to 9p.rst doc
>>>---
>>>=A0 Documentation/filesystems/9p.rst |=A0 32 +++++++
>>>=A0 tools/usb/p9_fwd.py=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 194 +++=
++++++++++++++++++++++++++++++++++++
>>>=A0 2 files changed, 226 insertions(+)
>>>
>>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystem=
s/9p.rst
>>>index 10cf79dc287f8..2467f1ea4a150 100644
>>>--- a/Documentation/filesystems/9p.rst
>>>+++ b/Documentation/filesystems/9p.rst
>>>@@ -67,6 +67,38 @@ To mount a 9p FS on a USB Host accessible via=20
>>>the gadget as root filesystem::
>>>=A0 where <device> is the tag associated by the usb gadget transport.
>>>=A0 It is defined by the configfs instance name.
>>>+USBG Example
>>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>+
>>>+The USB host exports a filesystem, while the gadget on the USB device
>>>+side makes it mountable.
>>>+
>>>+Diod (9pfs server) and the forwarder are on the development host, where
>>>+the root filesystem is actually stored. The gadget is initialized during
>>>+boot (or later) on the embedded board. Then the forwarder will find it
>>>+on the USB bus and start forwarding requests.
>>>+
>>>+In this case the 9p requests come from the device and are handled by the
>>>+host. The reason is that USB device ports are normally not available on
>>>+PCs, so a connection in the other direction would not work.
>>>+
>>>+When using the usbg transport, for now there is no native usb host
>>>+service capable to handle the requests from the gadget driver. For
>>>+this we have to use the extra python tool p9_fwd.py from tools/usb.
>>>+
>>>+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
>>>+
>>>+=A0=A0=A0 $ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
>>>+
>>>+Then start the python transport:
>>>+
>>>+=A0=A0=A0 $ python $kernel_dir/tools/usb/p9_fwd.py -p 9999
>>>+
>>>+After that the gadget driver can be used as described above.
>>>+
>>>+One use-case is to use it as an alternative to NFS root booting during
>>>+the development of embedded Linux devices.
>>>+
>>>=A0 Options
>>>=A0 =3D=3D=3D=3D=3D=3D=3D
>>>diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
>>>new file mode 100755
>>>index 0000000000000..95208df11abef
>>>--- /dev/null
>>>+++ b/tools/usb/p9_fwd.py
>>>@@ -0,0 +1,194 @@
>>>+#!/usr/bin/env python3
>>>+# SPDX-License-Identifier: GPL-2.0
>>>+
>>>+import argparse
>>>+import errno
>>>+import logging
>>>+import socket
>>>+import struct
>>>+import sys
>>>+import time
>>>+
>>>+import usb.core
>>>+import usb.util
>>>+
>>>+
>>>+class Forwarder:
>>>+=A0=A0=A0 HEXDUMP_FILTER =3D (
>>>+=A0=A0=A0=A0=A0=A0=A0 "".join(chr(x).isprintable() and chr(x) or "." fo=
r x in=20
>>>range(128)) + "." * 128
>>>+=A0=A0=A0 )
>>>+
>>>+=A0=A0=A0 @staticmethod
>>>+=A0=A0=A0 def _log_hexdump(data):
>>>+=A0=A0=A0=A0=A0=A0=A0 if not logging.root.isEnabledFor(logging.TRACE):
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return
>>>+=A0=A0=A0=A0=A0=A0=A0 L =3D 16
>>>+=A0=A0=A0=A0=A0=A0=A0 for c in range(0, len(data), L):
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chars =3D data[c : c + L]
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dump =3D " ".join(f"{x:02x}" for x in=
 chars)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printable =3D "".join(HEXDUMP_FILTER[=
x] for x in chars)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 line =3D f"{c:08x}=A0 {dump:{L*3}s} |=
{printable:{L}s}|"
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.root.log(logging.TRACE, "%s",=
 line)
>>>+
>>>+=A0=A0=A0 def __init__(self, server):
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats =3D {
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "c2s packets": 0,
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "c2s bytes": 0,
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "s2c packets": 0,
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "s2c bytes": 0,
>>>+=A0=A0=A0=A0=A0=A0=A0 }
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats_logged =3D time.monotonic()
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 dev =3D usb.core.find(idVendor=3D0x1D6B, idProduc=
t=3D0x0109)
>>
>>Is this idProduct an assigned number? I can't find it in
>>http://www.linux-usb.org/usb.ids. The "9" is obviously a pun on 9pfs,
>>a nice trick and it would make sense.
>>
>>However, given composition with configfs there's no guarantee that 9pfs w=
ill be
>>the only USB gadget function present, and so it is not quite clear that L=
inux
>>Foundation's vendor and product ids are always appropriate. What's more, =
when
>>you are not going to the market with products you can use whatever ids you
>>please for your own use.
>>
>>Given the above, I'd love these two (idVendor and idProduct) to be comman=
dline
>>parameters of this script. My user story: whenever I created a gadget with
>>configfs it had different ids than the above and this script wouldn't wor=
k.
>
>And actually it is perfectly possible to have more than one USB device with
>_the same_ vendor and product ids connected. How would this script behave =
if
>that's the case?

I updated the script in v5 to support the subcommand "list" to show all
available devices and their usb path. Together with the configurable
option to select the vid/pid it is now possibleto address the exact
device you want to forward.

https://lore.kernel.org/all/20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutr=
onix.dej/

Regards,
Michael


>>>+=A0=A0=A0=A0=A0=A0=A0 if dev is None:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise ValueError("Device not found")
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"found device: {dev.bus}/{dev.addre=
ss}")
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 # dev.set_configuration() is not necessary since =
g_multi has only one
>>>+=A0=A0=A0=A0=A0=A0=A0 usb9pfs =3D None
>>>+=A0=A0=A0=A0=A0=A0=A0 # g_multi adds 9pfs as last interface
>>>+=A0=A0=A0=A0=A0=A0=A0 cfg =3D dev.get_active_configuration()
>>>+=A0=A0=A0=A0=A0=A0=A0 for intf in cfg:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # we have to detach the usb-storage d=
river from multi gadget since
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # stall option could be set, which wi=
ll lead to spontaneous port
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # resets and our transfers will run d=
ead
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if intf.bInterfaceClass =3D=3D 0x08:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if dev.is_kernel_driver_a=
ctive(intf.bInterfaceNumber):
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev.detach_ke=
rnel_driver(intf.bInterfaceNumber)
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 intf.bInterfaceClass =3D=
=3D 0xFF
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and intf.bInterfaceSubCla=
ss =3D=3D 0xFF
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and intf.bInterfaceProtoc=
ol =3D=3D 0x09
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ):
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs =3D intf
>>>+=A0=A0=A0=A0=A0=A0=A0 if usb9pfs is None:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise ValueError("Interface not found=
")
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"claiming interface:\n{usb9pfs}")
>>>+=A0=A0=A0=A0=A0=A0=A0 usb.util.claim_interface(dev, usb9pfs.bInterfaceN=
umber)
>>>+=A0=A0=A0=A0=A0=A0=A0 ep_out =3D usb.util.find_descriptor(
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs,
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 custom_match=3Dlambda e:=20
>>>usb.util.endpoint_direction(e.bEndpointAddress)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D usb.util.ENDPOINT_OUT,
>>>+=A0=A0=A0=A0=A0=A0=A0 )
>>>+=A0=A0=A0=A0=A0=A0=A0 assert ep_out is not None
>>>+=A0=A0=A0=A0=A0=A0=A0 ep_in =3D usb.util.find_descriptor(
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb9pfs,
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 custom_match=3Dlambda e:=20
>>>usb.util.endpoint_direction(e.bEndpointAddress)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D usb.util.ENDPOINT_IN,
>>>+=A0=A0=A0=A0=A0=A0=A0 )
>>>+=A0=A0=A0=A0=A0=A0=A0 assert ep_in is not None
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"interface claimed")
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 self.ep_out =3D ep_out
>>>+=A0=A0=A0=A0=A0=A0=A0 self.ep_in =3D ep_in
>>>+=A0=A0=A0=A0=A0=A0=A0 self.dev =3D dev
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 # create and connect socket
>>>+=A0=A0=A0=A0=A0=A0=A0 self.s =3D socket.socket(socket.AF_INET, socket.S=
OCK_STREAM)
>>>+=A0=A0=A0=A0=A0=A0=A0 self.s.connect(server)
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info(f"connected to server")
>>>+
>>>+=A0=A0=A0 def c2s(self):
>>>+=A0=A0=A0=A0=A0=A0=A0 """forward a request from the USB client to the T=
CP server"""
>>>+=A0=A0=A0=A0=A0=A0=A0 data =3D None
>>>+=A0=A0=A0=A0=A0=A0=A0 while data is None:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 try:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE=
, "c2s: reading")
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data =3D self.ep_in.read(=
self.ep_in.wMaxPacketSize)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 except usb.core.USBTimeoutError:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE=
, "c2s: reading timed out")
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 except usb.core.USBError as e:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if e.errno =3D=3D errno.E=
IO:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.debug=
("c2s: reading failed with %s,=20
>>>retrying", repr(e))
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 time.sleep(0.=
5)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.error=
("c2s: reading failed with %s,=20
>>>aborting", repr(e))
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raise
>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D struct.unpack("<I", data[:4])[0]
>>>+=A0=A0=A0=A0=A0=A0=A0 while len(data) < size:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data +=3D self.ep_in.read(size - len(=
data))
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "c2s: writing")
>>>+=A0=A0=A0=A0=A0=A0=A0 self._log_hexdump(data)
>>>+=A0=A0=A0=A0=A0=A0=A0 self.s.send(data)
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.debug("c2s: forwarded %i bytes", size)
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["c2s packets"] +=3D 1
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["c2s bytes"] +=3D size
>>>+
>>>+=A0=A0=A0 def s2c(self):
>>>+=A0=A0=A0=A0=A0=A0=A0 """forward a response from the TCP server to the =
USB client"""
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "s2c: reading")
>>>+=A0=A0=A0=A0=A0=A0=A0 data =3D self.s.recv(4)
>>>+=A0=A0=A0=A0=A0=A0=A0 size =3D struct.unpack("<I", data[:4])[0]
>>>+=A0=A0=A0=A0=A0=A0=A0 while len(data) < size:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data +=3D self.s.recv(size - len(data=
))
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "s2c: writing")
>>>+=A0=A0=A0=A0=A0=A0=A0 self._log_hexdump(data)
>>>+=A0=A0=A0=A0=A0=A0=A0 while data:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 written =3D self.ep_out.write(data)
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert written > 0
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data =3D data[written:]
>>>+=A0=A0=A0=A0=A0=A0=A0 if size % self.ep_out.wMaxPacketSize =3D=3D 0:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.log(logging.TRACE, "sending z=
ero length packet")
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.ep_out.write(b"")
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.debug("s2c: forwarded %i bytes", size)
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["s2c packets"] +=3D 1
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats["s2c bytes"] +=3D size
>>>+
>>>+=A0=A0=A0 def log_stats(self):
>>>+=A0=A0=A0=A0=A0=A0=A0 logging.info("statistics:")
>>>+=A0=A0=A0=A0=A0=A0=A0 for k, v in self.stats.items():
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logging.info(f"=A0 {k+':':14s} {v}")
>>>+
>>>+=A0=A0=A0 def log_stats_interval(self, interval=3D5):
>>>+=A0=A0=A0=A0=A0=A0=A0 if (time.monotonic() - self.stats_logged) < inter=
val:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 self.log_stats()
>>>+=A0=A0=A0=A0=A0=A0=A0 self.stats_logged =3D time.monotonic()
>>>+
>>>+
>>>+def main():
>>>+=A0=A0=A0 parser =3D argparse.ArgumentParser(
>>>+=A0=A0=A0=A0=A0=A0=A0 description=3D"Forward 9PFS requests from USB to =
TCP",
>>>+=A0=A0=A0 )
>>>+
>>>+=A0=A0=A0 parser.add_argument(
>>>+=A0=A0=A0=A0=A0=A0=A0 "-s", "--server", type=3Dstr, default=3D"127.0.0.=
1", help=3D"server hostname"
>>>+=A0=A0=A0 )
>>>+=A0=A0=A0 parser.add_argument("-p", "--port", type=3Dint, default=3D564=
,=20
>>>help=3D"server port")
>>>+=A0=A0=A0 parser.add_argument("-v", "--verbose", action=3D"count", defa=
ult=3D0)
>>>+
>>>+=A0=A0=A0 args =3D parser.parse_args()
>>>+
>>>+=A0=A0=A0 logging.TRACE =3D logging.DEBUG - 5
>>>+=A0=A0=A0 logging.addLevelName(logging.TRACE, "TRACE")
>>>+
>>>+=A0=A0=A0 if args.verbose >=3D 2:
>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.TRACE
>>>+=A0=A0=A0 elif args.verbose:
>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.DEBUG
>>>+=A0=A0=A0 else:
>>>+=A0=A0=A0=A0=A0=A0=A0 level =3D logging.INFO
>>>+=A0=A0=A0 logging.basicConfig(
>>>+=A0=A0=A0=A0=A0=A0=A0 level=3Dlevel, format=3D"%(asctime)-15s %(levelna=
me)-8s %(message)s"
>>>+=A0=A0=A0 )
>>>+
>>>+=A0=A0=A0 f =3D Forwarder(server=3D(args.server, args.port))
>>>+
>>>+=A0=A0=A0 try:
>>>+=A0=A0=A0=A0=A0=A0=A0 while True:
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.c2s()
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.s2c()
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f.log_stats_interval()
>>>+=A0=A0=A0 finally:
>>>+=A0=A0=A0=A0=A0=A0=A0 f.log_stats()
>>>+
>>>+
>>>+if __name__ =3D=3D "__main__":
>>>+=A0=A0=A0 main()
>>>
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Mkw9ISFGf4nloy4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZVaWAACgkQC+njFXoe
LGQ6ng//ezmoqKxsAylO/Qzhtlc7ITM1jgaX810RYnJ/X+XPAohMaVlTbpPf+5XS
sN57Q0s53W1YZASfKALZh242tmymhjvoye2z1aTGxddHRHJu8y+GeHfagfTN/QAa
Kck5zt2q1h0fCC1/f7slMOjUxjW3hByMBpTUVflO8aA1B5SeGkpOQxAQ0hzHsuLZ
33zFrouRrMR/RASS8VC8+jsC23dg+EB1hOimraHpIsQ2sZUpY91J7FvgatsErZH8
ZPSndF2RhkV7o77m0FFHgwg1ySA9ULQb+SxWHtj6aSxFqAUqGmSz8mdftj5JFN7N
qTmym4w7DB24bAY+wdrix4YU18+XfUXwSw+rWUI/rY0rddUjH12eSdwVEA3I6/ve
HQrWH6P1TaNJdwkaJXIee0i7mKcEU7KXqcmzxYvgVOO5RobOBmQCyvkhij8sZF80
33BVRmhrbXdMYE3Vv14cRpqegnR/TuNUvr0l03M9i2opyO9iNK2spUuLKIKQ1K9b
m80fMXe+CqsqLywYmyPBb88nCgVxjMF9KEaypdrVVDpwNhlEGYkvbOfdORvvuXb1
wnu1BQInEA0LUzFDW0kDN/AVha/iR0rVmtr39knmONxQYqvsZzl7noJ3pmYpd1r6
mT3h2DliYtrpHUzFbCKpKDCkuyASW5n0SuiJx6BApwWIYs5inww=
=ATAh
-----END PGP SIGNATURE-----

--Mkw9ISFGf4nloy4Q--
