Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1210295DBC
	for <v9fs@lists.linux.dev>; Wed,  6 Aug 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495471; cv=none; b=fwJgJcRqTf+829Gdb5KXHQIvowoRUrsJbvkv55p+LsUNzgM2coKB9mTFAUUxDOCHaN9khYl7CWAe/swjZ/mqwIrdGAi+UkxY/Z+SIWYB+q9zHh4bu26lR9MGH68uGlT774Yk6mHEP+LfX073gtB7rbVOc0JT5TNgurASbk1Bo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495471; c=relaxed/simple;
	bh=IDSlojlj/P5UhxYr7GGWRqRIZthRZrEWCqxkGAawL8E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PfZfvYAzgAQhhfUU6OLE/WD3jO7BgCHqG8qjhd1jgd6Q5uvz2wCS1EbOEPvQXOH2LVtOMRyNcW6OxGBaPFUl47vA77KgMD3CCp4OTgAjKAM5mUnye7ozKMXseg66elkCdwYI8t6ObISPc/+W/MvIC2u3ste6zZWX4FssKkxwV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=feGCiIK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NG3Ziujv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="feGCiIK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NG3Ziujv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BF3CC1D001A1;
	Wed,  6 Aug 2025 11:51:04 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 11:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754495464;
	 x=1754581864; bh=IaqvCFRZQRnYawxKT71RrgJ5OBa2wbh5jJ2w0t8ChIo=; b=
	feGCiIK360Zpqd0eAJf8NX2qNY0v5AL76y2uCyunAuCuTPUZXdOcRrAf/ROsf8EK
	yK7mNIlEY6sTMUR98GpFFSSxB9pHM+yDTFGaJl7XW+Po+tGvvFJljQTunbXjR3Lq
	e9nO41lM9mOdgw6tG78seyuEsQeHwbf19TUqkO0BAmD1SsoT7cx+eHggqaWutUee
	IQoBkySp3hZcrJbOeXQuVWWVWw6c0PRqWKZZwVg/Ij69vj6NGGOr+72OEwIJYAtz
	DDnl5PFhhXxiMSBLVIPCFbj9AqXKqV4rB+4KfvS1mMhBFfL2yWgcCraYjBMzAS+U
	+uXI6Qx184DfnLoVpkHs/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754495464; x=
	1754581864; bh=IaqvCFRZQRnYawxKT71RrgJ5OBa2wbh5jJ2w0t8ChIo=; b=N
	G3Ziujv+5eD/Ra3kFjb5cBm7sTSXWfVQgstU4kgqL8HLjsazeL+btasDUU0/gLZG
	gPI54QNlLzTUchl5SZXARu/cS0eQWR6q7pyljy5Ej30B5CpQFwz7dcPCBm031AQa
	5F/Bq3KSPom6conr+uAOKSG7XSg2jhbLOLVX/jzAvK7qttbFWcpYmqsCGw5FmQ9c
	7hS60J6UtlXn/RPTM+VpILqVKhfv9apEid5mQNzEdnMaob+tIRQ1oC/nXiaZ0X5x
	y/NlWms7sO92Q7E+lCMKBZ/9ADC3KF/k5opxpR8v50yWv0/lbbh1XWWV4BgQVK2d
	Nuz0B/czSBnbeFUU4nOdA==
X-ME-Sender: <xms:53mTaLhZSP8p0w6qPLzTZXzoAM9UAembYJu7A3HxOoIzhIym7XqfUQ>
    <xme:53mTaICf_z9OqFAfYlE_uay_zGqMWJ8sw0nrQruN1Y6lUUQixK6H3ucJz-hMIMWTT
    ipXgGK6l1I_po-vhUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegs
    rghrrhgvrdhshheqnecuggftrfgrthhtvghrnhepteegiedvfffhieehvdekfeeukeegie
    dvkeehkeejueeijeeitdfftdejtedvffejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtg
    hpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhs
    segtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruh
    guvggshihtvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvg
    hrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:53mTaD7OpPyOSxepSYcUwIt4n-qBw4jkRNd3XX9aIvEX6xRacSDaNA>
    <xmx:53mTaAjgefxWSKGEO6ds2HnYeZL2rTn3eHu7Q8f_O5y_uPgkkblOiw>
    <xmx:53mTaIGO9ATzSiTgcfWzf2BFGOEpprRHrmCdlq66Z5iBN5QuaebKKA>
    <xmx:53mTaORQoaRPUZ4e4fuWiWo-q1uPKbncOK9QnP4RnNXrG9DDT1l5xQ>
    <xmx:6HmTaL7eYZ4NkdtfqX1n5Nj3_pnkXwMsAQEFZR0b1-nSm1qFpcvD9brm>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0B2EB6006B; Wed,  6 Aug 2025 11:51:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tea62be34c8f8a220
Date: Wed, 06 Aug 2025 17:50:42 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: asmadeus <asmadeus@codewreck.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Message-Id: <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>
In-Reply-To: <e42edd55-2559-437b-a2e3-2773b18d0cc5@app.fastmail.com>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
 <2026737.7mX0AZtNi0@silver>
 <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>
 <aIqXi6uBaWXtvgm3@codewreck.org>
 <e42edd55-2559-437b-a2e3-2773b18d0cc5@app.fastmail.com>
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Everyone,

If I submit a patch based on what has been discussed above, is it likely to be accepted? Unfortunately, in my current setup, I am encountering this issue quite frequently, and users of my servers are having a hard time making sense of the error.

Thank you.

Best,
Pierre

On Thu, Jul 31, 2025, at 02:36, Pierre Barre wrote:
>> First - thanks for starting this thread, large contiguous allocations
>> has been a problem reported regularly in the past, and no-one has had
>> the energy to address it yet, but it's definitely something worth
>> tackling.
>
> Glad that I didn't just create noise. I implemented 9P in addition to 
> NFS in my server because fsyncing on NFS didn't give me what I wanted 
> (fsync doesn't call commit when write is communicated to be "durable" 
> by the server, but that's a story for an other day...). 
>
> I am very grateful that this client implementation exists.
>
> On Thu, Jul 31, 2025, at 00:07, asmadeus@codewreck.org wrote:
>> (Added Willy in To, if you have time to advise on what's appropriate
>> wrt. memory allocation here to use either as a contiguous virtual memory
>> buffer or a scatterlist for various kind of dma used by transports
>> that'd be appreciated)
>>
>>
>> First - thanks for starting this thread, large contiguous allocations
>> has been a problem reported regularly in the past, and no-one has had
>> the energy to address it yet, but it's definitely something worth
>> tackling.
>>
>>
>> Pierre Barre wrote on Wed, Jul 30, 2025 at 10:16:13PM +0200:
>>> As a middle-ground, would it be acceptable to add a transport
>>> capability flag indicating whether the transport requires contiguous
>>> memory for DMA?
>>
>> I think such a flag will be needed even if we do what Christian suggested:
>>>> So a more reasonable solution instead might be using kvmalloc(), as suggested
>>>> by you, and adjusting the individual transports such that they translate a
>>>> virtual memory address to a list of physical addresses via e.g.
>>>> vmalloc_to_page() if needed.
>>
>> Start with a requires contiguous flag set for all transports except
>> trans_fd (I'm not sure about usb, but I'm pretty sure all the rest need
>> it); then each transport can figure out how to get a scatterlist or
>> something they need from the allocation, so we don't need to have a big
>> bang that breaks everything at the same time.
>>
>> I'm sure virtio's implem will come soon enough, but I don't see anyone
>> working on RDMA or xen so fast.
>>
>>> 1. Add a P9_TRANS_REQUIRES_CONTIGUOUS flag to struct p9_trans_module
>>> 2. Set this flag for virtio, xen, and rdma transports
>>
>> This is a nit but I'd rather the flag go the other way around, e.g. no
>> flag means requires contiguous and it's only set after confirming the
>> transport works
>> (I just looked at usb and struct usb_request makes me think some drivers
>> use dma, so, yeah..)
>>
>> We can always turn it around later if the majority of transports handle
>> it.
>>
>>
>>> 3. Modify p9_fcall_init to check the flag:
>>>      if (c->trans_mod->caps & P9_TRANS_REQUIRES_CONTIGUOUS)
>>>         fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>>>      else
>>>         fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
>>
>> I'm also curious if there's something more appropriate than kvmalloc wrt
>> using either as a contiguous virtual memory buffer or a scatterlist, but
>> I think this is fine for now unless someone knows of something more
>> appropriate.
>>
>>
>> Thanks,
>> -- 
>> Dominique Martinet | Asmadeus
