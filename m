Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C5299A94
	for <v9fs@lists.linux.dev>; Mon,  3 Nov 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156395; cv=none; b=U057dV/uaq5qJoddeSCv/pQ8vhliNxMUkjiIUaT3lQigdtw5RS0v3Yln96F2PaKyp3UBBaDh4A6/huYKwyttuTnVcuZwXGdEcLHai8FbTqhOrnVNHDatGSIdUnqWYXqcRANAC/vO3uKz97wyuEW6ccoXos92kJWlubhuGN5J2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156395; c=relaxed/simple;
	bh=81khHww0RXrIGfByOluomSheMwJMiosI66q5KkdC/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGbXgUXQyu6ftcIrg2lvZwfqYViQrH+7wBDIGaGvwgqN4cKzCI+zC9uTswjgQUlvIuq/gczUQAtC4LuxAzk/P99KYKFUQ6VdkD1OCDwKu5uaPBwGHrsXHx/QJ9XuoSxXzJVQNNWZidhm33cz+ryYY7iSVNRlfqSOKaihZIWucxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=YdmoOAiZ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="YdmoOAiZ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 61F4714C2D3;
	Mon,  3 Nov 2025 08:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1762156392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F9zWb1t8klcmQ6eGCLVDZoSM8kXy4Cpxwtf8zrpJYR4=;
	b=YdmoOAiZueOIu8yhEDUC6gMjIxzLj32Jwdfd9/McKak8N+sUZgT1KOS2Dmxe0GopVIsKSR
	IydtoIipg2uYcjUefEOH/A/22VDmp5vdKoVTSxmOo7s1ITdhBje18eaI5/3ncC9QBOYIhF
	udlck+vX7QsAbtgf7nJL5gDxTwe+1sS8hhFx6m6Ka7fr9OZK6QgM2uX284XIRJP/ytUG7F
	HvZRWYXZ2fioFmYxstR1SM03P6Gp0H0Oq8niTJEp3i4pCjSDlxtQyDohqUypR9PUp0yxaa
	JHRWDHF6v0C+sIJ+ZwKNpWm805JQQSWK9Ei7kMQS/ZX3IWte4FnDV4L0TEfR6A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0b5c3878;
	Mon, 3 Nov 2025 07:53:08 +0000 (UTC)
Date: Mon, 3 Nov 2025 16:52:53 +0900
From: asmadeus <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] 9p: Use kvmalloc for message buffers on supported
 transports
Message-ID: <aQhfVa_jdI_1kQwB@codewreck.org>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
 <5019358.GXAFRqVoOG@silver>
 <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>

Pierre Barre wrote on Thu, Oct 16, 2025 at 03:58:36PM +0200:
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

Thanks, it's now picked up and queued in -next -- will send to Linus in
a couple of months.

FWIW, I prefer (and I think it's the norm in the linux world) if patches
new versions aren't sent as a reply to previous version, it confuses
tools like b4 that fetch the patch thread for version operations.
If you send patches again please just send later versions without
using --in-reply-to :)

Cheers,
-- 
Dominique Martinet | Asmadeus
