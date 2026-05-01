Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294F3C061F
	for <v9fs@lists.linux.dev>; Fri,  1 May 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644713; cv=none; b=FzChZBRxJ4Q3A2/yN0ZYSyvVLUTVvsiqNxLXvjLqenzo4Izsi8/YY6un5PAox9OJ/NkV0PeFzf6DVXKq3XqlGRD4j+dwxbZ/wAltzzmbK81QO8lIOPw6EfiEQdkS/BF2VzJa/dpUzdHqsLU7KbKcMi1nFXMg3WVE90P+s2A7ZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644713; c=relaxed/simple;
	bh=Hu/9HOt8rJB1FVbbU9t5HrQ6ttXB7cTCQ7HvEb3vjvQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q51Ds1+jB37Ti02//YhrPWs7tHheyxbMZ0gBXSMNYm93ncdX29BHbOly4Ddfd82Alx63sxlcspnsYyzT34GvOpwKI6qFTuSYLlOWBWNtJkfVtIPHqWFgfLGerCS3R0U7JeOdDmLmy8xQ/3rbtcWgLnAYaSiasNI8tBxt75NgWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=noQuXDpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JrCYekxh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="noQuXDpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrCYekxh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 277CC14000C1;
	Fri,  1 May 2026 10:11:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-06.internal (MEProxy); Fri, 01 May 2026 10:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777644711;
	 x=1777731111; bh=RvVc7EXTz4pIaQSxzWgBr+Z9f5f/T+ZCpOaNj0PrfGk=; b=
	noQuXDpWA9BKDzeqlgCgGqN7XCXd2xcuvOJbWnfgCfIoqLZjF/2QU0nRVlc74Scq
	kaDP4tJTHrOkbyqbDKFIkq3mfd/TMXThc0VrVjycq3++G09CK3rtKqr6pBfiZBke
	s/nK+k9pchJOevnBscd6/fZx9hgrisC+DvGR/iyTqwTcUb71qWMB2upqT9++8nld
	GapcNGlxNO44qneXZZB4Egnryn32XbCcj22d8ivLM1UjqHrYknS8Ikzwj7+u125U
	xHxMKfAK4J/XmhdTd+Gx6RaUtb/OrAFgWCxMsQrZXQy014tnwo9BS1eV1JFzhZOU
	Eywl/ot1o+QFgirpS6pX7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1777644711; x=1777731111; bh=R
	vVc7EXTz4pIaQSxzWgBr+Z9f5f/T+ZCpOaNj0PrfGk=; b=JrCYekxh3f0ySS+vU
	cQv1oqH6G1OZ8pgB/2V0mcNCZ5YaTI92Zj51wojueGRIWGlKsEMZI/hiBUR5i6Xi
	STMamXfwe/v5AEijQTpsDsmgkDvATEK35QQtF4XGpuHyvSSbHWChNM4USgQtTOk3
	Xn1Z2HC0EFuQNAOBu3mPEpQbnvbYH+OFEClL4U6ETbj5+AjGF+oaYDx72PXt2ayN
	/gBcnhi2dzZvWofF07cjqO+vzyMQpre+7CMQJyliw0dlxVof2aVIq4Y3g6HhpjXK
	YxKKRMIxKXeH8JkP6E9+oebwkg0HucfBfZ6ayFsAfbfMhELxwloSNiABOLexKyLX
	WxnTw==
X-ME-Sender: <xms:prT0aVIZXqbPQ2m_oSMi4KEvJNGU-zOZgJ0Kvy78Dr7xPBTmhCYM0A>
    <xme:prT0ab9H96-hFQhTUE8G0y3EnazTtLgbqzDwjyRxvijQ4usSJ10G6LhcKVqmIx3q5
    feclcLFrzM07k-5SzSKAlfnkDnrLSFiydsU21yIiGF9hAZOJDzaIh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfrfhivghrrhgv
    uceurghrrhgvfdcuoehpihgvrhhrvgessggrrhhrvgdrshhhqeenucggtffrrghtthgvrh
    hnpedtkedvffeftddutdeuvdfgffeiuedtfedtueejgeevkeeugfeutddvueejgfeljeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdgu
    vghv
X-ME-Proxy: <xmx:prT0af14iS7QMYdxOwPiIyoemrSSdIjY4nUgT0ZZa9W-UODzJeKQ3Q>
    <xmx:prT0acAaUmpQxTFLevkrW1by21UrIwKzvSpUOtqjTrklUDbDxtaWlg>
    <xmx:prT0aXdhxBuzlm4mNW8A5AYzglwN1EhOZMEd__z-gfBZGeyr_O4BLA>
    <xmx:prT0aRhVeuuYncoFODUi_Of7Q_KcEJ82Yr1b-v2xAEYBbe1HvNKCPg>
    <xmx:p7T0acuMrWRd3kIV_LKtC5UB41CWbp7BJuek8EDlvwGTiFBICKi9kCzJ>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3D591B4006D; Fri,  1 May 2026 10:11:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 01 May 2026 16:11:29 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Eric Van Hensbergen" <ericvh@gmail.com>, v9fs@lists.linux.dev
Message-Id: <240a0dbe-370f-4c8c-9dea-877ad1f7481a@app.fastmail.com>
In-Reply-To: 
 <CAFkjPTniiwtBLf7yUepG_846QM6BeuKbxeisByQVTwkEQtjsZQ@mail.gmail.com>
References: 
 <CAFkjPTniiwtBLf7yUepG_846QM6BeuKbxeisByQVTwkEQtjsZQ@mail.gmail.com>
Subject: Re: FYI: v9fs/test rework
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Eric,

Glad to hear you're picking v9fs back up. In case any of it is useful as a reference point, I've been maintaining a fair amount of 9p CI for ZeroFS, exercising the Linux v9fs client against the ZeroFS server across a few transports and mount option combinations:

https://github.com/Barre/ZeroFS/tree/main/.github/workflows

Not a generic test harness like what you're building, but there may be some scenarios or pitfalls in there worth borrowing, including xfstests:

https://github.com/Barre/ZeroFS/blob/main/.github/workflows/xfstests-9p.yml

Happy to answer questions if anything looks relevant.

Best,
Pierre

On Sat, Apr 25, 2026, at 22:58, Eric Van Hensbergen wrote:
> I've started picking up v9fs again for something work related, but set
> out to first fix my test infrastructure.  Being lazy, I'm having
> Cursor do the test infrastructure rework for me -- it is still a work
> in progress, but I think it's already handling the old tests and
> starting to add new ones.  I need to suck in more of the diod testing
> framework as well so that I have full coverage there, and then I'm
> going to look at adding hugelgupf/9p and go9p.
>
> As part of this, I should be able to fix it for nightly builds and/or
> at least tracking upstream with regression tests across the multiple
> servers.
>
> Currently running in the main branch of github.com/v9fs/test
>
> Fortunately for everyone I'm not tilting at the caching stuff quite
> yet, I'm more interested in the synthetic file system angle.  So don't
> worry about me breaking everything (yet).
>
>        -eric
