Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937078;
	b=2p/TIqMp9HyKhGQkX9xJC+q8ZUvB3jBhK6vRWp73toK/Q9nsZZNEbXdLaYi6X02ii3hM
	 4n/CSvcTS+S/mhoC2NLnKo3SFTEUvSE3rNsA3H7mha3a3ZRswj09snI/BFws1wQhUKfx9
	 hBBmWzytBONgAYZXSL3FQDXCfnE2KrDHdQFW+m+MtuAqVSxBShTcyc1OZdT4UlEnLzI4u
	 BN4uxRyy8uDtdtieVtbAnWFbUOqsK07imaN5JIWz4+TpmFlB5l67fIkllHI4c89u3r5hc
	 Ua3g0U2c4yZ2rcJBV1vuOny48pjwOtwrfy2DR7CoOFbKQoYviRZ77QyvAu0Zm5XbXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937078;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RnXJ3k/kDvU9Zb0DzUMBqze6JfwOUNvIuLHckRULRCU=;
	b=vS+og2R+nhKHkCwNbqSY2OWy6+Xgh3QlcDiU+oZWPRk/NzuDKXCZbla/BLvLTIu5z+10
	 wXy2kaZW4gGvWBNRmrprewa3AZMSZYU6YbG17mzvHQpJCwUfywAVEPKxVJ2+MTC3oI+fP
	 koiBx6k87whJ+3XBOJRPLuqjGmVJBP2agApWja0E5SSO9qsD2L00dLgXEQB8tRO+icHoX
	 zTEC5AyKLidRm7oD2sWwed/irPwdsU9d6dE7ocRJ/yo+DzZLcDtxAN8hH/zH5bn+vSf2k
	 yaFoDjh1ciAmhR9t93ISSZ6NWyK5LxM7Md2cQ4VXh1f/wsOQDl3d/FfjU56ahXRJmFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+3FsqCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE7606A89B
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+3FsqCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C6C1F000CC;
	Tue, 17 Nov 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937078;
	bh=RnXJ3k/kDvU9Zb0DzUMBqze6JfwOUNvIuLHckRULRCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+3FsqCqfE4pgk+FPHem/KRLStt6p9noMANHBC1M7b4gY+TCar4vbfzBpr3SR4NeR
	 Qnou5GJrZq3A8UvaWQvEzuKFgsTm6FT0a7Eim6FqKN7xvo5T5cPqdQl/a5voeV+SOv
	 nCWd8tTC+I4jKSfXKEZl8VUsOUaeeAAPQlCRAAE4pcO4TaswXyJqS9hvybysmAzuBb
	 Cz0xhIPDq4dNYJECyCNNXentyz+1TZgOHTi7ldvl2BXDQ1thIhSaZWunRfrWmv/N/Z
	 ax66l60mkXQLcb3F1fNc1oUgJ3POWJ038pijPj/OHWR6E855FRUhi86sNaL57/Mj5Z
	 YE6IUatiH3p6w==
Message-ID: <sashiko-outbox-219249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 17/17] netfs: Remove folio_queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-18-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-18-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:37:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D17

