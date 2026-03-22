Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACD344DAE
	for <v9fs@lists.linux.dev>; Sun, 22 Mar 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186399; cv=none; b=R+SsyaieHpOAiEEmqZ7aL9Mrppu86okXuzFweD9N7GPKOfhZk/3Jadz0BkPixdxy8J8OidxHFAQY/w2f6YLPxMtAL5ZrcU28iXSpGyfpdDTzwOgcJyCrihwEwJUJZ27ecLAzvhY85FyXjuwyz4WIwHLiloRHwKoH5plNElYQORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186399; c=relaxed/simple;
	bh=JZWeHEJxzefnuAGwP66wkWC1F0jUUiAxCfDL4Nb5Jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLLHwVzA4Ic86PePcMrkpXPK+o+bv21nVz38RhViXtA5nKGv+rPFBagtoBbZ3a5GykYjIL0jFOOz1Cylxld8X/nkzbUu2SVVyvuRyHEYgXmiMON+C8EQaqmMAaHSAvwrICmEFQ5zvLMu41TG5GHMXPi8T5GgUq3NzmIdswB6n6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=j8xJOYDp; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="j8xJOYDp"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id BE68414C2D6;
	Sun, 22 Mar 2026 14:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1774186394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yq2WigjTd2tcF01ZSXjK9eGI897yLJiuB+HLtu7lEzg=;
	b=j8xJOYDp5YsfMjwUMJUt+kwpllyldwl9sqZ3GBLF/7Pk8k7ghQTzR91uBS12Y1t2a/khXM
	HeNvVKugHes6wXricsg1btI+9dsygB928u7tiLcmj+lGo72oD7ibzkVyLT7EqT10csjomk
	fcK7zGBy+o8R5OBg5FOIU60XW/1I7D5L13Y7ZN+3WVXKeosg12LltxjTI0JuK3l2KweymK
	lu1B6vIM+ZcaPP+c+YH0Mja5TZiYnf74oqFgKfLeoYRLfxVycMtlL0JD1HH83Ry5qvkibI
	73dJFKzf/ee9+e/H7VvAV8NKx6xkPCY/4M4Z165FPYuINj6dQbXv3bsMrqQAVw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 70a0a257;
	Sun, 22 Mar 2026 13:33:10 +0000 (UTC)
Date: Sun, 22 Mar 2026 22:32:54 +0900
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
Message-ID: <ab_vhl5g5MmmlU9z@codewreck.org>
References: <20260322111848.2837057-1-syoshida@redhat.com>
 <ab_b-95Ok9zLQCdn@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab_b-95Ok9zLQCdn@codewreck.org>

Dominique Martinet wrote on Sun, Mar 22, 2026 at 09:09:31PM +0900:
> Unfortunately we pretty much have to wait for the flush to complete for
> consistency in some RPCs (I don't remember what exactly, before commit
> 728356dedeff ("9p: Add refcount to p9_req_t") there was an obvious use
> after free, now there should not be a UAF problem but for some reason
> I've always been waiting for async flush (something like [1], execept it
> introduced other regressions and never made it because of eternal Lack
> Of Time))

Just thinking about it some more, one problem even with refcount would
be that we'll be either leaking memory/the tag for the request (if we
just take the ref on return from p9_client_rpc and wait to receive the
response), or will free the tag and risk reusing it before the server
replies to the original request.

I really don't see how that could work decently without some kind of
async flush.

If you're interested in taking over, I had rebased the 2018 patches I
linked earlier in 2023 here:
https://github.com/martinetd/linux/commits/9p-async-v2

I don't remember why I didn't send it for review again in 2023,
part of the 2019 patches about async clunks definitely was a problem
because we have to wait for the clunk happy path (because some servers
flush on clunk when cache is involved), but the 2023 patches properly
only do it on retry which is a net improvement, and the flush code
should be workable in theory, so this would "just" need another rebase
(that should not be too bad) and heavy testing...

Whatever we'd merge doesn't need to be based on these patches if you
prefer to reimplement it, I'm not concerned about authorship here, but I
don't think the current approach is appropriate.


Thanks,
-- 
Dominique Martinet | Asmadeus
