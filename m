Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432366;
	b=YgdCSkuEuf2l+tpoRPyVtxToS0d9jZWtnpYASKd68wQspIO439d5CRApt1pqERay51qI
	 ze5lwhLIUgVpIMD4ZmBS22aC9fBi/FlAJvudDm3yRmTedt/W0Uh3CJXjbv2DQQ9EepQi6
	 biWm7ozJQPH8KeYkFWzYP6jha/nuxM6PEmIfygQQSgYgOKckv9IiDWOaMsG2lSEpRZ34K
	 +CG4eMm0GgC1aNoSO3Hlt21/V6LL1iMAaMa9Pp2PR5AJoB8EsRc+pIMMD472vQkoJTgSG
	 E3aWRQDHg9sTx/qhKNFwT//mwfyco9GHL9pwFYkgbavqy9CV2ZG3OFGL9ll+SVjKXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AuTGNYpv1NYASt3fvvsMrhVjXUDzsp6m9t0MRYABiE8=;
	b=olUX9aQ7g4atdVkCT7PDRwh8MTF5z60s4rfYpFT2PEgR1yewfUiRRSDnXqPI5OsGSvEI
	 CCZuglq6wUBYUpQ942frAdxygwMb9JPceOYWYxBa3ERerWz99UZLi4ihPGBGnfTria/Xk
	 NSy4TlSKvhkfW0qcfnqEYNJ53WlFaWaxkMw3zSx1oMoXWbmdbm0JE5H6d0sjU2307g5z4
	 pLCaCuZ971f9KY8op92UiIqgREjrMbA/s1+R/il1gswS5dv3opXpWngLXjLLOHZAg2+qi
	 IiJz8VXsTqA8l2O1fKBZVGRcCC5CsLU4RlXMN1iu6HsXREJvUnECJOjzW6sdAGTQlhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbjzSh7I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855A606A326
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbjzSh7I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E961F00A05;
	Wed, 11 Nov 2026 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432365;
	bh=AuTGNYpv1NYASt3fvvsMrhVjXUDzsp6m9t0MRYABiE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbjzSh7I7k6QCPPZr4RnyQdj/SZ17kPVDHTlnRSPcxtFQKepGQCq+6+O2FYGORXW7
	 CxZDAHGUFBZ6tigAib2TS1w7RwvxUUgozGZvswX51NYzdXdAlEsR7e7nnLJkgZ5ipi
	 0KJPui2fEHNQz7yTMGmO2XfJeb85I0N4WHDRARXhLT6yUAGSCitDPF91NypGejSy1r
	 w5n6TGPk494Q754feHKcIW2dn740xCCR+HOSLPhtt9ZHDp8ew4cDLaj7stoxMvVJ3h
	 G01/1bD/a3JptCSHZ5JHLTEOvMWXiJwqZb+05uLilpE3TSo2bnfSmfOPARv7UVTKfQ
	 R6suSRdd6gJcw==
Message-ID: <sashiko-outbox-209704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/17] Add a function to kmap one page of a
 multipage bio_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-3-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-3-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:26:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D2

