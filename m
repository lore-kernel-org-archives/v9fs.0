Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0601C84AB
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309181; cv=none; b=dlCNGV6cEDKh06Xdw53AaN4Y4vTRl2CSmBId3AU3OwY+vWAR+oNmFGTMzMfe4BY6cVPPRxgnhQvp9pRBTVQr9Mry0IpV1vUwF147qhzBq5EnSPdpHWnCe/4oT6NyghHTED/sGhMR/dWonlWoC4jm13bwsX8bSaiWPiUcxiBuXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309181; c=relaxed/simple;
	bh=dIIU80Y1Z+W2CcZ3RBEfXeARM53B+yqk92PYGDcsr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BX6LnvbEwew1B3LJwXfvC7FdtpFa+Dp7z7vHgkMsfaaOKwFeSC1YFjU3YD19ujy/VviQJRGsBz+GVWC4yq7I+GeqPtEIskOyiMwJY3uX76SAsbl8U6Gof6ayr0nXgDDmxErymY6SkN/Xl9juPg7kThrjhVfyxpnFcJ+npJEGYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ERtdc9u7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ERtdc9u7"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5DC5D14C2D6;
	Thu, 16 Apr 2026 05:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776309174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hGNsQxXZD/hut4x0xMOkgbJ2GALgTEFTVphqvJGnPV0=;
	b=ERtdc9u7QBOaBE7pnUAqE9Kt3+n4ugNqzOggNbHBeF+A4jXTS9IRarrfGRnLRlk3ztntgA
	QF+xDS2NasMj/B/YBDEUJiyirYagrGskgy48r7xK8jEwSoOhn8isUpMk7Bybbr1jeb0Lz3
	IC0hUkwTe5ycCAURPRixNnPDxNqi7o/7wNRn9oN7RIA5KBM+8Y6brARSnCioF0JPKpxIiZ
	PHPCHQgZO4e2+xMF6DMaNXN8R0+0+ddLA9uiBTScnwviV3LbBaIIF5jXhop0JtyyHmHRId
	pAgIGQe25tsbEJUG+S5obwXQKO8mhdVEC8BsvAHAgvMpXP9WzIGcOHf88gGHJA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 873c0469;
	Thu, 16 Apr 2026 03:12:49 +0000 (UTC)
Date: Thu, 16 Apr 2026 12:12:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	Pierre Barre <pierre@barre.sh>, sandeen@redhat.com,
	Remi Pommarel <repk@triplefau.lt>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	David Howells <dhowells@redhat.com>
Subject: 9p patches in flight recap/what did I miss
Message-ID: <aeBToj14IBI6jh6Q@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

This is mostly for myself as I can't keep up, please tell me if I'm
missing anything obvious.

I have these queued for 7.1-rc1 (will send early next week to Linus)

https://lore.kernel.org/r/20260225135745.351984-1-sashal@kernel.org/
* 0fd76f1be20d 9p: fix memory leak in v9fs_init_fs_context error path
https://lore.kernel.org/r/0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com/
* da2346a48a5a 9p: fix access mode flags being ORed instead of replaced
https://lore.kernel.org/r/20260315190633.73536-1-xaum.io@gmail.com/
* 890d56964c62 9p: document missing enum values in kernel-doc comments
https://lore.kernel.org/r/20260324153023.86853-2-ericterminal@gmail.com/
* 72cb9ee4f6d8 9p/trans_xen: make cleanup idempotent after dataring alloc errors
* 8fc518e489c1 9p/trans_xen: replace simple_strto* with kstrtouintq

I have these queued for 7.2

https://lore.kernel.org/r/551c057c5dbcc83f19b9c8a3b508bd971598f657.1774380535.git.repk@triplefau.lt/
* fabe6e8af53a 9p: Cache negative dentries for lookup performance
* 2e624a12ba29 9p: Add mount option for negative dentry cache retention
* 060ba5a058cb 9p: Set default negative dentry retention time for cache=loose
* 47a37d360868 9p: Enable symlink caching in page cache

And these that need some work/help sorting out
- usb fixes 20260319-9pfixes-v1-0-c977a7433185@pengutronix.de
** I don't have the bandwidth for such a big rework, happy to just trust
Michael here given I can't test usb...
- writeback corruption 20251227083751.715152-1-pierre@barre.sh
** David sent another patch but honestly it's too complex for a quick
review, my gut feeling is to prefer Pierre's simpler approach first and
take the time to iterate (if we ever find time to...), but I just
haven't the time to check even that.
- lifting virtio msize limit
cover.1657920926.git.linux_oss@crudebyte.com and/or virtio buffer
iteration 20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org
** Once again ENOTIME stikes so I didn't check, but do your patches also
address the invalid access problem? Should we get Chris to test with
your patches?
I still think it's a shame to duplicate all this code and it should be
possible to do a bit better, but I agree improving sg_table is an
elephant I don't want to fight...


Thank you all,

by the way if anyone wants to take over for (at least) the next few
cycles I wouldn't mind at all, having a shiny new baby and a jealous 3yo
doesn't help :p
-- 
Dominique

