Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39289171D2
	for <v9fs@lists.linux.dev>; Sat, 25 Jan 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827325; cv=none; b=fE8gvh9mn9TuvhFq1wQKvN3d89/0J4JHh5f7T8tmztOlB2P3wHQU3ImxLY2GtmLxRw1So43nLpasPTJ2EqiUfQUideltP7SkUaAb1vfPKTqNfKcZ6KEBZirGMoHgVbd/rQSxxU6nLbMwWFtgTC05WZ+zH1Xr88ufSmBqRnSEtvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827325; c=relaxed/simple;
	bh=9A0Kqjij63Wp99eA9SaOjKRfFBv28L9ucjIEkOziTC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBwEXyM7oOOy6+2hL8X3mF1+u564MEAmerLp+uQjVJnLQ0z9O/Fqf/8Ki02cqCIQAn4uVI78/HMhvtuGBkJ/ZyiFuqV7SARvJXEPO0DWbXEKAv1JMC3fJ3SFciyPZXWiA9q7xwbg7Ub0wTpTTXGG+KoBcVSbHJcHHvoStP9D24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=EGdhAWB6; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="EGdhAWB6"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 11BDF240103
	for <v9fs@lists.linux.dev>; Sat, 25 Jan 2025 18:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737827321; bh=9A0Kqjij63Wp99eA9SaOjKRfFBv28L9ucjIEkOziTC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=EGdhAWB6T8H2emmHty1CtYcXJTNw38sdxuTQ5oEya6PR/Ma+6azw4nif2IzcO2Bvu
	 C4Wpf8j/XMoeKDh+jEc6yIoossYa5pgeDgjYLUSYtRv4A1iZCzTts4RpMdaiNzHrim
	 aMgHQ6l84WyHUBPv1ysxRcCw5YVuh2NzLB9nTv6oMOOx5CbCxmOTlBM8+IEhKjrjSt
	 METSEMTbmkxPGrIrv7Bz9JqcIQi8LYOj2l4ItXPs5a9J8Sr6Kv9OTQBXsgkRU+KJ2v
	 HyEKTvrC4xD/uZNHHWsC47iiAjGOxxdDxrfwq3AC0p4AIxFJsgjPZHBObTa7m+qnS9
	 9e1q3uKVs5evw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YgMc7757pz6tyw;
	Sat, 25 Jan 2025 18:48:39 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: asmadeus@codewreck.org
Cc: Daniel Verkamp <dverkamp@chromium.org>,  ericvh@kernel.org,
  lucho@ionkov.net,  linux_oss@crudebyte.com,  v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p/fd: change port to char *
In-Reply-To: <Z5RTs5XANcDxvZT0@codewreck.org> (asmadeus@codewreck.org's
	message of "Sat, 25 Jan 2025 12:00:03 +0900")
References: <Z5RTs5XANcDxvZT0@codewreck.org>
Date: Sat, 25 Jan 2025 17:48:38 +0000
Message-ID: <87ikq27pjd.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I didn't quite estimate the clean up path would be this messy, this
> "simple cleanup" is ending up being more complicated than the originial
> version so I'm thinking we're better off keeping the int -- what do you
> think?

Yeah, I=E2=80=99m also thinking that keeping the int would be best.
I don=E2=80=99t think the end result would be more clean than the
current code.

Thanks for the review from you both anyways!

--=20
Joshua Murphy
joshuamurphy@posteo.net
