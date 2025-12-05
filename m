Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2E313E21
	for <v9fs@lists.linux.dev>; Fri,  5 Dec 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942559; cv=none; b=mqO2Lhm1jP9Etx9/HMrVA9MGzDHoLwRJlOOFglIkJVO8Z+qa6BwWhPiEmUIkBJI/e0wllKd/9Mabs1GCrOc5y/3DG4iBRAcmkpc7OphFXnN12JtBWuEAWwPd37Kln9alJ6vVFTb23WJAzgcn+YZHJMdBlhhR2lrhIVzkHR1Fj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942559; c=relaxed/simple;
	bh=V6gTzCSoWu6rTG3TZmh5s3or3M7AG/rXNoj5xQG9Mp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrHPimqlUxw3Qt7qiIpD9AVkZarj5zpNHXy3fQwxG1aInVUqSCPGQHHEt1YSsBHozKFuNW9ZUpSqxD7Xz1UKcYz0KKgu2o1ErqDpYc0zgCo0G5a8k40uMONXNJpTh8RVJaacy7XW5RunO/sSpr7fnvtpXQNXzSfQki2UDfmL7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VoCkZx3P; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VoCkZx3P"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D321014C2D6;
	Fri,  5 Dec 2025 14:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764942554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJVR4LpcDJc6LNHUdhPlErogMTdnQ3sOZNcg9jmD2ag=;
	b=VoCkZx3PIZHSRRNxbsWB/psO0/ImApj5dsgUu1Pd1gyp1/NzBsQQrv9939hA3Lg8u0SKBq
	z4c4zZX9PkdSNiGcl+GQR7I4lFMxDMSEAHA/+68C2wB/RUNMkEldHBZCEt5/aFY6rD4NYx
	0jQNFPB6bBeAdKLfzQJIzPTkjl0hM8qltguZpY/+PBarxjDsVFX49Db1X03vCayIOUXoXH
	MtVKwX0EE8QjgCcNPIs9NHtp+1dGuGsqXEVvLexzCU1mA+3/4dui3sv4w9qAQXe7FjoIBy
	bhr882JbZEg7efgr2OiQntQYYCSynEPz2ZuXx36PaxoCLN5rkRcZ4PKc9Jv+sw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8f6454a6;
	Fri, 5 Dec 2025 13:49:10 +0000 (UTC)
Date: Fri, 5 Dec 2025 22:48:55 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTLix4bcHo_XDXpf@codewreck.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <5945634.DvuYhMxLoT@weasel>
 <aTLYEF4ZaTwF3tdL@codewreck.org>
 <2245723.irdbgypaU6@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2245723.irdbgypaU6@weasel>

Christian Schoenebeck wrote on Fri, Dec 05, 2025 at 02:36:41PM +0100:
> Haven't checked yet, but shouldn't it be like this?
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 0b8086f58ad5..5ff4bfe25a3e 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>         if (!iov_iter_count(data))
>                 return 0;
>  
> -       if (!iov_iter_is_kvec(data)) {
> +       if (iov_iter_is_iovec(data)) {

Hmm, __iov_iter_get_pages_alloc() is supposed to handle any of these:
user_backed_iter() (iter_is_ubuf() || iter_is_iovec()),
iov_iter_is_bvec(),
iov_iter_is_folioq(),
iov_iter_is_xarray()

so it would EFAULT on stuff like is_discard() and is_kvec(), but in our
case (folio) it also depends on what backs the folio, and just the type
of the iov isn't enough to tell

Your patch will appear to work (folioq path won't go there so the page
won't be pinned), but I'm not sure just being a folio is enough of a
guarantee here? for example is a folio coming from page cache
(e.g. readahead) guaranteed to be stable while it is being read? Can
something (try to) kill that thread while the IO is in progress and
reclaim the memory?

-- 
Dominique Martinet | Asmadeus
