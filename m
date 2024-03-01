Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7D79F1
	for <v9fs@lists.linux.dev>; Fri,  1 Mar 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294768; cv=none; b=jzmO+b0XEX0nBW6QDx4viQBPygoaGmLmtb8wdszpmKRoed2rsPdBxiCvzpz+F4Y2RETqvMxU8vp1kCLga85IZl3i0J3+4tR5qQJyZkypu6A7c8wK6gSiBxliinucqkMVc6LsKo4IEkrGt0DV8XI7RxcNlSsIuKMVR3pgGEYeSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294768; c=relaxed/simple;
	bh=VfJLA+apQ2y27CyTOnJ6ONaS3IDWYlPAkRiDGThMQtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVKrSbrAKGDOPUxOz/aFpOQpmTbmv+XzcQNY1r/uQri/RJDvU3a7cUDJllQge3AF72k5NBrgAoOSuFBQzHX1jzUlv+4zUHsDwNhqnGgZ+riaF/18+zGOZ2/a1ZqD0fXgJNcfKVDyRHkt9vALwp17/FLqkXOL7eZXXVWtfqOOydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JIgnldDX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JIgnldDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709294764;
	bh=VfJLA+apQ2y27CyTOnJ6ONaS3IDWYlPAkRiDGThMQtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JIgnldDXK8GgmRbTZW0t8M8yH3HcNouSz/z+AgCcAlJ6WH2eCNhX8pdb8NWeIOI6k
	 G+0yhyFtYrPCMoTIuM4nfU/ltgK6fkXODsaCVArpsxqZfYHw9z7SFQc/3oXL21Abf9
	 06Ghc2KAfDIIZwJcreZjySyr7HlrM2L3qq10fS5mJlSHt++IRAwLoQq4zCfGeiMLXI
	 qd3NHReHyscDhqtrDjT+ZO3kQ4GcsWIpYLyGudUF+AwpnM0KNkR4R/NDDLdrIex6+T
	 vzQVJuEuMNR+e4uGi+/7HmgQhxe1BtY+J0P3TkPBZe0OdB4Kd1ynjUcfHavlXZB4MC
	 /Tr0Dmkchc2YQ==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBC623780EC6;
	Fri,  1 Mar 2024 12:06:03 +0000 (UTC)
Message-ID: <9581f66e-dc3a-495b-bacb-30908a78a773@collabora.com>
Date: Fri, 1 Mar 2024 13:06:03 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] usb: gadget: 9pfs transport
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

W dniu 26.02.2024 o 14:56, Michael Grzeschik pisze:
> This series is adding support to mount usb hostside exported 9pfs
> filesystems via the usb gadget interface. It also includes a simple tool
> (p9_fwd.py) to translate an tcp 9pfs transport and reuse it via the usb
> interface.
> 
>      +--------------------------+    |    +--------------------------+
>      |  9PFS mounting client    |    |    |  9PFS exporting server   |
>   SW |                          |    |    |                          |
>      |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
>      +-------------^------------+    |    +-------------^------------+
>                    |                 |                  |
>                    |                 |           +------v------+
>                    |                 |           |  p9_fwd.py  |
>                    |                 |           +------^------+
>                    |                 |                  |
> ------------------|------------------------------------|-------------
>                    |                 |                  |
>      +-------------v------------+    |    +-------------v------------+
>      |                          |    |    |                          |
>   HW |   USB Device Controller  <--------->   USB Host Controller    |
>      |                          |    |    |                          |
>      +--------------------------+    |    +--------------------------+
> 
> The USB host exports a filesystem, while the gadget on the USB device
> side makes it mountable.
> 
> Diod (9pfs server) and the forwarder are on the development host, where
> the root filesystem is actually stored. The gadget is initialized during
> boot (or later) on the embedded board. Then the forwarder will find it
> on the USB bus and start forwarding requests.
> 
> In this case the 9p requests come from the device and are handled by the
> host. The reason is that USB device ports are normally not available on
> PCs, so a connection in the other direction would not work.
> 
> One use-case is to use it as an alternative to NFS root booting during
> the development of embedded Linux devices.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> Changes in v3:
> - dropped patch "usb: gadget: legacy: add 9pfs multi gadget" as discussed with gregkh

I will give the dropped patch a try to see how it works, as it should work the
same way regardless of how the gadget is composed, legacy or configfs.

Speaking of the latter, IMO there _are_ valid usecases other than having 9pfs
rootfs, so configfs support should be there. If you intend to send the patches
adding configfs support then kindly Cc me and I will test and review it for you.

Regards,

Andrzej

> - Link to v2: https://lore.kernel.org/r/20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de
> 
> Changes in v2:
> - improved the commit messages
> - introduced an patch to move the header u_f.h to include/linux/usb to compile usb gadget functions treewide
> - moved usbg gadget function to net/9p/
> - adderessed several comments in function driver, like the cleanup path and kbuild errors
> - improved the documentation in Documentation/filesystems/9p.rst
> - Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de
> 
> ---
> Michael Grzeschik (3):
>        usb: gadget: function: move u_f.h to include/linux/usb/
>        net/9p/usbg: Add new usb gadget function transport
>        tools: usb: p9_fwd: add usb gadget packet forwarder script
> 
>   Documentation/filesystems/9p.rst                |  47 ++
>   drivers/usb/gadget/configfs.c                   |   2 +-
>   drivers/usb/gadget/function/f_fs.c              |   2 +-
>   drivers/usb/gadget/function/f_hid.c             |   2 +-
>   drivers/usb/gadget/function/f_loopback.c        |   2 +-
>   drivers/usb/gadget/function/f_midi.c            |   2 +-
>   drivers/usb/gadget/function/f_midi2.c           |   2 +-
>   drivers/usb/gadget/function/f_sourcesink.c      |   2 +-
>   drivers/usb/gadget/u_f.c                        |   2 +-
>   {drivers/usb/gadget => include/linux/usb}/u_f.h |   0
>   net/9p/Kconfig                                  |   6 +
>   net/9p/Makefile                                 |   4 +
>   net/9p/trans_usbg.c                             | 871 ++++++++++++++++++++++++
>   tools/usb/p9_fwd.py                             | 194 ++++++
>   14 files changed, 1130 insertions(+), 8 deletions(-)
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240116-ml-topic-u9p-895274530eb1
> 
> Best regards,

