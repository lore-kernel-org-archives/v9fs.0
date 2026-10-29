Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253791;
	b=cBRsPOE8lV5ll+uX5+UGcgv9RmM01J5Fz9wAH7/ai6lD/Lbp6MkPRUPS2pcZ13lniuLt
	 a1fe6GVgCXkgW+xsSFDXEyEHHvRWkUUonJX0rod+IjdQEjy6ggQlrZdQihS0THi9w5bH6
	 V97D2PkgREOvRPidiKP3A+684nW79AowC3kBx9dF+TcNbJOSx6Nf1GA+4AwOrrWNqQxAY
	 2kCKkFFRkXzp34SRvzDHdtYNUZaFIBEW6iCXKlkrKFujezsHWEnzK+dJmN6Lm18wK9P1E
	 NFZjOxpYr/OU4ndsICzWbtDz1U1yRqmINiU5KkSJSFg0LE+Xe6Y+1jigJAo4ZeS3JBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kn/3NKgh2nSkHRrNMc5Xiz9B6ou4t90HP8GFBRYFYc8=;
	b=TIs580YrX7+521l2SfVLmklNQVxaJq7qki5hr8fTdDDDQTlN0E0ShCbzvXPlCUX7EvFx
	 gMm9H5gWHEpVLiEv0KRGEn4YyXtWhg8ROmbNKqtLEk8lcItS4SD0PY9sELS3G7kI3NbYI
	 FSZKREKWLQoN8zt0AU2PvmDLtydhYsKw1qyxoPCQ/ZUJ2E+QgBnOP6ECW4PRaFsayNgyI
	 +Q9P9Qzn3JrZdY+MuTJ6nfaGBokt9N+J6cgotodoIWulN+FDaH3skfExZQnJYsB3TEt29
	 vC1LjbnfBJcoRNSBZ4aMYz8hTCELSlsJ+cLdGZj+OsB+eUeogBLF5zLyQ6yzV/iFOvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzO+m7HC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB92606A31A
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzO+m7HC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BF81F01825;
	Thu, 29 Oct 2026 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253790;
	bh=kn/3NKgh2nSkHRrNMc5Xiz9B6ou4t90HP8GFBRYFYc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzO+m7HCFGmTd2zlrqdP4/TX1o0dTuaBnQkcYCVaNk2bSPHvAAbPy8ghMItkRdTFq
	 DMJ2VKElugYbFu8FTbb70L0UanLT46SDMWVeJ7FRJjAOTfod9kMHD2itFqEf3mPsRs
	 R1aveIRl6V/bDbl5KMsgksb0IPlOImh9q7TWyt6sHrfuzVjqZqZq1IfvfNl4PJ0G47
	 /9HTZ3M19SSX3rNBIY+o4RS6h4Vs/sGLGsl2cEhsYs7FNifKzdhMsia/SH3kBf+3aK
	 nsEdXjHHmL68timQaHMr4NLgwqbIceqMPqM444PCji2swuU2sirYDJwIakYOtBBreE
	 Tm2hytfDq2uxA==
Message-ID: <sashiko-outbox-188787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] 9p: optimize p9_fcall struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261029060014.3-1-asmadeus@codewreck.org>
References: <20261029060014.3-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:03:10 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> p9_fcall has a 1 byte hole followed by more data and then a single byte
> element:
>=20
> struct p9_fcall {
> 	u32                        size;                 /*     0     4 */
> 	u8                         id;                   /*     4     1 */
>=20
> 	/* XXX 1 byte hole, try to pack */
>=20
> 	u16                        tag;                  /*     6     2 */
> 	size_t                     offset;               /*     8     8 */
> 	size_t                     capacity;             /*    16     8 */
> 	struct kmem_cache *        cache;                /*    24     8 */
> 	u8 *                       sdata;                /*    32     8 */
> 	bool                       zc;                   /*    40     1 */
> [ ... ]
>=20
> This in turn also makes p9_req_t 16 bytes smaller (152 -> 136) as it
> contains two of these.
>=20
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029060014.3-1-=
asmadeus@codewreck.org?part=3D1

