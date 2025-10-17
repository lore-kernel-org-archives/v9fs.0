Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E8213E6A
	for <v9fs@lists.linux.dev>; Fri, 17 Oct 2025 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680238; cv=none; b=I+PbwsHijhL8qf8taeb/RBJ2OxgGpilAKB9ntmN79vuqf/V4QCbtsBvTf76y1/CQfd/dYzxfBuFEkaq8nA2GzOIIhWWl1Z11JB/xtil2xw0k1bk0H9MDzpKGaVk+y/4DwUFHo4cen220E7CTay6qw9U12rb3u6kJKoWlSXU0Zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680238; c=relaxed/simple;
	bh=q2z1XVsfOxaQEanFyl/O3jRiEJIBBrPJ+WgI7M7UIYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI4Gaay+kYPQv89MQKKRU1dDlIhoFR9qFG6e5Dv6ClKSLtvs+f7jGMugJJB8hUKF2x9kTWUiDI9o50uEUsKIhdNVYNX8Jzci2nLcvA455Uo3goLzp6QsmbF/zna6vPV3LdA2ip1OEUTK5bQYQNC5w7RyhsHT1k+5H6EuIS6Dcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fVyRJno5; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fVyRJno5"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 9dL6vKtrFnE4g9dL6vORDv; Fri, 17 Oct 2025 07:49:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760680162;
	bh=a0DQw3/InaKVaaSpMVnNMO5+IxlhSvGdj3eQnTfqumg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fVyRJno51WqygWBj7WjqLDoeuHsi4uG6O/0wxesYAKJ8J6CQf0ciMrTi9unLA3WI0
	 04OrTRao7g2IUE+JWk07hhZQNoW5YLJbqlHW49zOucJ8hWAr6XtZnMKpq1nbAflaIr
	 vlipTADdKGmCQ+beSEjuJ1jTfpniiB40wknKLOdwOsBXz8UuCHeiniJUi5w+qZIzGR
	 +CqCWGASLZMRr2Vgf2z2t2q0FMbzBEgP/IWe+3brKaC3KzgscryyxyAITUarAqDxtP
	 UYZqXl6Ew+7cdvuYUb3XDQgmO0dd2Q/F197f3kv+0bWy9v2KY+FMBrhq7uNLUT8Z10
	 dD8Tj225Mj3GA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 17 Oct 2025 07:49:22 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <25cab1de-ccc9-41b1-a7b1-8bfff44c74fc@wanadoo.fr>
Date: Fri, 17 Oct 2025 07:49:19 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] 9p: Use kvmalloc for message buffers on supported
 transports
To: Pierre Barre <pierre@barre.sh>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 asmadeus <asmadeus@codewreck.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
 <5019358.GXAFRqVoOG@silver>
 <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/10/2025 à 15:58, Pierre Barre a écrit :
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
> Changes in v3:
> - Added explicit .supports_vmalloc = false to DMA-based transports
>    (suggested by Christian Schoenebeck)
> 
>   include/net/9p/transport.h |  4 ++++
>   net/9p/client.c            | 11 +++++++++--
>   net/9p/trans_fd.c          |  3 +++
>   net/9p/trans_rdma.c        |  1 +
>   net/9p/trans_usbg.c        |  1 +
>   net/9p/trans_virtio.c      |  1 +
>   net/9p/trans_xen.c         |  1 +
>   7 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
> index 766ec07c9599..f0981515148d 100644
> --- a/include/net/9p/transport.h
> +++ b/include/net/9p/transport.h

...

> @@ -44,6 +47,7 @@ struct p9_trans_module {
>   	int maxsize;		/* max message size of transport */
>   	bool pooled_rbuffers;
>   	int def;		/* this transport should be default */

Unrelated to this patch, but it looks like 'def' could be a bool.
This would save a few bytes in the structure, should it matter.

CJ

> +	bool supports_vmalloc;	/* can work with vmalloc'd buffers */
>   	struct module *owner;
>   	int (*create)(struct p9_client *client,
>   		      const char *devname, char *args);
