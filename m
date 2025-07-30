Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80396C120
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906628; cv=none; b=nmsP1B+imVDkGZ8HNchRt8S2HhzO239jgf1vlswQ7GRCNBKWwY6P+eVPuP4Ktzor/q7tVf/h4XFa9b1HZdFtII4OAq7ZZDn+r1U06BY27mQVhBcO2+KWwnNa9w6Y6RKOWpikZEgKhXYMenvUHfs5ESBbOApz+MEVQkLWu+FVqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906628; c=relaxed/simple;
	bh=ZVbb8lBznRoBXRYz0ljAjiax9MUByLStB6ouf6H+U1o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FiQ7aRIyi8z+KzrGZLXWIu4EcqxbcXyiA63JZLQyGUnijoSnA66lrko7Luc4Q9EnFUdBw1XF79IKKkHL44+vSjQljKRHtk6AbcbJqDdulP/Mn5Oa/B/O8cJapvljY8t30IkpOsQVYC9EcERuxjMho8lya846YxMwZh1TZ6m3OoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=c8R3yGqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mn2RkKCb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="c8R3yGqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mn2RkKCb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B72A214008B2;
	Wed, 30 Jul 2025 16:17:05 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 16:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753906625;
	 x=1753993025; bh=AuRBdRg1LOuNG4DKzGVBTR0NDrUviCmFnP6lYxZQPv4=; b=
	c8R3yGqLhEK1pcVj1Ffb3KQJc7la9HzmNNsSiNgVpeJBP0khUzhC7Xww3zGJT9pQ
	XPMKuyCdWcTkzbdNjmwiD7QBOlLd1yXPQYxsE2ZaDecNt3qcD451WSP96UMtZo8g
	KkOU/Z1ttcLzcayxnzgKb7Takjo0iDbvomoXZj+RR1psNz+fsvggPIXHmOrEZl86
	4THZjiFFWsqVGj1fZO8EDdKCmBMn1D1R2jhv7Bbqq0Q6q4UI/Hp+hm7eSSuILfZd
	nOA0fScwWPUr0OimHa/5c5yL/7xpYAyJYKrjhXFx9mHGVlDpsmxgV5HvhT1sr8Ua
	hyj+YFq38bnoduLGKQlPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753906625; x=
	1753993025; bh=AuRBdRg1LOuNG4DKzGVBTR0NDrUviCmFnP6lYxZQPv4=; b=m
	n2RkKCbTG2XEQePkmDDkWpLUfdHb75QQWk0DlKVUOo/A+xtvHzqVCPKUsb64PjTD
	EOmdbdNscV2NexbqICD5C3Tk4Gd+BoJUxv1gd8ZV/fXf6rizHn9FhIey1sPExMQo
	cx9JmZi827Wj3Bosm6MLNMx7/B5RR8kcb2f9dQ/C4AU/l2iVkwPjBrKm/45RLqjR
	qpUOB4TSFc96Ta3n0HgALWftKQe59rRmUL3zLpQyhgPaRXd7XYEm1p7zPUR7CGcq
	8ocIthyqPgBhfI6jSexW60jou6ES7aP6pE0IdmIDb4uGRa4oBu/N+mx8hj0IVD9F
	p3JD21utyIAWdawFumtEg==
X-ME-Sender: <xms:wX2KaIFiys21bBTJvHEe0lJJ0tt9fEQeFP9s1tOSyr_07FJV4CzsPw>
    <xme:wX2KaBXzjWj6Q7kBRAQFUxeNdeUS6gld__xXWnfTloUHNcpt7N6twLnceYS5NnkTF
    pl2Wzoo0afKbYtJkEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeetgeeivdffhfeihedvkeefueekgeeivd
    ekheekjeeuieejiedtffdtjeetvdffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtph
    htthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushes
    tghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuug
    gvsgihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wX2KaMOiD1kYRT8Yv0quDbTT4OPWmBOWottX9idvqiuGm-FIm_gppg>
    <xmx:wX2KaKX1ryvz9lBl3-n9jtfegXmnOcobdpAQ_Ljk_46N0WIah28Jfg>
    <xmx:wX2KaI3Zhzmtkh4I0xNg8NTydwY6J-w1rHIitkcRPJ44zSWzOcVQEg>
    <xmx:wX2KaAorjEvLvbLSwpbYJRoPkpBo3_DstNQLLy5isfzkzc9CMZZyNQ>
    <xmx:wX2KaDXc2MzUp1JX7HmsmlEiOAy9NlSB9y7Jw18DE7eGggE3DCMcQzEQ>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E97EBB6006B; Wed, 30 Jul 2025 16:17:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tea62be34c8f8a220
Date: Wed, 30 Jul 2025 22:16:13 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux-kernel@vger.kernel.org
Message-Id: <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>
In-Reply-To: <2026737.7mX0AZtNi0@silver>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
 <2026737.7mX0AZtNi0@silver>
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As a middle-ground, would it be acceptable to add a transport capability flag indicating whether the transport requires contiguous memory for DMA?

1. Add a P9_TRANS_REQUIRES_CONTIGUOUS flag to struct p9_trans_module
2. Set this flag for virtio, xen, and rdma transports
3. Modify p9_fcall_init to check the flag:
     if (c->trans_mod->caps & P9_TRANS_REQUIRES_CONTIGUOUS)
        fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
     else
        fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);

I can prepare a patch implementing this approach if you agree.

Best,
Pierre

On Wed, Jul 30, 2025, at 19:28, Christian Schoenebeck wrote:
> On Wednesday, July 30, 2025 6:19:37 PM CEST Pierre Barre wrote:
>> Thank you for your email.
>> 
>> > What was msize?
>> 
>> I was mounting the filesystem using:
>> 
>> trans=tcp,port=5564,version=9p2000.L,msize=1048576,cache=mmap,access=user
>
> Yeah, that explains both why you were triggering this issue, as 1M msize will
> likely cause kmalloc() failures under heavy load, and why your patch was
> working for you due to chosen tcp transport.
>
>> > That would work with certain transports like fd I guess, but not via
>> > virtio-pci transport for instance, since PCI-DMA requires physical pages. Same
>> > applies to Xen transport I guess.
>> 
>> Would it be acceptable to add a mount option (like nocontig or loosealloc?) that enables kvmalloc?
>
> Dominique's call obviously, I'm just giving my few cents here. To me it would
> make sense to fix the root cause instead of shorting a symptom:
>
> Right now 9p filesystem code (under fs/9p) requires a linear buffer, whereas
> some 9p transports (under net/9p) require physical pages, and the latter is
> not going to change.
>
> One solution therefore might be changing fs/9p code to work on a scatter/
> gather list instead of a simple linear buffer. But I guess that would be too
> much work.
>
> So a more reasonable solution instead might be using kvmalloc(), as suggested
> by you, and adjusting the individual transports such that they translate a
> virtual memory address to a list of physical addresses via e.g.
> vmalloc_to_page() if needed.
>
> /Christian
