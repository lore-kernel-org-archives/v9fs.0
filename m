Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED464217723;
	Tue, 15 Sep 2026 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455085; cv=none; b=IBOLy/mFZlpoH1au2F/GZ6cBuiEvHhLiTyiE8uXYl+oVMkSnF7VL02eeqhljBNryY2nebarYAwjNxQIa1b3Y9+TeLGC1HnRZZZw7sc/eoR8Bo2vuG9FEZDOrHUdrdj3yNFrk+zlEqDI8mLyko4CyvSXso7TImccySUo31Wgfmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455085; c=relaxed/simple;
	bh=Rzu/DvTlLzOxPncOC7q4NGfOAA8xj0FMiwwkPCvSeZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqu+a460CoTRJLVMnCFroQ2f/lLQZJdyyjcbrCuoaIT2gMqiZIl5kTMIEwuA4Nvcuv0yAGTlSGn7/XQAbirDgcvvrsxGglczViy8Rj17qaPlnQzpNhSKDLg8I30GKRsWvbSv3awvknY5BTLjr0YGhc2QEV/LmHHTjwN+gVMyDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4ons60v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4ons60v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0594E1F000FF;
	Tue, 15 Sep 2026 06:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455083;
	bh=GxZNt8/Z5BCAZDMiJFFdwsLVIH457rLHjlpMQ6ZHvm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4ons60vNAiNv2bAcSKM2RAEg8/l+u0DQ7FK3ylWaywYhRVCJG0ZWA9TTdaQ3hkXZ
	 s5/5YtBCly6bTlePClqbkfQ4wTRT7hCzS3ykgak0Uo5isWjwPu7sKhXeyl8cWOwYC3
	 8bqc0KhZNcyQMbGF+5yNw9ZVlnfxUaW0C3x+etqKXBxEqFUFsLjZB3YimsTHFT6qms
	 JAfhyJ5SkufHHO4R8QTdvUMmfiAzf9C0kSdo6qkyG+E0b5O9pfiCoA14AmJDjjlElv
	 GS42UEwP3r6okZ0Hjt0cI6qJR+quvjzBF9gS2KU0X1A6mZ6ymycObrCAVijV3KvFW2
	 2Rjl1MWtlpIOQ==
Date: Tue, 15 Sep 2026 08:51:18 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, 
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free on usb9pfs_clear_tx
Message-ID: <aqjqwG_6zXJYC7nW@line.checkpat.ch>
References: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>

On Fri, May 29, 2026 at 04:10:25PM +0800, Yizhou Zhao wrote:
> When p9_usbg_close() is called, it invokes usb9pfs_clear_tx() but does
> not clear usb9pfs->client nor usb9pfs->in_req->context afterwards.
> The 9p client core (p9_client_destroy) calls close() and then
> kfree(clnt), so after p9_usbg_close returns the client struct is freed.
> 
> If the USB gadget is later disabled (e.g., host disconnect),
> usb9pfs_disable calls usb9pfs_clear_tx again, which passes the dangling
> usb9pfs->client pointer to p9_client_cb. Inside p9_client_cb,
> p9_req_put(c, req) dereferences the freed client to access its reqs IDR,
> causing a use-after-free.
> 
> Additionally, usb9pfs_clear_tx does not clear usb9pfs->in_req->context
> after calling p9_client_cb, so a second invocation finds a stale request
> pointer and attempts double-completion, further compounding the UAF risk.
> 
> Fix by:
> 1. Clearing usb9pfs->in_req->context to NULL in usb9pfs_clear_tx()
>    before checking usb9pfs->client, so that even if the client is gone
>    the stale request pointer is consumed and cannot cause
>    double-completion.
> 2. Adding a NULL check on usb9pfs->client in usb9pfs_clear_tx() to skip
>    p9_client_cb() when the client has already been destroyed.
> 3. Setting usb9pfs->client = NULL in p9_usbg_close() after calling
>    usb9pfs_clear_tx(), to prevent any subsequent call from dereferencing
>    the freed client pointer.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Acked-by: Michael Grzeschik <mgr@kernel.org>

> ---
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 1ce7033..c75de5c 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -435,6 +435,11 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
>  	if (!req)
>  		return;
>  
> +	usb9pfs->in_req->context = NULL;
> +
> +	if (!usb9pfs->client)
> +		return;
> +
>  	if (!req->t_err)
>  		req->t_err = -ECONNRESET;
>  
> @@ -457,6 +462,7 @@ static void p9_usbg_close(struct p9_client *client)
>  	client->status = Disconnected;
>  
>  	usb9pfs_clear_tx(usb9pfs);
> +	usb9pfs->client = NULL;
>  
>  	opts = container_of(usb9pfs->function.fi,
>  			    struct f_usb9pfs_opts, func_inst);
> 
> --
> 2.43.0
> 
