Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EA8635D
	for <v9fs@lists.linux.dev>; Sun, 16 Mar 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161054; cv=none; b=ldsfmcP1VGFDIAfg/EISdqRghB5jmErm9gPppMbnBi8gU3TmUuahaxHoy3zwPY5Vk8beJQG68EqCnm9LJbuDPozA2gj8Rhm+PV/VwOQjxblvTvl5YIvriSrT1PuoNNjeaISLdjEJL5s5pp9KxhIa7daMKs4p5C3AYUF4QJOnlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161054; c=relaxed/simple;
	bh=eQEYD964ZwZcou93JAtqTPtrFjHw2YRPV5Qu0lMgdeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsWGSkSdnJxI7sk3oyZL+mKJXS5CtcrfQNoqDcfG0CCv7KguyWdpPt69UW+TfP1e6155yI2bRzTloe94eS1MViv56LGOw/IbFs3m+G955Y6kB3sJDT06eL5gHVUrMyluxtgahsr5On8dmJlJ5IX7b3JuozTnkVKkYzpAJbsFWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xvj99/SC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xvj99/SC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8CC0714C2D3;
	Sun, 16 Mar 2025 22:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742161052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+gAHhx1QBvSIWSCEwaH/juWgm8kz5kUJuLCBoRiSLI=;
	b=xvj99/SCDZkJJq8mNVU94ixlk9YhS9xAkTBq0g73yDqM1g5rkbjMmaHm1grO/1J3iWL6y3
	gMKt+SJOzSHrnvBPwzpPVvDzy15me08fTJ5y8uWK1eJuGB0pnVC0nPa7CGyYRq6PJuRU/N
	OFhh5nIYxtyd6wKXqmoXsW/BcMNRL8tAzVosQXXjUFfUdJlKyg3eNfvLGBCSGW7xH0I+/T
	zWqtIRNtZPmvvgiPCpQYlJmUoDk3qrSML3wGsGOfDLZzdw0w7HxpKjA8aFGHLsle/wKEPK
	pcEZpO0by/J74XGFtV0XRFLpltquE9r7QHWZO6jTDRGPAf2EgyUtBaPKZd/viw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8d8a7bee;
	Sun, 16 Mar 2025 21:37:28 +0000 (UTC)
Date: Mon, 17 Mar 2025 06:37:13 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robert Morris <rtm@mit.edu>
Subject: Re: [PATCH] 9p/net: fix improper handling of bogus negative
 read/write replies
Message-ID: <Z9dEiQUyDtf7nx0e@codewreck.org>
References: <20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org>
 <4171850.H1WhmIdAfj@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4171850.H1WhmIdAfj@silver>

Christian Schoenebeck wrote on Sun, Dec 22, 2024 at 04:29:58PM +0100:
> > @@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
> >  		return 0;
> >  	}
> >  	if (rsize < received) {
> > -		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
> > +		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
> >  		received = rsize;
> 
> Does `received = rsize` make sense here? I would rather do `received = 0` to
> prevent copying garbage below, that would be ignored by caller on error case
> anyway.

Good point.. We're not setting *err here so this isn't an error (and
thus not ignored), so I guess it sort of makes sense if you look at it
from a "best effort" point of view, but I agree a bogus reply probably
better return an error.

OTOH it's a change of behaviour so I'd rather have it in another patch,
will send separately.

> > @@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
> >  	*err = 0;
> >  
> >  	while (iov_iter_count(from)) {
> > -		int count = iov_iter_count(from);
> > -		int rsize = fid->iounit;
> > -		int written;
> > +		size_t count = iov_iter_count(from);
> > +		size_t rsize = fid->iounit;
> 
> I think that would break 64-bit big-endian systems, as `rsize` is passed via
> format below as "d" (32-bit) type.

Good catch, thanks!
-- 
Dominique Martinet | Asmadeus
