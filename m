Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3B369D55
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024311; cv=none; b=o533HV62DaxqHq0Gr+SRxbdayKLe5cVvKEIgL51R93e4oi5o/vZ89C+xFof+ALFGgwaBWZzmjiwwl0GyThcBwEx6b7eFgx9ts/rLBZYwspBwwIxUaScq5kVbQ86loojqiYt/1X3+LIBxQMi7VM/lCkv1r/OMAK6Zdo1uR5Fh8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024311; c=relaxed/simple;
	bh=0oMSeB2GluYcxelP4breah5oEHpzkUULyVRc99mSCe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR5DvSX9K0woEZflA0QTclotSKrKarWFCjL9Jg2djYrUazhr+VcW8u3M6JlFBmfmH3V+HJNeIXv+K4o8H7g2jUmeBQN2I6FDRZemfBE03XDRJSy9P1T8cf6+2sxi6ix++QWMw5eKYrK7m1JywNeIQf/huMFRbLDbCULp8vXH0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wUaVcfyH; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wUaVcfyH"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 04B9614C2D6;
	Fri, 29 May 2026 05:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780024308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbpKW2TSgrCLa/K2Y0OoiDA6cDFrB+2d8wgaxfFfCMQ=;
	b=wUaVcfyHlqsOm7qzFSru6pWj4uFTfJkfxC3AcPdtLnXVLs08M36prU3XAqIfoKNxJezTRf
	5xKwicpmB89UVg7+n0Jxc/dRUoemVjt4EhTub7rx0vpABjRV9OXhk13vuhmCl43X74UN6k
	t+XvuJWINXNYht6wBL8l0jPazM0SpVJbwtHSFggEvpt5+WMByFTkaNSRiEFqm+CM4Z1Vkw
	HU8qr5KQz+MgJ2Hl8reA7cjdflovyEpDvZETLtbc/c2wwQWsligIlECsOWqUgz0DVT+XvS
	ZRhSXaAc4wzROV/arM/ISB9AdeK6y5qGoI9hqFBN0o6fd8qk6yr1llkbQSjWWg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0c1f7306;
	Fri, 29 May 2026 03:11:45 +0000 (UTC)
Date: Fri, 29 May 2026 12:11:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yifei Chu <yifeichu24@gmail.com>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] 9p: unknown RLOCK status triggers WARN_ONCE panic with
 panic_on_warn
Message-ID: <ahkD4tMzJR3qA0Bu@codewreck.org>
References: <CAPJnbgJ7ZK7DCjCfG56hd_iKGePmAzudb4hOWd4=9r32nM+KcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPJnbgJ7ZK7DCjCfG56hd_iKGePmAzudb4hOWd4=9r32nM+KcA@mail.gmail.com>

Yifei Chu wrote on Sun, May 24, 2026 at 10:43:57AM -0400:
> Short version: I found that a 9P2000.L server can return an unknown RLOCK
> status byte and make the Linux 9P client hit a WARN_ONCE() in
> v9fs_file_do_lock(). With panic_on_warn=1, that turns into a reproducible
> kernel panic.

You're right we should not WARN() due to server sending us bogus data
(only on internal state bug)

Please send a patch directly next time, especially since this is trivial

I've saved us both time for this time:
https://lore.kernel.org/r/20260529-lock-warn-v1-1-20c29580d61d@codewreck.org

-- 
Dominique
