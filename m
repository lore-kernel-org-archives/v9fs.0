Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833899;
	b=YKsHgc2kG6iHljCqu8aV9yTiqy+qpg6PZcV3PfLkFaZq2ZYqFX9BCVVHC66eEoY9tJUX
	 BG7v553qz8nVPbNGn8MJ5VNUU7Xk8uMOBn2hCsw3pkQp5x+2x1lhwzsa5zixKrEHVw/V8
	 ssDOvOJ4UK7fNYM6Zvckw4kc+kLDjNPutkBgbgrxiOGVs0F8p987Fi41lUfiklSSwqXi1
	 odbE8s126fkFOuWLME7qqKX5rXoLCO+taDjTULpjecDMDCy1oLd3V08b8OSmu4XvodBEP
	 6BLmUZTvWs6QCM6lrl/ynzY6jzS4WRlwjA17p7InXV6wOf+/77Bn7ItOHYkCwcXUi+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gQT5cNfFN9iIUhkLkqMMajO4OYI8ZPfu9fJTYXLroX8=;
	b=D0qkTs6ZN5hfUwCJzoC9EWjajKLS0gZikdnqUBl0uhEHeRE+CJhZgtUyNCcmROc5sG6L
	 cTaN5TIUu+9Ocip1+D3/d9fAns9GRD4kglt8hzczVp0GFrgLh1hBJ9KbCCFw4+grv0hgY
	 9PgQoMRfwSQYBb7gjk4bbCtruGwZBnVwTNQo/KgKhfvhEGMt5GqGOy0QrjfDpb80YkRDG
	 GkU+RsxRyivrrbmbLY128Ohw4ZoryyNeFL4wiqRhR3igQZisgDI0gBLSK1lJi2oO7Nnuj
	 4REq3onLigHxbo8dRRxTmJXTGv1Eh9/brAVRwto6WtOXwH427/6DEKvulYuoU4dEQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MolIaoLm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F59606A31B
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MolIaoLm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37A1F031E0;
	Sat, 24 Oct 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833898;
	bh=gQT5cNfFN9iIUhkLkqMMajO4OYI8ZPfu9fJTYXLroX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MolIaoLmWeoZa6GxAPOyJBrIMS0QSNDovp2FhAYwRfZ1kLys6ybI57sREKPOxN3x8
	 ibTLMEOqjjVajECvqn9cOfPaOj/VjNtOGqoy3J9PMz+xN4REeFhHCFhpdomL3IB6Ar
	 u3tLK4n6Nd3U0D6KMNCCka+IGQtFEewcsmjqAGDQR/mx3uBfXSgzPglE+aLKRqDQ3L
	 E8JLugqOT8MXM5y/J0DY9Wv8LvHlcoKO2MY4/HA2XL5s6yU/ZEV6oQJwieqMKH4jrB
	 YQYOdcW+EprM9eRMGQWiTI8cAPZG6xss/0F0psA42D8JnR3dj52MNJWJ+kAo34V2Y7
	 qkbcCI4ZTy7Kg==
Message-ID: <sashiko-outbox-183610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] 9p: remove duplicated assignment in
 v9fs_fill_super()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Thakur" <codeankit.thakur@gmail.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261024092154.1844-3-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
 <20261024092154.1844-3-codeankit.thakur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:24:58 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> The declaration of v9ses assigns it twice (v9ses =3D v9ses =3D
> sb->s_fs_info). Drop the redundant assignment. No functional change.
>=20
> Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024092154.1844=
-1-codeankit.thakur@gmail.com?part=3D3

