Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833899;
	b=2Si8tvq8KYx1j8klhOrMTT5SHFfkrA9WK/Jc0+q4P9iT9AYIhVq9hkYgQLtLTcTJlalG
	 6JmNx2iVnEMwNKthcSlOUONr+mxaEI1+OU5QzYdmVnR408cDilV4oHkkhlV8YjqUhA0i1
	 eO3kFm1YQ4mGcKaZdPT9QxjJTe2BtHl7EgpRfqXuxB+t6oUEPS4/vl/QlmHgDyl3qwGPe
	 Juqy/clqkEkz61/zhlTqWEsRFkf63pkDLgDHb+eHO3jidRxQHbq7EH3RrIHvjHVZTASsh
	 2pzmEyrj1L//fHhBrDWfcG3vkjwXEJMsy5acyKqV8VZV2/VcbC2NqhQbJk+WZBm697w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pVr8BPhW85DaIKUmH+f4IeIdXwQdDCffU4QS0+KuDqw=;
	b=1dbhKYJYo8dE8PqBCCEr/bZw1WJa9WPq49NaD9PQe2B6X547MepOERlisZcVcNwwTQji
	 j/6JeRZhHI3HvsCBIZxCQo4loUyjCfT7iKS3DzMhsC/EhM9DHe+bhRvftWcnhtMQSiFwF
	 FChTCJmo8zuyoFpeTIg+sDoT03/vnVQp6gQMhZfr6FmgdbucdQBZ6f+HTd3GczMQJtILt
	 OoV418eYcyVhr+qButRJi06PYpJvI1lBalE+2crjRJHF7g4mC+gylufioTFakE2mYGK0P
	 qKoXGeLn3Q3E+bOnd6IgAZd7+iaVRXK5h5viHFj/dck+iXacSk6rQfG21QcVCSebeDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4iReCHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A14606A31E
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4iReCHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553341F031E1;
	Sat, 24 Oct 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833899;
	bh=pVr8BPhW85DaIKUmH+f4IeIdXwQdDCffU4QS0+KuDqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4iReCHFfjoYSXK8RvCDwbOG/fYAzZ0SraulWh+HDHbir77UM74rG/yE6UiMIMdTg
	 MD/wQvn+QWCWHMUKE0aPLi/bLAauAiOfO3Zeh88gTzVDqxytawPwUmNPaoKLLsh8A6
	 Ek8hlFFGaSYgNw2UR864QW4ZDmzhoQzwCDeVwWMiPx+q5Ust/CxT/PM8h25P5sGecr
	 DeSWhobjSKxWX8KY7rbI2ri+m3KYdKbNF/2Mxy4hI5fpx07jY3T7sN50cMt9Az5P7+
	 tXfacOjz1q6de0BgdizC1pgGQo0GBdJ5wNg4Nbael9Ln2HP0nI6Xn8OeXbOn6a4Ls9
	 ocluG58ZvoCrQ==
Message-ID: <sashiko-outbox-183611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] 9p: fix header guard comment in acl.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Thakur" <codeankit.thakur@gmail.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261024092154.1844-1-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:24:58 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> The closing comment of the include guard says FS_9P_XATTR_H, but the
> guard macro is FS_9P_ACL_H. Fix the comment to match.
>=20
> Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024092154.1844=
-1-codeankit.thakur@gmail.com?part=3D1

