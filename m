Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794076491;
	b=1363RzlZllEsTbWnwc1O/VoHWpqMYSOChc74ew5jIpk4fpOs4DGSUrYaGJZq8I/HomTP
	 PC56OU5K8kaN7XnA2gAy4Q38aYsnVmhIb2NPbo+FQVNkubyHTWwKv2cjOfvrBSMgjRRmm
	 X+fFvXwHLhgO8PveSHSzLfLiytKB0JFbt2zwQhxlTFnNYeXAmARMgc7/8T92Xii/O0VT6
	 MkxxMEXsoNsdIngnXCp4cG6aAjYiER+sylKDTvJzWJ0OZ/aYFR+yn+80nX3Ocx05lXjQY
	 7D/cE/NTSdqhvKx9fpMEDgnOIiySZTjAQcYPkPUmlyLaSFSGIV+nQ5Y6tASd5FaxAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794076491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V0X17Ide7auKYvEurdpX+QNjCzxtO+zsjKMG2Q/rHXc=;
	b=hgKFxtK/wtzdL7uSzBLhnFGDTPj8L8QwkK0roDHoVDgo9OlPmrGck0ubB2TDa/dJUd4A
	 00Gdg7aWzUsjBlkYb/jJWCuJRQ6esVdlVAn5V48I1W2Urh1MiywxE2OWFfxUza6WuqIHF
	 fPze27YRbdeJ1zHq+ZXWccBQXE62jaBGSZUJbIvuCRre6y8qaNPKNB1QrhDnVM2s9Ukn/
	 BXFjURabORzYL1STYl2KyBsGz8R7fJZASu9DT1D2g0T6ow9qtW2An7ei4hrwoS9xZtpYU
	 wJsKOIIhJmiHSm8MSNx5bvYCkEsywrIWamIsEZhfNmFotOPZIQrSibzCO8GvF1JG4VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtHE7IEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC4606A32C
	for <v9fs@lists.linux.dev>; Sat,  7 Nov 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtHE7IEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC141F0089F;
	Sat,  7 Nov 2026 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794076491;
	bh=V0X17Ide7auKYvEurdpX+QNjCzxtO+zsjKMG2Q/rHXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FtHE7IEy2BSiwCBZtiTvpduq/6+8GKnZ0xsvs05sFrxkd7suZTlZAq5GBur4b2SsP
	 IwEmpraFw94uby+J7GoImK+UZ45w/1/bSouej5SVcz5ZvHNsnoryZjXuN4s50i8Kae
	 x9elZ/oOUuT6JRP3vk9atflW/JfkXRgRHAk5EP+gzniai+E3A0v04XrPkGq9U8EK/U
	 8vE19s8eFQVD2S9tk9wkX6hN4PiqZb6gID2ArHcgvZwBiScEZRbr8McA1Dz+S74z+D
	 lHA9CUKk6iVFtrKzEfaI9uaNk0+0K/J8AzznLw8P+xetXTw1VVkZyPO1PvCiZeMpTM
	 TrITMyH/BSywA==
Message-ID: <sashiko-outbox-203171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/15] afs: Use a bvecq to hold dir content rather
 than folioq
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261107160823.1465553-10-dhowells@redhat.com>
References: <20261107160823.1465553-1-dhowells@redhat.com>
 <20261107160823.1465553-10-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:34:50 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Use a bvecq to hold the contents of a directory rather than the folioq so
> that the latter can be phased out.  This is also applied to the symlink I=
/O
> buffer.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160823.1465=
553-1-dhowells@redhat.com?part=3D9

