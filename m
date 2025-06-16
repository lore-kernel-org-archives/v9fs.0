Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FD205AB6
	for <v9fs@lists.linux.dev>; Mon, 16 Jun 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115418; cv=none; b=CpPRNAVPPYKODT67eZ2lH31NxcWS3slHguGER4O+LXmlk3eJrJ7JQTY5yAlbreN9frpIEVelRn7oTU+E6VBdflCBn1gHn5cMIKne77to/WXk49GNf/jdLxSBGIEr2hNWgid0sNlxfbvhYfGoDnbp6eXvNr3/BPL3Pq+C9SWI04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115418; c=relaxed/simple;
	bh=l/dsEKZik8069kBgbRAsR0tcPdM8xcTYaQmnuK2tb18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHUpxi8Ayd5RI6/Jiwhq/bDCi/dKUfrCWd/KBri4wpbn9OpzDKQtXr8r5wiQN5i39TJTo1Eh5o3O9xRyuLwJ/NWqGF+GKDsc6aCYttesMulbRK6++WUZhUO+gUN4scvOUE5WVDSNvr+Uav6i1saOjhkr6P8KsjI/ISCzT5e8B+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ba1Vh+Nr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ba1Vh+Nr"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 45E3014C2D3;
	Tue, 17 Jun 2025 01:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750114827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LSj4gXCyHisTwhB2BQnYcgpL/7V+l81OjPQ3XMozPiY=;
	b=ba1Vh+NrSIjd7dsdd0+OHQAo7kEOIiMCbiZJITasBMpb06v5GCKFJzfa1Q00oZ7ppDVJYG
	V+JsgYIurMccniqSrkVZn6QnSlVESpbxMFZPC8sfVKmKZ+D3eo+daYi/ML7Vs8MJu4t/cR
	1BtXctHoYjA4lz1+e8LJvfTLuJIMFlCmmGvQXCcVMABgSNMwml7IPYNukXzENuyJR/XK7w
	LIkPx8oP95IJ7trvfZ/myMEkKZumsIBRyJr+knK01jJeJ8WRyBrEAcGxgk9x92o3cIZwfM
	mlxTijTq0BCrtF6ANKmdm/PJN/2PMo81dXOiCXGii/KvVky1ARmGdwrB/hSKmw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ffc07ee8;
	Mon, 16 Jun 2025 23:00:23 +0000 (UTC)
Date: Tue, 17 Jun 2025 08:00:08 +0900
From: asmadeus@codewreck.org
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFCh-JXnifNXTgSt@codewreck.org>
References: <20250616132539.63434-1-danisjiang@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616132539.63434-1-danisjiang@gmail.com>

Yuhao Jiang wrote on Mon, Jun 16, 2025 at 09:25:39PM +0800:
> A buffer overflow vulnerability exists in the USB 9pfs transport layer
> where inconsistent size validation between packet header parsing and
> actual data copying allows a malicious USB host to overflow heap buffers.
> 
> The issue occurs because:
> - usb9pfs_rx_header() validates only the declared size in packet header
> - usb9pfs_rx_complete() uses req->actual (actual received bytes) for memcpy
> 
> This allows an attacker to craft packets with small declared size (bypassing
> validation) but large actual payload (triggering overflow in memcpy).
> 
> Add validation in usb9pfs_rx_complete() to ensure req->actual does not
> exceed the buffer capacity before copying data.

Thanks for this check!

Did you reproduce this or was this static analysis found?
(to knowi if you tested wrt question below)

> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> ---
>  net/9p/trans_usbg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 6b694f117aef..047a2862fc84 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
>  	if (!p9_rx_req)
>  		return;
>  
> +	/* Validate actual received size against buffer capacity */
> +	if (req->actual > p9_rx_req->rc.capacity) {
> +		dev_err(&cdev->gadget->dev,
> +			"received data size %u exceeds buffer capacity %zu\n",
> +			req->actual, p9_rx_req->rc.capacity);
> +		p9_req_put(usb9pfs->client, p9_rx_req);

I still haven't gotten around to setting up something to test this, and
even less the error case, but I'm not sure a single put is enough --
p9_client_cb does another put.
Conceptually I think it's better to mark the error and move on
e.g. (not even compile tested)
```
	int status = REQ_STATUS_RCVD;

	[...]

	if (req->actual > p9_rx_req->rc.capacity) {
		dev_err(...)
		req->actual = 0;
		status = REQ_STATUS_ERROR;
	}
	
	memcpy(..)

        p9_rx_req->rc.size = req->actual;

        p9_client_cb(usb9pfs->client, p9_rx_req, status);
        p9_req_put(usb9pfs->client, p9_rx_req);

	complete(&usb9pfs->received);
```
(I'm not sure overriding req->actual is allowed, might be safer to use
an intermediate variable like status instead)

What do you think?

Thanks,
-- 
Dominique Martinet | Asmadeus
