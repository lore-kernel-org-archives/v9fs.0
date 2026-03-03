Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D52248A3;
	Tue,  3 Mar 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544642; cv=none; b=FPx/gxVdFyGLSu45S71i9Fu3rR+c3tS+Xepsjjn0V9R9WWtUUzExqBAApzs/aIncEouyCqIXC3M52JM6Glf6zkoPC25fajp0R5T1D1Q/a2Nh9REDNnnBr4tx0as8oG5G0+M8jrDenEJ3YmH+mh1zvu0PICxqhKgvCK7jMMZ2mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544642; c=relaxed/simple;
	bh=gg5eDyLDYQo1E/EP0sjT73dNT6plErHiZoUyBrGDA0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHm8BGn0PYUCycSb30hs2vV6n6MzKvwr5Y5TImr6Z0lb86WFPDPPfPf5H2HhV0+K0TzhJBfB3NL+XsqB8x6fmV9BehQljhadpFnaB8ygbwU42YiCYtt/m/5LXB7vvs4AffwxUkABTaJgd8W68NN2yTD9cn7H8c91+GnX/5mG27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Bzu9byF9; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Bzu9byF9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=jPptrhPFGUii31dbECyV8x7in5GiZNoXYOb7iyJiRhs=; b=Bzu9byF9RzcU9/3fAHn+tr9fCU
	XtKxb3uOFayUt4SKK0QgBjlu6SIcUoEA1/yT48NfPh98ybgxUn+wECIL1GdmqoUmwlgLaSGYY1zek
	pcyWvCIEKKb/SC4FlXF24l+1fGvba88ive6O3keChCcnLOOuExBG0mGyYFSLYa/VIUnlNWOiyRp3G
	4Fms4UfQMFfHrln3AAb/2W3l0PDQOXJCLJyyOsJ4wpyWz9fTwx0RN0/8Yx4lnlVfVzBjmou1CB4KV
	08qIightqaq6xDN1ygoSxCW0FdQN3EaJOyp+BEhMoDv68T46qTmmFNoSPf4bg8cc8bx0uOY8NpxTX
	GVzIEHPhysi5uM6bYd9dyIk6g5z93H71oFa+Entsovsmuhrqqd466ZQEVPfgM0KLcVK88JRaE93Wz
	JkV4BFPGmhh7uCrMHsQ1INx46VZclnaCqWmxo+5aZHt7uBVvSFFJFZoCmEhpIr+VIppjYqrAzvVSB
	CcDeTRjULeO7wFdtEa1tPnNxDl+DP0gj/izmW4dVJcRyQz2hRWlBCNLH4W7VUAXWy1Ir7FGRw8ikd
	H1sAeWkWXEF5MepGnp6r+QYAjzRLh47EkfBsxq1TTwyPLlNH7dARnFRJABq/dm/957qHLWgKAT2DT
	FPOEIEJykqm+o+RUhct7wlJWnyFlPMIa8F7ZPKLNk=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Sasha Levin <sashal@kernel.org>
Cc: sandeen@redhat.com, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] 9p: fix memory leak in v9fs_init_fs_context error path
Date: Tue, 03 Mar 2026 14:30:36 +0100
Message-ID: <3398837.aeNJFYEL58@weasel>
In-Reply-To: <20260225135745.351984-1-sashal@kernel.org>
References: <20260225135745.351984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 25 February 2026 14:57:45 CET Sasha Levin wrote:
> Move the assignments of fc->ops and fc->fs_private to right after the
> kzalloc, before any fallible operations. Previously these were assigned
> at the end of the function, after the kstrdup calls for uname and aname.
> If either kstrdup failed, the error path would set fc->need_free but
> leave fc->ops NULL, so put_fs_context() would never call v9fs_free_fc()
> to free the allocated context and any already-duplicated strings.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/9p/vfs_super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
 
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 0a1c4f7cb001d..431f24938a1d3 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -312,6 +312,9 @@ static int v9fs_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
> 
> +	fc->ops = &v9fs_context_ops;
> +	fc->fs_private = ctx;
> +
>  	/* initialize core options */
>  	ctx->session_opts.afid = ~0;
>  	ctx->session_opts.cache = CACHE_NONE;
> @@ -345,9 +348,6 @@ static int v9fs_init_fs_context(struct fs_context *fc)
>  	ctx->rdma_opts.timeout = P9_RDMA_TIMEOUT;
>  	ctx->rdma_opts.privport = false;
> 
> -	fc->ops = &v9fs_context_ops;
> -	fc->fs_private = ctx;
> -
>  	return 0;
>  error:
>  	fc->need_free = 1;


