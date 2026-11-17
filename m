Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937269;
	b=4DurYP6E8gYh18gTFUmMRPG+qBRxZBZHCmVZaKR55BgXUpqKTwz6/31fEQmbaqIhzGlf
	 ACB/sp83Xict63UBQ4c0h6q0/8dNvKyWc6r96ckW33WfrFQlL1XmWT16/1cF3uWgJU3ij
	 VF2hGHEddakzIk6t3L3cdYoE/b+vhf+bxfidJdmE0UdPhd8f3BXHXkVZdzxzvFxdaJEJL
	 8CFOSXaMzKvJObwbjJYb8XfFn0m0UfK83GRB1FWxKaJaEii9opowJttNeYLk5y8cAZIN/
	 JyRxrGPyi4ZwTqqi6O85UwAalFA9OhbsR4IR4vl57YoJeXf8vJvSa19GYDKcajNsYPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vtLssnBroWqbXlg4bIGaoRpazIEEjHglFw0hAPrwPpM=;
	b=jHAXkv+Ou5VcrP+Rvoeq45IZeBO+jv8lKMTTqwf/PsTXDwo19n1tZ5AyeIfNxITGRWAH
	 k6/wxUuaZHZJ/VaTJz50AphmDablOFqxpIpnfW8zawYiTRBgxRFRbgaBlmqRSOlTFyhEn
	 UXtHrMIdvmggS9Q8xnz3y/zVvGVqxdLuoV/weEkVI1B+WWq2gvXwtN+wS/lg935l68h45
	 pxxK8A4RftGLKdTsemM8FUKGLfpEyH2b5XpP0kpSWNrFNpzoNfwPL3kZYpyJ7Nsl08jbb
	 Vedd3SS1MdMMXmCyL0a0aD9bhWRgIJBW4TKh1j8g2eUK6LhVAWJtPSlPcWPmlcj3NQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nd0xD4Sb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C3606A31C
	for <v9fs@lists.linux.dev>; Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nd0xD4Sb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12771F000C4;
	Tue, 17 Nov 2026 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937269;
	bh=vtLssnBroWqbXlg4bIGaoRpazIEEjHglFw0hAPrwPpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nd0xD4SbORexfu/fhHp+OPlT2tnLcIJc5BrDu7WUGecq26eDbETtA7567MCf+VVdg
	 mESlrBsI+CzwZMU233nOeIGyaPmMRIj9UGx/IDNa+Bk+JJ+VZ24QpQoDIhjd+rjL6Y
	 zhC4QQTKAK9hkp/VXztCMIIJTTVLztEveY5P699VkU8ckKMH+97NCNcXC0DQwFep1Z
	 Q0UDuYUK9LiMOL4IPPr0xy6bx1xblI4j23AB8p+dXAWl/Q6NGTkk+h6hw3VZDpx7KS
	 lYBGnr5qJ01q2YtUsXqe2JT5sAFGaxdrd4khSQkgffBMj8iUdjTsx433SZnvs+fBWI
	 xzmsf2ZJWRBDw==
Message-ID: <sashiko-outbox-219254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 16/17] iov_iter: Remove ITER_FOLIOQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261117171958.2982801-17-dhowells@redhat.com>
References: <20261117171958.2982801-1-dhowells@redhat.com>
 <20261117171958.2982801-17-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:41:08 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove ITER_FOLIOQ as it's no longer used.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117171958.2982=
801-1-dhowells@redhat.com?part=3D16

