Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA531960B;
	Thu, 25 Dec 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658216; cv=none; b=R2D4rB7BY4RE20IeKyEgEJsdkHFd/xp+V2EdZaZupLYhWLmUTex2uCuyqceDwn7DIj/FfzcJtV1gnwWIJhYmyLKPfGtyARK6S2WkOyWZiiXUWE7GFNALhdz2vKXHpy8fhA8dJghxJZXLto/otiDpXP92LnuKd3uKCfe7E6oNMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658216; c=relaxed/simple;
	bh=MJ83WW3G/AIWSiccrXO9Wwg1mh53kCDLajnyPeGaZmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDBYUIMG8+Nb9COsp9b4HfiPU/9m1B5hoAfmM9dLhwPG3qWLC4woHxv9LkU2KP6Sc9SfFxXW9GXx67qcxEAAvdf6LKo/mW6IkLRjMRLcr+cFRBO80Q5rEr+IwuTn2vDcftEX2IuLi2rPoV7SngDnZhFuHRNojdWTOGHAixtbOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=WIoKWb0s; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WIoKWb0s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=dkOBV/QLD/S6CALGp8pJJbwkbLe3YXSW9rEFM2e5BCM=; b=WIoKWb0s+vMY25LcvVZcxC+j3X
	h9bgl3F/Pua0LZAvkTTPbYVgbMkMAj9rFV92vWE4ZI54SmIu+0LhDANjyBvj64t7PbyTemYjPvzcW
	DDyRvSKzgAjCz9OkVV5yLADyiXTbwKdDDveoECnZ5k7fWEI1ed/CoPOufZT9BrnElKnmVo3urxYWq
	bnaFeFis7oREWQQ/Ec8PYgYbn3ls2ulZ+Py3H/34TNHNx6FZqqN0Dj5wOK/ND7EvXAX/amOXh/3g1
	/K5evIrLbAKIOkrikbDMiB2ODeu7aCRgmmxBDA2RC0FmccZ5JG6iOisyGzvoMHs7xYUEDs7sS6uZE
	TAFvELx9AGC9/QR149aAwQ9HhK1hdmPsW6/Yji1haKwIR1l7YRLlADBDGf+jtj/jpburMrl1WKs4m
	D2dXKTXfXV65PUpe4jP8f7VpGNoy7aR0DNPfhDDvyziw9mCLG8zQ5Qcvbg2FnTGOqm2nxn4pW4vjA
	xrg/ZZ4sEjQO3zjU2NtbeoXpgBt39AD5ZfevtoG2WGcM9s+QzjnnEb3I9ETYFbxFlO8iuIx3ZeeMb
	XuGv43As7KWgeWXgPrCp7A0KQFwJcf/+1uRxmaZL0mBh3/7wpHtE7h8eW5oZlKStOnDq6WvQNf2KL
	EED7FmSSPNXKT8bTbaMo8nzvYhE55T1masN9GwBtw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Pierre Barre <pierre@barre.sh>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject:
 Re: [BUG] 9p: data corruption with cache=mmap under concurrent stat/write
Date: Thu, 25 Dec 2025 11:23:20 +0100
Message-ID: <5951517.DvuYhMxLoT@weasel>
In-Reply-To: <aUxqVn0DO7ee9K2_@codewreck.org>
References:
 <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>
 <aUxqVn0DO7ee9K2_@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 24 December 2025 23:33:58 CET Dominique Martinet wrote:
> Hi Pierre,
> 
> Pierre Barre wrote on Wed, Dec 24, 2025 at 03:29:01PM +0100:
> > I'm hitting data corruption using 9p with cache=mmap when stat() is called
> > concurrently with writes.
> Thanks for the report
> 
> > Environment:
> > - Kernel: v6.18.1-061801
> > - Mount options: cache=mmap
> > - Transport: unix
> > 
> > Reproducer:
> > 1. Mount 9p filesystem with cache=mmap
> > 2. Run PostgreSQL with data directory on 9p mount
> > 3. Run pgbench workload
> > 4. Simultaneously run `watch -n 0.1 tree -ah` on the data directory
> > 
> > PostgreSQL reports:
> >   ERROR: unexpected data beyond EOF in block N of relation "..."
> 
> unexpected data beyond EOF looks a lot like
> https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk
> 
> could you try with this patch?

Pierre, I am also confident that this patch will fix the EOF data issue you 
encountered with PostgreSQL. However ...

> >   HINT: This has been seen to occur with buggy kernels
> > 
> > Analysis:
> > 
> > The issue appears to be race conditions in getattr/setattr when using
> > writeback caching:
> > 
> > 1. v9fs_vfs_getattr_dotl() condition checks `v9ses->cache` instead of
> > 
> >    `v9ses->cache & CACHE_WRITEBACK`, triggering writeback flush for
> >    any cache mode
> > 
> > 2. Both getattr and setattr call filemap_fdatawrite() which initiates
> > 
> >    writeback but doesn't wait for completion. The subsequent server
> >    stat/wstat sees stale file size.
> > 
> > Would using filemap_write_and_wait() instead be the correct fix?

... you are seeing a 2nd issue? getattr() output should not be related to 
mmap() access.

/Christian


