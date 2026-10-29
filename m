Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253914;
	b=X8MnYrza0o2K617YPA7kgrI/TMc3q1mgxytRtMmW8YaiqAodGoe0lrP/TuETrlNGzqWg
	 yeFgWN+XKmBFss9Kcs6um9mWD3mbz2BrThiNDjAl/S498mIqX2nbAkZfUxGNE8TGls/av
	 LzvIGrQkmmDcnRJPwLu8mQu8iolU6wLcROSimB6C2g4oEbXkTJkUqGi9EDnAf1NI8NKU4
	 fO6elD8C7UdoyBfsn8/wWA0ozktXhNOZxnR9XWKzz9RsAPCXW5QJOOI8BbtTdmySwujWa
	 n8qTbRL35SxixkCZ7bAY2BPxAQb1+015HXS0pnvlcjqw564t6TBx1U5Z9xRYewmYttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RhWSRkx7PvODuPDJav0DD8D71ISyb27AyGFn7PsZggU=;
	b=PmKGShs7uHh9hFl/YnqQBI1HAHH5t18iN4R2BYEjKSOFlmHyYAw6uTSn99VPrHFRJlr4
	 +Xee693+uxaJSo1/RGPnPY+Py1o774oRHg1LnPxexN3DB9EPjQuGgfKZk0SrfWACwuphP
	 4XAa2VDQsKf5gdZ5NZtWYmLb00sNNGXVyqG3uq4p/kLWYe8v8u+jEUKa5Q4QrA1LIK9rQ
	 5Y3VTDXdluwCMhqr+qKd5PS3ZLTXLa4Tn9m0wWJK5TgkZyUPpjmFbEvGW3b8Ttb3+lmlE
	 RUFayLI8efKYm45K9xfTCtadhUfY1A2YE/HwpFP2t4D4YUp3EruofF7jlK8mVKy3lYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOq7Rv7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62B606A31A
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOq7Rv7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D51F01828;
	Thu, 29 Oct 2026 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253913;
	bh=RhWSRkx7PvODuPDJav0DD8D71ISyb27AyGFn7PsZggU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOq7Rv7OGbEPLjwpNiukxGQFe8M5YU4NoBg3eTY82qEYY+UvobPkCDCkHZlsemnRT
	 XWxzlLm/N9F756N+69F27LnDnD0O00N5tUSDkCH+yI8t8KjmU+PSM3TX7B+bcasY5M
	 IO7UWhFlYgCvzh6AaCRWQJ8yYcyyF44GomwnK3EVmKLaX04x28kh3Sin1ilVM5DcAy
	 ARNC/o7CxNUG1PGWJnFYwmnvnuDRJVEx2jxnYZC2LwPSCl4OF6qLB60FSF0lW2x/1x
	 SmJiw5pdirPk2CTdCSjwKK5L27DcLFizGkhrsnybnqoOwQ7yIo4EKgWczcUL9cqSd0
	 X7HhM4jUDkMgA==
Message-ID: <sashiko-outbox-188790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] 9p: reject RERROR/RLERROR with zero errcode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261029055801.3-1-asmadeus@codewreck.org>
References: <20261029055801.3-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:05:12 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> From: Hui Peng <benquike@gmail.com>
>=20
> In p9_check_errors() (net/9p/client.c), a malicious or buggy 9p server
> returning P9_RERROR or P9_RLERROR with ecode =3D=3D 0 causes
> p9_check_errors() to return 0 (success) while leaving the unparsed
> response payload as if the expected reply message type succeeded.
>=20
> Map ecode =3D=3D 0 on RERROR / RLERROR to -EPROTO.
>=20
> Link: https://lore.kernel.org/all/20260919221734.3708000-1-benquike@gmail=
.com/
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029055801.3-1-=
asmadeus@codewreck.org?part=3D1

