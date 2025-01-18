Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0713C809
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737226457; cv=none; b=fBIXc2aVc49TTkgNtiASh/DcnkrMsvaeYdcyVSs3T3xO9lxBUbafGPwfw0XTr8gLCVaT5COfk0+9yWETFpgflhydQmQyfa91vY6gpDqCHrPSyNInFmeBYfnaDf769aXUa7EltAA/MLUeEuu9edJo6TBk4S8vH0qUS3ric/JiCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737226457; c=relaxed/simple;
	bh=GQEv2Ya4Ndk91ZUZUmCeoQRr/CxyOfW5SPheFxqkRuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gMXRxH6qzgTZHg4AqnYuTJ6RkeBL6e7B3olPKWrW0zx5qgVu61SirNn0inBm5Tx+9eCkLw8QCyunKF14Z98KoBFIrnDCIQS+3wcnXdEfCnl9CFQ8bF1QBEKZeNqm/9gDWdYAIDYBMaKax5KRBlv+899FNZu9lhtMKRn6+raUXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=LngVoSEA; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="LngVoSEA"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 31B7F240101
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 19:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737226452; bh=GQEv2Ya4Ndk91ZUZUmCeoQRr/CxyOfW5SPheFxqkRuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=LngVoSEAmV812IEEhxKTmZ13dDPsaOHCm24aOBPXbhmgDfa/q02D0AuQ0HFbyvKti
	 a1QunX9q4DO9vsFGSvJy6ofuXwTBj0jT5732POjU+0smADTN37bnK/3te+Et9DnvIy
	 nfdhpmdhXJWXriZ6D8eUxv3/GyGMraBcccTUOhXO13owYRE6qoqZEiwkIDy2blVFi4
	 m5KD7qu3+0QTXyTAtoyTxphBUDeDkGO3VlPOVQIqqeS4aJFTDw4WNArYj9D8F/QC3k
	 bkBW8oMk5Ostv1Ca9iAA853dzM9ulm+e/RW9tgW9dlQGhT2FPqOyxOK5FqGvCtH+nA
	 5wE3A5oixtcDg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yb5Nz11Gfz9rxF;
	Sat, 18 Jan 2025 19:54:10 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,  lucho@ionkov.net,  linux_oss@crudebyte.com,
  v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p/fd: support ipv6 for trans=tcp
In-Reply-To: <Z4tX8nnJAO8zw9c1@codewreck.org> (asmadeus@codewreck.org's
	message of "Sat, 18 Jan 2025 16:27:46 +0900")
References: <20250117214943.6368-2-joshuamurphy@posteo.net>
	<Z4tX8nnJAO8zw9c1@codewreck.org>
Date: Sat, 18 Jan 2025 18:54:07 +0000
Message-ID: <87plkkneb4.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Let's keep the sprintf here and I'll try to find time for that later
> unless you want to do it.

Doesn=E2=80=99t seem too crazy, so I=E2=80=99ll do it once this one is good.

--=20
Joshua Murphy
joshuamurphy@posteo.net
