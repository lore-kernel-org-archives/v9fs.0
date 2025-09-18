Received: from e3i308.smtp2go.com (e3i308.smtp2go.com [158.120.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8932E8882
	for <v9fs@lists.linux.dev>; Thu, 18 Sep 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224735; cv=none; b=B6C8sJXfwrpJD12Z48/Oj73GGDjnZkrekvFdjLobfU9eNyGEs3A5ZnSGFw+747DU/i9u0UwySMKEPWllD2RxpRKsNUU43ANWBwdAAVOju5Cwh4uZAWFZboMWmFo9dg7Akye1FtjWeJK3miAk+gVK9mkQ03SB4aOrFNJhfHmuaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224735; c=relaxed/simple;
	bh=l3pzda/Ga0u32pP2y0Ol8CiPoveeaHvhSiHYIF3et5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6ykrC9E+VDYSk3QB116c3XTRakq8+Qu/0qRvrYNI3djH07CCM78gB8JJ5BQb3zPnbpnoXzFrwPg7N+7ehqgDps8lzEH0eZrIV/GHBIqoKIvGMBAcCyxntgOr2+wN3ezr209e4aL51Hed9L/XJ6dgJPkOERDdDQvXx9Kv6eYERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=X9qezxPJ; arc=none smtp.client-ip=158.120.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="X9qezxPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1758223824; h=from : subject
 : to : message-id : date;
 bh=Hw7yQi+sLehXHDsSGjLvuOxcP7o6dr9w07jZ+nXXLQ4=;
 b=X9qezxPJkHXv1NbwA6zuZgNwWUzkC1WaSKCgFvXIDQfsm5x5QfgOdIU+9e7phxRY6cqWr
 E48b0ZIzHAi/pXiL0UlmXFs0oTmc4bx8d06oeaSePHf0wFGLBravFT62uukO85OFP3Apw3/
 Pt0fEEaULM400TdFwlxKpkr8BUqoHcVmBZpOBvQ4e4y2SJgw/ma/iNHBYk0vssaskgL4z+a
 RBdp4OIGCYHt2L5/gHfyFVr6Rk8sFjgXGYRfzPoLr56ZrrsiVdmr0pOEJmhAThFVfE0YnJ4
 PVuKQwxZ6LmiRO6gUjuuViSOwJBnLufQow0Tk+emLt7ab05Ju3BXgfxhuzBw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1uzKKd-4o5NDgrhR1L-rWjP;
	Thu, 18 Sep 2025 19:30:15 +0000
Date: Thu, 18 Sep 2025 21:17:33 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Message-ID: <aMxazb_dcK3hTATI@pilgrim>
References: <cover.1756635044.git.repk@triplefau.lt>
 <aMa2Q_BUNonUSOjA@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMa2Q_BUNonUSOjA@codewreck.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sC45X5161K
X-smtpcorp-track: hj6tBN28fitc.pkHRJU3_vy_z.seP2EgZ63OB

Hi Dominique,

On Sun, Sep 14, 2025 at 09:34:11PM +0900, Dominique Martinet wrote:
> Remi Pommarel wrote on Sun, Aug 31, 2025 at 09:03:38PM +0200:
> > This patchset introduces several performance optimizations for the 9p
> > filesystem when used with cache=loose option (exclusive or read only
> > mounts). These improvements particularly target workloads with frequent
> > lookups of non-existent paths and repeated symlink resolutions.
> 
> Sorry for slow reply, I think a negative cache and symlink cache make
> sense.
> I haven't tested these yet, and there's a conversion to the "new" mount
> API that's brewing and will conflict with 2nd patch, but I'll be happy
> to take these patches as time allows.
> What was the reason this was sent as RFC, does something require more work?
> 
> I can't comment on io_wait_event_killable, it makes sense to me as well
> but it's probably more appropriate to send through the scheduler tree.
> 

RFC was mainly here to know if a io_wait_event_killable() would made
sense before getting the scheduler tree involved. Also as it is my first
contribution in v9fs (and fs subsystem) wanted to be sure I wasn't
missing something obvious, caching could be a complex subject to grasp.
This also comes with some drawbacks, if for example server removes a
shared file or modify a symlink the client will be desynchronized, so I
wanted first to be sure we were ok with that when using cache=loose.

I'll try to monitor the new mount API and rebase the series when that
get merged. I'll probably separate the io_wait_event_killable() in its
own patchset though.

> 
> > The third patch extends page cache usage to symlinks by allowing
> > p9_client_readlink() results to be cached. Resolving symlink is
> > apparently something done quite frequently during the build process and
> > avoiding the cost of a 9P RPC call round trip for already known symlinks
> > helps reduce the build time to 1m26.602s, outperforming the virtiofs
> > setup.
> 
> That's rather impressive!
> (I assume virtiofs does not have such negative lookup or symlink cache so
> they'll catch up soon enough if someone cares? But that's no reason to
> refuse this with cache=loose)
> 

virtiofs does have negative lookup (when used with cache=always) and
symlink caches (this serie is even quite a bit inspired by what fuse
does). I don't really know what makes virtiofs a bit slower here, I
haven't dig into it either though but won't be surprised it could easily
catch up.

> > Further investigation may be needed to address the remaining gap with
> > native build performance. Using the last two patches it appears there is
> > still a fair amount of time spent waiting for I/O, though. This could be
> > related to the two systematic RPC calls made when opening a file (one to
> > clone the fid and another one to open the file). Maybe reusing fids or
> > openned files could potentially reduce client/server transactions and
> > bring performance even closer to native levels ? But that are just
> > random thoughs I haven't dig enough yet.
> 
> Another thing I tried ages ago was making clunk asynchronous,
> but that didn't go well;
> protocol-wise clunk errors are ignored so I figured it was safe enough
> to just fire it in the background, but it caused some regressions I
> never had time to look into...
> 
> As for reusing fids, I'm not sure it's obvious because of things like
> locking that basically consider one open file = one fid;
> I think we're already re-using fids when we can, but I guess it's
> technically possible to mark a fid as shared and only clone it if an
> operation that requires an exclusive fid is done...?
> I'm not sure I want to go down that hole though, sounds like an easy way
> to mess up and give someone access to data they shouldn't be able to
> access by sharing a fid opened by another user or something more
> subtle..

Yes I gave that a bit more thinking and came up with quite the same
conclusion, I then gave up on this idea. The asynchronous clunk seems
interesting though, maybe I'll take a look into that.

Thanks for your time.

-- 
Remi
