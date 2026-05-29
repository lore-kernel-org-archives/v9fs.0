Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8E35AC18
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022466; cv=none; b=d+yB8aKsxROs7tQjNtOWuZZXEW1sp3UUuWMtNpnmFuYEI3yKLujYqy8HiaaQtefRQflkfvao7MzOVY4viF4mk3oBemegM90vR7arzcdKxjnwU02nU5eHm8+174HcC3OpvMxOjQ9eBc9SbCWXQ0HB6xWD5hRVowdvXHN+Aq+jkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022466; c=relaxed/simple;
	bh=Z6XdDhF48S7c2HyeMlf7I0oXXf/MbmepJPQ5KF0ht2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWeU/09zuKULYGtkjP1Bla2e2dWZUIYrPE+NhBvm92CPz9xLHRU9vWNhEVYgPspW7rAL9s5PHns0VWXVDdNlqgMyN07f3w0FEDMbVv3lMoCOHJkKq29ZuqyOkRcBAkHVDg6/4CgCk9fQhsqAaPTsbzi/bN+nppchbF0uBa3T+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=n2+M5FFu; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="n2+M5FFu"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8419114C2D6;
	Fri, 29 May 2026 04:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780022463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FdBpLbeSF1+PYunOzClPys8cqaeaZJN5U3Td3axJnzs=;
	b=n2+M5FFu33zteclvxVDDU/lBk3qmXO6hI9LTvkO4fwgSaJHJpDE5xRAXrqi9o0bkmhJdHe
	+Rustp+69+W71o5S5tfq0A1sE5Gn3a2LwKTOb9D+Q16c21uArzzAejqE4TyRu++UKkEEOc
	by2msa6QkKvIyaR/55HLDO0sa+AnelA+sjCAWpO+28Qi1Y/LUDcUtRrqz5Z1Zh97QYR2ux
	AI3W00lBya7FYpDwHuS5b+XyAyTxwuWF6ePnLXwpObb3ZuZxyMqDVeA1U8/Q9Xb1+Wp3pD
	ZKtt/aFDvtUbmd1heVyo3z6oSP4o1L+MJi0v+LBb0i4pYC81eXSfB7Vg1VcQiQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d8b8d90a;
	Fri, 29 May 2026 02:40:58 +0000 (UTC)
Date: Fri, 29 May 2026 11:40:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Aayush Patil <aayushpatilsch@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	corbet@lwn.net, skhan@linuxfoundation.org, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/filesystems/9p: fix broken external links
Message-ID: <ahj8q3KPuS825WRP@codewreck.org>
References: <20260510182856.17569-1-aayushpatilsch@gmail.com>
 <agxW8An7fRApCY1r@codewreck.org>
 <CABc3pKGKCLydod2NOgETP-z0T5BHep8hyy7z2UF3o+DrWEh5yw@mail.gmail.com>
 <CABc3pKEY8QvQzWPeU9QGBFG1dtGSdseTRdXF_5MUX1MeNBV5QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABc3pKEY8QvQzWPeU9QGBFG1dtGSdseTRdXF_5MUX1MeNBV5QQ@mail.gmail.com>

Aayush Patil wrote on Tue, May 19, 2026 at 07:23:38PM +0530:
> Regarding the replacement links, should I include them in v2 or leave
> those entries removed since you're not sure if they're the same files?
> Happy to go either way.

This is fine as is, if Eric replies or someone wants to add the links
back we can always update again later

(I've also fixed the typo in commit message directly)

Thanks,
-- 
Dominique Martinet | Asmadeus
