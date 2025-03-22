Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B03522A
	for <v9fs@lists.linux.dev>; Sat, 22 Mar 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678803; cv=none; b=PlHiVyg8yaJvABjFHjRyPIFrg5HEnZJJiQLH0Af8/4p21NX7R77n/fsLGUMBKgfWZnHWJ5v2i00ydRNHmZinaqj3Bo/36uWAw0nHNjgYGWt9cw8xjeSQKbvUBBSBrlAdB7IrUMI27NPYzElmgro6/5gWgIG431/kVAmZKBvFUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678803; c=relaxed/simple;
	bh=aJKrk8AhFU5inmvC5FMnFgltEpcRhKTMhWxISXywHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIdEw5Av8JZAUvyBViwY0DwolgTmV5LCmq0aXOCW60QcCxdyCTuW70JaORbrVx3XoyNNgZh/3M9C/EMzFeJtIFP/eAUetLRCchTNSQ22JcRWfojSwITY6NuSs7jfS1qWe0GGdat08JI8VYs15Ad59P6/3JvTohKBqF7C01QbzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sxlAqcxb; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sxlAqcxb"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A920214C2DB;
	Sat, 22 Mar 2025 22:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742678799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlQXDT9qjPMuCQRb2y5j+QqB42E7sudAvA1QZKSwl8U=;
	b=sxlAqcxbFegzN+9/JA3Mq4pLML+DTcOv4PDeAh8rfbDiwM0e6B0ULM3xOyLhY//CwgEVTU
	8+ph1HJqs5NsACoSbYCA1Ct/oabash214Ghlb6+GO0aARvLAlNm5PGmN452+u6rtQOegHf
	6CaumImpLCQqgPPP709YExp4o4V5ir/T1rAxHBwJH0wEC16mjW/m/a8WlLrPg35OHJYS7I
	TPTdx1RlYVEtb6RM+I7eEybFlxD1cnfYG4GZUzcbygFObFB6aB6IqIiVi7+WDUNQgtqOuk
	mTPzXo3h3/O5Bkp2gK6um0NJN3pcED3f5YUe+n/biVStLKdyi5Zv9vkZDMDBJg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 00e7e8d0;
	Sat, 22 Mar 2025 21:26:35 +0000 (UTC)
Date: Sun, 23 Mar 2025 06:26:20 +0900
From: asmadeus@codewreck.org
To: Sasha Levin <sashal@kernel.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use hashtable.h for hash_errmap
Message-ID: <Z98q_K71xueitBeB@codewreck.org>
References: <20250320145200.3124863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320145200.3124863-1-sashal@kernel.org>

Sasha Levin wrote on Thu, Mar 20, 2025 at 10:52:00AM -0400:
> Convert hash_errmap in error.c to use the generic hashtable
> implementation from hashtable.h instead of the manual hlist_head array
> implementation.
> 
> This simplifies the code and makes it more maintainable by using the
> standard hashtable API and removes the need for manual hash table
> management.

I'm not entierly convinced this is simpler from my little island (that's
one more API to learn about vs code that doesn't look all that
different), but I guess I can see the point from an overall perspective.

I see no problem with this, I'll pick it up for -next
Note this code is not used for 9p2000l iirc so I currently don't have
any test for it :/
(but it's simple enough that I'm willing to take the risk)

Thanks,
Dominique
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/9p/error.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/net/9p/error.c b/net/9p/error.c
> index 8da744494b683..8ba8afc91482d 100644
> --- a/net/9p/error.c
> +++ b/net/9p/error.c
> @@ -16,6 +16,7 @@
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/errno.h>
> +#include <linux/hashtable.h>
>  #include <net/9p/9p.h>
>  
>  /**
> @@ -33,8 +34,8 @@ struct errormap {
>  	struct hlist_node list;
>  };
>  
> -#define ERRHASHSZ		32
> -static struct hlist_head hash_errmap[ERRHASHSZ];
> +#define ERRHASH_BITS 5
> +static DEFINE_HASHTABLE(hash_errmap, ERRHASH_BITS);
>  
>  /* FixMe - reduce to a reasonable size */
>  static struct errormap errmap[] = {
> @@ -176,18 +177,14 @@ static struct errormap errmap[] = {
>  int p9_error_init(void)
>  {
>  	struct errormap *c;
> -	int bucket;
> -
> -	/* initialize hash table */
> -	for (bucket = 0; bucket < ERRHASHSZ; bucket++)
> -		INIT_HLIST_HEAD(&hash_errmap[bucket]);
> +	u32 hash;
>  
>  	/* load initial error map into hash table */
>  	for (c = errmap; c->name; c++) {
>  		c->namelen = strlen(c->name);
> -		bucket = jhash(c->name, c->namelen, 0) % ERRHASHSZ;
> +		hash = jhash(c->name, c->namelen, 0);
>  		INIT_HLIST_NODE(&c->list);
> -		hlist_add_head(&c->list, &hash_errmap[bucket]);
> +		hash_add(hash_errmap, &c->list, hash);
>  	}
>  
>  	return 1;
> @@ -205,12 +202,12 @@ int p9_errstr2errno(char *errstr, int len)
>  {
>  	int errno;
>  	struct errormap *c;
> -	int bucket;
> +	u32 hash;
>  
>  	errno = 0;
>  	c = NULL;
> -	bucket = jhash(errstr, len, 0) % ERRHASHSZ;
> -	hlist_for_each_entry(c, &hash_errmap[bucket], list) {
> +	hash = jhash(errstr, len, 0);
> +	hash_for_each_possible(hash_errmap, c, list, hash) {
>  		if (c->namelen == len && !memcmp(c->name, errstr, len)) {
>  			errno = c->val;
>  			break;

-- 
Dominique Martinet | Asmadeus
