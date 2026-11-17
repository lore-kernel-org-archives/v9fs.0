Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936528;
	b=4izG+QnMa1MYr0+Cz79Dlf7ThRSv6UkOZsLbw8a0nC5MomTUk+nbFjXNi3Efy15K8o5+
	 2tk2rcqE/g1dsOHs4vOIDFhrXGCoyaXPhzeSpkfBq8KTrJqhNL9eIZFi8uKEpqfA+kJ7w
	 1kcEmvfo1fBglOrHtukz6F2SoQGGBo/OTpZie7Yp6lsBS+fyFCXB3QZyWBN2Gw4pBbPSX
	 244y1rZ1mOFC7MnVM1KtXsq0AJq58lNyMaIyWMVM1apARI+6MmZMp5qoUSiJEJ8Sl9/XZ
	 uqGb8JasDAdNUd6691czqKvLRZSn68bHZNAUizKBQ1r305puCVRUYjKSRT9u//cHT0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MYRl5qcKfUNob8IWcFBQGJFLl2kSDtGCyPC5QIp+dsQ=;
	b=p9ybeAovp/AtjllR3PzPJsC3S1/0xdd+QviDbzkCjkTjPTXyhXI8JnFW3RnLPNjrvEDW
	 YM0IwqMMfbSDu+lnEzSQSlEjm4GGtsjQASxH5Xc0DHxlPjAqmHnntCmShTxgyBsiPhGZK
	 3P7v0Q46Jf+4MY4o+xJSP9WCMK0djTKMszHS3XzqKg75ti0MewabiZ4x274M974C9Ft+L
	 ScoD2X7aZODsdbi8Bquo4rRYperDuKeB2+Yan0cphcEEdHtxnOq4R2qSNcGW/bxFgFIpn
	 YAMxWIv70fN+240gzBtQ/KUwoq8csgT+HpB+zaeIVIQSqIqjO37tu38K8FpyemNZtmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0u3swgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BED606A334
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0u3swgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A8E1F000CB;
	Tue, 17 Nov 2026 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936528;
	bh=MYRl5qcKfUNob8IWcFBQGJFLl2kSDtGCyPC5QIp+dsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0u3swgk3vO1UBiXZhi1a/SBEfbtkYv54/RA5xz40yVKnphLvfF72E6rLaVTMl0Va
	 5VpY21Aq5SUxp8z4DSitVTqEijNi529NCJOV6ihNNfM1ZFGNluOGKGeercosqqqLHb
	 wMY+jRPpJPzLsY9r4TBEtRjTecvGaDzB/tInfCrM9bRCFbFM6ZbmvD0WCsKocZoeSv
	 NjSjUNtiZ6L6UrQ7ReEUVoGvNj9ZupIYjdtGYi7bFMTH7z5wd6PGXajicQsJOaAPAz
	 xeeat5qNguPOdfw0NAHcDE+nPbW/lphk/QcNUYblfo+OTTeyhMhEUoxjXAV9iN3htP
	 dUPS34t+6CYTg==
Message-ID: <sashiko-outbox-219232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 02/17] Add a function to kmap one page of a
 multipage bio_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-3-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-3-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:28:47 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add a function to kmap one page of a multipage bio_vec by offset (which is
> added to the offset in the bio_vec internally).  The caller is responsible
> for calculating how much of the page is then available.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D2

