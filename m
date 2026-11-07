Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071380;
	b=NCT8nALceqwK119BmOnsUZAkvyFc5WT8zVZjYEZgF3dC8zdVGMJc92O1FWyyxpANlsWb
	 J+fMjQpX78CxRKMvnRnftxToR41NyJdXYoedRszU+wmkmwaQoJKFF2b+K14t0tESE1DEn
	 o6BmZm0nqIlOr8SxTJhMYMRU7Suxwlmd4uhZdWFn1fmWDX6qRU58mI1OLkqUArmQzwtFE
	 hkIZsxqlHUsCBbcc3foCxPkKRfN2cJHzd7KxLKOwv2+xJgLrRKcOle25K5FYuqDTwsq9f
	 ub5of+6TRE9Kx1dGmcjM3wzadc2kMQ9c7V/v0c5ZaYi8Zl3+bN2XPeFInBRU/HQd34g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ssy96u5kDLiC3EkRrt0whTW7S+tSLD9/DrVazE6aNQE=;
	b=TcEzxIx4yahTJf0Ik2tu/GhsIuVAaFHWN+XredaflL4KrzQbUseZQrZu4GjV3K+g+dX3
	 vxHV1RuKHvVaFkcpIH7RTqK1gI9RYYLxvEK3vGGXeDMfN87fMrvXbe+lIWO59v8qE3YNJ
	 j0dE66Jk/sJbng6yRXA42uvg7VulD+U516QywJlbyQAFslf1yBrm8crLkOqP/NKqRrJ6b
	 +iaCwNyolQ2V8jY7g1yHV/EFGUJVm8uicfTQnVcQUGjct+TTgrETWGuDeGpM0YwtxcfVq
	 w0XJniQ2c2+vy2jpoLnKl/iYADW1q6v55qUobgEyV9TiAMZeyYtp9cWEWx0E2X4WHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERwCkWOJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A073606A331
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERwCkWOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED5F1F0089F;
	Sat,  7 Nov 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071379;
	bh=Ssy96u5kDLiC3EkRrt0whTW7S+tSLD9/DrVazE6aNQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERwCkWOJyeXcElfSExfzk0oszFFfJ6A6uxnrOx1yGu0cZeU4vmjZ0SuLm7FpMwIuZ
	 gQEwPwscO9NGlMqecjZ6imu20hlSpeHetGnyaVA29Ai33R3BRs+hqZXQWzGbBjC9T2
	 c2ar1x/x0dzHVqgViJItn2zF+fJRSzbUsIYrXsHK0HRF8VGGi1IW41O1jQPOTsRo1Q
	 lW2mJtXLk8U+Xu67hAM+HnTAYIRzVAvPJmEDyQ6EJRCaUOxpJ0RYHeaRgjfO0X4St/
	 iBWhawCmjupW0tZ3H9YsG9sSOK0dK89ZHh/S/ULuEYpfCvjaK/v+jc4RH+x/UTgj68
	 sTCZZ4JpxBM/g==
Message-ID: <sashiko-outbox-203093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/15] afs: Fix an inconsistency in the symlink code
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-7-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-7-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 17:09:39 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Fix the afs symlink code to set ->directory_size to the size of the buffe=
r,
> not PAGE_SIZE-1 or i_size.  This doesn't actually change the operation
> since the value is ignored by the symlink writeback path (which writes to
> the cache).
>=20
> This was spotted by Claude.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D6

