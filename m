Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555711A265D
	for <v9fs@lists.linux.dev>; Thu,  3 Oct 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977101; cv=none; b=ntxD7Rk32iIT1H7keKM7tkKhL05g3i9pl2+jKp9HqWkwdCYcFN4+cw1a6Hu8ZC42ICdAcWwtCFRtaj8y75MCNmMFvwLZ2lPji6wxW1Qw+iah57FbArpsud1xiJp90+RuRdbHrUA1UJDJYm9QhcWtPdduLXEqkkJo7FWjvP3vEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977101; c=relaxed/simple;
	bh=m1yB8Ze6iYF0CL9QqSRczwMHRy9+goP0hLkrZu9n4fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K2ruxvVpVDnwmfm2coU1mLhFRwMFTougo03Rg3YTIfn5/GiPJIHPfDzOU4NQbeRvtdmvtx/BMazdDL/2Mc1CFIf5RWmHcJjBU6sxeza/l1UCsnyk1E8eNvy3MOfcJXVZGVl3xoWODnaJAwiyh4JL/SiC69WSCabgl139RGKQPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=DHKUDIWo; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="DHKUDIWo"
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B98E12621F
	for <v9fs@lists.linux.dev>; Thu,  3 Oct 2024 17:38:09 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 8B27E3E8AF;
	Thu,  3 Oct 2024 19:38:02 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 21CBF4075C;
	Thu,  3 Oct 2024 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1727977081; bh=m1yB8Ze6iYF0CL9QqSRczwMHRy9+goP0hLkrZu9n4fs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DHKUDIWoEo7ugj+8L+DxuHRpikcCzpQjB//Za1NVRBeCs5LFQ5kxzmfW8jlvxDwA3
	 3x0YUynVY9tjk7Gip6YHnahmgMTXGVZqy4IxoqJVZVFct7Art1SsuuqwiTOpXkIhxl
	 sEWNaqthSgGvF1h1t99sVIIfhGKAhVpQO06ea9+w=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 93CAB42EDC;
	Thu,  3 Oct 2024 17:37:58 +0000 (UTC)
Message-ID: <d1383f52-b1b3-4967-8bd1-abb42fedba4f@aosc.io>
Date: Fri, 4 Oct 2024 01:37:56 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] net/9p/usbg: Fix build error
To: Jinjie Ruan <ruanjinjie@huawei.com>, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, m.grzeschik@pengutronix.de,
 gregkh@linuxfoundation.org, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240930081520.2371424-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20240930081520.2371424-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 21CBF4075C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]

On 9/30/2024 4:15 PM, Jinjie Ruan wrote:
> When CONFIG_NET_9P_USBG=y but CONFIG_USB_LIBCOMPOSITE=m and
> CONFIG_CONFIGFS_FS=m, the following build error occurs:
> 
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_free_func':
> 	trans_usbg.c:(.text+0x124): undefined reference to `usb_free_all_descriptors'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_rx_complete':
> 	trans_usbg.c:(.text+0x2d8): undefined reference to `usb_interface_id'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x2f6): undefined reference to `usb_string_id'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_func_bind':
> 	trans_usbg.c:(.text+0x31c): undefined reference to `usb_ep_autoconfig'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x336): undefined reference to `usb_ep_autoconfig'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x378): undefined reference to `usb_assign_descriptors'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `f_usb9pfs_opts_buflen_store':
> 	trans_usbg.c:(.text+0x49e): undefined reference to `usb_put_function_instance'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc_instance':
> 	trans_usbg.c:(.text+0x5fe): undefined reference to `config_group_init_type_name'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc':
> 	trans_usbg.c:(.text+0x7aa): undefined reference to `config_ep_by_speed'
> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x7ea): undefined reference to `config_ep_by_speed'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_set_alt':
> 	trans_usbg.c:(.text+0x828): undefined reference to `alloc_ep_req'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modexit':
> 	trans_usbg.c:(.exit.text+0x10): undefined reference to `usb_function_unregister'
> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modinit':
> 	trans_usbg.c:(.init.text+0x1e): undefined reference to `usb_function_register'
> 
> Select the config for NET_9P_USBG to fix it.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   net/9p/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
> index 63f988f0c9e8..ee967fd25312 100644
> --- a/net/9p/Kconfig
> +++ b/net/9p/Kconfig
> @@ -43,6 +43,8 @@ config NET_9P_XEN
>   config NET_9P_USBG
>   	bool "9P USB Gadget Transport"
>   	depends on USB_GADGET=y || USB_GADGET=NET_9P
> +	select CONFIGFS_FS
> +	select USB_LIBCOMPOSITE
>   	help
>   	  This builds support for a transport for 9pfs over
>   	  usb gadget.

Fixed building on arm64.

Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>

https://buildit.aosc.io/jobs/43382

-- 
Best Regards,
Kexy Biscuit
