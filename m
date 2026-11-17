Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936969;
	b=xca3xCD7Bbnq65HicZ9nWSrBk/c3yiEqIWSPZoU+rz1FjogarMtD6/hewYwe2IYhRc0M
	 aUtH+h6XSnNS17RwhQQMGBYrKQ8QQ3FUq2fxgEAS8oryu8rEbaUm2XEYSWW8WSVIPdylV
	 qY3Uly3032HNGrlp+NV1nMKYdKpeSF+Fg8nBlOY9e695VMxmrA8+hYWq5Q5Etes0hePwF
	 w8waLNXZ9N+gDhy0H+sBCN7sYDAEUuyRSksvaUolDOkB9lG2/sEkhQ/8GuhIh0H+H+9pD
	 vxjiluJH808wmGyP9+oAVi4awDYbuZ11nLYjHWvKe3dmsYYz6Yy8+xVp3fxACJVZ8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLHgw7CuRyrhHcG6tIyLjwylABfDCS638nhfEKmpd/s=;
	b=0z4LEiLsXuYmu7oLE+p4BAEHNPxtc9ncObtkFGHBAltE6/V6HtCio6FVpr2xCi0wMMMe
	 4BpjhPITQdr3Eki5SqUGQFCOq3Zd4iwMoINj0gtENjphpdeYI4NazzIGzdtx1C8qG3lVw
	 MLjzYM4NFVV+7giQNzHcUfUGQ+gY98fvD0Id2U04auXibasJcjg/Cw4u+JCETKAABefkP
	 wS8QTrJlqSEVjeOW6X46/dlyVJ/pdDb1j+Kc8opY4WtVZAPjllG00EtUz6tYwoOqbNgfF
	 o1fw+3pkH7ieZV5udSY94AJU/FrjmgJDCLnZxRE+PsRu071x8Yp4spPW5Lmnj6dnXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWC3nZYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D77606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWC3nZYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DED81F000C6;
	Tue, 17 Nov 2026 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936969;
	bh=pLHgw7CuRyrhHcG6tIyLjwylABfDCS638nhfEKmpd/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWC3nZYfl/jHJcGVvbISYpqfow7a6fCkkC55V91aiU9V+vyast4vyADVvFjMriqhY
	 38rUV2mMMdg8a1KKFSwSGDyQUQZid2kVBDoncMiTHl2MKj7lSLG9rydb8rG+NfhPMp
	 RP0EnL4kqX/vYiiW1Ys5GCe9h2mhZaQvj/X0HvylfwtJEDEbtIPA2ym4rzvH85tH4O
	 3Dk57yyKkDee3EFdaNMtOefMsSKWnWMQYC0JSiO4Svwej6ypXHmiK16hKiTibTPduJ
	 cRXR8vuq9g1g/GCYbcuCqMS1UUSqI4u2PNrAh+YzEltMpyfM3TJcSSnb50Eng64RyL
	 uxu1WXrlFgkJA==
Message-ID: <sashiko-outbox-219245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 13/17] smbdirect: Support ITER_BVECQ in
 smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-14-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-14-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:36:08 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add support for ITER_BVECQ to smbdirect_map_sges_from_iter().
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D13

