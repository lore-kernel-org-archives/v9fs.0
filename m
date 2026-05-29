Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6C33D6D2
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042272; cv=none; b=XKoUpYKTZF7XKwO7ROt/lCjxEopmNGcy1osACIQnaoTyGipKFm4R4eqJC4RTbNuQvhq5Dqj51EDfMOIdItQSIOmBnDy4gDnPjdHk6kszl+T4tYp0mI1Eq6nq6op7d659nJQYhQWLnTMRx4/cQZQd5kbtm+WvDO/MKEXWQ5lz5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042272; c=relaxed/simple;
	bh=vRnra2O32hWXnbgZFzlm93oqAz8pXCk4Z5JzTvcJUr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8zS+22kr3VAJbtg+AOf41E9YszFnKUFlBPsSuMzZ2Ci4kJxTR74vSq6fDtGM2/n5UUD9DjAnD+oxIvR9g+ZiJ6m+EjtaYUjTiTdu6SjHoXKXcINO81nusEX9Q7OU4QC5qCrXfOl5dFWUEnfzbndVCHUT1OEs4Nm3pImJQArrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=XmHI2Kfu; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XmHI2Kfu"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D118C14C2D6;
	Fri, 29 May 2026 10:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780042265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oM47xRLPCMwJh3GRGBykcM4VnqapQ/+g5+kgrBhiZ6s=;
	b=XmHI2KfuYo2LjLdWTn8XA0BAd9816e07gvpJErNCJq3EYNVDljhgIjUxFEloLHWMhBGK17
	mwAoUyMn6XQBhx1aoIZWMsiWyNC3g2SmbLtiFQinS1OEOJT2eXV+FsR6hIChAic0sYcGBi
	FCniphxIlXNbj5AwjMAQiuJL0wJGAgH0npE1WtpL1cQHxFY0DJ4qu5aFx515DqfwPhNxnz
	N8jWEwPuosZhwZfIwieCJIoKOvZEUg3c8SJzhNtA4C/E48jIothOUdIm0axydRYNpP7khc
	IvtGArLnHRlSKqgC9F+DLVDnfsHMWfYChyda6qTNi/hE8M3Um1kwc1eZm2m9sA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 88a35d5b;
	Fri, 29 May 2026 08:11:01 +0000 (UTC)
Date: Fri, 29 May 2026 17:10:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] 9p/rdma: create RDMA CM ID in caller's net namespace
Message-ID: <ahlKBgzjaWnu0pMr@codewreck.org>
References: <20260529070817.76798-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529070817.76798-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Fri, May 29, 2026 at 03:08:15PM +0800:
> The 9p RDMA transport currently passes &init_net to rdma_create_id().
> As a result, RDMA address resolution and connection setup are performed
> in the initial network namespace, even when the mount is initiated from
> a non-initial network namespace.
> 
> This differs from the socket-based 9p transports, which create sockets
> in current->nsproxy->net_ns.  Use the caller's network namespace for the
> RDMA CM ID as well, so that RDMA transport setup follows the same
> namespace context as the process performing the mount.
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
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  net/9p/trans_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index aa5bd74..ea49b15 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -541,7 +541,7 @@ rdma_create_trans(struct p9_client *client, struct fs_context *fc)
>  		return -ENOMEM;
>  
>  	/* Create the RDMA CM ID */
> -	rdma->cm_id = rdma_create_id(&init_net, p9_cm_event_handler, client,
> +	rdma->cm_id = rdma_create_id(current->nsproxy->net_ns, p9_cm_event_handler, client,

We apparently should use fc->net_ns[1] (likewise in other transports that
use current->nsproxy->net_ns)

[1] https://sashiko.dev/#/patchset/20260529070817.76798-1-zhaoyz24%40mails.tsinghua.edu.cn

If you have time please send a (separate) patch fixing trans_fd.c ?

-- 
Dominique Martinet | Asmadeus
