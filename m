Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439075;
	b=xjiDT0cmzpEWx66r+V9NEzq2I/W/LB7hIOlTY6WX78CGSA7EH0Iux8nqtAlFeeVixbAh
	 qK9vof73IYxzQHsLFYbJ9soMOR76Pd7969mP46ih7X2mLwP+jYB6r+Vwgbh0Yd8g1+QtG
	 Z4IswtiIuWThxnREuAVMrV//yK4IrwzoVJqBJYvcOdbmvdtMhLStCOEKT4J0i30ugiajV
	 7hkJ06eD3SKOp4t/tCWFd1Opu2d7lKbwRqbZ93ElxulO8cgxrKJmckD6jbyq3QHbAnfTR
	 VkeUU/byXpT/Fs5vxF5jXVDp5m5fBPlxNwpRPGDfl7zgSdOkpWRm671yl4W9L6eb0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439075;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wwS+9hrK+VO+wZ83iTKEXsy1fjFNGF5ncpuBApm2pug=;
	b=Pyo6cp3XuzAN/Vc8yCH8+IWHZycvNHIbZexqYgi+2LHJ00Sa6VdZpyd5wZ4ScwtnJq8+
	 VcODh/i39X1Pmb3YSeTfliqcjxcA70zLTaSfhPRPWLkHaqpESht0KGnHAjVPU/aUgp/th
	 oPl4kl9qRss0Z5LM+h0ZEVaHWe1fwU/PduZmo7JwrDk1CUtgYq+vX+X0gRhlAv7mut68C
	 Gz5qjZtNLtsdUtlLD6jr41giVQ6e/A2dyDnqdKXThrSytGV5F6DKLVfHOGO0WFyXcQhvH
	 eex8LrQiebQtk1w+HQfveOTaZ2ZFB2gAPNalqDXvy9n+mx/owyoCvqCx3ceD2zNkvaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjI79rjU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB1606A32D
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjI79rjU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D11B1F00A05;
	Wed, 11 Nov 2026 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439075;
	bh=wwS+9hrK+VO+wZ83iTKEXsy1fjFNGF5ncpuBApm2pug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjI79rjUHgscZ2eZRR7YFi08mXuopPhcs0n+puXgmZD9s2vKcUwC4vZy4PZoNix0a
	 HNMmnab0yLunayIni9dFzyXDAD0SeEzAtuiLuVtH90wffUhwMd8JrmIxpohX1znZha
	 9sDo+N6pUj4OJDJNH6aKITXLBYuVEOUGuLH/3ljrrwgujXHDvQSPq8Xz0yerYqZn/d
	 /Pi+krqH4kG4Z0/Zmd1x1Lcw3NuMaLVwyL9KfQuhfludhnd5YUiryq9GB8sSP5swHX
	 bPg2L0ZYPRaZyHARhrIZ8jj0qlGu0dInMrHZ6QXwQZMlK36e2hOWAduZ51PSfBLtLn
	 UBbPlqlgL3PYg==
Message-ID: <sashiko-outbox-209850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/17] netfs: Explicitly pass tail padding to
 netfs_writeback_single()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-9-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-9-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:17:54 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] afs: i_size exceeding directory_size in writepages triggers
  WARN_ON_ONCE()
--

commit e4f5c0122c57e02637340e7c5e9b182a6f565f23
Author: David Howells <dhowells@redhat.com>

netfs: Explicitly pass tail padding to netfs_writeback_single()

This commit adds an explicit content length parameter to
netfs_writeback_single() so the caller provides a padded buffer via the
iterator while specifying the actual content size separately, and updates
AFS directory and symlink writeback to zero tail padding and pass both
sizes.

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
> diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
> index a1dbd552ddff0..c18e4f8064234 100644
> --- a/fs/afs/symlink.c
> +++ b/fs/afs/symlink.c
[ ... ]
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
> =20
>  	if (ret =3D=3D 0) {
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index b8237e1314d8a..e041023811ed0 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
[ ... ]
> @@ -747,26 +747,33 @@ static int netfs_write_folio_single(struct netfs_io=
_request *wreq,
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

[Severity: Medium]
Can i_size exceed directory_size in afs_dir_writepages() or
afs_symlink_writepages() and trigger the new
WARN_ON_ONCE(iov_iter_count(iter) < len) in netfs_writeback_single()?

In afs_dir_writepages(), dvnode->validate_lock is held shared while
checking AFS_VNODE_DIR_VALID and reading dvnode->directory_size and
inode->i_size.  A concurrent RPC completion such as
afs_do_lookup_success() calls afs_vnode_commit_status() ->
afs_apply_status() under cb_lock and i_lock without holding validate_lock.
If a third party grew the directory on the server beyond
dvnode->directory_size, afs_apply_status() clears AFS_VNODE_DIR_VALID and
updates inode->i_size without updating dvnode->directory_size:

CPU0                              CPU1
afs_dir_writepages()
  down_read(&dvnode->validate_lock)
  test_bit(AFS_VNODE_DIR_VALID, ...)
                                  afs_vnode_commit_status()
                                    afs_apply_status()
                                      afs_invalidate_dir()
                                        clear_bit(AFS_VNODE_DIR_VALID, ...)
                                      i_size_write(inode, status->size)
  iov_iter_folio_queue(...,
    dvnode->directory_size)
  netfs_writeback_single(...,
    i_size_read(...))
    WARN_ON_ONCE(iov_iter_count(iter) < len)  <-- triggers warning

Even after commit "afs: Use a bvecq to hold dir content rather than
folioq" later in this series reads i_size and directory_size under
dvnode->cb_lock, test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) is still
checked before acquiring cb_lock, so the same race window remains.

Similarly, afs_do_read_symlink() allocates vnode->directory to PAGE_SIZE.
If the server returns a symlink status with size > PAGE_SIZE in
netfs_read_single() (or a concurrent status update grows inode->i_size
past PAGE_SIZE and sets AFS_VNODE_ZAP_DATA), netfs_rreq_assess_single()
still marks the inode dirty before afs_do_read_symlink() returns -EFBIG.
When afs_symlink_writepages() runs, it does not check AFS_VNODE_ZAP_DATA
or whether i_size <=3D vnode->directory_size, hitting the same
WARN_ON_ONCE() and returning -EIO (which also skips freeing
vnode->directory until eviction).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D8
