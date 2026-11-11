Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437122;
	b=EHR43l/PqykNX2GYygj004VmtYfRs2WLVhtSu1MQKdgVUvpFsIRMQZCgmvwJ2Ch7kwAq
	 jV1PHNjbZ1Cb+ONdqOIGaevuENCqCjs3IEQUjn5NqSZ3AqtTNWuhK6obtPpW2g35s1Kj1
	 LQYsBAJyiCxSbO07WddzAjuDwnedtfVY97P48/foZ1G3+pOVsTPGvstSHEjo1+LcOE571
	 J7SQJfyx6GARY5cfcviZdDXlCra5m75xsgmjccBtIXzzn+lKef1i3kpYCXlVZ2TFSncNJ
	 RjmSetcJ2ZGYmcfv+n/lsxD5Dqbk4jOv+YG/4nMwUSqi2gbvPkIy2qAhk/UFjXCNXzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O3JMCVVOQZrWDlO0CWTXekuV/IYBWNtK2T7z1Mwm6rc=;
	b=b7HPg1g8s5wMCL6munN8E2aY+Sb6NkrrFIM50nY2b9XVm5SgmN+vXF9WwMt+MQZASNqu
	 yBYdY834x5zWC3rzP/Z6LY8MfUyT1q3F+1YICRiv4cJ0l8mRsPPquWZQ6klaIgDj2ArLv
	 ktXwQuyBdLXgjNYfbARTLLeHiIwCZHX+j47LdLuA3qyvkk+7PvM1UBU6KNHiOueRbWi+q
	 zCkxOyiICay9Jd+bDTI/ULthpMDe2o/jIFDEwW17ysgORauI/GoLWIW1Seur8A6ZChAAF
	 lMKbVcmQyKoTFGi//tTdmzykvrVtj7j35NWbKWRqVOdxVxVDXfyCsPamuURebPYHwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nyIbL6/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261A60A383D
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyIbL6/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068AD1F00A08;
	Wed, 11 Nov 2026 22:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437122;
	bh=O3JMCVVOQZrWDlO0CWTXekuV/IYBWNtK2T7z1Mwm6rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyIbL6/9AuM4wc8hsVgQV4u3RkMCEeiaV6hbmtPaTtui21AkvSJeKLtSPCIXJsVui
	 fUwzqiLSM4rJv1YuqA3qPjrWYRu4vD3dgbl171gT5Amo75c5IXWC3xMgbj/phOdVnS
	 N3ouNezV8lqco8mmWrGJipuCCnJK4d0FfOT0F6U9Xj5ZUdumjtktPwifX7vH6LE8mK
	 4wncEjW5mXAGoM+cN7Af0A84rtI7mctxe0B1eVgkpIuPB5atsb6ba1W4C1gSYUlITK
	 GzHm2k5qb1lM4CMwvtRQ2LHwGWQMAndJyvDsuX3f/BMh+VnZJRB7xcOGOm08ldXTOX
	 CA7DCK2OylAdw==
Message-ID: <sashiko-outbox-209826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/17] afs: Fix an inconsistency in the symlink code
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-8-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-8-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:45:21 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D7

