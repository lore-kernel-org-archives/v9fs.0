Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F421487E2
	for <v9fs@lists.linux.dev>; Wed, 15 Jan 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956019; cv=none; b=asSgulrkQMUrhp1u9A9UwLOkEA22Ja6ZA2rD/5BYV3bXzLQcgukeUpQy9oQFSGRMtczFDF8ylPPl0ffMas0AzN6F4wNB9lL4hbA3kY9s7MpoKW4kDKwuwKaWqYCrY99kRl9Rmj8ahvGPHLda8SHEitLuL2+DgCUz8RVVNSJBGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956019; c=relaxed/simple;
	bh=+yTvbnS+ys59Fl+qbMqPce+r4Tq8wEeDaJ1ZILDgdaw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=oTJr54z9sDsRpoiXIJi5ZREB1x2PvtgQpRK7HOB5X6wtI3nD+fbu7lExccWbRqIpQrkGIjkmai7DRzgNQadepRYo+iyEc1bJ/ruhwITl3tmEEpH1d9UR+PqtsknLv7O7VSda+qq4Yj1Jefn2NjYV9cnk6dGcLiymOTbjuYr4Qhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=KkZvAyRM; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="KkZvAyRM"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EF21E240101
	for <v9fs@lists.linux.dev>; Wed, 15 Jan 2025 16:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1736956008; bh=+yTvbnS+ys59Fl+qbMqPce+r4Tq8wEeDaJ1ZILDgdaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=KkZvAyRMp6ePVhICi1A1m6gNSagM1ly1nh428d2UBcTIGAQo+U0VgdREC9F/48uc7
	 TZ42GLafhhdotR1kjLhszGIvd1t9IXSkJUzQUpFcdVmKVNvdKDmITE/SLIf2zSU8aR
	 KhOhljjwcnAzP9/OERnu9fH4GKjIlsk1NSab4hNryOWzbPd7CCyP1Gxlb7DQcQjfMH
	 5ry9Uv0x+BwtZ6xxubkez8QwwS/xgwmfX2jdefy9TdJ+0UjD8HClOrv2kWaApTgBOi
	 K5odJSMkI/z75SK53y4umserwEK3ekbvLIWDh7B1+UV3Xo1iGbYO3mUSbm85d/nB6f
	 EWRQQcOoeE58A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YY9N80rp1z6txY;
	Wed, 15 Jan 2025 16:46:47 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: asmadeus@codewreck.org
Cc: joshuamurphy@posteo.net,v9fs@lists.linux.dev
Subject: Re: -otrans=tcp with IPv6 address?
In-Reply-To: <Z4bV8_e_gZUgG7Et@codewreck.org>
Date: Wed, 15 Jan 2025 15:46:46 +0000
Message-ID: <874j20qduh.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I haven't had time to do anything about this for ages, but patches are
> welcome!

I haven=E2=80=99t done kernel development before, but I=E2=80=99ll see if I=
 can put
something together.

--
Joshua Murphy
joshuamurphy@posteo.net
