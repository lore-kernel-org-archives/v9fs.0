Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722718B47E
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913847; cv=none; b=nSl3MQnvq+EvUp+qIseHzA2wFvOVU/kOrniXrRm+tYqNyb3tb+g58iX29/tH9MnH4g9tM8jqe87VDjaKhYj9Em8+csGZmbeXGZzt/QJ4N+I+FHkMwUeait7aANx+/+xW3h7chr8qTq8udV4z+mq1mmr05F9Mymjc0IuxhQWekQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913847; c=relaxed/simple;
	bh=ddVPTpr4vlJtmcH42Kyjnj4MF0i/bfMojR6IIfEnIpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKKjQySZU1y328Xp6t5Ya5Viv1zg3pjXU3UZ6PNpkRiy3XfnzGtOTcQX4ONdap2biH4wQua9Yzis5yUuIguM+a41XdH6NNrAxEf4XRXQkH791QwZ4VEnNGqt7srT3XLkT5Hej2EUH8+B/fA7+gi0Udr3P9JzIgi/yKB+aSHtUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=O77M/fGU; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="O77M/fGU"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id EED7314C2D3;
	Thu, 31 Jul 2025 00:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1753913246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iiZLDAfEF+WO6c2mW5XQmquEWbHBp4FM+aN7ari3muw=;
	b=O77M/fGUAz+iPaahe8hEHDJjg2yUndSGGQ/smAnVJMQ48f5miEliYFGzYAFHsS5A+3zVwB
	PJJq1eKzISfZlPPQwDVf8lSlL+ef2fRNsSJCrMWyF6Juxk6ocaVg9Jw+Lt/c3mMmHv5/TM
	w7SFUKGctTxDl2f+RU122UqrKrBKU8ruMH72NRuD/PII1nDZHFnthvzw95rt2jaW1WDbun
	rJMFlHkWvDJOz3ynK0bFflHtGqYrgZAM1b7AvTcgih79s95MnCMJC6qjJskA8HAQtoebxR
	lNU9k37E2hzUeBR5vJj7Eq9awPjTnobvWrel4mNq9BJ6yGOoA54gNhsDH+w9vQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d224c4b4;
	Wed, 30 Jul 2025 22:07:22 +0000 (UTC)
Date: Thu, 31 Jul 2025 07:07:07 +0900
From: asmadeus@codewreck.org
To: Pierre Barre <pierre@barre.sh>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Message-ID: <aIqXi6uBaWXtvgm3@codewreck.org>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
 <2026737.7mX0AZtNi0@silver>
 <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>

(Added Willy in To, if you have time to advise on what's appropriate
wrt. memory allocation here to use either as a contiguous virtual memory
buffer or a scatterlist for various kind of dma used by transports
that'd be appreciated)


First - thanks for starting this thread, large contiguous allocations
has been a problem reported regularly in the past, and no-one has had
the energy to address it yet, but it's definitely something worth
tackling.


Pierre Barre wrote on Wed, Jul 30, 2025 at 10:16:13PM +0200:
> As a middle-ground, would it be acceptable to add a transport
> capability flag indicating whether the transport requires contiguous
> memory for DMA?

I think such a flag will be needed even if we do what Christian suggested:
>> So a more reasonable solution instead might be using kvmalloc(), as suggested
>> by you, and adjusting the individual transports such that they translate a
>> virtual memory address to a list of physical addresses via e.g.
>> vmalloc_to_page() if needed.

Start with a requires contiguous flag set for all transports except
trans_fd (I'm not sure about usb, but I'm pretty sure all the rest need
it); then each transport can figure out how to get a scatterlist or
something they need from the allocation, so we don't need to have a big
bang that breaks everything at the same time.

I'm sure virtio's implem will come soon enough, but I don't see anyone
working on RDMA or xen so fast.

> 1. Add a P9_TRANS_REQUIRES_CONTIGUOUS flag to struct p9_trans_module
> 2. Set this flag for virtio, xen, and rdma transports

This is a nit but I'd rather the flag go the other way around, e.g. no
flag means requires contiguous and it's only set after confirming the
transport works
(I just looked at usb and struct usb_request makes me think some drivers
use dma, so, yeah..)

We can always turn it around later if the majority of transports handle
it.


> 3. Modify p9_fcall_init to check the flag:
>      if (c->trans_mod->caps & P9_TRANS_REQUIRES_CONTIGUOUS)
>         fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>      else
>         fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);

I'm also curious if there's something more appropriate than kvmalloc wrt
using either as a contiguous virtual memory buffer or a scatterlist, but
I think this is fine for now unless someone knows of something more
appropriate.


Thanks,
-- 
Dominique Martinet | Asmadeus
