Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCC17BEC5;
	Wed,  9 Oct 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460539; cv=none; b=liYgizYtCofgWBo6Gaw6hUM0JQ1V3st4vd17JDLCUgrJrolatVI42N4XoY4ea8TRcaAfxTUf+gzLudqArhDYenx4EInOIJ8cdeuXo8zBNe+BDFAj/9GrFspteL4GJEGuXlQ+baDu4kUU61q4jpvWCKvJl5mGiK4osm7cnr6U+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460539; c=relaxed/simple;
	bh=oCAOo8Bdc/kr0LgFyMUbMXb2BpaSFaCjRK7n2HuwAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mon3Gg0oX+WiuQqvT3Re8ep6OGZYPvOvlV82iFn3khr9kEpKBjBVuqO5DGKapHQKUUMS4/H6rfckSi6N5TAt1Xo1AP/nksPcs4GO5mevFmGL2kSqhC+jy4RkTjPqAG7ssZFf6o/mMa0onAFo1xCNKf839wVGH+bAnRzjcI8ZivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZFuJ9JM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZFuJ9JM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642BCC4CEC5;
	Wed,  9 Oct 2024 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728460539;
	bh=oCAOo8Bdc/kr0LgFyMUbMXb2BpaSFaCjRK7n2HuwAko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZFuJ9JMTj8mUD7SeHthX8fQF227odujYoOWwGg7Q1zYWxuUDM4cYJUqwEhSeaZ45
	 2m+HA2sNJqbaEO4/1YOzWIXNl02EQEDapyEDdQlQ8iN+k5ii0kcJDYHQgolRayVH6U
	 vG+Ujlx3rpjgPVlKIL4wc2fAZYsel9nEQYwrzvmI=
Date: Wed, 9 Oct 2024 09:55:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.grzeschik@pengutronix.de, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] net/9p/usbg: Fix build error
Message-ID: <2024100910-distrust-cornhusk-a8bd@gregkh>
References: <20240930081520.2371424-1-ruanjinjie@huawei.com>
 <2ff5834d-cb88-39f5-168d-8e179f152757@huawei.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff5834d-cb88-39f5-168d-8e179f152757@huawei.com>

On Wed, Oct 09, 2024 at 03:49:22PM +0800, Jinjie Ruan wrote:
> Ping.
> 
> On 2024/9/30 16:15, Jinjie Ruan wrote:
> > When CONFIG_NET_9P_USBG=y but CONFIG_USB_LIBCOMPOSITE=m and
> > CONFIG_CONFIGFS_FS=m, the following build error occurs:
> > 
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_free_func':
> > 	trans_usbg.c:(.text+0x124): undefined reference to `usb_free_all_descriptors'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_rx_complete':
> > 	trans_usbg.c:(.text+0x2d8): undefined reference to `usb_interface_id'
> > 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x2f6): undefined reference to `usb_string_id'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_func_bind':
> > 	trans_usbg.c:(.text+0x31c): undefined reference to `usb_ep_autoconfig'
> > 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x336): undefined reference to `usb_ep_autoconfig'
> > 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x378): undefined reference to `usb_assign_descriptors'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `f_usb9pfs_opts_buflen_store':
> > 	trans_usbg.c:(.text+0x49e): undefined reference to `usb_put_function_instance'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc_instance':
> > 	trans_usbg.c:(.text+0x5fe): undefined reference to `config_group_init_type_name'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc':
> > 	trans_usbg.c:(.text+0x7aa): undefined reference to `config_ep_by_speed'
> > 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x7ea): undefined reference to `config_ep_by_speed'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_set_alt':
> > 	trans_usbg.c:(.text+0x828): undefined reference to `alloc_ep_req'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modexit':
> > 	trans_usbg.c:(.exit.text+0x10): undefined reference to `usb_function_unregister'
> > 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modinit':
> > 	trans_usbg.c:(.init.text+0x1e): undefined reference to `usb_function_register'
> > 
> > Select the config for NET_9P_USBG to fix it.
> > 
> > Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  net/9p/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/9p/Kconfig b/net/9p/Kconfig
> > index 63f988f0c9e8..ee967fd25312 100644
> > --- a/net/9p/Kconfig
> > +++ b/net/9p/Kconfig
> > @@ -43,6 +43,8 @@ config NET_9P_XEN
> >  config NET_9P_USBG
> >  	bool "9P USB Gadget Transport"
> >  	depends on USB_GADGET=y || USB_GADGET=NET_9P
> > +	select CONFIGFS_FS
> > +	select USB_LIBCOMPOSITE
> >  	help
> >  	  This builds support for a transport for 9pfs over
> >  	  usb gadget.

Ah, I can take this through the USB tree as it fixes a bug that came in
through there.

thanks,

greg k-h
