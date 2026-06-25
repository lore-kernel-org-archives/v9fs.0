Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967F332EC1
	for <v9fs@lists.linux.dev>; Thu, 25 Jun 2026 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420820; cv=none; b=fJQ1AMgyQ8r42U1g7iNfoEgVU2lKZ9rNWjEhWn4deUaNCnOP+I4UgLWwbDPCuedo7/x6G8/ECGq0bNttYORIwoMeSiqbe/xP0RsUxXI7AwrLn3QLHAwmB4wcxWcxefiAjg0XepvkisxHc5zJSPQlzpre/X/LLAhsu2IeE3SORjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420820; c=relaxed/simple;
	bh=yg90jpABlr98aAenod1BqfhSCtt/y6hBL7Vo94eGWd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqhMfP1PWk8IXjpTU4xWZU8bPBovce5GKWs/HXJGo8b64JbSRACJJ27NOhZaZJ8nAOJKEfHBlYk1DrCsbsPopk+XDoS4Fy7ZIAYVyZMgNIm0jgz0kPBgoROAr2GFKrImq/DZ3DBDOQTKSZgmLeFjlUGygBd+T1q09hb2oPlFhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=n1ENh5Zy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="n1ENh5Zy"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1F58014C2D6;
	Thu, 25 Jun 2026 22:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1782420808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmsKDYLrWXSsy8bCSaEi30AD6M9x7X1yvrgyqIhpyw0=;
	b=n1ENh5Zy7OaVlmGcObYysVC5lX2+AT4b7lY3zH8SKLPv+hhpLPUoIIEU9YMhg5FMKEpGrh
	Dfmz2DJhQkyXBMBuI/eu4fAMrj/5KYIJ5f358EFB5F4dlPYml87wbZfUqKgGCJL1Wi5ZgR
	cAdR+FfeiQZdPo9G5XLDEp6A/iY6wP/8vwPQ34m2AkPyQGWCEUByNwkK4DBRCzcTsiMpaN
	DSTWT6UhuaIYw8Q5ZERonZSWwgvqoFmc+eDPikTJl8atsGP3lqfC9j543AkK7OQHgugnHe
	Z9Wb9V66vSfZnbosZjhPmotYmIoXwVA482j4KnKXrw2IMo3zpaRTv0Wq4Qpa/Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e313b8bb;
	Thu, 25 Jun 2026 20:53:24 +0000 (UTC)
Date: Fri, 26 Jun 2026 05:53:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	stefanha@redhat.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org, v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p: add vsock transport
Message-ID: <aj2VNVzCXTELZpG4@codewreck.org>
References: <20260527073447.86538-1-skvarlamatus@gmail.com>
 <20260625151636.26449-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625151636.26449-1-skvarlamatus@gmail.com>

skvarlamatus@gmail.com wrote on Thu, Jun 25, 2026 at 05:16:36PM +0200:
> I wanted to ask you about your opinions on the issue with
> port number truncation. The port number is parsed from mount
> options as u16, which is sufficient for TCP, but vsock uses u32.
> 
> I see two ways to resolve this. One is adding a new command line
> option for vsock only that would be stored in a u32. The other is
> changing the type of the port variable to u32, and adding a range
> check for TCP.
> 
> Personally, I would lean towards the second option.

Actually the port is already parsed as u32 and silently truncated, so
you don't need to worry too much about it (I just tried mounting with
port=0x120235 and it mounted on port 0x234=564 successfully)

We can add a check for tcp/rdma truncation later if someone complains
about it, just make the vsock port type u32

-- 
Dominique Martinet | Asmadeus
