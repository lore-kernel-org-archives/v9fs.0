Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443277;
	b=Q2BXXagdO7X67SZquoQClwyCMAiFjpQNBS0E/LiA8yiKzqoNopzR29MYedELJF/6BWbW
	 Rzinz+B+06asrC1TIflXGy73giYR5pRFeDVcVEX0GXr8EN1N9LWgT7/lcTji150CR2MTU
	 aIbsHiv6FykZE37KtcY5JpsG9oLrnI9M7YL2Yc7/a4OX7LrzWDpLs0LPYCGOThZfRy8Qr
	 1wRpuzVcKaIfjDlqwG2MSYRmG3Q4O7088M4kqKFzMyHS97xjX2u9qg1oXHZB8Dvj/BbEs
	 ZupV92NWJK14uPnvZRwS/VCBjT8TX5AH+dm+l1mSgRACL+DHk5Te0HLeF1m3rHde5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443277;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+7fIesUDqFguNs8oerMqlClMTWN1VKHhfjz1EQQvIBI=;
	b=WUAqo7m4s03nqn/uYykSZrxPRZjJhmI6ZHWBYFh7+WI0r0q01/sTp+ad0vdjpn+JA3hQ
	 JfwC9Pk0Dls4ir2ebo0KvbFa6VcYERAuJLEBcZy7Mlz5AQCQFJcWu+t9zsXl5IRdZ0A+h
	 9Xhi5+X/eMk9iloUxXzE1XY4KPzVkJTgHG8OeXzXARG3lKL5C8D8rqvE1OcxkeiAgeY/K
	 M45YJDofDvuesXPluyEFJX225SWZy0Z6ZWbeCDvwLobfBIbj0Rr1MaZZl42Ei3FP4J/nB
	 lZkcBeVFjfeyhMPNL7IjMYB/ccp6W7d3WUMnXcPDOF0pq7UOagpCuF681J2OP9prJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7dPuCA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C0606A326
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7dPuCA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2FA1F00A05;
	Thu, 12 Nov 2026 00:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443276;
	bh=+7fIesUDqFguNs8oerMqlClMTWN1VKHhfjz1EQQvIBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7dPuCA1Cs2oI5FcxkGli7KSXhYncyiBL25y3ppPdhGkyjX0zHLp2o4Fm6a+bBmMH
	 6Nu28hj+GmDqHLRQJo/FXV9HUUZURpvLvnwe6Kluz5AcvS5zYC4+p00XpFsLjRS0t/
	 YuNmtX9YYV1n0KVTQymtiZ5phgpab8NYaIfIRYUK3hchTbs7PDTuS5acVXr89W8TFp
	 ZvGln1HkOyQHJrAgxRUp6dyFnavbaM2XjurwAZGG7WuK6VM43ZTO397s0Ch163Pxpd
	 rXPM7sMPnrHofgREUJSF5ku8RVA5pY/rbw2Mpd1WEM1JX9OsuGd5lA3m0wbw1YpuVn
	 08JAAv2xy9fPw==
Message-ID: <sashiko-outbox-209918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 13/17] smbdirect: Support ITER_BVECQ in
 smbdirect_map_sges_from_iter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-14-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-14-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:27:56 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Add support for ITER_BVECQ to smbdirect_map_sges_from_iter().
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D13

