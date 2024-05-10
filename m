Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308D16079A
	for <v9fs@lists.linux.dev>; Fri, 10 May 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329759; cv=none; b=uFm8618EvdnlZyToKMjEV045l+57TXGrwDa1yoSBmgJpDqvfZ+ofTMkHFjJlxdG350RA6N5qfnLtVOgFn4qjN+vLOLfy8SCqs1vTviwafDvqWHs2JWsnQe8YNyOywN9hsFpJi0YuD2KxBNiMuuik+APRAjnHwAOUiu72TtQv/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329759; c=relaxed/simple;
	bh=L7tsgP4f2XeNjNvOA0n4h6Xu9Jd9jlvwcZ6tHLK50o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTAT0O1V/yTxeii+YGYAaRQ6t8B+uI5qo22si5uPk3+BsceiCeopfyp6iNfJjRA3JlIXb8hJ6JVdPG4E6dT+Vd6+NO4vEf+IsyjIU0u52UUkxAPUonLdSAVWmiATXfW6ounK2VA+mqrKns94tRnW7OhX787XW8E3CHP1XPdR8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VMDeqtdJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VMDeqtdJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715329743;
	bh=L7tsgP4f2XeNjNvOA0n4h6Xu9Jd9jlvwcZ6tHLK50o8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VMDeqtdJm3FmXXUXynoHc4lDyG7dzqMFYc5GANHuwAD4AO8a/9tAC3IwkU87/zdJj
	 9PksU3gGsjYEn/5dMufV6Bi18OIZYFD/6A1od40Cidj1mMrTw+T79G86pdHyaHDvKX
	 cXu/czJCQsub6nEWVeVk/jpL4NYOrTfWFgrEjdc401M7HS17/dMXlf0gJIwAsOFEL7
	 nbBCb78bIWJd1B8o0k18iqhRNppM7oMt/vNAcvTcWWAgNPThbFOWtgXOGAMW2vSvsy
	 78O7B7Kxk5zYXQ3GSgv4tQcd26TmMibyhmrOckCjgKvDGTMLEBw9rxr1RQXj3xjDJJ
	 wHmlzMvf0LDUw==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80AE13782009;
	Fri, 10 May 2024 08:29:02 +0000 (UTC)
Message-ID: <e1c8cc99-47e3-4780-87c8-9f4da370ac4b@collabora.com>
Date: Fri, 10 May 2024 10:29:02 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
 <20240116-ml-topic-u9p-v4-3-722ed28b0ade@pengutronix.de>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20240116-ml-topic-u9p-v4-3-722ed28b0ade@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

W dniu 30.04.2024 o 01:33, Michael Grzeschik pisze:
> This patch is adding an small python tool to forward 9pfs requests
> from the USB gadget to an existing 9pfs TCP server. Since currently all
> 9pfs servers lack support for the usb transport this tool is an useful
> helper to get started.
> 
> Refer the Documentation section "USBG Example" in
> Documentation/filesystems/9p.rst on how to use it.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v3 -> v4: -
> v2 -> v3: -
> v1 -> v2:
>    - added usbg 9pfs detailed instructions to 9p.rst doc
> ---
>   Documentation/filesystems/9p.rst |  32 +++++++
>   tools/usb/p9_fwd.py              | 194 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 226 insertions(+)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 10cf79dc287f8..2467f1ea4a150 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -67,6 +67,38 @@ To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
>   where <device> is the tag associated by the usb gadget transport.
>   It is defined by the configfs instance name.
>   
> +USBG Example
> +============
> +
> +The USB host exports a filesystem, while the gadget on the USB device
> +side makes it mountable.
> +
> +Diod (9pfs server) and the forwarder are on the development host, where
> +the root filesystem is actually stored. The gadget is initialized during
> +boot (or later) on the embedded board. Then the forwarder will find it
> +on the USB bus and start forwarding requests.
> +
> +In this case the 9p requests come from the device and are handled by the
> +host. The reason is that USB device ports are normally not available on
> +PCs, so a connection in the other direction would not work.
> +
> +When using the usbg transport, for now there is no native usb host
> +service capable to handle the requests from the gadget driver. For
> +this we have to use the extra python tool p9_fwd.py from tools/usb.
> +
> +Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
> +
> +	$ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
> +
> +Then start the python transport:
> +
> +	$ python $kernel_dir/tools/usb/p9_fwd.py -p 9999
> +
> +After that the gadget driver can be used as described above.
> +
> +One use-case is to use it as an alternative to NFS root booting during
> +the development of embedded Linux devices.
> +
>   Options
>   =======
>   
> diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
> new file mode 100755
> index 0000000000000..95208df11abef
> --- /dev/null
> +++ b/tools/usb/p9_fwd.py
> @@ -0,0 +1,194 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import argparse
> +import errno
> +import logging
> +import socket
> +import struct
> +import sys
> +import time
> +
> +import usb.core
> +import usb.util
> +
> +
> +class Forwarder:
> +    HEXDUMP_FILTER = (
> +        "".join(chr(x).isprintable() and chr(x) or "." for x in range(128)) + "." * 128
> +    )
> +
> +    @staticmethod
> +    def _log_hexdump(data):
> +        if not logging.root.isEnabledFor(logging.TRACE):
> +            return
> +        L = 16
> +        for c in range(0, len(data), L):
> +            chars = data[c : c + L]
> +            dump = " ".join(f"{x:02x}" for x in chars)
> +            printable = "".join(HEXDUMP_FILTER[x] for x in chars)
> +            line = f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
> +            logging.root.log(logging.TRACE, "%s", line)
> +
> +    def __init__(self, server):
> +        self.stats = {
> +            "c2s packets": 0,
> +            "c2s bytes": 0,
> +            "s2c packets": 0,
> +            "s2c bytes": 0,
> +        }
> +        self.stats_logged = time.monotonic()
> +
> +        dev = usb.core.find(idVendor=0x1D6B, idProduct=0x0109)

Is this idProduct an assigned number? I can't find it in
http://www.linux-usb.org/usb.ids. The "9" is obviously a pun on 9pfs,
a nice trick and it would make sense.

However, given composition with configfs there's no guarantee that 9pfs will be
the only USB gadget function present, and so it is not quite clear that Linux
Foundation's vendor and product ids are always appropriate. What's more, when
you are not going to the market with products you can use whatever ids you
please for your own use.

Given the above, I'd love these two (idVendor and idProduct) to be commandline
parameters of this script. My user story: whenever I created a gadget with
configfs it had different ids than the above and this script wouldn't work.

Regards,

Andrzej

> +        if dev is None:
> +            raise ValueError("Device not found")
> +
> +        logging.info(f"found device: {dev.bus}/{dev.address}")
> +
> +        # dev.set_configuration() is not necessary since g_multi has only one
> +        usb9pfs = None
> +        # g_multi adds 9pfs as last interface
> +        cfg = dev.get_active_configuration()
> +        for intf in cfg:
> +            # we have to detach the usb-storage driver from multi gadget since
> +            # stall option could be set, which will lead to spontaneous port
> +            # resets and our transfers will run dead
> +            if intf.bInterfaceClass == 0x08:
> +                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
> +                    dev.detach_kernel_driver(intf.bInterfaceNumber)
> +
> +            if (
> +                intf.bInterfaceClass == 0xFF
> +                and intf.bInterfaceSubClass == 0xFF
> +                and intf.bInterfaceProtocol == 0x09
> +            ):
> +                usb9pfs = intf
> +        if usb9pfs is None:
> +            raise ValueError("Interface not found")
> +
> +        logging.info(f"claiming interface:\n{usb9pfs}")
> +        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
> +        ep_out = usb.util.find_descriptor(
> +            usb9pfs,
> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
> +            == usb.util.ENDPOINT_OUT,
> +        )
> +        assert ep_out is not None
> +        ep_in = usb.util.find_descriptor(
> +            usb9pfs,
> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
> +            == usb.util.ENDPOINT_IN,
> +        )
> +        assert ep_in is not None
> +        logging.info(f"interface claimed")
> +
> +        self.ep_out = ep_out
> +        self.ep_in = ep_in
> +        self.dev = dev
> +
> +        # create and connect socket
> +        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +        self.s.connect(server)
> +
> +        logging.info(f"connected to server")
> +
> +    def c2s(self):
> +        """forward a request from the USB client to the TCP server"""
> +        data = None
> +        while data is None:
> +            try:
> +                logging.log(logging.TRACE, "c2s: reading")
> +                data = self.ep_in.read(self.ep_in.wMaxPacketSize)
> +            except usb.core.USBTimeoutError:
> +                logging.log(logging.TRACE, "c2s: reading timed out")
> +                continue
> +            except usb.core.USBError as e:
> +                if e.errno == errno.EIO:
> +                    logging.debug("c2s: reading failed with %s, retrying", repr(e))
> +                    time.sleep(0.5)
> +                    continue
> +                else:
> +                    logging.error("c2s: reading failed with %s, aborting", repr(e))
> +                    raise
> +        size = struct.unpack("<I", data[:4])[0]
> +        while len(data) < size:
> +            data += self.ep_in.read(size - len(data))
> +        logging.log(logging.TRACE, "c2s: writing")
> +        self._log_hexdump(data)
> +        self.s.send(data)
> +        logging.debug("c2s: forwarded %i bytes", size)
> +        self.stats["c2s packets"] += 1
> +        self.stats["c2s bytes"] += size
> +
> +    def s2c(self):
> +        """forward a response from the TCP server to the USB client"""
> +        logging.log(logging.TRACE, "s2c: reading")
> +        data = self.s.recv(4)
> +        size = struct.unpack("<I", data[:4])[0]
> +        while len(data) < size:
> +            data += self.s.recv(size - len(data))
> +        logging.log(logging.TRACE, "s2c: writing")
> +        self._log_hexdump(data)
> +        while data:
> +            written = self.ep_out.write(data)
> +            assert written > 0
> +            data = data[written:]
> +        if size % self.ep_out.wMaxPacketSize == 0:
> +            logging.log(logging.TRACE, "sending zero length packet")
> +            self.ep_out.write(b"")
> +        logging.debug("s2c: forwarded %i bytes", size)
> +        self.stats["s2c packets"] += 1
> +        self.stats["s2c bytes"] += size
> +
> +    def log_stats(self):
> +        logging.info("statistics:")
> +        for k, v in self.stats.items():
> +            logging.info(f"  {k+':':14s} {v}")
> +
> +    def log_stats_interval(self, interval=5):
> +        if (time.monotonic() - self.stats_logged) < interval:
> +            return
> +
> +        self.log_stats()
> +        self.stats_logged = time.monotonic()
> +
> +
> +def main():
> +    parser = argparse.ArgumentParser(
> +        description="Forward 9PFS requests from USB to TCP",
> +    )
> +
> +    parser.add_argument(
> +        "-s", "--server", type=str, default="127.0.0.1", help="server hostname"
> +    )
> +    parser.add_argument("-p", "--port", type=int, default=564, help="server port")
> +    parser.add_argument("-v", "--verbose", action="count", default=0)
> +
> +    args = parser.parse_args()
> +
> +    logging.TRACE = logging.DEBUG - 5
> +    logging.addLevelName(logging.TRACE, "TRACE")
> +
> +    if args.verbose >= 2:
> +        level = logging.TRACE
> +    elif args.verbose:
> +        level = logging.DEBUG
> +    else:
> +        level = logging.INFO
> +    logging.basicConfig(
> +        level=level, format="%(asctime)-15s %(levelname)-8s %(message)s"
> +    )
> +
> +    f = Forwarder(server=(args.server, args.port))
> +
> +    try:
> +        while True:
> +            f.c2s()
> +            f.s2c()
> +            f.log_stats_interval()
> +    finally:
> +        f.log_stats()
> +
> +
> +if __name__ == "__main__":
> +    main()
> 

