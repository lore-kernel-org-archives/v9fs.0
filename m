Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079702;
	b=NuC3zIF3ilHeo2+itccMIt6Tkg7gvY/Ls2gq2mVWV3K9DhGxpzl3tRwYLaX7y+DIWBpj
	 klpvovWgqaTNXqcKdRgDFBVfWB3VGTGUKgMBdwocBdO1shZXV1l4eOzzYyQY9uHkMdYRz
	 8Kv36k8UzuAA9ISDQNpM/1VzXC8jATID13vdajnZcaOxxaq6RQIMauc0stJ3fkwszGkM3
	 +Ct6ZS2Hb3sTLEYpYG04jEg3XTlQkwZa5eQpCeTrXWthsWUqMBI0vQVNN29GADRpQWL75
	 5r3PVj7NlXooTSdi4P6aQOu/NCrZsavKz/nikFyOoems4+EVOgWFolbppW25yXENTJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=novx6xdNMcGe0gQv4Z/P1HWr0DijOUl+uoYSQAtsFfc=;
	b=GawjzlSNw5Rk3EUUG3K4PfNcLkaNj+MHpIU0aLsoaaqZAijj38jF8HIdRamgWfnC+d/0
	 UiiZLR27fXb6z1Ay8BWTaVKCPLBWLE3byrxKph/w8rvkQ1T+Qs+dhn1HUStbz5W2DliYd
	 zcL8W2CNS3uGzMNNDoi0EGQ55DHZRNjBnCu3KwkgLfVOLTH4qhN5vWyKU6cAa/oxfMZgp
	 i6lgyP2wgSMwhNNN6OwcrCnGEkG2MgUFaxPGQvytDEIPX88S00+bhcyRcfzNstpqnXSib
	 1qGycEebFJ916s4ubHbH5u8KIexnCLLxQrota3JWLm8UWfLmzvOh0XLascM7ooqUJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqL6LqoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD27606A331
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqL6LqoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC71F000C6;
	Thu, 19 Nov 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079701;
	bh=novx6xdNMcGe0gQv4Z/P1HWr0DijOUl+uoYSQAtsFfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqL6LqoQzbM3nkKUpCWeSAEjegcP3MH7HGs8CCCMfiiurnsBfkUq34nqfyKwMjT2H
	 /MatSjxc/0E5QCj6zxBEDSQQkbSpdTxT/r4q5WNg2JJ+CA2BX5Ss79ZNTONw0T3Nz0
	 LMcVDFrh9vCrIW2dSJYgujxnPOKreEMyW/7ggtKXMgams/0DT0iM7s6du4JcW8Yq3k
	 cqOKMtOyRXQ/Ucmga4kSvdvA+1G/kCf8j3h4qKUBuH+RGpTer/7unkN8kY3EJxXmRv
	 3OjxHJinZtCzprf4GIlulbCq3dFy5jz+omeoSilqIUQh66gW/3NzgEeH/XHG+SRNXi
	 QNdh9XrGmOcrA==
Message-ID: <sashiko-outbox-222801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/17] netfs: Explicitly pass tail padding to
 netfs_writeback_single()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-9-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-9-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:15:01 +0000
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
- [Medium] afs: uninitialized cache write or WARN in
  afs_symlink_writepages()
--

commit 95ee548dcf53267f4aa069e5911e552ec816490b
Author: David Howells <dhowells@redhat.com>

netfs: Explicitly pass tail padding to netfs_writeback_single()

This commit updates netfs_writeback_single() to take an explicit content
length alongside the buffer iterator and updates AFS directory and symlink
writeback to clear tail padding in the buffer.

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
> =20
>  	if (ret =3D=3D 0) {

[Severity: Medium]
Can afs_symlink_writepages() write uninitialized kernel memory to fscache
or trigger WARN_ON_ONCE(iov_iter_count(iter) < len) in
netfs_writeback_single() if the symlink's server status size grows before
writeback runs?

Unlike afs_do_read_single() and afs_dir_get_block(), afs_init_new_symlink()
and afs_do_read_symlink() allocate the PAGE_SIZE vnode->directory buffer
without __GFP_ZERO, populate only the initial symlink length, and mark the
inode dirty.  If a status fetch (such as afs_getattr() or
FS.InlineBulkStatus) observes a larger size on the server before writeback,
afs_apply_status() updates inode->i_size and afs_apply_callback() sets a
valid cb_expires_at without freeing vnode->directory (or during
afs_do_read_symlink(), FS.FetchData updates i_size > PAGE_SIZE and marks
the inode dirty before returning -EFBIG).

When afs_symlink_writepages() then reads the updated i_size, a new size
between the populated length and PAGE_SIZE advances past the unzeroed gap
and writes those uninitialized bytes to fscache.  A new size above
vnode->directory_size (PAGE_SIZE) skips zeroing and passes len >
iov_iter_count(&iter) to netfs_writeback_single(), hitting WARN_ON_ONCE()
and returning -EIO without freeing vnode->directory.  Passing __GFP_ZERO
when allocating the symlink buffer and invalidating or clamping against
vnode->directory_size when status changes would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D8
