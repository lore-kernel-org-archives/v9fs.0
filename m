Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0A36AB7C
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529759; cv=none; b=CV0Q56byVlvhRniedy7t2anbjlwrs85Yx94A30BR4HPH6MCEO80PObkhKdJSN0nXc4nSErMEXrRUwtvKStl81XMGpQoB3cLf6Ne1wcra/eGjcENmyOg0xrivjKtELEPNtMqq/eZmJoWUzBjh5vZyNmmWeS0agHXfRqmdFP7/aRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529759; c=relaxed/simple;
	bh=R3JdeKXGpczm1aaqBQJyostWCGWg+A908Q7kylVL3pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEZqLwyVAqNcpk4PQSLn1irvyvAKAo2tmojjwj1NvdBNGB7bGkIgAbGEga/royA+U4K5IOU6vqw+Gdks0XrePL5Io9DYTKSGRlf2ufVU7JiWx6p/x/iAVRvfRfjwDlOqDwKEmGZHmzSXLFqbNL0QS28tww5sy18gkaJdL5Wx7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=H24EC86F; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="H24EC86F"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B944614C2DE;
	Mon, 15 Jun 2026 15:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781529756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1A9oUgxX/TI+Qa3lIT5zuers7SyzSZDBGoStVTGj5M=;
	b=H24EC86FgNmw7i8qUG+KKa50JfJxW6A9bOIkxE8sjWMuuCS1o4DwUqNSXAyjIjRriuZbU3
	XpXc4W3uTKry8kDLWMr/f6/ujLh8GBOtRV8b9Cm47SX8+hY8VMak4AlkjRyVxMxoGGBg3z
	8h1YHWR4d9eMtFLNsjIpCgzGM7BN6JI2Tdv29fWQ+lipZ1muIhq6wWTHoBTgxdbAG9YmMm
	EpxYV/+qERKyiSuFW8OU6oRLO3UigOUi0lN2Q8k5z4ykMpHjRZQ6kgurcqN7vaaM5bRCGS
	RRUEGZmFB3PzmK8jrQ32/pysf980k/b4Mlq5XvN0B60hZpnjtVAZVzXGsN4WwQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f059dd13;
	Mon, 15 Jun 2026 13:22:32 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:22:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] net/9p: fix race condition on rdma->state in trans_rdma.c
Message-ID: <ai_8iSfPkPDFB3l9@codewreck.org>
References: <20260529073933.77315-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529073933.77315-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Fri, May 29, 2026 at 03:39:31PM +0800:
> The rdma->state field is modified without holding req_lock in both
> recv_done() and p9_cm_event_handler(), while rdma_request() accesses
> the same field under the req_lock spinlock. This inconsistent locking
> creates a race condition:
> 
> - recv_done() running in softirq completion context sets
>   rdma->state = P9_RDMA_FLUSHING without acquiring req_lock
> 
> - p9_cm_event_handler() modifies rdma->state at multiple points
>   (ADDR_RESOLVED, ROUTE_RESOLVED, ESTABLISHED, CLOSED) without
>   req_lock
> 
> - rdma_request() uses spin_lock_irqsave(&rdma->req_lock, flags) to
>   protect the read-modify-write of rdma->state
> 
> The race can cause lost state transitions: recv_done() or the CM
> event handler could set state to FLUSHING/CLOSED while rdma_request()
> is concurrently checking or modifying state under the lock, leading to
> the FLUSHING transition being silently overwritten by CLOSING. This
> corrupts the connection state machine and can cause use-after-free on
> RDMA request objects during teardown.
> 
> Fix by adding req_lock protection to all rdma->state modifications in
> recv_done() and p9_cm_event_handler(), matching the pattern already
> used in rdma_request(). Use spin_lock_irqsave/spin_unlock_irqrestore
> in the CM event handler since it can race with recv_done() which runs
> in softirq context.
> 
> Tested with a kernel module that races two threads (simulating
> rdma_request and recv_done/CM handler) on rdma->state with proper
> locking: 5.5M+ FLUSHING writes over 27M iterations with 0 lost
> transitions.
> 
> Fixes: 473c7dd1d7b5 ("9p/rdma: remove useless check in cm_event_handler")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

None of this is frequent so taking lock is sound, picking this up

-- 
Dominique
