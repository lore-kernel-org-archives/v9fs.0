Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935618734F
	for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136019; cv=none; b=BGHLj3oM7zC+OY/4Z4mmD93b3ST8IwwvFE6PHHW5cljaQ++S8bRNId65BE5yrUd9IHB4EmKwLJWMAKFz6OMLuiu24X9Ujz91+vVPdhT7acHiaH4AbwFga1IyOiS5wJwseEf3zALTslvbtslEZCrKPQr4BneDS328av6bgIKIpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136019; c=relaxed/simple;
	bh=PW3AyOFpbV+M9k/gGrHGTVQSWvBcQjABQGUEXr8Az1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7jOyx7VOHxhsO502FSA+3TMnm/bUL0v8ECwZlH79CGX9/sMwPFyn7oHduElMU459/1jiXEnenBI1vI7JK4a944vuaJF5EgPk/6H8RE2PcSKLL7pUqIQTEAIqDHSQApJZ27Qg3bVOOGJVMqK2vMjUVC3oML9dHrVqwvXJbWYC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Hc2lHDyJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Hc2lHDyJ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E1683240027
	for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 18:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737136008; bh=PW3AyOFpbV+M9k/gGrHGTVQSWvBcQjABQGUEXr8Az1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Hc2lHDyJWKlHkmqv8+Q+K3Hc6lj0IyHIGyKWans4AYLD28M22VRqRi2RrCGqQ1ME3
	 25nxYyeAo2Tlv+DQU8inAKI/WJncAJQoXUESQDP8565biBftUVDwk5BQfkkS4h4Wsf
	 DGBpQIo6iynb4FSbPZw9XHe0BzwIlGk7P9Uw+t1hsF2NBxkefm6DPDH+lCbaItk/th
	 sNaM4sEhlnITL0XIQXxI6DGWKhfhJIi9yjrqHY8T4TelZMtuOrQ3VIWFHjWv+CsyYW
	 nB/zE6Fdxq4+tdTwBwgP16Lhlg9OPWbJ6sDmjlxL9ekE5uT5WMz4ZXwuGV2Uws9ETy
	 yo0LduQVfTSbw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YZRxg3MdLz6tyr;
	Fri, 17 Jan 2025 18:46:47 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,  lucho@ionkov.net,  linux_oss@crudebyte.com,
  v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p/fd: support ipv6 for trans=tcp
In-Reply-To: <Z4liFG9zHHHslkp6@codewreck.org> (asmadeus@codewreck.org's
	message of "Fri, 17 Jan 2025 04:46:28 +0900")
References: <20250116160701.8024-3-joshuamurphy@posteo.net>
	<Z4liFG9zHHHslkp6@codewreck.org>
Date: Fri, 17 Jan 2025 17:46:45 +0000
Message-ID: <87jzatl4e2.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> That memset is for sockaddr size, should it be for sockaddr_storage?

Yeah, it probably should be.
Do you think it would make more sense to only initialize the
sockaddr_storage as later suggested instead of using the memset?

> not a new problem but I don't see this being initialized to zero either,
> I'm not sure if there are cases where that can cause problems but it
> might be just as well to init `stor =3D { 0 };` or equivalent just in
> case?

Makes sense, will do.

> Could you try to get rid of valid_ipaddr4 and call inet_pton_with_scope
> with AF_UNSPEC directly?

That would definitely be the more correct solution, I think.
Originally, I was trying not to change the code too much, but I guess if
I=E2=80=99m changing it I might as well go all the way :D.

--=20
Joshua Murphy
joshuamurphy@posteo.net
