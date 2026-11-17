Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936888;
	b=DjFqU9DTGnWjP3HMdQW+auv2/f+YUR5iSidMQREhYJfbxJ5cc7fUbHf9NkVz6zFkgjDK
	 ewfF2EmCaSQSlt+F7uyUo6fpSG2RbG6X1sJZh4UoB3Q6+fjzVGereRAk7+PAiLt/f+ZMR
	 PtdAOFS/6+2plQ239Gew+dJHm2NQ4J4/vZnutKaXjXHVZTvrLtVPNsQ8krBdu17qldLhU
	 I6Iwg7F90ChCoQBQC2H+I53JDnwTU4J+LL8dIGhC+EIavVrs1DNs0rTDDcavWmreYM2fh
	 tfu1QEU6UDLDcR2IW+tGenBlhu6eBY81EwIOfiANjLJivgqCZFgsaaff8Q7sWatxgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936888;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BRRiPWwUWz0l2GNTM3QTkLYpzCBeSjHMZOXBgieH4Mg=;
	b=wOMxYBmEiEGSqBSeWdshpZQMsw7V2PxPeYn/iT0OLNZrkhKFbyv6FmHgvr9YWD3LewNL
	 CaI6g+l5q8CUqyWf4qUTwkvKCBYaJZ6Lt1Fm9o5Q+LXxB9ePa0qnx0ggTwahV8DF4wZYo
	 Kno8eiBlLrntllWUJX40uTHXXrUUYqoh0lpVnXc0Jez0v9CgykbW6u+XgRpZTiOSeYf0v
	 J6mZyAm8mO6ZsYa3j6f0V+yc3ueYJGqnib8G2cJLJXRBOsWaipCy7E7voJebUVC1faxyD
	 x8Qt8dLObeIFdrwrRRWSNaYvZMKgVVobIUWsYppw9j+VVwkuJC+p0EyGkTQf4/zdntg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuWC+WcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027D606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuWC+WcP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A664D1F000C4;
	Tue, 17 Nov 2026 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936887;
	bh=BRRiPWwUWz0l2GNTM3QTkLYpzCBeSjHMZOXBgieH4Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuWC+WcPi78vAUaO1oZmB2y0v3TxpcaJxFymZwRF5x98LQ57AeEHbM828zhS62F4K
	 kW3S1pAy8Ok8WkVIpBMOGx27Vrwx+Nr55sXbCqzaql0P85zHzlPqB99jdpNuvP+WdL
	 nhVobDi7dvNLU1yysE13g9mRNVO6Cz8Ky1jXd8ROUiUT02XDjWM5A1bq0WsX2RRiN2
	 GBZ/NrHWpLsuFCd8w26mRBol67EmEG141uSG9GyJjc6V8okl5236DpsH9Kaa3CJsYp
	 HFhFjD0QrqJQVNGXCqSm8XxIyncebLns+R5mPMwNxjXi6wRos5Xig7JskjntmT6NM9
	 t0AmrBgeDQaCQ==
Message-ID: <sashiko-outbox-219242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 01/17] iov_iter: Fix kunit test to remove __init and
 __refdata marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-2-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-2-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:34:47 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove the __init marks from the functions in the iov_iter kunit test so
> that they don't get removed after the module is loaded or if the test is
> built in as the tests can be triggered through debugfs too.
>=20
> Also remove the __refdata mark which is unnecessary if the table so marked
> doesn't point at any __init funcs.
>=20
> This was found by claude-opus-5-5 run locally.
>=20
> Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterat=
or")
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D1

