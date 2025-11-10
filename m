Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D430100C
	for <v9fs@lists.linux.dev>; Mon, 10 Nov 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784579; cv=none; b=bDbfNSnajv/YCqLFGlvLxYZN7aEo/MZPSqF2Q1GpZe1PzoU2M2SHrxg6WL+xNHHaF+TxY6OHnMhyycKti3lkvm0GU54KkE/TL5LqHfB13DUKSwfJrZgBQWwL5h+Jwf3lPKNA454ZQrnCTp6Pu2MoTnFhy9uWRzAUOkdiuP5YS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784579; c=relaxed/simple;
	bh=BqIUwVxkAKts4cXw+oTDzIVplIaQyivjg20fpWI9CPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTxwpPkIk4UbU3XBucJxqQGPcSrexY+qyPbccDxAttTwVzqUf0KEI8qm5ojMqk+G0E3TuZTE4jMq6s46XA0npZ87itjjQ5n9eCiC72hkkkoVjo9BhrkKjUyCEmgrMhEOjG8rqYZPmJVFzGTxJof8CzIwMTO1NjY1dAjQM+o5eRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=k/4QBPoJ; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="k/4QBPoJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=iBHqCoZ6Ehmm0av1iIiOq+dAco1TKlsdiZuy2SG4k98=; b=k/4QBPoJFc4tPLZeUdaSknwh96
	htA868F7Ed+IowfBkUpoLfu1661d2YBG3VoGu+kfp6j/HK68sLwHBk7fhJRPAFZYCirC2v+f0IA20
	bx8GW5Lo4FGdB/k0+O9wwMZiXzeu/z8wbj/4g/2ZDF911TSKFYCq0sWpJ+UaZah9fy/8sK2NIByA+
	OKgsjPnM33qXvwS6JhEiVwI7eVGz0DMV3GUv87liNhqNqBhLyDk3D/g369KGJRMox0v/iRTLQxSuq
	aQMz1/jH89JnDccIyH8jIQDwK+I6IOM61Cn0Np8NZzP0Qo8Wy/BKlW/qFZIWZ2tq5NIj2z3jzqGLV
	P12+UjnNwLU+5hbryeI9uFF0kLTN2XAdcWr9R6KZP790wbO7NKZYHRwze9tvuMVwBGLh3weRhENcv
	vAv5u4jEVphw1VHBMXS3kceZkePl4roMFRXi0kGvZ7SnAsqwaDLYcnvFyOyXQ3mW2IWXE106Jvsh2
	633mVYEIOookNLGNsX7KQwW/dJEydG68OPTc4K8u5o/UpyNmlmY9C2dZVoKuqaxAfaNQhtC5NpI1z
	1aVXjMz7ezrUs6/x1CNhTPzw8iajaBi2yfEeO1CvGfIqr7ktdxTWtbkk3sPF9qUgq8p277Khv5oDZ
	3ohwpme2hImvUagHrXcGpksKXq0B09eKZu4ZjMQK8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>, Tingmao Wang <m@maowtm.org>
Cc: Tingmao Wang <m@maowtm.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject:
 Re: [PATCH v2] fs/9p: Don't open remote file with APPEND mode when writeback
 cache is used
Date: Mon, 10 Nov 2025 15:22:48 +0100
Message-ID: <5562649.tBn8OvxF64@silver>
In-Reply-To: <20251102235631.8724-1-m@maowtm.org>
References:
 <cover.1762115015.git.m@maowtm.org> <aQfkMUncxteb9aPW@codewreck.org>
 <20251102235631.8724-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 3, 2025 12:56:30 AM CET Tingmao Wang wrote:
> When page cache is used, writebacks are done on a page granularity, and it
> is expected that the underlying filesystem (such as v9fs) should respect
> the write position.  However, currently v9fs will passthrough O_APPEND to
> the server even on cached mode.  This causes data corruption if a sync or
> fstat gets between two writes to the same file.
> 
> This patch removes the APPEND flag from the open request we send to the
> server when writeback caching is involved.  I believe keeping server-side
> APPEND is probably fine for uncached mode (even if two fds are opened, one
> without O_APPEND and one with it, this should still be fine since they
> would use separate fid for the writes).
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> I haven't done a bisect to figure out if this regression was introduced by
> a change or was this behaviour always present - 6.14 has the same problem
> and 6.13 did not compile for me due to some problem with bool / true /
> false being a keyword in c23, and it could not compile with c17 either.
> 
>  fs/9p/vfs_file.c       | 11 ++++++++---
>  fs/9p/vfs_inode.c      |  3 +--
>  fs/9p/vfs_inode_dotl.c |  2 +-
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 612a230bc012..6f3880208587 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file
> *file) struct v9fs_session_info *v9ses;
>  	struct p9_fid *fid;
>  	int omode;
> +	int o_append;
> 
>  	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
>  	v9ses = v9fs_inode2v9ses(inode);
> -	if (v9fs_proto_dotl(v9ses))
> +	if (v9fs_proto_dotl(v9ses)) {
>  		omode = v9fs_open_to_dotl_flags(file->f_flags);
> -	else
> +		o_append = P9_DOTL_APPEND;
> +	} else {
>  		omode = v9fs_uflags2omode(file->f_flags,
>  					v9fs_proto_dotu(v9ses));
> +		o_append = P9_OAPPEND;
> +	}
>  	fid = file->private_data;
>  	if (!fid) {
>  		fid = v9fs_fid_clone(file_dentry(file));
> @@ -58,9 +62,10 @@ int v9fs_file_open(struct inode *inode, struct file
> *file) return PTR_ERR(fid);
> 
>  		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
> -			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
> +			int writeback_omode = (omode & ~(P9_OWRITE | o_append)) | P9_ORDWR;

I guess changes in this function could be simplified by either pulling
O_APPEND at the very beginning right after v9ses = v9fs_inode2v9ses(inode); or
by simply pulling both P9_OAPPEND and P9_DOTL_APPEND here, but it's doing the
job so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

/Christian

> 
>  			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try
> opening O_RDWR\n"); +
>  			err = p9_client_open(fid, writeback_omode);
>  			if (err < 0) {
>  				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 8666c9c62258..97abe65bf7c1 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -786,7 +786,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry
> *dentry, p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
> 
>  	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
> -		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
> +		p9_omode = (p9_omode & ~(P9_OWRITE | P9_OAPPEND)) | P9_ORDWR;
>  		p9_debug(P9_DEBUG_CACHE,
>  			"write-only file with writeback enabled, creating w/ O_RDWR\n");
>  	}
> @@ -1393,4 +1393,3 @@ static const struct inode_operations
> v9fs_symlink_inode_operations = { .getattr = v9fs_vfs_getattr,
>  	.setattr = v9fs_vfs_setattr,
>  };
> -
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 1661a25f2772..643e759eacb2 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -282,7 +282,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct
> dentry *dentry, }
> 
>  	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
> -		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
> +		p9_omode = (p9_omode & ~(P9_OWRITE | P9_DOTL_APPEND)) | P9_ORDWR;
>  		p9_debug(P9_DEBUG_CACHE,
>  			"write-only file with writeback enabled, creating w/ O_RDWR\n");
>  	}


