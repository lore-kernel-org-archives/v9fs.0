Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACC20459A;
	Tue,  9 Dec 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273947; cv=none; b=gpUpA4EiFpPmslTSyPgdoDU0+DZgMfjULhFuyDXJgzdjmED/gUU/FEI+KUDOKdQO/Czc8KdVfe428SDmVMupVfI9TgxM3r6hNS9MtcwLrgg385WkoFnzjyqKqYu2yxLeh2w4rqOVakBhBCkSnT+V4t+0ivOJNdaCMGdAnK0F3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273947; c=relaxed/simple;
	bh=xAFLO1v85EXKJ1xaV6ZxU6twOLlWcvarQ3Y8SGRYMBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qE7kGXSf+xHDaH3gxRwfCRBOtM9OlGirROmpA7PeHh8rIAZX1d9/H3tv7CKOyink8+d5vkQVxAaUVMXZKka3jdlfW+5shCrEWZbapiJB0P8jcmh2ntaEUO9G3/4KAPvEaKDpVmNl7BLoeJgb7yDRGwNoLhOoROIspBrWiit2c2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=tXhFNI+N; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="tXhFNI+N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=gGnLs3g+nQLmBRL67FKt3OfTd3fl8VjkQA3HI9JWqy8=; b=tXhFNI+NyV4VOt+/VtpnjXKIVx
	WMibHj/XgnTcDEbaeJNCx3JLSvi6dUCi0LosgpdSwhMnbkZkOpeCo5tZ+lHUZUzzl9tU4ZwR+hPBg
	TdVqMQ2BMKBFUjcg9vWfKiKhNNpZg1eJa8Uk4zsUDZTWkjJ4WVD2ouFMj+quyjOePo+3MbXu3f2lH
	3cf9tXVjOO8aDVyUkRUtZRVnzJ7hkPUEqmXrQT0xOie9PgXfH4zcb+BcB6/R+spALaPq1QNinAwqI
	wcPIkqXeGla5s6ZPQVWifCX4fFryoo25qk4fphBMKaWBfCfRcx0RiFZwYdId1TQ9W+hi2cWw3MdKD
	GzC19PMAmSDdb/4564/pXATjjeDgY/afcP+kT0cTUomRVfl5/e3M1oJC/vmYINyOu1vi0vq2aSveJ
	gnuFXTK2rosyRyvwiJvJJpKitbZ0E0cMGPmz4ghJGecDQhQ3Nd9HFIaHj3jcrV1YOa988K+MwVnBG
	QP083vUzZL15rKPTdxmygzf2m4+J+qslWTau7CowMCVJJcDoDHiPzZUdCYsCTGcnRN4yh9/hAVJXW
	c52iOURHmEX4c/3BR9Y+fKMlAoYlFZPEUXey06FQJeuSsawOqCRJ8OAsjltduwLL966LzPorAGfl1
	BquxQEb3gAL43uTkKRK6cilgwBU55nbPVkSdmEnlw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Chris Arges <carges@cloudflare.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject:
 Re: kernel BUG when mounting large block xfs backed by 9p (folio ref count
 bug)
Date: Tue, 09 Dec 2025 10:52:08 +0100
Message-ID: <5032423.GXAFRqVoOG@weasel>
In-Reply-To: <aTWF6xnCe1sSA8gQ@codewreck.org>
References:
 <aSR-C4ahmNRoUV58@861G6M3> <aTUqKudyHxilbBpL@casper.infradead.org>
 <aTWF6xnCe1sSA8gQ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 7 December 2025 14:49:31 CET Dominique Martinet wrote:
> Chris,
> 
> I'm not sure why but I can't reproduce with your .config either :/
> If you can still reproduce this reliably, could you try with the
> following diff applied (which is basically the same as what Christian
> suggested a couple of days ago with also ubuf, whatever that is)
> ------------
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 10c2dd486438..f7ee1f864b03 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
> if (!iov_iter_count(data))
>  		return 0;
> 
> -	if (!iov_iter_is_kvec(data)) {
> +	if (user_backed_iter(data)) {
>  		int n;
>  		/*
>  		* We allow only p9_max_pages pinned. We wait for the
> -----------

Right, that's clearly better than what I suggested. Feel free to add:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Honestly I think those iov_iter functions and/or iter_type enums deserve some 
API doc comments. At least I don't find it self explanatory what the 
differences between the individual iterator types are.

/Christian

> Willy,
> 
> Matthew Wilcox wrote on Sun, Dec 07, 2025 at 07:18:02AM +0000:
> > In readahead, we allocate a folio, lock it and add it to the page cache.
> > We then submit it to the filesystem for read.  It cannot be truncated
> > from the page cache until the filesystem unlocks it (generally by calling
> > folio_end_read() but some filesystems explicitly call folio_unlock()
> > instead).  So you don't need to take an extra reference to it.
> 
> Thanks.
> 
> My main problem with this all is that trans_virtio adds the buffers to
> the virtio virtqueue but does nothing to take it off if
> wait_event_killable() in virtio_request() gets killed, but looking at it
> even in the code path that gets a ref the code will happily drop the ref
> even before the flush is over so I guess there's no reason to actively
> try to pin kernel pages...
> 
> I'd sleep better if there was a way to remove (detach?) the buffer from
> the virtqueue but I can't see how to do that without breaking something
> else, so I guess we'll have to live with that behavior unless someone
> knows better.


