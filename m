Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078621;
	b=div3BkgAKkUg6aXNnsvFjQ1nFVH6W5QI7GxC1KJ8gQHKHXLvwlsNK8kcuWYNni3Yk6Bu
	 YXQ9EamTvp4k2Ua7Wf7Pdwy/toZc8MKMCXg2cw8hRub8UnZ1l7BgEI9pWCsbiepauFV/b
	 pYwStI0MQ60BsSdxpZ6z+gZqQNcVZ7OpGW5cwABQY2Lh1Q+wqRLe/3LEBR4KbxrVW3JN2
	 4WhgPsMkOEZXerdUIUXNK54B6JzW/AUN/nDW88U5QnoShTTb7XLvTKdbvJ0AsnsY/ou/+
	 kAQgSW4MclchK/ZL45NL3gJAv2v/4WwmkpYGHj1ceUfwFusLhXpP+vmPtg3KkL4OM5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NRQlw+eubtI5cmncO0zfwJGwC8e3zfQHwA0hD4XX1X0=;
	b=EQPKbOJaeoiku7aehUpOHZ/uWmg1M9VnOgKkQVVKj7jngPZPGjhHVRc4i0Lts9h6XbF5
	 1KoqZ5Uqlg0yUi+4gpvHMEnBMiORiSlpeDzTnLPw3l6YVYt9gp1BzPtKSoGjmq6Z6dETP
	 5ortv36dqw4w+jtkSp7aH/BEbhz1CFOTWbGjQ4lw8P/Z4+6rddx9W4R1zgK1a3vjB/hA6
	 NkmoLfeOADkGbDQF21Xj9ce5yJHCvJwBnob6BqagLv/tZQo2jQ+7APi0ELueaROuh5gja
	 u32sfzLAw8Cmv/5T7lDeYnNruKinqMdCzw+eJQi4CoKbxQ/F1YUVlGOinBN9VDS9yuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVI34eXu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D1606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVI34eXu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1280E1F000C4;
	Thu, 19 Nov 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078621;
	bh=NRQlw+eubtI5cmncO0zfwJGwC8e3zfQHwA0hD4XX1X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVI34eXuhRXhnV1TeligrnnUYxBFcNWQGzQEMWgSmh24RLAklOpXauGN5aWAT/FZJ
	 AATpm/zqSVjse09aveIn4DXXZIS7rEWu+GQW0ruBd1jId/2GrybfTz28YWmP9JwHzZ
	 jh9gRMY0WR4NtYnWayTJi0Gj7PgMVIO4v9TxzsafU+UZnquXYbpEg7obGkPIAUb/kK
	 0O9XZjCQoNE8eWxVMypjOiqerW/Hs78SWj6FdxsicMhPCkLDB1EIkt0NKXuEJB/auO
	 jV7+G69Th28NmWjGnn+F28ZttSjFrI/vrnZErlUNBMAsenjtBsaj67a9GJuJPOOZjk
	 4JYZFjTesbGMg==
Message-ID: <sashiko-outbox-222749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/17] afs: Fix an inconsistency in the symlink code
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-8-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-8-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:57:00 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D7

