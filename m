Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609252F692D
	for <v9fs@lists.linux.dev>; Mon,  3 Nov 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165029; cv=none; b=qhyI0bzePqmxnsIvgoTEnqXrI4SV+2gqHfXk8I+wDV2Kawafbf9HsLQ7AGCkYQ/7IaQDlkV42+vgdcE69colLDh3VFYmh9nPSKxkRF3xKdNBzdFIYqdEmWwwy0wduM5/sLrivQUF1vtg4rBt53hxbcBOhWXWJZpnar1vccY7W2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165029; c=relaxed/simple;
	bh=jreKh7UoXms/zPvts4j5vSExLuNfxgKkq7HIyMMt1fI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=al9gTbDEAhPiC1MQzBg+nO9Bu2ECuT7xShJRqED6IiAhrWNlxJKLQqn9cBdmxBY1w228suEgEq2csDhSrnSydeSgwLy3Ey2l4CePFGac/V4JwVlLusMhoh7/YbrRKeeCjiquRU/byGVb25ivPVvNEJvMP8cBMYmnEA9CRy2KOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=JzXT9LVr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvlCS3qH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="JzXT9LVr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvlCS3qH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 67D101400100;
	Mon,  3 Nov 2025 05:17:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 03 Nov 2025 05:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762165025;
	 x=1762251425; bh=8I8MpOPXB7ZcC9lpAikBwCbV7Q54AcJYFLWaDJzNxFU=; b=
	JzXT9LVrpaasboYIyHoeBInG0Y1m1DTbVNj0OgpOlsoQtMW8fl3EXavj6x3s9F1p
	gbqfZuEU3hJTkp8uBhLcAVE4rDUxVKlOSzSQHSNtAejeasAFM+J5JpuM6LcfI6xZ
	x92UAlkRpdG0wWcf0N97ygN1JcZAiLPTNevPjC0su+hybfD48RR1qAy485gsgqSr
	VKwkyHGmTcwcmVVJ7NS6yAZnTmcslx1/nqQagImgXPjvGZjlXtwNf7Hv9i2rQ3J8
	ZgKxH0c2m9AsT3KnJ0RioIqFeCRElSetJ7VGfVMoZQhCj9dba0j+45MK4eJpFh5Z
	gPUxFKv4o6QDojVFX820lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762165025; x=
	1762251425; bh=8I8MpOPXB7ZcC9lpAikBwCbV7Q54AcJYFLWaDJzNxFU=; b=b
	vlCS3qHuss8Tnk2IRihXwx8P0rzzuySNtK/JOV03kRbQACeAfc8q30+ElgK0uXuj
	wKBb7ZoRTeBrL5ue+XSjUAbpSTeBenxFMCzrIjOnGycZ8K62TB7sYhAB1U+VLXhi
	+UyttRGL62r93Y2mf9pw9C4B7kDC/Eynsk9m3+9+EDX19/kdUpvibG07Qd+l0W5f
	33Olf+r2qqKIXBfgNLpasQ4oX0GbGRGiH3mB3OHjMtSjFYAwPxPeYANrn7k4dhSw
	dRHr5BnNB5um3L2yJRyIgwc4OjDNFyE1H+6b77wnYkMXN1r556zTiBW/PDxPHfXG
	45GukHbNzNOHoHFrUSFVw==
X-ME-Sender: <xms:IIEIaalGrS96Pih8mg678jxD1RmJqEzg1W28Zli8JWzce37V8mhVLA>
    <xme:IIEIaShavjrd7uZbH4XX4CXnF34HH3yvv9g8KA_rY-A0WZ-J7Nwb-r5t6M4ZCojtf
    U1448AGCba9hQy9mMPpMXFOPiQuj-4LceuUDASIcdxYZ8Nu5nI_KPs>
X-ME-Received: <xmr:IIEIaW0noRwE8rVozzo53q6WgUFcFmYChR7kJb51rv02f73EiNKw_bEGF0oTpUkcmOqKS69r8xhFkgJSywbyzi1jam7306-7_iPr3BVZAqVJuyovew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesthejmh
    dthhdtvdenucfhrhhomheprfhivghrrhgvuceurghrrhgvuceophhivghrrhgvsegsrghr
    rhgvrdhshheqnecuggftrfgrthhtvghrnhepkefgleegkeduffekheeigfelfeeffffgud
    dtgfevjefhtdduieevuedtgfejgeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpihgvrh
    hrvgessggrrhhrvgdrshhhpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtph
    htthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohep
    fihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvlehfsheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IIEIaTIX0yrE9Gx-PdY2Ran_BXcFenwz5NUM69TlmrYbWIdxDXviBA>
    <xmx:IIEIaewnqhTFCMhfmjMI7WXKcXna4GO7Bnp4tYNx1KdeOcTvet73Ig>
    <xmx:IIEIaZUCSrApZAJX3_3EvJTConRJwp4C8eOoQSSuSMwMEHKLoc90Jw>
    <xmx:IIEIaWi1vbjTztGU43h3Yf5v_rZTsOh418bZWb-pBN4hEwQVip51DQ>
    <xmx:IYEIadKz9Rb-WX9av3LmYDEyFH-v7xQEt02kKzkSsLSpuXNff7Wo3XZ5>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 05:17:03 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v3] 9p: Use kvmalloc for message buffers on supported
 transports
From: Pierre Barre <pierre@barre.sh>
In-Reply-To: <aQhfVa_jdI_1kQwB@codewreck.org>
Date: Mon, 3 Nov 2025 11:16:51 +0100
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 v9fs@lists.linux.dev,
 ericvh@kernel.org,
 lucho@ionkov.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <42356AE9-D6F7-425C-BCAE-8DB19A7E0629@barre.sh>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
 <5019358.GXAFRqVoOG@silver>
 <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>
 <aQhfVa_jdI_1kQwB@codewreck.org>
To: asmadeus <asmadeus@codewreck.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On 3 Nov 2025, at 08:52, asmadeus <asmadeus@codewreck.org> wrote:
> 
> Pierre Barre wrote on Thu, Oct 16, 2025 at 03:58:36PM +0200:
>> While developing a 9P server (https://github.com/Barre/ZeroFS) and
>> testing it under high-load, I was running into allocation failures.
>> The failures occur even with plenty of free memory available because
>> kmalloc requires contiguous physical memory.
>> 
>> This results in errors like:
>> ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)
>> 
>> This patch introduces a transport capability flag (supports_vmalloc)
>> that indicates whether a transport can work with vmalloc'd buffers
>> (non-physically contiguous memory). Transports requiring DMA should
>> leave this flag as false.
>> 
>> The fd-based transports (tcp, unix, fd) set this flag to true, and
>> p9_fcall_init will use kvmalloc instead of kmalloc for these
>> transports. This allows the allocator to fall back to vmalloc when
>> contiguous physical memory is not available.
>> 
>> Additionally, if kmem_cache_alloc fails, the code falls back to
>> kvmalloc for transports that support it.
>> 
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
> 
> Thanks, it's now picked up and queued in -next -- will send to Linus in
> a couple of months.
> 
> FWIW, I prefer (and I think it's the norm in the linux world) if patches
> new versions aren't sent as a reply to previous version, it confuses
> tools like b4 that fetch the patch thread for version operations.
> If you send patches again please just send later versions without
> using --in-reply-to :)

Got it, thank you!

Best,
Pierre
> 
> Cheers,
> -- 
> Dominique Martinet | Asmadeus

