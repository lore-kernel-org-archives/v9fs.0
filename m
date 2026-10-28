Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221582;
	b=TDlF9ZP9RjsZnfeq72MVW6awvm5HBL1hx76i5oh0FH/+ZCWzPeFjm0Qqu36YWCjinFLZ
	 zCQSQLB2NHvGWRvetnaS4wjF03wOG/MBkecN/dKtTuaYB1OkcPcG9I4YiG0AO83zQPr1Z
	 +h15ljDHLYjTo4eTmk2PRkW/fGfXQonq+FZN4XD0RbGQJPuxOJnQDbQ69jQHCEI7veHkG
	 9yfhw3YxXYbcE2MKPtIHM0RRd26CuYactg/CWQFodCXJOuEiZ5M4esCQn6w2zQEqYW3kH
	 7j2HMiG5MzZm6FIdXX3IM5QtR/JLCneqTKEph8QKbuWPS5IBUj001kwZwsH68ZO7YwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=1U4kkjWGgsDvjjFH6rA1YeOtK+lamjZuaWRgy38Z+iY=;
	b=jaW+HgoYxuLQQBZmfWzqglUsinSUxTNVEVzR7DTqZgN4Is9dS0aF1i/KYu38w454mBiM
	 /OAYuu031YO94qlYarxq2x67crrITqDhJyhbgNwGIUt1EBw+UvJGACBrHR4U4PtgJorWg
	 TpJAxi/CJWjw6nI+GUzmP1sB7gngU++hu+FVj/X1UvPzXjFE4+aWb908N3JdWmxjmHQk2
	 kWKzlQfVH0cFq+uo7U71isF/gVqXWwPheT9AqG256OhzvTMeemVpXgD9T1LhRyn3HQicX
	 yKhbkPt/YKDWq5b+6WEYWRWn0yjQylI67A7++zP8FqUWpDRsV/OtisBS76X2jjhEQPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zfhRCywQ;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461B606A31C
	for <v9fs@lists.linux.dev>; Wed, 28 Oct 2026 21:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7461B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zfhRCywQ
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5555814C2D6;
	Wed, 28 Oct 2026 22:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793221579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U4kkjWGgsDvjjFH6rA1YeOtK+lamjZuaWRgy38Z+iY=;
	b=zfhRCywQm397mApgZmVGmGOur7Ab9RM9b73cQf81jpGS2JpQ0H7LFelfeZ4xziGR9tqxHP
	eDS26RIkkmvE5T86bUJaddC82b3ABEnmrM1VyXQ/stLD7xs/vOBRRa/dm9zBWVUC2tr8my
	69fePCmEK4ZpsJgOSjtVQy1vFbroO359N4t166tnP2k9lb+Z0gijXGRWaNHCqGcH2FVznb
	viEeBDt5KuHOjXWo+po/nipEwiduyWk8qXen61oyTtfudYvFmKw09Enfx6fGT11LpMSKRk
	jv9h3nVBT5IqkNsJsGiM4RZS5TtLF03h2KjdPG3RKk14e2JPPFFhaC4fIMQG9w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 370ff9f9;
	Wed, 28 Oct 2026 21:06:13 +0000 (UTC)
Date: Thu, 29 Oct 2026 06:05:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Juergen Gross <jgross@suse.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] 9p/xen: drain response work after unbinding IRQ
Message-ID: <auJjtiJbYfZnVxbC@codewreck.org>
References: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqagvTnrIOGl8nfi@codewreck.org>
 <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>
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
In-Reply-To: <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>

Juergen Gross wrote on Thu, Oct 08, 2026 at 12:42:21PM +0200:
> > This one makes sense to me and I've picked it up, but I think
> > "9p/xen: fix use-after-free in p9_xen_request"[1] adding a refcount to
> > the front_priv is too much complexity vs. my understanding of the
> > current threat model -- I can pick it up if someome who understands xen
> > better than me has a proper look.
> > 
> > Stefano or Jürgen if you care / have time?
> > 
> > [1] https://lore.kernel.org/r/20260529103416.81378-1-zhaoyz24@mails.tsinghua.edu.cn
> 
> I think [1] should be taken.
> 
> We try to harden frontends against potentially malicious backends running
> in a driver domain. Such a backend could cause the device to be removed on
> the frontend side, so the attack vector is present.
> 
> The only reason this doesn't qualify as a Xen security issue is that the
> 9pfs frontend hasn't been yet declared to be security supported regarding
> attacks by the backend. Hopefully we will get there.

As said above I'm happy to take it under the condition that someone who
can validate the patch has a proper look; I don't have much time for 9p
right now and my setup doesn't include any test for xen so I'd rather be
cautious

Thanks,
-- 
Dominique Martinet | Asmadeus
