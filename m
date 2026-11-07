Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068102;
	b=cvDs+HZ14UG5QzpeNSWvK12nh9To0BW1/5uGBkkkJmpNO9VzwQu0Yla7YdCxu5QXhetC
	 Ctd1X9t/Y4hwZcg+g0XCrgk/kdaeAKEJ05jw9WA0K2COP/gFsOPrvWFAoyRWsnCgZAG/k
	 ZgXQ0zBQK9D07IItmlLTAF7tVroZMWjZvma+HD16uB8rlFNCQdzcP5huFtp8Kyr+PQiUO
	 BptGMk4Ncfc8v4HYaubo/Mr/DdwNiE6DjtiJXjsqgCW+IMJgQNJOK0bXt/5OOJ6mReACi
	 MpeVsalWGqWeV4zgVGWv7mYh/trsz7jWEDI5Jlgsw1GGJttLENctYBVLKdRSHgG7/6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4CLVyfr6VREq6/L4wwSCGpNp6COX7ACpeCSJPyeSr0I=;
	b=Vnuwuutr2Z//RFp3r0ZQLScz62hAQbap3HrBsNMERvKTRxK2vmRwJouaSfoZUiyhiaqC
	 duLjnmdLv73R3SdX36SSiqYrNZsNoAcUj5ee0SGYQMER0m60qvxam6+ERTBpVsPfBWM/n
	 8zvxmkercBPEtYvfNd1i6BY6+hfcDH54JAas7bAKGBi4JBL1a9HQWfdD+lb0BPrapNOqk
	 eUxz3Adgk1/0oLT4gIw0rbGw8zGfgjbICN+rc/MwweXBEUolSrtFU2BJCb9qbTQmVfpZd
	 lijAnGkwonI8w8r18xpyKxPf9Wt+JwvOXAFovV5DadFmYBZVHJGkyigbjXq7QW+j8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6yW2SGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89170606D3C4
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6yW2SGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101B1F0089F;
	Sat,  7 Nov 2026 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794068102;
	bh=4CLVyfr6VREq6/L4wwSCGpNp6COX7ACpeCSJPyeSr0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6yW2SGRgD0DGY8YcQEpzE1BPFPiP7r/myIuOT0VivBBtorOj9oK2KRTZICxBoV+W
	 47nW2JHBsKRI4JJAbrpWAtFZweE2ISbqY1VNSUMu1cybWnW9J07xskncKNMZjnBNzy
	 zvYAc1sY7L5j9oEOafKHz6QUNcqnWHPSyK4UZRl3XcuXdpKZXG5GyuKpp4vPPG55DD
	 3+TequWp2DXr/ruwnKy99ntrGSuOQxEwRVOMXiHNtoeRsZjhL+el06FwzvjOVYYL/U
	 8ramWsCnPGmX/W/XeRI7D9I+upaD2auKQgfogwBzEsklz+GgVuo0/7D8FJmcen1Y76
	 r8jo+g0p6J1tw==
Message-ID: <sashiko-outbox-203035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/15] Add a function to kmap one page of a
 multipage bio_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-2-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-2-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:15:01 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add a function to kmap one page of a multipage bio_vec by offset (which is
> added to the offset in the bio_vec internally).  The caller is responsible
> for calculating how much of the page is then available.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D1

