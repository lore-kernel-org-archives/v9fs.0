Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6E2F4A0C
	for <v9fs@lists.linux.dev>; Sun, 22 Mar 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181400; cv=none; b=PidRx2Gf6YqAjACKwvc7R674KQVso7ATrqOWH2pdVuRxbO78edBJO+dB8zHAqAiIfJROw398tId8R9b5EdgPp7gyWuuGuqyDxDHbB+7deVpp/Q9yHZlFLwQ8zyWWpi2jtlzUe4z9afTtIxJ2FKYqLypzyIOxws6OnhBqyUl+tlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181400; c=relaxed/simple;
	bh=r2BS5jitUikXBbp5+qeYvYnPVjlrn9IN9yxeJK70bB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r69cpg9kTOcetnGhddCMG63I4fFaKW+a271NPU5w86AOBZnY9B3WtAEg4iE9vRs2z7NKaNr+rPe0GSgF9Ps74Oi7Ajwso5HPCuPTVGsKR57K+a8Z9I0LPumD9cSNZO/pBvw1KXC0ElXoYYGMTKJJX/UfxZKzJN4uxFgGspstdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=SOXPWtXv; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="SOXPWtXv"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2A4D614C2D6;
	Sun, 22 Mar 2026 13:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1774181390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60S6+d5zi8E7zdMyWY+57TfPC118m+lN5gdqfKNASy8=;
	b=SOXPWtXv/aMtsbMi6WsWlFHFhubdY6xsF3FqPeXBSYcG2/u8e5XUul0UeFsXtvVhNKk8+a
	LKYAFMxUrwmeOuxQ64FALNjfkX+Obq2W/lqJSg6boIuWwqo9ZhhjcSvl1eJQLN0htbVMXJ
	1hTfLCxNUbTmCtkt+/HaFzg4ShXcjSfWazv24HLJHdtZ2e/1XvsMSG/uAbl+roGPqoeKVp
	RTVCRdiCJAC1utTwmJFr1RuCviqfSYvk4XlfyIXl3XBsXcbY3cNIcZdEnCFnNGMRr5SQLW
	WIORWhJF/4aljmTrUG6HtRoVpsltuhfsH+7zJXnNyI3ZK74JUWKYkvnVSDGjag==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6cd66c15;
	Sun, 22 Mar 2026 12:09:46 +0000 (UTC)
Date: Sun, 22 Mar 2026 21:09:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Tuomas Tynkkynen <tuomas@tuxera.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: don't ignore fatal signals during flush
Message-ID: <ab_b-95Ok9zLQCdn@codewreck.org>
References: <20260322111848.2837057-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322111848.2837057-1-syoshida@redhat.com>

Thanks for the patch,

Shigeru Yoshida wrote on Sun, Mar 22, 2026 at 08:18:47PM +0900:
> When a 9P RPC request is interrupted by a signal, p9_client_rpc() clears
> TIF_SIGPENDING and attempts to flush the pending request by calling
> p9_client_flush(). Since commit 9523feac272c switched the wait from
> wait_event_interruptible() to wait_event_killable(), only SIGKILL can
> interrupt the wait. However, the flush path also clears TIF_SIGPENDING,
> which prevents subsequent wait_event_killable() calls from detecting the
> already-pending SIGKILL. This makes the task unkillable.

Yes, the task is unkillable, it's a known issue -- I don't see how
that's a new problem with the switch to wait_event_killable(), as far as
I'm aware it was a problem even before the commit you listed.

Unfortunately we pretty much have to wait for the flush to complete for
consistency in some RPCs (I don't remember what exactly, before commit
728356dedeff ("9p: Add refcount to p9_req_t") there was an obvious use
after free, now there should not be a UAF problem but for some reason
I've always been waiting for async flush (something like [1], execept it
introduced other regressions and never made it because of eternal Lack
Of Time))

If you've really thought it out and can convince me we can safely do
this I'll give it another thought but in practice it's only a problem
for broken servers (or syzcaller), so I'd rather prioritize not
regressing elsewhere unless there are good arguments...
If it helps fuzzing though I guess we could have this as a mount option?
but then you'd not be fuzzing the same code path as regular apps, so I'm
not convinced it's a good idea either...

[1] https://lore.kernel.org/all/1544532108-21689-3-git-send-email-asmadeus@codewreck.org/T/#md5b45e3a9fda626a3e48489e12eed27a455707f7

Thanks,
-- 
Dominique Martinet | Asmadeus
