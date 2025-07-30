Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB37E107
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892404; cv=none; b=ZwAdDn3AZghSPSaNMyCiNAp5IYtPkRZgrV4grQy0/j/+itIsrsNn/sDiuWk8j9OdGCwCbUM1ddmxHQDsKAcHsjh9tda78rOrn8uCTo71Hv0Mh4K+44sUY8YT0DQCro7h5VOdVqvhLsTrWCkc/2Ned0c3hdsv0fJ1WMDXCQzA86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892404; c=relaxed/simple;
	bh=qxsFtVaQ+8GvwmWj3mTG3NeZ4EFj6Ypnl/PYcQGnsEI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DQM2h6juzDnj3cmv3vX7/rQSfuAI7AO309mWBFiMLz1WGBLzZSyPNjFFeJKXvCZ+E+iOs1DEog9lsWGIQ/tc2GyhgO5jv8nzzuAC4eXh+YxLbeKTM913sI9JBPB5YsTmfSG0uYvU9nUOnjZACpBicOqgZ+caRx0/JZCUDMTk4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=jRssZYRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2T2jsi6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="jRssZYRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2T2jsi6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 573727A0061;
	Wed, 30 Jul 2025 12:20:00 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 12:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753892400;
	 x=1753978800; bh=JDMyoYUR9BxhyTbON9A5YBTPY9ObxpkF11IXTvWyR/0=; b=
	jRssZYRBzwa+8lh69t2QG3LG3tSnUrZj/Qb+t5WseyJZj3UMYNLhLjdrUKxe/g/X
	nN2m4EXgvLgvHqkArLxl2ElOScwFTpn0nhOzaC2b28CZu7U62WLoZ9VIyVn8TfaG
	mh0apMFw6hABUhEtXZFOyAa1ax4odweP4QupPYsoaX1//vHUPDfJiobQ+Nuxgu1g
	C9sVZ5kPm6f8Snj9SdiNTE31qG+orHmtvvYvFYK5JIa6X1j5mHIMELYqUcag57bH
	adjmy1tWv7VXpanwDC8s0VeU8u7Vh7KCswf57/v+HZfaxGqW2Tfk34zUkV0NdIZS
	10B2LQmONZq4lSTYGUDsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753892400; x=
	1753978800; bh=JDMyoYUR9BxhyTbON9A5YBTPY9ObxpkF11IXTvWyR/0=; b=M
	2T2jsi6Xhd0vQWue0ClbcrN2YFokPuBAL1Zl6ZrGdmU+4sJrJLEPc7qQL3gypNrF
	akyFRmZyO/6y6jX2OnjUZosi4J2YhaKANAn7/3q7TWxYHbBKbu4EA2WGqVWfvOxF
	dNVKYNq+fGoXWhI+RdrJu1aMZ6r/0cphPB1V0eRYU005CR8VBrBcvt5nNrL9uA6R
	kBwF72BP7HlEkb8ov5zAtR5BGuFt6aAza05e4C5FMOgexhXvFVRraPgRRG57VSYU
	LErlQd8kH9VweXLAtBy4KpQjyqd1t3FCnZDZRxPD7uKbjYNrQcu/E5wc39MdOuZA
	TXoPhB6IEEhQ/pcRK1OiQ==
X-ME-Sender: <xms:L0aKaDgfZXyMw2EdeoWa2Cr_yNByI5vLaO8M52j6gB15aMWQKscKsg>
    <xme:L0aKaAC3sHBrxAWDW-3R5VDZeO9ZDrGVOIk7I1x22m3XGQz_4cLY_xUke5BV-bdBf
    aK8V0KmRSBZT6V9QzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeelieffteelkedtvdffjeevfeelgfehhe
    ffhfeivdelfeetkedvgfffffeutdfhvdenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhivg
    hrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtg
    hpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthho
    pehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:L0aKaDLGIDsWYIBTcvTqtT2lXDhPvY6NZVwHIUqDEts4SZ6zmpc_8Q>
    <xmx:L0aKaOjFJb_TDtW69cwb426Wkqfp1Rg9St87bAqKJPn9K8MFE_T_BQ>
    <xmx:L0aKaBS4kfMJw-zMKvEDPA8s-HRWqKV6GUn-WztKVf7wS8jyqp1dIQ>
    <xmx:L0aKaIU0IZZx1wU2DuL3PhYJ940MOobxcNGar-We7EV7FC02G62wmg>
    <xmx:MEaKaABXDnNx8b7othGwyBYzrfun6IdobwnoyVar7ngcAHBWeZYJOMlv>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66519B6006B; Wed, 30 Jul 2025 12:19:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tea62be34c8f8a220
Date: Wed, 30 Jul 2025 18:19:37 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux-kernel@vger.kernel.org
Message-Id: <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
In-Reply-To: <2989343.ydHz1Oe0dO@silver>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thank you for your email.

> What was msize?

I was mounting the filesystem using:

trans=tcp,port=5564,version=9p2000.L,msize=1048576,cache=mmap,access=user


> That would work with certain transports like fd I guess, but not via
> virtio-pci transport for instance, since PCI-DMA requires physical pages. Same
> applies to Xen transport I guess.

Would it be acceptable to add a mount option (like nocontig or loosealloc?) that enables kvmalloc?

Best,
Pierre

On Wed, Jul 30, 2025, at 18:08, Christian Schoenebeck wrote:
> On Wednesday, July 30, 2025 5:08:05 PM CEST Pierre Barre wrote:
>> While developing a 9P server (https://github.com/Barre/ZeroFS) and testing it under high-load, I was running into allocation failures. The failures occur even with plenty of free memory available because kmalloc requires contiguous physical memory.
>> 
>> This results in errors like:
>> ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)
>
> What was msize?
>
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
>> ---
>>  net/9p/client.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 5c1ca57ccd28..f82b5674057c 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -230,7 +230,7 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
>>  		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
>>  		fc->cache = c->fcall_cache;
>>  	} else {
>> -		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>> +		fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
>
> That would work with certain transports like fd I guess, but not via
> virtio-pci transport for instance, since PCI-DMA requires physical pages. Same
> applies to Xen transport I guess.
>
>>  		fc->cache = NULL;
>>  	}
>>  	if (!fc->sdata)
>> @@ -252,7 +252,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
>>  	if (fc->cache)
>>  		kmem_cache_free(fc->cache, fc->sdata);
>>  	else
>> -		kfree(fc->sdata);
>> +		kvfree(fc->sdata);
>>  }
>>  EXPORT_SYMBOL(p9_fcall_fini);
>>  
>>
