Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2D36F8F2
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315196; cv=none; b=RP74hXKZ0LM4Zrfp/LX7VP9jvIVEprQhRAabVgBjkcQhLeH4ZujYz/Jibm1FLyMhKhvCknOOEwijX2TxhS6RKP0hHnQmdg3/e9GR4acCRxTQd+8dXielLAYOg3iSLUNuZjR9dZFmRjYx6JMLd0Apwso7Kv6QH0TjrSeFiHuBZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315196; c=relaxed/simple;
	bh=h6P7nPO/wXAjCOk4ZHQz+sxZSuy/hMR6p/qSRpoiCjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpSo5Btz3Tl9uDtWjxm8+OxZqelf8ZndPDOjupY9fQ5nQk9X2/G9hnz1pbs8LOE8aeIkFdplaRG38/8XMWCrTxKGAwI0jKoi+mEA3Z8kBrm/MnOgoDe217ZXRHjSyW9ds+72zhBXsn3xphXL8rZiXVRQwGaKABOFQTQU+rEmR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nEX82nJk; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nEX82nJk"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7570D14C2D6;
	Sun, 13 Sep 2026 17:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789315191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZY8O0nRi5GbS1NOYeVTB4YwNIhP2oo4hHI/CPzZ7h6g=;
	b=nEX82nJktLeVDlkL0kQvbeI9yswaKfI8poSuYRkXLkTjjMXUzh2kjmd8sbzR7/mu3DnwG2
	QCF4J3qC8Xk+0skVyuHHgL6DTH1pL1x8PjX3bvshdmxFvKfm6WpKKNR1CWoz+z01ue9/+l
	1J+MroCxNMU1o6lR8ZZE+K5AwZQgwMVIxTOVeodm9E1Kfi5clFPcFdqQmxyPvF7OCMWKfj
	AbO+1Dcwta3k9M4dggtTvI2J0YD+hOJOiEGUNpjSzrjJxx4ecJNl5ho3FAbwmgFvd95JXs
	1NNRYKDc8Gu6nZEcD2PqcKe7b3cFYz55DfoOAps6V0CYa40E7rHSdSiUPPGAZA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 963ab251;
	Sun, 13 Sep 2026 15:59:46 +0000 (UTC)
Date: Mon, 14 Sep 2026 00:59:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ze Tan <tanze@kylinos.cn>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net/9p: safely abort fd RPCs on fatal signals
Message-ID: <aqbIY53PWehECvuQ@codewreck.org>
References: <cover.1784186316.git.tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784186316.git.tanze@kylinos.cn>

Ze Tan wrote on Thu, Jul 16, 2026 at 03:30:48PM +0800:
> This series fixes a hung task reported by Syzkaller when a thread blocked
> in a 9p fd RPC receives a fatal signal while another thread in the same
> group is waiting in coredump_wait(). The interrupted RPC currently enters
> the TFLUSH path and can wait indefinitely if the 9p server is no longer
> responding, preventing the thread from exiting and the coredump from
> completing.

Thanks for the patches and sorry for lack of reply

I'm sorry but I'm cutting this out for the forseeable future:
You can't just abort a request you sent without flushing, for example
if a mkdir() call is interrupted it should be failed and the next
mkdir() must succeed (if it wasn't raced) but with an aborted request
you could have the directory be created in the back of the aborted
request.

I actually had a branch with 'async flush' a few years back but there
were subtle regressions and I never had to look further into it, and I
have even less time now, so I'm sorry but unless you're very convincing
I won't take these (other maintainers may have different opinions if you
can get any of them to look, that won't be my problem then)
-- 
Dominique Martinet | Asmadeus
