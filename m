Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435467;
	b=lBsYnXlK/Lm2x6kDX3T6Ts4qmH3AWeQ0WEPRsuMFVayOaHLXSXXo1tsNETLYla0gfJeZ
	 Zq8bT9Gc7fF+Q3bSEZEIpnuThM+uo8+qTLb17NccNHZW72IjXRbbULqijF9F2PugjATWn
	 5KLcsLgN2v8X7CmdV/3+C66VNb5MoJB6tGon23zw9HUjcSaiVo46xJhJCmzq6Vf4txjpJ
	 CBqd4PMmyE67UNAfLW+IxlWxJCjEOOpf23gfVxtnAqyNXlenusrVjs9gs5dM+1SBuTWKp
	 smisefKGI/l7bB9XY+Ih4FpveeVKH5Xet8Wy6BAzdBaa5pp7+32YJHGFXuchh9pfiYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GY10JfC1cfZ5rkupC0drmGiIKb7kkjISbKkgJwA2YHU=;
	b=LAk4MQWQyPgGzoH+2bm5V0y3ghtct8xhBOq2CeqW0IM2ira5ZZr2Jk/ki0sfV316katO
	 E2WgJUIkzDb5n78ggsAajAYxYIYYphxe4AiGpjGjt+ovcr9sIi/dWlwFI4hES71b+i0YU
	 6HXWKMGX98CDKmHw5HUDMwjTrHttGQTalIQ8972dwPQrdvxagtHKkGi2nE+j5sHmCfpuX
	 Loju5fzfPr/grgF6tquTNwRv6IbhowOdaBYfPSRdwLEMUAAptYfI8W7lgQgmsu5995k9F
	 W4c416BWr8rbpEjZRLmdZCuNlPyL9/SxzDaSUiQ+BWzrRH9YykNGR+tpvcpXamO01yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7co2xck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F0606A321
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7co2xck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3EB1F00A05;
	Wed, 11 Nov 2026 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435467;
	bh=GY10JfC1cfZ5rkupC0drmGiIKb7kkjISbKkgJwA2YHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7co2xck4hA6TQBtbC96D+8eUeuKqgpe1sWK0cyF4Z+kW9p/dizHgH5ywloVpv3Ei
	 JnJErcz2Cftyip+vXBrHN2REDjMeiGUO/LrNpmUitNjfp3X7u5naFa3t08Nab8JExQ
	 nZQiX8Mp/21lbMxIOLR/zZIhDpVMEHbR1WEtWWl/oWhKFJmWAcfMangwZMYWcVXmnC
	 XUb1xgc/KeGJg8r5EPd79lU7CJhVDE8yPTBo4rj3TALXKqBMEb8PnBSbw2bObsywEB
	 FCB3piLU+WasCcZxXLqJpdc6auqvlZVIY7lSArtT7gjuvXYzF5glQSZE+O8wCmIIFB
	 dMYPH7GxZAd8Q==
Message-ID: <sashiko-outbox-209778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/17] netfs: Add some tools for managing bvecq
 chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-5-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-5-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:17:46 +0000
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
- [High] netfs: mempool deadlock in bvecq_alloc_chain() when
  for_writeback is true
--

commit e5b9a085f1bcfd322d1044543745cbe0c1ae3076
Author: David Howells <dhowells@redhat.com>

netfs: Add some tools for managing bvecq chains

This commit adds helpers for allocating, populating, refcounting, and
freeing bvecq nodes and chains, along with an emergency mempool for
writeback allocations.

> diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
> new file mode 100644
> index 0000000000000..1d4da3de9b9d2
> --- /dev/null
> +++ b/fs/netfs/bvecq.c

[ ... ]

> +struct bvecq *bvecq_alloc_one(size_t nr_slots, gfp_t gfp, bool for_write=
back)
> +{
> +	struct bvecq *bq;
> +	size_t size;
> +	bool from_pool =3D false;
> +
> +	/* Don't overrun ->max_slots or ->nr_slots. */
> +	if (nr_slots > BVECQ_MAX_INLINE_SLOTS)
> +		nr_slots =3D BVECQ_MAX_INLINE_SLOTS;
> +
> +	size =3D kmalloc_size_roundup(struct_size(bq, __bv, nr_slots));
> +	gfp &=3D ~(GFP_ZONEMASK | __GFP_THISNODE);
> +
> +	if (for_writeback) {
> +		if (size !=3D BVECQ_POOL_SIZE) {
> +			gfp_t gfp_temp =3D gfp;
> +
> +			gfp_temp |=3D __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> +			gfp_temp &=3D ~(__GFP_DIRECT_RECLAIM | __GFP_IO);
> +			bq =3D kmalloc(size, gfp_temp);
> +			if (bq)
> +				goto success;
> +		}
> +
> +		bq =3D mempool_alloc(&netfs_bvecq_pool, gfp);
> +		if (!bq)
> +			return bq;
> +		from_pool =3D true;
> +		size =3D BVECQ_POOL_SIZE;
> +	} else {
> +		bq =3D kmalloc(size, gfp);
> +		if (!bq)
> +			return bq;
> +	}
> +
> +success:
> +	*bq =3D (struct bvecq) {
> +		.ref		=3D REFCOUNT_INIT(1),
> +		.bv		=3D bq->__bv,
> +		.inline_bv	=3D true,
> +		.max_slots	=3D min((size - sizeof(*bq)) / sizeof(bq->__bv[0]),
> +				      BVECQ_MAX_INLINE_SLOTS),
> +		.from_pool	=3D from_pool,
> +	};
> +	netfs_stat(&netfs_n_bvecq);
> +	return bq;
> +}
> +EXPORT_SYMBOL(bvecq_alloc_one);
> +
> +/**
> + * bvecq_alloc_chain - Allocate an unpopulated bvecq chain
> + * @nr_slots: Number of slots to allocate
> + * @gfp: The allocation constraints.
> + * @for_writeback: True if allocating for writeback
> + *
> + * Allocate a chain of bvecq nodes providing at least the requested cumu=
lative
> + * number of slots.  Each node is a maximum of 4KiB in size.
> + *
> + * Return: The first node pointer or NULL on allocation failure.
> + */
> +struct bvecq *bvecq_alloc_chain(size_t nr_slots, gfp_t gfp, bool for_wri=
teback)
> +{
> +	struct bvecq *head =3D NULL, *tail =3D NULL;
> +
> +	_enter("%zu", nr_slots);
> +
> +	for (;;) {
> +		struct bvecq *bq;
> +
> +		bq =3D bvecq_alloc_one(min(nr_slots, BVECQ_4KB_SLOTS), gfp, for_writeb=
ack);
> +		if (!bq)
> +			goto oom;
> +
> +		if (tail)
> +			bvecq_append(tail, bq);
> +		else
> +			head =3D bq;
> +		tail =3D bq;
> +		if (tail->max_slots >=3D nr_slots)
> +			break;
> +		nr_slots -=3D tail->max_slots;
> +	}
> +
> +	return head;
> +oom:
> +	bvecq_put(head);
> +	return NULL;
> +}

[Severity: High]
Can bvecq_alloc_chain() deadlock on netfs_bvecq_pool when for_writeback is
true and gfp permits direct reclaim?

Under memory pressure, bvecq_alloc_one() falls back to
mempool_alloc(&netfs_bvecq_pool, gfp), which yields a 512-byte node holding
BVECQ_POOL_SLOTS (29 slots on 64-bit).  bvecq_alloc_chain() loops calling
bvecq_alloc_one() while holding previously allocated pool elements in head.

Because netfs_bvecq_pool has 100 elements, a single chain requesting more
than 2900 slots (~11.3 MiB of 4 KiB pages) or concurrent writeback threads
building chains at the same time can exhaust the pool midway through the
loop.  Each thread then sleeps in mempool_alloc() waiting for elements to
be freed while pinning the elements already attached to head, before any
I/O can be submitted to release them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D4
