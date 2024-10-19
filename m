Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A1DE887;
	Sat, 19 Oct 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340735; cv=none; b=AylRSU6x0jW2kUDnexwLlnZQWso0ysf2fZhcUfmy4982FNe7RjKvG/+WAwgm+Uc1f/PVpuBFnzRPLrjib+Z6Kmtentt/wgjQ+UL9XZim3SLEfU/fUTIpPvcld9LnC4+r1pRqwH5wX5JjjWKGBCqe+0LaEsg68Mgtv9YP3mH7THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340735; c=relaxed/simple;
	bh=83gIlBADgU0w1Q7k794QLQ7+PeOyUylNZ3LEjz601W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSvzStPS0vOhoyXnhGAcBku8t/mxzV7anUyXj61VRZ8UHYN/Me7+a7JV1sr9tRXdAfbd1oav3FVIYRrg5l5qfyRs8BhD3gpsVJg667U27g3ygDWj2WqKv578e+5UQoKi+lvjq87FnFg1ilmLI9oDQdONGm7Z29QMY83Pvim64c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 m.grzeschik@pengutronix.de, yuehaibing@huawei.com,
 gregkh@linuxfoundation.org, Yue Haibing <yuehaibing@huawei.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] 9p/trans_usbg: Fix incorrect error check in
 usb9pfs_alloc_instance()
Date: Sat, 19 Oct 2024 13:58:37 +0200
Message-ID: <1854979.Kn10jCkGcg@silver>
In-Reply-To: <20241019092302.212221-1-yuehaibing@huawei.com>
References: <20241019092302.212221-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, October 19, 2024 11:23:02 AM CEST Yue Haibing wrote:
> kzalloc() should use NULL check not a IS_ERR() check.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  net/9p/trans_usbg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 975b76839dca..6b694f117aef 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -909,9 +909,9 @@ static struct usb_function_instance *usb9pfs_alloc_instance(void)
>  	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
>  
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (IS_ERR(dev)) {
> +	if (!dev) {
>  		kfree(usb9pfs_opts);
> -		return ERR_CAST(dev);
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	usb9pfs_opts->dev = dev;
> 


