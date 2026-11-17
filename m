Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937113;
	b=SgCBp0BPX3yblumLgPpJpwRYpsMd7IcoYF8lqVH94q9GXnu7s0hd+PUD5XvvTmo45DJx
	 dq4sBDR0MS5InWDoj++B+7l3m4oSVz6ggpc81F7At6+2XhpVdeYhEC7qtuOpLpAwRFyEE
	 40unUyy4eNxfXCs6Fbkr5PMF71eg1GRstG94DnmUfykMDwdf2NbTdXTmImncbtJkWcT9F
	 11xIJ1pJPb9MpeFy5Phco8/SRsiUJylpldSMnfk+J4bjggSJwTTQanpzUUug5nLYcHMvy
	 t86Ygo23i8+Pz2E8NtT9o/vim9J083fRfPxV4oIaYfB1Z8ujCei5Y0ijhzysjgrF1Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937113;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+nmCJafZvGAj6qAn9dODMVYOYcdT8Df8tRsxm4N7X2o=;
	b=AhjS++Fr93tacK1AXZFYJrJtvzMgGy9Fp0UvJUgw47Z+CrRSu1w5+7hvys+J8fucubdd
	 yODcPm6Pe44sL0y2PCBJ32/ksiHJ+BwqfUDX263ivqoGeryWwrdV0lE1Z/jRJkeKrfMfQ
	 9LZIB+/uSm6YHeoi0rP1HV6PYB+jfeDPhcsL58OyY3dFTGkNzkzPj2Qx6jymi8Amm4F+H
	 hr47I531cjbsfHs9hZOqpT655k8+vl4qevPQBkT5EhbJ0NqgjgW/jEo/PV8PCGJMjDeEn
	 Wk2NPTeGguH+jeDxh0+OFP7RLoQN0AO+cFZUL441/oh0EU7ymQlHqwOfOH6sZezgSdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d81viCdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC94606A32C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d81viCdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64921F000C4;
	Tue, 17 Nov 2026 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937113;
	bh=+nmCJafZvGAj6qAn9dODMVYOYcdT8Df8tRsxm4N7X2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d81viCdKS27iGjjiHAJACNXZIIYZlFFLLWBhfiGNYr0yC+s6ZBI8VjuHdSqjG0MY2
	 FiSdjtmkbjnSDEAQxvq+CCz/1l/SZjwiy0XASBl2hT6+GSA2bF5wrihgl62V5koJFk
	 SZtOUOVoiSZVV2J7nsuhOS+xMpneLv4lqEPPf0AZQBwGEGV6TAmM39awVVp8wroJ7t
	 KWEoCTCfdfK/9v6d4yx6ngIFKv19zIc+HruXKdW5cW360amWB/6nvCnNYcs0a3mmnv
	 jo1zJ5S6YBBGlittxwejW3p1RUmVxeb0YaquK86Tv/qQCVNnqmPLED6rQHPIPwdj7E
	 esqFFFa6hRUVQ==
Message-ID: <sashiko-outbox-219251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 07/17] afs: Fix an inconsistency in the symlink code
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-8-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-8-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:38:31 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D7

