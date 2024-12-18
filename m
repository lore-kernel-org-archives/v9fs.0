Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7A1F956
	for <v9fs@lists.linux.dev>; Wed, 18 Dec 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482139; cv=none; b=taTrPXmL3yC2aFOlFHcBScKSgt32aKK6308qTrs4W8k3GpbCuoNTFml1Fjk0eTLf59sdBzz8/p1iQa8ogTywUGIX7j2bIQqlI6RP0JmRcUKR5g8c4wmlAGEsijAleFMbjR/q6TbnECrkR8fZLHEvwbuf2FP7p8xjabctjIpcmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482139; c=relaxed/simple;
	bh=+kUYGBVjEIQGlnpaamQr88xZlwTHuNQ6H5KXNowT1Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkHqZGY5hAMw995feyYNRy2Y/Ov6zbptPfZbZmXlzISESyyRkqzU8PLgNWD2edmm4NU8Yq5oDAcXVh5HUAJ6tOpUE0mA42QKb1zo6MY/9+JdJkMtAxXohfO2AgmoWp93YzwxhGpxLO55n5oyARXnwSSVgsJvS5l3hVVxszjKrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jhmrd1UR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jhmrd1UR"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2426114C1E1;
	Wed, 18 Dec 2024 01:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1734482128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aa4RpIN0gJc0MId92ARrAz9ol7/3oZRHnRyI3A1CAQ=;
	b=jhmrd1URWOLLqZm01rQt77HGSNoXGiJl3+vt9hQSuW/VZqJ08JcZl/L63/nobwjJmouyen
	zhkhpnn0EcTDYCXpl0tzziavwsOQ+jrlQSNtvH0bA61CZo61dn6cdUVQi4mDrFCtvSauTp
	DMExKCVID91YX0v9VLEVTLpj3gvV2jdDqKrXYLpZ3E2tk9kVdhGDxaBnhK6nqaIpqxiYCe
	LGAWFaOgfr4hU8d6rm8PYZ7VmJLLP65cXMQnIfCbsmVwU8x987Du7xVxV3mdMke3hEsSvF
	xDlzmeRnMn/CIdmgfHtfU3JIeq7pLJVq/h9Pty91WD3mLCi5US8dg3e1QWIy5Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 58118b4a;
	Wed, 18 Dec 2024 00:35:25 +0000 (UTC)
Date: Wed, 18 Dec 2024 09:35:10 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: rtm@csail.mit.edu
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: p9_client_write doesn't check for negative "written" from server
Message-ID: <Z2IYvnHYTgMxA_Xi@codewreck.org>
References: <16271.1734448631@26-5-164.dynamic.csail.mit.edu>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16271.1734448631@26-5-164.dynamic.csail.mit.edu>

Hi,

rtm@csail.mit.edu wrote on Tue, Dec 17, 2024 at 10:17:11AM -0500:
> If the kernel's 9p client sends a write request, and the server returns
> a successful Rwrite reply, but with a negative "written" value, then
> this line towards the end of p9_client_write():
> 
>                 iov_iter_revert(from, count - written - iov_iter_count(from));
> 
> can pass an unroll argument to iov_iter_revert() that's larger than
> the number of bytes in the iov

Thanks for the report, I'm surprised this didn't come up sooner through
syzbot...

That is correct, written (and simlarily received in p9_client_read_once)
should be made unsigned.
They're actually compared with 'rsize' which is an int but is set from
fid->iounit which is a u32, so just making these three variables u32
will sort the issue.

The patch is trivial so would you like to send it?
If you don't want to (or there is no reply in a while) then I'll send a
patch this weekend crediting you as reported-by.
-- 
Dominique
