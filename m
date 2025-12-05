Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788633E355
	for <v9fs@lists.linux.dev>; Fri,  5 Dec 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939819; cv=none; b=oPOWntA9+jPyoxwZhY7pLqe9Dfwz56Wn1GtDlY1wIzSDlOknCdxlFoGSe7+nMRwfp7xCBu+1riOjgiu+4POvPKzOvXDzrYWGBEhh3IqJ4GMBlt1sfCnSxZyYj8ZzH9LItdrIKkOcJK48m7/tV5TwtWYF+5+3XV+FZwGzNLptGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939819; c=relaxed/simple;
	bh=XtuWdz8AHuFkQx1/GXeHM6qh27DbdwcY9adlxXdyGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smdW1hLsxdGUgXta2bMDAS+HJG6utJqCxQ8a7OPY2AH+tF4KXI+4316g71hp/Nc+LYU5rsYMmYbe0ILJrtxrmI5zLCA2zUF8rm9Nzqn4l/S4ACB2s+cx1rkOCVQSirxtKcYWXpc7jL50BBt55VC1zTVN8hvQh4ImOYfoqU4N5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=gStmT76y; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="gStmT76y"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0DE1314C2D6;
	Fri,  5 Dec 2025 14:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764939811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUNVS0bls4aKtIYkswtFnDfA4LZUtSduPNksf9xgN7c=;
	b=gStmT76yQzNqHO05tyVvcERDCuE1QR4zX8QSV0msqXAfp2/tKBFOOyoZcQiVlDgVpxqYE4
	j3cWfD26jH+OgThJhiY89ajcu/NWQnnB4kCf7Iu3Htv1xSstoOO+0rezj0+HWq45uroKg/
	hJ3ZhfFT/q2te1c2wbRos3dIkMJF4010DB6YuAZRPIPE6iJdmPmmINDOWgJJ6rqphNrY9Z
	LC9i/DPz1qNLRhOlCjJvEG01eED2ERT9noD1gDrVST378vb0/YFAteFihzu3gVLJps4NNT
	QrRz1TvCYGeI5VJ3Pp6tgs9lt3S2xjxN2fnFI5TOpRCxzuTRF42R7fWu/E9pVQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 980155cd;
	Fri, 5 Dec 2025 13:03:27 +0000 (UTC)
Date: Fri, 5 Dec 2025 22:03:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTLYEF4ZaTwF3tdL@codewreck.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <aSTmUTOIm4hnU7aw@codewreck.org>
 <aSTwj8LfyFvAXEqc@casper.infradead.org>
 <5945634.DvuYhMxLoT@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5945634.DvuYhMxLoT@weasel>

Christian Schoenebeck wrote on Fri, Dec 05, 2025 at 11:47:10AM +0100:
> > Oh, hang on.  You're passing a kmalloc'ed page to
> > iov_iter_get_pages_alloc().  That's not allowed ...
> > 
> > see
> > https://lore.kernel.org/all/20250310142750.1209192-1-willy@infradead.org/
> 
> I'm confused. Looking at p9_get_mapped_pages(), iov_iter_get_pages_alloc2() is 
> only called for user space iovec data, isn't it?

I think that doesn't hold true when mounting a filesystem with -o
loop -- afaiu the kernel issues IOs to 9p from the XFS subsystem, so
these can come from kmalloc or whatever it is they get memory with.


As to what to do with this, given Willy's last reply (thanks!), I'm
honestly still not sure... If we can detect the pages are coming from
somewhere we don't like I guess we can return EIO instead as a stop-gap
measure (better than a crash)?
If we check early enough (in client.c generic code) perhaps we could
route these to the non-zc path that doesn't require this, so let's start
by trying to figure out how to check what kind of page we got...?

-- 
Dominique Martinet | Asmadeus
