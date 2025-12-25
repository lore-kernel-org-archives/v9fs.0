Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFB188713
	for <v9fs@lists.linux.dev>; Thu, 25 Dec 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766674399; cv=none; b=HH3jwNxhp9UlhGBA2jBYLrzNXITho3dFBsajSnSoI6vgHD46bioFGSQg+sL/PO6OIuS2yAHx7iUnMsxVfvvuJjE0jZsypuVvAH9te2EinItC7vzmXZ7JT72cXhEixnmn8pBtbVsR+plJ6Ka5lakXac5zFteDJzabPrrAqwRBHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766674399; c=relaxed/simple;
	bh=fQX8z03e+dyJ42CkvFuZte1VAqgKKNNjVUKq+HTwlIg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UAgogFEwrDfnUoGlFs7jqRuxe2kPHPQNHrGd6S/WrIAgSmEatQ6OtOfnYWKetsxSgzZymBegLWyDf7ALKxd+QSup0VcbR80GaVuBRZ+wP+1bbuoEvdChyCGlpE9pWHW+Wc5693/HFNXt8C7Re96GHzZIADc+z8Yg/k85rQt0ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=T6tnu2oq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/xVzOzK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="T6tnu2oq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/xVzOzK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BED6EC006E;
	Thu, 25 Dec 2025 09:53:16 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 25 Dec 2025 09:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766674396;
	 x=1766760796; bh=qeW7miAmAxU7XN0cDLzpnUTVrsvEnnPhCeOo/Ylhctg=; b=
	T6tnu2oqMm2wuAfAlJCVkjVneFtrkzS628Y/KDVwfTfsWqi9yKDwrnoOdfIS72lZ
	zyFnQfWyCiEPYAvBLwFYd6bm3EYd40ZeZSzvtiAPiPH5GNPHZ6XHO8cecqAg1YCj
	Ja4Jiof2Y8Ign5tFLaAdSGEde9v2JyydE1nlJ2kedrQ9kGCKOPoNO18I5IEPpJrG
	eAO0qvOWExf46F4Ntl04RzgTlFyD/PCzqFoXMIvp0RK4ocbLiYgBmT62O2xzvuRY
	bH8zdsvdZUlYMw5G9soo8fR5fjSFHUfGjgt9V+RaXA9mG989d7Das5FssoEqZWPF
	Dd5hI5DlklTS6i/2rbBv2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766674396; x=
	1766760796; bh=qeW7miAmAxU7XN0cDLzpnUTVrsvEnnPhCeOo/Ylhctg=; b=b
	/xVzOzKL+NTjyuBJTAcj3BPIwHQLKc/Z+0HydZbTkery3a0QOkdt4YVec87kNVRx
	8k4oZqznzDO8LZzAVj140zv5FKySnGof1uPmHuGwlBV6EEUMnTg3P5H47U+YdMoF
	zz/s6HcImORu5M9gwIoK8UJ/U9kpY3nj4VAYK/xrzhwCSJ0BZsXTlU9NX17FjT/x
	1DuSPTEeVm5Mt2YCyWgOk10X5QhOrr1v0VUUuKfTOw1pGRCrGjx5w21mJdc9xDMp
	wacDU/aCU+a2CTi7iaVvOiFsAxaLoGSKCN/64/Gb7MN0Kdu4Br5N6xEl1Boys3Vt
	qA9YpK7FLENHDtB3UD3cA==
X-ME-Sender: <xms:209NaX5XXivp9_HFsB0-77l687pYOjUbFWETmzoAgkgRG6UdgDanoQ>
    <xme:209NaXtIfQE8gJYqZatIQRZBxJzKdYD-fTW4CERNPS82YVlmOKcaUuhcOYGBDLlsz
    5-xXyHL1vMFBWBe9irzsR-fEH7f4m0Jh6znRNYCLz1duDNoelG4Z0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiheekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfrihgvrhhr
    vgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvg
    hrnhepleeuhfejjeefiefguefggfekveeffedvveefhfeggeekjeelkeffheelgfegheev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvg
    hushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegt
    rhhuuggvsgihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvg
    htpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehv
    lehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeguhhhofigvlhhlsh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:209NaVhM-vCOP5aRVZPDoPP-wR87J1BsYUFZ4hqfswmtqp6taxg4BQ>
    <xmx:209NaUHxln6jHXaVjQNdc5E9pfDEnQBjxc9Bi2TtFbrdkFcX6gp9hg>
    <xmx:209NaU96y7yPau2eRvHYqehry8wO3jk5tr9XJCbP4YFPFbk5DPe7LQ>
    <xmx:209NabwIwwM4Np91y47dvMHIro4CIdLmmZwlIcCp9n9wr1dRCt3HDg>
    <xmx:3E9NaR4D7A5YXG44pZDW9_vR4sC-DoRfzTUUhHoa92WI5ucUde70vsCs>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 13712B6006E; Thu, 25 Dec 2025 09:53:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A_8kOvWl7YLF
Date: Thu, 25 Dec 2025 15:52:54 +0100
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 asmadeus <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, "David Howells" <dhowells@redhat.com>
Message-Id: <81e47329-a3e9-411f-aec3-2a1477624043@app.fastmail.com>
In-Reply-To: <5951517.DvuYhMxLoT@weasel>
References: <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>
 <aUxqVn0DO7ee9K2_@codewreck.org> <5951517.DvuYhMxLoT@weasel>
Subject: Re: [BUG] 9p: data corruption with cache=mmap under concurrent stat/write
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Christian, Dominique,

Thank you for your reply and merry christmas.

>> unexpected data beyond EOF looks a lot like
>> https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk
>> 
>> could you try with this patch?

I will try this patch and report back.

> ... you are seeing a 2nd issue? getattr() output should not be related to 
> mmap() access.

What's strange is that this issue doesn't occur during normal Postgres operation or while just running benchmarks. I initially encountered it while running du -hs during a pgbench benchmark, and I've since been able to reproduce it consistently with watch -n 0.1 tree -ah. Running the benchmarks for hours never trigger this bug, but it (almost) immediately occurs during du -hs / tree -ah.

Best,
Pierre.

On Thu, Dec 25, 2025, at 11:23, Christian Schoenebeck wrote:
> On Wednesday, 24 December 2025 23:33:58 CET Dominique Martinet wrote:
>> Hi Pierre,
>> 
>> Pierre Barre wrote on Wed, Dec 24, 2025 at 03:29:01PM +0100:
>> > I'm hitting data corruption using 9p with cache=mmap when stat() is called
>> > concurrently with writes.
>> Thanks for the report
>> 
>> > Environment:
>> > - Kernel: v6.18.1-061801
>> > - Mount options: cache=mmap
>> > - Transport: unix
>> > 
>> > Reproducer:
>> > 1. Mount 9p filesystem with cache=mmap
>> > 2. Run PostgreSQL with data directory on 9p mount
>> > 3. Run pgbench workload
>> > 4. Simultaneously run `watch -n 0.1 tree -ah` on the data directory
>> > 
>> > PostgreSQL reports:
>> >   ERROR: unexpected data beyond EOF in block N of relation "..."
>> 
>> unexpected data beyond EOF looks a lot like
>> https://lkml.kernel.org/r/938162.1766233900@warthog.procyon.org.uk
>> 
>> could you try with this patch?
>
> Pierre, I am also confident that this patch will fix the EOF data issue you 
> encountered with PostgreSQL. However ...
>
>> >   HINT: This has been seen to occur with buggy kernels
>> > 
>> > Analysis:
>> > 
>> > The issue appears to be race conditions in getattr/setattr when using
>> > writeback caching:
>> > 
>> > 1. v9fs_vfs_getattr_dotl() condition checks `v9ses->cache` instead of
>> > 
>> >    `v9ses->cache & CACHE_WRITEBACK`, triggering writeback flush for
>> >    any cache mode
>> > 
>> > 2. Both getattr and setattr call filemap_fdatawrite() which initiates
>> > 
>> >    writeback but doesn't wait for completion. The subsequent server
>> >    stat/wstat sees stale file size.
>> > 
>> > Would using filemap_write_and_wait() instead be the correct fix?
>
> ... you are seeing a 2nd issue? getattr() output should not be related to 
> mmap() access.
>
> /Christian
