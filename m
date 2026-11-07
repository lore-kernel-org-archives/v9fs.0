Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077836;
	b=mj17wrx3gUwyERw9OrYQfxlYXE4BAViUtjdowu2T5tPVETS8W9WSdlz7qwm32HFdselX
	 GFQ7z09EE16JFkJwBKge45AaDwkZ/k2ymurHPn4E87ydtHk2AaAmq9LJXEe1WoAENTA/W
	 AqsBXknrx2LRshO/xNwbXtwUZ6tcWXUU91Mt5EWVyEppSi2YgXkRt5+xapLN6FC+CLgFP
	 1Cm/sA/uMbrIuWoM8kkA+NlSxRQxag+slx9hhgFI+PvpYBzEiUzpyHJiDCr1So9A3p28/
	 tn7aHsNbbFUY5Zcg+0qd9y4IS+xFnoti0c2DU5hfdNHGaGjMlbKkwIbq5AgE2+8F1BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dix+j55JOYydgDGFXz6aChqML0Cvh1opKDQ+Sv8qdhQ=;
	b=IQzBaJBxGM3rVpGO4dWs+rO4tIgNluoA/ZBBnwyfNnMAZHlZpGJWBoJ04D4rn9f9uirH
	 xt9QxyofkGNUiBR0/RG2QSEMvzq1jk040xBrUmi9AW7nqbOga7yzeSWvo0IOsPs/0//cy
	 Wfe7xrhQs9Fb+juf5Vq0O8pSQm8a2hcIGCHactPVAL+H17ix2kmw/yxpINtNq7GU4nNKs
	 2uNqGWuoAb5gCH6FOorJwXIDPzqt5610NoHpYHrIhjgDX0JaMGFVmbpo7OKpz5/Mh8U5j
	 c2Qqg+lt/qrkpkIgX0gJcMG/upjrbCq9o4AQ6pMIOWjB9ifZ5qVdMglNEJ7DOtinW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4h2NnXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148D606A326
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4h2NnXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCA1F0089F;
	Sat,  7 Nov 2026 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794077836;
	bh=dix+j55JOYydgDGFXz6aChqML0Cvh1opKDQ+Sv8qdhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E4h2NnXdXH1MhpD5N6LfzKTF76AIY56jMVyYjsPMQTcsmubuWgmX8AUQ3j4PQd/Pm
	 9mjFFvki9GHx0XfMkVbHBIeqIYPrjWqmr7MZpc/8CAhbH6MZVJ2WKh5/fbUxyQi6nr
	 pdJgjORSEX+OP0kR6QM3K+iaSjuutVMZ23q1ffNislj9rNvxWwc3hHCysYDB0Bsnzt
	 nAsjaWO3cyZmjBHSbYAHuOkxQhHxOhoqjxFV9WueD/Tc0OAJptCf8KMZJL9xB0hZZo
	 P7Ax8Kyky5Ac/hnsli2OA4m35y5//vaACkdm0KRC06at1QyCAOR8aqDjinNBMp2bxJ
	 pJcyJBjAbrbWA==
Message-ID: <sashiko-outbox-203190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/15] smbdirect: Support ITER_BVECQ in
 smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-12-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-12-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:57:15 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D11

