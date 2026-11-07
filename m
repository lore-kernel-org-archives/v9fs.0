Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073571;
	b=kK4RaGo55tyXHF5I+1FHF4BKu10xZKNPU5NpOWvGvGbnhBvtT+GEGhhAHMDNv6/AMpQQ
	 kbOmPyd2aevSy7CJqQfANX6U9ukf8NalxLCRIzrbm6I6BeFh/M0l8+NR14k7LLtaP+CiN
	 gxHQ6Ew5jj9sxCtzHwI5Vr3PqDNwkwQqzf4CTQ2Prypq8IqbBDPNtvXLPwqbgXScWTqn+
	 z6mPf2/IYCPKUGBBX56h/+KHpb/ymfnwQ4TSGxM1eGJjjHhtXgYedhNbbd8YudB38L18T
	 ryfIYnq5mQrSMwiDCgivZqxrvRmFUYeyZKcOxmjNx5sarIfz3FeoITT+KCkHrhf0Azw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3OAqlctn4th29t+tKD8+IYrNFunRmDGQElHDSHxUPb4=;
	b=2Kr2M67Hii5eeFtgJizn8SNlSoFHxk89GyQfspLpwwVoDSLO2OAU3lUMr4UVN/6ou2FU
	 oz06lO8qV3k6N8oMOx5dp0LzrXvnynrd0+EkC/sAeS3RZ3nSLbBh9TPqIM2F19U3xYyGf
	 I2aAo7PgXg5CuM3XwyjxL5MzS8GzzgMr+Gk6u1RzhVo6b6e3nTi6pRnZ7KxJ7Mva++L2N
	 qtojdyI1C9nCHMB6vPsQvbA3sDz9iNG/b6TWAzc4hF/FX3V2FP5ePzAYrxLopgXeL6+Dx
	 tBGk2NGmCHUmKuEgi+5QiZz+BjN75plK72EsVPKj9S5ZIXjGWG2CQafK5kkwA5+QgEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+p5xKw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53D606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+p5xKw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F791F0089F;
	Sat,  7 Nov 2026 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073570;
	bh=3OAqlctn4th29t+tKD8+IYrNFunRmDGQElHDSHxUPb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+p5xKw4/XLkQI593iE+cChd/PApAueYr2LK79QubBZZgJOUKwNzAoQhIO5ADxEsr
	 32pWxTWjVCAx2jBORhxxiwzcDsd+jAf55OIXFBAbDgjF9G/BiS9f8TYM271iedBxia
	 /rLvAEhl385dGPiY5PICMUteMdKUgjiQ14XQ6KlK7ypS1DMVhESjOYLcQwCWHVbIPC
	 XFatpL6dP0KyX6iA3/ITDRH8rTJNPZRtibDPEpW7DT7D+csis9QThfjJWY9O6yYH4Y
	 RprK0JVwx1amExSQxawp9VTM06unFNN0ATNOmwOtimmA5xd0LyGqh7jMtJmftNEVpj
	 06yhZrmjKsYvw==
Message-ID: <sashiko-outbox-203129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/15] netfs: Explicitly pass tail padding to
 netfs_writeback_single()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261107160823.1465553-8-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-8-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 17:46:10 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] afs: race on i_size in afs_dir_writepages() triggers
  WARN_ON_ONCE()
- [Medium] netfs: netfs_writeback_single() does not set wreq->i_size to
  len
- [Medium] afs: i_size exceeding directory_size in writepages triggers
  WARN_ON_ONCE()
--

commit 85f14f8d404627b37bc4c8b65ec7be7797cc5f30
Author: David Howells <dhowells@redhat.com>

netfs: Explicitly pass tail padding to netfs_writeback_single()

This commit changes netfs_writeback_single() to take an explicit content
length alongside the full DIO-rounded buffer iterator, and updates AFS
directory and symlink writeback to zero the buffer tail and pass both
lengths.

> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 75f8f70cfeff0..51c158d8f723f 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c

[ ... ]

> @@ -2228,9 +2236,10 @@ static int afs_dir_writepages(struct address_space=
 *mapping,
>  	}
> =20
>  	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
> -		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
> -				     i_size_read(&dvnode->netfs.inode));
> -		ret =3D netfs_writeback_single(mapping, wbc, &iter);
> +		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory,
> +				     0, 0, dvnode->directory_size);
> +		ret =3D netfs_writeback_single(mapping, wbc, &iter,
> +					     i_size_read(&dvnode->netfs.inode));
>  		if (ret =3D=3D 1)
>  			ret =3D 0; /* Skipped write due to lock conflict. */
>  	}

[Severity: Medium]
Can a concurrent status update grow inode->i_size past
dvnode->directory_size here and trigger the WARN_ON_ONCE() in
netfs_writeback_single()?

RPC completion callbacks such as afs_do_lookup_success() call
afs_vnode_commit_status() -> afs_apply_status() without holding
dvnode->validate_lock:

CPU0                                  CPU1
afs_dir_writepages()
  down_read(&dvnode->validate_lock)
  test_bit(AFS_VNODE_DIR_VALID, ...)
  iov_iter_folio_queue(...,
    dvnode->directory_size)
                                      afs_do_lookup_success()
                                        ...
                                        afs_apply_status()
                                          afs_invalidate_dir()
                                          netfs_write_sizes()
  i_size_read(&dvnode->netfs.inode)
  netfs_writeback_single()
    WARN_ON_ONCE(iov_iter_count(iter) < len)  <-- triggers warning, -EIO

If a remote modification grows the directory beyond dvnode->directory_size
in that window, netfs_writeback_single() warns and fails writeback with
-EIO.

> diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
> index a1dbd552ddff0..c18e4f8064234 100644
> --- a/fs/afs/symlink.c
> +++ b/fs/afs/symlink.c
> @@ -228,6 +228,10 @@ int afs_readlink(struct dentry *dentry, char __user =
*buffer, int buflen)
>  /*
>   * Write the symlink contents to the cache as a single blob.  We then th=
row
>   * away the page we used to receive it.
> + *
> + * Note that the buffer tail is cleared under a shared lock on ->validat=
e_lock
> + * - though hopefully there won't be racing writers since the only
> + * 'modification' is to be either read from the server or locally create=
d.
>   */
>  int afs_symlink_writepages(struct address_space *mapping,
>  			   struct writeback_control *wbc)
> @@ -247,9 +251,17 @@ int afs_symlink_writepages(struct address_space *map=
ping,
> =20
>  	if (vnode->directory &&
>  	    atomic64_read(&vnode->cb_expires_at) !=3D AFS_NO_CB_PROMISE) {
> +		size_t i_size =3D i_size_read(&vnode->netfs.inode);
> +
> +		if (i_size < vnode->directory_size) {
> +			iov_iter_folio_queue(&iter, ITER_DEST, vnode->directory, 0, 0,
> +					     vnode->directory_size);
> +			iov_iter_advance(&iter, i_size);
> +			iov_iter_zero(vnode->directory_size - i_size, &iter);
> +		}
>  		iov_iter_folio_queue(&iter, ITER_SOURCE, vnode->directory, 0, 0,
> -				     i_size_read(&vnode->netfs.inode));
> -		ret =3D netfs_writeback_single(mapping, wbc, &iter);
> +				     vnode->directory_size);
> +		ret =3D netfs_writeback_single(mapping, wbc, &iter, i_size);
>  	}

[Severity: Medium]
Can i_size exceed vnode->directory_size in afs_symlink_writepages() and
trigger WARN_ON_ONCE(iov_iter_count(iter) < len) in
netfs_writeback_single()?

In afs_do_read_symlink(), vnode->directory is allocated to PAGE_SIZE.  If
netfs_read_single() fetches the symlink from the server and the returned
AFSFetchStatus reports status.size > PAGE_SIZE, afs_apply_status() updates
inode->i_size to status.size and sets the callback promise while
netfs_rreq_assess_single() marks the inode dirty.  afs_do_read_symlink()
then returns -EFBIG without freeing vnode->directory or clearing the dirty
state.  When afs_symlink_writepages() later runs, i_size is larger than
vnode->directory_size, causing netfs_writeback_single() to warn and return
-EIO (which also skips freeing vnode->directory).

> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index b8237e1314d8a..e041023811ed0 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -747,26 +747,33 @@ static int netfs_write_folio_single(struct netfs_io=
_request *wreq,
>   * netfs_writeback_single - Write back a monolithic payload
>   * @mapping: The mapping to write from
>   * @wbc: Hints from the VM
> - * @iter: Data to write, must be ITER_FOLIOQ.
> + * @iter: Data buffer to write from, must be ITER_FOLIOQ.
> + * @len: Amount of data to write.
>   *
>   * Write a monolithic, non-pagecache object back to the server and/or
>   * the cache.
>   *
> + * The data buffer may be bigger than @len (as set in @iter's count), an=
d if
> + * so, this function will use the extra as needed to provide padding int=
o the
> + * cache to handle DIO rounding, so the caller should clear it.
> + *
>   * Return: 0 if successful; 1 if skipped due to lock conflict and WB_SYN=
C_NONE;
>   * or a negative error code.
>   */
>  int netfs_writeback_single(struct address_space *mapping,
>  			   struct writeback_control *wbc,
> -			   struct iov_iter *iter)
> +			   struct iov_iter *iter, size_t len)
>  {
>  	struct netfs_io_request *wreq;
>  	struct netfs_inode *ictx =3D netfs_inode(mapping->host);
>  	struct folio_queue *fq;
> -	size_t size =3D iov_iter_count(iter);
> +	size_t size =3D len;
>  	int ret;
> =20
>  	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
>  		return -EIO;
> +	if (WARN_ON_ONCE(iov_iter_count(iter) < len))
> +		return -EIO;
> =20
>  	if (!netfs_wb_begin(ictx, wbc->sync_mode =3D=3D WB_SYNC_NONE)) {
>  		/* The VFS will have undirtied the inode. */

[Severity: Medium]
Should netfs_writeback_single() initialize wreq->i_size from len instead of
letting netfs_create_write_req() -> netfs_alloc_request() re-read
i_size_read(inode)?

If inode->i_size changes concurrently (via afs_apply_status() ->
netfs_write_sizes()) between the caller passing len and
netfs_alloc_request() reading wreq->i_size, wreq->i_size and len disagree.
If wreq->i_size < len and the loop advances to a folio with fpos >
wreq->i_size, netfs_write_folio_single() underflows the unsigned
wreq->i_size - fpos subtraction:

fs/netfs/write_issue.c:netfs_write_folio_single() {
    ...
	flen =3D folio_size(folio);
	if (flen > wreq->i_size - fpos) {
		flen =3D wreq->i_size - fpos;
		folio_zero_segment(folio, flen, fsize);
		to_eof =3D true;
	} else if (flen =3D=3D wreq->i_size - fpos) {
		to_eof =3D true;
	}
    ...
}

Although the follow-up commit "netfs: Change netfs_writeback_single() to
not look inside the iterator" removes netfs_write_folio_single() and sets
wreq->len =3D len, it still leaves wreq->i_size initialized from
i_size_read(inode), which causes cachefiles_issue_write() to skip DIO tail
padding when start + len !=3D wreq->i_size and triggers WARN_ON(len &
(cache->bsize - 1)) in cachefiles_collect_write().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D7
