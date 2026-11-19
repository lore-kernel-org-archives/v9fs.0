Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080553;
	b=nGPHsqV0bwwmu3smfu6sULjkpIQsjUupnUg2ou7LaGAa6N1drYnoj91l8VRJ2fMmX2qa
	 de+e3IcUdUMDVDI+O8VNQtdLcuHnl16BIxHOExZLQ8wzijdhAwQ3XUjSEkhONinI014JG
	 PitlPnChlW3qEmg0/E2rNui4Q9UNyCSbuUf5bCaAtKmUkjg9OB12P67u0VcmFjCyJGteD
	 XioUgSJWvYdet/973Y+6G0aKwg24PV8WYoKzKvuVAcGoE979/Iz3GVhe8SfGoD+GZChdu
	 rBQeQ9t3GtdmMwhmkO236MkCbUjxfpTYKtyxrT+RJJE9UVb2lHeiPsLcEN2FGRWV/eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=54Xg+31GAwGDocjA4VNSymHKNP7tDrjDmp2DIIV80fY=;
	b=WYW1+NZbBrPxUsQjMMIofGGsOzvIEjdWxv3e2VYocHcZ6HjUvXNKo5esf5WoUo1imEyC
	 cHUzW5pnaGGQtfylAI+L5armgnPv5Xr4GU9tNdgX12SEXJk46B7MFds7rejxP4mvR0FOh
	 4Wc9bbV56jgmnp7sFY0BfMdxwpvEHWXByJN17Svn616zJ1nw46G4F2S6T5Ul9O/GZuiZC
	 9Of0XupWhFmr0As07aprjsIExBNL7kaLffxmq+Xrq5KxY8vKkHh2x1WQ8Esc4IB8B6h9J
	 3fs4uKJwGD+TetvgsLpKz/82WoQmVtD6YcCqyi9UYJGiyelc25hJHIOy5SK89pVjaTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXvJ3LK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E3606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXvJ3LK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB4D1F000C4;
	Thu, 19 Nov 2026 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080553;
	bh=54Xg+31GAwGDocjA4VNSymHKNP7tDrjDmp2DIIV80fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtXvJ3LK24AiEnKtQ8/DHZMJsOnAgfSEOT6m+VI0dTq4ib+VSWRYX55l8v+sRUrBK
	 ZyiIPbm5jSpX52HgQFQvQ37yzycoiBwb8KqVV5YyqXHWXGMpemx3BuuvsjmTI1w1SO
	 TBzHkXkqeUsE1Gs1pgv6bhDrvbI0OVjaXYat+xBlVcHtu/MVxV8BIoI0S1MRslNBsm
	 WyaGEhuEFZ5NRkgfR/tQLIbMBOQxKqYqfoNUO/StfiFPKNGfbU8GEC3WFsHuAugHlC
	 QpCDJ32oqW3vn5HN9jCtloj5B1YWGT5TdH4CVj43RLJfczlYXyYuqS7zxXwtMUiy/M
	 8Gg6f1bcQC0Qg==
Message-ID: <sashiko-outbox-222836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/17] afs: Use a bvecq to hold dir content rather
 than folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-12-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-12-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:29:12 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] afs: inconsistent i_size and uninitialized buffer in
  afs_symlink_writepages()
- [Medium] afs: inconsistent directory state and size in
  afs_dir_writepages()
--

commit 38825177e122ffa7a8e67a676f8d6170b75ad709
Author: David Howells <dhowells@redhat.com>

afs: Use a bvecq to hold dir content rather than folioq

This commit replaces folio_queue buffers with bvecq buffers for AFS
directories and symlinks, and snapshots the buffer, buffer size, and
inode size under cb_lock during writeback.

Link: https://sashiko.dev/#/patchset/20261107160823.1465553-1-dhowells%40re=
dhat.com

> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 51c158d8f723f..b75a26b312291 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
[ ... ]
> @@ -2220,12 +2220,11 @@ static int afs_dir_writepages(struct address_spac=
e *mapping,
>  			      struct writeback_control *wbc)
>  {
>  	struct afs_vnode *dvnode =3D AFS_FS_I(mapping->host);
> +	struct bvecq *directory =3D NULL;
>  	struct iov_iter iter;
>  	int ret =3D 0;
> =20
> -	/* Need to lock to prevent the folio queue and folios from being thrown
> -	 * away.
> -	 */
> +	/* Need to lock to prevent the bvecq and folios from being discarded. */
>  	if (!down_read_trylock(&dvnode->validate_lock)) {
>  		if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
>  			/* The VFS will have undirtied the inode. */
> @@ -2235,15 +2234,23 @@ static int afs_dir_writepages(struct address_spac=
e *mapping,
>  		down_read(&dvnode->validate_lock);
>  	}
> =20
> +	read_seqlock_excl(&dvnode->cb_lock);
>  	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
> -		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory,
> -				     0, 0, dvnode->directory_size);
> -		ret =3D netfs_writeback_single(mapping, wbc, &iter,
> -					     i_size_read(&dvnode->netfs.inode));
> +		size_t i_size =3D i_size_read(&dvnode->netfs.inode);
> +		size_t d_size =3D dvnode->directory_size;
> +
> +		directory =3D bvecq_get(dvnode->directory);
> +		read_sequnlock_excl(&dvnode->cb_lock);
> +
> +		iov_iter_bvec_queue(&iter, ITER_SOURCE, directory, 0, 0, d_size);
> +		ret =3D netfs_writeback_single(mapping, wbc, &iter, i_size);
>  		if (ret =3D=3D 1)
>  			ret =3D 0; /* Skipped write due to lock conflict. */
> +	} else {
> +		read_sequnlock_excl(&dvnode->cb_lock);
>  	}

[Severity: Medium]
Can afs_dir_writepages() still observe i_size > d_size or write an
unvalidated directory buffer to fscache?

In afs_read_dir(), set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) runs
outside cb_lock after afs_read_single() has dropped AFS_VNODE_IO_LOCK:

CPU0                              CPU1
afs_read_dir()
  afs_read_single()
    ... (allocates d_size)
                                  afs_do_lookup() (FS.InlineBulkStatus)
                                    afs_vnode_commit_status()
                                      write_seqlock(&dvnode->cb_lock)
                                      afs_apply_status()
                                        afs_invalidate_dir()
                                        i_size_write(..., new_size)
                                      write_sequnlock(&dvnode->cb_lock)
  set_bit(AFS_VNODE_DIR_VALID)
  downgrade_write(&validate_lock)
                                  afs_dir_writepages()
                                    netfs_writeback_single(..., i_size)
                                      <-- WARN_ON_ONCE(d_size < i_size)

Also, new directory vnodes start with AFS_VNODE_DIR_VALID set and
AFS_VNODE_DIR_READ clear.  If afs_do_read_single() fails in
afs_dir_check() after netfs_read_single() has already dirtied the inode,
afs_read_dir() unlocks validate_lock without clearing AFS_VNODE_DIR_VALID,
and afs_dir_writepages() (which does not check AFS_VNODE_DIR_READ) writes
the corrupt buffer into fscache.

[ ... ]

> diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
> index c18e4f8064234..823a9ba82eb7f 100644
> --- a/fs/afs/symlink.c
> +++ b/fs/afs/symlink.c
> @@ -56,7 +56,7 @@ void afs_evict_symlink(struct afs_vnode *vnode)
>  void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation =
*op)
>  {
>  	struct afs_symlink *symlink =3D op->create.symlink;
> -	size_t dsize =3D 0;
> +	unsigned int alloc_flags =3D 0;
>  	size_t size =3D strlen(symlink->content) + 1;
>  	char *p;
> =20
> @@ -66,12 +66,15 @@ void afs_init_new_symlink(struct afs_vnode *vnode, st=
ruct afs_operation *op)
>  	if (!fscache_cookie_enabled(netfs_i_cookie(&vnode->netfs)))
>  		return;
> =20
> -	if (netfs_alloc_folioq_buffer(NULL, &vnode->directory, &dsize, size,
> -				      mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
> +	vnode->directory =3D
> +		bvecq_alloc_buffer(PAGE_SIZE,
> +				   mapping_gfp_mask(vnode->netfs.inode.i_mapping),
> +				   &alloc_flags);
> +	if (!vnode->directory)
>  		return;
> =20
> -	vnode->directory_size =3D dsize;
> -	p =3D kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
> +	vnode->directory_size =3D PAGE_SIZE;
> +	p =3D bvec_kmap_partial(&vnode->directory->bv[0], 0);
>  	memcpy(p, symlink->content, size);
>  	kunmap_local(p);
>  	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
[ ... ]
> @@ -249,27 +251,39 @@ int afs_symlink_writepages(struct address_space *ma=
pping,
>  		down_read(&vnode->validate_lock);
>  	}
> =20
> +	read_seqlock_excl(&vnode->cb_lock);
>  	if (vnode->directory &&
>  	    atomic64_read(&vnode->cb_expires_at) !=3D AFS_NO_CB_PROMISE) {
> +		struct bvecq *bq =3D bvecq_get(vnode->directory);
>  		size_t i_size =3D i_size_read(&vnode->netfs.inode);
> +		size_t d_size =3D vnode->directory_size;
> =20
> -		if (i_size < vnode->directory_size) {
> -			iov_iter_folio_queue(&iter, ITER_DEST, vnode->directory, 0, 0,
> -					     vnode->directory_size);
> +		read_sequnlock_excl(&vnode->cb_lock);
> +
> +		if (i_size < d_size) {
> +			iov_iter_bvec_queue(&iter, ITER_DEST, bq, 0, 0, d_size);
>  			iov_iter_advance(&iter, i_size);
> -			iov_iter_zero(vnode->directory_size - i_size, &iter);
> +			iov_iter_zero(d_size - i_size, &iter);
>  		}
> -		iov_iter_folio_queue(&iter, ITER_SOURCE, vnode->directory, 0, 0,
> -				     vnode->directory_size);
> +
> +		iov_iter_bvec_queue(&iter, ITER_SOURCE, bq, 0, 0, d_size);
>  		ret =3D netfs_writeback_single(mapping, wbc, &iter, i_size);
> +		bvecq_put(bq);
> +	} else {
> +		read_sequnlock_excl(&vnode->cb_lock);
>  	}

[Severity: High]
Can afs_symlink_writepages() write uninitialized page memory to fscache or
pass i_size > d_size to netfs_writeback_single()?

Both afs_init_new_symlink() and afs_do_read_symlink() allocate
vnode->directory via bvecq_alloc_buffer() without __GFP_ZERO and only
populate the initial symlink length.  Unlike directories (which clear
AFS_VNODE_DIR_VALID in afs_apply_status()), when a status update arrives
for a symlink with a new data version, afs_vnode_commit_status() sets
AFS_VNODE_ZAP_DATA, updates inode->i_size, and installs a new valid
cb_expires_at !=3D AFS_NO_CB_PROMISE:

fs/afs/inode.c:afs_apply_status() {
    ...
		if (vnode->status.type =3D=3D AFS_FTYPE_DIR)
			afs_invalidate_dir(vnode, afs_dir_invalid_dv_mismatch);
		else
			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
		change_size =3D true;
    ...
}

Because afs_symlink_writepages() does not check AFS_VNODE_ZAP_DATA (and
afs_invalidate_symlink() only clears vnode->symlink, not
vnode->directory), an updated i_size larger than the old symlink length
causes afs_symlink_writepages() to zero only from the new i_size to
d_size, writing stale content plus uninitialized kernel memory in
[old_size, i_size) into fscache.  If the server reports i_size >
PAGE_SIZE (including when afs_do_read_symlink() returns -EFBIG after
netfs_read_single() has updated i_size and dirtied the inode), i_size >
d_size triggers WARN_ON_ONCE(iov_iter_count(iter) < len) in
netfs_writeback_single().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D11
