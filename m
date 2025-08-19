Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D633CE88
	for <v9fs@lists.linux.dev>; Tue, 19 Aug 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608717; cv=none; b=XoJZ1anBfJm4B4aNDoNV5s8+dkGo0PzVzztwwTxOcLYOc8cKhIL7Q+RhKsKJrTxLXYdStG5e+3RhJk0EJCAGvStHeudLgNgT/vlve1jkc5/ELF9ub9CWGchL+2vlEFOVzvjyluajKbbMjx/KDOVwyi/zRJfG2s6atQf4Ns2XvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608717; c=relaxed/simple;
	bh=2XgrvtYDmwZUcGVTZfL7e/sPjjFo0c4czq6fGvPgyrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drqNflYBZk/sbR+GwCBAIcvj6GCyZktltMsKa/a4iH3HPudxFTEbGhzrsZhmPTlLGRQuvhnV09mJJ+/59GqiaTnTs1MNqsO+h1f0O4rAO/ljr5jtjVnSfiNeeiwzSvi1knpDiEaq6gjt+gOQR/9FNGfhMykMGe2tOtCQ2qMy2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=a2djMx7R; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="a2djMx7R"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c5qNy4Y53zCp5;
	Tue, 19 Aug 2025 14:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755608242;
	bh=YsLuM3yGbZTvi6po099yZIeHOk3XlsGeMSXmLnbfMo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2djMx7RVPFn9tUAcxaAYRA8TrDnz2V+96NF2on/9cJzy2OIx6i9go4O052EfdCAY
	 aHicr0b3Xh4yX3YWtNkoOntssedZmFseK8Lmjbn2sN/Hjyh0fk8W93PF8tb4uh249S
	 KfjlDdw3k6JRwAf5aYSPRnOX09X7uxbxt+wPL09s=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c5qNx5TygzLg1;
	Tue, 19 Aug 2025 14:57:21 +0200 (CEST)
Date: Tue, 19 Aug 2025 14:57:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Tingmao Wang <m@maowtm.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	v9fs@lists.linux.dev
Subject: Re: [PATCH 0/3] fs/9p: d_revalidate changes and using it for
 uncached mode
Message-ID: <20250819.sheng6Iciafi@digikod.net>
References: <cover.1743956147.git.m@maowtm.org>
 <Z_13l9hPolrDrEnj@codewreck.org>
 <aJ6zmlp0XHKW5f-a@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ6zmlp0XHKW5f-a@codewreck.org>
X-Infomaniak-Routing: alpha

On Fri, Aug 15, 2025 at 01:12:10PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Tue, Apr 15, 2025 at 06:01:11AM +0900:
> > Thanks for the patches; I think it makes sense overall. We've had
> > problems with files modifiede on host while guest was looking at it
> > semi-recently and I thought it was fixed but it either came back or I
> > missed something...
> > 
> > Just a note so you don't wonder what's happening that I won't be able to
> > give them a proper look for ~a month with real life getting in the way.
> > 
> > If someone else gives it a fair review I can probably pick up this
> > thread up for 6.16 but otherwise it probably won't make it, the landlock
> > part will probably come even later...
> 
> Sorry for the delay on this as well, I've just given a very quick test
> and this looks fine so I'll grab this for -next
> 
> Since I didn't wake up in time for 5.17 it'll wait another cycle, but
> it'll get here eventually.

Thanks!  I guess these patches miss some Fixes tags and Cc: stable@ to
be backported.

> 
> -- 
> Dominique Martinet | Asmadeus
