Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079904;
	b=DA3NfIhcH0hd8R5fRxruyFWHbhYqF8gplpbElWmclcZ7xZZK/CWkcLTBdv0lDAwQnirf
	 z3aMZKg/klItDuH3IYGI94FHSFcomNxm0rp/nsdpJ4iUarCQ6TSFGgB8bYfnI3nUUjk2j
	 m+qSY2rcSKtCE7ugni4lxe7uIuG9I8brOSQuC8h+1ijDtD1nXV62A1hM5W2p3wYSc2DJP
	 1Rk5j/rzASrdDj6nlt5I/uoJ8V3jGF1USbKKOTqpzQn2938aioB9A5f0IUkRXzOCqLn6A
	 0VkOPA3dZ+WiT2A6Mg2gtt64AtkZukCHfFaaLHUZndNxKM+eG1Z4cQUQ2bO/KOMtv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pZTAHFy88PWyoR2MgWmR0M+ZUo/Vwmhn7i94lCER3b0=;
	b=OjPf5Ayimv+APNBsVCpDHgjbqacPijeX4+q9MjQcupkBVZUjaB1LQBHePa7+MPM1riRG
	 JRKEnopDqd3QuOw4Skx9ZbrBNqU/IHXiChK1K82lR62Y2CiZFrRtz9G0XTlxRBj86JVGm
	 xJcj8UAdKIEbJ2dcoSC9QJH5XCWEWkoziTc8e1uq1zDm5ej63NQ526SOBDo0i9M2Lq9Uc
	 jxC0AHkuSVEwoEH+4+vqh4YMC2R8TiHGojXvLNLLEh2FTt7CNt/wjbrIl3oNKn5vktuHn
	 cx1km2NE1NTSWU5iCbLqQT1R9H9VldF4be1Yi6j6/ctXKM8FwqHeV5lMDQy4tdJvzRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX8QNlmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284AE606A326
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX8QNlmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC31F000C8;
	Thu, 19 Nov 2026 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079904;
	bh=pZTAHFy88PWyoR2MgWmR0M+ZUo/Vwmhn7i94lCER3b0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gX8QNlmduoK3hFGvVUDrotl/0rQZX0uYCGM75qpddCwt3wgwYOKH2cu5Ip06RtFc1
	 0+YD9BSphqgKa6zYdktnuFoj2BPfj3JwvW8Flh0FvP+Q1dZbXaMZCOTm4Ov5BRRO3O
	 IjZ2Q/bLFte5TgVc8EHT806CloBlY2MFU6KYfPu8WkL7yQYSl9US2U6l5j57QzWl5C
	 vAWjhntigJcQJ8HPMaKEj24A6uX68u0qxQqm8YydJvO87k1ZzfPFDN7lou49nhWArp
	 jjSy1ez3Kj2vvpJeKiTki3JXXmZQ58tyQmOkRNx/vJ4uhDdIQ7lbQauoRku5r8iAXh
	 h97V8Uc3/yO+w==
Message-ID: <sashiko-outbox-222810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 17/17] netfs: Remove folio_queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-18-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-18-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:18:23 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove folio_queue as it's no longer used.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D17

