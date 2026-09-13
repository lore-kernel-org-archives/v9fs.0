Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596639099E
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789287486; cv=none; b=JzbNGvgOL8hIRf2C6Ci78f+W7N+P+4TzuafUeMMLGlxGJYqoy6l0w3l/Z0mn2ccctZvOejC+AY1blV0RxMoAOd6Mh4kKkgUgEi4ROFsACpE8IWEKbhpKSnu3tciDzGIFjuV9xhztiV6Cxhc873Zj7pMSwQ3fxRtzl1zXh5Xm0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789287486; c=relaxed/simple;
	bh=mM9oLVrWR++VfwOwO41s4wixGszplr2iGvCN4PyrPpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEFTgBs85v1HTOliIISQa5bWwS+XzEDulUc+bfBdyYA3pr1wgKINFeiGq8WQI7j3dblJLn3Xc3azAJND9TnCyyvYV6++sO0l3CKQRj8Grv5y7HK1DO9HA7aoQ1HUKjtv2JkB1U/y+HQ0dl7U6p5QhYLAe4SjhtIuHBz06wqH+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Y9zXTXTg; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Y9zXTXTg"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5C56014C2DE;
	Sun, 13 Sep 2026 10:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789287481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10wMTV3unf/XMi04iM50ZAp4gIea+06zVuCFjTbf4uY=;
	b=Y9zXTXTgeFkUuHCq/mW9/wwVQjeZRxsmCt4TnBietugbsShcvNdBjLbgI628t1MmPRPkka
	y6hmpoYSgWTsVUsHBCyTI0u5RrOplBxsqBpjrzVdKnXNRiqpgwfyoLTK9ltALRSLN2OV8Z
	LC0mgxa3ZumgUPcTDyFODS/ucrkMYaqBS8Bp2EvLTavjO3cAz0NzCYcRRgvf1Lp178s1fR
	zpSWOSvJBFOghlXyzRae53zVwuAObD4ETWqyihgF/g8HwhOumTkw/+I6pfHxvtMeqMauWP
	kD16d6RYgXLoui0mkW7DwgN5IiwDh5G1TguyOPl35VngkKw08mUAYEzD5vqNTg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 883c6394;
	Sun, 13 Sep 2026 08:17:56 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:17:41 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH v2] 9p: use fc->net_ns for network namespace in RDMA and
 socket transports
Message-ID: <aqZcJR-6EsjkUM8v@codewreck.org>
References: <20260529090625.78761-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529090625.78761-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Fri, May 29, 2026 at 05:06:24PM +0800:
> The 9p RDMA transport currently passes &init_net to rdma_create_id().
> As a result, RDMA address resolution and connection setup are performed
> in the initial network namespace, even when the mount is initiated from
> a non-initial network namespace.
> 
> This differs from the socket-based 9p transports, which create sockets
> in current->nsproxy->net_ns.  Use fc->net_ns for both the RDMA and
> socket transports instead, so that transport setup follows the VFS
> mount namespace context rather than depending on the calling process's
> current namespace.
> 
> This avoids surprising behaviour where a 9p RDMA mount from a container
> or other non-initial network namespace may use the host namespace for
> RDMA CM operations.
> 
> Fixes: fa20105e09e9 ("IB/cma: Add support for network namespaces")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Sorry for the delay, thanks - I've picked this up for 7.4

I've just rewrapped the function calls you touched (because fc->net_ns
is much shorter than current->nsproxy->net_ns and that looked odd)

-- 
Dominique Martinet | Asmadeus
