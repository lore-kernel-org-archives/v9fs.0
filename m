Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442012;
	b=BFsTy4PctIi/8iVf1D7kwnV0YlVGzXd+R5LdQ/Vm2b4zqyCu+vGr6CG1+JGKtakJe5so
	 FmqQq/r4TrsR5o37YPUmMYjMsqHyeafoacBZj8RcM7IBVu9DB8rSGK93Bvz2ow8iPlBwc
	 GQQJoxx8HvywAYVOaD6tSJ2UDB072G+af1cw3ThMKCNDTF3LICvcZPQU7nM5KVsnhgAWD
	 tz4nADKooRZjHFzzEY+GtSEGlUnl4BQvQafN78ql5MuQ0UsFbdQGJogMaoGxnarDJKt5q
	 4yvbEAWTlhlO2h1GNqG2so2SAQ8uj7Frmj8m3FI4A8Oob6ifewcgSsid5Pa0OAbCcIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0bmp433TaDo6IviXUVVQ1aGDWweClHYOgkfkm/RbZao=;
	b=cc/ZzeNUY/FZl4Ol3JrQaurLsZu4s8eI7SgjQu9+CoI9Kh7gZUmgPeaRygY7Im07c+0X
	 uPfJC7JgCboHT6VznIaa3I48jMlwIQBkXlwZyTayFZwB59sALcbA7jbEpmchqdbiHOhw1
	 +p2068RYpeX5E/PiwNChgQ+66FRwKd3hMDThf8wZpdwZ40pzOLSdWF/qXODi4mBxGDeFk
	 3rFKwwcQlHIv33nuyUzxJrJgqFRqxIppS0E5ru9M4CihSwCdKvRRDRZTAdLNKRRl4xP7B
	 Li7zJBbIPrxGvPnJtA9soMb6u5tlHm9+pK428IC9XsIFrCN0vCpy8w4wwQuVkNnu18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At4XioiK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D27606A32A
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At4XioiK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7831F00A05;
	Thu, 12 Nov 2026 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442012;
	bh=0bmp433TaDo6IviXUVVQ1aGDWweClHYOgkfkm/RbZao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At4XioiKfWM9ntq/0MLgVJ3SEAhwwVzmfwac1LlJ5ANXeZY0cukM3rWKwAN+RkjuC
	 BXR2R7G970NCMGhhoy3dQYwYMV92xCRs936n+WGlCUkP3NklvmCLdYcztGCzm3EAe4
	 tPs22pUP6Pum8uVu+oRAlEhqWSISsq2fUfp/ohReKJlOg2c2uViHAlrRxEATK60swD
	 QilggvnJLbHgCQwgkrQIdZO6w/noGg67IX69zDEflT0sh0Es3kUX3MS/NtMMThYVDC
	 cehtxq9GlKjBpLGtU4lc2N9VyPu+OGayC2UxMhWIQEUp2oT4KEN8A9tU+3XRzjyLN6
	 0YI4mJnyD0vkw==
Message-ID: <sashiko-outbox-209883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/17] afs: Use a bvecq to hold dir content rather
 than folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-12-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-12-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:06:51 +0000
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
- [Medium] afs: TOCTOU race checking AFS_VNODE_DIR_VALID in
  afs_dir_writepages()
--

commit 6db299c57b12dc739490b1b98b5287a7b4f00825
Author: David Howells <dhowells@redhat.com>

afs: Use a bvecq to hold dir content rather than folioq

This commit replaces folio_queue buffers with bvecq buffers for AFS
directories and symlinks, and snapshots the directory size, inode size, and
bvecq buffer under cb_lock during directory writeback.

Link: https://sashiko.dev/#/patchset/20261107160823.1465553-1-dhowells%40re=
dhat.com

> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 51c158d8f723f..9cefd90fd4f8b 100644
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
> @@ -2236,14 +2237,21 @@ static int afs_dir_writepages(struct address_spac=
e *mapping,
>  	}
> =20
>  	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
> -		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory,
> -				     0, 0, dvnode->directory_size);
> -		ret =3D netfs_writeback_single(mapping, wbc, &iter,
> -					     i_size_read(&dvnode->netfs.inode));
> +		size_t i_size, d_size;
> +
> +		read_seqlock_excl(&dvnode->cb_lock);
> +		i_size =3D i_size_read(&dvnode->netfs.inode);
> +		d_size =3D dvnode->directory_size;
> +		directory =3D bvecq_get(dvnode->directory);
> +		read_sequnlock_excl(&dvnode->cb_lock);
> +
> +		iov_iter_bvec_queue(&iter, ITER_SOURCE, directory, 0, 0, d_size);
> +		ret =3D netfs_writeback_single(mapping, wbc, &iter, i_size);
>  		if (ret =3D=3D 1)
>  			ret =3D 0; /* Skipped write due to lock conflict. */
>  	}

[Severity: Medium]
Can afs_dir_writepages() still read a new i_size paired with an old
directory_size if a third-party status update races between the
AFS_VNODE_DIR_VALID check and read_seqlock_excl(&dvnode->cb_lock)?

CPU0                              CPU1
afs_dir_writepages()
  down_read(&dvnode->validate_lock)
  test_bit(AFS_VNODE_DIR_VALID, ...)
                                  afs_vnode_commit_status()
                                    write_seqlock(&dvnode->cb_lock)
                                    afs_apply_status()
                                      afs_invalidate_dir()
                                        clear_bit(AFS_VNODE_DIR_VALID, ...)
                                      netfs_write_sizes()
                                        i_size_write(..., status->size)
                                    write_sequnlock(&dvnode->cb_lock)
  read_seqlock_excl(&dvnode->cb_lock)
  i_size =3D i_size_read(...)
  d_size =3D dvnode->directory_size
  read_sequnlock_excl(&dvnode->cb_lock)
  netfs_writeback_single(..., i_size)
    WARN_ON_ONCE(iov_iter_count(iter) < len)  <-- i_size > d_size

When afs_apply_status() processes a third-party directory change under
cb_lock without holding validate_lock, it clears AFS_VNODE_DIR_VALID and
updates inode->i_size to the new server size, while leaving
dvnode->directory_size and dvnode->directory unchanged until the directory
is later re-read.  If the directory grew on the server beyond d_size,
netfs_writeback_single() hits WARN_ON_ONCE(iov_iter_count(iter) < len) and
fails with -EIO; otherwise it writes the invalidated buffer with the new
i_size to the cache.

Re-checking AFS_VNODE_DIR_VALID inside the cb_lock critical section would
ensure i_size and directory_size come from a valid, consistent state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D11
