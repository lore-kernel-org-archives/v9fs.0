Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7853DDDC9
	for <v9fs@lists.linux.dev>; Thu,  2 Apr 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124632; cv=none; b=MaZL1G69Emo0QB1fsR88s/foUYzFq9xHi7ciE9B1Qi7O6Hi5nyHaqU2MNcrUTm75yYE+OiZmQ7rQb3VJKSYn3FIWmr371/VAh/r3biBJqYIwbrkOKL2AU/As0zYTh+xvxTa1Kw4QozJaYKKnAlYdqtm0DdeEkWZphHIvVQrpjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124632; c=relaxed/simple;
	bh=xVmuycfLwNQ3omqbTqjnro+8/vcCy2B12kgtgX0L4NA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SZVipfzQefUofJQ7rbTbqkU5xafm47NhI7P4VAic9si20MhxY+TAb5lCgiCuTpyxWOoJVKG6G3Z2oNyvdjvUL9UaxgslsqA/O69t8n8W247MT+bJ5onvgF9dsa+mhpJCYQXmbyULpXJ7D7dbMjZU7m461Box2fMm+fA1H3DVblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=h6YBBQXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOf7cWci; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="h6YBBQXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOf7cWci"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5997E1400263;
	Thu,  2 Apr 2026 06:10:29 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 06:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775124629;
	 x=1775211029; bh=rwb3s0na1s2ywJgMpNsKHLX3L30KxLLtCh5OfR6KMk4=; b=
	h6YBBQXBTTDAS9ApX8flPbZrtidNKscqpwngIOaMvE5TgU9iwA0D7eQFZfq5jb98
	qRTuopiVXWNtIWrRFEikiFmqWm9Yh/glq6O0RGQOIkkHxI++jpwIMPXUYJvRaOiZ
	AmMyOaKCfafYWELV28paM5A+cqpHKJfhX6bvPiysbCCTh0AMaELmBoHEQPDE7SIC
	fjVlJgbC/mVJZpmNvbt/3jJSQDvmy47WtYvnmpiiNa6sCGcu3ecOwmQgPgAghaB7
	28KfpUA4tpRvN2CcyKg3rHfkSi/Eaah55eL/YHx1eVX7+HMyySGQ+57c4EVVHrml
	RzUAABGsMjI8Rs7meTVW9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775124629; x=
	1775211029; bh=rwb3s0na1s2ywJgMpNsKHLX3L30KxLLtCh5OfR6KMk4=; b=Z
	Of7cWciTKnisiIO3L+jHbMY2KJlkhQF5BSnX3VN/WDwltcZqtctjUpCkLqhb0YJC
	wOabT3VE3Ovw9CkvaVgKlDkHxx51J64RRagiGjVY44KAGVZ8rbDsVwhVXUNaqglK
	l9zl3HlYgi142ttsnjeyOJyAgvGsch73PtGf0MrNTn4dGlc33biZARaSGo7NXXu+
	oPqyMI4jewTZHwhTiei5smFWZIJByzGnKxRZYP4Yz8DPaSHixuevjMcgIgBiB/sf
	7hQAojeAHGudiL5oF+4OHezUECvOqaqRhbpIN9qoyX9TOtjpmCaioHG1pjGP7Y/y
	p5nHCjQsIRYQ0T9obZ7zg==
X-ME-Sender: <xms:lEDOadoQhealPPHbGXOcPE9Ex1L_kuVxIcbIKqiJaEX1-CEABZDnOQ>
    <xme:lEDOaafcUiSkr6V3Ys9VgDyYuwqkPQsRP-Mr3My6NRXflJTpw8QFEv3U9CZoHCoe-
    QnJUYa0wGlspplArdR2Zjqs15SjLuqL7Vk21G4mTWrS6TUgbBFGpaVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghr
    rhgvrdhshheqnecuggftrfgrthhtvghrnhepteegiedvfffhieehvdekfeeukeegiedvke
    ehkeejueeijeeitdfftdejtedvffejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpth
    htohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegt
    ohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvg
    gshihtvgdrtghomhdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgt
    phhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhelfhhsse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshgrnhguvggvnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lEDOaUa6wZf2WeS_a0R5R6WZD5D2xefUEn6Trb-fw0SxHCw8PXTF4g>
    <xmx:lEDOaR8UE0oama8_Rf-zd4FfeyCYrWaRdbCPTdy0PT-IvtAGbwLY5w>
    <xmx:lEDOaSlA5aOLBriLI3U-TOlzelbi_w7HzvV8R9k1lYGPw615VdoDjw>
    <xmx:lEDOaezcmYHdRWNRdUSSPncSsrcXSatshlbd5U98uOK3OfOcGGbKZA>
    <xmx:lUDOaa0nGR1eoSSmzH3xnI2cZe_t0F4Cuw-c-oPoZC9P6o4xzXKcPwc5>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0555B6006E; Thu,  2 Apr 2026 06:10:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A7SXi_NfNDDB
Date: Thu, 02 Apr 2026 12:10:08 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus <asmadeus@codewreck.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sandeen@redhat.com
Message-Id: <e1802c64-3193-41de-ada6-625bee8fe8fb@app.fastmail.com>
In-Reply-To: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

To reproduce: mount a 9P2000.L filesystem with access=user on kernel 6.19+:

# mount -t 9p -o trans=tcp,port=5564,version=9p2000.L,access=user 127.0.0.1 /mnt/9p

Then as root:

  touch /mnt/9p/test
  chown root:root /mnt/9p/test
  
# chown: changing ownership of '/mnt/9p/test': Operation not permitted

Tracing the server side confirms the attach arrives with uid=65534 (nobody) instead of 0 (root).

On Thu, Apr 2, 2026, at 12:03, Pierre Barre wrote:
> Since commit 1f3e4142c0eb ("9p: convert to the new mount API"),
> v9fs_apply_options() applies parsed mount flags with |= onto flags
> already set by v9fs_session_init(). For 9P2000.L, session_init sets
> V9FS_ACCESS_CLIENT as the default, so when the user mounts with
> "access=user", both bits end up set. Access mode checks compare
> against exact values, so having both bits set matches neither mode.
>
> This causes v9fs_fid_lookup() to fall through to the default switch
> case, using INVALID_UID (nobody/65534) instead of current_fsuid()
> for all fid lookups. Root is then unable to chown or perform other
> privileged operations.
>
> Fix by clearing the access mask before applying the user's choice.
>
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  fs/9p/v9fs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 057487efaaeb..05a5e1c4df35 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct 
> v9fs_session_info *v9ses,
>         /*
>          * Note that we must |= flags here as session_init already
>          * set basic flags. This adds in flags from parsed options.
> +        * Access flags are mutually exclusive, so clear any access
> +        * bits set by session_init before applying the user's choice.
>          */
> +       if (ctx->session_opts.flags & V9FS_ACCESS_MASK)
> +               v9ses->flags &= ~V9FS_ACCESS_MASK;
>         v9ses->flags |= ctx->session_opts.flags;
>  #ifdef CONFIG_9P_FSCACHE
>         v9ses->cachetag = ctx->session_opts.cachetag;
> --
> 2.51.0
