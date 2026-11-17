Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938323;
	b=x9UydNN3gap9XTaPqHeorVfsS0GgvpUajXdNDYakiL6VLPV/F4BFhbmAWr4ZKOKmeCQv
	 jJeHDj4Os1uAPLxUatmQyjGBV6+Y5lct3RbMPXA8OE65D/AeXRo/938FZ/CT7E7IhT+jL
	 K/cvrHUyhHpKPNbnZx6oqxKMZhWzlogKV8WxNkhgaNixecWVNa8k4d7gYhGEWtgLJqDJl
	 /sE4FFhkhCHFRbEgz9+cDBtxzxJ5D9x3oc8KERvBY13KGibQ/RU1JJX+Dzr26ebHFWoK+
	 /TqsR3xpyQsAxNeMA7fXewo1g4T22HjH5desGPyJkdXPNCvlXmO3mZ71vjDkMF9tpxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c9tftNEaeXvHnmJ3S584HudlHuKuvQkEEbxuvFloGuM=;
	b=heGpIiM8ssgNFdL/0Po2bHMwLKM3Ia75Bv7wzPj9FB2cL+MjsQIa5oEmP+bVaYFtOHQt
	 GBMHfcpt+/f2j1hcpQJ8+XcXIyDPfMzUciPEUDOY/WFByd/ZHtn2zs/GmDH8R0OpUJF2w
	 CON4nCSkcLso/GdtOXsXZBdsrLcpuwa8UkPwjXHGqOiijMAmvYAZnYBJs4l3TWXYGB7tP
	 ib1wotOuPJV9dGD4mbL7MHUy3wG2iddZ21k2TOL0ZbGzptZv5VhoiyVtMR1LWOzi/9Aqk
	 g722/jSxrHzQnW4diHObwWOkdaQHYHabrD87c5mQyqbYZQ3sSvUjKZ+2rfd0wHDXumw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX8b1P6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AD606A332
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX8b1P6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC11F000C4;
	Tue, 17 Nov 2026 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938323;
	bh=c9tftNEaeXvHnmJ3S584HudlHuKuvQkEEbxuvFloGuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KX8b1P6KHbvyf4OP2SRCy8cEurCp0CvDJVz1oXgch/s6xIxJDlwJ57i4cr1HqAxMA
	 qSM+r0/RNVg4SzQ8JeXi8oLHodp8XjsxNnfPz03PIMppfd5uFffZC8gkp0Ym2WsKee
	 vhOW/C1AA+B0FL1cQY8eDfUCYBrC/e7IzVCZpdSzBAEk4h2Y/oJaei5UN/sPwl1Wr+
	 /E7Cfq8fQ/ay5df67mvMRn5QZM4oAPEf9GWFRqwbtXEuSix5yboy6uiOzJXMHWAFeW
	 TPrpyKeXzimnHvCSern6AnvQINckkvs3+I/XfQLA3viez3evGiZq9uBjTjxkdC6Lv+
	 O/Slu9Pup0hOw==
Message-ID: <sashiko-outbox-219298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 08/17] netfs: Explicitly pass tail padding to
 netfs_writeback_single()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117171958.2982801-9-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-9-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:58:42 +0000
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

commit 9928f42420a3a1a108161f6c7830b8d72274c828
Author: David Howells <dhowells@redhat.com>

netfs: Explicitly pass tail padding to netfs_writeback_single()

This commit updates netfs_writeback_single() to accept an explicit content
length separate from the full buffer size in the iterator, and updates AFS
directory and symlink callers to zero tail padding beyond the content lengt=
h.

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
Can afs_symlink_writepages() write uninitialized memory to fscache or
trigger the WARN_ON_ONCE(iov_iter_count(iter) < len) check in
netfs_writeback_single() if the symlink's status is updated on the server
before writeback runs?

Both afs_init_new_symlink() and afs_do_read_symlink() allocate the
PAGE_SIZE buffer in vnode->directory without __GFP_ZERO and populate only
the initial symlink length.  If a third party modifies the symlink and a
status fetch runs before writeback, afs_apply_status() updates
inode->i_size to the new size while afs_apply_callback() renews
vnode->cb_expires_at, without freeing or invalidating vnode->directory.

When afs_symlink_writepages() then reads the larger i_size, it advances
past the uninitialized gap between the old and new sizes and writes those
uninitialized bytes into fscache, or passes i_size > vnode->directory_size
to netfs_writeback_single().  The directory counterpart is fixed later in
the series by commit "afs: Use a bvecq to hold dir content rather than
folioq", which checks AFS_VNODE_DIR_VALID under dvnode->cb_lock, but
symlinks remain affected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D8
