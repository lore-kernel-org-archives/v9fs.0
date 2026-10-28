Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221630;
	b=Kf7sDUjJRuBkbQwQhM89VX1DKMAWgPDUS7nLLziJBvly2voZDX+ypuE9JEVGxc3CRWLS
	 dl8mYDdM5N0uDeGdXCRPacIQIwDyPKYlIxr29uGoPhdGGcZKxZ2/lqOsfFdhyO7nYiUjF
	 15lOk4hgivIO53pOBEJzYLWbhjy3NIku5CE2oqpWlEneQZX4IPIzZVCDRkREAMK2OCJ3n
	 OfPIKe8B7S6rr6N6DtiGuVw8k8UpD0Spev0ohFI+aXbgUpOJZuouWmznqfgT3qdQYnc/S
	 +faDBcEK0u06AsFD8e6AYGzeJaYcKvw50JDPrcOVlSUXERoQpMuDdypKvX97awR+Efg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221630;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2/lPgg8fKxGL3uLAdVbmY1R/+7ya4E8tGVT7ByIFRjg=;
	b=IopkCc5Mp11zIMLShTwsx/O6TtS8nfkx2b/RpwN7LVHZrj55g4LAU35pi6oPThd2T53e
	 xhSzU8N5+6A3QVapJPofag63O/rCL5Fp/xcLTPshD+RlJqJGhnkiQIgv91lEKtuG++qVA
	 COs3jEj7kYXm6cieJND2/0HfHdPXhRvGg+DEZGD/3Zg2CJY5Zba3N/h68760lpH7utubm
	 V/WGdIl6sF6eQ7vL6aDlJ6NrQ3kZw/vthzNxCxfRhN1wrKBlPtqjirXiBOaHAib7Oq84z
	 txIek0kE7JfePs4yycR7O8K7E/SxmkYQ/kxur+xBmAjj41OWLcHMDFvRuPzNKPblUHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=m4mtgKA8;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD489606A31D
	for <v9fs@lists.linux.dev>; Wed, 28 Oct 2026 21:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD489606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=m4mtgKA8
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 701CE14C2D6;
	Wed, 28 Oct 2026 22:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793221627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/lPgg8fKxGL3uLAdVbmY1R/+7ya4E8tGVT7ByIFRjg=;
	b=m4mtgKA8vzB48AHooh9KfUJFZwgaPwddicOLjyxi/t6FlBpahaXnIXUf30lFPqTrFsxY+S
	3gR2+bU0BiaB9tLG4jnegOQuPvDeU5UsIi5V+1xq5OqDw8Vui+fyd/6SjMylTt/QMV4EYc
	kyu1EN17ZRbhuXmN4eFNqrLmmXVc1U+RpeEQyhmDqLUBIQxxAQu6qey1Ry2LzuPOznHaKZ
	Wg4KGllH5USVGlclz6b06inudgr1FsDdIjvXhkCK+St84F5unF+TiP33jhtcC+TXgapm6G
	/8bwZJnRU4dboykDCHzWvXIRH+acKUDtvNGmmFaYdG5PU4r83/9t6pfcaUyNyA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 223e1ccd;
	Wed, 28 Oct 2026 21:07:03 +0000 (UTC)
Date: Thu, 29 Oct 2026 06:06:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, sgarzare@redhat.com,
	stefanha@redhat.com, v9fs@lists.linux.dev
Subject: Re: [PATCH v3] net/9p: add vsock transport
Message-ID: <auJj6EKveraM5woC@codewreck.org>
References: <arI7p2EinDektW0n@codewreck.org>
 <20261027200522.94192-1-skvarlamatus@gmail.com>
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
In-Reply-To: <20261027200522.94192-1-skvarlamatus@gmail.com>

skvarlamatus@gmail.com wrote on Tue, Oct 27, 2026 at 09:05:22PM +0100:
> I noticed the batch you applied to 9p-test on Sep 22 (including
> the vsock transport) hasn't made it to 9p-next yet, so I just wanted to
> check whether it's still planned for the 7.4 merge window or if
> it's waiting on something.

Sorry it's just waiting on me to have time to do something.. There's
still a bit over 1 week this merge window (it's exceptionally 3 weeks)
so I think I'll make it, I've just pushed to next

Thanks for the ping
-- 
Dominique Martinet | Asmadeus
