Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0D2E658
	for <v9fs@lists.linux.dev>; Tue, 16 Jan 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440120; cv=none; b=T+4UN4wauvv1IiOlfEUjhgwZ8egNKy2e3W6se8vxuDMhZergQqlJpb87e6q632vQ1PKUbs7DxRSm+KX4JXdtpHnk2F9aqnn3XGxdcfT6i4oCBFJRVDz+zrOuwB+7RajlX0uH/Cr7Iylo7kUDOWb5JPyt3Ba7hxcKmqSQxlz6wH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440120; c=relaxed/simple;
	bh=U3x4ONFy9Ei70OFyJFkS3iOitDj71QgI6j6TOl7h2vo=;
	h=Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:X-ME-IP:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=AfygbzSzOKH7Dbs34TkPjCtLyAdHm/RAFA9kr7m3QfQUC9MQYhbto/1h68k0YVPnRZ33oqQLyRD7OwkLTYKPoI1n8Cu7VKJxgVcUz8p23qZSv0Xqgdd4u5QthQFCTnQz9ZugOrL+aAGhMM7MfkNEHqzlRzIadbko0NVYsHCKpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GaBM+qsL; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GaBM+qsL"
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Pql9rceCI6FTdPqlBrC9ak; Tue, 16 Jan 2024 22:14:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705439658;
	bh=wS8NzOHKk5phyyBMwvuAnpbVzPwUbfEIN5JtjGlJSK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GaBM+qsLiFrpekYiaNN0jSJ1W0trwHwP5lRr1FwXjar/CcXCr5uiGbqgt42sVpPl2
	 410dXKMWYXfBn15nVxKkWu2LMhEWwwDccADPFlhPKxL7i7OEn4Z74VGLjzvDgBYtc7
	 9be/a0NZebkt2fhTQ1u8DU4vMxHgJsZB7BqQyizjR4wLED9wG9TbQVoK9On/UVwGZ7
	 /YHvJ6B7ztLptm2TLilg6RFexTnEIXLSNdY4qgZIh/slb9feL7OLWpdYTaLsZZZdBX
	 nc2vOWeovSzexpKdzCrJJ2YIycGvk6S23k2tcHGIzaot7XD9XdCR/M4Ac6Avfn9bYz
	 pSdi+hyvh7Ktg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Jan 2024 22:14:18 +0100
X-ME-IP: 92.140.202.140
Message-ID: <de0bd3d3-bb7b-4f94-aae2-0d9323b273fb@wanadoo.fr>
Date: Tue, 16 Jan 2024 22:14:10 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Content-Language: en-MW
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
 <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/01/2024 à 02:49, Michael Grzeschik a écrit :
> Add the new gadget function for 9pfs transport. This function is
> defining an simple 9pfs transport interface that consists of one in and
> one out endpoint. The endpoints transmit and receive the 9pfs protocol
> payload when mounting a 9p filesystem over usb.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>   Documentation/filesystems/9p.rst     |  12 +
>   drivers/usb/gadget/Kconfig           |  11 +
>   drivers/usb/gadget/function/Makefile |   2 +
>   drivers/usb/gadget/function/f_9pfs.c | 849 +++++++++++++++++++++++++++++++++++
>   4 files changed, 874 insertions(+)

...

> +static int alloc_requests(struct usb_composite_dev *cdev,
> +			  struct f_usb9pfs *usb9pfs)
> +{
> +	int result = 0;
> +
> +	usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
> +	if (!usb9pfs->in_req)
> +		goto fail;
> +
> +	usb9pfs->out_req = usb9pfs_alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
> +	if (!usb9pfs->out_req)
> +		goto fail_in;
> +
> +	usb9pfs->in_req->complete = usb9pfs_tx_complete;
> +	usb9pfs->out_req->complete = usb9pfs_rx_complete;
> +
> +	/* length will be set in complete routine */
> +	usb9pfs->in_req->context = usb9pfs->out_req->context = usb9pfs;
> +
> +	return 0;
> +
> +fail_in:
> +	usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
> +fail:
> +	return result;

'result' is never overwritten, so we always return 0.
Is it on purpose?

> +}

...

> +static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)
> +{
> +	struct f_usb9pfs_opts *usb9pfs_opts;
> +	struct f_usb9pfs *usb9pfs;
> +
> +	usb9pfs = kzalloc(sizeof(*usb9pfs), GFP_KERNEL);
> +	if (!usb9pfs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
> +
> +	mutex_lock(&usb9pfs_opts->lock);
> +	usb9pfs_opts->refcnt++;
> +	mutex_unlock(&usb9pfs_opts->lock);
> +
> +	usb9pfs->buflen = usb9pfs_opts->buflen;
> +
> +	usb9pfs->function.name = "usb9pfs";
> +	usb9pfs->function.bind = usb9pfs_func_bind;
> +	usb9pfs->function.set_alt = usb9pfs_set_alt;
> +	usb9pfs->function.disable = usb9pfs_disable;
> +	usb9pfs->function.strings = usb9pfs_strings;
> +
> +	usb9pfs->function.free_func = usb9pfs_free_func;
> +
> +	mutex_lock(&usb9pfs_ida_lock);
> +
> +	usb9pfs->index = ida_simple_get(&usb9pfs_ida, 0, 100, GFP_KERNEL);

This API will soon be removed.
Please use ida_alloc_max() instead.

Also, there is no corresponding ida_free()? (or isa_simple_remove())

> +	if (usb9pfs->index < 0) {
> +		struct usb_function *ret = ERR_PTR(usb9pfs->index);
> +
> +		kfree(usb9pfs);
> +		mutex_unlock(&usb9pfs_ida_lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&usb9pfs_ida_lock);
> +
> +	usb9pfs->tag = kasprintf(GFP_KERNEL, "%s%d", usb9pfs->function.name,
> +				 usb9pfs->index);

Same here, it seems to be freed nowhere?
I think that both should be added in usb9pfs_free_func().

CJ

> +
> +	INIT_LIST_HEAD(&usb9pfs->function_list);
> +
> +	mutex_lock(&usb9pfs_lock);
> +	list_add_tail(&usb9pfs->function_list, &usbg_function_list);
> +	mutex_unlock(&usb9pfs_lock);
> +
> +	return &usb9pfs->function;
> +}

...


