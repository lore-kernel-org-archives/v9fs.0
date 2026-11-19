Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080006;
	b=usKDioKXJglqrTF7kv0CMbAsDg517HSwIFTLd0osVvovk4rpVSjAzJ1TWMbYA98N4IFK
	 bFzz+3Oc26tS2qL/xJvoV9+yfHcKC4kuotJAiykVYBuBaP4IV5b/T92FZu2ZH5OPvBCjm
	 UGeR1nWijnzbUy5fKOOTpvaegVA2B/tCCBTNuFtWsiEBbuJPJssTM3acxnd8MAaRhfGY/
	 zjdIX6tKmJpyhz5rP949gETU6lZZxsHZaHld/+FCal31aY2R4GSvublTqN0Or9TFXVKrI
	 S1tHuQusOnH9/QVL/d+cxGIpqypM8nQRx9q/7iCfjHDH4/kYmtHYL1YldN8nacTLF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LXRUEW0nhg1Wutx2jbEcq8bSzU2X7+5Uy6W9i5Rsm14=;
	b=bLt9psaFowr1HZdDG6Bqmw1272QHnoIZ7MrxVxVfoVuje4IpSOIx3fo7pKr11auj3J1U
	 xhhisvmbZV2vYU9ZW/1PEUOJeKhFyV6LBjL5No/9efvdkSfdrRYnQhPD2K4D53QwIJJN8
	 VKif2l3HzLLjvE1uXOG9piIL3CerOxk+zsCs7n1E2cFdT8aWd/ZNHaQ3HLk1dp8D8TEVs
	 VvnRfG4FwjNOMw646z2ggwDybQb/qlazYDKbgGQ4FucIlCYCn0kuP/Hesx680oL8Ad61x
	 XiT9A6XUB6+DKi532r6BwYphllLMcw9mC9HgVZZlVu8fgmclrXxCB/hLnFWTmQ8PN+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/Ss9bDG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8943606A326
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/Ss9bDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C99F1F000CC;
	Thu, 19 Nov 2026 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080006;
	bh=LXRUEW0nhg1Wutx2jbEcq8bSzU2X7+5Uy6W9i5Rsm14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/Ss9bDGkrz7RQax4m2lZp5kvJqpqGvO2FM9yEkCN+eRgxZNZU7utb1oc6XP/E+bP
	 yAJI3fB4LiEBdkP/Nxz4L4CcadKthVBBYtxBI8hCtfM1yOqQnDFC6ySAD/j65fBCZz
	 Tf9N7zsRa77qlFvWiJiKwiGmzmOWD6S40kPQFBU/DI7fRM1rna5Zz8cfgCCmd2EmTq
	 soz9+/h8FA4smtfvj+CpLjMTNF7A4oN2i5yxeriZnbG7jiTagN6QPwUm2dXL3VDrYM
	 im9E87I3QT5EO+b+Pon5OKKED5Ya4KavyemYoEqUc5YXP+2/nxQzGAfqtzTKsAw2KK
	 wPEe8ZD2MMhww==
Message-ID: <sashiko-outbox-222813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 16/17] iov_iter: Remove ITER_FOLIOQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-17-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-17-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:20:06 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D16

