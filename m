Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079413;
	b=GO2KtWLwiYgEqFf9YSWZAZBdnwxSpncTjF5LoTnWQOW8jALalK0fn7G1ORyTCVNCSRJM
	 ILcKOeoJ5aYd0NUUJcmJbWB0L3dree2SNUAI29N//pP7bNbpsc5c/AnwbbWg0zj0uMeK8
	 cdHxL6WWvtOt8WfxHODS6k/3+/zGX3houOIx3VRLaY9c9u9+fSSt9n9Sf3zmdcPb/Ojlr
	 K5Px1RdDpAY1Fnsje84LOFK4/3E/Iwu5bLrcOQLr9qWRT4yP2Lvh7GDnxqh1AFJG9cqu1
	 aiAnRv1yFKffM25hrvk7IJcgcJfQc0komjPfgqIVEF6Ufas1Ra0dmgWX3MIDm189rKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=alRLk0Bk8YD69LGF3/cQdPH485F8ITQdMO6V6nkeQpo=;
	b=NAfba60ZmvaXFrmpR6H0AxmxXPS260g1KauqO+VoqrsykyifshSrKnTEy8ORSAZW0FxS
	 ySWSTy0g7a2HjqB5uZtTHb+W2Io+Uc3SdLTmfApBTi605+Q4NBU33ufDNurdHrMWHRAbh
	 /T7r1MG37/w04T9V1tS+HYE7ZbD19UcJFpDeDmI0HD51tr8vkbddTJZJKSNvdCBn5jngJ
	 DTXnI2KO2b5S/P2yc4yWq55nApy22KVNBLBxgxZBx6W8seb9ImvSf7cv25hHCvGYIjKgy
	 EJ0IuaHbPSRJeVSNaon8xqxiLhYwDOTTW/XgppM+z5SizIXkF0TBHql8wb6P1cdMzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3j+P2Lo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBC606A324
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3j+P2Lo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DA91F000C4;
	Thu, 19 Nov 2026 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079413;
	bh=alRLk0Bk8YD69LGF3/cQdPH485F8ITQdMO6V6nkeQpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3j+P2LocalAHiutgXltQNd8DtY3PdhvFRSZA9g417bmr4xuUDl7diVy9TX7rKpdB
	 zPBxMYzHufq6cCMp15x372TUlN7fkeG4pMCB/Z4+UdfZJKgy24nxmkt/+UG/GwxK1z
	 BVtNfJQ93v2a5bLA31PKCKBrLwvPB43Tf7FZNIvK/T/VvTd6RDgn4r+vnfaQZQW9xe
	 9uIwT5P1I/MuolAJ0rRHLkFDYSShTzN5/LiG+zmqNFYYtn+kb+jTVO/MMPTcrS906q
	 5tryqiiaPwQSkwgijB9dww+wkxTssiwcyNbPjwvvjDGyV6HrB/w5sxtdowFGtYlS2T
	 EC3/yZjhvdCsA==
Message-ID: <sashiko-outbox-222792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/17] cifs: Use a bvecq for buffering instead of a
 folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-13-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-13-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:10:12 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Use a bvecq for internal buffering for crypto purposes instead of a folioq
> so that the latter can be phased out.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D12

