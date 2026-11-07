Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069091;
	b=IYwotOFPq04yENgIX79Klgl46tQ5x3aUgdXErVucEfSvHgJqQm1LFbLayQv5Mo2XqYYn
	 1JWLheu0dgCGC90jkJzfOOBmkRzIE3SSAutxNJG8X23FXNuee05yxBQzOrohx7+SjjgD7
	 +B0Q2gVy+MeIvj+TXfPfEUTgFMayIZEOqruNJifMCEKurfLXMpkwgb8fbXpdzQDlguZlF
	 U3O7HV7EKvnVDs1twnEd5veaI4T68VSfZ2dikeQh1q7qi2tDObbtZA8kL8+/LKKYgqurM
	 K17mt51Wr3eUT7ppzxtkYGoBvHCA3Zd6JbwzolDHiS4NnkyN+3mSflMXaLioJ53Jhjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x0sQJdZtzXWsk3ve9J5NRctpX3C6mN25lxBkMou1Ru0=;
	b=R9oYG48zLKTunQbsd6l0c8c9NKropiQFf2bAh5ZF2qkwUnZ9jxWlMy985RolVARvttmc
	 cQI45lzSVBbh8Daq1i6gd6jlw1p44HUmpxKQYtVX8goxkhXJQ6eUQ3HAdKoJj1AoVCcRw
	 +sg8EvBfNxN65eLBI5E7HbQrKX/0LN/t6zEJaGmx0w7uAoXQtQZAKbSFf4oiYJ00ED0wn
	 dUYxFmnDmNH2M4VCHOGRjCoWB8UhhAAa5PNz1IQ6QvCotEYYBYWk78HB1Pr11kTD+5gK9
	 CtSk0LTi2PGstpxtiyjRrN1Oaxr8RnZn4fCQLlmxr+dg8XsjwbDTtoj9KuFH4HVwj0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSzhAFEa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CB606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSzhAFEa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EA1F0089F;
	Sat,  7 Nov 2026 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794069090;
	bh=x0sQJdZtzXWsk3ve9J5NRctpX3C6mN25lxBkMou1Ru0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSzhAFEapVxhHa0lwAj+INAxR87TnOih6M5iRyreawOMrB8Z894KyZIIAD+UGjrDp
	 oLPBmkjsqxICMevVX7OKpuRsx/Rqe1fUloV7mSv7ahDH/oOX4Lyw5ubRUcPkIwGA/s
	 YW73z/e4rRp/v04PkFc2o0pKXz3V/XWye6A5IVxfdxD3tesZpavu0nUntU0278hnqi
	 Io/CXUEg3HNJccrk6gP+7vxWbBP4drjd65fjYNKprRrq33/dQLgokjwpywzxL60UQ3
	 CxQDcRso4SNpo35zpJFdcVY5ZWBvZGYDhIAgGMavAfbeFSreJgItS8G1AiLJcVHHBk
	 4XGr9iLGWoiLg==
Message-ID: <sashiko-outbox-203060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/15] iov_iter: Add a segmented queue of bio_vec[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-3-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-3-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:31:30 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
> indefinite quantity of elements to be handled and allows things like
> network filesystems and crypto drivers to glue bits on the ends without
> having to reallocate the array.
>=20
> The bvecq struct that defines each segment also carries capacity/usage
> information along with flags indicating whether the constituent memory
> regions need freeing or unpinning.  The bvecq structs are refcounted to
> allow a queue to be extracted in batches and split between a number of
> subrequests.
>=20
> The bvecq can have the bio_vec[] it manages allocated in with it, but this
> is not required.  A flag is provided for if this is the case as comparing
> ->bv to ->__bv is not sufficient to detect this case.
>=20
> Add an iterator type ITER_BVECQ for it.  This is intended to replace
> ITER_FOLIOQ (and ITER_XARRAY).
>=20
> Note that the prev pointer is only really needed for iov_iter_revert() and
> could be dispensed with if struct iov_iter contained the head information
> as well as the current point.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D2

