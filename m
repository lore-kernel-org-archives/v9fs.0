Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759555;
	b=h2FA5hwYASLJUNKSeZ02db0OKSLM5XSZDASdUgGZK/j6NwJbj0nXHIi2sP2w1pqfKS24
	 hZNyAAsyDMPOhUKLSIRl/BWWjgZsMCkOYW2qdQS0+gSKuad5bhjvYWS23g1RdTXIDahyY
	 cy8/MglfQqdFNARsks5EvWUu/jMbzDzDjTtHLdtYcG7xXfioVtYC8BRzLmCM40fz2Gg7L
	 jCZSLgBdWBxbtvJLl/g5vKAyljrvt1+cUUI65iMHtODdJ+GgwTtAcaop3RuJA1ipobwAh
	 snR+Sslmo9x+kwTzilAWKgXx4jHwi3TzyyFtrq8n8ylIFWkPw5f6KfrzW7XdiavG3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iQgxpc8rDNBzOdFc2QZLqVPY5Wvl67O5kkPbJXeZH2c=;
	b=IiZsBi8wiK+GMsoMLSg2T73gZKl0hDTUgQNmbtXXRa2L6+RJ9VrkRt7qc4xcTUwDJwlZ
	 /X67WjrRdk5ydXgmNnm7rfHCYtns0iHscbpL6wopGyqf4M9sJ6oQ5M13a6V+NUE/HVSuO
	 svwQqXjX7RhSz9EGLcyCH28AFKKCEFDZVksN+jDeb7ufjsx7klMsPj6Q4C8sXXAcMdZHa
	 GHrRidQDH4qxA+gI3pabg/U4visuBhH+dDHX2TF99+EUeWy0OqnIsCz9g+z3fI4taWarP
	 IldrtK11pTHjjQcrRO0v+kFnC5L+dDeuAvtbJt2OR5BqZlg3iQRsqSqkOJqMR08rVJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQlJxrfV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1D606A31B
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQlJxrfV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ED41F00919;
	Wed,  4 Nov 2026 02:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759554;
	bh=iQgxpc8rDNBzOdFc2QZLqVPY5Wvl67O5kkPbJXeZH2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQlJxrfVW65c7eqiRz61asOepHK/Muxd/zG3Y7toVE9BGPAN66RVxbbBzYSer4o6O
	 7uky10AgRNZSLtiUuUaJ0kUDeVZ9iD7RiEj9U5XeGNIZRVHZu8dVUE9s7CPeZxwZKL
	 c0Ozq/WS321ysreqMU3RzXETfHYwvx6vznd0aKA4cQr3YDf4LsqzNytWIZEvAATcTH
	 NHVEyLg4UtKT5hRcgwsTWcB6w1kURzynaqEDU9QyPJmQJ6SY2sCFzukV0sa0y7W6oY
	 EZMoo+t9ZhUD9u31HJeQdVrv41ZY64+pM20VXoHt3ofEUKV2ihR4AIl3GmAfOKMRIU
	 YIbg0INoHBt1w==
Message-ID: <sashiko-outbox-196497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] 9p: release the request when the response tag is not in
 flight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261104022807.1484097-1-vulab@iscas.ac.cn>
References: <20261104022807.1484097-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:32:33 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> usb9pfs_rx_header() takes a reference on the request returned by
> p9_tag_lookup(), but the shared error check returns NULL without
> dropping it when the lookup succeeds and the request is no longer in
> REQ_STATUS_SENT. That state is reachable: a cancelled request can still
> be found in the idr with REQ_STATUS_FLSHD, and a duplicate reply can
> arrive while the client still holds the request in REQ_STATUS_RCVD.
> Only the parse and lookup failures may return without a reference.
>=20
> Split the check and put the reference on the unexpected tag path, like
> the other error paths in the function.
>=20
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104022807.1484=
097-1-vulab@iscas.ac.cn?part=3D1

