Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445619;
	b=dwU2wICP6gqGWs7wy5C39VFdkYMQVBlB8WNp2Ik+G0u3W04TOGnSppW6cxcefgwnhl5N
	 EpnIW6oCrtkohiT8GY4L5zhvWGqCpzryditHXZSHd/Ypb/0MNEbOeAaLMF/EqzGSOsSfU
	 tkKmjOIxun+SW+ZAufH+uWTkTw4XsH6ACuKqenlv9vcusxA8NTJGjW+38MvBnWcm+AXPd
	 X3s40sGgOUx4rCzKQGGPadEJuBRl+sO+BqdySpfFLS1a8+g53KWmZbnwEoVEkU6rApHNl
	 xyvIFkAaGKEtIbrLI2oMFjgcYQnyAfimocATmHBrrYRwq6CwTMgjNDDet/Dq/Z+sMyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cCqDtH2n3LhEu3DL1g6pW31RrLpHf6tcgsGKBkkO19A=;
	b=YBrQB59MMOxV0UE09QmZIxhhi4Utam2NNny4H4A0f64pMtd1f2b45DxzMvJaKdxIm6Hl
	 jlPMpbqcepQbUkaacieH9nVT34ahOo0XeF0JB0j7Jl1osVJAqXVdrdBcvNB5s94hJWm7n
	 axMQEzo9HfmM6rZahggvz8ReiiWiFk7GKyWaohqTsBkqAXHktx+Wey7mctMH5NSsRUbcu
	 3E5uch7hFObiC6IbhrTp2K9BsytdKDmj8Xab9k7vHVNK3L+8W82ri0k2mreXtC9j3vrnP
	 ZRZAsyMPx5vzkuXcQ/gzfxR9CQdl0p6QADG5v1nKw4T7x221MTUqHuupvZf7aZMtwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gyj0qj96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43281606A321
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gyj0qj96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA47A1F00A05;
	Thu, 12 Nov 2026 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445619;
	bh=cCqDtH2n3LhEu3DL1g6pW31RrLpHf6tcgsGKBkkO19A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gyj0qj96Xdk7N57amZkG0W9O0Ll9a+OsTBGrzn18ZweS99Imy3IhXKzYboseshsSe
	 9oi5BoxxSdgTD0kXxCNSBEu0UFt7AWIAoZB/WixneUzbeDMBBw40FYRhHcSkvD6dHa
	 cnjzV+C306cS5vmRPJmB4re2T5HFKOU9yTnDoL+rPw8dm5jcr4FQxe1YtV/S80EwZX
	 xhQC2ZlNaXcmLkWI2wEm0Sc2OO6itAmv/6BYFvks80rTGVLmIba39HYxFVsAuWkPh7
	 wSMZPuOZbA8arE5K5ZZYC7nl3UtofcJBS8QMNM1KrwIi3+4vJXHLL+gCbiZ/qetmN4
	 VKe1R1JuHqSuA==
Message-ID: <sashiko-outbox-210037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 15/17] smbdirect: Remove support for ITER_FOLIOQ
 from smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-16-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-16-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:06:58 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
>=20
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D15

