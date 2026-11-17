Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937524;
	b=eOXZ0BaMJJKJwvrdQR2u4bX6ktsSQNTRqIZvr8ucEJruSkYgMv6ORdCao8VuVDgJZoTN
	 XnGIbmBPylXdigBFgN6SoAzmcPZkrgPhKHkTw6bUh0XOarxl8S3GaY945+seXr9TDh7cE
	 sbp16VXoxSKK8T8hvjShDvZWIctzmEq0gSttQ37KoWDC4qctLw8M5E/XZd+NHdrZG84tH
	 yciQNiaVv4pASJa33R3iPQwAS4RhbOH4xvL41D/oWKEBHhpdP9pZPUMTnm8fsiR1usK0Z
	 U/HFGIZoL2/6TNhBN6JFZPXOuwSxBP2FFmKi3LWwe/NoOIWm/MKjtXM15ta5JstCgUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iDeYPMqAY4D5AIL5gHxwFNrprsx0/xI84urhHva1axc=;
	b=LoI7c59EGh4XDoSRSSlmMvE8FM5yTh0/TvINQbbxnQCWq0ofimwu2rurJ1AO609F7k5E
	 QwuQKiVZQMOEVeDRZuD9CI7siDZA2IoDUFFtdC096Ku/NFEc0MevxJQ0iNVrE6/YwauoY
	 4YloE3z3NARcpQcP2yb3Q1YpVP7GnggeZsTkqAv/bMxSGcQWpfER3QQJxU/cUzIz8w0jx
	 ZWoMILFiWIYJXd3W+j4prmbSi1M82cAoN/XHGlVongArliuDZ5Sc6estPDRimGyJnsAym
	 IryfPB9RDjwoyYlPiGDFYWbJD2e5KPcheLda7IlWPMsehGhdxB9PobyqqS0oBVvx6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deeohlu1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686C606A32A
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deeohlu1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1705D1F000C7;
	Tue, 17 Nov 2026 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937524;
	bh=iDeYPMqAY4D5AIL5gHxwFNrprsx0/xI84urhHva1axc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deeohlu1KKjj6DzfS14dkwwLMqvMSxKxUd5XdpbuurM62T+mjAc0OZ7kMZHSiVtiY
	 aR63myn/zpjqorM++WCIiTl5+PHHLtbceTsGHWm0/BWIcPH/bu1g5rUygNyGgsQBeg
	 wrja7x1aY7N+vlzWZqli7Gvgcxhj4Kl4dYT7xAgp0OFs6uQEzCicN1YxZOblF1eMDq
	 XfJDcInta+Dgql60Ur99rEK0YY3rLNc1cpvlUm4Ga7lZgCEjCtUjfvwNQ5GPSl4MVo
	 UeKI5Q0RbJxuhmAr/yUzVwfH1E10DYxI3g1nzH4HLbJby/0oLArtnOKDpLEBl/GOL/
	 lfXdOhFwf8fmA==
Message-ID: <sashiko-outbox-219258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 12/17] cifs: Use a bvecq for buffering instead of a
 folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-13-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-13-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:45:23 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Use a bvecq for internal buffering for crypto purposes instead of a folioq
> so that the latter can be phased out.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D12

