Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B13EFFAC
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529019; cv=none; b=HO+6JkgmhyqnN7/pgdDSrwiltr6HhcrxQmHJzy1mw/BJmaueZGmtJcFaoAOlp3GuJW90Eauw9ATgOCxGdOGdMNbFoT3R/wM0ctos/VfdTqTc1dKvTCs0F0nCqdS2fGpPMICU7fGbyvTXCf+21CHUWXlR8RYJsR1dDfBrKL1nbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529019; c=relaxed/simple;
	bh=YTZMIoD5rpNvNhRIWdCOvb4Ip7DyzU/4n2NQO/zq9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdaavhjHJp+rp3wVOrHglhbmuBgrdgPVash5lD4OMjfLS7qj0GA4zzRb0HfKZAwX/mIyvOoNlXJsonYnJxAAaX3jgUD8Uowo/t9O3ZHTcsLcFcKgpwFmxn/T3viGRb50xzmUFELqxXNE4tfoivac/bFQKwhGwnWlUOLUK90u3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=LjNKs2VL; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="LjNKs2VL"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AD00514C2D6;
	Mon, 15 Jun 2026 15:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781529004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUqaCm43EDrt7OukUs0TNGrXxt3Z8CI1bQ1LFu8uQHY=;
	b=LjNKs2VLrtZCu+Z8rQW8zDSccmOYZ7igs1zmPFRenAOFdbLoJMTFaJTvvALZgAUOvdYzUt
	qSbXaGnptslh0rWP+53urzu0IWIMDZSHDKUCwrFN8LBvXFkQs6eNvL+y1s90oTeCK8iN1X
	j/Z+uM4SFRC579TCAdEX/8OdMrjYcocvfbzgcCSlpWwQ0ZZ2VGiqYSfB/RDlv+t5xQ/vsR
	e+Ihjoje8regLRjfDzngO5IpC2DdAcn4ZcARmuHLlZQghiesU/iXuGjaNvKODXa+YfLG5o
	ko7q+TWGLI+MQq32u/CjA+pECekmvsK2LoaEBQEQRiE5zQ3FJo4SQJP1dSc0MQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d3a185c3;
	Mon, 15 Jun 2026 13:09:59 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:09:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH net-next] net/9p: Replace strlen() strcpy() pair with
 strscpy()
Message-ID: <ai_5mEpISFp28Myj@codewreck.org>
References: <20260606202744.5113-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260606202744.5113-3-david.laight.linux@gmail.com>

david.laight.linux@gmail.com wrote on Sat, Jun 06, 2026 at 09:27:42PM +0100:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Use the result of strscpy() for the overflow check.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Thanks, picked up in 9p tree

-- 
Dominique
