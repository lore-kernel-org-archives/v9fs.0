Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E3B652;
	Sat, 27 Dec 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766835040; cv=none; b=l8dj6f/IWoneMvA7pNW4h+6SsoSC5MHqsFmvHG39qyIc4wbhQ+4vxBfX1DHCLf7qbj/6kAwUT9qGsyiJ2ABqxv9lOVaGvWYAAYjUNuVF2V+uRHx6pBEF26nj4tNJC53j0Hz0V0Z74iTK1WLcyBgSAzHk9DvMlykkduo1G9v3Pl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766835040; c=relaxed/simple;
	bh=r9UYbSXeG+Ujdk3dbUFi4QmIfhx36xmj5Y4wE7BT5jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvE/7Rw9aHfeqksXoM8MWJmd9BCwVZAqnsr7TjNE+/uLNh2zOP/lJzU4AqdmbXBSmtcOINxBJLgLwbtUvP6mKntn7NvpefanHTreUS1EXjs/Uy8iAG4Ndy5rpubZm33TesnQjPf1QiNTb9SmZto1fqDmlicJ8DwwyflYby9QSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=fiZsDOMr; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fiZsDOMr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=SLUEThgHZecZhQbrRTMgH6kIso9yU0RAFzfYR5nJi3A=; b=fiZsDOMrvDQkkFtoH8FH3zC50I
	44LDtVxidMXzn2B70+ZJ7EOJbNtaUAm3TwHG+psKYHCyI647ZWDBjkQ25gP9cJXeGa+y9dJmRzBm+
	l47176B2IbxUgwdLKdSPuDwVH/ZP70JAxMST3mujHofpPca0Kzcu/hwWazby4nnck2f6I9FBTXAfW
	dpmbd3ezZl6fEh5tWdF0QmVR0MCDl1p0Yh+q3I8e1ThQ+bnaHWcEpk5oicMN+0Xyrz2NGE/XtRi7N
	/VHJRjmHqboStAERBo5slFbj1gqoKBxz8gHc/U2d+/WmoI9gYvtX5XuW31vjq09DiysxLNg8F0JTt
	Rl/md49mNv8aedz9aPFw/ZbmY1HpJKAGEgv40HMddumncN0gPrcrIGABzUBW0PpkLEngg8xnApXHX
	2LkTJUa3ggGjrCeGGD8VzSMLFJv6Ls+/XXHaHS9e8VdOM8bgGl5FoV6jhhlMTn3XHXcCe/R4MzjAr
	Op3cDaKh9gfTDr//KdnQsZikacEazQiPK53lc3xL9YbywzD9TX/xqX38ufBbdrXmu/nSX2Srw5lRg
	9EWPr/WVjZlOKgw79I1COc78cuJyOWh8sBGlKNouUNI+bYmafEL7hsea9jCOAaTsmpRsz7QcbyXvS
	Cc6AVSvD3YIbEKNifdb4deKhCpm2OJGBndJPEoYSU=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Pierre Barre <pierre@barre.sh>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] 9p: fix data corruption with writeback caching during concurrent
 stat
Date: Sat, 27 Dec 2025 12:30:20 +0100
Message-ID: <2393940.ElGaqSPkdT@weasel>
In-Reply-To: <20251227083751.715152-1-pierre@barre.sh>
References: <20251227083751.715152-1-pierre@barre.sh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 27 December 2025 09:37:51 CET Pierre Barre wrote:
> When using writeback caching (cache=mmap), v9fs_vfs_getattr/setattr have
> two issues that can cause data corruption:
> 
> 1. filemap_fdatawrite() initiates writeback but doesn't wait for
>    completion. The subsequent server stat sees stale file size.
> 
> 2. v9fs_stat2inode()/v9fs_stat2inode_dotl() unconditionally overwrite
>    i_size from the server response, even when dirty pages exist locally.
>    This causes processes using lseek(SEEK_END) to see incorrect file
>    sizes.
> 
> Fix by using filemap_write_and_wait() instead of filemap_fdatawrite(),
> and passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is enabled
> to preserve the local i_size.
> 
> Also fix v9fs_vfs_getattr_dotl() to check for CACHE_WRITEBACK specifically
> rather than any cache mode.
> 
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  fs/9p/vfs_inode.c      | 11 ++++++++---
>  fs/9p/vfs_inode_dotl.c | 13 +++++++++----
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 97abe65bf7c1..f4c294ca759b 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -977,7 +977,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct
> path *path, return 0;
>  	} else if (v9ses->cache & CACHE_WRITEBACK) {
>  		if (S_ISREG(inode->i_mode)) {
> -			int retval = filemap_fdatawrite(inode->i_mapping);
> +			int retval = filemap_write_and_wait(inode->i_mapping);

Haven't reviewed thorougly, but this looks wrong to me. The point about write-
back is not having to wait for completion.

>  			if (retval)
>  				p9_debug(P9_DEBUG_ERROR,
> @@ -993,7 +993,12 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct
> path *path, if (IS_ERR(st))
>  		return PTR_ERR(st);
> 
> -	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
> +	/*
> +	 * With writeback caching, the client is authoritative for i_size.
> +	 * Don't let the server overwrite it with a potentially stale value.
> +	 */
> +	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);

And this measure alone (along with the same change in v9fs_vfs_getattr_dotl()
that is) would not fix the misbehavior you encountered?

>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
> 
>  	p9stat_free(st);
> @@ -1058,7 +1063,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
> 
>  	/* Write all dirty data */
>  	if (d_is_reg(dentry)) {
> -		retval = filemap_fdatawrite(inode->i_mapping);
> +		retval = filemap_write_and_wait(inode->i_mapping);
>  		if (retval)
>  			p9_debug(P9_DEBUG_ERROR,
>  			    "flushing writeback during setattr returned %d\n", retval);
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 643e759eacb2..362a68a2bca3 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -431,9 +431,9 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>  	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
>  		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  		return 0;
> -	} else if (v9ses->cache) {
> +	} else if (v9ses->cache & CACHE_WRITEBACK) {

OK, so here is an inconsistency between v9fs_vfs_getattr_dotl() and
v9fs_vfs_getattr(). But to me it should be the other way around, i.e.
v9fs_vfs_getattr() should do it any cache mode, not only for write-back?

/Christian

>  		if (S_ISREG(inode->i_mode)) {
> -			int retval = filemap_fdatawrite(inode->i_mapping);
> +			int retval = filemap_write_and_wait(inode->i_mapping);
> 
>  			if (retval)
>  				p9_debug(P9_DEBUG_ERROR,
> @@ -453,7 +453,12 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>  	if (IS_ERR(st))
>  		return PTR_ERR(st);
> 
> -	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
> +	/*
> +	 * With writeback caching, the client is authoritative for i_size.
> +	 * Don't let the server overwrite it with a potentially stale value.
> +	 */
> +	v9fs_stat2inode_dotl(st, d_inode(dentry),
> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>  	/* Change block size to what the server returned */
>  	stat->blksize = st->st_blksize;
> @@ -561,7 +566,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
> 
>  	/* Write all dirty data */
>  	if (S_ISREG(inode->i_mode)) {
> -		retval = filemap_fdatawrite(inode->i_mapping);
> +		retval = filemap_write_and_wait(inode->i_mapping);
>  		if (retval < 0)
>  			p9_debug(P9_DEBUG_ERROR,
>  			    "Flushing file prior to setattr failed: %d\n", retval);




