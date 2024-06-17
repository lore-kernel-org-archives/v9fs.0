Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABA186E56
	for <v9fs@lists.linux.dev>; Mon, 17 Jun 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624779; cv=none; b=tGsAL8L2aNy96YVZbwR0G+MUuLbE0iQvs0qgq0B9DinGsfkg0GPVHkh80EtTdiBoW2uy47fX9aT/rV2PD4N0TBKjLWCVFUOt2uGLcb+EpMVTIU/dRKHKgTQ8UzPXU4FwRkFubzBmS2DnKhKBrcSn26zKxRFqKHxrQ0IPpmSXMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624779; c=relaxed/simple;
	bh=VlJ5J9pZQ0M7PDCWB+NdhhSZorAccfOa2nkTpZBiK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFvYrYFGjwzjw3vJfkm1H4EYcyKVm4FpMpN3LfGmCv/KQhk745MtqK4efjZVCfD6DjqoIPNcx/b+RXGlnyXSLcc8vlzs1e5ecz4OMExh+WtTScMTeIwLogkeZOsmvHebHOAxgZkbYAjKFXrSQKRTsomdPjvhRpZTIJDVVbs4D8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sJAoF-0008Oy-8i; Mon, 17 Jun 2024 13:46:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sJAoD-002y1i-OA; Mon, 17 Jun 2024 13:46:01 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sJAoD-00G8wQ-26;
	Mon, 17 Jun 2024 13:46:01 +0200
Date: Mon, 17 Jun 2024 13:46:01 +0200
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
Subject: Re: [PATCH v6 3/3] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
Message-ID: <ZnAh-fIAnlFo_a7y@pengutronix.de>
References: <20240116-ml-topic-u9p-v6-0-695977d76dff@pengutronix.de>
 <20240116-ml-topic-u9p-v6-3-695977d76dff@pengutronix.de>
 <e6a39148-332d-4bed-900f-f22d131e2b29@collabora.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4Q/i+JIH56pJ4Mh"
Content-Disposition: inline
In-Reply-To: <e6a39148-332d-4bed-900f-f22d131e2b29@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: v9fs@lists.linux.dev


--n4Q/i+JIH56pJ4Mh
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 10:19:33AM +0200, Andrzej Pietrasiewicz wrote:
>Hi,
>
>W dniu 5.06.2024 o=A015:32, Michael Grzeschik pisze:
>>This patch is adding an small python tool to forward 9pfs requests
>>from the USB gadget to an existing 9pfs TCP server. Since currently all
>>9pfs servers lack support for the usb transport this tool is an useful
>>helper to get started.
>>
>>Refer the Documentation section "USBG Example" in
>>Documentation/filesystems/9p.rst on how to use it.
>>
>>Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>
>This time --id alone worked for me (as well as --id combined with --path)
>but --path alone did not:

This is currently right and expected. Why is using path alone of any
more use? Since you could then grab any device with two bulk endpoints
without even ensuring that it is supposed to behave as expected with
this script.


>$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 list
>Bus | Addr | Manufacturer     | Product          | ID        | Path
>--- | ---- | ---------------- | ---------------- | --------- | ----
>  3 |   39 | unknown          | unknown          | abcd:ef01 | 3-1.3.3.5.4
>
>$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 connect -p 9999
>2024-06-06 10:14:45,368 INFO     found device: 3/39 located at 3-1.3.3.5.4
>2024-06-06 10:14:45,369 INFO     claiming interface:
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
>2024-06-06 10:14:45,370 INFO     interface claimed
>2024-06-06 10:14:45,370 INFO     connected to server
>^C
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
>
>>---
>>v5 -> v6:
>>   - set path parameter to None when unused
>>v4 -> v5:
>>   - updated documentation for new subcommands list/connect
>>   - run ruff format
>>   - make vid and pid parameterized
>>   - add list as subcommand to scan for devices
>>   - move connect to extra subcommand
>>v3 -> v4: -
>>v2 -> v3: -
>>v1 -> v2:
>>   - added usbg 9pfs detailed instructions to 9p.rst doc
>>---
>>  Documentation/filesystems/9p.rst |  41 +++++++
>>  tools/usb/p9_fwd.py              | 243 ++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 284 insertions(+)
>>
>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems=
/9p.rst
>>index 10cf79dc287f8..2cc85f3e8659f 100644
>>--- a/Documentation/filesystems/9p.rst
>>+++ b/Documentation/filesystems/9p.rst
>>@@ -67,6 +67,47 @@ To mount a 9p FS on a USB Host accessible via the gadg=
et as root filesystem::
>>  where <device> is the tag associated by the usb gadget transport.
>>  It is defined by the configfs instance name.
>>+USBG Example
>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>+
>>+The USB host exports a filesystem, while the gadget on the USB device
>>+side makes it mountable.
>>+
>>+Diod (9pfs server) and the forwarder are on the development host, where
>>+the root filesystem is actually stored. The gadget is initialized during
>>+boot (or later) on the embedded board. Then the forwarder will find it
>>+on the USB bus and start forwarding requests.
>>+
>>+In this case the 9p requests come from the device and are handled by the
>>+host. The reason is that USB device ports are normally not available on
>>+PCs, so a connection in the other direction would not work.
>>+
>>+When using the usbg transport, for now there is no native usb host
>>+service capable to handle the requests from the gadget driver. For
>>+this we have to use the extra python tool p9_fwd.py from tools/usb.
>>+
>>+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
>>+
>>+        $ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
>>+
>>+Optionaly scan your bus if there are more then one usbg gadgets to find =
their path:
>>+
>>+        $ python $kernel_dir/tools/usb/p9_fwd.py list
>>+
>>+        Bus | Addr | Manufacturer     | Product          | ID        | P=
ath
>>+        --- | ---- | ---------------- | ---------------- | --------- | -=
---
>>+          2 |   67 | unknown          | unknown          | 1d6b:0109 | 2=
-1.1.2
>>+          2 |   68 | unknown          | unknown          | 1d6b:0109 | 2=
-1.1.3
>>+
>>+Then start the python transport:
>>+
>>+        $ python $kernel_dir/tools/usb/p9_fwd.py --path 2-1.1.2 connect =
-p 9999
>>+
>>+After that the gadget driver can be used as described above.
>>+
>>+One use-case is to use it as an alternative to NFS root booting during
>>+the development of embedded Linux devices.
>>+
>>  Options
>>  =3D=3D=3D=3D=3D=3D=3D
>>diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
>>new file mode 100755
>>index 0000000000000..12c76cbb046b7
>>--- /dev/null
>>+++ b/tools/usb/p9_fwd.py
>>@@ -0,0 +1,243 @@
>>+#!/usr/bin/env python3
>>+# SPDX-License-Identifier: GPL-2.0
>>+
>>+import argparse
>>+import errno
>>+import logging
>>+import socket
>>+import struct
>>+import time
>>+
>>+import usb.core
>>+import usb.util
>>+
>>+
>>+def path_from_usb_dev(dev):
>>+    """Takes a pyUSB device as argument and returns a string.
>>+    The string is a Path representation of the position of the USB devic=
e on the USB bus tree.
>>+
>>+    This path is used to find a USB device on the bus or all devices con=
nected to a HUB.
>>+    The path is made up of the number of the USB controller followed be =
the ports of the HUB tree."""
>>+    if dev.port_numbers:
>>+        dev_path =3D ".".join(str(i) for i in dev.port_numbers)
>>+        return f"{dev.bus}-{dev_path}"
>>+    return ""
>>+
>>+
>>+HEXDUMP_FILTER =3D "".join(chr(x).isprintable() and chr(x) or "." for x =
in range(128)) + "." * 128
>>+
>>+
>>+class Forwarder:
>>+    @staticmethod
>>+    def _log_hexdump(data):
>>+        if not logging.root.isEnabledFor(logging.TRACE):
>>+            return
>>+        L =3D 16
>>+        for c in range(0, len(data), L):
>>+            chars =3D data[c : c + L]
>>+            dump =3D " ".join(f"{x:02x}" for x in chars)
>>+            printable =3D "".join(HEXDUMP_FILTER[x] for x in chars)
>>+            line =3D f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
>>+            logging.root.log(logging.TRACE, "%s", line)
>>+
>>+    def __init__(self, server, vid, pid, path):
>>+        self.stats =3D {
>>+            "c2s packets": 0,
>>+            "c2s bytes": 0,
>>+            "s2c packets": 0,
>>+            "s2c bytes": 0,
>>+        }
>>+        self.stats_logged =3D time.monotonic()
>>+
>>+        def find_filter(dev):
>>+            dev_path =3D path_from_usb_dev(dev)
>>+            if path is not None:
>>+                return dev_path =3D=3D path
>>+            return True
>>+
>>+        dev =3D usb.core.find(idVendor=3Dvid, idProduct=3Dpid, custom_ma=
tch=3Dfind_filter)
>>+        if dev is None:
>>+            raise ValueError("Device not found")
>>+
>>+        logging.info(f"found device: {dev.bus}/{dev.address} located at =
{path_from_usb_dev(dev)}")
>>+
>>+        # dev.set_configuration() is not necessary since g_multi has onl=
y one
>>+        usb9pfs =3D None
>>+        # g_multi adds 9pfs as last interface
>>+        cfg =3D dev.get_active_configuration()
>>+        for intf in cfg:
>>+            # we have to detach the usb-storage driver from multi gadget=
 since
>>+            # stall option could be set, which will lead to spontaneous =
port
>>+            # resets and our transfers will run dead
>>+            if intf.bInterfaceClass =3D=3D 0x08:
>>+                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
>>+                    dev.detach_kernel_driver(intf.bInterfaceNumber)
>>+
>>+            if intf.bInterfaceClass =3D=3D 0xFF and intf.bInterfaceSubCl=
ass =3D=3D 0xFF and intf.bInterfaceProtocol =3D=3D 0x09:
>>+                usb9pfs =3D intf
>>+        if usb9pfs is None:
>>+            raise ValueError("Interface not found")
>>+
>>+        logging.info(f"claiming interface:\n{usb9pfs}")
>>+        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
>>+        ep_out =3D usb.util.find_descriptor(
>>+            usb9pfs,
>>+            custom_match=3Dlambda e: usb.util.endpoint_direction(e.bEndp=
ointAddress) =3D=3D usb.util.ENDPOINT_OUT,
>>+        )
>>+        assert ep_out is not None
>>+        ep_in =3D usb.util.find_descriptor(
>>+            usb9pfs,
>>+            custom_match=3Dlambda e: usb.util.endpoint_direction(e.bEndp=
ointAddress) =3D=3D usb.util.ENDPOINT_IN,
>>+        )
>>+        assert ep_in is not None
>>+        logging.info("interface claimed")
>>+
>>+        self.ep_out =3D ep_out
>>+        self.ep_in =3D ep_in
>>+        self.dev =3D dev
>>+
>>+        # create and connect socket
>>+        self.s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>+        self.s.connect(server)
>>+
>>+        logging.info("connected to server")
>>+
>>+    def c2s(self):
>>+        """forward a request from the USB client to the TCP server"""
>>+        data =3D None
>>+        while data is None:
>>+            try:
>>+                logging.log(logging.TRACE, "c2s: reading")
>>+                data =3D self.ep_in.read(self.ep_in.wMaxPacketSize)
>>+            except usb.core.USBTimeoutError:
>>+                logging.log(logging.TRACE, "c2s: reading timed out")
>>+                continue
>>+            except usb.core.USBError as e:
>>+                if e.errno =3D=3D errno.EIO:
>>+                    logging.debug("c2s: reading failed with %s, retrying=
", repr(e))
>>+                    time.sleep(0.5)
>>+                    continue
>>+                logging.error("c2s: reading failed with %s, aborting", r=
epr(e))
>>+                raise
>>+        size =3D struct.unpack("<I", data[:4])[0]
>>+        while len(data) < size:
>>+            data +=3D self.ep_in.read(size - len(data))
>>+        logging.log(logging.TRACE, "c2s: writing")
>>+        self._log_hexdump(data)
>>+        self.s.send(data)
>>+        logging.debug("c2s: forwarded %i bytes", size)
>>+        self.stats["c2s packets"] +=3D 1
>>+        self.stats["c2s bytes"] +=3D size
>>+
>>+    def s2c(self):
>>+        """forward a response from the TCP server to the USB client"""
>>+        logging.log(logging.TRACE, "s2c: reading")
>>+        data =3D self.s.recv(4)
>>+        size =3D struct.unpack("<I", data[:4])[0]
>>+        while len(data) < size:
>>+            data +=3D self.s.recv(size - len(data))
>>+        logging.log(logging.TRACE, "s2c: writing")
>>+        self._log_hexdump(data)
>>+        while data:
>>+            written =3D self.ep_out.write(data)
>>+            assert written > 0
>>+            data =3D data[written:]
>>+        if size % self.ep_out.wMaxPacketSize =3D=3D 0:
>>+            logging.log(logging.TRACE, "sending zero length packet")
>>+            self.ep_out.write(b"")
>>+        logging.debug("s2c: forwarded %i bytes", size)
>>+        self.stats["s2c packets"] +=3D 1
>>+        self.stats["s2c bytes"] +=3D size
>>+
>>+    def log_stats(self):
>>+        logging.info("statistics:")
>>+        for k, v in self.stats.items():
>>+            logging.info(f"  {k+':':14s} {v}")
>>+
>>+    def log_stats_interval(self, interval=3D5):
>>+        if (time.monotonic() - self.stats_logged) < interval:
>>+            return
>>+
>>+        self.log_stats()
>>+        self.stats_logged =3D time.monotonic()
>>+
>>+
>>+def try_get_usb_str(dev, name):
>>+    try:
>>+        with open(f"/sys/bus/usb/devices/{dev.bus}-{dev.address}/{name}"=
) as f:
>>+            return f.read().strip()
>>+    except FileNotFoundError:
>>+        return None
>>+
>>+
>>+def list_usb(args):
>>+    vid, pid =3D [int(x, 16) for x in args.id.split(":", 1)]
>>+
>>+    print("Bus | Addr | Manufacturer     | Product          | ID        =
| Path")
>>+    print("--- | ---- | ---------------- | ---------------- | --------- =
| ----")
>>+    for dev in usb.core.find(find_all=3DTrue, idVendor=3Dvid, idProduct=
=3Dpid):
>>+        path =3D path_from_usb_dev(dev) or ""
>>+        manufacturer =3D try_get_usb_str(dev, "manufacturer") or "unknow=
n"
>>+        product =3D try_get_usb_str(dev, "product") or "unknown"
>>+        print(
>>+            f"{dev.bus:3} | {dev.address:4} | {manufacturer:16} | {produ=
ct:16} | {dev.idVendor:04x}:{dev.idProduct:04x} | {path:18}"
>>+        )
>>+
>>+
>>+def connect(args):
>>+    vid, pid =3D [int(x, 16) for x in args.id.split(":", 1)]
>>+
>>+    f =3D Forwarder(server=3D(args.server, args.port), vid=3Dvid, pid=3D=
pid, path=3Dargs.path)
>>+
>>+    try:
>>+        while True:
>>+            f.c2s()
>>+            f.s2c()
>>+            f.log_stats_interval()
>>+    finally:
>>+        f.log_stats()
>>+
>>+
>>+def main():
>>+    parser =3D argparse.ArgumentParser(
>>+        description=3D"Forward 9PFS requests from USB to TCP",
>>+    )
>>+
>>+    parser.add_argument("--id", type=3Dstr, default=3D"1d6b:0109", help=
=3D"vid:pid of target device")
>>+    parser.add_argument("--path", type=3Dstr, required=3DFalse, help=3D"=
path of target device")
>>+    parser.add_argument("-v", "--verbose", action=3D"count", default=3D0)
>>+
>>+    subparsers =3D parser.add_subparsers()
>>+    subparsers.required =3D True
>>+    subparsers.dest =3D "command"
>>+
>>+    parser_list =3D subparsers.add_parser("list", help=3D"List all conne=
cted 9p gadgets")
>>+    parser_list.set_defaults(func=3Dlist_usb)
>>+
>>+    parser_connect =3D subparsers.add_parser(
>>+        "connect", help=3D"Forward messages between the usb9pfs gadget a=
nd the 9p server"
>>+    )
>>+    parser_connect.set_defaults(func=3Dconnect)
>>+    connect_group =3D parser_connect.add_argument_group()
>>+    connect_group.required =3D True
>>+    parser_connect.add_argument("-s", "--server", type=3Dstr, default=3D=
"127.0.0.1", help=3D"server hostname")
>>+    parser_connect.add_argument("-p", "--port", type=3Dint, default=3D56=
4, help=3D"server port")
>>+
>>+    args =3D parser.parse_args()
>>+
>>+    logging.TRACE =3D logging.DEBUG - 5
>>+    logging.addLevelName(logging.TRACE, "TRACE")
>>+
>>+    if args.verbose >=3D 2:
>>+        level =3D logging.TRACE
>>+    elif args.verbose:
>>+        level =3D logging.DEBUG
>>+    else:
>>+        level =3D logging.INFO
>>+    logging.basicConfig(level=3Dlevel, format=3D"%(asctime)-15s %(leveln=
ame)-8s %(message)s")
>>+
>>+    args.func(args)
>>+
>>+
>>+if __name__ =3D=3D "__main__":
>>+    main()
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--n4Q/i+JIH56pJ4Mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmZwIfYACgkQC+njFXoe
LGQv4Q/9HkKxy/HTtpPntvfDedlmOiCBTHESnixLOYf+Piz44DvzGI63uRJWIqOA
mpnASg7oGu2CIfF+laz0GWHUe+O8tsrGYSjRzq1V/Z22CwcegZb6Fy8sUguxhnbG
im44W46PkEXv9E64NwzmUbpN5YjmwJ9gh60E48iA2KHc5foL6CKsii7p06EzZcT6
eC/Bt5B55Pxl5y7pt7I+AYTIR30w6QLqDhD1VV50d8uEHm6XjCePX+4Xpu4dV9Di
1lNMSsFXQgnaefONHy2aLw/HatzApootu5E0UO1BcjoId6ntkg8I7GXCzaVGW2UN
Z5jPYN0LaQW0sXIAD/IYt/kdFG0P+Sukbt5Hi7epwJQgnVOrEUPmmC1+R/KAdcnO
oj5VubEAIJ0rNQA5nEFeft9pXQRn2+8osxwdpVPrSEK2QhErMImGtWFy0iVjAwc1
YwXVgz1sI/pGTt1ZfjFlG8kmUReXSSsknc6AwirZu2PEVuQjvF6PTiF7aYyLS3zx
WglkHYbrr91Ar+1A52t97mkeq2OfAq2gs6gmeZrJnnL3u4kMzUWFGKrFZ82sdKW5
6ekaguqrWf5pI2jNbtNY3tcqx969nGJXyHUNo7ZYyr1G/7MBIbKFCsn0gKCOAgHH
e9xFva5QmRND2Hq810oERGGcbMyfrThn/X6P1uPBxbbRT8VcOzw=
=/gp9
-----END PGP SIGNATURE-----

--n4Q/i+JIH56pJ4Mh--
