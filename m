Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081086;
	b=jNT//GYnPGN78s9AgLG9mJyT2WhOVMEv+MBPXR/ThwM5MZdhIv3mUtZBI5uuWDnjlO0X
	 g9zswv3Jj4Lni1ni4ZirHvRxXOwhHO38r2+GWOn0FA1kRGXO6prrzqde4mSxnorSU1gGW
	 CALgSmaki9N2pc42EoVANOrAt+oHWRZdXrC51pWrUzibwQ/SJrJSl8CSkPTXY8qdKFVRa
	 KsNCCKdkbAEBZ/Bm5+svX4sFl4eKPt+UuOY5ASBHnf+acLRwqk4C5QCEcJ90bPnI0EtxT
	 v24lRFaYQN8vCn8RLG/tFQS33DbFQWW5iXS9iwPJisuBTofdX2hfvDn9Ysp3RW9yamQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jUPDR8MZ5wkne5tIr3FSNwBJVcdr7eN/6K9LMWg7q6g=;
	b=IvXdrXMe2+RdzsQ28YuTuF25e9t0keXNLY4m3w2ekclp8yrE+xnrEzX8tgxaApVn9cBc
	 f78BQOqwhf+dCgUhH53i9n6f1ffGL/ETRb2CJlBecWYtrxlCot/e/Qxvskr2CMFzwq6GQ
	 0ooYo4qe6hAGDK4hy+BzrmWZMF76TGskwfGHpSZh+HKp5MhwA1M3Uc0ovrMNcTUmmpPTS
	 ZDCFN0UtlK/sKBk7cjn87jFbCQGKno2AYqlAwfkQdaGp0LiKAdwtAwP2MdUv7YVj+Va5H
	 x5Id+ADH/kbelNvdcJz/jYLFas3l1pMDwwBB/SwDVvXHdmj1Do0oO6yspXNfN7pUcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtUD28Nv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C89606A33A
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtUD28Nv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6C51F000C4;
	Thu, 19 Nov 2026 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795081086;
	bh=jUPDR8MZ5wkne5tIr3FSNwBJVcdr7eN/6K9LMWg7q6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtUD28NvYPTH0t1ZR0xRKyIP/CsoLDHKSJpN7mON4LYIpdIbXDheISmZpUYmuyk2B
	 5zbIqv0AhcduScLrmehYfw3pX1mpS6fGeAhKNAvIGWPcQNkVVO7CviJpccEE8cAxTE
	 bwZQsyYnJrXO+TgX3lPcE+0mZjjKx3x6DbCf7qfs3Tr0vvDk44Z4ruthymlf0YaeUI
	 UXH7PwdRulS5+RlJz9lVm1nY5uO016PXOeBxOHGiy9mgTOF69E2SfK6fRUloOUFBr9
	 wwvqdxposJpeQcuthvi27At7INK9EOY1wW3Drk0uAYv9YII6OW2Kw73iSgsGH4IoGH
	 5AR9iuHmx+erw==
Message-ID: <sashiko-outbox-222862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 14/17] netfs: Switch folioq to bvecq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261119083851.3306418-15-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-15-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:38:05 +0000
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
- [Critical] netfs: NULL pointer dereference in
  netfs_read_to_pagecache()
--

commit 8e713b4a482fc07f13d650f4826e027df83215a0
Author: David Howells <dhowells@redhat.com>

netfs: Switch folioq to bvecq

This commit switches netfslib from using folio_queue to using bvecq for
holding lists of folios during buffered reads and writeback.

> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 69e68ef0652a7..852b2cb73435c 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
[ ... ]
> @@ -275,11 +277,14 @@ static void netfs_read_to_pagecache(struct netfs_io=
_request *rreq)
>  		.cached_to[1]	=3D ULLONG_MAX,
>  	};
>  	struct fscache_occupancy *occ =3D &_occ;
> -	struct folio_queue *fq =3D rreq->buffer.tail;
> -	unsigned int offset =3D 0;
> +	struct bvecq *mark_bq =3D rreq->buffer.tail, *mark_pin;
> +	unsigned int mark_offset =3D 0;
>  	ssize_t size =3D rreq->len;
>  	uoff_t start =3D rreq->start;
> -	int ret =3D 0, slot =3D 0;
> +	int ret =3D 0, mark_slot =3D 0;
> +
> +	/* Pin the bvecq whilst we mark folios for copying to the cache. */
> +	mark_pin =3D bvecq_get(mark_bq);

[Severity: Critical]
Can this dereference a NULL mark_bq in bvecq_get()?

When netfs_read_folio() reads a dirty, non-uptodate folio created by a
streaming write, it calls netfs_read_gaps(), which sets up an ITER_BVEC
iterator in rreq->buffer.iter without initializing rreq->buffer.tail and
then calls netfs_read_to_pagecache().  Because bvecq_get() does not check
for NULL before calling refcount_inc(&bq->ref), this triggers a NULL
pointer dereference (unlike the loop below, which checks if (mark_bq)).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D14
