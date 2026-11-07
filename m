Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079919;
	b=23tnkWtyyaY4wnXZXjo7xSKaK3p141ukyyCg7JWJLGRsPqLofaH6kLmG/q4nAi7adcmW
	 7tgPHQE5vZ4AJ91CwJrGDYk/gdy20iYiPt1EM3ccUIYQz9P7ZqNV512vuJPYnRDw3OQD3
	 JosGOPm+hwRiWjz8l4nDWNa7+koin/82g6dqHfE6hRDH/RmQUUF3r1AQre1JKteewmp6P
	 4+lx5c66AFy2Y1x5syiHh+vTKw7Y3+lJD9WPaeoW9HPd4JrJeXm6ytioFvrE+SVVzanbM
	 Z2AQcLB0vh1lLTnkfDoehqBPrmRxAsyUH15lYCrNiOanh+L1b9/qpdDnWfsOVHEyidw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079919;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=biF9iks+6B1yYktuqcrQqlN+mPFa6vTeFkfoWIYEaDY=;
	b=JA4zP/dgMzoIfisph9TWYNLvprBXwwP0G+JXRMZ1rJssTeU1Q0yRqq0cQbKuxA7k7dnm
	 hIxUV4kbhFTpAryLI4Vpqojkoms+tlONIu8iGaNcsYx2FsyQ5XEQXQhucFxZ+dXm10bVc
	 GQQB8mwrgkLjrgqQxRi59QynK9nZQuKH7EybmrBZTPWT9LItmWoPdA1W4xDu25o9ErkUS
	 NjuyALZsaqsjU7bR+uj5YwZ1ZZG7ltFNICSUwjhohcjGI+mGBbDD2576x2VUkuNK1i28A
	 6nRuYEly3G4nw+ZdwTYPLUqPnzNmWgfdZwN8/Y9ZJTNHOs2R1c4THdfL9OqELlo1KOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3Yze4hY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACE606A336
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3Yze4hY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B271F0089F;
	Sat,  7 Nov 2026 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079918;
	bh=biF9iks+6B1yYktuqcrQqlN+mPFa6vTeFkfoWIYEaDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3Yze4hYk64n4qO5m8fSZ0w+YOL/GgdPcz7cs5GGuBBwz5bslXO6cIH6ywY5BsJ1f
	 oLhDaJmmhddGSlLR6C/RJffpoaO4FvxU0sR2dCCRele8h6qVhFfKB6HlhSxJk4WPpC
	 0gYVtibFtJnqOYn1o7wZCWTvZm8AQkPazUyQ3p6c8bvAfeQ06aMmExEawei8yME7AK
	 XKi8X7R4HTZ2eHoyaX/moKz83qd8QVuCgybIjLrGjS8zn4YVSzz9P062kKy6oh+eZt
	 7iVRR8A5mRdT4LUqVRfUR6xuK0NJNtqHITQREJO6gXuPJva7865tNLYVmGSus7kuDl
	 Qih06yyoIiwkw==
Message-ID: <sashiko-outbox-203211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 14/15] iov_iter: Remove ITER_FOLIOQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-15-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-15-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:31:57 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove ITER_FOLIOQ as it's no longer used.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D14

