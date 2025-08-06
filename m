Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E6221299
	for <v9fs@lists.linux.dev>; Wed,  6 Aug 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516705; cv=none; b=pofmmOsW9rui/uwadDNKSSRZCoDfueYuFvTaUDD98FyLxcItBajurOzu8TkMcUhccN5HsRl3zv11hAEy0KN452lFMuV5uZIDMQkO5HbzncyXHJ7wzDiGJIYAbVWIo0TVHjHflk/qWQ8vL+0UuCJlyDKhV0QIXFna66zRw3JveE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516705; c=relaxed/simple;
	bh=hSvhgcIPSMVKVVrDV9A6ow1mnFI3XEVqUK6kLXNTlDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9GMPsYqQwn81D2Tnii1TqxFHlqGi7ksCqkPc4OJ2TASzr5w2sAyC7OrOgOz4JQ4Gf1WUsUshXD5Ad/pnUm0MlIWZwiECQOj70cGs0U4vWQCpoCmPhr2jDwtXcE04dTfO9+xgYbgblTyg+NYLwj3ZBiuUvu8DgYHdLtkspiUaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0PVb53zm; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0PVb53zm"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6C40814C2D3;
	Wed,  6 Aug 2025 23:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1754516693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDXslEXUyYlkqYWgbAu1NHBDx3cXJY158gt4ax7R09M=;
	b=0PVb53zm4I8zjKfCBSpErkqzpTqr1o75ceMU4+LQkbKSZpHjYw68/W/TGFoxzmwT8Ia6Tx
	Sbj663B4KtmG4SUBFNF8vZs68dYsJaTb4W6xUbewk/0WzsPEemvTVHFmtQe9aHcxNaric+
	tipcUEjHHwwogGuoEUjWZaZPo6jipY+t9AnSs4uimis4SJQSrKrHwCoOEShECYUlpM6m50
	D1ZW0qVcJRKC/RTdHZ+XZefOUYNBEXbXwNu0PJxExoiSyLxpcRKnqRuouJu6y10l+ojlyV
	2PwZuebFvRVKz5T/UYyutE3bR0c+TiLKqbcCQKFAXq26ZBp+qL4hKM5WgxVqEA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f1e66d28;
	Wed, 6 Aug 2025 21:44:49 +0000 (UTC)
Date: Thu, 7 Aug 2025 06:44:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Use kvmalloc for message buffers
Message-ID: <aJPMwqqchOaZFSqn@codewreck.org>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <2989343.ydHz1Oe0dO@silver>
 <1fcc97fd-bf32-4ea1-82c1-74a8efb6359b@app.fastmail.com>
 <2026737.7mX0AZtNi0@silver>
 <bbf2ae2f-d0e6-4f8f-b359-128cd8d5539f@app.fastmail.com>
 <aIqXi6uBaWXtvgm3@codewreck.org>
 <e42edd55-2559-437b-a2e3-2773b18d0cc5@app.fastmail.com>
 <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>


Pierre Barre wrote on Wed, Aug 06, 2025 at 05:50:42PM +0200:
> If I submit a patch based on what has been discussed above, is it
> likely to be accepted? Unfortunately, in my current setup, I am
> encountering this issue quite frequently, and users of my servers are
> having a hard time making sense of the error.

Yes, sorry it wasn't clear.

I still have no idea what's the "best" allocation method that we'll be
able to use as either a vmalloc buffer or split into a scatterlist, but
there's little point in worrying too much about it, so please go ahead.

If it's restricted to trans_fd and there's a chance we can make use of
it with (at least) virtio later I think everyone will be happy :)

-- 
Dominique
