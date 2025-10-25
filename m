Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975323315A
	for <v9fs@lists.linux.dev>; Sat, 25 Oct 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406757; cv=none; b=KxL5zQcvDY70quJ9JgwxrKqhUNnSYrk6fC9PqZVtZYoP59MTYKsIZ9oO2aw8Bl8A8S3Qfv2E2CCFXMCvmDl+2qvxs55+xo6klE7dk7Rhahk+78hYdCGuqblaANRlYbZb+RdEVejL3zBwIQy5Odcj6evD2N4WeRZzSK/MHKmeevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406757; c=relaxed/simple;
	bh=lIcT7DGHfmW+6KASwi1FSInr/6v4dqNDhMmWNSx8n98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dE+3osm7celu1XOZrNNcqqDL9DMKPOM0rmLcfIvhT397Z9ymzcp+Z1PXotkG6UHs6LqOpf6f00ry98NB8x4C64NUfrLgZlpupmOIXbVUqWDhBP2XV8rXz0pF3za8b9Hf1O+8idx5kJ+G7ZcV8gT6nmd1x4iB0PRAw1ObOP3DAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=VymnHbRW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIBsEoKZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="VymnHbRW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIBsEoKZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E717E7A02B5;
	Sat, 25 Oct 2025 11:39:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 25 Oct 2025 11:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761406754;
	 x=1761493154; bh=4lsl0L/8q6KxkaWZxSqc3YCjdL7PlHqwbE9m4byzu70=; b=
	VymnHbRWAclIBNsd83NmFxeOafm66E8DQ5FNEnYatVM4mgu8WqxXkSnAxWZl7bJC
	krkhTGA5cipXQg/xFmex64Ad0rFIKOHuYLkN2FnKkrRA3Tyod7tpe82OHiXpn2p8
	qe+OgmTsaeNuc+c92DBk11jb3mKdJy5+FmzY9TW41kJC5pM0poWSMg4cEGr8d8eX
	mH4Ts5k3AED+vaQ088BXh6Wf6ndNbhiCD1B3ntGvol8EbFtxwWoFP4bLEXzqFHh2
	EnaYvaoN7WBws4nVDaxup7PVJPizIPP+nLxB0QI4Vwz/jg2btGJD5dq9D8ubNERG
	oYhVHm6rxxb6VeD3Lg0asw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761406754; x=
	1761493154; bh=4lsl0L/8q6KxkaWZxSqc3YCjdL7PlHqwbE9m4byzu70=; b=q
	IBsEoKZXLWsEmP/6HwFp+n9kkR3QLBec84xdS1J85JPhQ/PhZ+IQirJD7vhf0MCa
	0LmsJedcbiKBWHmYd8NiGJCAc8Y2gVcQgRw2V/rpX5koQWypPfJxizF8aJTGEwWI
	+DUmhJN81mgb6H9C/6nAZwurbsojCVyQ1F1Ax4Zv4hwwLb52doKAhRDn5lVoS4gu
	OmD7ncdJWBlQwuoaSR/4XaIXu6JZNjhJVOnF4SWqEQkPtT+DFsJTxrvLpct+NBt5
	H4P+bcr1qOVZUXKnk7y48LnqugXYIsLRMsnKbj8GqEvM62tNwzPh53i9K3TF0IWo
	WUNF8f99DkrkFJyoZyrHg==
X-ME-Sender: <xms:IO_8aG06GqdOxAUC1e0fulmCSXFPg2I2EyJSubDwz3Bc15bi3Y1w0g>
    <xme:IO_8aJiExipX3nHkgPNa8piMH49OAirKFIUu8gub3g0DpBhSN1pkSb1cH3loY-hcf
    xIIL-IBsKrD_WE2vBN3pb2Ug8Hthxw0_bLdfrUtuRLfh7dJSXxUZwyf>
X-ME-Received: <xmr:IO_8aPkAzmY-A11DdFbgtWUQ3Pb3wNOuBO3sO7NL5xkfqIjeqjwknLF17u9mgYTGbd3SEKF8rx0ZAonkf_0sgE04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepje
    efgfeghfejuefhheeigedvteetudeiudefvefhhefggfffhfetudefteevudffnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegtohguvg
    ifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshiht
    vgdrtghomhdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    lhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepmhhitgesughighhikhhoug
    drnhgvthdprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Ie_8aPYG7iUX3rmdfzHZkdlfcGTD68ISxLWvC1Onnk2sfbUaqU50Jw>
    <xmx:Ie_8aKEzCDN2OJZcYiNbfa-TXyy5m03F0G9Wya5gO2048Fbujl6Ovw>
    <xmx:Ie_8aOaiwX-NMrQ9jnil6nQh7BMLfVb76OvVjynnHrnHQ5_kiUmyOQ>
    <xmx:Ie_8aOzX8ll50qpGENrerrq4Z3TkaeoVnB40-p56NTZ4nG0BdNzPFw>
    <xmx:Iu_8aD9NouaJ0FishsdAagPNfFUtXuYcuNPMSsa5V4I1RsEkgGDeBX2k>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 11:39:11 -0400 (EDT)
Message-ID: <73432e36-de5b-48fb-b314-052b2668bb8e@maowtm.org>
Date: Sat, 25 Oct 2025 16:39:10 +0100
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH] fs/9p: delete unnnecessary condition
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Latchesar Ionkov
 <lucho@ionkov.net>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aPtiSJl8EwSfVvqN@stanley.mountain> <13655400.bYd4YqkHfl@silver>
 <aPuAXaHNWMhZOeuv@codewreck.org>
Content-Language: en-US
In-Reply-To: <aPuAXaHNWMhZOeuv@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/25 14:34, Dominique Martinet wrote:
> [...]
> Anyway, thanksfully this particular double retval < 0 check is harmless
> -- I'll pick this up for -next for now but hopefully we'll be able to
> "revert the revert" and fix the other problems Tingmao pointed out by
> the time we reach the 6.19 merge window...

I'm hoping that the solution I proposed [1], which is to pass
V9FS_STAT2INODE_KEEP_ISIZE in v9fs_refresh_inode_dotl if v9ses->cache &
(CACHE_LOOSE | CACHE_WRITEBACK), would be good enough to prevent these
sorts of issues.  But given I've already missed a thing the first time,
I'm less confident in my judgement now 😅

(The other alternative I see is to flush the cache before updating
metadata, like we do in v9fs_vfs_getattr, but then that's a even larger
change, and I'm also not sure if it would be race-free (i.e. if another
write is processed after we flush but before we refresh metadata))

I can try and do some more testing on this, and would welcome pointers on
things to try.  Also let me know if you think the above suggestion
(V9FS_V9FS_STAT2INODE_KEEP_ISIZE) is safe on its own.

(Also, for some context, the main victim of this stale metadata issue,
afaik, is just the workaround for Landlock to work on 9pfs, in which we
get something to deliberately hold the paths used in rules open for the
inode to be reused.  Although I guess some other workloads which do a
similar thing might also suffer from this so still good to get this (stale
metadata issue) fixed.  I hope we eventually come to a proper solution for
the Landlock issue tho)

[1]: https://lore.kernel.org/all/6c74ad63-3afc-4549-9ac6-494b9a63e839@maowtm.org/
