Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC519B3D8
	for <v9fs@lists.linux.dev>; Mon, 26 Aug 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712113; cv=none; b=Ef2bqtsvTrcbMp6KSCwezxntTY5CLVhc3BWC6TJ1Eh1MfQ4ISh35e5nneD4KyVxXCCkiaB97lCUo0i2ZFPWWWavtwWwuQ4AewFTbsx6cFMIB1nQDMjfxWjgsPiKt2hKGi5h0RIXbiLnjX0H9lnxHc+YCm84QnHpt7nYUI6mbbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712113; c=relaxed/simple;
	bh=f4MKN2HbRnrkU0wW17LkNNhYBkHj33v4X604bMdlwQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=drZPkzMIe7TtYy4NN5HfcCz0/+zMRVmf8uvT+LdmroYghXq+S3B5Gy9RrLnloUCjwAjmpHFaWpJAWFZ7F/eCL8WkEo/c2OHEGtwwmVSjmhhW86l7IxesBx+o0DWqwbsbEfYDZCEVm7V8ZM02MscZTjvgV8/xSEUWD5mUcDJTBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mzLejvdn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mzLejvdn"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B10FC42D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724712110; bh=DHTAo+3eqHqGYJgtecztNEhf4IFJ+ibD/sDKHNht7Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mzLejvdnaUPdMyvAQbiuANUfr/ST6VQ28/PkwkLKjNYIWDGwT0iChJXb4miQsJUPM
	 VTkmhzV7d+XvbrKQqsYS16/i9v+q3Cl4d2E+2iLWdaHMmNz0NLHljGrA3xe495wkz2
	 h3bZWd/PC8Q2urLeyyIH+/nP+L/ajMgR4hqttzQNCc8va0oT1coT1l3h9kALQEoS5u
	 VOPmRPAWqzmv6TjBT6WByn3BSs2oZwzW4B6pQevcT7tcAsoIEb2sS+n0xS0od+38Ll
	 Hi715aWhHfDF12NdZzF8p7uJyQWw7q264h5+NAAxuQwzVHTTqWg1FN7g2i9xB6CDzR
	 CsdoezPd3hn6g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B10FC42D39;
	Mon, 26 Aug 2024 22:41:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dominique Martinet <asmadeus@codewreck.org>, SeongJae Park <sj@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dr. David Alan Gilbert <linux@treblig.org>
Subject: Re: [PATCH 3/3] Docs/filesystems/9p: Convert a goo.gl URL to
 original one
In-Reply-To: <ZsvX90dovlI52Ohd@codewreck.org>
References: <20240826010949.78305-1-sj@kernel.org>
 <20240826010949.78305-3-sj@kernel.org> <ZsvX90dovlI52Ohd@codewreck.org>
Date: Mon, 26 Aug 2024 16:41:49 -0600
Message-ID: <874j766h5e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Dominique Martinet <asmadeus@codewreck.org> writes:

> SeongJae Park wrote on Sun, Aug 25, 2024 at 06:09:49PM -0700:
>> Google URL shortner will be unavailable soon[1].  Replace a shortened
>> URL on 9p.rst with its original one.
>> 
>> [1] https://developers.googleblog.com/en/google-url-shortener-links-will-no-longer-be-available/
>> 
>> Signed-off-by: SeongJae Park <sj@kernel.org>
>
> Sorry, we (9p maintainers) slacked on this one - there's been a better
> patch for this one:
> https://lkml.kernel.org/r/20240725180041.80862-1-linux@treblig.org
>
> The sciweavers link doesn't actually work, so it doesn't make sense to
> replace as is.
> (although you could argue that it's probably been broken forever an
> nobody noticed, so it could just as well be removed...)
>
> There's no patch queued for 9p, so if you (Jonathan) want to take the
> other patch please feel free to.

It wasn't sent to me ... how did we ever manage without b4?  I've
applied, it, thanks.

jon
