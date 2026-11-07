Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077517;
	b=tbjngoEeN+/LU3LC4IWgWg2ms0yrNEoGZ8n8KNU5mux9lgFjHAfemTmhWsMzpIh04ueR
	 cNcJwougMn21lQceR58biYnxQwmV6MAVC0krJmSKZEH1Omua2gVuvnfQkt4+snbHgouOF
	 LgxeBoRUc6vKaXfRTK8tohDqGF1btxMzjKazpF0w3U32dC4zLaS2wYyotGW5+W8baOh9T
	 /Yy8opJ6dnvSJyvmjecOtHM2w8cN6M0pySvf3orXbSXIgxQ+yzbk/ytqyRmV4ajTgmFKA
	 JZMOgDA4DJbkyNPkFFNms7GEDzwanuEd+x4QsHddWhdeV5m35PNbDMXExRhQNgbaQXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HZRYi8qUyQ4M1U91DbCOXEPZ21Xj8Rcj0Be0VWSyP+U=;
	b=DD60fYZ/rx7QgsAkqQuHGjS8j5MkHhvDXuFKWGkUht2HDuelg1MnsGMeremYEBYJw+HI
	 MtE9uSbBNDcHWVPn6hkn0s00FA+AgVO7vMpp2FNda5tAkAyK3n/D6pjIRJFbCAuFUUEqU
	 bVHwblvt31X3fPxLjq3uL7pZqmbFtSxPRECnxAiSEBLuIJ54p22V9HtZrelUQdpV0g4oy
	 kRxkNiskcr3J3KnBcWuesCO3TSlfs0Fw9o08vCdqdIQNSZ2X9lfXyq68S4s+R4gWMTul7
	 4d050IrDtBOWhbHXR2uilA8CrvLQMfHi3ecDhXHYSctUikoTVFXaAbYXXaVJHe7b4ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dDKhQke/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C053606A32C
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDKhQke/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826361F0089F;
	Sat,  7 Nov 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794077516;
	bh=HZRYi8qUyQ4M1U91DbCOXEPZ21Xj8Rcj0Be0VWSyP+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dDKhQke/YKAVnYVxDteZ1MroUQVDgxhFlO0iegIOvbOB99re9Yf6yvcvmZPLgmgEU
	 6MYEQ7PB+JDtvUNGE6gjlOtDO8R15yVXIqGtbZAC+V4Rfd0BXMhZlgDMIilFHGJldV
	 Hs+eJA0G3vI0sHa+60V+7h9/JjWVYoAbuyVbozYIB797zaFBPBo6RTjYsVNjHcqEfs
	 ZQBb8Yssl+VbzFB46kKy8Fze8PxNkm/ZLfwCL1AR6FLmjDVl0Bi1FatXDskLqH5Qhx
	 WawSTCS4lo+Wvs55IRYYnLADRxjdCTF5yK2gR5xDzhw5N/aoG2wzc7RRRrwU2eYWxT
	 zmu21cCx8RfXA==
Message-ID: <sashiko-outbox-203189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/15] cifs: Use a bvecq for buffering instead of a
 folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-11-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-11-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:51:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D10

