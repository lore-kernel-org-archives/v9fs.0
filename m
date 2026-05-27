Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11562192FA
	for <v9fs@lists.linux.dev>; Wed, 27 May 2026 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853962; cv=none; b=ig9880fdWbZMfEP2dkkofo2BuxqDTNe9VH+LS6eal/FW0DjEUGiK8XS6OMzQ61gy5KJB83vZAfmJxJ819gu14JGBmGqChtqiaj0iPdksskuMbw00r26z8zK6ElJ7iQ9QVeDVASxl5aECRpVak2GTm2edohiDV0M//tjR4ejcF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853962; c=relaxed/simple;
	bh=9gW4Nrbx8q4f3A8f53Oqo5tJzgpCfdhhQZNGYCbnAxQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=Yr973+h3qdkOshrahHnw9ALHCQ9AuZ7+SjEvL4LI6pUEpPd7+C0Zcy9Tj7fFUhhj1G6E8qPaMBzcydg4jWz2tQI9qqJRWhaiALouEUyDPfHms79veEocbXqZMb5BkCJ+0uC41ZzExHn/h1ffN+q1FRcuRVbTHuG0zk9izBCx7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TdGPkrZa; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TdGPkrZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=mrddDPNXewI1iOMWZr30hnnkthZVV2Z2aJnbUpYV5XA=;
	b=TdGPkrZazQl1ZzMkExM2PMHgffUHy/jc0AqTb/bJLktQwYuFEeA/UClumk+hj+
	5+TPQ1Ieh8vgj3WaVai9gCApY1qgl6VLI4d8AiTv7iFvgkrgjlzlEaivcMG5zW/k
	VSHmSIkZzG1J0ftkj23avrmDyLdDE6ZLWnXEDCOI4zhyg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXH+tdahZq6mVXAQ--.31431S2;
	Wed, 27 May 2026 11:51:58 +0800 (CST)
Message-ID: <6A166A62.6030802@126.com>
Date: Wed, 27 May 2026 11:52:02 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
 linux_oss@crudebyte.com, David Laight <david.laight.linux@gmail.com>
CC: Hongling Zeng <zenghongling@kylinos.cn>, v9fs@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: avoid returning ERR_PTR(0) from mkdir operations
References: <20260520022650.14217-1-zenghongling@kylinos.cn>
In-Reply-To: <20260520022650.14217-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH+tdahZq6mVXAQ--.31431S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1ftFyUKF4rAF1rJr1DJrb_yoW5tr1xpa
	n8Kr1vya98XryxWF4xGF4qvw1SqFW3KrW7Wr1fKw1vv3ZxXw1DKF18Kw1Yy3WrGrW8W3ya
	qF409w1rur4akrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5miiUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoB7RomoWal4s+wAA3S

   Hi David,

   Gentle ping for review on this patch v2. Since you originally suggested
   this approach, I wanted to make sure the final implementation matches 
your
   intent before it gets merged.

   Thanks,
   Hongling

在 2026年05月20日 10:26, Hongling Zeng 写道:
> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
> ERR_PTR(0) which is incorrect. They should return NULL instead for
> success and ERR_PTR() only with negative error codes for failure.
>
> Return NULL instead of passing to ERR_PTR while err is zero
> Fixes smatch warnings:
>    fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
>    fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'
>
> This change does not alter the runtime behavior since ERR_PTR(0) and NULL
> are equivalent. However, it improves code readability and silences static
> analyzer warnings.
>
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>
> ---
> change inv1:
> - Add clarification in commit message that this is not a functional
>    change, as suggested by Christian Schoenebeck.
> - Add acked-by.
> ---
> Changes in v2:
> - Simplified v9fs_vfs_mkdir() implementation based on reviewer feedback
> - Remove unnecessary 'err' variable and use ERR_CAST()
> - Add suggested-by
> ---
>   fs/9p/vfs_inode.c      | 19 ++++++-------------
>   fs/9p/vfs_inode_dotl.c |  4 ++--
>   2 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d1508b1fe109..d2692bc20b08 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -672,27 +672,20 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>   static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>   				     struct dentry *dentry, umode_t mode)
>   {
> -	int err;
>   	u32 perm;
>   	struct p9_fid *fid;
>   	struct v9fs_session_info *v9ses;
>   
>   	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
> -	err = 0;
>   	v9ses = v9fs_inode2v9ses(dir);
>   	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
>   	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
> -	if (IS_ERR(fid)) {
> -		err = PTR_ERR(fid);
> -		fid = NULL;
> -	} else {
> -		inc_nlink(dir);
> -		v9fs_invalidate_inode_attr(dir);
> -	}
> -
> -	if (fid)
> -		p9_fid_put(fid);
> -	return ERR_PTR(err);
> +	if (IS_ERR(fid))
> +		return ERR_CAST(fid);
> +	inc_nlink(dir);
> +	v9fs_invalidate_inode_attr(dir);
> +	p9_fid_put(fid);
> +	return NULL;
>   }
>   
>   /**
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 71796a89bcf4..83a52a85ce08 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -349,7 +349,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>   					  struct inode *dir, struct dentry *dentry,
>   					  umode_t omode)
>   {
> -	int err;
> +	int err = 0;
>   	struct v9fs_session_info *v9ses;
>   	struct p9_fid *fid = NULL, *dfid = NULL;
>   	kgid_t gid;
> @@ -412,7 +412,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>   	p9_fid_put(fid);
>   	v9fs_put_acl(dacl, pacl);
>   	p9_fid_put(dfid);
> -	return ERR_PTR(err);
> +	return err ? ERR_PTR(err) : NULL;
>   }
>   
>   static int

