Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334B2BE62C
	for <v9fs@lists.linux.dev>; Mon,  3 Nov 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155283; cv=none; b=DPpKVnSGq5c9bP+0009pDDjl+nlu7dN0Kk7f2Ocx0AhFxqIhoz0OZoyXgL+ZDDxxknsEOPu7J7l2kchceHptIkbuskDZBm3+k2tbt2erL3c6SANz37vv0X7/MzWe7NPC3mR0G4IVVyAZrGiDrG8IpbclwdAxO1O9LBqMvKEJlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155283; c=relaxed/simple;
	bh=OaIrQuLa4Fc/nUWN+i36v0NLFWmb/7dXjMkFBh6t7HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5KxhlXEznf6bArFUw98svqMDV4dxPTwBo5ASTb+KxKRADO40WiVS+bSDhPYgyVnNee/i8xh7UbfPTyEgn73ThVDbHBscVvvNxrusZ9FP4UiMEsTIBj6eBhKyrO9UOScmNHXUH6a6j+rEcOzpgBZyLXuuU+j1RedeoHKQfkJgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Q5155Gp8; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Q5155Gp8"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5ED9014C2D3;
	Mon,  3 Nov 2025 08:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1762155277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQrtrx4bqMFJsQe0FEzhHJ9535jhbktObZu6e5hp1Hw=;
	b=Q5155Gp8XBV8wrqnW7AmSnBBTyLdLM+Pext9G/hNgUyJmWEYI4tVax6dZe1b02SLnWba7W
	NNtD4srNvbh2BwyaewUZIoofXsXLDQH4IVBdPAmrlmZ61tNqMzK6mttrfaI73hvG+AuJpY
	UaWoXebY0HSZDDtwvQRc7UEeRUCoL9A6Lq9SAswb9JwZFMbQlOZiMqpUQa8gazGta//OtT
	yA9PxowqL2lPS0PhKViSQuZUAEMHqQVEPFUipLlvSqnqb/7Ah/+qbiORjrmgJNUqt5/Gcp
	keja4xlWVDLIGFe49bhjQ6kA5W+tsfS71qJBp97N607ZnAiJPreMGpkFO3v7OA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1231a4a8;
	Mon, 3 Nov 2025 07:34:34 +0000 (UTC)
Date: Mon, 3 Nov 2025 16:34:19 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: [PATCH v2] fs/9p: Don't open remote file with APPEND mode when
 writeback cache is used
Message-ID: <aQha--QBgwu8DoDE@codewreck.org>
References: <cover.1762115015.git.m@maowtm.org>
 <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org>
 <aQfkMUncxteb9aPW@codewreck.org>
 <20251102235631.8724-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251102235631.8724-1-m@maowtm.org>

Thanks for the v2

Tingmao Wang wrote on Sun, Nov 02, 2025 at 11:56:30PM +0000:
> I haven't done a bisect to figure out if this regression was introduced by
> a change or was this behaviour always present - 6.14 has the same problem
> and 6.13 did not compile for me due to some problem with bool / true /
> false being a keyword in c23, and it could not compile with c17 either.

Ok so you got me at the "it happens in cache=loose too", so I went ahead
with bisect... I had the same problem with newer gcc being c23 and older
kernels being silly, you'd think `KCFLAGS=-std=gnu11` is enough but some
arch makefiles ignore that so I went in heavy patching
arch/x86/boot/Makefile and arch/x86/boot/compressed/Makefile . . .
... Anyway, it certainly didn't break recently, but it's not ages ago
either: the repro you made (thank you!!) starts failing in 6.4 cache
rework: the first bad commit is actually 21e26d5e54ab ("fs/9p: Fix bit
operation logic error"), but that's just a fixup of the previous commit
so 4eb3117888a9 ("fs/9p: Rework cache modes and add new options to
Documentation") is the cluprit... and... I'm not quite sure I get why
without digging deeper...
(But at least that made me realize the commit just before, 1543b4c5071c
("fs/9p: remove writeback fid and fix per-file modes"), removed the
writeback fid I was talking about... But that commit was working (with a
sane ~P9_OWRITE mask), so it's not directly that removal that broke
things, but something else in the rework)


Anyway, I think this commit is a strict improvement over the current
situation, I'll just slap a Fixes tag and push to -next for now, and if
time allows I'll try to have a closer look...

Thanks,
-- 
Dominique
