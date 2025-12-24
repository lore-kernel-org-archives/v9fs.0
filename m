Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43C27467F
	for <v9fs@lists.linux.dev>; Wed, 24 Dec 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766586564; cv=none; b=d9EGz7ZE+GnbPEX9Wi7Yo+/Cabvdn9Tydvxy/dpV5Qcu3rKteZK3uCxqPjoT6vfGvkdTVrDtkhIpZImLQm5SF6xanDNw9qXoeIr8NPmQt8F9CrBijw5PTuRKXCGU78VqT0neBXe2wc6hcQq6XtFAusCEjrFUGd8TZUEfopW0HGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766586564; c=relaxed/simple;
	bh=UY7r9ZHLh6WvHFhbYzjaIxcCCpxgW/ob4sUXK+Gc3Gw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=uhKr0Ao/Kc5Cnb/KFq9LZQblz7H8Ug2zzfCeUSzzIPXGWDBePsmC/fjHjFNmfLR5G9R4wlMuf0FTsrZVsWI+3eAZ5Ym+vJlQhCBWsGQQO+Cpud+SfLUCZ9fQnKA9qAUVy1CItUIPSRRZkl90bjoo//k083u4ncNcckv/k2x+Tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=GSbICQnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ro2C8Src; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="GSbICQnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ro2C8Src"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 670C8EC032F;
	Wed, 24 Dec 2025 09:29:22 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Wed, 24 Dec 2025 09:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1766586562; x=1766672962; bh=U4
	wc0PyuiKLhULiv+pIMbDFV7iBxSAoG8+KAJ8PDxHE=; b=GSbICQnMFhUpOChOG8
	ORqVjn8dM097lFvOYYV/02E/gi3S/3fP1ZSpg+p3swMuAWY8Iptcmb4/2W3l9iTR
	Xvo1ZRdaBjijSNbFlUyOc8zbi6g4S4Fz762Z6rfQpTRlpa4I1s+gEPiAf6Tn3B8e
	yRjBEnUd2eNVliSsXUUAAhcBz/vhD94fKKJbavg6FzMCGr0lDXzy8/jiGImVgj2/
	i9zMzOI7AW+uEk5kMyfV1Anse4K9ajf4nNrJ76edE4EjJ9Pn9/r+3hKvCe5Xrcc5
	ZPS6h+ZTQ4Eo2NY1A2Lbb+alrCEETVFGvLQmyE8e/YzQ96Pp64MPssiyIa1JkZ/3
	JXzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1766586562; x=1766672962; bh=U4wc0PyuiKLhULiv+pIMbDFV7iBx
	SAoG8+KAJ8PDxHE=; b=Ro2C8Srcu/CEgfwYyBP9HX63rWcVktkmSGFxsHK5OOUq
	pM0+Jj8Z/TOsdfKp5V8dp6IH+OLAu9dj7xbDf8uCM1J2lxZxk/2NWZTMlhEqjmFu
	yWuQ+RHVOP4JJ3Pad4b1FKC/30+aSu1gJe/eeyXxFw8ZkBjoQzD14A/tH0XEIwPG
	b6on2xYXlXiK4vVYVDlb7uXeyt5HHS9FQcnP+gC2AZOTYx7k/AwDDd9tPtp69fw7
	0Hi8IMEs96e47Nv5yrO6H3+sW5elg4Q6BP20MjId5exl+kCfN8/m+Cl6x5yQ3+Ca
	ZtaCeTkonGo1uQ1s+BaLNOQW0ZxbcTAn/3PYX7vw9g==
X-ME-Sender: <xms:wvhLaXL9Pfh_xYXjyY0MT9IWUpFS5wEHN46Mk53w2C_8cTtMEa6QVw>
    <xme:wvhLaV8pwMC1awhR6TOqJc1BDxM8FkkldzOfGYgxyzHEVJZycHhtdM8qdfBmzPCL2
    LrpfuhpPfpq-mTYkRxiXcht3gZBGzOThdXRrbPZvdOGuUMr7TP2Eb9z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeivdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkffutgfgsehtjeertdertd
    dtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggrrhhr
    vgdrshhhqeenucggtffrrghtthgvrhhnpeejffeugffgueeihedtgeefudejkeetudfghf
    egudekgeefgefgleduhfetfefhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestgho
    uggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsg
    ihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghp
    thhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wvhLaZGyiqP5Vnz2NWLNqjiG6vN-jBqIc4UF3I_C5T8QYTCXdiwxYw>
    <xmx:wvhLaVvEMKifDcUaJt9UwL8cwzbWOlVlxXrQK3ICbnQryRg5C6OPQg>
    <xmx:wvhLaQth31lgHU2dmvs8-TNLco005iJXqH01rB-rbN_hc6FGA-WcRQ>
    <xmx:wvhLabAPtODtN-zNTbTfDh45BuHLF8y68xD-vmVVym54TTjfr8Q8cA>
    <xmx:wvhLaXsYc3QZ6an5KVUcbh2ujvW2gJSbRVSX9eOm7kEj1HDofFfITLmM>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3176CB6006E; Wed, 24 Dec 2025 09:29:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-forwarded-message-id: 
 <c03bb61c-88a5-420e-acd5-d45ef43676b7@app.fastmail.com>
Date: Wed, 24 Dec 2025 15:29:01 +0100
From: "Pierre Barre" <pierre@barre.sh>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <aea6cd1d-ff2b-4288-8196-edfdfd1539f6@app.fastmail.com>
Subject: [BUG] 9p: data corruption with cache=mmap under concurrent stat/write
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm hitting data corruption using 9p with cache=mmap when stat() is called concurrently with writes.

Environment:
- Kernel: v6.18.1-061801
- Mount options: cache=mmap
- Transport: unix

Reproducer:
1. Mount 9p filesystem with cache=mmap
2. Run PostgreSQL with data directory on 9p mount
3. Run pgbench workload
4. Simultaneously run `watch -n 0.1 tree -ah` on the data directory

PostgreSQL reports:
  ERROR: unexpected data beyond EOF in block N of relation "..."
  HINT: This has been seen to occur with buggy kernels

Analysis:

The issue appears to be race conditions in getattr/setattr when using
writeback caching:

1. v9fs_vfs_getattr_dotl() condition checks `v9ses->cache` instead of
   `v9ses->cache & CACHE_WRITEBACK`, triggering writeback flush for
   any cache mode
2. Both getattr and setattr call filemap_fdatawrite() which initiates
   writeback but doesn't wait for completion. The subsequent server
   stat/wstat sees stale file size.

Would using filemap_write_and_wait() instead be the correct fix?

Thanks,
Pierre Barre
