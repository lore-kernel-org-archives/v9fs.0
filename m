Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B602F5A0F
	for <v9fs@lists.linux.dev>; Thu, 16 Oct 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599612; cv=none; b=dAXX+mKfWUfP8J/W7CHDKtrsA4qGAw/Mdlt6J8W44RJcimwwnMP89aLgUG1CdVgs5Y7xOMB6rJyXD1VwzwHhFrjCbrfVMf5VEEzowBQxR5q5U6Sy/oDAKp5lecv0GoA/k+oNkpHvlHkWmiKdcu8y8yD4SIoLZ4HVIwe/EVVCXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599612; c=relaxed/simple;
	bh=05UloXMOGfgA+Goo9cxLqaUMFw/jumZnq1r5CrX4S4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCctEVFK1lWd5SLBqO/s4qCEuxdJYphn8iGJwDO8BykDLpCRODQkybkaiMlK6MUNj02qc9kSe9OkMdKaSxO6ojwRCGYn5Tsx+PNd/ZU4JbHM39/AxPTHRdr+9nliQFaDJ+Z0b7tB8k/YpyMaOdfLdO4hfs96NlER715dimfIQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hbA2h2qs; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hbA2h2qs"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3A55614C2D3;
	Thu, 16 Oct 2025 09:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760599601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmnapE2YgNjNgRuKkBe2xcRK85JFWVZYlkYtqwl7MHw=;
	b=hbA2h2qsL5cAQnGwJpj1cNQCxwckWIE7YcGzRO4Hwv7BF8prQcRxOvDROkj5DxbEzX492B
	pcjx3f3f0QGjVzejjR6qmv4kGVZ28l40hrm/KI9Ttv/cxgpjNWlCU1wnrcx4FrBkzCoO0g
	MmTmYpEf63nnBGY//iU2L80013b+bzn4lsIdvYeLfGx52ZgaJhTQgnp/8rpwyAq+Ubgt9m
	4K/ImeBkJ/pmdvn+Ns3j8CfY22nieaNKPb64Jt/3MgK2k7iR+Eeho4hfPqVKoJchbbK5BT
	sRFdk6peYBXAD1PX97Wm8w8e835uF6NYyoSv/2cWkpyI454XUq/zmnSjp5z1cA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5e445050;
	Thu, 16 Oct 2025 07:26:37 +0000 (UTC)
Date: Thu, 16 Oct 2025 16:26:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: Use kvmalloc for message buffers on supported
 transports
Message-ID: <aPCeHj4vrDnc8R8v@codewreck.org>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>
 <aJPMwqqchOaZFSqn@codewreck.org>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>

Pierre Barre wrote on Thu, Oct 16, 2025 at 09:01:56AM +0200:
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

Looks good to me, I'll pick this up for -next when time allows and it'll
get in 6.19 in a few months

Now to get someone to make this work with virtio... :)



> @@ -252,7 +259,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
>  	if (fc->cache)
>  		kmem_cache_free(fc->cache, fc->sdata);
>  	else
> -		kfree(fc->sdata);
> +		kvfree(fc->sdata);

(Oh, it's ok to kvfree() something allocated with either kmalloc
or kvmalloc, neat.)

-- 
Dominique Martinet | Asmadeus
