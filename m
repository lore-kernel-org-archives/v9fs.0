Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070879;
	b=Yx85DSUAU1o3o1tx78cgNnWhX8aKkKwT10B7NQr/4n2U74tID/urR8o6rqxzZhKvOH8J
	 AXajCtf2JNP8HUSSpBqyDXq0xGv3KatKukVStH84jRu5LyWYHOdMeqG1SB6b3uS+b3Mw0
	 iyb4yGhagUd+wk+qR3fDseUm2xjinoUHf8rZ8Pc6XjniUiXaWt9n9jZECyfEyOwkGRhfM
	 RkFxpiAmymDZYOJgjOiMnCJcK3VGsv2qzbeO48YDnTEJrRbStvmM9vVX3vhtxqmlmCHv4
	 RyP5Kqg/qmVjjmSZo4DraFn4isPxaaG6LXKj/roWx6E+MKibmxpG18KAY3J/QGvTAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/6HMiNiabAcjnQzYdxDn1F0FLzhfWw8pv6Z9yfXZarY=;
	b=CVKGpt4PWb6zZs8dZCGZxJWpCARAkuGAMCU8NuerqmN+NRaalvTCoQr2dd+8C5biMqhO
	 thi/Cuyoi3qcbyj+80H67EhfJdSOxCQFABH7eNqACU7Wzepdv4oFyWc+vmqY7fopA+IQ7
	 4DR4/cgm+GiRWtYZc5zm08Z/C8AyyJyrXT2tIrrorDPxvV3fRKSFUr+VUUlNOAcnrqJzv
	 8SzwryC02BJwDeHs+6eWuLxGMG4sImzCurc5onfKkQxCaMYEHhnae8BqbynVM/v99+kV0
	 hRNdTbL2HK0N9cN+f7nfoiypjwfOq34P1fzkHAXCW9tJTETBJ4v/V74BYQ511PINJXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8TbMD1u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DF606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8TbMD1u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A01F0089F;
	Sat,  7 Nov 2026 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070878;
	bh=/6HMiNiabAcjnQzYdxDn1F0FLzhfWw8pv6Z9yfXZarY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8TbMD1uZS5n1mrFAejUHEitMgGy0tOg9YHkJCNUwfxyQHKdzt4qF+vLB2UjU1OVM
	 8rvoeXGBoe8CaYVziXKp5rJFaIsIayn/rL3Uhs3W9QG4jSAr6MSN8DTYqlHu3yLzOb
	 i9obi+fea4LQI2YzFG0ED6l1GLclbmlwz0JrAV/8wTQdXfd8uh1tavmmwG8vx/7FwD
	 wgWgR6YY7JKx8+B29Gc91TM7HVx6W5ypKbI2BB2EypY5LY5P5rupKTEf3ZOnjcXsoL
	 8LW3s19n4sXulGB39B9P+JG97SgbOBkit2axF111GjwuZ65jGh2wyO4nLIblhnz6kn
	 JwBaeyvkhbIbQ==
Message-ID: <sashiko-outbox-203082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/15] iov_iter: Add a bvecq kunit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261107160823.1465553-6-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-6-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 17:01:17 +0000
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
- [Medium] iov_iter: kunit_bvecq marks test functions __init with
  kunit_test_suites()
- [Low] iov_iter: folio leak and unchecked action registration in
  kunit_bvecq
- [Low] iov_iter: bvecq_kunit_advance() bounds revert steps by left
  instead of pos
--

commit 078e4c29ad244b5b9e915f77ff2e3db4692905e6
Author: David Howells <dhowells@redhat.com>

iov_iter: Add a bvecq kunit test

This commit adds a KUnit test suite for the bvecq iterator covering advance,
revert, copy-out, iov_iter_npages(), and iov_iter_alignment() across various
bvecq chain recipes and partial folio configurations.

> diff --git a/lib/tests/kunit_bvecq.c b/lib/tests/kunit_bvecq.c
> new file mode 100644
> index 0000000000000..7cdd455df6929
> --- /dev/null
> +++ b/lib/tests/kunit_bvecq.c
> @@ -0,0 +1,599 @@

[ ... ]

> +static void __init iov_bvecq_alloc_folios(struct kunit *test)
> +{
> +	struct folio *folio, **folios =3D bvecq_kunit_folios;
> +	const int nr =3D ARRAY_SIZE(bvecq_kunit_folios);
> +
> +	bvecq_kunit_pagemap_nr =3D 0;
> +	memset(bvecq_kunit_pagemap, 0, sizeof(bvecq_kunit_pagemap));
> +	memset(bvecq_kunit_folios, 0, sizeof(bvecq_kunit_folios));
> +
> +	for (int i =3D 0; i < nr; i++) {
> +		folio =3D folio_alloc(GFP_KERNEL, bvecq_kunit_orders[i]);
> +		KUNIT_ASSERT_NOT_NULL(test, folio);
> +		folios[i] =3D folio;
> +
> +		/* Fill each subpage with a different but predictable pattern. */
> +		for (int j =3D 0; j < folio_nr_pages(folio); j++) {
> +			u8 *p =3D kmap_local_folio(folio, PAGE_SIZE * j);
> +
> +			for (int k =3D 0; k < PAGE_SIZE; k++)
> +				p[k] =3D bvecq_kunit_pattern(i, j, k);
> +			kunmap_local(p);
> +		}
> +	}
> +
> +	kunit_add_action_or_reset(test, bvecq_kunit_release_folios, folios);
> +}
> +
> +/*
> + * Follow the specified recipe to allocate a bvecq chain and stick the f=
olios
> + * and empty gaps into it.  Further, the offset into and length of each =
folio
> + * is adjusted from the partials list.  Each ALLOC command will append a=
 new
> + * bvecq to the chain and move to filling that.
> + */
> +static struct bvecq *__init bvecq_kunit_load_chain(
> +	struct kunit *test,
> +	const struct bvecq_test_recipe *rec,
> +	const struct bvecq_test_partials *parts,
> +	size_t *size)
> +{
> +	struct bvecq *head =3D NULL, *bq =3D NULL, *p;
> +	size_t pos =3D 0;
> +	int folio_index =3D 0;
> +
> +	*size =3D 0;
> +
> +	for (; rec->cmd !=3D BVECQ_KUNIT_STOP; rec++) {
> +		if (!head)
> +			KUNIT_ASSERT_EQ(test, rec->cmd, BVECQ_KUNIT_ALLOC);
> +
> +		switch (rec->cmd) {
> +		case BVECQ_KUNIT_STOP:
> +			break;
> +
> +		case BVECQ_KUNIT_ALLOC:
> +			p =3D bvecq_alloc_one(rec->count, GFP_KERNEL, false);
> +			KUNIT_ASSERT_NOT_NULL(test, p);
> +
> +			if (!head) {
> +				head =3D p;
> +				kunit_add_action_or_reset(test, bvecq_kunit_bvecq_put, head);
> +				bq =3D p;
> +			} else {

[Severity: Low]
Does iov_bvecq_alloc_folios() leak already-allocated folios if folio_alloc()
fails after the first iteration?  KUNIT_ASSERT_NOT_NULL() aborts the test
before kunit_add_action_or_reset() is reached, and
bvecq_kunit_release_folios() passes the full array size to release_pages(),
which cannot handle NULL entries in a partially populated array.

Also, neither iov_bvecq_alloc_folios() nor bvecq_kunit_load_chain() checks
the return value of kunit_add_action_or_reset().  If action allocation fail=
s,
the cleanup callback runs immediately to free the folios or head bvecq while
the test continues, causing a NULL pointer dereference or use-after-free.

[ ... ]

> +		/* 3 steps forward. */
> +		part =3D min(left, 3);
> +		iov_iter_advance(&iter, 3); /* May be short. */
> +		pos +=3D part;
> +		left -=3D part;
> +		bvecq_kunit_check_next(test, &iter, &pos, &left, 3);
> +
> +		/* 2 steps back */
> +		part =3D umin(2, left);
> +		iov_iter_revert(&iter, part);
> +		pos -=3D part;
> +		left +=3D part;
> +		bvecq_kunit_check_next(test, &iter, &pos, &left, 2);
> +
> +		/* 1 more step back */
> +		part =3D umin(1, left);
> +		iov_iter_revert(&iter, part);
> +		pos -=3D part;
> +		left +=3D part;
> +		bvecq_kunit_check_next(test, &iter, &pos, &left, 1);

[Severity: Low]
Should these two revert steps clamp against pos (or size - left) rather than
left?  left is the unread byte count remaining ahead, so when the forward
advance and check reach the end of the iterator (left =3D=3D 0), both rever=
ts
become 0-byte no-ops instead of rewinding.

[ ... ]

> +#define TEST(CHECK, PARTIALS, RECIPE) \
> +static void __init bvecq_kunit_##CHECK##_##PARTIALS##_##RECIPE(struct ku=
nit *test) \
> +{ \
> +	bvecq_kunit_##CHECK(test, \
> +			    bvecq_test_recipe_##RECIPE,	      \
> +			    bvecq_test_partials_##PARTIALS);  \
> +}
> +
> +/* Emit test stub functions. */
> +ADVANCE_TESTS(advance);
> +ADVANCE_TESTS(jump);
> +#undef TEST
> +
> +#define TEST(CHECK, PARTIALS, RECIPE)				\
> +	KUNIT_CASE(bvecq_kunit_##CHECK##_##PARTIALS##_##RECIPE),
> +
> +static struct kunit_case __refdata bvecq_kunit_cases[] =3D {
> +	ADVANCE_TESTS(advance)
> +	ADVANCE_TESTS(jump)
> +	{}
> +};
> +
> +static struct kunit_suite bvecq_kunit_suite =3D {
> +	.name =3D "bvecq",
> +	.test_cases =3D bvecq_kunit_cases,
> +};
> +
> +kunit_test_suites(&bvecq_kunit_suite);

[Severity: Medium]
Can triggering this suite via /sys/kernel/debug/kunit/bvecq/run after boot =
or
module load jump into freed .init.text memory?

All test functions and helpers in this file are marked __init, while
kunit_test_suites() registers bvecq_kunit_suite with is_init =3D false, whi=
ch
causes kunit_debugfs_create_suite() to expose the debugfs run file.  Should
this either drop __init and __refdata or register the suite with
kunit_test_init_section_suites()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D5
