Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433592;
	b=NxC5niE+P6ow3Nsro+vxyLyyfwXeQlIKQG9pPQeRnlR6R5Od7UuxDjTkIrgxAXa8COE+
	 M7EbPTOe865t5c4y0ch0FfGeqUlsNzRoGesGZJGC2bBWFta55NPZ0DaXfLyYPj/f9zL+m
	 p/rW53rxPD/RfuEk8A19Io1s/HW6sCDIV3y1Wh5aHd0FPebEaOqWRol2TiZGsnySX7eAH
	 0chmvZiq9A6OnHfWOEaoGWGf2tm35hJyaZAIBNbab9Suz2l23Cx7lRTNMrRgJLKooJBO+
	 SpMdcjMYEKidDQvEEprcJP5asNrMpNYa7xBjzr0Df1vzsCcC4Dv6CcdMJOmEU3LlTmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UBNMCUGUyyOxFFihinuKtlmAkERxCYStE0xFKbmmdUY=;
	b=A1D+6GitOhuRqWtMKjtwEwtRStPAp/GRSH2iK8nrgwC9ORFhT9L7GWmj7f/boKEKPkll
	 yec8IPMUqM02+VKBJnKAbNSaWCzm2gR9oV1I+CDcgpkWkWnOBLxUrauUwzCF/3Re2NeBH
	 PJJ3HHbfnJEnOFD7OlKiLlxM8S3hnQxMwn02zsemGsbnT8nh4Y29sTS+ui5J18CsT7SXO
	 voJNdplv+Z8n4BhFKatjJ9rV0J7r367yZ2y7jGIOGlBQVTtOwj9djPu425D4DaHXP4AmD
	 0XYOcVmmj1Cw+uTgU7U59h61PuNVQvh+djEutRSmbTWpggC9HO9agKzZsn0jdm6RLpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+1mFTva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C1606A31C
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+1mFTva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29F41F00A06;
	Wed, 11 Nov 2026 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433592;
	bh=UBNMCUGUyyOxFFihinuKtlmAkERxCYStE0xFKbmmdUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+1mFTvaAGKJsu6spnPxdLf2SbBHkUYU/6lUcZF94FgfhEChcrBNJe7HXNlmxH4hQ
	 SkP/OV7ngYC1W9DQ3+1qk/1554QdP2fTHYd1d0Ne5zmJBmKS5uxhC6czt3R2upLeEA
	 5wKxPpCV7o4BCR8ua23ElPn39E4lMMTTXz0JkpZwGLV1zHD9dt08BJ7WDUeKFGQAN4
	 AOpFpD9YZ4pm8G4KLnpGBTUFhJ+gKC0MxxsX9auW66rgCfRxBCC4Gf9nOo0iT4DFfG
	 9rESXYm0sJjRRqjffBlRFRkujhjk0h5QzjqKJ7KhAN8qavfhwsnd6WcASyEIy+COLo
	 kURBpapXlSA9A==
Message-ID: <sashiko-outbox-209723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/17] iov_iter: Add a segmented queue of bio_vec[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-4-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-4-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:46:31 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D3

