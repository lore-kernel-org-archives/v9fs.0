Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445886;
	b=wV26pfsoHiFZreWyuKrGdMH6HlpG+8P5sG/gYZ6TegC1l6Ls44jK2q6V1kIV5iUz0mcD
	 XTAVAT+p2m1X/K+3Din15NmVqIOtJ6QfRyR2OE+yA9rLbRiPTJmUNpPt075JfeRdJ8Fmx
	 wOGfHgaeZ0MVLID1WGrJedFe3rqxjCsJ9iz9E8vKXp5RiguAeRedfoZLe1mMrbBsniAhH
	 dVKAdr8cEtALci6tqDYOlLZAjU11k/qYcM3BSnv3EIOI4+Z7GgHSc25uJZTi01mZIrZuZ
	 VJm+Pao0m9zlbSirbu0yhw/mjPqVe8VMO7PRjSNooJpG/jkzVtAopfK5eUpe4c4194A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vs7JgdD4xZ4BQ6bhdYWa9DIIEPc5OmlT+M3i7Za+Zng=;
	b=NIeMBM9IheYHsbxRNRne4jvOyg1cpm5oxjrejPtuAYnVPyZifkAFL4Ch1F05O3/SCp8W
	 v6SrGXth0BD6CkxNAG8lcgYQNeML9meXxyRDTdlkms/49rg4TsF3t3NHiJW5wYXyOPNWA
	 +axtsJGlaJYRja1eW1PTnEiY91Sj4CDgUinhRrl27GMRkqXi418MnORLSC3lreyWY8l0S
	 dxsTl1XUbvr1ClLE2Aa9NxfG66DtC2ztyObjAiyv/TrIaiCCGghzziDfhuA/PtXPq4btP
	 NqneaSCLGfNRyinaa0Qe1AgSO2TYIJIEV3dkZviyUUafBKYovLyQdpuH3PXOmjJxZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZuaEmuj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF957606A889
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZuaEmuj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6748F1F00A05;
	Thu, 12 Nov 2026 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445885;
	bh=Vs7JgdD4xZ4BQ6bhdYWa9DIIEPc5OmlT+M3i7Za+Zng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZuaEmuj4Dd27yELCBvFDUSE91N75vFAR11N7jxnLPiulhXX2f68Fq1kG/YzG8EoO
	 SI9F9313UPzf3j7GN0Vx/cFw0OHbE8esCbcL1cOmXlaCfxasGbZey9y6ogBTVJ1bOR
	 LyR1W5z/G6kNOVNRMXfnJEJ1Cs5fwUBMWqlV7oRdx3M0iSljwdvCNdxYhaH7EL5PaP
	 L0vW8u5drzOmxo5D00Ljh713oEN1da/bwRT5edRcQLU8YBw91LZz63a6UJJx9BqPgz
	 20nRuU1qWvWdqys7f7TcOD/F95w7OoFgW8SPeumuOeSKYRfctw2rKPXrBqzatHkYBc
	 K+NuQvGTnN19A==
Message-ID: <sashiko-outbox-210044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 16/17] iov_iter: Remove ITER_FOLIOQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-17-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-17-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:11:24 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D16

