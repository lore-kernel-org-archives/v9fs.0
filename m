Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078204;
	b=47+lrcIgkehBDbA8/yuo2xkiOlfceJd8U403wQ2QvGzA0SaJMe8MMApb64g2IJfbZCBD
	 v3zqqu2hqoAeck69gTKvRRgSOVo094n7KI+20Qi/3G4jbdPyixQw2WlCLnl72+BLrQw8/
	 48yv0jfffAKMWLmh9z7xK8db9U10ahWTjHpEygNABnJilt8qXQRXPAqpzWrvwWMwhNpWp
	 264Kgt+vJ9mnpndDwTOagDWRfTgso2LwmoDje8L9RHnsJcpjZ4OXORGX8HfGkc4k6cfUt
	 BPWr3hYnEa1gpmjUSBAHA3bqg6fAydph8VJ1PVdqU73xznGv3rhejzZ09U6pGp/IjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jpo4chyNHpD2xHYEx8I+0cXxwu8y8XKU/cexFY9e644=;
	b=223QEbeJlNF4506XZFNFZVxcBDDoexu1kQk4/KYYBBHz+jENlufpi7IMKGcKTqwWXO+Q
	 pyVe2bUw6TbpvyO5IZv+D683G11I4F84K+tV7agXYgIRjQkHwRMFhPlRKuQqv5Gg2ey6s
	 dTUahLUU77gQnmikk/joIk2C6sot5cFqaumkgBDkM9QCqlt9gS+b5woUUGZjuqPjQsAk5
	 m2D3GxdEyTxOM0cFVaNcxh9No8I7NrZl2+QVQ4np0R1kH4HK7eYQwjPsbQT4CS8FEMRcD
	 l+w3a7WjW9EdWRYqpWX3JhiyDXitnuzMxYkQokcpy7kz3UNA8XZBVEGTYSAip7Dn4aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUcX8r2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455F606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUcX8r2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09291F000C4;
	Thu, 19 Nov 2026 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078203;
	bh=jpo4chyNHpD2xHYEx8I+0cXxwu8y8XKU/cexFY9e644=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUcX8r2kfj8lLa0X3p7ZgEs+YPVwTeqeF/0vO1vQjnhVfqKcTsw/J2FqOZK2Ai9HX
	 4VMoHbkr/zyvHGQomZrfMLUmai8jRsHyouO5OJCT+q6iCMAN63yvEh8KLwGb7ggCIb
	 mVAWJI1A+2Ply3vQA7RYk4Br2AyA4o7jGnMuEefIf493ZBpZy3KgyP6ZH5qsTCF2pq
	 U3binTKZnl53E6KvnYGXWxlSV2SnBA8hyKVCFnBtbUz1ksWxIrRxIOSBXYG6KCZFO9
	 oInsfmuhsntURWCrl9Zj21I/cRe/TLv9SX7Jb4iTkRd3b5bOuRNUwq9ZfJfr9sMg7v
	 2OK6BVpvGN/dw==
Message-ID: <sashiko-outbox-222722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/17] iov_iter: Add a bvecq kunit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-7-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-7-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:50:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D6

