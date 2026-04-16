Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998E1643B
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304145; cv=none; b=UQ42+LoJVwGd4a+bYVmI/lQl7Q24EQcdepF2/+hfdS5K3fwe1C0LSdJ232a7mBl1n27lN/RYBmLiERqHx1ymWjDCLwlbuaCSR3I2EqkROe8RIlyUSj+KCuPwxT6lPhnfyDzrQwJEmK4yYD9uJarH/xGBIIBpbwjB4jc+uUBiaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304145; c=relaxed/simple;
	bh=hcPLTson+u/Be+QUoNyraMm3eXHQxOp4UFFLMgNVFi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg+Ou5xjGAicpnjXXrSr1vH4sVNpSBvnOKk9VNIja91jfJU+wiSYtBJETMngZmJTGKY7OYLvbdXS4cuia7wmCBav9qU0vxug01bdvgkcpg1w/yNpZgrneZ2q7Zz78//eckI1Qm4CZ2ivJF4z0zhWt4YCTRvC6dT+cr6oYqIdrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=4G+8VCUt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="4G+8VCUt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C9D3014C2D6;
	Thu, 16 Apr 2026 03:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776303725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnCwHYjujmK5Qi92GwKW4sFo0ajZbQU+RcukDPLPfI8=;
	b=4G+8VCUt5jFSwIsR5Ar/tX7A4Gd88+r20v8cFBVctPcelatVgJMXYUi2wF8FzZ3RZT5oQ3
	RKKCNqVfwpCpGgt2aJBl1SGrmp5WVtHuoBnguzA0lDf0rPE+065UzdUdJ59LQr+OcCQ/b6
	ZcMgetyxCU78QHBTuPIe70A4pD5NGT5RqjGZj0vfIiYw1W+d1QUCGRfz9u8ZPDPWjOkpuC
	aVS7mS9hfMBZcQtn2lh2sxN7rMYI4W1pMdPiwfkPXsktSAJS7GmENFu1AE4j/bhF2FXCW/
	41UUsnH4tmJXKmh1KrLlqK7yWStFk2dKy8N2DWblRrarXRs3JTb1uwS8EoSM4w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id cb43ed24;
	Thu, 16 Apr 2026 01:42:01 +0000 (UTC)
Date: Thu, 16 Apr 2026 10:41:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Message-ID: <aeA-WpUyfWrYrvaE@codewreck.org>
References: <20260415155237.182891-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415155237.182891-1-kovalev@altlinux.org>

Vasiliy Kovalev wrote on Wed, Apr 15, 2026 at 06:52:37PM +0300:
> The same defect is present in stable kernels back to 5.4. On those
> kernels the infinite loop is broken earlier by a second SIGKILL from
> the parent process (e.g. kill_and_wait() retrying after a timeout),
> resulting in a zombie process and a shutdown delay rather than a
> permanent D-state hang, but the underlying flaw is the same.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

It's unfortunately not that simple, just leaving here will leak things.

There was another patch last month, help is welcome,
please see https://lore.kernel.org/r/ab_b-95Ok9zLQCdn@codewreck.org

(By the way, what's with the rekindled interest on this?...)

-- 
Dominique Martinet | Asmadeus
