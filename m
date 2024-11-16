Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D954765
	for <v9fs@lists.linux.dev>; Sat, 16 Nov 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745658; cv=none; b=Js4oIBwIqYEbJMJhOElN8zqmZDMJ7apInqks4xYywYlUk/cPtuEyXiVNBItF1FBOoNkmdsIIthjXZDHysF2Dt+Kf6i0Et9XGsA8NmAnNBJCQVPLsNJc20suF8o/P505jiivspU9iV0gymI5lPDg5rHkCl+nBEKomyjbFYYX7D7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745658; c=relaxed/simple;
	bh=MOVng9Ha4sMJk3+Jdat+wN9LMmfgLGKMsUzsSGUIiHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epnclM3RqZ1DYeUR/1lGo7KFnrEgcMFhwuexpMUdq6OPnuCUeHBGoXzLgcj7AGJ3fGMcUKx0SQFXGdxw0SoPpD20EOsGkSdpH54Uq25Z/oeUdUtqjCTS2Y5EL0VCJN1fU/Wz0kAWdGgFsOqopAnw+E/G8NGWeGmFrE5hL0qd+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=q4WM7UrE; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="q4WM7UrE"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AE98B14C1E1;
	Sat, 16 Nov 2024 09:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731745645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KswjZy/HqPntBZ/99MsDazDdPI3IQwrkpz4Pv2A/tBg=;
	b=q4WM7UrEeKRUvgS0GdEXq6mFtoRBoOUipqcoVaH7brZbBaaVJiePYYgAnnkRls766U+cl0
	0oAHnwy1nBRByk2gHT26ev0/u3Vgv/2mmb8q3TOqWIYL1vFeTOqzm0xH8gO7C8oa2zfVZW
	4HcnfERgwNQkqw20mPDEob/naIxzC18LqoGuUSbKsDFXuyM3y12G6j5YnNCu4zQY9FQMZ9
	46ds80N79P9ozyKMOt54n3WiHk3ZAeIgwpQWjYGKJ6ye1y9Alcctq0U7WdDHWycCGwCtWF
	+LH45kV7LLDZTjpCatoaUGb1FSmZuiYpqJxCVVQ7HlbpfxKJAtb6CbhL1JVzRg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f7b2776e;
	Sat, 16 Nov 2024 08:27:20 +0000 (UTC)
Date: Sat, 16 Nov 2024 17:27:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] fs/9p: replace functions
 v9fs_cache_{register|unregister} with direct calls
Message-ID: <ZzhXWfkxj3cY8zTm@codewreck.org>
References: <20241107095756.10261-1-colin.i.king@gmail.com>
 <Zyyt0XUv0Ypl56qI@codewreck.org>
 <d410dce3-36ce-4663-94ca-25bad2f91ad4@suswa.mountain>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d410dce3-36ce-4663-94ca-25bad2f91ad4@suswa.mountain>

Dan Carpenter wrote on Thu, Nov 07, 2024 at 04:56:55PM +0300:
> On Thu, Nov 07, 2024 at 09:08:49PM +0900, Dominique Martinet wrote:
> > @Dan, I don't have anything queued up 9p-wise so if you want to take it
> > through the janitor tree it'll probably get in faster; otherwise (if
> > you'd rather I take it or no reply in a while) I'll pick it up when
> > other patches come in.
> 
> There isn't a janitor tree or any rush on this.  ;)

Sorry, I was somehow convinced you had a tree somewhere.

I've now taken it in 9p-next, will pobably submit it for next cycle.


Thanks,
-- 
Dominique Martinet | Asmadeus
