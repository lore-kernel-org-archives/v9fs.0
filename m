Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E4FC01
	for <v9fs@lists.linux.dev>; Mon, 26 Feb 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915874; cv=none; b=PEPaF9uupnLK1gW5W6LDwkuXlzyGTR9ChgWmwYFk4PSmp3vHpgSBk8ftASiIB8HIGSY7oexFB86rBKSQlDlbGmh6aCc9tWT8ZwyB9IyGwbJ38wqDEGDhq35DsUzELzcmoqEslX7UoUncXlu7D+yCe4+Jc3OincXssDSZop/JuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915874; c=relaxed/simple;
	bh=EnOHlUnDap/4ImmT/XsmmXsgwlD7LDaUp8b6N0konyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0oLp2gZZmxtME0MeeSsdgORbGPiKzmBNrDo2ZFbwD9P7NB6AU99osiFSUM+Lw8vX1INaMSdwahaIuxHm6wGuoktShUryjeflf+TAECQKLU4YBsppRyYs/RKKVPZiltXUIUUDtI8pIJs6NnfyMLl2gnJO/z/awLsKkRuOW3XaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AAVh+6v9; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AAVh+6v9"
Message-ID: <2de0d872-0e05-4fbb-8291-0c60487ccd8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708915871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpE4nKekj14CCL2IymlyiWfeetzm5jT90k6NA0P2Cno=;
	b=AAVh+6v9wFk4dmisJwwBRgraOeOiFyGFIwh+4C65jKf/9TZKgQLn5XY4/xwB26xUcqbPN1
	4/ovo7RE0VJgUzevD2xr/iCFfCJ7SsfeXOhXCqU0ppSAxvNjnXBTTvqfXNGmbMy9pE5apV
	CBQ213bJpXBUrmcJdffyoq6eRcJCAzM=
Date: Mon, 26 Feb 2024 10:51:00 +0800
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] 9p: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224134617.829016-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134617.829016-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:46, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/9p/v9fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 61dbe52bb3a3..281a1ed03a04 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -637,7 +637,7 @@ static int v9fs_init_inode_cache(void)
>  	v9fs_inode_cache = kmem_cache_create("v9fs_inode_cache",
>  					  sizeof(struct v9fs_inode),
>  					  0, (SLAB_RECLAIM_ACCOUNT|
> -					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +					      SLAB_ACCOUNT),
>  					  v9fs_inode_init_once);
>  	if (!v9fs_inode_cache)
>  		return -ENOMEM;
