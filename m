Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F791F03DE
	for <v9fs@lists.linux.dev>; Sun, 15 Feb 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771147324; cv=none; b=mAeg9hn1I20nORpBBfn6wOS/3G6VNYa8e3BGQ5lVfAbW7kvtdaXQynPF1TBu/rraJ4QIzoyEUhfaAS9AvmDhdQhQfb5C5u4qpBEVM9LgiWKEpm0vdp/d30OJoOalZEJOOpS8A9eUBsDe99/uLFNYZdt+8F3b0j5oOwEDgdS4raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771147324; c=relaxed/simple;
	bh=wkAS4RJJl6vDV0QaeK+eTSGXuymafUpb7sdDSBT1qIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Ch6uIW1YneCsfPr2woUfC6vlxBR/GrDB6ufmlWzpODezPEbBmzbXWYe6nNTYGTYsc16kR2CiArD30mNRoRjPR8hgrY5xqsuQnU2Nlo1+gIYXHVyTup4Lh4zEjBWpI1ZInOK529yJvegb3QENxEvIYxoA6ghqWs9DBI4pLQAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=BEhZ1I0m; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="BEhZ1I0m"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5370514C2D6;
	Sun, 15 Feb 2026 10:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771147321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZir9aqsyFPLT6pkG/trDWIZZ0JXD3/dPzKk1KrXGYk=;
	b=BEhZ1I0m9i4pGIrNEC5oWlyYWGW/R5YN96TwTfs/NHv8f4Y/lLwQlL2GwOHX+ENa3zfT07
	/uhl/qpgbBGA9E2iZlkEQCV1arNoWI8Vxn0F0DN6XnmuHm5vGoGStLL8yj7q3rAxzFDlRl
	Fmgwk3I+z56JwKnbflIP6Xn8mHbpd3P9/MV+zZ8WCbhmfr2Fq2YpFi2YmYljphMn0R6nzA
	AMfVv2gZXwnmgTcaQOpGsgPn6walUu4HhMrnIu2gYMDKMHoUVHorOqI/KweZaxRbcPzL1g
	2f28yHQuftmhueywo7OGNq8qt+sHKCj88UUUnJ505xv3aMTXTzAHU7ooJDvAwQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 000b32f3;
	Sun, 15 Feb 2026 09:21:57 +0000 (UTC)
Date: Sun, 15 Feb 2026 18:21:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Pierre Barre <pierre@barre.sh>, ericvh@kernel.org, lucho@ionkov.net,
	David Howells <dhowells@redhat.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback
 caching
Message-ID: <aZGQJsgPxuLqlJ_-@codewreck.org>
References: <20251227180137.730385-1-pierre@barre.sh>
 <2025543.PYKUYFuaPT@weasel>
 <64008E3D-7EEE-4E6C-9392-986C1D8E8858@barre.sh>
 <1946294.tdWV9SEqCh@weasel>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1946294.tdWV9SEqCh@weasel>

Christian Schoenebeck wrote on Wed, Feb 04, 2026 at 12:48:55PM +0100:
> > FWIW, I tested the initial approach I described and this seems to result in
> > no real performance improvements compared to not using any writeback
> > caching at all.
> 
> Right, surprisingly I don't measure a performance penalty either.
> 
> Dominique, suggestions how to proceed on this issue?

Thanks for the ping and sorry for lack of activity lately.

I've just pinged David on IRC (and will remind him monday if no news) as
I don't have enough opinion here..

I'd be tempted to agree with your initial review that this v2 should be
enough though, so unless he has any reason to disagree I'll pick it up
and send to Linus after rc1

-- 
Dominique Martinet | Asmadeus
