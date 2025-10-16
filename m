Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651E1DF982;
	Thu, 16 Oct 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621342; cv=none; b=GaN8+hgAmGAafdHo7ujshi/LD9hnM2/Ntbg1LocoL1w6iWj8paIcESvv508pfNGKkJOzDiEtOp1jNgVGc9nr0qtQbQfudhM/Tt1jPATVzyU6gUewTAEjDUvyJAaLOiFSwr9I1GG3SC4FrZ/JSmy2x3U4/5q+yrUOZ2F+NcuF9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621342; c=relaxed/simple;
	bh=W7EFgnzr5VtHMbZSDIKFfHdRgXS6s6BbdPilZrxfOy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc5ewYBb7OKgxpX6xqdQNLw2FKIQlTeugTtWN2iJ8sA1s2tMaUu/SC1rGNndSVmbE7ycxcQiHqSJYz43GaLHH08EMyn1c4LIwNikwr8n1dpMzjm8xLKw1tM++wKzxXC/ez5qIgII2YaLrJNJ5KiFK7ftUvTqMH3KlJHSJ9Qako4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=PSTTxJjz; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PSTTxJjz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=b2ScJ6plfteW9i8eAYDh25/3yzR6qSuYHL3UCvaBAQE=; b=PSTTxJjzed2gJfl+vwX+HLgzSH
	9TZqqtJpFXglC0AA6CP2k2yH1EJxMX4Xc9SMaRPpuz3i+A83eeXMbeL99q6g6CiLymMspp1kOAgpX
	1/U/L4xp6QbmP63hsrQ1bYCmhX6HB6Dgm6dDZuJoL433TRyajYacZ1cwq+ksYVssCHUR2MepGVlFW
	TDb6WWsmSR2beF0aIEVcB8wCaQ4HaU16+6/jMeOumX4FtnR3kLdUZRajudj3naYJZCf5jAt5DG35Z
	tzZmVFQOotlq44fcXn6myw5KG0txGbXZmjuNKfohlTaFu6xq5XAahofMto7lhPwKKNa4n7h35+0GQ
	0+IczkB3CW4ohUAJQzPxy93SEEqGS+Yt4JQX5Yakghn8BWPWXMzKgkUyhiLto7ZEGGFN2mgDcyPou
	A0KraeQNEu8P0ieYr5qWP0JjgEWtLn204ERmO78dHxqYuEQVke2aDk2jjocFY7p54CFY4A0UA/Ofc
	Hahv5RnOQE8ApYclVVFlF8C0sVyPGD8PRKtw5Y4ZJkYMd0rCLytQxX7sZUOyzkK8KyDdbZKzXtDes
	2TdMGiDY9mdwbJeQ144azsosjYEXuehhZgGTGS3F0eI25piSKM8jMgxUqjPPytXyjm4Y09iueimJe
	EQ9EFo4nXBGggb2XR554Q9WggbrVNT93xfgFRCzh8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus <asmadeus@codewreck.org>, Pierre Barre <pierre@barre.sh>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] 9p: Use kvmalloc for message buffers on supported  transports
Date: Thu, 16 Oct 2025 15:06:09 +0200
Message-ID: <5019358.GXAFRqVoOG@silver>
In-Reply-To: <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
References:
 <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, October 16, 2025 9:01:56 AM CEST Pierre Barre wrote:
> While developing a 9P server (https://github.com/Barre/ZeroFS) and
> testing it under high-load, I was running into allocation failures.
> The failures occur even with plenty of free memory available because
> kmalloc requires contiguous physical memory.
> 
> This results in errors like:
> ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)
> 
> This patch introduces a transport capability flag (supports_vmalloc)
> that indicates whether a transport can work with vmalloc'd buffers
> (non-physically contiguous memory). Transports requiring DMA should
> leave this flag as false.
> 
> The fd-based transports (tcp, unix, fd) set this flag to true, and
> p9_fcall_init will use kvmalloc instead of kmalloc for these
> transports. This allows the allocator to fall back to vmalloc when
> contiguous physical memory is not available.
> 
> Additionally, if kmem_cache_alloc fails, the code falls back to
> kvmalloc for transports that support it.
> 
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
> 
>  include/net/9p/transport.h |  4 ++++
>  net/9p/client.c            | 11 +++++++++--
>  net/9p/trans_fd.c          |  3 +++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
> index 766ec07c9599..f0981515148d 100644
> --- a/include/net/9p/transport.h
> +++ b/include/net/9p/transport.h
> @@ -24,6 +24,9 @@
>   *                   we're less flexible when choosing the response message
> *                   size in this case
>   * @def: set if this transport should be considered the default
> + * @supports_vmalloc: set if this transport can work with vmalloc'd buffers
> + *                    (non-physically contiguous memory). Transports
> requiring + *                    DMA should leave this as false.
>   * @create: member function to create a new connection on this transport
>   * @close: member function to discard a connection on this transport
>   * @request: member function to issue a request to the transport
> @@ -44,6 +47,7 @@ struct p9_trans_module {
>  	int maxsize;		/* max message size of transport */
>  	bool pooled_rbuffers;
>  	int def;		/* this transport should be default */
> +	bool supports_vmalloc;	/* can work with vmalloc'd buffers */
>  	struct module *owner;
>  	int (*create)(struct p9_client *client,
>  		      const char *devname, char *args);
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 5c1ca57ccd28..2a4884c880c1 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -229,8 +229,15 @@ static int p9_fcall_init(struct p9_client *c, struct
> p9_fcall *fc, if (likely(c->fcall_cache) && alloc_msize == c->msize) {
>  		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
>  		fc->cache = c->fcall_cache;
> +		if (!fc->sdata && c->trans_mod->supports_vmalloc) {
> +			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
> +			fc->cache = NULL;
> +		}
>  	} else {
> -		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> +		if (c->trans_mod->supports_vmalloc)
> +			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
> +		else
> +			fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>  		fc->cache = NULL;
>  	}
>  	if (!fc->sdata)
> @@ -252,7 +259,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
>  	if (fc->cache)
>  		kmem_cache_free(fc->cache, fc->sdata);
>  	else
> -		kfree(fc->sdata);
> +		kvfree(fc->sdata);
>  }
>  EXPORT_SYMBOL(p9_fcall_fini);
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index a516745f732f..e7334033eba5 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -1101,6 +1101,7 @@ static struct p9_trans_module p9_tcp_trans = {
>  	.maxsize = MAX_SOCK_BUF,
>  	.pooled_rbuffers = false,
>  	.def = 0,
> +	.supports_vmalloc = true,
>  	.create = p9_fd_create_tcp,
>  	.close = p9_fd_close,n
>  	.request = p9_fd_request,
> @@ -1115,6 +1116,7 @@ static struct p9_trans_module p9_unix_trans = {
>  	.name = "unix",
>  	.maxsize = MAX_SOCK_BUF,
>  	.def = 0,
> +	.supports_vmalloc = true,
>  	.create = p9_fd_create_unix,
>  	.close = p9_fd_close,
>  	.request = p9_fd_request,
> @@ -1129,6 +1131,7 @@ static struct p9_trans_module p9_fd_trans = {
>  	.name = "fd",
>  	.maxsize = MAX_SOCK_BUF,
>  	.def = 0,
> +	.supports_vmalloc = true,
>  	.create = p9_fd_create,
>  	.close = p9_fd_close,
>  	.request = p9_fd_request,

Just for clarity I would add .supports_vmalloc = false to the other 
transports. Except of that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Thanks!

/Christian


