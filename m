Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317941;
	b=JbY4nK7uDaguTY7yS8kdiGk7XOc10r9bAa705XAx9sa7lqc90X5YchxNOkpgge438AjK
	 uaLDI4z1eeayEXjSSrPPZCHXjvpTwa1JCOl9vzLQX60XSXAqg+R8epqzcdsOaM//AKFBm
	 UPEwTduItL7CDoyWIny2Pflhi7LiDG4HnZ800tYxAzEzDsCiOtWoQ4Rh+hMQ28G0uXoQm
	 N5YgLVEXdFEfcOkToZi0kIK7lE42fL9sOtEULB2z4AHnkwHPjZjKSpRF8j+bLtxgoeDpg
	 p4IFH3x9OEoYPhri+7L00HoKTsTBe01RYRgN/MhDNoZDbGHJzoXDUiSro536t2/noLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317941;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uJAyGgp0q306lE3dBNgeZglrmKITpnYBT4hRyV1iCu8=;
	b=KVlrUlMWMbXmkhEm8hHX99jaUGGQ8ok3hnyBcpgNruIhO20gfUBPgja97TXeZKsp+OaI
	 AT3P+6XEkUDqkYAKu5jd480xnAxpY/b4P3hHTbYBW+4+mGHGKDQFGOD7bWz6rfji0cHot
	 gD1s40sa7SnEcEmKCvcmVWwdhBDZBbg6mmvgR2WAFcwymByQSP3pSNZEg2M7kiErRToDz
	 Ds+hTSRIsfbYQ6yKd1/k8D8sDEP/6DdRN/SYKA+W2RwmwCzEHr+ZXq5gWkOWFL8LkHoaA
	 qMY49/rUQECLGQqvR78M9HyWp5gXHq3yYJrje/VSmd+aEEavU3PesyEJXYHh33eVccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b="g8q/bMdw";
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02022606A7D2
	for <v9fs@lists.linux.dev>; Tue, 10 Nov 2026 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02022606A7D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=g8q/bMdw
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 46BD814C2D6;
	Tue, 10 Nov 2026 14:38:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794317929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJAyGgp0q306lE3dBNgeZglrmKITpnYBT4hRyV1iCu8=;
	b=g8q/bMdw5r1gr7kWrexHMdvv1TeWb2K1Sk4CfjgtzUiIKlgy94Kkk8GF5vojcn9AYbEWyx
	95aZbLEkawG/3MejkHpHugF4dCxEOLne0EbAt1HdSoHRukleBg4rwahmfSv0gupFXPFRay
	MjPGDDvqodOOdbHvKYzlhluLNPF7uYY76grbZuK8bDhcxjKBVa6pXEVFn0ltZX43VnO2jy
	wU+xx27gBo+J8f2LsPWE1RcZGHPPTlYwlnYBiW4PhFjvdx5ajNloQMa8gm3C4qf7cHAatv
	9Oh6n+gcuruaYCnCazma9ZNCQgqCTF2N4l6QnwZlI37aDyX+tRJMMBlOy8t8vA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c25126cb;
	Tue, 10 Nov 2026 13:38:44 +0000 (UTC)
Date: Tue, 10 Nov 2026 22:38:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	ericvh@kernel.org, lucho@ionkov.net, andreas.noever@gmail.com,
	YehezkelShB@gmail.com, corbet@lwn.net, linux-usb@vger.kernel.org,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux_oss@crudebyte.com
Subject: Re: [PATCH 0/3] net/9p: Add 9P transport over USB4STREAM
Message-ID: <avMeVSDYT9p9PHz4@codewreck.org>
References: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
 <auKzZIyFW2CTci1b@codewreck.org>
 <bc1ec916278d94116bd9b60e40b549612e3ff3a4.camel@linux.intel.com>
 <20261109165236.GW176724@black.igk.intel.com>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109165236.GW176724@black.igk.intel.com>

Mika Westerberg wrote on Mon, Nov 09, 2026 at 05:52:36PM +0100:
> > In case of one-shot backup, I think my drag&drop scenario from cover-
> > letter fits it well. Assuming single thread copy, both transports
> > achieve similar results, but with busy-poll enabled, trans=thunderbolt
> > cuts about 1/3rd of copy time:
> > Copy from 9P client to a server, using trans=fd, takes 22m29s while
> > trans=thunderbolt + busy-poll takes 14m50s (~1.5x faster).
> > Reverse direction, same improvement: reducing copy time from 41m07s to
> > 26m56s. All done on default msize.
> 
> That sounds like a good reason to include it IMHO. Also I like the
> simplicity - no need to run a separate descriptor feeding process :)

I'm sorry but I'm just not convinced it's useful enough to warrant the
effort to review this from my point of view given my lack of time for
linux work:
- most of the speed benefit comes from busy-poll, can't this be made to
work for all fd consumers somehow? (it could be an ioctl before passing
the fd to the mount call, or it could reuse e.g. the existing NAPI
config with network over usb4stream if that's more practical; in
particular I recall some drivers supporting a hybrid mode that'd
busy-poll for x ns/ms then fall back to waiting for the irq, that'd get
you the best of both worlds as a sane default)
- for simplicity it looks like mounting from boot without initrd isn't a
goal, so this can all be hidden in a userspace wrapper. 9p has
historically always been pretty bare, we're not even doing dns
resolution that has been a basic feature available for nfs since
forever.
You can look at this mount.9P helper for inspiration:
https://github.com/nfs-ganesha/nfs-ganesha/blob/V15.2/src/tools/mount.9P

> > I would be happy to maintain Thunderbolt transport.
> 
> If Dominique is okay with this, I suggest to send v2 with a MAINTAINERS
> update as well.

OTOH if you're going to maintain this I have no reason to block, I can
just say I'm not reviewing in depth and pass the ball to Linus or
someone else higher up the stack to decide...

-- 
Dominique Martinet | Asmadeus
