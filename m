Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079747;
	b=J+76/IsobYUWX9RjeTB72aAYrXF5nAXr6IztOhBzQfXkpnbEI11oDkTz1EkD0hMv2YF2
	 EG6nAa3DMtZ628wIoLDVCe2+pizQ1GuadOikIDOJaMC1gNAziFz4z6SemLC8JN3RVHNkn
	 WNuteVHPRE2Xm36pTuafoXEV4HUzJYT9Cob5XBeSoHpoRzjQWylomCFOiHMIrKgA9jLwj
	 enZYLP4KnoroRADNIgQW47+we/eNOPsyoCBHphm5m0Nw1xDxCRhpy2q6n/7sLJPduMtyX
	 GafMdCfu08ejHkSQGgZNqk21mEuhe1/nu6LQRI6pIlZB17Aj4f/4zyQuGZ2IQqo9dnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7lMa9/x5FrUgU315kn/ihjBjmT0nyWMYyDm82K/nYI8=;
	b=EJYEXmXYKeU8GxjSnY15JvbS/iTkgF7v+9M/XIPCkmm7h6buopaWl06smPEG3/SCR68h
	 h9lvIlJwkBxQKFMbXBeLLtrCeBCYi68WGoclExc5uhx5sQ3MVeTdd72dIjbFWgdWrvO8U
	 PuK4GVRm2wkGmzfrKd3VmLjrbGZQPXJNIDu9kFJLY7ghUE3HT1pFw9jJbDkUeTNhQmKve
	 tDsoLKG1ycHO+zeLTQZeCeZcAwSINlJyDqwfG8MM3rHetrlw0HFm0OvAl6Uc5XBy33KN5
	 7AalwiA+kRxJXMelMY8kWANTCXrwhI1vRIqdoG7AFHYtW/SIaliHl3jDxEG3zZ5Z8eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3KDWRb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B908606A32C
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3KDWRb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A81F0089F;
	Sat,  7 Nov 2026 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079747;
	bh=7lMa9/x5FrUgU315kn/ihjBjmT0nyWMYyDm82K/nYI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3KDWRb9GTFHzHi9ZL2b2YicGgUDIi8UeHOFlRg2aHQqBcuku4RHCLCp6BGSsraRP
	 oJAMwcg6GxT8Ab5+RZnZlLNjW/P0aBTbZgYLoG120C948OXP/ExPZOYKrflmLbFED+
	 Jig9its29HESjf6DuzdbRVcgrlP9J7DOzhZbUHFTtDKOKEMl7cTck7zBryNWfKi5IU
	 lTpfJsnUKzU8SYejHFf1oHTUNHvTZtOzVeOZe7UCQxSn861QlIIj1z8lGhdrGwFiPi
	 /f+tnTkQpQPYS8BjN5mlrL+J7D/m5bH+/Mrj4LBiSvaDWhFPMs0rG35yQ/LCMdLZIk
	 cID/c99YBNA2w==
Message-ID: <sashiko-outbox-203210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 13/15] smbdirect: Remove support for ITER_FOLIOQ
 from smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-14-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-14-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:29:06 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
>=20
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D13

