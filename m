Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395613;
	b=nQI/o6GMtp/iUHU6a2pepM+8yHH8+bWqSNHSZLlOudtslZgUhsKL5px+zWvCB6Be/L/N
	 Wj7vDnP88i02kWZS5s05+ZFeSc/jhmNLy4n/9Ikl25DuwXXFQosePsrWsRCbJHOlqRzhg
	 eM+rACq3vXXY/UzEkbMqwWqevkbj6TqqPI1pMTipnEzd6Mb19ic2XTywXrjt1jxWJHXHa
	 WS1ZakewG0P7J+H+MDD4AnR8r+YJWMhNIlUXJ1iobzaAO3fm6Y2jy5KS7XPU3LJyD/qjh
	 XKC9TZWCdkdQ15I0fMwnajdDP9h63Jb1zsKO5oy34YAhtMiEg88ogx5aZXxs/uO6YlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LQaMs4m0GH1lFeKfuT3qI/9/G/+BZoDLQMFq+/2UF8M=;
	b=Yn/Yx9N9tcHs7z9elrr7U/MzRbyV1prf1FXpNimX7eKUZfEvD6V+tg9HnVr7WHKxdDXX
	 ZEKPMitvpzWWb3LwbNG8qmgl+erEkQahAauiYN7fG6cxup1XKqNBejTH9V9pxRLAQGWNr
	 D4vy9ORkap7dP8fcr54wB0U+vZGjkZkooh+p62TXodmqJlHYeoxqdc419U17KEICC7jGm
	 BSFAwPt55UXPY8OqI/bMaoyZTtAELnKOBORgnSxySfmu5n+6AVsZE9UnDCHoUfRzwTMQc
	 iNx+3BVo3Lq0aR72vznjsbmcXFK7kIfccW7Fd+zqg6kSVumtcFhzBXbQBVTsf2TVpfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=AHGky8Vx;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC79606A31A
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 01:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC79606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=AHGky8Vx
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6051914C2DE;
	Mon, 23 Nov 2026 02:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795395602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQaMs4m0GH1lFeKfuT3qI/9/G/+BZoDLQMFq+/2UF8M=;
	b=AHGky8VxGQMpG5+CbhSEMlv6yHQTRzMXqvtnc+lhWEYAAHLJ6ZvFVaUyzzdNMDQ2iDuEi/
	h1Ge+zpKfnGentriE0fu7YxVFCQ68o/qEWz0Jh9R9T/9A1tYdIB/mRp61+fQUftuz9xTw0
	Jg/Lv9n4WZgOqdwKNsnOPXyMs7BUmDaQMfhMCa7MvoAtTNIYgi/pWSs+J+dhdLD0kwaX8u
	Ium97QQ20D9Sg74sDcWNoJzb4xkgqKdI4+8hYDoiDIgEGYK/ZR7QdfAc/DY2skflybrUOP
	Pu6llsVxrj4RUUumN/oTRQSGo65EZeiWj8UkLooU/v6cpngXdbl+uLXOeBWWHg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 47c69b9e;
	Mon, 23 Nov 2026 00:59:58 +0000 (UTC)
Date: Mon, 23 Nov 2026 09:59:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p: client.h: clean up kernel-doc warnings
Message-ID: <awOP_4jvEyebmc75@codewreck.org>
References: <20261123004425.1770155-1-rdunlap@infradead.org>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123004425.1770155-1-rdunlap@infradead.org>

Randy Dunlap wrote on Sun, Nov 22, 2026 at 04:44:25PM -0800:
> Repair all kernel-doc warnings:
> 
> Warning: include/net/9p/client.h:52 Enum value 'BeginDisconnect' not described in enum 'p9_trans_status'
> Warning: include/net/9p/client.h:90 struct member 'refcount' not described in 'p9_req_t'
> Warning: include/net/9p/client.h:132 struct member 'fcall_cache' not described in 'p9_client'
> Warning: include/net/9p/client.h:132 struct member 'trans_opts' not described in 'p9_client'
> Warning: include/net/9p/client.h:147 expecting prototype for struct p9_fd_opts. Prototype was for struct p9_client_opts instead
> Warning: include/net/9p/client.h:243 enum fid_source { FID_FROM_OTHER, FID_FROM_INODE, FID_FROM_DENTRY, }; error: Cannot parse struct or union!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, picked up!

-- 
Dominique
