Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045EC224FA
	for <v9fs@lists.linux.dev>; Sun, 17 Aug 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755469838; cv=none; b=h/WS1T09mzlLVk29ffhclg+RsRoFKKBBOGZkk+O+ML+wSrBfytJcaztRd2f/qVmGcd9Dq6gFcaOptWvWDttfx4++jVW50KriCuZzq45C659PIsyVmd4bEi8SOVP4EfgmFDBP/6OkWyrlWmj8RiJPz80X5TadkCuUgWwc7fYZrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755469838; c=relaxed/simple;
	bh=/TUfM962kdROIwk2J5PfYpkRjQs1eJudmCNbGQ6CtnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqNQjGEP+9GmIm9LNOgBbkqMfijQKhXXXgERPFrGLSWDty6dKl14K97Mdx8u2M72vHgduRomXltqHEwXHiokRHKQdH3W+SEw78Qnw4CzMJHlawsjYPy9Wc9JSY3yMEHL0z5i2/JRrOzzDTh/CksfcBwUhp1d3Q7AmWt8riTQySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Jozw2Wi3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Jozw2Wi3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 030E514C2D3;
	Mon, 18 Aug 2025 00:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755469826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EC7ZeeynHbV5dR2gW02CLGkM8DkCtxZ+fq3gICAka3E=;
	b=Jozw2Wi3E9/O6ER5AUlm2xOH2OFpE3j4JXA68GJyRuPbyubvSa2PEbdh66SWO/y+mTGJk4
	vdzDK+g7w5bkN0Xr6yLB+2emFkl0rd968/XSztI8mOe1TqdA3W8hKh9pL38sfIPsr9QRN8
	raCYKrvNNrpY43nDCkRm5Z23t/FMGP4X0pJvCA4LS9QJhg7N8V1s/ya4GLL1X1kSRfuw+M
	KctGhtYZY24imbOhsMcU5g5oFD1qUD4FdTTyakN+eZQHy0z2XWAGxhLMz+ejSEZ6YmUelv
	28tLzQhLsMZX07f77t3aKqlMw7p915Sw/+cYzTC9IG6ah2eR0k1IUSj9XjIqRw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d0708c0d;
	Sun, 17 Aug 2025 22:30:24 +0000 (UTC)
Date: Mon, 18 Aug 2025 07:30:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: v9fs@lists.linux.dev
Subject: Re: [PATCH] spin_lock_irqsave() in p9_client{,_zc}_rpc() is bogus
Message-ID: <aKJX8Q7AH6ax2qYy@codewreck.org>
References: <20250817164206.GW222315@ZenIV>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250817164206.GW222315@ZenIV>

Al Viro wrote on Sun, Aug 17, 2025 at 05:42:06PM +0100:
> 	Both of those are blocking; they can't be (and are not) called
> with irqs disabled.  So these spin_lock_irqsave() should be spin_lock_irq().

Makes sense.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

If you want to take it:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

Otherwise I'll pick it up for 6.18 tomorrow-ish

-- 
Dominique
