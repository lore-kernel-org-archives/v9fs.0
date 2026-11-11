Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436310;
	b=b1lzT0zUy5JJU2YKfcAE2cuaZskpcAswUQ+aj0yRjviExWXJfIGg6tuzZACr6HotCPLh
	 2BhQ94Vg6FsImILxpDShk/BWA9VwS3gU9jEu3E6ZkyhvQu7g9neB0z7bLl7C+uy0WZrMt
	 FQblZB3WVey41SrVlUtbrSTQdhDGGBk2lp0UbgNhOagIv6OiuiyzWHW0GavioKhPKDpFn
	 HgujGzR/hxPf2R1pNpfAQt+humG7URWFELLVnGnhjbLgEE95mZ1sipUm950h4fNTLKuxE
	 e2/AYMSyEY4mdDmk3zlFlMBv2n3nHvrzJuMEBhvaMPemmauqGio9mHCUeDLJm14sRlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z5UPz2ExE2o7jWHveyWP0wyt664WMJgnkxc8DH1fKjQ=;
	b=YvGALwcirhX/9L36kWpgGr/ncOpPTmPrDJfHC/iHrVgJTPXO/9fyItuoEXeXCskNsdUc
	 ir5OKPMDWxsb5Xd868OkNJd6Bo7KHQTNgzxBoJSxTRafsEfQLMmtVwO4f0X7gH4t1NnPh
	 Mgm9gNeSdOn2xdsWxNVqufixM6K+sgmwx+w7hEB82ueaQOixQ1l5c1K4R15BWzT0FSVb9
	 ylskQXTCOE2vR2CUQT/4JZnfzYf4tVSYUI2hVQSCu+dZK9WkZ5w3my5mFT7xWhx1ZXraz
	 NDnl+4sGUjJpxod530CEFTgzzAgSlhwZIkpkGfzSjbczeqc70f98v8ztsfjKxsogfTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dU0hh7RS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9F606A32A
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dU0hh7RS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361621F00A05;
	Wed, 11 Nov 2026 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436310;
	bh=z5UPz2ExE2o7jWHveyWP0wyt664WMJgnkxc8DH1fKjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dU0hh7RSfv7Hy5yadFWtKlfpiEsNTqjWuk0JAQLmYWXx5w8sE0AJtisusfA3vXFTv
	 7/qxTP+Nr+9JCLS60A6Vd1ncilvTmZMazrn8ry9/muELxwQs+f7WnYvN2l9BEO5ftr
	 qlPpb/a9ds0H421YtfGVw77xIsVST0Cp9HtA70YLEu01d/Q9kmVsSeFYAsRS3Om+g8
	 YKK8nFAt8exXi7+LuQn8MHtwCv13RdXGO3Q1itZ8Ul0Z5aVrJSWaN1U6cq0BYo3c7W
	 Ye3hDwc2T9a123qyhyJfyxIzMlD1qxoawxDcBd4i8jZpA8Vz2SWwkq6Z4CYVHxM1or
	 U/Jn0iflklaHA==
Message-ID: <sashiko-outbox-209798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/17] iov_iter: Add a bvecq kunit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261111203034.2126314-7-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-7-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:31:47 +0000
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
- [Low] iov_iter: bvecq_kunit_advance() bounds revert steps by left
  instead of pos
- [Low] iov_iter: unchecked kunit_add_action_or_reset() in kunit_bvecq.c
  causes UAF
--

commit 395487bf3dfe00b3cc632478de3e9afe0e1c97ad
Author: David Howells <dhowells@redhat.com>

iov_iter: Add a bvecq kunit test

This commit adds a KUnit test suite (CONFIG_TEST_BVECQ) to exercise
ITER_BVECQ iterator operations including advance, revert, npages, and
alignment across various bvecq chains and partial folio configurations.

> diff --git a/lib/tests/kunit_bvecq.c b/lib/tests/kunit_bvecq.c
> new file mode 100644
> index 0000000000000..19f3dc41eda78
> --- /dev/null
> +++ b/lib/tests/kunit_bvecq.c
> @@ -0,0 +1,599 @@

[ ... ]

> +static void iov_bvecq_alloc_folios(struct kunit *test)
> +{
> +	struct folio *folio, **folios =3D bvecq_kunit_folios;
> +	const int nr =3D ARRAY_SIZE(bvecq_kunit_folios);
> +
> +	bvecq_kunit_pagemap_nr =3D 0;
> +	memset(bvecq_kunit_pagemap, 0, sizeof(bvecq_kunit_pagemap));
> +	memset(bvecq_kunit_folios, 0, sizeof(bvecq_kunit_folios));
> +
> +	kunit_add_action_or_reset(test, bvecq_kunit_release_folios, NULL);
> +
> +	for (int i =3D 0; i < nr; i++) {
> +		folio =3D folio_alloc(GFP_KERNEL, bvecq_kunit_orders[i]);

[ ... ]

> +static struct bvecq *bvecq_kunit_load_chain(struct kunit *test,
> +					    const struct bvecq_test_recipe *rec,
> +					    const struct bvecq_test_partials *parts,
> +					    size_t *size)
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
> +				bvecq_append(bq, p);
> +				bq =3D p;
> +			}
> +			break;

[Severity: Low]
Does an allocation failure in kunit_add_action_or_reset() cause a
use-after-free on head in bvecq_kunit_load_chain() and leak the folios in
iov_bvecq_alloc_folios()?

When kunit_add_action() fails to allocate its action wrapper,
kunit_add_action_or_reset() immediately runs the cleanup callback and
returns an error without aborting the test.  In bvecq_kunit_load_chain(),
bvecq_kunit_bvecq_put() frees head via bvecq_put(), and the loop then
continues using the freed bq pointer and leaks any subsequent segments
appended to the chain.  Similarly, in iov_bvecq_alloc_folios(),
bvecq_kunit_release_folios() runs before the loop, leaving the 16 folios
allocated afterward without a cleanup action.  Asserting that
kunit_add_action_or_reset() returns 0 (and resetting bvecq_kunit_folios_nr
to 0 alongside the memset() in iov_bvecq_alloc_folios()) would avoid this.

[ ... ]

> +static void bvecq_kunit_advance(struct kunit *test,
> +				const struct bvecq_test_recipe *recipe,
> +				const struct bvecq_test_partials *parts)
> +{

[ ... ]

> +	npages =3D iov_iter_npages(&iter, INT_MAX);
> +	from =3D iov_iter_count(&iter);
> +	do {
> +		size_t left =3D from, part;
> +
> +		KUNIT_ASSERT_EQ(test, iov_iter_npages(&iter, INT_MAX),
> +				npages - bvecq_kunit_pos2page(test, pos));
> +
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
Should the backward revert steps here be bounded by pos rather than left?

left is the number of unread bytes remaining ahead in the iterator, while
pos is the number of bytes already advanced from the start.  When the
forward advance and check reach the end of the iterator (left =3D=3D 0 on t=
he
last 6 iterations), umin(..., left) evaluates to 0, turning both
iov_iter_revert() calls into no-ops instead of testing reverts at the tail
of the bvecq chain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D6
