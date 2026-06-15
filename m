Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A83F1ADE
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529232; cv=none; b=KTex5w+VZB2L5Yzrvw8rOs9AJO51o4wMQzgKbFW1UEf06tzQ91GBchTtRCy3UULkXqcYU4o7vI5HYGFdD7d8nSgN0Dt214aNNGWcB5W9PmuyqazQ+PfVlnPOHD48doFatBnrm5CqqE0HCOR1UM8PJF4QwRM1Y6Olly/Y9ccGm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529232; c=relaxed/simple;
	bh=jFSVVJ14aiy4Ul4uFPq3KDzuj7dvHjqy2I4cR6OmUCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuq3RThLn2ZMd54Docpl/sCvKyzy14f29U02DW4r0xOPEtj+McMQCO0Q6LgCdJRV4bsSbiE6bAK3nGnov+J0CafSI/A8aNo3U80En1Hay48dezA4fEqkZWFULM51edafOxmXpsZJi07pssmIz+yt4EFw5BtKeZOp2xrp5vh56/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wBevBwAA; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wBevBwAA"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id EE04314C2D6;
	Mon, 15 Jun 2026 15:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781529230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yy26O8rLSQoyPxQV7w2+ZRANRetss6D+jSJtV1b2C+o=;
	b=wBevBwAAoXio0uD4t1vElQGxk6Y8u9ZUEBvjsuMaWqO0VLJcTRMaWA6Cd4jArjRLqNMxVE
	MLsYY1Nf8niQLhZal3HiJgSbTaE88Dh+GUpiMuAcfprYKrAOtvYxfHw25lDkzLfNWu/bSN
	CiANmoL610X1zRb9vAqiwph87rCugE4uTu1E3NxoHImZ709lLQcGOLaFGfVToWKi52Ea6Y
	s+JT0XUPB5buaOZay1ub0LyCJrPOJvRvKB/L8nvHHYWyeG2PM/QUGIhGNP4TQ+yJzm5RZr
	fBTc1/lbZnCIBxd5qYJY0Exrt4AcuS0IM8Pi0R5IOWD9aC994644HXQkiEHRzQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9a8c800a;
	Mon, 15 Jun 2026 13:13:46 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:13:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] 9p: Add missing read barrier in virtio zero-copy path
Message-ID: <ai_6e8Rhfq1coHw_@codewreck.org>
References: <20260529075441.233369-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529075441.233369-1-hanguidong02@gmail.com>

Gui-Dong Han wrote on Fri, May 29, 2026 at 03:54:41PM +0800:
> Commit 2b6e72ed747f ("9P: Add memory barriers to protect request
> fields over cb/rpc threads handoff") added a read barrier after
> p9_client_rpc() waits for req->status, pairing with the write barrier in
> p9_client_cb(). The virtio zero-copy wait path was missed.
> 
> Add the same read barrier after the zero-copy wait before reading the
> completed request.
> 
> Fixes: abfa034e4b8e ("fs/9p: Update zero-copy implementation in 9p")

This doesn't make sense, the wmb was added a few years later, so I guess
this should be
Fixes: 2b6e72ed747f ("9P: Add memory barriers to protect request fields over cb/rpc threads handoff")

With that said, a rmb here makes sense, so picking up (with fix tag
fixed up)

-- 
Dominique
