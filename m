Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF633C9
	for <v9fs@lists.linux.dev>; Fri, 31 May 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141049; cv=none; b=dZxEL0PsmuOILO4gq0ZF63kVch2kfU7fnmQX2ZVNDFu2xX26PZKsebzvwbS0xhkkyheQXvSKUsQziLyVgak07odYXQjgjZBz1511Jcf849n/hypVP1mzTAZnjczfRZUdDAkwr1zgMPvmQ65gjMZM19zWRBR19AwC6moylsvxenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141049; c=relaxed/simple;
	bh=1Y1xbqjaEjTZ/pN6vHCnPOFrHlGwFVGVOqCzuduS3GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlfnaGexrQK/3/EefuUx/l91oIq44twqamFSqZFazk/vZ+pHWAS0CUWdS1iHJaqkTd3xe1ouJMrMBcj8iv4J530SKeA1afxNlHagelS5AmLoSlKR2NGZg9ZpWMX2tcnT0LcVENHyHR0IXVYIkGYyXPSCCby06hRu6HkY/8GCsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bALMnNzG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bALMnNzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717141045;
	bh=1Y1xbqjaEjTZ/pN6vHCnPOFrHlGwFVGVOqCzuduS3GE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bALMnNzG+87La+4Fs466WUM/0gwzZH5tutD5UFAi9k4OItl0klqYtVHrPAaYtMhuM
	 g8RHqh9zzbC/ufBDRNXLNVrqGafZIdw+ZZKprmymKkkMjtLkvcCfnMy4iiDiViwz2d
	 WtUuW5vuAiWK+yirOzMm3xWCEczaBD+mNdgXNHE5H4RyHmklvuJn726LQ6kNrfzTib
	 3BNPvjBmfgytUB4xGjrn8Y5mPugWmGu46qqO1wivdhqgoA7B9HEPACppRoyzWz+yGw
	 EuC9ld+76sKY1Pd4meiEz5fQOPzQP20AVUBaGxf4hXeYkSFswRE00SrEAcbQeFTZDk
	 8EzHBf00tnDwA==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8218937820CD;
	Fri, 31 May 2024 07:37:24 +0000 (UTC)
Message-ID: <a4b04982-6fac-4492-8454-0878a143d80f@collabora.com>
Date: Fri, 31 May 2024 09:37:23 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, kernel@pengutronix.de,
 Jan Luebbe <jlu@pengutronix.de>
References: <20240116-ml-topic-u9p-v5-0-5ed0abd53ef5@pengutronix.de>
 <20240116-ml-topic-u9p-v5-3-5ed0abd53ef5@pengutronix.de>
 <50c62db3-060d-4b21-ae28-629003611e1a@collabora.com>
 <ZlehszQxJ5I0AvcE@pengutronix.de>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <ZlehszQxJ5I0AvcE@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

W dniu 29.05.2024 o 23:44, Michael Grzeschik pisze:
> On Tue, May 28, 2024 at 08:41:12PM +0200, Andrzej Pietrasiewicz wrote:
>> Hi,
>>
>> W dniu 28.05.2024 o 00:08, Michael Grzeschik pisze:
>>> This patch is adding an small python tool to forward 9pfs requests
>>> from the USB gadget to an existing 9pfs TCP server. Since currently all
>>> 9pfs servers lack support for the usb transport this tool is an useful
>>> helper to get started.
>>>
>>> Refer the Documentation section "USBG Example" in
>>> Documentation/filesystems/9p.rst on how to use it.
>>>
>>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>
>>> ---
>>> v4 -> v5:
>>>   - updated documentation for new subcommands list/connect
>>>   - run ruff format
>>>   - make vid and pid parameterized
>>
>> Thanks for adding that.
>>
>>>   - add list as subcommand to scan for devices
>>>   - move connect to extra subcommand
>>> v3 -> v4: -
>>> v2 -> v3: -
>>> v1 -> v2:
>>>   - added usbg 9pfs detailed instructions to 9p.rst doc
>>> ---
>>>  Documentation/filesystems/9p.rst |  41 +++++++
>>>  tools/usb/p9_fwd.py              | 243 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 284 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
>>> index 10cf79dc287f8..2cc85f3e8659f 100644
>>> --- a/Documentation/filesystems/9p.rst
>>> +++ b/Documentation/filesystems/9p.rst
>>> @@ -67,6 +67,47 @@ To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
>>>  where <device> is the tag associated by the usb gadget transport.
>>>  It is defined by the configfs instance name.
>>> +USBG Example
>>> +============
>>> +
>>> +The USB host exports a filesystem, while the gadget on the USB device
>>> +side makes it mountable.
>>> +
>>> +Diod (9pfs server) and the forwarder are on the development host, where
>>> +the root filesystem is actually stored. The gadget is initialized during
>>> +boot (or later) on the embedded board. Then the forwarder will find it
>>> +on the USB bus and start forwarding requests.
>>> +
>>> +In this case the 9p requests come from the device and are handled by the
>>> +host. The reason is that USB device ports are normally not available on
>>> +PCs, so a connection in the other direction would not work.
>>> +
>>> +When using the usbg transport, for now there is no native usb host
>>> +service capable to handle the requests from the gadget driver. For
>>> +this we have to use the extra python tool p9_fwd.py from tools/usb.
>>> +
>>> +Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
>>> +
>>> +        $ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
>>> +
>>> +Optionaly scan your bus if there are more then one usbg gadgets to find their path:
>>> +
>>> +        $ python $kernel_dir/tools/usb/p9_fwd.py list
>>> +
>>> +        Bus | Addr | Manufacturer     | Product          | ID        | Path
>>> +        --- | ---- | ---------------- | ---------------- | --------- | ----
>>> +          2 |   67 | unknown          | unknown          | 1d6b:0109 | 2-1.1.2
>>> +          2 |   68 | unknown          | unknown          | 1d6b:0109 | 2-1.1.3
>>> +
>>> +Then start the python transport:
>>> +
>>> +        $ python $kernel_dir/tools/usb/p9_fwd.py --path 2-1.1.2 connect -p 9999
>>> +
>>> +After that the gadget driver can be used as described above.
>>> +
>>> +One use-case is to use it as an alternative to NFS root booting during
>>> +the development of embedded Linux devices.
>>> +
>>>  Options
>>>  =======
>>> diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
>>> new file mode 100755
>>> index 0000000000000..7bedefce75c7b
>>> --- /dev/null
>>> +++ b/tools/usb/p9_fwd.py
>>> @@ -0,0 +1,243 @@
>>> +#!/usr/bin/env python3
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +import argparse
>>> +import errno
>>> +import logging
>>> +import socket
>>> +import struct
>>> +import time
>>> +
>>> +import usb.core
>>> +import usb.util
>>> +
>>> +
>>> +def path_from_usb_dev(dev):
>>> +    """Takes a pyUSB device as argument and returns a string.
>>> +    The string is a Path representation of the position of the USB device on the USB bus tree.
>>> +
>>> +    This path is used to find a USB device on the bus or all devices connected to a HUB.
>>> +    The path is made up of the number of the USB controller followed be the ports of the HUB tree."""
>>> +    if dev.port_numbers:
>>> +        dev_path = ".".join(str(i) for i in dev.port_numbers)
>>> +        return f"{dev.bus}-{dev_path}"
>>> +    return ""
>>> +
>>> +
>>> +HEXDUMP_FILTER = "".join(chr(x).isprintable() and chr(x) or "." for x in range(128)) + "." * 128
>>> +
>>> +
>>> +class Forwarder:
>>> +    @staticmethod
>>> +    def _log_hexdump(data):
>>> +        if not logging.root.isEnabledFor(logging.TRACE):
>>> +            return
>>> +        L = 16
>>> +        for c in range(0, len(data), L):
>>> +            chars = data[c : c + L]
>>> +            dump = " ".join(f"{x:02x}" for x in chars)
>>> +            printable = "".join(HEXDUMP_FILTER[x] for x in chars)
>>> +            line = f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
>>> +            logging.root.log(logging.TRACE, "%s", line)
>>> +
>>> +    def __init__(self, server, vid, pid, path):
>>> +        self.stats = {
>>> +            "c2s packets": 0,
>>> +            "c2s bytes": 0,
>>> +            "s2c packets": 0,
>>> +            "s2c bytes": 0,
>>> +        }
>>> +        self.stats_logged = time.monotonic()
>>> +
>>> +        def find_filter(dev):
>>> +            dev_path = path_from_usb_dev(dev)
>>> +            if path is not None:
>>> +                return dev_path == path
>>> +            return True
>>> +
>>> +        dev = usb.core.find(idVendor=vid, idProduct=pid, custom_match=find_filter)
>>> +        if dev is None:
>>> +            raise ValueError("Device not found")
>>> +
>>> +        logging.info(f"found device: {dev.bus}/{dev.address} located at {path_from_usb_dev(dev)}")
>>> +
>>> +        # dev.set_configuration() is not necessary since g_multi has only one
>>> +        usb9pfs = None
>>> +        # g_multi adds 9pfs as last interface
>>> +        cfg = dev.get_active_configuration()
>>> +        for intf in cfg:
>>> +            # we have to detach the usb-storage driver from multi gadget since
>>> +            # stall option could be set, which will lead to spontaneous port
>>> +            # resets and our transfers will run dead
>>> +            if intf.bInterfaceClass == 0x08:
>>> +                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
>>> +                    dev.detach_kernel_driver(intf.bInterfaceNumber)
>>> +
>>> +            if intf.bInterfaceClass == 0xFF and intf.bInterfaceSubClass == 0xFF and intf.bInterfaceProtocol == 0x09:
>>> +                usb9pfs = intf
>>> +        if usb9pfs is None:
>>> +            raise ValueError("Interface not found")
>>> +
>>> +        logging.info(f"claiming interface:\n{usb9pfs}")
>>> +        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
>>> +        ep_out = usb.util.find_descriptor(
>>> +            usb9pfs,
>>> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_OUT,
>>> +        )
>>> +        assert ep_out is not None
>>> +        ep_in = usb.util.find_descriptor(
>>> +            usb9pfs,
>>> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_IN,
>>> +        )
>>> +        assert ep_in is not None
>>> +        logging.info("interface claimed")
>>> +
>>> +        self.ep_out = ep_out
>>> +        self.ep_in = ep_in
>>> +        self.dev = dev
>>> +
>>> +        # create and connect socket
>>> +        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>> +        self.s.connect(server)
>>> +
>>> +        logging.info("connected to server")
>>> +
>>> +    def c2s(self):
>>> +        """forward a request from the USB client to the TCP server"""
>>> +        data = None
>>> +        while data is None:
>>> +            try:
>>> +                logging.log(logging.TRACE, "c2s: reading")
>>> +                data = self.ep_in.read(self.ep_in.wMaxPacketSize)
>>> +            except usb.core.USBTimeoutError:
>>> +                logging.log(logging.TRACE, "c2s: reading timed out")
>>> +                continue
>>> +            except usb.core.USBError as e:
>>> +                if e.errno == errno.EIO:
>>> +                    logging.debug("c2s: reading failed with %s, retrying", repr(e))
>>> +                    time.sleep(0.5)
>>> +                    continue
>>> +                logging.error("c2s: reading failed with %s, aborting", repr(e))
>>> +                raise
>>> +        size = struct.unpack("<I", data[:4])[0]
>>> +        while len(data) < size:
>>> +            data += self.ep_in.read(size - len(data))
>>> +        logging.log(logging.TRACE, "c2s: writing")
>>> +        self._log_hexdump(data)
>>> +        self.s.send(data)
>>> +        logging.debug("c2s: forwarded %i bytes", size)
>>> +        self.stats["c2s packets"] += 1
>>> +        self.stats["c2s bytes"] += size
>>> +
>>> +    def s2c(self):
>>> +        """forward a response from the TCP server to the USB client"""
>>> +        logging.log(logging.TRACE, "s2c: reading")
>>> +        data = self.s.recv(4)
>>> +        size = struct.unpack("<I", data[:4])[0]
>>> +        while len(data) < size:
>>> +            data += self.s.recv(size - len(data))
>>> +        logging.log(logging.TRACE, "s2c: writing")
>>> +        self._log_hexdump(data)
>>> +        while data:
>>> +            written = self.ep_out.write(data)
>>> +            assert written > 0
>>> +            data = data[written:]
>>> +        if size % self.ep_out.wMaxPacketSize == 0:
>>> +            logging.log(logging.TRACE, "sending zero length packet")
>>> +            self.ep_out.write(b"")
>>> +        logging.debug("s2c: forwarded %i bytes", size)
>>> +        self.stats["s2c packets"] += 1
>>> +        self.stats["s2c bytes"] += size
>>> +
>>> +    def log_stats(self):
>>> +        logging.info("statistics:")
>>> +        for k, v in self.stats.items():
>>> +            logging.info(f"  {k+':':14s} {v}")
>>> +
>>> +    def log_stats_interval(self, interval=5):
>>> +        if (time.monotonic() - self.stats_logged) < interval:
>>> +            return
>>> +
>>> +        self.log_stats()
>>> +        self.stats_logged = time.monotonic()
>>> +
>>> +
>>> +def try_get_usb_str(dev, name):
>>> +    try:
>>> +        with open(f"/sys/bus/usb/devices/{dev.bus}-{dev.address}/{name}") as f:
>>> +            return f.read().strip()
>>> +    except FileNotFoundError:
>>> +        return None
>>> +
>>> +
>>> +def list_usb(args):
>>> +    vid, pid = [int(x, 16) for x in args.id.split(":", 1)]
>>> +
>>> +    print("Bus | Addr | Manufacturer     | Product          | ID        | Path")
>>> +    print("--- | ---- | ---------------- | ---------------- | --------- | ----")
>>> +    for dev in usb.core.find(find_all=True, idVendor=vid, idProduct=pid):
>>> +        path = path_from_usb_dev(dev) or ""
>>> +        manufacturer = try_get_usb_str(dev, "manufacturer") or "unknown"
>>> +        product = try_get_usb_str(dev, "product") or "unknown"
>>> +        print(
>>> +            f"{dev.bus:3} | {dev.address:4} | {manufacturer:16} | {product:16} | {dev.idVendor:04x}:{dev.idProduct:04x} | {path:18}"
>>> +        )
>>> +
>>> +
>>> +def connect(args):
>>> +    vid, pid = [int(x, 16) for x in args.id.split(":", 1)]
>>> +
>>> +    f = Forwarder(server=(args.server, args.port), vid=vid, pid=pid, path=args.path)
>>> +
>>> +    try:
>>> +        while True:
>>> +            f.c2s()
>>> +            f.s2c()
>>> +            f.log_stats_interval()
>>> +    finally:
>>> +        f.log_stats()
>>> +
>>> +
>>> +def main():
>>> +    parser = argparse.ArgumentParser(
>>> +        description="Forward 9PFS requests from USB to TCP",
>>> +    )
>>> +
>>> +    parser.add_argument("--id", type=str, default="1d6b:0109", help="vid:pid of target device")
>>> +    parser.add_argument("--path", type=str, default="", help="path of target device")
>>
>> I had to specify both --id and --path, otherwise I was getting
>> "device not found".
> 
> This is odd. What was your list command saying about the available
> devices?
> 

<snip>

[ 4260.577064] usb 3-1.3.3.5.4: new high-speed USB device number 25 using xhci_hcd
[ 4260.677769] usb 3-1.3.3.5.4: New USB device found, idVendor=abcd, idProduct=ef01, bcdDevice= 6.09
[ 4260.677788] usb 3-1.3.3.5.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0

<snip>

$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 list
Bus | Addr | Manufacturer     | Product          | ID        | Path
--- | ---- | ---------------- | ---------------- | --------- | ----
   3 |   25 | unknown          | unknown          | abcd:ef01 | 3-1.3.3.5.4


$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 connect -p 9999
Traceback (most recent call last):
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 243, in <module>
     main()
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 239, in main
     args.func(args)
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 190, in connect
     f = Forwarder(server=(args.server, args.port), vid=vid, pid=pid, path=args.path)
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 60, in __init__
     raise ValueError("Device not found")
ValueError: Device not found

$ sudo python3 tools/usb/p9_fwd.py --path 3-1.3.3.5.4 connect -p 9999
Traceback (most recent call last):
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 243, in <module>
     main()
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 239, in main
     args.func(args)
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 190, in connect
     f = Forwarder(server=(args.server, args.port), vid=vid, pid=pid, path=args.path)
   File "/home/ap/Collabora/kernel-rk/tools/usb/p9_fwd.py", line 60, in __init__
     raise ValueError("Device not found")
ValueError: Device not found

$ sudo python3 tools/usb/p9_fwd.py --id 0xabcd:0xef01 --path 3-1.3.3.5.4 connect -p 9999
2024-05-31 09:34:44,047 INFO     found device: 3/25 located at 3-1.3.3.5.4
2024-05-31 09:34:44,053 INFO     claiming interface:
     INTERFACE 0: Vendor Specific ===========================
      bLength            :    0x9 (9 bytes)
      bDescriptorType    :    0x4 Interface
      bInterfaceNumber   :    0x0
      bAlternateSetting  :    0x0
      bNumEndpoints      :    0x2
      bInterfaceClass    :   0xff Vendor Specific
      bInterfaceSubClass :   0xff
      bInterfaceProtocol :    0x9
      iInterface         :    0x1 usb9pfs input to output
       ENDPOINT 0x81: Bulk IN ===============================
        bLength          :    0x7 (7 bytes)
        bDescriptorType  :    0x5 Endpoint
        bEndpointAddress :   0x81 IN
        bmAttributes     :    0x2 Bulk
        wMaxPacketSize   :  0x200 (512 bytes)
        bInterval        :    0x0
       ENDPOINT 0x1: Bulk OUT ===============================
        bLength          :    0x7 (7 bytes)
        bDescriptorType  :    0x5 Endpoint
        bEndpointAddress :    0x1 OUT
        bmAttributes     :    0x2 Bulk
        wMaxPacketSize   :  0x200 (512 bytes)
        bInterval        :    0x0
2024-05-31 09:34:44,054 INFO     interface claimed
2024-05-31 09:34:44,054 INFO     connected to server

Regards,

Andrzej

> I tested this with the default vid:pid as described above (1d6b:0109)
> which worked fine with path alone.
> 
> Michael
> 
>>> +    parser.add_argument("-v", "--verbose", action="count", default=0)
>>> +
>>> +    subparsers = parser.add_subparsers()
>>> +    subparsers.required = True
>>> +    subparsers.dest = "command"
>>> +
>>> +    parser_list = subparsers.add_parser("list", help="List all connected 9p gadgets")
>>> +    parser_list.set_defaults(func=list_usb)
>>> +
>>> +    parser_connect = subparsers.add_parser(
>>> +        "connect", help="Forward messages between the usb9pfs gadget and the 9p server"
>>> +    )
>>> +    parser_connect.set_defaults(func=connect)
>>> +    connect_group = parser_connect.add_argument_group()
>>> +    connect_group.required = True
>>> +    parser_connect.add_argument("-s", "--server", type=str, default="127.0.0.1", help="server hostname")
>>> +    parser_connect.add_argument("-p", "--port", type=int, default=564, help="server port")> +
>>> +    args = parser.parse_args()
>>> +
>>> +    logging.TRACE = logging.DEBUG - 5
>>> +    logging.addLevelName(logging.TRACE, "TRACE")
>>> +
>>> +    if args.verbose >= 2:
>>> +        level = logging.TRACE
>>> +    elif args.verbose:
>>> +        level = logging.DEBUG
>>> +    else:
>>> +        level = logging.INFO
>>> +    logging.basicConfig(level=level, format="%(asctime)-15s %(levelname)-8s %(message)s")
>>> +
>>> +    args.func(args)
>>> +
>>> +
>>> +if __name__ == "__main__":
>>> +    main()
>>>
>>
>>
> 

