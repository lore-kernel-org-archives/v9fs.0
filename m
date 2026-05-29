Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27934C981
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023727; cv=none; b=rf+5omzWdbI4Ca7AlgfL6Xf8MsxO7oSCuyI9zuATy/Jd/YMkrPCvhUKuF6sDYxiZz5DUD6+K9c3De4Fz2i2CiE8SzQx+tHYMHMcpCyiN9JybU+hlePGIEwc1LKd5GdZAT6kZSz7zNIPGRBXpX20NOlKQdlzjAGmWLsuSnk/TEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023727; c=relaxed/simple;
	bh=4wbkKHfYQBjqAh8M0IsOiaIs/JTBPLn/NwmN6L3+dU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIsk+btOUSl2xjwZW8I7YXgitd8gbhtTZOn+9hPishjRbcO56GFQ9VCAFQKMwobkgfTLySno9kf8pF8aRHtK42qpo8kCTsdLDelT3IXpM29BwBrAdjYrm3cVGt5oH8heL3XaOECn11+SNg1p2wIqHTcmPIrbwV8JwSfLgWk5n/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Vj379kfS; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Vj379kfS"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0C26C14C2D6;
	Fri, 29 May 2026 05:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780023722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjjkJur6v1rOaFxu5hP3+Ay7RKLW8XqoXLs/DlZB/rc=;
	b=Vj379kfStCTkpoFLP51vszCpG3lxbGNCRVR+/wC6mVYdDfjTidAAeASQe+06Jzc6nkBIQp
	orfVR7RVyY3vgwuxDgy38cCRndxYWZAyYojF7JC3Q6l2wf2UOS9Usz959+pLb1bJ1I2GDR
	VJs9HljjquT9bUETdhTzcJT6l4iEGPcKDUJGh+ftIiQfNTbwsGbzeVP1z5RBh5bA4Rssmr
	5MNkxALwO8do2BYQRqXrjHLCbjsnZIKf7SHQgvr8kpN2iMmEh4JHu11Ee9ytaa2KiQUp8P
	ksdhWUJ/lU2DvRb7aStbB+GtbFKElKtsp01EEjblybKWngg+x2YCs985gsw4ww==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a1fe97c;
	Fri, 29 May 2026 03:01:59 +0000 (UTC)
Date: Fri, 29 May 2026 12:01:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: add vsock transport
Message-ID: <ahkBmFmRjBDUAF7T@codewreck.org>
References: <20260527073447.86538-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527073447.86538-1-skvarlamatus@gmail.com>

skvarlamatus@gmail.com wrote on Wed, May 27, 2026 at 09:34:47AM +0200:
> From: Matus Skvarla <skvarlamatus@gmail.com>
> 
> Add vsock as a transport option for 9P client connections. This
> allows mounting 9P filesystems over VM sockets without requiring TCP/IP
> networking or additional userspace tools.
> 
> The implementation extends trans_fd.c with vsock support, reusing the
> existing socket infrastructure. A new p9_fd_create_vsock() function
> handles vsock connection setup by parsing the CID from the mount source,
> creating an AF_VSOCK socket, and connecting to the specified endpoint.
> All other transport operations (close, request, cancel) use the shared
> fd transport implementation.
> 
> Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
> into 9pnet_fd.ko. This follows the pattern where socket-based transports
> (TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
> (virtio, xen, rdma) have dedicated files.
> 
> Usage:
>   mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point
> 
> Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>

In addition to Stefan's comments there are a few valid remarks from
sashiko.dev (e.g. port number being truncated); please have a look

https://sashiko.dev/#/patchset/20260527073447.86538-1-skvarlamatus%40gmail.com

-- 
Dominique
