Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AE4C97;
	Sun,  7 Dec 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765091892; cv=none; b=V3jW8iuWRcuhcz9dX69ScgQaplVJbGhDVeLY/EMYwTpkl7AC8PqH+WLSEOyoa5jXNOlrpSm8mNyMBj9dV0E3PsNjkoSsVPIBUGkW2k8NZK8eHenMQQd+aXxG4ZZ4SfcdWQl0gXDC/0+EsfwEFDoW3GMWexJ1ysQ7SCB1Mt8VMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765091892; c=relaxed/simple;
	bh=DAccmFMfzX6rNCXBjl+K+iP0Ga3fG6NQilcf5Z/1OQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3LrDAd0G+K4xLShlRcePYCzRfg1YQ+SiFnceWQbtj1orETJ0tv1SzpC7REsvVoNEaGZBQqTYcFmJ/tsiDQl1EX2H1hudzVnSs9rmUjMICVJHOIvT2Vn1h8+MPjz+UvCttjWWTilsh5fbOPTo1rRzZOA1VnGLPYNl3Vhr1lVF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQkolVUq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQkolVUq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CpbRA2oq7D72qJWSVvTQlZDv/Lqjzxz1XcpqKhTtug0=; b=nQkolVUqeEg+auocfOygmyEHJ6
	cPY2I1sL+5YEf2UKx5MQGFloVD9HW3tLVZxwMDyhwAgIkNczchXxLWEGtFKr5vpCPMqYFSrXlMcL3
	LnUy4xM/MAydPe2TWbjdWpUPPe+YfvEpE24AXBQnjcRN+5NnPohwOvS6xaaSlanAsEEUUTbN9Dlm9
	+P0tCodwQrFwiepvcIspJI8BJZd9zEnLCHLrA4WMD7uqwLDcqa0VfpcIrwk4+ZPp3mtQWk1N3pSyT
	Bd34WKmvYBvpuTzX/hTLluKJldXkDyt+cM0mQ2vh3oyUPxzPk4OIV5k+RJ0IiySlIO6CqGQusa+1I
	yLofWRlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS91u-000000088wz-28Kr;
	Sun, 07 Dec 2025 07:18:02 +0000
Date: Sun, 7 Dec 2025 07:18:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aTUqKudyHxilbBpL@casper.infradead.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <5945634.DvuYhMxLoT@weasel>
 <aTLYEF4ZaTwF3tdL@codewreck.org>
 <2245723.irdbgypaU6@weasel>
 <aTLix4bcHo_XDXpf@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTLix4bcHo_XDXpf@codewreck.org>

On Fri, Dec 05, 2025 at 10:48:55PM +0900, Dominique Martinet wrote:
> Your patch will appear to work (folioq path won't go there so the page
> won't be pinned), but I'm not sure just being a folio is enough of a
> guarantee here? for example is a folio coming from page cache
> (e.g. readahead) guaranteed to be stable while it is being read? Can
> something (try to) kill that thread while the IO is in progress and
> reclaim the memory?

In readahead, we allocate a folio, lock it and add it to the page cache.
We then submit it to the filesystem for read.  It cannot be truncated
from the page cache until the filesystem unlocks it (generally by calling
folio_end_read() but some filesystems explicitly call folio_unlock()
instead).  So you don't need to take an extra reference to it.
