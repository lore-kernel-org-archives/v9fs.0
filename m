Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2F2209B
	for <v9fs@lists.linux.dev>; Mon,  8 Jan 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="QgqdVEa3";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XwLst7Nk"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 4E4ADC01D; Mon,  8 Jan 2024 12:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704713315; bh=k2lMxOP1/yyk0rbltW6MUaJ4MBuiJmlSqq2jdXY75p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgqdVEa334KMcx8MltWtwlBV1wHnqzwKDBdMBZpPbNoGGt8/pLtDkyO9oOaKdvMVF
	 CKn2zt2KyBemHxaw97RNnFPHRpkHoOHNabJ8qkVFjH6qZDARF9SZ6IjGAVujusDCgC
	 1Yd/wkQ8pgXgsx4gcvz0qeutmGutuVgytzNmz4Sewh3I447GBcAGPbl+o0Qyz7sn7b
	 8A2p0F2JyliXOmT8CIV0ndk5q27MJlz0npb6DvnBtUXMQVSvzbZtRmQyNOFMZEwd5N
	 wQ/HUpqByHsTU3QbTeC71jzRjcsxGYFbws8gY9EFWcowcpoa3QZqjHAF1cN+tQ4pgs
	 DLOclOWtJK/hQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id CC64BC009;
	Mon,  8 Jan 2024 12:28:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704713314; bh=k2lMxOP1/yyk0rbltW6MUaJ4MBuiJmlSqq2jdXY75p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwLst7Nksg1YyJ5mredTlrNKl3q1v8nWdhq93tj7M38LAhZnekm6R6/1732dXPXFt
	 l9mAFRLPJszE1B0x+W7/uFF34cvezj0aR4frM3F+2mbEq1wv+vFetMSLPdPj+sfkbs
	 ZOgJYD9ADEj8yCD5x3Ug4fU9zwGKdHqUMN3oAyQbuAjs2hxHUenclzq+fJMNcozL4q
	 t8Oi+axJdKQ6Kn0qAzP/ltSp30ON8235VbwAKV2cnlsC0EeArG5WTWhDE2GfpBufAf
	 9eHtXzbwhPj5QZ9X+9/MIguyIJc7yfgLvkEH4wBCtpOTEzHZaNHRPVsb70eyml/jVn
	 JphjglaNeG0Lw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 88dbdfb2;
	Mon, 8 Jan 2024 11:28:30 +0000 (UTC)
Date: Mon, 8 Jan 2024 20:28:15 +0900
From: asmadeus@codewreck.org
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux_oss@crudebyte.com, rminnich@gmail.com,
	lucho@ionkov.net
Subject: Re: [PATCH 7/9] fs/9p: rework qid2ino logic
Message-ID: <ZZvcT2__1syWHdbC@codewreck.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
 <20240106-ericvh-fix-cache-dups-v1-7-538c2074f363@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-7-538c2074f363@kernel.org>

Eric Van Hensbergen wrote on Sat, Jan 06, 2024 at 02:11:14AM +0000:
> This changes from a function to a macro because we can
> figure out if we are 32 or 64 bit at compile time.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Couple of remarks on this one.
patches 2-6 so far all looked good to me.


> ---
>  fs/9p/v9fs_vfs.h       |  7 ++++++-
>  fs/9p/vfs_dir.c        |  6 +++---
>  fs/9p/vfs_inode.c      | 31 +------------------------------
>  fs/9p/vfs_inode_dotl.c |  6 ++----
>  4 files changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
> index ad0310deb6c8..789e1188d5dc 100644
> --- a/fs/9p/v9fs_vfs.h
> +++ b/fs/9p/v9fs_vfs.h
> @@ -43,7 +43,12 @@ void v9fs_free_inode(struct inode *inode);
>  int v9fs_init_inode(struct v9fs_session_info *v9ses,
>  		    struct inode *inode, umode_t mode, dev_t rdev);
>  void v9fs_evict_inode(struct inode *inode);
> -ino_t v9fs_qid2ino(struct p9_qid *qid);
> +#if (ULONG_MAX == 0xffffffffUL)

The standard preprocessor condition in the kernel for this is checking
BITS_PER_LONG, e.g.
include/asm-generic/bitops/fls64.h
18:#if BITS_PER_LONG == 32
26:#elif BITS_PER_LONG == 64
33:#else
34:#error BITS_PER_LONG not 32 or 64
35:#endif

> +#define QID2INO(q) (ino_t) (((q)->path+2) ^ (((q)->path) >> 32))
> +#else
> +#define QID2INO(q) (ino_t) ((q)->path+2)
> +#endif
> +
>  void v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
>  		      struct super_block *sb, unsigned int flags);
>  void v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 4102759a5cb5..13a53da75ec8 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -125,9 +125,9 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
>  				p9_debug(P9_DEBUG_VFS, "returned %d\n", err);
>  				return -EIO;
>  			}
> -
> +

stray white space?

>  			over = !dir_emit(ctx, st.name, strlen(st.name),
> -					 v9fs_qid2ino(&st.qid), dt_type(&st));
> +					QID2INO(&st.qid), dt_type(&st));
>  			p9stat_free(&st);
>  			if (over)
>  				return 0;
> @@ -184,7 +184,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
>  
>  			if (!dir_emit(ctx, curdirent.d_name,
>  				      strlen(curdirent.d_name),
> -				      v9fs_qid2ino(&curdirent.qid),
> +				      QID2INO(&curdirent.qid),
>  				      curdirent.d_type))
>  				return 0;
>  
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 02761009946b..fe8cbcdf4b5f 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -407,7 +407,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
>  	dev_t rdev;
>  	int retval;
>  	umode_t umode;
> -	unsigned long i_ino;
>  	struct inode *inode;
>  	struct v9fs_session_info *v9ses = sb->s_fs_info;
>  	int (*test)(struct inode *inode, void *data);
> @@ -417,8 +416,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
>  	else
>  		test = v9fs_test_inode;
>  
> -	i_ino = v9fs_qid2ino(qid);
> -	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode, st);
> +	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  	if (!(inode->i_state & I_NEW))
> @@ -428,7 +426,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
>  	 * FIXME!! we may need support for stale inodes
>  	 * later.
>  	 */
> -	inode->i_ino = i_ino;

This is gone, but v9fs_qid_iget_dotl() still sets i_ino -- didn't check
which is needed but we probably want to stay coherent between the two.

>  	umode = p9mode2unixmode(v9ses, st, &rdev);
>  	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
>  	if (retval)
> @@ -1159,32 +1156,6 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
>  	v9inode->cache_validity &= ~V9FS_INO_INVALID_ATTR;
>  }
>  
> -/**
> - * v9fs_qid2ino - convert qid into inode number
> - * @qid: qid to hash
> - *
> - *  We add 2 to qid->path to keep reserved inode
> - *  numbers reserved.
> - * 
> - *  Its possible in the future we will make qid->path
> - *  just a hash to lookup inodes, but this breaks too
> - *  much right now.
> - * 
> - */
> -
> -ino_t v9fs_qid2ino(struct p9_qid *qid)
> -{
> -	ino_t i = 0;
> -
> -	WARN_ON((qid->path+2)==0);
> -
> -	if (sizeof(ino_t) < sizeof(qid->path))
> -		i = (ino_t) ((qid->path+2) ^ (qid->path >> 32));
> -	else
> -		i = (ino_t) qid->path;
> -
> -	return i;
> -}
>  
>  /**
>   * v9fs_vfs_get_link - follow a symlink path
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 8eee13bae887..2699d7b3b8e8 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -100,7 +100,6 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
>  					int new)
>  {
>  	int retval;
> -	unsigned long i_ino;
>  	struct inode *inode;
>  	struct v9fs_session_info *v9ses = sb->s_fs_info;
>  	int (*test)(struct inode *inode, void *data);
> @@ -110,8 +109,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
>  	else
>  		test = v9fs_test_inode_dotl;
>  
> -	i_ino = v9fs_qid2ino(qid);
> -	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode_dotl, st);
> +	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  	if (!(inode->i_state & I_NEW))
> @@ -121,7 +119,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
>  	 * FIXME!! we may need support for stale inodes
>  	 * later.
>  	 */
> -	inode->i_ino = i_ino;
> +	inode->i_ino = QID2INO(qid);
>  	retval = v9fs_init_inode(v9ses, inode,
>  				 st->st_mode, new_decode_dev(st->st_rdev));
>  	if (retval)
> 

-- 
Dominique Martinet | Asmadeus
