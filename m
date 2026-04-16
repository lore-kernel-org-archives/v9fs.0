Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27418AE2
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304534; cv=none; b=XKx82jS/pWf4gKMY/wLR0qqN77DN/mvEH5hXgauBYiDjE9J1aDkwkSHkFbK683SMc3bTYyyDopordDdt52LD8B1H61tQuguL4RlwmDHiszoNfDMPXhQln+El8KANgowmp/YkacXj+wi432+zjorne5NeJRIdxfMtLDUN8KlxJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304534; c=relaxed/simple;
	bh=CJLRXeVlBW7S173v7QUp4h3JtAcELq/535LLhrMgsoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/ANIbLbra3oDe7O8SKFAfRRGYQV79CIWMz2mZcvQMoj4mER/ER4cXKkNZ8dbH7DhhqJ+zlo76hC+F75OGWPY2sVMR5Nb47K0mH4kS5TzDYPpo7wMmHp1dIrvAliIyLJL5p0Y4iNXRStCqMlRLiJGmsIj/Ik8aOvUFy2ZS59TJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=BLzq9Lf+; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="BLzq9Lf+"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CCC5A14C2D6;
	Thu, 16 Apr 2026 03:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776304527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h87WCj5FXO0v6omlqR75PLELNPQYy2IrbPP3P40eyE0=;
	b=BLzq9Lf+6JaelqqbmYh3pxFzUrCH0o65EBmTkkBUMdAzHqCrdY46vaaDBhFQs5nP+yjjzc
	oybK/odRwHjFDeKEpvK3dCuWONjR9sg6PlMat65rlslIZXa3QpfGay7DVr8NbYlXjgEDK1
	BAniO6T+CggbWBsjfaWelQe0O7d0fbY/9yrV+bL3GmRvPQMBI5+SFTOpVsg8BdhNvmD3Tu
	zntSVJDEq0Fv+RebOzlVF2nkWyenkjZITJke6uHwaJHTAzZTog4e6Cye8gf5PfAHK0XX8o
	FkRBVkfogTUokvymqcqC4u9IO0AlfNAViIdZfW+CAIizH7uBlKAPmOxdHiFwGw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id aac010aa;
	Thu, 16 Apr 2026 01:55:24 +0000 (UTC)
Date: Thu, 16 Apr 2026 10:55:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Baran Arda <baran9arda@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: remove unnecessary extern keywords from header
 files
Message-ID: <aeBBfWYcWcOouaTA@codewreck.org>
References: <20260410202651.60818-1-baran9arda@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410202651.60818-1-baran9arda@gmail.com>

Baran Arda wrote on Fri, Apr 10, 2026 at 11:26:51PM +0300:
> Remove explicit extern keywords from function prototypes in 9p
> header files.
> 
> Signed-off-by: Baran Arda <baran9arda@gmail.com>

Sure, why not, will send in next batch to Linus

-- 
Dominique
