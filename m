Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618633E7
	for <v9fs@lists.linux.dev>; Mon, 26 Aug 2024 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635459; cv=none; b=sNNkmkDIj2w7+34i37TXW2XDU/MlyWj39YQS9NNRAbyS8oTTF/aRj6RuSqiC07M6ZroNA9GinCh95JnoAAl2eLHV+pTCMLAmE3BimxhfXoZ/oJLDLoWo5hkCu+CoqLwFxwt8uknKWqNJjeI/Kj8vZZ6AQH7SBBCLVhNCTqBVkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635459; c=relaxed/simple;
	bh=2lhZOhnyTlMgqD2SrXiAJZIq3W7WNtFgPBl1dA/44rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd4gXzTxItP/AeY8g9FAgYm8fJjTLnacTxuZC1e02WxfdSLR9QyZrnx9ixrLSydbtYddWLuc1iijlbxxatz/OT9RVZGatWm5z645olq0PMcvRlNqvySNR+8JOBIr6EL19t7EuIE4xaO1VBmGrqy0z4+3iY8fDhIbhgGPXf+HdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=LKEek1ya; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="LKEek1ya"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C959314C1E1;
	Mon, 26 Aug 2024 03:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1724635146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+QcNhh0VWoV5otdU1nJZBsnrM5AKjg1RiGKnZhNWAU=;
	b=LKEek1yaWqoDk84IfnpqG0lhZ37tuLeMPuKXe+WPDcZP8odwd4NHtDjlk725lR12m4ipgc
	TGvPNDbEQ4bGYQbqCYGPt9B2ecQskBMKhEuS/kAR5lO3ms5/EDkwAPXmcYPb42NJm956Me
	su6g+JeDlUPuI4ZuvpaZE1Nq0m5SsWIOIY7B2TNcNfvZq23BgSV3YIVCKFL0Jy7xNoHGW+
	5on+AjCi8ph0vtnAqyJYCnJr8mwa42YNkDwQHt4Pkd3knoJbCZCpNTZJS1w/+Crwx6OdLG
	cKlOepP+fIBVcAayYGnX85svwu5j6ZtxsViwNIPjxwvZRZ4n1Tlxf3hXaFwYzg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ca8414c2;
	Mon, 26 Aug 2024 01:19:02 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:18:47 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Docs/filesystems/9p: Convert a goo.gl URL to
 original one
Message-ID: <ZsvX90dovlI52Ohd@codewreck.org>
References: <20240826010949.78305-1-sj@kernel.org>
 <20240826010949.78305-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826010949.78305-3-sj@kernel.org>

SeongJae Park wrote on Sun, Aug 25, 2024 at 06:09:49PM -0700:
> Google URL shortner will be unavailable soon[1].  Replace a shortened
> URL on 9p.rst with its original one.
> 
> [1] https://developers.googleblog.com/en/google-url-shortener-links-will-no-longer-be-available/
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Sorry, we (9p maintainers) slacked on this one - there's been a better
patch for this one:
https://lkml.kernel.org/r/20240725180041.80862-1-linux@treblig.org

The sciweavers link doesn't actually work, so it doesn't make sense to
replace as is.
(although you could argue that it's probably been broken forever an
nobody noticed, so it could just as well be removed...)

There's no patch queued for 9p, so if you (Jonathan) want to take the
other patch please feel free to.
If it goes through the 9p tree it'll get in the next time we send
something as I don't feel the need to send Linus a PR just for this, so
that might be a couple of months further down.
(I don't like patch series where folks are added in Cc on individual
patches because it's never clear who is expected to grab the patch in
the end...)


Thanks,
-- 
Dominique
