Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805039FCC5
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288177; cv=none; b=lN1AiaFbEzoGFgqK+VJhtiqSXjArOiWtKgfXK0gfXAQsV54ETB4pyHn8ccCxtt59q33NHRB5lpIyHFeO641Nw6mCCuVmKCshz/W/z54snEFHy9onFQ4v4p6CdHAMLbAOd2pQ+5Ob75Qz+yik6p2cqFN+fEqazg+nh/aIyWzkOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288177; c=relaxed/simple;
	bh=6biMcOK+Zz97Q/9QBCS7qEWHP+iqlTDK50DK8QQ3lMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLc37Z5ldcliY8XjbGo0P9lZmpwUFXUrc1D/2RXRASq85iG1cywS8yD3FQKMiIwPRj9+6tMlcC45rWbFAJ2gGm/Jgxp64mGnCI5ft6V88i9jfDPrf5UfiWt7x1EFc8dIXStj6vMBMiwnMXbHuKh8BJlGGKhzWs5VEj1pH/TSSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=AtBm2Uuu; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="AtBm2Uuu"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C6C1B14C2DE;
	Sun, 13 Sep 2026 10:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789288173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NWVMD343iBz9pEDko/crO5W5x3RN1LKVuaVTjRA7JDs=;
	b=AtBm2UuuQBPn3YQcnNd1EKZ6JHKAr0DBfEpXUVIgbzE0n2jI+eYU/zbFQVgHKtgYAc3dO0
	4dAN5fJzr2XZG2Uy6gcXsYeLytX58vz4HLmF2Dlrwf1sYE5grAQCJ+BYgNLB0+WszSfY/c
	70bX0TL/UjsUHcyLwmFEO5mDea8X0MI016hU80kCJPbyJXwCPu3AvmOOGEyFo+w4ZAwnxz
	nH7LKIN6eVww7q3WtWWyk7JtSAP6mWr4RqbIsRbJ+r4L23BIn8JIm4vyMutXV+we/TcU1c
	drP7LT/KKsLdVxqaqIgPsFL+8eFFG+Zz69l6izU9vv2uS+QVVTC3zLXOYZiGWg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a311f9f0;
	Sun, 13 Sep 2026 08:29:29 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:29:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free in usb9pfs_free_func
Message-ID: <aqZe2nP84d5WYecJ@codewreck.org>
References: <20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Fri, May 29, 2026 at 04:18:16PM +0800:
> In usb9pfs_free_func, kfree(usb9pfs) frees the entire f_usb9pfs
> structure which contains the embedded usb_function member that the
> parameter 'f' points to. After the kfree, the code accesses f->fi
> via container_of(f->fi, struct f_usb9pfs_opts, func_inst) and later
> calls usb_free_all_descriptors(f), both of which dereference the
> freed memory. Since f is &usb9pfs->function, all post-kfree accesses
> through f constitute use-after-free on the already-freed usb9pfs
> allocation.
> 
> Move kfree(usb9pfs) to the end of the function so that all accesses
> through f complete before the memory is freed.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Thanks/sorry for the delay, I've picked this up for 7.4

There actually have been a duplicate of this commit a bit later with a
better commit message, so I've kept you as author as you were first, but
swapped the other's commit message in and added them as Co-developed-by

other mail
https://lore.kernel.org/r/20260731150414.3135662-1-nicoyip.dev@gmail.com

commit as of now
https://github.com/martinetd/linux/commit/0955472fff1e9f9e410a0300136924ebc8bd7a16
(look in https://github.com/martinetd/linux/commits/9p-test if commit is
gone on rebase)

-- 
Dominique Martinet | Asmadeus
