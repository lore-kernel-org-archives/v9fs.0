Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DB190692;
	Wed, 30 Jul 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893466; cv=none; b=bMlJmvickD+8nm8caZA7wdGvdjynell4WBxDfWweCoEsIrWzQDrK2dFNVTl7tHIqJ5CQQvPCb075HVUzefByYI2gpPhUcv1VZ7/+RX/oaXYgZnOt+CpDOadwDddYXAQkom94BpzQ2E4wMW94bBYW5tExNWSZQQ8xDuoGIyrhS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893466; c=relaxed/simple;
	bh=0C0KsPi9Xafpx8vSaO7NnuYX2LgMpY46VySoYhdbHeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiXDhO4c+gz64QNZka+H/LDED9PEhAVU7KVXLunmqlsUbOgd55FnarcRpJYo1gW4NE2HkglbFvvYNjROr+n2nVyT+bmi5OIcFxmc7lFNyW5vJjQ/mvbquDdga2cMcCui7aNTp0MeZHtJvb57NztPSQnn4zJvjk6nBvBobSvtIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=hclBiAz5; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hclBiAz5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=6WzFyA7HHnsN0YX0BqT+sbS2GLp4HfpygWNA1sHG2qA=; b=hclBiAz56+bxfks6IKny9sWiCZ
	jQoQkRoa5oVm0TQejM5rrKbmeb2XyRSlxuFMcqXp3CZq3ZWab5/zMHJPrtU6P6BcNeThuC/LHCGF3
	njZmGfkU3/DDeh05Uka4WpkVCdPlqsbdcdPVipCvx7A1nyMknpmK6dcIw4YBflPLA+sFBX4WKghJ1
	m4BKUuFaZy+/g/LorgBsNVoLzHY1tCU6LRk7HtNXzfgsoL04GDz8eaSJss/Of7zhkt/2a69xY1vrx
	GaD6w1prP3wxhLJJz0H7YbVec6Og6suugJRC3ElLKShYAPWePDgMy9SDuowNsOHcpie6MHfsY3A/j
	PScQy7ssolPiKR33AaurA32/d5RyoY2xRnjVGoS6z3cwmvfr/tCfYN30fFAAl8uZR0K2VH4w7HnZm
	6xRoTgn3rEYPOewFOqYMhZ3RPthxOBY0b1emvMVB4/Tg+qagpGKhGs6MfRk8fvIj8uWQXAX0vXGZ8
	/C3IMYWDmvmZm/5vNHc3DFY2N82mWnnzuKwHkHAFY7KyFBXTOH0n/h61dL2XD9fPbBvyUsPG4LnP3
	kF759PRQn1pWJkkiJuAz4XoHK//J2uT+Zkurjdo2HYYfDB+1DovmVI5DkPVoL9zreJcnw4zKVSME/
	0TYT8MqVgj03RawFZIMUaIshc5JIlmoCeb/gUdGZA=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Pierre Barre <pierre@barre.sh>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Date: Wed, 30 Jul 2025 18:08:13 +0200
Message-ID: <2989343.ydHz1Oe0dO@silver>
In-Reply-To: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, July 30, 2025 5:08:05 PM CEST Pierre Barre wrote:
> While developing a 9P server (https://github.com/Barre/ZeroFS) and testing it under high-load, I was running into allocation failures. The failures occur even with plenty of free memory available because kmalloc requires contiguous physical memory.
> 
> This results in errors like:
> ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)

What was msize?

> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  net/9p/client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 5c1ca57ccd28..f82b5674057c 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -230,7 +230,7 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
>  		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
>  		fc->cache = c->fcall_cache;
>  	} else {
> -		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> +		fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);

That would work with certain transports like fd I guess, but not via
virtio-pci transport for instance, since PCI-DMA requires physical pages. Same
applies to Xen transport I guess.

>  		fc->cache = NULL;
>  	}
>  	if (!fc->sdata)
> @@ -252,7 +252,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
>  	if (fc->cache)
>  		kmem_cache_free(fc->cache, fc->sdata);
>  	else
> -		kfree(fc->sdata);
> +		kvfree(fc->sdata);
>  }
>  EXPORT_SYMBOL(p9_fcall_fini);
>  
> 


