Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06825F7A9
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242372; cv=none; b=GuFsmY+paWBZmsQQsMY8iXZr0DRnOO2bz3kLtsGLmVqXd2nNjp1R83AEyY5TXcGlKjVKX+3FOfNBDvpqkQe4cqrrqt2YGChAqXW3TyrLTMuq/PWkBTTjvY/oVpZQ1VUdb7bnLMzzPKOBfPcZLw6NQVmcmZW4rXrT+2qG9A5q8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242372; c=relaxed/simple;
	bh=Og7SF0OKHRG1ne1tZZXNtxHiOhgywCYbynWJNbQv95w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwjYARgZ21YqlcKmWihfIjsv6MXalHg9D06xksAoEWVqt8pP8dkGtHjrijQYt69JmG3ecgzwESUuuw0kH+aY/WDniwSDf8bJVEqOewJ1Xx/NdypSCE/7q8z7HQwyVsXzFWsg4wt6yFko0V44a0g6BRtF+2Jq36aDFoNy12I80a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=tImejGSP; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="tImejGSP"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F24A714C2D6;
	Wed, 20 May 2026 03:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1779242368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtsWKnSN5XWGkKSxhV2Y5E/x4SLsMkiCzw1G/Tz56f4=;
	b=tImejGSPFenBKra4EdHoDRuL8G1J0UagAzTbNhM43biDhhLjQv/YRu8X9xUPhd8LJiFA26
	HgZ4Ak9PqFsimfJTH3hHmWVoIjqcdbHRU7ohoEF12aPVhM3gVh8mSy5tdDfB2wpFFrRljo
	B7pJKPLMkMi6SWfIhePii6j9bplG5OY4Fa4/dMKbGYjMpyqwXm7FZYFb8VWVF0kawPAxPn
	xfapuURCp4dHRkQDRbSgtJNLuUyBiG5jwKZHpoNqJFlDGOxN6FpigieJMK3vlby/akG/B5
	7tq3YYExzkdV4dHZHW3edUNuSPTeWEvloOtmw47Tj3q0MTMd7R0f1OGwDEy/wg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c95f56cf;
	Wed, 20 May 2026 01:59:24 +0000 (UTC)
Date: Wed, 20 May 2026 10:59:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] 9p: Fix mkdir to return NULL on success
Message-ID: <ag0VbfIZJhWNGtl6@codewreck.org>
References: <20260511061830.38373-1-zenghongling@kylinos.cn>
 <agxVvu6on5BXqb2J@codewreck.org>
 <6A0D119D.3070900@126.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6A0D119D.3070900@126.com>

Hongling Zeng wrote on Wed, May 20, 2026 at 09:42:53AM +0800:
>   I received David feedback suggesting to simplify v9fs_vfs_mkdir()
>   by removing the 'err' variable and using ERR_CAST(). Since v1 is
>   already merged, would you still like a v2, or shall I submit it
> separately?

It's only got as far as my tree, please send a new version

-- 
Dominique Martinet | Asmadeus
