Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F252C21CD;
	Fri,  5 Dec 2025 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764910424; cv=none; b=bNUsHEeW8XxT8CRjTUJOZvmeh01wpTKtEOvdek5yAhISCu6DjaSOegvkbtfoqcag6wqr/CHwD32b981EPNZ+cgczhuBa1M4jCW+Sc7yIDGOP549Vmj4lidArP8h6Efwp4fIfi/gVROh18QRbhXPVWfCw8ET+yTN92dYVmCPBzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764910424; c=relaxed/simple;
	bh=pq+AEgqcmcZzIlHiZLgSbQEf+bcGFbdzWjFMtCkW4SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpRb/kha45fmwXnh+Ueem4LVP2AQ5KoOQWnGpVxuOUHrZoFE+EGXF660fNjcXm1OczjZZSG5CaL/qH7Cfirl8wblk4W5gHn+vhgSRICx+nfVgtFAu1dmDOOHH+4uCzsy3JCdkd2oXMLfLh+zv2qwPYvzDsT7Fgczj7TVT8S1ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vANoP5fn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vANoP5fn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JBvQZHKG+upUXS3RG4SHwW7rAtZm+dnNwPqqEoHXvaE=; b=vANoP5fnbqOA9xrWOZnSaFcu1Z
	su2Zx9WnJjUMSFtmGjCrbuc30jrsfyKO9fdm4FbQuTxlh1cwV1UqMaRty6PPlgGGeteTh9va5D2gu
	zRIKmEwBAAAad+SyWrC3UiJD83Cs0VjR5arLk7FoR/tjit1NxrXe9CRgZd2Fu53t7d/U166HtGezK
	pWxypUTpvSMSWIVt+lmekjTsXBNuYASIraL3uoCjPWvi3ixLjZK3LvvhZ+h2j1bvSgAUQi3jTSwdg
	CL6ly8hNIQFPLae8gz828HwltBEoxR7ZH4ekfgyHJlvGiIgVdZa8LN7rxUB8WUk7DPb/FALDoqwUg
	zEtbYKTg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRNox-00000005Axw-1gzd;
	Fri, 05 Dec 2025 04:53:31 +0000
Date: Fri, 5 Dec 2025 04:53:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	David Howells <dhowells@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTJlS_oFL_uiEoTw@casper.infradead.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <aSTmUTOIm4hnU7aw@codewreck.org>
 <aSTwj8LfyFvAXEqc@casper.infradead.org>
 <aSVw0M8f3vTXdQxH@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSVw0M8f3vTXdQxH@codewreck.org>

On Tue, Nov 25, 2025 at 06:03:12PM +0900, Dominique Martinet wrote:
> I'm sorry but I'm not sure I see what I should do from this -- your
> patch looks to me like it should now work with this?
> Oh, it's not merged?... I don't see where the discussion stalled
> either...
> 
> For context, in this case virtio needs the pages to be pinned because
> the host will write directly into it, and the API we're using is
> virtqueue_add_sgs() (drivers/virtio/virtio_ring.c) which expects a
> scatterlist, which I guess must be pages (can't say I'm very familiar
> with this particular API either, but the word `folio` doesn't show up in
> drivers/virtio)

I was hoping Dave Howells would chime in, but since he hasn't ...

The root problem is that iov_iter_get_pages_alloc() takes a reference
on the page.  It thinks this will prevent the memory from being fredd
under it.  That's not true with slab allocations; the slab won't get
freed back to the page allocator, but the original memory can be kfreed
and reallocated to another kmalloc.  So at best this is a useless
bumping of the refcount, and at worst it'll corrupt the data of some
unsuspecting user.

So we delberately broke this usage.  You can't pass slab allocated memory
to iov_iter_get_pages_alloc() any more.  And then we decided to break
the "large kmalloc" case too.  It's an implementation detail whether a
kmalloc comes from slab or not, and we might change things in the future
such that allocations which are currently deemed too large to come from
a slab now come from a slab instead.

I don't really have concrete advice for you what you should be doing
to fix this.  We should never have allowed this to work, but I'm
insufficiently familiar with the iov_iter APIs to tell you what you
should be doing instead.  Hence my hope that Dave Howells would ride
to the rescue.

But this isn't anything to do with folios, at least not directly.
It's a spinoff of the folio project.

> Since we don't know where the iov comes from, we can't have any
> expectation about it, but we can check things and try to act
> appropriately (or error out and/or somehow fallback to non-zc if there's
> a reason we can't do it).
> 
> What would one need to go from an iov_iter to something this could use?
> 
> out of curiosity I looked at other "big" virtqueue users (e.g. vhost
> scsi must be shuffling similar data around), but I don't quite see how
> the buffers are passed, I'd need to spend more time than I can afford immediately...
> 
> 
> Thanks (and sorry for pulling the whole arm when you give a hand),
> -- 
> Dominique
