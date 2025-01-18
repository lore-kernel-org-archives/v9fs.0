Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E733C9
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163440; cv=none; b=tsT3TkPzi4K/t8kZt40nouu/ypWHaPHVaztTvtxR04fH/yVav4w9dCgP/vajUEj0h7yQ5MzMR9uTK81juiNKW9CgJKDy5OCuMtQUxhZpKzJPmIRN40BpOJpLn4D3ujqdVgaFogtsJwfAa8xSokdNSV4xhLnPG6PNmMcEgPzx+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163440; c=relaxed/simple;
	bh=9gqVEpozSxbgw4/KmrfUkciIFu8U1Fsb9eFovJJKkn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cnnBy6dEL+mAG0YtHuf0VfSMQ/O0F3J0WePIAAlm7FGEqP2vSBRfl1/+xTEyTFYSu/91+FmdghbmQsJYEF5Jw+8wsBXnjO5OHvenYX/6kJFR2vEF9EuBB4ZIRYzpGm2rh8Cw25RLwEt7/l9fPWIxzgI61fmZ3HPfhBSKOAq51yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cwnTaSmF; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cwnTaSmF"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 25DF3240027
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 02:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737163436; bh=9gqVEpozSxbgw4/KmrfUkciIFu8U1Fsb9eFovJJKkn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=cwnTaSmFA0fClDH7DJAwnTAAPsxST7uYwRhtNkf1FLC5KBPgooP8WHoa6F8+w42pI
	 SH2nxB6kmaOLw9PIsceUg2mMKtEQmN3v6UQHvFCfidBpW/8jY0lfj5iwvD/nRfVefu
	 FEVDfws64LmgWC0KgKwOws+fezcb7MC9y/CWBLPCmvnvJghbPJm9RJsjMNzIMlp0ny
	 lfLtyS0JYQ2c7pjL0gmHnJwvkghsT+DBsQpJwaibLf6Xt4QvfvkPBMxa0tF4oO0doC
	 hAu0ZgVPzPacxZCBUrZlFGuBRr79sejla7S9c8Po39J5woN/iUSWlyWf70wvdP3dqb
	 y7NcOCi2gVsOg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YZf566094z6tn4;
	Sat, 18 Jan 2025 02:23:54 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: ericvh@kernel.org,  lucho@ionkov.net,  asmadeus@codewreck.org,
  linux_oss@crudebyte.com,  v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p/fd: support ipv6 for trans=tcp
In-Reply-To: <CABVzXAmxVAe-9wEy3QD6iZtA+pXj5_cVcDob06WNTC5conmmWw@mail.gmail.com>
	(Daniel Verkamp's message of "Fri, 17 Jan 2025 14:50:47 -0800")
References: <20250117214943.6368-2-joshuamurphy@posteo.net>
	<CABVzXAmxVAe-9wEy3QD6iZtA+pXj5_cVcDob06WNTC5conmmWw@mail.gmail.com>
Date: Sat, 18 Jan 2025 01:23:52 +0000
Message-ID: <87jzasgbiv.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> It looks like inet_addr_is_any() checks the current sin_addr/sin6_addr
> of a sockaddr, but does not change it, so this doesn't seem quite
> right (its only effect is to return a bool, which is discarded here).

Huh, I=E2=80=99ll definitely fix that.
For some reason I must=E2=80=99ve thought it changed the addresses rather t=
han
checking them.

> inet_pton_with_scope() appears to unconditionally dereference its
> `src` parameter (`addr` in the call above), so the `addr =3D=3D NULL`
> check is too late.

I=E2=80=99ll put it in a separate check before the inet one.

Thanks,
--=20
Joshua Murphy
joshuamurphy@posteo.net
