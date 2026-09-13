Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857843A5E78
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306705; cv=none; b=iahhCjX5EZdXgmbZUDf7U3nqkauVPjZLaEt93wB5DSgtQwT05drXDRIR4BjU8TXS0WtomXPzIdybCKm4RD/7g1KA3ruIjFQLh12v9GejpNc1ac2TQd/pkpL72+kzxNhC/Eba9DgOJ0IcZFPy+SmDOymzmLIRhua0zVlnx+zW5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306705; c=relaxed/simple;
	bh=7ZBT2cGyuqF/+/+IrvpgsirKZKaT1cm5/j5Qqq8yTFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiMCUZp9y/5Y9aK8dJFLL8hSSXjbynjXUsUCyT9fuW/yzpm+49Q05lBWxW0Wgyznew6VqWUpL8+Br6rfQD1Q5azfeW9vM6/Nc7YlmfFMWsuwMtN3iAlYtDh7TjLO9bQIELpL1A0wgQRnVTXuo35W2wp9+usfHnud4QaXQXfOQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=XCBAfaKq; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XCBAfaKq"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0D8E414C2D6;
	Sun, 13 Sep 2026 15:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789306702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbT07zL1x0N9eTKPXC3jRV0HLLO7PhJrQDpD3mTYzI8=;
	b=XCBAfaKqhtUzGyj7eEfjFqfYWq2k35jwIIWjTQePeh7E3IcpRJcgVQ450bjEZC4d1wd3uY
	hSqUCV84Td+F0SvXcEAk6FSbspQkGDjJ6q2e7VKoPxwBWyJV1Gvjg5ZkI72YkSt2mbI1IA
	fAkZvOqSB9dSW+ickD50sO1/txGzFjXBX632UA1GIklw354mtVLY1RvfEwXXByBGcW04sf
	yq2prsWmTbeEXP9ju+Az8Z4u4Ll4oTIH2NC62UUQ5GpxdthbptTdN6A5pewVftRkwHU/4e
	5hPpbH1CdqKuR43jmk14c2aX5irTCasiLFtcV08oiANtoP33XjxGeOmv2Fs+zQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 32ce9d39;
	Sun, 13 Sep 2026 13:38:19 +0000 (UTC)
Date: Sun, 13 Sep 2026 22:38:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] 9p: simplify v9fs_cache_session_get_cookie()
Message-ID: <aqanPLWK-hjvPrhK@codewreck.org>
References: <20260814040826.1213127-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814040826.1213127-1-dmantipov@yandex.ru>

Dmitry Antipov wrote on Fri, Aug 14, 2026 at 07:08:26AM +0300:
> Use the convenient 'strreplace()' to simplify
> 'v9fs_cache_session_get_cookie()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/9p/cache.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index 12c0ae29f185..cb0e5b61e131 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -20,18 +20,15 @@ int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
>  				  const char *dev_name)
>  {
>  	struct fscache_volume *vcookie;
> -	char *name, *p;
> +	char *name;
>  
>  	name = kasprintf(GFP_KERNEL, "9p,%s,%s",
>  			 dev_name, v9ses->cachetag ?: v9ses->aname);
>  	if (!name)
>  		return -ENOMEM;
>  
> -	for (p = name; *p; p++)
> -		if (*p == '/')
> -			*p = ';';
> -
> -	vcookie = fscache_acquire_volume(name, NULL, NULL, 0);
> +	vcookie = fscache_acquire_volume(strreplace(name, '/', ';'),
> +					 NULL, NULL, 0);

Thanks
I find it more readable to split the two e.g. keep the replace separate
from the fscache call:
+	strreplace(name, '/', ';');
+	vcookie = fscache_acquire_volume(name, NULL, NULL, 0);

(this is fine because strreplace does a replace in place as well as
returning the string)

If you're ok with this I'll change in place, this doesn't need a v2

>  	p9_debug(P9_DEBUG_FSC, "session %p get volume %p (%s)\n",
>  		 v9ses, vcookie, name);
>  	if (IS_ERR(vcookie)) {

-- 
Dominique Martinet | Asmadeus
