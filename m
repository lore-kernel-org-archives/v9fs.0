Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1C143754;
	Thu, 16 May 2024 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853654; cv=none; b=Ai/VUEeWgW/jFXrBX0nlij+1tMERbCJZgobuVc5ja/IcPbr+S2RvDHHMslZMoRA7aZh/skP0p8Va0OHNfS+EiJRi1ETiAjr4bAvfir+symEoQtt8fEPf2Yb3qOeTMeqD5gqFCJN8D24oBqOED1C6JKqYQPCMOYBSBpT+lDKo6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853654; c=relaxed/simple;
	bh=8HXogCTpnJ/n4MmOkUeaDBlbudv84EkCG4VMtstjvmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8S20Fn9c1gf09D4mGQQdH6egXhJW7TbtLxq8sXABnZ7YNyr5KFfnvZ9Sh1W4C/3LRLKCxVhgNZgmzM5UTIT3XGq3Nwn1p/WafRwYJFhQZ2XW4a4TnP1Gd85gtKi1IMlhmTvmSsTPN7x4rus7RFrBgxo86y9OH2isoKbTRQ3ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=jf2ezs57; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jf2ezs57"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ZOdg+UxEX0UYoNsiLotMQ5sr/A6Ve75FAxdqq6STPCI=; b=jf2ezs57UCUKXx/sircGT0LdPB
	xPAGh1Cdn6buWBed/Gmq53llWqOrzXwr6YpwqUJmZe8piJKAsd83YaiLwYX3Kk0onUrRGPqAqi/PC
	RemYT6EInkg2heGsesVl2IYqK4++yNSRn1tDlq4PWnH8gjU2oxxOfkJx8cOetphZquu7H9anMmmRN
	S3hpMj1iO3OTNJO7rr1VEFT7UOVo2C00Ww/K+gUe4tm5I3dfUaYSJkwg1YzUpaDcgvy6Kuxi7j1gF
	erYjMVTKXn0T2+4pyYUW7gux2ILIinifaVkkOlz0Hwb79AECJfcKXmWBvg2W9Lq29bxmQpSZJ5Nrd
	waUVEVDI2EC+jGF8N4vqqGLt5eWYJwOCacPF0uoG75HDzqY+uSOIFsJHS333CKGIOCpyz2EzbCGpU
	oFdTjg4g2TSFsqda74wgDgF+DoYStG9b27WokFpXNKRgnjwKwf3XAfmSOEj6eQ0vhD48GCwSJNuXP
	jZA04DmieDSfXMoYf5uLxoyVJ3LTOzW+vqta1qQCiVuUU+s7riCBxF4mzZBo/ShuMmX3oGFi46RqZ
	ewzVO7F4Hui3Lq7iEDlDEZIbmO03oP92bnjPNVclpqryqdOANJpwiLmfOgwJ8HdpK/xR/ETXdt+dN
	MNNh0XWEh6Dv4UTUzKQSjZOX4V2T96hP557JuU2FI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net/9p: fix uninit-value in p9_client_rpc()
Date: Thu, 16 May 2024 11:27:21 +0200
Message-ID: <1731146.XZuUqIVtO3@silver>
In-Reply-To: <20240408141039.30428-1-n.zhandarovich@fintech.ru>
References: <20240408141039.30428-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, April 8, 2024 4:10:39 PM CEST Nikita Zhandarovich wrote:
> Syzbot with the help of KMSAN reported the following error:
> 
> BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
> BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
>  trace_9p_client_res include/trace/events/9p.h:146 [inline]
>  p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
>  p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
>  v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
>  v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
>  vfs_get_tree+0xa7/0x570 fs/super.c:1797
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page mm/slub.c:2175 [inline]
>  allocate_slab mm/slub.c:2338 [inline]
>  new_slab+0x2de/0x1400 mm/slub.c:2391
>  ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
>  __slab_alloc mm/slub.c:3610 [inline]
>  __slab_alloc_node mm/slub.c:3663 [inline]
>  slab_alloc_node mm/slub.c:3835 [inline]
>  kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
>  p9_tag_alloc net/9p/client.c:278 [inline]
>  p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
>  p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
>  p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
>  v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
>  v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
>  vfs_get_tree+0xa7/0x570 fs/super.c:1797
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> If p9_check_errors() fails early in p9_client_rpc(), req->rc.tag
> will not be properly initialized. However, trace_9p_client_res()
> ends up trying to print it out anyway before p9_client_rpc()
> finishes.
> 
> Fix this issue by assigning default values to p9_fcall fields
> such as 'tag' and (just in case KMSAN unearths something new) 'id'
> during the tag allocation stage.
> 
> Reported-and-tested-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
> Fixes: 348b59012e5c ("net/9p: Convert net/9p protocol dumps to tracepoints")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v2: change fc->tag init value from 0 to P9_NOTAG per Dominique
> Martinet's <asmadeus@codewreck.org> helpful suggestion.
> Link: https://lore.kernel.org/all/ZhNVMivKCCq6wir0@codewreck.org/
> 
>  net/9p/client.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> diff --git a/net/9p/client.c b/net/9p/client.c
> index f7e90b4769bb..b05f73c291b4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -235,6 +235,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
>  	if (!fc->sdata)
>  		return -ENOMEM;
>  	fc->capacity = alloc_msize;
> +	fc->id = 0;
> +	fc->tag = P9_NOTAG;
>  	return 0;
>  }
>  
> 


