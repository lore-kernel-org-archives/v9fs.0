Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280673;
	b=uGAf4gBL5cKbZNFh1NgXUG6rh7V8AvnLsY8mfEZPu2kWhQAkD/lcPs6oBSYjgr4kx1a4
	 KnRkhbnLwv9q1CfSqGjtdXLuSUN82xT2H5qd1wxAgdMDzpr8vnr35oimrRYvC7jT1fCbW
	 3SKkZs3r+e44cstl2wnQndVxy+n8T1J/ZcBWWG3Pw4wr+kKugYubXcZ/BahO3SjmR/aXh
	 0cht0EK+f3i7ZY9KC7mEu34LGASrxIFmJPtWh8Yw/AkrPtBTZlJhD+exaAyxzYWWDGp0m
	 vG8HTd716sVR44s/Rgq9ohIPnyjgexk5nfX0/dFWhYlaTGpxyJ71EeHKh4+naG8xBQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=By2eJ4XZKUqe0XFvU6d2eOG56783Xnvs7crtTDE4A/Q=;
	b=JS8bkkrnyU5WqDBYee/riifOMYPJuUYI1IjjX3pLK5XviETciKSti38JmEOKsr7pLIJc
	 ZJtTlyleiDGKyLK0VbB8XkpkR1+3tgo2YDGLI6/U8h31YTFHTnbUxGXjIemOkH8AfUaGq
	 cYlErrG96vf/BvCVfNwNweuvBpmrcOSizSezIZFyXq0RJQpBrr5dtPeEk/389Q2toNSLg
	 lUwqC9U2swUCfqzqUhK4mkLhHFQ2Ux64FNno4H4j7PfxOpglF1hNoyEtaddLEzkd5TWZx
	 txLjoRMv+yg0HhnsYBPt8C/hEZfHweb1m+2GEaz/4QVuzHN2wUA3ZRdrSXcC6Pul0aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=4blu9VVn;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A61606A323
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 13:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A61606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=4blu9VVn
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 20CCF14C2D6;
	Thu, 29 Oct 2026 14:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793280664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=By2eJ4XZKUqe0XFvU6d2eOG56783Xnvs7crtTDE4A/Q=;
	b=4blu9VVnEkx41UKwf9Fa/DKS/Sql1ttVu7MO+n6fYm4irZ+d82xmx40d5pqc8kZvKM0AgV
	5C8HqNlHLYclxelyMRfyE6EBf+iywb64piZo/XxMDPnMJrGVdkD9DfPwwrLrY99//a9pzo
	rrdzzW0tTCQzhNARHC2kaHgc7kforBAEFCFErJxwErNiTcdGPrLbsTQCg7+t+jC784mQkb
	/vJwcLHLROF6K5IB0XWxJgf2ygVofe99i8VNw34fI1AFbdqPYufwJv0ug4jyrIP54j3D6S
	1UFyM2K5Arw4vpItCtfI6Wxv1xpz8oNFRoMja8CknuyxIe4Rh4D8lHLeZXL3wg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d8a33568;
	Thu, 29 Oct 2026 13:31:00 +0000 (UTC)
Date: Thu, 29 Oct 2026 22:30:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH] 9p: pin request under client lock in p9_tag_lookup
Message-ID: <auNKhWf9nWaGq14c@codewreck.org>
References: <20260930201357.590469-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <auLejxGRgVLKlLuL@codewreck.org>
 <08dad2f67457cf97eedff42e57312bd2@oss.cyber.gouv.fr>
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
In-Reply-To: <08dad2f67457cf97eedff42e57312bd2@oss.cyber.gouv.fr>

Jérémy Jean wrote on Thu, Oct 29, 2026 at 11:56:03AM +0100:
> I am not so familiar with that code base and I have a hard time
> deciding the actual impact of the lock.

Each request is already taking the lock twice (when allocating/freeing
the tag in the idr), so I'm honestly not sure how much adding a third
locking call will change in practice without testing (and if I wanted to
be pedantic I'd say I can't even test this properly as I don't have any
numa hardware that'd be impacted more strongly by this)...

One of my worries was that some transports call this lookup function in
a irq (e.g. rdma depending on hardware), but that's another thing I
can't test /shrug

> As you said, it might be possible to keep p9_tag_lookup() lockless by
> storing the owning client in each request and then validating both the
> client and the tag after successfully incrementing the refcount.
> 
> The two helpers refcount_inc_not_zero_acquire() and
> refcount_set_release() should ensure that the client and tag checks
> see the newly initialized request state after reuse. Then, the
> mismatched reference could be dropped through req->client. This
> should stop a stale lookup from mistaking a recycled request from
> another client for the original one.
> 
> Below is a tentative patch that applies this strategy. I have
> verified with my reproducer that it indeed fixed the UAF. What
> do you think of it? Let me know if you'd want me to send a v2.

That's pretty much what I had in mind, yes.
I wasn't thinking of the _aquire/_release refcount variants but after
checking I agree they're needed, so I'm tempted to say it's another
argument in favor of stopping SLAB_TYPESAFE_BY_RCU...!

On the opposite side if we keep your current v1 then I'd get rid of all
references to SLAB_TYPESAFE_BY_RCU - it's no longer needed with the
lock, and the allocation no longer needs to split refcount init and set
either.

Anyway, please give me a bit of time to run some quick benchmark with
and without lock even if it likely won't mean much, and we can iterate
from there; I don't think this warrants a v2 patch at this point.

(It will be at best a few days, I'm not expecting to take this in for
7.4)

Thanks,
-- 
Dominique Martinet | Asmadeus
