Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD42B9BA
	for <v9fs@lists.linux.dev>; Sun, 21 Jun 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046846; cv=none; b=fp6yGbq+n/04EofPuVSZkETRKEmVHjO1bohfIvSXHfjRb9HXHe0qocAd7WA7/FzJa1qOKzd8r5Ym4JnNa6Qf4f+fpqNrXdByxewOTyeoRBHDjypYHedzJAyeIioD7HqYtI40vsltr0WBHnh8Idpi4bjWm1mbYAFPyfiRC6eObGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046846; c=relaxed/simple;
	bh=TL6aRohAjLVeqIYRHBGQZyWb46j2PNJfru5U8AgJY7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D++E1Oy5m/9MAnNozTJb0zXKm0sGapFJ5943rXAkXFbVRi3rJ+n+oPG8xdpB7AI28nyGViiAafJCoJVggtewyok7U0O8I2PJ9U9CEQqk1virOxhfLFdlR1Dt+IWeB7HmogDtrrsbi0vvErSSciKrRFAopvAYILeDt7mUTBlh9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JSzyasJi; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JSzyasJi"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3A71214C2D6;
	Sun, 21 Jun 2026 15:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1782046841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYT/k7gnFOeT8ek+DUY4zKbtckl0T+W+A82T5fk5CNE=;
	b=JSzyasJiHA9Rf8Hb81yqXvA1WKgyfqTg8+gFfisBf6TyqfEAhIVPozSRWtE5ZFKHzQfQPv
	3ZKH79/RrUBDf3Lgp3oFJDODpagDDU0rGzoEgmdgsqcB4M6MaXlOQaF1HMRyUSfEdR+Apc
	RpjvD2oMoKjwpYxWPMeJxAPjycquYmXVKDGRllh4/qFLCrnj8ocM0K1Oi6lazuXYHqSUa1
	0rK/b8D1zKUJdzeUwoiTqeYHL1B8Shvg+XXmMPQjxBFWFk5s/g7wAfsGPzK/j+Kgh3jtbm
	5TcZFicrWK+eFn+hcQBVbr2ZgtYki5XQMP4A4L1ZpsTJtuiTovZQrvztLMWjyw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 66f442af;
	Sun, 21 Jun 2026 13:00:37 +0000 (UTC)
Date: Sun, 21 Jun 2026 22:00:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal
 signal
Message-ID: <ajfgZs23wKUUG6IW@codewreck.org>
References: <20260415155237.182891-1-kovalev@altlinux.org>
 <aeA-WpUyfWrYrvaE@codewreck.org>
 <e3e9146a-d820-d35d-cebd-e7e7e4a2fa24@basealt.ru>
 <aeFoRIOUNQZWmTG5@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeFoRIOUNQZWmTG5@codewreck.org>

Dominique Martinet wrote on Fri, Apr 17, 2026 at 07:52:52AM +0900:
> >  While the ideal long-term goal is the asynchronous implementation (as
> > seen in your 9p-async-v2 branch [2]), this patch serves as a reliable
> > intermediate solution for a critical regression.
> > [2] https://github.com/martinetd/linux/commits/9p-async-v2
> 
> iirc one of the problem with the async branch is that the process would
> quit immediately on, say, ^C, before the IO has completed, but it's
> possible for the server to process the IO (and not the flush) afterwards
> and you'd get something that's not supposed to happen e.g.
> 
> p1             p2
> 
> write(1)
> ^C/sigkill
> flush sent but process exit without waiting for server ack
>                1 not written yet
>                write(2) in same spot
>                write(2) done
> write(1) completes
> data isn't 2 as expected after p2 completed
> 
> 
> So it's quite possible async isn't the way to go, but that there is no
> good solution for this
> (given this is true even without async on sigkill: if we have something
> that works safely, there's no reason to wait only for non-fatal signals...)

Sorry to come back to this after two months but I'm still a bit worried
about this patch, and just came back to it as I'm about to send the PR
to Linus...
And I'm still thinking about the problem above, or rather possible
variants involving cache (e.g. write going through the server, but
client believing it didn't because the response didn't make it in time)

.. But the thing is, I couldn't actually hit the `if
(fatal_signal_pending(current))` you added (adding some print
statement):
- if cache is enabled, the actual I/Os are done by the vfs in the
background, so any kill to user processes won't have any impact (and
thus I guess my main worry about cache is alleviated there)
- with cache=none I'm not sure why I can't hit it, I tried with an
external server, breaking on the write() call while running dd, and
killing dd with SIGKILL a few times but that doesn't appear to be
enough? (task still stuck in write > rpc > flush > rpc, but it doesn't
appear to ever get out of io_wait_event_killable() even when I hammer it
with more signals?)

So, given that my worry with cache is irrelevant (runs in background &
won't ever hit this), I can't seem to hit this with what I consider
to be normal workloads, and assuming it does fix your problems given you
were able to test it... I'll leave it in and send to Linus now but I'd
appreciate clarifications on how to test this more thoroughly as time
permits...
(I honestly probably should drop the patch at this point, but it'll
still be time to revert if I figure something out in the next few weeks
given it's been in -next for almost 2 months already)

Thanks,
-- 
Dominique Martinet
