Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3936D9F6;
	Sat,  9 May 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778322162; cv=none; b=UMCF6AllHj3QyVIVNNYNEcMSjKUbzyRcqm+ScFR183xytSxGJ255AMx4nWZamv0btcWYnUy4cT+0ja399O0cUj92M/OT0j0zRs+cQV0RSI+QSRDqdvPbS+AyvFh9sawnXQcXNIQuAknYTemzD4JBp53mUqNjpSYT+ZVtnCK2/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778322162; c=relaxed/simple;
	bh=WMwZBNXZEpw3U8toTieG0XSgjcvumD+CinQsmRYzjOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViLD2nyKZAJlRlKqaxo/N7HrbGIYftaYeOK8N7xFtezP/zVbYCtI8rVUCa2btsJJktiaT7h7tte1V7p2oDfbV7+McoQzT1amsO/Gk2c2vNwGVBshyDs4tNuf14oBn8ISP/R2+CoiLrteUy36SSx558+AX7zjR8ns4ULz6kYGFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=XUlGwn3k; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XUlGwn3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=MkpXe+MOgYHl1o13MU67gVq6PcdraGdRFjaX5XJ16Qk=; b=XUlGwn3kDoSx3FSyrPQQ6Q039y
	8flxO95nzWnNRc6cJ6gMs8Z/Yt9a9iuWvhkpQvLuSTczjcpMGEuZSGynVkcoP+7mFITdqjZUmw1F7
	+olPr6Fctcp90/XAo4iwRvOCspgPNz+0UJ+8M9g6SgQq7DD5penssCas3fOV3sEDrVbZDFqVY3qw3
	tGnrIQr59m8jy0inVEvFIa5OeHFOuCuQF9WljUKNXmEcb27jf3F5NgOBQcPocw4PbnqHuHUvZ/o/Z
	tEr84/YmEBvJfEDmEun+/yx4gdjEGhNPTgLeH87G3ZFhN4rsdsJX/LjgRgeb4p+i4GOeZsPJ6sE/r
	0YMkTMXTr8SJa34qdZN95ISwGWMJuytcb6oSnvgDS116fGKiRJEs98q14qikxA/YVxtjjNR2U3x41
	6lmM6BeFqRqHPVzhxWKFKteuVJOCEpbv53MF/LkLgjgmCasQA5AYp6MwTAA4RILMZRSgea6N5Smr0
	IrrPHdF3oXGW5y1vzA6GyEqhnUyVdMnRc+a1bhKb4+W7oCiDFC+q4lED146RJny1Y2UbgSUrxreic
	Jye3z4NRThssFMtdOHzdnnNt9ueuxSDsJjCLavV6I2xETLVdzBw76eH+/fFpCXILiAOZ49ehSlrHy
	0i7pduKoXKLEvsG33esM9FOLAkMuzJpGp3wFI2wDI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hongling Zeng <zenghongling@kylinos.cn>
Subject: Re: [PATCH] 9p: Fix mkdir to return NULL on success
Date: Sat, 09 May 2026 12:00:30 +0200
Message-ID: <5990824.DvuYhMxLoT@weasel>
In-Reply-To: <20260509063733.50009-1-zenghongling@kylinos.cn>
References: <20260509063733.50009-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 9 May 2026 08:37:33 CEST Hongling Zeng wrote:
> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
> ERR_PTR(0) which is incorrect. They should return NULL instead for
> success and ERR_PTR() only with negative error codes for failure.
> 
> Return NULL instead of passing to ERR_PTR while err is zero
> Fixes smatch warnings:
>   fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to
> 'ERR_PTR' fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to
> 'ERR_PTR'
> 
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry
> *") Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>


IMHO it would make sense to point out in the commit log that this patch would 
not cause a behaviour change. It just silences a static analyzer warning.

It improves readability though, i.e. for code readers to see that the 
functions may return NULL.

Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/vfs_inode.c      | 5 ++---
>  fs/9p/vfs_inode_dotl.c | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d1508b1fe109..d2d18c796b58 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -672,13 +672,12 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode
> *dir, static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct
> inode *dir, struct dentry *dentry, umode_t mode)
>  {
> -	int err;
> +	int err = 0;
>  	u32 perm;
>  	struct p9_fid *fid;
>  	struct v9fs_session_info *v9ses;
> 
>  	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
> -	err = 0;
>  	v9ses = v9fs_inode2v9ses(dir);
>  	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
>  	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
> @@ -692,7 +691,7 @@ static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap
> *idmap, struct inode *dir,
> 
>  	if (fid)
>  		p9_fid_put(fid);
> -	return ERR_PTR(err);
> +	return err ? ERR_PTR(err) : NULL;
>  }
> 
>  /**
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 71796a89bcf4..83a52a85ce08 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -349,7 +349,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct
> mnt_idmap *idmap, struct inode *dir, struct dentry *dentry,
>  					  umode_t omode)
>  {
> -	int err;
> +	int err = 0;
>  	struct v9fs_session_info *v9ses;
>  	struct p9_fid *fid = NULL, *dfid = NULL;
>  	kgid_t gid;
> @@ -412,7 +412,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct
> mnt_idmap *idmap, p9_fid_put(fid);
>  	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
> -	return ERR_PTR(err);
> +	return err ? ERR_PTR(err) : NULL;
>  }
> 
>  static int


