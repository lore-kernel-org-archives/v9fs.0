Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442830;
	b=DCi5ZKkvvOB3OV/+XGW6bfcdUjWWG4Eu/U/nn9wRjPevU0i6nN+z7MnlBp1KpMHS5aiB
	 xGHpOWUKe1nHSYrUZeYq+htmPDpM3JDPaQ/Ui0BRtbrGAlTCpp4nnTQlq7IfYyKFqpV0/
	 7Irr1u54yxR72Dyni66K9fETSELGWZSTRI2h5dmH8HmJIP5wwYp8FifmcS6GdB6h0ivW9
	 CbYdLi4Yq3QdCVwrSmUARgM0y0hU7kjpHkKTSHYqK0VtRLRWaYFzttmqZ229prv0IoVOK
	 EsY6j4jPJkmSJChN76vDrFZP/ftGPK+YfKAXcEhnzZ0hAbHRH+V+emPQoMI0V82qPhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z3rR7A80sLz4WMqjvjLxFT73rV9L1r1E8J0skvRD8FQ=;
	b=LELZ+c+C9Mg4uoquukdl8QciT+7MchOobkcMAzI9pfFPwewttPfEOen7OaTRa4bM66uz
	 qlXzN5lwyzye1smwtwe/pYPGA/GQ6xWvtiiv4unK88gW5a8GiQP0vNAnHxbh7TovHJ9LC
	 hr/MeyHkjBSdQfT8fdqw6ma47y92seBkrdoZm76Lto/5QfHqTMWTAgiiUoX8x0uOIJ+DC
	 EH0ftZSVGwdsrj0GcmM9ZkI9vptRJ41Sv/PIaHa25vBB1XfZbolXsLYcOWsp8H9jcnf2M
	 1fJD8g874uuKJfYZZYXANY5W5MunPKxseNoasKTOMRFPd5hmUAX8NXs2c7vDL36pDzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffd86vEI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61267606A321
	for <v9fs@lists.linux.dev>; Thu, 12 Nov 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffd86vEI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161681F00A06;
	Thu, 12 Nov 2026 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442830;
	bh=z3rR7A80sLz4WMqjvjLxFT73rV9L1r1E8J0skvRD8FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ffd86vEIFrVjvKOIoBfYosvs9HoM+u44oKpUUK9gRCHowBpaOqAFhPXDcw0SNvg1N
	 Bc0tR7FnY2Is4If90TiBnuyBV3+50Wuazk5JQCnN5lh2//LmVjn8/2dNTrIzU/EocI
	 EzMhMcxV8ecL6CibLGzy8E9gVg+yuJz/LdQKevr/LToOZ9dlPUPgwzdw/6pKecvtaF
	 1pw0LnmAYOoZY7Bey7WMr/dBXHri5Y+IvOR68bbaSJBBB/uOdWdB3bppb0gy+co8b8
	 GJeFt+mOM3clMLYFORRpXq2YYoYH5nZnpro93Ytd4RhFIYXfpERGtUvxiqaXfb0WtX
	 RVngQbCE4+WIg==
Message-ID: <sashiko-outbox-209903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/17] cifs: Use a bvecq for buffering instead of a
 folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261111203034.2126314-13-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
 <20261111203034.2126314-13-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:20:29 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203034.2126=
314-1-dhowells@redhat.com?part=3D12

