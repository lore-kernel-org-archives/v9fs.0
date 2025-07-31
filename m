Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4E27454
	for <v9fs@lists.linux.dev>; Thu, 31 Jul 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922231; cv=none; b=tXiQcRHt+0y4/2X9PxaUS82yqJS+z5FRfA0qOj8BX6CIL1vUGTa05LTjhoqykh6/9nkkRkELKf8fjO2ulx2uNIYHVYPo8YlY5Xxx9VTQaotdXyk3MlnmklX9gVPA1ekrJiUpax1jfLnLCE7sHmeFT5IUrBoyjjVQCgLdzfuLFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922231; c=relaxed/simple;
	bh=RzDD8ToDp7xXYPGQS0zB5SbXNYFXgpiw9LuDmN+k7dY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Agucu8H/dDrzibv3I71ncpqUdkd4m581dzt9LBI4MXJsNc+Q2XLJA+9C+L8JRgAxpNWaUE3AdFy577oeTKa4caVuLbNJxd4jwmNFTDPDGXIgP381TSdjMr3wfAcZgJGSMBc/retAffoQL/jeacZKQGfHtwNUobGIBfjAMWwVpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=HO0jQh7f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQINKw/L; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="HO0jQh7f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQINKw/L"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 150791400083;
	Wed, 30 Jul 2025 20:37:09 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 20:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753922229;
	 x=1754008629; bh=Jr1/yeTTFM1cng/NygQCTPklievovyhPIMSJcmVhPVc=; b=
	HO0jQh7foKrZQWTgC7Ej9N7BkIMmaYCNdtFtu/I0lpq97/KwfukPPewFD975XeNb
	EZiKiFNaCLwd6GHbmRiHBbtZk72/T90BNlmXMdxcmAaDRhD8qUyDQl6ZvxYDonl7
	R7p9lyGPAX01FkZn4/rz8W/iTT/YICUACw3OL1y2aO8mMhEbJf3AT/hxOuEeuLzB
	SMhbSxSQsOtpuU63Klcyh7Qt4ACKxg1ri8cSh9p0rEjoUvz8qaaKwOz0E03S+/Eo
	z7l2J3NtFqduZ57i6iw2f7KC1HEUrh9Wis1n+RCjSbYDS287CuRpBfulceDkudg5
	n03HLsEHMBLjkK3bFBczYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753922229; x=
	1754008629; bh=Jr1/yeTTFM1cng/NygQCTPklievovyhPIMSJcmVhPVc=; b=f
	QINKw/LDNPtxwkwsCxSP9e3VUdTSUT/vbJSrCHaW4z/X7kFx3SJMnZ5ktpbKzAMY
	Vpash00iwplb+4GEUm9vnDOl8+zAsepsXmfo5BTYVgJKmBy3i14qg0UwA9QhOGxc
	V6esRbce9uknfx/zGKjMWSRaZ760Rr0s+50/PNnuNeh2xwZ6SiJh83m8zNXHpXZ8
	pUY0V79xEyBeqT27TrVMG3EbNq8NN24sug8lDrhxQlmcbCKYi5/X3Tcwj8Bhgpbs
	VO7MzTt1ZLkL+sw3J0bSmqZCY443IP9WNYD4Cv+tRaYHgcCgcSx5AfoUjgSMx1to
	KfWAhUgL+MW7oH2xrxaag==
X-ME-Sender: <xms:tLqKaPkqmJS20Vtr3HKky34HBJtKEoDtDQ0D9VGWSrLWTTmpqV6vUA>
    <xme:tLqKaC0e6M5HyC4bTt76tHOjt1xujg_3DsdfBuFLMkpvf0WCwZpkK5x4Odb3e0zYV
    C6LCh_yHCQdz9uYxd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelleeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeetgeeivdffhfeihedvkeefueekgeeivd
    ekheekjeeuieejiedtffdtjeetvdffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtph
    htthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushes
    tghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuug
    gvsgihthgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegvrh
    hitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tLqKaD9GhCHMys031UlbL-qqC26v1UlJLBRITnN-XTSHjWjiALOAkA>
    <xmx:tLqKaHXeXPTJrHsPaEnKhPX3iV4YNpiPYiTZWpxxyvBTa4Gt-_fu0Q>
    <xmx:tLqKaOrQrJP0qv-e0b_MI60lTni6moggU05sKLa2StZWiW-WTkrLBw>
    <xmx:tLqKaJntizu6QZTjxo_5TtW0iwpWkrCvCwsbDgGeVNGngbPEvUyKCg>
    <xmx:tbqKaGfeFLf27Q3WFGuGeVIZfpSayIbrzEYp859vECCuJSi1fXo5Wg3_>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49152B6006B; Wed, 30 Jul 2025 20:37:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tea62be34c8f8a220
Date: Thu, 31 Jul 2025 02:36:41 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: asmadeus <asmadeus@codewreck.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Message-Id: <e42edd55-2559-437b-a2e3-2773b18d0cc5@app.fastmail.com>
In-Reply-To: <aIqXi6uBaWXtvgm3@codewreck.org>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
 <2026737.7mX0AZtNi0@silver>
 <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>
 <aIqXi6uBaWXtvgm3@codewreck.org>
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> First - thanks for starting this thread, large contiguous allocations
> has been a problem reported regularly in the past, and no-one has had
> the energy to address it yet, but it's definitely something worth
> tackling.

Glad that I didn't just create noise. I implemented 9P in addition to NFS in my server because fsyncing on NFS didn't give me what I wanted (fsync doesn't call commit when write is communicated to be "durable" by the server, but that's a story for an other day...). 

I am very grateful that this client implementation exists.

On Thu, Jul 31, 2025, at 00:07, asmadeus@codewreck.org wrote:
> (Added Willy in To, if you have time to advise on what's appropriate
> wrt. memory allocation here to use either as a contiguous virtual memory
> buffer or a scatterlist for various kind of dma used by transports
> that'd be appreciated)
>
>
> First - thanks for starting this thread, large contiguous allocations
> has been a problem reported regularly in the past, and no-one has had
> the energy to address it yet, but it's definitely something worth
> tackling.
>
>
> Pierre Barre wrote on Wed, Jul 30, 2025 at 10:16:13PM +0200:
>> As a middle-ground, would it be acceptable to add a transport
>> capability flag indicating whether the transport requires contiguous
>> memory for DMA?
>
> I think such a flag will be needed even if we do what Christian suggested:
>>> So a more reasonable solution instead might be using kvmalloc(), as suggested
>>> by you, and adjusting the individual transports such that they translate a
>>> virtual memory address to a list of physical addresses via e.g.
>>> vmalloc_to_page() if needed.
>
> Start with a requires contiguous flag set for all transports except
> trans_fd (I'm not sure about usb, but I'm pretty sure all the rest need
> it); then each transport can figure out how to get a scatterlist or
> something they need from the allocation, so we don't need to have a big
> bang that breaks everything at the same time.
>
> I'm sure virtio's implem will come soon enough, but I don't see anyone
> working on RDMA or xen so fast.
>
>> 1. Add a P9_TRANS_REQUIRES_CONTIGUOUS flag to struct p9_trans_module
>> 2. Set this flag for virtio, xen, and rdma transports
>
> This is a nit but I'd rather the flag go the other way around, e.g. no
> flag means requires contiguous and it's only set after confirming the
> transport works
> (I just looked at usb and struct usb_request makes me think some drivers
> use dma, so, yeah..)
>
> We can always turn it around later if the majority of transports handle
> it.
>
>
>> 3. Modify p9_fcall_init to check the flag:
>>      if (c->trans_mod->caps & P9_TRANS_REQUIRES_CONTIGUOUS)
>>         fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>>      else
>>         fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
>
> I'm also curious if there's something more appropriate than kvmalloc wrt
> using either as a contiguous virtual memory buffer or a scatterlist, but
> I think this is fine for now unless someone knows of something more
> appropriate.
>
>
> Thanks,
> -- 
> Dominique Martinet | Asmadeus
