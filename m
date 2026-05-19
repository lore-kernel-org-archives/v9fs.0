Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA04D8D9D
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193702; cv=none; b=jxP1kgW8yG0t48HdpsNEx98MfXcVJeGC4yVtpWUt11jX2k90WbjaLcgBPJDpu5QdB0lCU57FkaiIKzsf4uBr0MFnlBVfXp9BW9rSaf7kEs06FdADmif2TthOfb+B8dQqHO6/H7/YsFaSiUj04tgjbPWnJaup1hB7l/HEXo2WlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193702; c=relaxed/simple;
	bh=bA1J/muiPJBldY4kAWFXmVE/1rGvI8Hr2oeFmmjjhFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkuAXw3OxwuGaLeQx5hZEGArhBxujjPC+/v73aBsJZyiYQ+dqYAn4uprraEH9C+IS5kmHe6GIJuY7Pq46L0s0FVDIQp1so2PvNwl81eySbUBnVdNeLQg87dHcbT661z+pWIFQGDs5Iuwwd3IHoia473MFuast/CfpYb0ZkElHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=aqFILWYw; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="aqFILWYw"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 552F914C2D6;
	Tue, 19 May 2026 14:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1779193699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oGG7rqHqBiTLcuaattfZMkUGXNnPnK/QT+Zkrc2e0d4=;
	b=aqFILWYwiZZPFGmAN0Da6g5pN6cOGXMJNukehGdknYsZ9ibcBoXgobZxcZmukzMhmxU6nv
	LqqOL9KkkLaGuVrLPfwyL1EqdpipYew4890lwdSLLVpVKBTkbngYcEMsveUYASqA0JcXA6
	7olluqsnWmcuNIoBURlKX1uAmEf6MoZBouXyDJBiublN+Nuygm2XGjCfcCoW1QTgcOABwn
	2zqY3DuVAh36a3RLKhV6L54qZn4diZ5sQHd60Eb+j0mVgrjY6xnCI/7oy7Kp8Ouh6R3ELF
	dnsIPymwcYvEJTJvacnTEr1+so/nqB7zAlr3lm57myKCGS16EVtOI3CbZvUYfw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e06e7cf0;
	Tue, 19 May 2026 12:28:15 +0000 (UTC)
Date: Tue, 19 May 2026 21:28:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Laight <david.laight.linux@gmail.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p: use kvzalloc for readdir buffer
Message-ID: <agxXUItqeMqTrESo@codewreck.org>
References: <20260512132032.369281-1-pierre@barre.sh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512132032.369281-1-pierre@barre.sh>

Pierre Barre wrote on Tue, May 12, 2026 at 01:20:31PM +0000:
> The readdir buffer is sized to msize, so kzalloc() can fail under
> fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
> / v9fs_dir_readdir_dotl().
> 
> The buffer is only a response sink and is never pack_sg_list()'d,
> so kvzalloc() is safe for all transports, unlike the fcall buffers
> fixed in e21d451a82f3 ("9p: Use kvmalloc for message buffers on
> supported transports").

Thanks, I need to run some tests but picked both patchs up for testing
When Time Allows before pushing to -next;
I think they're sane enough in this version.

-- 
Dominique
