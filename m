Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5863E1D1D
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088731; cv=none; b=OLcwYSpImPxqI6fXGIDUm5Qbdejw05CArxi9nY2353EY1Ip+8T2zlrycyGI6DUNLHyw01n+wXLmd+hhLpdexYdyufLnK3GFE4ADwtZk4MmrYY2qlg+Sz994DUWc5iR+mQKAWOonRlwbYk8hC1MCRnmTyuv+ieb4iY2mJmqA5ckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088731; c=relaxed/simple;
	bh=ddujXxuF0ME5z3Hcok/6CJy6QU1VDcSBq1xYh6zAj6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCGDiIZDPLv7HbFfVrhqi4CXTFKz/GznyqPYKPk3bCX/vv4q/Z8d4ac8UyvlDVjVTtOm0sA9XHz/NsogTSee9zOV3fztOE43SBXWp+tmrcUz9hqFXtkQWDAR+ESM3u2+NFAC8pgGh+N7gwV4sxNPunXbKjGroPlCbd7E5GajMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=eIUCKQaf; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="eIUCKQaf"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B4F7014C2D6;
	Fri,  3 Jul 2026 16:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783088184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGRkAfHAZ8DDLGKacaMAHLNIsMHQsq3u0JveiKRt8mY=;
	b=eIUCKQaf6ZH2G2ntPs6a3AH9qWNj6IAkAf1P6R2B8e9qrH4zUEgnAdBjar7aEw+CNwrmz3
	HzlZHwLKZ819/pjAkDwDOyV5b7il0PSZg4HPKYUK3uO7/44Ts69vyRAGUavYhQJC/aQMdS
	prWggeUz18FBkENysrHwI2zWloMx4Iw3gxnMYYuVDlyYjHfy1jusvJOBLjNzVX//4OgYBr
	hLIezJyHfTHZAKg36tLBwIXsW1OYHlK67Ly1xh5WXMwnPXM9F/hLs4MhdCAe0C0fDsEQfe
	onw5X1j0w9nSCMFMMB8mzET9ekVnb8mZTYzlqpxRpG1oSc8w07QFHKqk9/e09Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 26166b71;
	Fri, 3 Jul 2026 14:16:20 +0000 (UTC)
Date: Fri, 3 Jul 2026 23:16:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?utf-8?B?TWF0w7rFoSDFoGt2YXJsYQ==?= <skvarlamatus@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2] net/9p: add vsock transport
Message-ID: <akfEJIwxoVx1hKXd@codewreck.org>
References: <20260701155922.95502-1-skvarlamatus@gmail.com>
 <20260703054133.GB448934@fedora>
 <CANG_AsJtiN+31UCEZDSRX5ckq10vW-Qw7gjcBcB+feDZA7rgww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANG_AsJtiN+31UCEZDSRX5ckq10vW-Qw7gjcBcB+feDZA7rgww@mail.gmail.com>

Matúš Škvarla wrote on Fri, Jul 03, 2026 at 02:31:41PM +0200:
> pi 3. 7. 2026 o 7:41 Stefan Hajnoczi <stefanha@redhat.com> napísal(a):
> 
> > If you respin this patch, please add the port= option because it is
> > absent from this example and it could be missed if one doesn't read the
> > paragraph below carefully:
> >
> >   mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/9
> >
> 
> My first idea was to have it there, but I removed it before submitting
> as I thought it would be redundant. No problem with having the port
> option specified in the example. I'll submit a v3 with this change.

If that's the only change required I can do it when applying, don't
bother with a v3 just yet

(didn't check the patch itself yet, will probably take a couple of
weeks...)
-- 
Dominique Martinet | Asmadeus
