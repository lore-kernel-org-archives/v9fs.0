Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291910E3;
	Sat, 19 Oct 2024 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296172; cv=none; b=blY6SHvss+ztp7VOuiqVePISF0Fhod5fb5borVL38/QBYuuzSxDS8fxv4vsVlqsnnLZr01Py+DzSbQGUDCHq+V6jWJ+LG9yKCJHojcvySDVpbJTe+unUamOp0N+/8BZLbE2qJxeORczCUG9tcpozX4XRG77mEaRkYYN3ZYlAl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296172; c=relaxed/simple;
	bh=zQ+4NLTXiWKgZ/nDVrxLyHaxZSjKfudr9cZDkowAlks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNFAjhgHvViIyfxobD9QftM18V5TpOHdc6jEWV6c5u3ag6hbdemFOwBZO0HEGg4yXnVTEFEnMv16DHknEPlvTCbIQX9mFuc6iPyOBGFssXrPt/Xu60iVqvavnRNGwZyycSt7AihAAT6SYDk2CrfFh6D56WK4C9L1RKnfuXDpVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=BFPlCMV3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="BFPlCMV3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2256214C1E1;
	Sat, 19 Oct 2024 02:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729296170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjRz2hW4KWqMX7pE51x2ikoQlF/URcxYPhc+lRqtmkk=;
	b=BFPlCMV3WlBta+YU4UrvafuzpLBzOnwmnvDmL0SUz5VrxUzNzyvZm8sRiIAn8LreNHT2NX
	wXREzhFcFsvQ+gX49xsDHwylyjTkchy76l2iVmqbxQMmqMxx5aAfch+koDJvJatcKM/bta
	U32bK8z+n0Px+5u7QfWRfWB7NBe26Kclhqa+xP9dagKeaV1v3F32J4YlYh4/g5funViVa3
	tFmTU6X35o1R8ca2Agg70dvSV00mbS0HtdpB2v/yCBae9GyguAcoOuLuLfjms5OgH08MM2
	GT3Y38oHmNUkk/bC3qBsbNAospKDKmBx1tnWL/yA2vcM9QO49XgWqyjEMNJLoA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id cc7b0353;
	Sat, 19 Oct 2024 00:02:45 +0000 (UTC)
Date: Sat, 19 Oct 2024 09:02:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
Message-ID: <ZxL3FsmjGrTT_EV9@codewreck.org>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com>
 <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info>
 <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>

Vlastimil Babka wrote on Fri, Oct 18, 2024 at 11:38:04PM +0200:
> > In that case: Linus, given the circumstances I wonder if it would be
> > best if you could merge the patch at the start of this thread
> > (https://lore.kernel.org/all/20240807094725.2193423-1-pedro.falcato@gmail.com/
> > ) directly, which can also be found as 79efebae4afc22 in -next if you
> > prefer to cherry-pick it from there  Either now or after 24 to 36 hours,
> > which would give Eric a chance to ACK/NACK this if he sees this mail.

Sorry to everyone involved, I've just sent the merge request - I wasn't
much at computer in the past few weeks so wanted to wait until I got
back home to send it just in case, as I didn't realize this was a recent
regression that caused actual harm (it sounded like an old warning that
someone just recently happened to hit, and sounded easy enough to work
around locally if there is only one specific setup involved); I should
have sent the fix separately or at least corrected myself about the
schedule.

> >>> It is causing regressions in my environment
> >>> #regzbot introduced: 4c39529663b9
> > 
> > If anyone wonders, that is 4c39529663b931 ("slab: Warn on duplicate
> > cache names when DEBUG_VM=y") [v6.12-rc1]. That's also why I'm CCing
> > Vlastimil, so he knows about this.

(that might have been nice to have as a Fixes tag for eventual backport,
but at least that commit doesn't appear to have been picked up by stable
so it's probably fine as is)


Thanks,
-- 
Dominique Martinet | Asmadeus
