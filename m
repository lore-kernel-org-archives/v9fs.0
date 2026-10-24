Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833874;
	b=W0pUrU3wtGN0R1JF9eTieY22+8Sq4flDNA1TXbVgS+yj9FDB8Zf3qwKm47Uf9rMEjqoX
	 lXtFMBeHQHSNiIYsNlsqIVW0hrxncKkp0QE0MS538AwsRyZ6PfXOCQSFVP5TO4NmTOmMB
	 PKrmlgFOSg3GC2oKMbYInRN/rolaulEMAMu9dJHh1I0lAdBq2DBkdyfcOWOTOQiFDweVs
	 z9eB4G4OyHyPt4Jdq2nDVZ3wmKcKwb5Y2L63VzQn1QdznS/TaX5lDcYhtIYN/YJ8PMPRk
	 DiVkwaOQJuMzhcNrbsPXFkNsTzi9iB+TSSaXIv2Yv7CziJzqSZi8XZl7mOlhZVtQjWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pKEDRfqpGMWD/kw/XvN6TV8LVxx6Ie/xX4egrcUHA2c=;
	b=mhpiPdz6IJqsYXGmdkseX1ygB3HONs+hp5netDvrSDMMwIqsic6/9Zh1CLdr4Gx74pKw
	 IQ7YiWYPVg2QAd9zruLInaFRryIkle1W3bn5AKqfp5SOGlHHTRa7H4bjofPcicwyFalps
	 whvOPX4An1e4+dgSJL5P8ijgUd0MxWxq+M0+Tp95CCS22vBD0fskmxFwg0O0o3VxDkxTe
	 1EzqxcNXaNF3GbdaVR+fLa4Nnu1z19r9w6N0QcuqW2eR7ZstFS1fWhXcpsJ5TU+x2JycD
	 Fh9W+4sTPlpMJolGfrUIEJ8FHqhKL8TR/sSFxYmbBpq9Ibh9jOBFhuGgF6chqG3V79Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHO9HmuR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC62606A31A
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHO9HmuR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D41F01825;
	Sat, 24 Oct 2026 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833873;
	bh=pKEDRfqpGMWD/kw/XvN6TV8LVxx6Ie/xX4egrcUHA2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHO9HmuRb5L0AvyLQnOZP8s29M5NLdYzoIYrVjeJ6ntK4kwjGoLdKVjn1uLEy3fj1
	 SzG4pUBpMSSwSXr5C7lH3qfcDZHFNLEwAZwen9LVtK132wHFw47L2vEADE9Q5/71wW
	 VF59FGDujFymoIyuIrmTtVnJ2E5RNtVxA90CaOw9D5lNFT0fDpT/A9gHzgWM7z+lXx
	 4owDZMryzFFjD+HiaeOAqzL8k8p25uGkvGejVeVJtPbdcNjb5UpsQH/fdrHFxdYL+3
	 AQg59sUjXLAMUIK8/fi8IYpjkVXop/adjh5+fshUJAtMVuwmoJlon/DhrVfZrpxylk
	 XnPw1jlJ7/Mxw==
Message-ID: <sashiko-outbox-183609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] 9p: fix typos and wrong parameter docs in
 vfs_inode.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Thakur" <codeankit.thakur@gmail.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261024092154.1844-2-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
 <20261024092154.1844-2-codeankit.thakur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:24:32 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Fix spelling mistakes in comments (functon -> function, Hadlink ->
> Hardlink).
>=20
> Also fix the kernel-doc of v9fs_vfs_mkdir(), which described @dir and
> @dentry as being unlinked instead of being the parent directory and the
> directory being created.
>=20
> Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024092154.1844=
-1-codeankit.thakur@gmail.com?part=3D2

