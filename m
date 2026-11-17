Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938714;
	b=LNUe++dc+P9/nXGCmW30XuTsDFa3yxTq6+Wys4NoUahRNOjd8avkJDNpc7c3Ufvg8ZcX
	 BwschZ4H6FgSrrR7/YL1Ec3q9q8FrrBj5/Vvye7I1eB7DDDyc3VtxaoNkhGnoKZSYGdgR
	 i2XyFrMKg18WRhKlR6mI/Rr8REjRa2uy91QL8r1UNc6z0QIO4Q2PIFc6d9iFsaXaUZGBN
	 12gUY+EBINuuok4lkE+MKi5CTOHnql9IW4ai/vLteiFUeCcq7JtLjMoJquIRHGrnqIBew
	 oIVrqCOH32EDgWL0MWMWc5ZPZ0UJykZrhzWSmolUZAztUv4kDz/xnSC8aSH52es6buQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pc8MFujNuCZmrBtVbNt2GQSDC7hdlkBZEkRqMKev2Cg=;
	b=Shy8KeQM4etmJAgZFA7RuH7Mkd+KHO/Ex9Jx4mvviL17d1h5s4YOgoOSprRGgaB/u9D5
	 qAVhEv1qHX5/Vi7peGQ9TC+/8UeTM4OsS4O7D8L/T453zVIrIo0bszdtuE7ke/tuHzdxS
	 +6vSsGMa1rlyuJhLTmCAOlHBaDOJvh93yA4VomeMm5KvqgPNg3a+v5sBqwrNL9h69Sxyc
	 hAmESlzNbXMvpJU3wJQVBJOmg1qRayr6To3xrgOd8m8ib/AbHxGaU/NzdEyV7zGh0h2Av
	 i+MZoTxkU4Mwij5Zb1Fup098MDhRIluK3vvMiF45bv+5zrmhpjLYnvXdZJLZamJVJSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om+z0WZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39234606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om+z0WZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A2B1F000C4;
	Tue, 17 Nov 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938714;
	bh=Pc8MFujNuCZmrBtVbNt2GQSDC7hdlkBZEkRqMKev2Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om+z0WZQzAAWiPXBJ8rbjpYzANXWEftVlAcz8cDHNulcperHlJco0Rs9YSiuXtQs1
	 iyamqsDF4VkxYLtzoNRtu1+fm9dpJd5miE5XsYltMgnGj5uSTW3A77uGwKU4NxSVgG
	 hFz4jDlk71wgmqoJv6T/WF8HqiYOHt32O5aENppNF3fK/GOnlwZhlzz5+z98B4gnO5
	 EY6ta9hCmrxad9MeeaCRliWQXRXpuea4oCvBvh2cQ4VlmtZFiyoulIW6Y6Fb0KFQXU
	 fti08ObOK1Wn/7m0B2z7vxgPVl/KTuefA3FIHzZEwCL63qqVVbxLec+HdW2LMwmU3K
	 rn8NuJ6w9BXOA==
Message-ID: <sashiko-outbox-219308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 11/17] afs: Use a bvecq to hold dir content rather
 than folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-12-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-12-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:05:13 +0000
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

commit 1f753ccfe6b6a6145c885c24eef1abe752152c76
Author: David Howells <dhowells@redhat.com>

afs: Use a bvecq to hold dir content rather than folioq

This commit replaces folio_queue buffers with refcounted bvecq buffers for
AFS directory and symlink contents, and snapshots the buffer and sizes
under cb_lock during writeback.

Link: https://sashiko.dev/#/patchset/20261107160823.1465553-1-dhowells%40re=
dhat.com

> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 51c158d8f723f..cc0449b9a6866 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
[ ... ]
> @@ -2220,6 +2220,7 @@ static int afs_dir_writepages(struct address_space =
*mapping,
>  			      struct writeback_control *wbc)
>  {
>  	struct afs_vnode *dvnode =3D AFS_FS_I(mapping->host);
> +	struct bvecq *directory =3D NULL;
>  	struct iov_iter iter;
>  	int ret =3D 0;
> =20
> @@ -2235,15 +2236,23 @@ static int afs_dir_writepages(struct address_spac=
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
> =20
>  	up_read(&dvnode->validate_lock);
> +	bvecq_put(directory);
>  	return ret;
>  }

[Severity: Medium]
Can afs_dir_writepages() still observe an inconsistent i_size and d_size or
write unvalidated directory data to fscache when checking only
AFS_VNODE_DIR_VALID under cb_lock?

In afs_read_dir(), set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) runs
outside cb_lock after afs_read_single() has released io_lock and marked the
inode dirty.  A concurrent RPC that updates status without holding
validate_lock, such as FS.InlineBulkStatus in afs_do_lookup(), can update
inode->i_size and clear AFS_VNODE_DIR_VALID in between:

CPU0                                  CPU1
afs_read_dir()
  afs_read_single()
    ... (allocates d_size, dirties inode)
                                      afs_do_lookup()
                                        ...
                                        afs_vnode_commit_status()
                                          write_seqlock(&dvnode->cb_lock)
                                          afs_apply_status()
                                            afs_invalidate_dir()
                                            i_size_write(inode, new_size)
                                          write_sequnlock(&dvnode->cb_lock)
  set_bit(AFS_VNODE_DIR_VALID, ...)
  downgrade_write(&dvnode->validate_lock)
                                      afs_dir_writepages()
                                        ... (d_size < i_size)
                                        netfs_writeback_single(..., i_size)
                                          WARN_ON_ONCE(iov_iter_count(iter)=
 < len)

Also, afs_inode_init_from_status() sets AFS_VNODE_DIR_VALID on new directory
vnodes before the directory is read.  During the first afs_read_dir(),
netfs_read_single() marks the inode dirty before afs_do_read_single() runs
afs_dir_check(); if afs_dir_check() fails, afs_read_dir() jumps to
error_unlock with AFS_VNODE_DIR_VALID still set and AFS_VNODE_DIR_READ
clear, so afs_dir_writepages() will write the corrupted buffer into fscache.

[ ... ]

> diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
> index c18e4f8064234..b65f6c3c011ac 100644
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
> @@ -84,6 +87,7 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vn=
ode)
>  {
>  	struct afs_symlink *symlink;
>  	struct iov_iter iter;
> +	unsigned int alloc_flags =3D 0;
>  	ssize_t ret;
>  	loff_t i_size;
> =20
> @@ -94,17 +98,15 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *=
vnode)
>  	}
> =20
>  	if (!vnode->directory) {
> -		size_t cur_size =3D 0;
> -
> -		ret =3D netfs_alloc_folioq_buffer(NULL,
> -						&vnode->directory, &cur_size, PAGE_SIZE,
> -						mapping_gfp_mask(vnode->netfs.inode.i_mapping));
> +		vnode->directory =3D bvecq_alloc_buffer(
> +			PAGE_SIZE, mapping_gfp_mask(vnode->netfs.inode.i_mapping),
> +			&alloc_flags);
> +		if (!vnode->directory)
> +			return -ENOMEM;
>  		vnode->directory_size =3D PAGE_SIZE;
> -		if (ret < 0)
> -			return ret;
>  	}
[ ... ]
> @@ -249,24 +251,31 @@ int afs_symlink_writepages(struct address_space *ma=
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
> +
> +		read_sequnlock_excl(&vnode->cb_lock);
> =20
> -		if (i_size < vnode->directory_size) {
> -			iov_iter_folio_queue(&iter, ITER_DEST, vnode->directory, 0, 0,
> -					     vnode->directory_size);
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
Can afs_symlink_writepages() write uninitialized kernel memory to fscache
or pass i_size > d_size to netfs_writeback_single()?

Both afs_init_new_symlink() and afs_do_read_symlink() allocate
vnode->directory via bvecq_alloc_buffer() without __GFP_ZERO and populate
only the symlink length.  When a status update modifies a symlink,
afs_vnode_commit_status() updates inode->i_size and sets a valid
cb_expires_at while setting AFS_VNODE_ZAP_DATA rather than clearing
vnode->directory:

fs/afs/inode.c:afs_apply_status() {
    ...
		if (vnode->status.type =3D=3D AFS_FTYPE_DIR)
			afs_invalidate_dir(vnode, afs_dir_invalid_dv_mismatch);
		else
			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
		change_size =3D true;
    ...
}

Because afs_symlink_writepages() only checks vnode->directory and
cb_expires_at !=3D AFS_NO_CB_PROMISE, a larger updated i_size <=3D PAGE_SIZE
causes it to zero only [i_size, d_size) and write stale symlink bytes plus
uninitialized page memory in [old_size, i_size) into fscache.  If the server
reports i_size > PAGE_SIZE (including when afs_do_read_symlink() returns
-EFBIG after netfs_read_single() has already updated i_size and dirtied the
inode), afs_symlink_writepages() passes i_size > d_size to
netfs_writeback_single(), triggering WARN_ON_ONCE(iov_iter_count(iter) < le=
n).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D11
