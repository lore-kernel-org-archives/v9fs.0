Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253038;
	b=Jrs4wwT0qRoTOMbb4mzFk7LCIanH3Tzkt05Jaoygqw9WqWRt9pIF3sfu1eD7HuIGuKKj
	 WnC4HN4pelpAmGDGttBsdYysi0YuAYsDh4HNzquZ94WT5fDaibSnuCPoJkJeY1rGpXKF6
	 hP7+yQ6+iRNcitQdU3gQZBOQX8gFvowPVA/vjg9G45xszFFfvFDvttRadHuBuADJqdekU
	 SFZgaDlv8gtaENakZOT5wTX3bo01ogQP0435hQzPqZ1LFZS29quPpvYt/DjDeOSe2VdTf
	 uokJccGmcrozastTvKKk7RtjyKlGTx7P8N+vrTNqw8KSIqp6vPc2jblp9de8F47v7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253038;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=P3PE2FvQDeDg47lUY+c1B4hlYkYPfpXvssIQ1cU0Aro=;
	b=zli5IwkP9H9YHIwJikRYBDW4etqsR7x4F1FpNZqmJ2JAl7lvno0vuinEf1AHt22JNrap
	 XH13OxpSGmYEvKsZXhoPWHigsMfHX+3NOQBdmOat5vBoQOYalaH8wbWPbKMhQP49lx3LE
	 xKnkXvn3I2nSoGWvLZUACXKlFYYCJhBlb7syF7sPa2TDK64rUblXYFhPtC5FTfgxymxjF
	 0ipV151kfCavx9dBC+8/zkMbknWwLo0dFEpjaU363WB9WCNNu1OJAaT71deQSo+MvqSYc
	 AFqp7/jTWFpbiv/zB1NpF0guDCwArkh2ubWrGuubWfeRHeXpKBZtqbkrq0Cj4N6vv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=pBBE1z0c;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3A606A31C
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 05:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=pBBE1z0c
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C9B3214C2D6;
	Thu, 29 Oct 2026 06:50:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793253025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3PE2FvQDeDg47lUY+c1B4hlYkYPfpXvssIQ1cU0Aro=;
	b=pBBE1z0cN+HxlacBpE2IQ5462goyyiey+AqDOHAWTl1ejch4s34DaA7TG+MWKDfd4GduZy
	AEXLHnvae3qUUVfCOw05R5KdoWygZ61ukfQBpKZ6qIhg9R9jMn2L/itqdtEd/oufsGYet8
	HBOhTRsAplaTWNBFbip1WRdLt+m2lzYKaWNH8i9y/ow7xypoieBqa/ufExB3J5CiDmcxyY
	b4fZOGWwNPy7625PiWZ01j9LB1LQ5XSHOx2jylPH8xrUQ08AEZm0V+bn7dbKUN3YzgwrfH
	GtNBGQ3wryUAsyBcqGB9/A0IPTW2Ae5TQtDq12tGMndt5iK8/ZgH7o9Rxn0UKA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id eddc34aa;
	Thu, 29 Oct 2026 05:50:22 +0000 (UTC)
Date: Thu, 29 Oct 2026 14:50:07 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH] 9p: pin request under client lock in p9_tag_lookup
Message-ID: <auLejxGRgVLKlLuL@codewreck.org>
References: <20260930201357.590469-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930201357.590469-2-Jeremy.Jean@oss.cyber.gouv.fr>

Jérémy Jean wrote on Wed, Sep 30, 2026 at 08:13:58PM +0000:
> 9P clients keep separate request tables but share one request cache.
> p9_tag_lookup() can race with the final p9_req_put() and pin a request

Ah.. Right, just checking the tag isn't enough, we also need to check
the client... I'm not sure why I had assumed the caches were not merged,
they're only not merged with different types..

So technically we could add a reference or some kind of id for the
client and check that, but given SLAB_TYPESAFE_BY_RCU is hard to grok I
guess it's much simpler to just take the lock and be done with it...
(in that case we can get rid of SLAB_TYPESAFE_BY_RCU altogether, the
lock is enough guarantee that the memory is valid until we get the ref
here)

It's far from a new bug so I'd rather not rush this just to go back to
rcu a few weeks later, give me a bit of time to check how much impact
taking the lock here adds so we can decide. There's enough leeway in the
p9_req_t struct that we can check the client for free if we care...

Meanwhile, if someone else has an opinon feel free to chip in
-- 
Dominique Martinet | Asmadeus
