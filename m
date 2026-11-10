Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307995;
	b=3jDHs7uLa+LuAISZS9NcmGvFJbIETIiWr8TNWmiifxuKQHoMu1Go44YG1N0yhuolnp/c
	 sRZH+GkbdAszzLutFY9XjA1qnAHpWEzlU9q44CndHeAX7uspaQOlIVGOz4nQr8JJ58Djv
	 KTjXiuHZNnvZuSRz7/cqGANvinCHzt/cZ8+vgkPFEF2It05vCPrC5G3vl2hb7yRonf7Zk
	 McG6lxcicYXz/r90/VcsJd8u22Q1AXkn5bSw1vzv2x9fTBZugj5hHcCbs3nKrnVQ0zAs2
	 y2Qz3EecuqhAuZtQ7y3IFGrjzg6T0CIdbdoG/KLrA4tzjvS3zsFhDGDQkifR02LerrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OADRfp/lToK0d62pH4PG6Qctpkt3Yy+E/djkgSCY54A=;
	b=Pf1BreaHBd8dQaaR2q9dUNeSvhHWmgEeei2BN3GI2BwaA8aj399rk4Gn55Y/0I15Ms6h
	 W4sem7VjVqGcaTbbTmOa9oOP2TAe47Swzgb5/whSer/7Dtjhf9mYjpsp9faqpeg2Lav0x
	 9Ar2zuFTEV0aLqgKzALitjqRrVsVjnP0oM+4+Z02Mi1GCpbRRga3upN7unJXHoeY9p9rr
	 ECYIsUmP2Ns1Tjmo53GQy70CsM47qfM0uwHY0ZsPWtxmvENaofR01HHe99FuDfaUjrQSl
	 q87UwlHjsuPzeVcxysExa+FxWvXNZyGwuRBR4vALXr8HiFdvTh2YHQiy1j7JB4lGYqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGSKozPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EA606A325
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGSKozPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6101F008A1;
	Tue, 10 Nov 2026 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307994;
	bh=OADRfp/lToK0d62pH4PG6Qctpkt3Yy+E/djkgSCY54A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGSKozPv0yoaQLhdDK8C0GIGFf8z3c9zd7FNKSm0KNahEzOiB76qjswTZoHFRmrMf
	 VBcNetcciWV8gpS8EoF1MG7QMGaAiOh4Zs+x0vyvj1pibDvfRNy9IA+wma1XUyBIvB
	 5OR290QRP7xOdVefji9qg5JDrWsrdMbInvl40v214bJpN6ZnFxMTnbaThp4gqzXssY
	 7xzsv5IW4uYWige4HAnRozt3oU8MHpTt+Tk0Tkwt94xYu7H8falJ7Ago7Xgim5pZUh
	 vP/kPnavEy8iR6PnPcDSdTcO0IB5dT/UngEtmmkx8sTLUUIdfKPw0/UVK4A8r1G1z3
	 kNl2LTUuE367Q==
Message-ID: <sashiko-outbox-206903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] 9p: take the tag of a flushed request from the
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261109105251.2545764-5-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
 <20261109105251.2545764-5-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:53:13 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> p9_client_flush() finds the tag of the request to cancel by parsing the
> header of oldreq->tc. For a zero-copy TWRITE, however,
> p9_virtio_zc_request() adds the payload length to the size in the header
> after marshalling, so p9_parse_header() fails on the mismatch with
> tc.size and no TFLUSH is sent. As a result, a zero-copy write
> interrupted by a fatal signal returns without waiting for the RFLUSH,
> and the server can still write the data after the writer is killed,
> overwriting a later write to the same file.
>=20
> Use the tag in oldreq->tc.tag and drop the parse, so a TFLUSH is sent.
>=20
> This patch is assisted by Claude Opus 5.5.
>=20
> Fixes: d28c756caee6 ("9p/net: Fix zero-copy path in the 9p virtio transpo=
rt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105251.2545=
764-1-lian@is.s.u-tokyo.ac.jp?part=3D4

