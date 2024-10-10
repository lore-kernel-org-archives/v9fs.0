Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D814594C
	for <v9fs@lists.linux.dev>; Thu, 10 Oct 2024 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525980; cv=none; b=iWIKw/qNObFABnwoHIqtrHHbQcixtXpfy5yBDbLfKLGeci5JghA98kTnabflzVwLb0UJ0iDYy7AVbf2F147NYYBqz1uPKzSiEI5/lnG9kF9o0J0HMY9OZw/qOfY6mnK+PeqaAjgXts8KBBxYr5GAf/mLyltB3XQbCYy3szyvLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525980; c=relaxed/simple;
	bh=1pKOvqjkmWg3Iphfkje73m4O8tgM8IjJroQCpRpBEWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Otel1v3Zf3hW21tubLN1AvZxYbOLlUZSOM8e1IF6EedKI3da5BNlVIqHawlFW5TdqYQhxKHUY0g3zZRPrBKqwnNrZxeSRvYiJVoFKwvXnVRTv9T6pJrj+/Mhi/5VqiV1FAYY86mpCYfwhQp0/enc2ktQaEHpqdHqwI1rv4r9mGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPCmC43s3z26gbb;
	Thu, 10 Oct 2024 10:06:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F17B5140120;
	Thu, 10 Oct 2024 10:06:14 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:06:14 +0800
Message-ID: <7e29e022-eae6-4a93-f7f1-841febab0988@huawei.com>
Date: Thu, 10 Oct 2024 10:06:13 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] net/9p/usbg: Fix build error
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
	<linux_oss@crudebyte.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <m.grzeschik@pengutronix.de>,
	<v9fs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
References: <20240930081520.2371424-1-ruanjinjie@huawei.com>
 <2ff5834d-cb88-39f5-168d-8e179f152757@huawei.com>
 <2024100910-distrust-cornhusk-a8bd@gregkh>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2024100910-distrust-cornhusk-a8bd@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/9 15:55, Greg KH wrote:
> On Wed, Oct 09, 2024 at 03:49:22PM +0800, Jinjie Ruan wrote:
>> Ping.
>>
>> On 2024/9/30 16:15, Jinjie Ruan wrote:
>>> When CONFIG_NET_9P_USBG=y but CONFIG_USB_LIBCOMPOSITE=m and
>>> CONFIG_CONFIGFS_FS=m, the following build error occurs:
>>>
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_free_func':
>>> 	trans_usbg.c:(.text+0x124): undefined reference to `usb_free_all_descriptors'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_rx_complete':
>>> 	trans_usbg.c:(.text+0x2d8): undefined reference to `usb_interface_id'
>>> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x2f6): undefined reference to `usb_string_id'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_func_bind':
>>> 	trans_usbg.c:(.text+0x31c): undefined reference to `usb_ep_autoconfig'
>>> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x336): undefined reference to `usb_ep_autoconfig'
>>> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x378): undefined reference to `usb_assign_descriptors'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `f_usb9pfs_opts_buflen_store':
>>> 	trans_usbg.c:(.text+0x49e): undefined reference to `usb_put_function_instance'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc_instance':
>>> 	trans_usbg.c:(.text+0x5fe): undefined reference to `config_group_init_type_name'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_alloc':
>>> 	trans_usbg.c:(.text+0x7aa): undefined reference to `config_ep_by_speed'
>>> 	riscv64-unknown-linux-gnu-ld: trans_usbg.c:(.text+0x7ea): undefined reference to `config_ep_by_speed'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_set_alt':
>>> 	trans_usbg.c:(.text+0x828): undefined reference to `alloc_ep_req'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modexit':
>>> 	trans_usbg.c:(.exit.text+0x10): undefined reference to `usb_function_unregister'
>>> 	riscv64-unknown-linux-gnu-ld: net/9p/trans_usbg.o: in function `usb9pfs_modinit':
>>> 	trans_usbg.c:(.init.text+0x1e): undefined reference to `usb_function_register'
>>>
>>> Select the config for NET_9P_USBG to fix it.
>>>
>>> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  net/9p/Kconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
>>> index 63f988f0c9e8..ee967fd25312 100644
>>> --- a/net/9p/Kconfig
>>> +++ b/net/9p/Kconfig
>>> @@ -43,6 +43,8 @@ config NET_9P_XEN
>>>  config NET_9P_USBG
>>>  	bool "9P USB Gadget Transport"
>>>  	depends on USB_GADGET=y || USB_GADGET=NET_9P
>>> +	select CONFIGFS_FS
>>> +	select USB_LIBCOMPOSITE
>>>  	help
>>>  	  This builds support for a transport for 9pfs over
>>>  	  usb gadget.
> 
> Ah, I can take this through the USB tree as it fixes a bug that came in
> through there.

Hi, Greg
Thank you very much!

> 
> thanks,
> 
> greg k-h
