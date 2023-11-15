Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9E3D6C
	for <v9fs@lists.linux.dev>; Wed, 15 Nov 2023 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ih3Vmn8D";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Lr8X1VL+"
Received: by nautica.notk.org (Postfix, from userid 108)
	id EE544C009; Wed, 15 Nov 2023 08:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1700032023; bh=XeRLQ/ZbHAhANYJbae35MvxoExBCZAaYiuVIDO+z5XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih3Vmn8D/uBdgYnvi+7m+l6Pp0pxyHIjmjKKpfmhPv9WrL5OTnl1LdNlSK/IBhMHO
	 AVkqIETpPyAtc17CY3fFMwYUDB2P1gKRlQI77TWFqkVxHtTFEilFTw2YciqZD/FWsv
	 un5gvIZ51w6TmpXVF9RPNxf34Q7EZdb+8eYb1ZWMk7Od8FU8wyu+wjV9DQg9wwPVvR
	 zOUapwHYpVV31T3FkQH78v5RzAm1n9FGMVT/umS5O0LOeH7rRoqCUN3Mr3m24Ur2/e
	 ooJLj9F7uVNeKmGFnOhoo/gGQtYd0MVQ9V9NjASFKAvjYXSPSAhvTyFKU767h7l1pu
	 VLWEzUOvC3FRQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 12B74C009;
	Wed, 15 Nov 2023 08:07:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1700032022; bh=XeRLQ/ZbHAhANYJbae35MvxoExBCZAaYiuVIDO+z5XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr8X1VL+SGwAvhkZLLHdA8XM2j/wkI+oons8D1Qk4LnwYsbj3nOA4CAXQXkpFHqgC
	 V6CVsDz2cgdRKsasq9MC7geIfcdCn7SKk2xdw+Ox9+1qyOurhMNCjuceCXzU0ITSBR
	 pQ1HcEmUB9Sxpdzuk3mrS0sYc1HAMeFeF+vYYQoRqPinb30E3gt9hwwvlIi8fznnr4
	 rXgGJtNX0WAAInmrZfF773BkxwWhHNhuemEvi2zB6NY5IPkGcKF80ZGvYF4x5x+8Z1
	 XYPuNUm19b/2Wb6AqU+/5E5VuxMQT7at6HARsWe8/ITqic2mNmdbfEzNxQ9DtvgpxL
	 bpQdV0szzYIlA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id d6a5a159;
	Wed, 15 Nov 2023 07:06:58 +0000 (UTC)
Date: Wed, 15 Nov 2023 16:06:43 +0900
From: "asmadeus@codewreck.org" <asmadeus@codewreck.org>
To: Albert Guo <aguo@vmware.com>
Cc: v9fs@lists.linux.dev
Subject: Re: [syzbot] WARNING: refcount bug in p9_client_walk
Message-ID: <ZVRuAzFQfLX162ye@codewreck.org>
References: <PH0PR05MB832071E5E0944D7C5CEA81DFB3B1A@PH0PR05MB8320.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR05MB832071E5E0944D7C5CEA81DFB3B1A@PH0PR05MB8320.namprd05.prod.outlook.com>

Albert Guo wrote on Wed, Nov 15, 2023 at 03:50:48AM +0000:
> Hi Asemadeus,

Please always cc the subsystem's mailing list when asking such
questions; there's no point in singling out maintainers.
(And it'd really help if you wouldn't mispell names; although I guess
you could also say it does help since rilled up folks are more likely to
answer...)

> I’m Albert Guo from VMware.  Sorry to disturb you. I’m writing to you to seek some help for Linux 9p driver.
> We use 9p driver in our product.  We seem to encounter similar refcount issue in our test:
> [syzbot] WARNING: refcount bug in p9_client_walk
> https://groups.google.com/g/syzkaller-bugs/c/UrvjxOLiykQ/m/LlVAtCzQBQAJ?pli=1
> 
> syzbot
> 2023年3月23日 06:02:37
> 
> 收件人 syzkall...@googlegroups.com<mailto:syzkall...@googlegroups.com>
> Auto-closing this bug as obsolete.
> No recent activity, existing reproducers are no longer triggering the issue.
> 
> 
> Looks like the issue isn’t reproducible from syzbot? Is it fixed? Do
> you know which commit fix the issue?

It might have been fixed in 26273ade77f54716e30dfd40ac6e85ceb54ac0f9 as
uninitialized use could be causing that, otherwise I don't know --
there's been no other fix around refcounting since that report...

> Our kernel version is  6.1.56: https://elixir.bootlin.com/linux/v6.1.56/source

But it's long been fixed (included in 6.2 and 6.1.2), so there must be
another problem.

Please give your full stack trace (and not just a link to syzbot); the
warn message might help.
Also, how often do you hit this? (Can we consider it "reproductible"
under test where you would be able to run with tracepoints, or
simplifying the load etc?)

-- 
Dominique Martinet | Asmadeus
