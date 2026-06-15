Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6433065D
	for <v9fs@lists.linux.dev>; Mon, 15 Jun 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529364; cv=none; b=cLj85LDv0AsKPamwZKkA74+ntMSOOz/CoX7hFDGv/enNYAZ0zBuMa7FV4uNnYs6tOtfh8pJGyfL7BtOlmR+oFKotZ9A/aAmLIwiAWQ42CyZmHVpg7BuCpUtpJVvjy5cMnJpP+JLxfrccUhEi0OVcriTdfXS83szuQNhBtk5UdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529364; c=relaxed/simple;
	bh=ZU3DYlZqZY3INdfdAsqhIhGUSte0Vjax6OAW+ZIm+LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR0T74JMNUljkkrBYQG91m2doR02Nk2dhHeqPlweoxLNMd5TlBvsdQHE5CmPa/OLMJH0q+F76M4ma2VQwOo38urhrsxQqxobIifxatyfVY6anELSHHMswaCxj5+g3/1peAXLpbph18HpMWfZc7e261VXR5uNCBbifrzq2vVYFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=IwhoPI5Q; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="IwhoPI5Q"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3755F14C2D6;
	Mon, 15 Jun 2026 15:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781529361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVvis7jXq0eVvkCDOueMx4Y57DkIbXjkmQYwBC1MW9s=;
	b=IwhoPI5QgdpqH1hGte82lci9yyDvKDbc0oEHWdXT/9KBnVpsbqEQQRMd7fJxMGrqycVKdp
	yyR566/PtzGhnmZNSMXuRc60rB7hqPDj/TPcArBsNsNXmaUD6agLQSXW/Qkr3FLXVlQmUm
	95R4luub+HwhQSGbWGplfo3s/irbnbjH8DCiQHuNnM0gFtqyOoBtn+Qws/HsL6ST3jRoPK
	i1AeOr3Qy71Xy+oIsI3CMmIsNJk3hf1lXvFnU6PqTHdI4eEH2/8gblPenraSujBRnCdxoS
	hmHgVR3ywkGgckMcVaXI5xFodL10RSgiDRPVshNxTYAwE0gdnm/ZD0qc6faeFw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c40709d6;
	Mon, 15 Jun 2026 13:15:56 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:15:41 +0900
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
Message-ID: <ai_6_VC-TRwksKyu@codewreck.org>
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

Thanks, picked up
-- 
Dominique
