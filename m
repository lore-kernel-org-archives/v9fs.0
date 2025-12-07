Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB091EFF80
	for <v9fs@lists.linux.dev>; Sun,  7 Dec 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765115396; cv=none; b=aPsS1Y+gy6MEMZWA0bq59BF0oAIn8X/ezlcSWZZzTygfTxP7zCvXRw/BYK7+2S2keLMnAGk9W1g6fqrfxOGtU8s7H331V3q+0q1D5158X1JLjQ+cey7y6K9LlHOSn6EO87JR56/wWE410nh6JPM9N8UsHqvLJxE0grclpGppGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765115396; c=relaxed/simple;
	bh=XfUxU1e9CTTy6Ytf9Zx6H9YMUbdFQu42ePCQg002UTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt794lx5ua47kA33QpRWM9g3rKyfkxFDcjHbkEBCDx121vmEUAfTsoiFlgZ/jzAhEPyLBLtOiKNLecctyZeYI5bP0lL5v0DMxGNtLobQvYjO/5hsPb1xF7FqOqXeziMv1YS0XKFgiztf5xTPfgvQiaV/pJBqvh8zY75qLsN5eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Cl9pHGbC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Cl9pHGbC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9485B14C2D6;
	Sun,  7 Dec 2025 14:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765115391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CzXPmtUThyvOAk675AjjuHczeRhHVyOOpKEsLxcdhY=;
	b=Cl9pHGbCnNw+eYqH2jAE6TFtx2W6XjZTZyL80NgRpMA5SBa9zrykHfeusF9iIDGEgO1G+M
	p6OZbp2bgtjgv9uBeqwZDgY5bBsu09LDReoABTeT4t8HKNYihV858ATrkiLFcNxgxxl7ju
	ofsH+bPd6613nazVvUSaFyjd8cpEyHxFfLu6XTnDRJJemNzGgrPx45O8Lx1TuZgHJ+H5Og
	7i3JfURFUl0UvXK7V7al/zhk3euVbgC/jG2qGMAJ25kSW8kO+SY2I5or3u2vLJxCSL5ALe
	esltttMYz3a5RvZjicGXSeh9O6ECLZaAEzTIzGpkdsYOlmgL1i9zYPXtVspoVg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8cbb36e9;
	Sun, 7 Dec 2025 13:49:46 +0000 (UTC)
Date: Sun, 7 Dec 2025 22:49:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Chris Arges <carges@cloudflare.com>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTWF6xnCe1sSA8gQ@codewreck.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <5945634.DvuYhMxLoT@weasel>
 <aTLYEF4ZaTwF3tdL@codewreck.org>
 <2245723.irdbgypaU6@weasel>
 <aTLix4bcHo_XDXpf@codewreck.org>
 <aTUqKudyHxilbBpL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTUqKudyHxilbBpL@casper.infradead.org>

Chris,

I'm not sure why but I can't reproduce with your .config either :/
If you can still reproduce this reliably, could you try with the
following diff applied (which is basically the same as what Christian
suggested a couple of days ago with also ubuf, whatever that is)
------------
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 10c2dd486438..f7ee1f864b03 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (!iov_iter_is_kvec(data)) {
+	if (user_backed_iter(data)) {
 		int n;
 		/*
 		* We allow only p9_max_pages pinned. We wait for the
-----------



Willy,

Matthew Wilcox wrote on Sun, Dec 07, 2025 at 07:18:02AM +0000:
> In readahead, we allocate a folio, lock it and add it to the page cache.
> We then submit it to the filesystem for read.  It cannot be truncated
> from the page cache until the filesystem unlocks it (generally by calling
> folio_end_read() but some filesystems explicitly call folio_unlock()
> instead).  So you don't need to take an extra reference to it.

Thanks.

My main problem with this all is that trans_virtio adds the buffers to
the virtio virtqueue but does nothing to take it off if
wait_event_killable() in virtio_request() gets killed, but looking at it
even in the code path that gets a ref the code will happily drop the ref
even before the flush is over so I guess there's no reason to actively
try to pin kernel pages...

I'd sleep better if there was a way to remove (detach?) the buffer from
the virtqueue but I can't see how to do that without breaking something
else, so I guess we'll have to live with that behavior unless someone
knows better.

-- 
Dominique Martinet | Asmadeus
