Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B41EFF81
	for <v9fs@lists.linux.dev>; Sun, 22 Jun 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624792; cv=none; b=XR5bHNem+qSx2z6RgmE0XTmRJfVk5yJZsInXQSWkiJzD/JOYJqTUUoMLv4xz9364sQs/kGUIQtpjgsahWyO7xkx4FwUOF0h4JOGOO9RCt8/EFtvpRb5PL0LCRFk6zMjdP10V9FM9aNOEI1cfSDXTm8+2L/WDX6uRcXi3n1aTlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624792; c=relaxed/simple;
	bh=QNJR0KkCTh+OAKdt0AhF1h0Y5GIdyFPZKwAp9ESeI60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiGEYylwVAWB6gr5XbFCJR8rJJ1WWAZG1R819cOlIDiTSjnHQvfGaA/HTs9RMZCWq2yVlnvi0sUF+EeKNrtyf742P3m1a5OGwwUkgQ17u8vZp8WPq9yk0a8SKGobq9TKSQmAiJx3vuomalTym0g+xet/rS5pAJtpIxhFn2oHoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rXJtwHAC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rXJtwHAC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8321714C2D3;
	Sun, 22 Jun 2025 22:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750624789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LmQyjY+PPhdIwsfTnogU5Qv4nLE52Xwy953v02UeKs=;
	b=rXJtwHACGTmeR8vom572roucFa4PvjjNf1l6K9JotlgPqoan8+gl9N6Qwpl9x6J92+e7Nv
	bH+XbpZvC7ZZItHbwdWNQVG8AxhGA9WN/rTpRU2sETIZWsCrbKBcff6NgItAKN+b40Y4bZ
	QHrErFVHAYTbEbFfiiWw8b7c1E56JyXIAGFO/RH/dUNXHAPyl0VWQ3bPOFqRaWAmB10oYQ
	nLjSmzuUeIix8QMXK+lPE6na6vh9eWcGp3EUyM/fJ9RgfKXRAIToouOQmudEEeY2S8N00m
	B8GwJ42RSWl7mKiqkE291nSIfiFr97pjmFSdU5fhtLBXnbW/jsBsBKDNlxS/ng==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6511ba9f;
	Sun, 22 Jun 2025 20:39:44 +0000 (UTC)
Date: Mon, 23 Jun 2025 05:39:29 +0900
From: asmadeus@codewreck.org
To: Kees Cook <kees@kernel.org>
Cc: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	security@kernel.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFhqAergj6LowmyE@codewreck.org>
References: <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
 <659844BA-48EF-47E1-8D66-D4CA98359BBF@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <659844BA-48EF-47E1-8D66-D4CA98359BBF@kernel.org>

Kees Cook wrote on Sun, Jun 22, 2025 at 01:02:20PM -0700:
> >-	p9_rx_req->rc.size = req->actual;
> >+	memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
> 
> Is rc.sdata always rc.capacity sized? If so, this world be a good first adopter of the __counted_by annotation for pointer struct members, available in Clang trunk and soon in GCC:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-May/683696.html

I think so, I'll add the annotation in another patch when time allows
(and try to revert this commit to check it works, even if I have no
reason to believe it wouldn't catch this)

(... And this made me realize commit 60ece0833b6c ("net/9p: allocate
appropriate reduced message buffers") likely broke everything for
9p/rdma 3 years ago, as rdma is swapping buffers around...
I guess it doesn't have (m)any users...)

-- 
Dominique Martinet | Asmadeus
