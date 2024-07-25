Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FB7482;
	Thu, 25 Jul 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920215; cv=none; b=hdbLFn+8P/nLBhgBzP+yrWyVyVPb/SeAlbf3OlNU6eBQD99Fl/SargVapeftFgpfWUL8FxNM/DyLyfGWO6jn4y7Za7+1w+DJy1wpZd98Zl88BNk8/ZjqWn7WxNz5DrYsfj8dmjO73HN5hPG9JBIq9oH1m72zVAGd+3QtIoBg3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920215; c=relaxed/simple;
	bh=giEmIQyfujgK7trC3Z5BVs33T8wG9iTIdiSpNdknO8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6I9FJCw264fZiXA9ThMZf8ajiklyOP8xiOu/P+l8PBocz5PS5qXMaMYzW1Z0VRSYxNPX12W+jB7xStcZw31GZ9M9sz4a3mj/yvMEv53hl5pK8jNUQKrLeMZ6VIAkdWKCU5APSvpNxfuOZYU2cL2Vu9Y1UixghKWYQKBamNxOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GckM/erz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GckM/erz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7fgIlaj7VIBRKbKi7Dde+07wn6FnHltfd48aihj7Dfw=; b=GckM/erz476VA3L3
	94NtvBcuHNQiXZ9fv1tvbntVTdR1QZA1Z4swFGO/3LUGn2mQWPItsfYAa3lnqGk6SXXGhRyqt3nVw
	r1toAfTjQDe7vzfJ6Io/eRK9S/ekFqt86iolILI6kSoyj00NKFikJb3EBGf5Upyl1ogCOW2+X4uyA
	eR0ygJqVbabAmYqs+5EF6LzDp9jHMSGuwe81RYs3Pp+ntliMJzRBiT/aamnKXhNSvr10j5c8vh7pv
	jadNWvIF6fZYyQBCYFYYqgmE3+7fP56d0m2aDUB4txjsUwoNEOXHMrDbofGhN9gfqIhEBM3bPsTjU
	aMRULUhFg435qeuIuw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sX06X-00DDOj-0e;
	Thu, 25 Jul 2024 15:10:05 +0000
Date: Thu, 25 Jul 2024 15:10:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 9p goo.gl link
Message-ID: <ZqJqzcJRaXgMRLoT@gallifrey>
References: <ZqE9zUXO3agBjno7@gallifrey>
 <b7ec9dba-5ba7-40d1-b1a0-e85f3149f445@infradead.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b7ec9dba-5ba7-40d1-b1a0-e85f3149f445@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:09:48 up 78 days,  2:23,  1 user,  load average: 0.07, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Randy Dunlap (rdunlap@infradead.org) wrote:
> 
> 
> On 7/24/24 10:45 AM, Dr. David Alan Gilbert wrote:
> > Hi,
> >   I noticed there was a goo.gl link in Documentation/filesystems/9p.rst
> > 
> >     * VirtFS: A Virtualization Aware File System pass-through
> >       http://goo.gl/3WPDg
> > 
> > Given goo.gl is going away, I was going to expand the link, but
> > the link looks fairly ill; it goes to a sciweavers.org site
> > that has an abstract, but it doesn't seem to download the full document.
> > 
> > I can see links to the document around, but I'm not sure if there's
> > a 'right' address.
> 
> Yeah, it (or a variant of it) is available in quite a few places.
> 
> I prefer this one:
> https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf

Thanks, I'll post a patch.

Dave

> 
> -- 
> ~Randy
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
