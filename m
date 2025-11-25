Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8318A93F
	for <v9fs@lists.linux.dev>; Tue, 25 Nov 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061421; cv=none; b=UdLDo5L2yCgXYFTW+GD/3lhnkKeKLgd47hXARtK2oUYX1xEAyvbv+Mk3WRI7ojwOlCDmnJ2LpAnvsuWmZqJBswXVtCGet3I4DtAwG4FA6fR37418nbP8bSE1Ua+V7cfoEui3qcZF1yeDEdn5Fbke+CkYBWL7y0ElWpPcxnNn1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061421; c=relaxed/simple;
	bh=QuWevpztLeKuSYbwkEWbIhzEcMgJD9CgSQGrH0zQfrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NugxmuiTMoKq5Cthn0uTPLeMFafhBUkMYVpEZsxN63yccL6i4RlDoAEpSHbaaQ7dtSIm0iNZ5HQe8ne3auSlb0wtN8kn0GWB+sm1Pw+EF5yf191IC10ICPa/PmZdH2AElyynYWW9xbh6BWpwwnqiskjp4Ekve1ynkU9jee4L7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RK0fxTpo; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RK0fxTpo"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9ACA114C2D6;
	Tue, 25 Nov 2025 10:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764061412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZZkTeoG5+7ll6N+KbYW/2fVYo0SehWJUdee6e3BAro=;
	b=RK0fxTpoxZ1avh5uHus2PiPof3Se+nxrgX4V67Flp82wZg66II5Q1uCjBcUllwyGUucEd4
	gGlK63XcB/wbtke8t4cWmM9h/rcXn11ztiMP4JmtJAcQ7TTEPuLuvW3czFY8PtMSJyFEcd
	3zdm2mYaSiMdUjnQ32g/QW/pYq4ly1KDrj9/vX50c05ypEhu27a7bbuK1jhWIWHhWMojWr
	uxQrm01jrRVVCP+6G77NPB9TbVShQBiurxWrdFo0ba/RemIhGnZH5l7+mWovQ5mY5DdcF/
	NNQVAbD7RCvrFmUcLuh67fEj8QheH1c/rGz5qmIw/zKnP4ocDqAuqYhBtowjrg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4da2ffb5;
	Tue, 25 Nov 2025 09:03:27 +0000 (UTC)
Date: Tue, 25 Nov 2025 18:03:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aSVw0M8f3vTXdQxH@codewreck.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <aSTmUTOIm4hnU7aw@codewreck.org>
 <aSTwj8LfyFvAXEqc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSTwj8LfyFvAXEqc@casper.infradead.org>

Matthew Wilcox wrote on Mon, Nov 24, 2025 at 11:55:59PM +0000:
> > > [   31.395976][   T62] page_type: f8(unknown)
> 
>         PGTY_large_kmalloc      = 0xf8,
> 
> So somebody called kmalloc(2 * 1024 * 1024).  Not sure if that's helpful
> in tracking this down?

This is a "zero-copy rpc" so the pages come from wherever the iov_iter
we were passed was from, and we don't really check...
In particular that zero-copy code in net/9p/trans_virtio.c hasn't
changed much since Al Viro rewrote the 9p code to use iov_iter in 2015
(commit 4f3b35c157e4 ("net/9p: switch the guts of
p9_client_{read,write}() to iov_iter")), and I'm not quite sure anyone
ever looked at if it is anywhere close to friendly with folios...

So I guess it turned out not to be:
> > > [   31.398075][   T62]  ? kvm_sched_clock_read+0x11/0x20
> > > [   31.398131][   T62]  ? sched_clock+0x10/0x30
> > > [   31.398179][   T62]  ? sched_clock_cpu+0xf/0x1d0
> > > [   31.398234][   T62]  iov_iter_get_pages_alloc2+0x20/0x50
> > > [   31.398277][   T62]  p9_get_mapped_pages.part.0.constprop.0+0x6f/0x280 [9pnet_virtio]
> 
> Oh, hang on.  You're passing a kmalloc'ed page to
> iov_iter_get_pages_alloc().  That's not allowed ...

Thanks for finding this, I wouldn't have noticed.


> see https://lore.kernel.org/all/20250310142750.1209192-1-willy@infradead.org/

I'm sorry but I'm not sure I see what I should do from this -- your
patch looks to me like it should now work with this?
Oh, it's not merged?... I don't see where the discussion stalled
either...


For context, in this case virtio needs the pages to be pinned because
the host will write directly into it, and the API we're using is
virtqueue_add_sgs() (drivers/virtio/virtio_ring.c) which expects a
scatterlist, which I guess must be pages (can't say I'm very familiar
with this particular API either, but the word `folio` doesn't show up in
drivers/virtio)



Since we don't know where the iov comes from, we can't have any
expectation about it, but we can check things and try to act
appropriately (or error out and/or somehow fallback to non-zc if there's
a reason we can't do it).

What would one need to go from an iov_iter to something this could use?

out of curiosity I looked at other "big" virtqueue users (e.g. vhost
scsi must be shuffling similar data around), but I don't quite see how
the buffers are passed, I'd need to spend more time than I can afford immediately...


Thanks (and sorry for pulling the whole arm when you give a hand),
-- 
Dominique
