Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936611;
	b=ycQL2VxZpZ/NMUQEJohOPIhGYrdSq5WoHi5HxxjDtB8qFe8ldPltNlPc3ZNUNhg8jTu5
	 laAeR+J2U5hoMlDSt4A+FfbPUOYXy8q/e6Ip3zJt2GCgPbzjh/fnilX356UKFAN4lHW4p
	 QEFF2PLyEAJv/ZxIEVmbkPLiD01+iDBnwhY4VVOGlO82ULjhk3MZJovDN4puQJYP6nsCx
	 91HzBhkdYNRe69QnPli4GdELvuZtsjviYh4twb6njAx4hdeWkQ4fo7YRAvutnLGp2+4Im
	 561fBM04A3nN1SNfhf8Q7GcS43aJSknmMYLe0hCUGlqKM9dnVga28Rmgh7ZomlS0fPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936611;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QGdHzUOfRBKQfCRXuQw5eB/0+8kfyTF1WNY5i+MuaRI=;
	b=Tky2Uj6cRegsLtuuxh74qsBZR9lXgCoSKhvZEhD2275NHoz016JrpEXcsJDXWRwOHPE+
	 BIt4lcfuGOhm3R3RSXddBS7HNyTqrxyAlMg5HVeTcYOqqWSzLyJFoOb/G/BsFlJmuKfKX
	 5jieWMNZHvle1bSAbIFUitbMBH0/snwXqHTBvy9v4vNL5R2qmw/IH5n2AG7WmpgC9Mmmn
	 NVo5MlNuPR8H74ZN5ZIyAdacgcWgjf4Q/U9zmkqS5wEST4j/iNowWaPiTBk8W7d0hUbfo
	 EPnELlBoS9L0jsnJie0gQDMk+RUkKi2/vcDM22bwCBHn09q02+GBzYGGYqFilSpjgWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/rfByM6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCC606A33E
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/rfByM6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60081F00925;
	Tue, 17 Nov 2026 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936610;
	bh=QGdHzUOfRBKQfCRXuQw5eB/0+8kfyTF1WNY5i+MuaRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/rfByM6m9bTVYl/vSSUL/hVqB5A9vB0t0pKFDs9VRuip+vJjY+fJ8k+fHP5+z3iI
	 xs3m6I31aF3AgY5xF8QwTb4UDGqyCQfXHQ4hW6jHV1oWPG8Sa0EnBj7JNlycQr4SE8
	 1CiZ9KPl2UHwNdCkGXaLJbT1Sx8s5i5Huq3NzEw4115rt+5fh+u/OWewWGANsMVTM8
	 Ds58MF5N+9MsIqe+gVUuF9exSkf1U0Va64z2jpDFUzRCAqYfTOF1zHvZnhHxTMCg2n
	 YTaeH4fwztmbhLZPkyfHkCnWPR8lYnh8Z+raamURg/7ze+UlpfdPeyjuuZPr6nNxYl
	 mYHjtUn8mLfdA==
Message-ID: <sashiko-outbox-219234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 06/17] iov_iter: Add a bvecq kunit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-7-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-7-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:30:10 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add a bvecq kunit test to exercise the bvecq iterator in a bunch of
> different ways.  Each kunit test sets up a series of folios of different
> sizes (1, 2, 4 or 8 pages) and fills each subpage thereof with a distinct
> predictable pattern that it can then sample to check that the iterator
> appears to be in the right place.
>=20
> The folios are then assembled into a bvecq chain depending on a particular
> recipe and partialness list and then advance, revert and copy-out is
> tested, along with checking iov_iter_npages() at each point.
>=20
> Each test is a combination of a bvecq chain recipe:
>=20
>  - A single bvecq with 16 folios with no gaps (zero-len bio_vec).
>  - A chain of two bvecqs, each with 8 folios and no gaps.
>  - As the previous, but with a gap at the end of the first chain.
> [ ... ]
>=20
> Exercising extraction, copy-from and copy-to is done in kunit_iov_iter.c,
> with those bits added in a different patch.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D6

