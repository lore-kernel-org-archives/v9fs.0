Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936908;
	b=SsEVuPy6msHM/Zjw2hgnRg3/MQBAxv1wRAQzrnevHfEE/6kUzQWflE1bXxs3tx2TUgOn
	 CRaeJprlE+gG3NB6V+maBupruv1cUdZm9VWAYEW+IGPKp6Wq6Z3O8K/qSj8Sfo4UaWhpS
	 gDFdVkpE7vqyHzCxcKHpYAib3VbFZB85xVdyRwuluTsdjWE2jk2cz7PUeDkVzRSPOGdBw
	 aM1Q0IZSGoYhq9TkxEe0W9IscNH4vKt4yJ8O43nnC6z7S+H40f9irjXRxnHmXhoLbrk9Z
	 KITzlcT4Yy41DHYzysbNjWk8sVMpD/SRfVlY64ZmgfRWYMrxETWYX9m1NqjL11DxCkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g1DO02J45L1rxEnZ7mA3SQv9BTy03U9/yGEG7zoyspE=;
	b=kJb34DVR1pA50wCSHdwha7KQ+mbP9pnfMgRiz701yjgIEOnbLMJw8UW/r/NuLeDHsmka
	 g/xIOLzJWSJIhJUMr2UCOLAZYWltatJ1NPXTC/KIGZ1RYxSOE+Kx4l68YQjZZ8lC1KSBp
	 x8sG2e1P5GX8coqEXA+BWekTclDCv7rFJVbcoZWjCWTcikG6qqlGKGwgMzOaSTJ/HhmDk
	 muTnyzdEJZw7lUIIZC4/PRfXH6w7yMpKAqqMoqfwVOZlbOt4dapJ9S7Hm2dST9rrSTJPf
	 tiuSOXEscjtRxibJ21C4I6JFlqZHKaRA1VO7en+tzmsD+iyqZs61EZbIS4EoynYWPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpEVNOhj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5418606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpEVNOhj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FD21F000C4;
	Tue, 17 Nov 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936908;
	bh=g1DO02J45L1rxEnZ7mA3SQv9BTy03U9/yGEG7zoyspE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpEVNOhjUjl3iUVCsQjFN54mcgpjzbAtMIAaG+CEXdf+bDrRxgczUM6CBQBD2c9bD
	 bSjGA9IMdfzmGeskXSG7TakFeJ3SCvKYh5ekiDk1B85rPAg2Npp3fnwFwc+/cxwGpZ
	 AEr7E0X9h7nu5znHuq6lfn9Qnba1qZLs5mSTzOFbenfTOTMYqrAqIpGKO/sMLcxCwC
	 2fgc1/HlaPPFc2IO6Gy72nTWgPVz0nf3UQ1NYN6Pr9N/CrqjbS3ShaEqbGE8LAGGIt
	 ycrmBRhXvfBi9gd9m8JuJM6kfpP3zlW9xLYU8QNfA6cmnT4GwNl3O5MZWNPdRW5kjA
	 niOmfytrmDTvg==
Message-ID: <sashiko-outbox-219243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 15/17] smbdirect: Remove support for ITER_FOLIOQ
 from smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-16-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-16-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:35:07 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
>=20
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D15

