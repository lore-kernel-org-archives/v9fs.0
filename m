Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078564;
	b=bgzZnnCUG5pkoJwrw4zAcWEJ+ah/xbdFx5+fyCGW1o8KpgnkKQJd10oJsJipHgFCSzU+
	 U/lS4rwKjOm8QiaYHnDM+b0X5ZazbcctaN1FC9Wig9vFwE5SmVzg4xwu0ydR37wr1ZBUs
	 upLHn7VwZiPUS/lUz+XH4XRx2ez8v151FN+FWJVnTW+qO/XQ3111fQnO53TuP3ty+V5YT
	 Vs91HknJo9q8S/XP9CnGQmwPYV8gIqEDqxdqyzo+y/VX3aW9Yiqaj7nRrW/iBE5RALhhk
	 J5Yr8dFohmB13K0558r0cLstzXv8ZjYME0gGYMK/7FolElEIpqHH+H4aPoTXIqXbCvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0gmQ/Eq5t+TpgDGY5RHJdYDsrsF3deOvnjxZueqCn3o=;
	b=wmoxtTCrjHepKOM1zTiybCvj47jZHCETK15TxmGDNwDbFruAN0no7QI63nomcaBlAM2b
	 4HNW7QpiRX/Mdf4/URlL/sQJVbmZ9KmG+M2515u001DimgZczqHWNgwTdSTEOfK6amxB1
	 4+To4c/A34dTa23//S+4TY5sNMb5NeASoJ0NZ6ir5B5diSX1ONQfP02XEimbqdFLOlfX7
	 U98ooGkJzAEEWUBaEQt2p/wQ/yUA6JwLlJ8PbVpGWvVz6fRfr+aPRgrELA06KMhjFTADi
	 kIGhwLt3HE2qQXwpUI+mOhlEnvSSlebDlfhke5d7TU6aD7Ls2xiv4/6WLzO4Te0RWWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOsGBY+s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D0606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOsGBY+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FC11F000C4;
	Thu, 19 Nov 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078564;
	bh=0gmQ/Eq5t+TpgDGY5RHJdYDsrsF3deOvnjxZueqCn3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOsGBY+s5hRoe840SQYIIOEAC1aTQEoW0xvvsJg3hmrabiC+KOTNSV9tR0IMEYxNN
	 jRqzdWGCk5K+ZApUagjeGEmIwrZL3CVHLEsgrxgCNU6G1o0piWKP9LHsMaxwIIQNek
	 R4Z+4fvtJNxtD1clhjx/0o4JRRU+4w/m6PhwBlw7GUg/yCNpIprihREov8yvP9atpv
	 SOfD1VaidXH7nWcZjhoU+cxGLs7ngtQmDPwk9IV9A9zKiFJIs/2TXuHC27qe8/Cflo
	 c+JMG47vB1jdxKVO1serKG8/kt19dkYhgYBNat+Fmhtbl8QE0i9xPNdrIEcHew3hnE
	 VNbM2sH3dzdxA==
Message-ID: <sashiko-outbox-222745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/17] netfs: Pass the write length to request
 creation where appropriate
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-11-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-11-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:56:03 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> For unbuffered/DIO writes and writes to single-type objects, pass the
> length down into the request creation function so that wreq->len gets set
> correctly.  For buffered writeback and pgpriv2 copying, this remains 0 as
> we don't know in advance how big the request will be.
>=20
> A subsequent patch will use this to set as the i_size on single-type
> objects (e.g. afs directories) as we don't care what the old i_size was a=
nd
> we don't want to see inode->i_size in the netfs file changing due to
> third-party invalidation before we update fscache to say how big the obje=
ct
> is going to be.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D10

