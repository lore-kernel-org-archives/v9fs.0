Received: from e3i214.smtp2go.com (e3i214.smtp2go.com [158.120.84.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BA308F26
	for <v9fs@lists.linux.dev>; Wed,  4 Mar 2026 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614787; cv=none; b=VrTed2mkRZbDmudlU01WIHffVZfTc4GTP2fbhNkPqdVp2sQx68+QRMc2v2SGjdzKwewGOyYfjPIK/AauzAKWl6tzv9kibFmLxLCeo53esep3XPkD04pt9nXBTJV/bv4CNqQZbnXfUpw86li9LLjtAR6A5fz7Tq3jkZM3UJGC+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614787; c=relaxed/simple;
	bh=s3YTevfNULOu7OTTUNNxgQc2Xj3CV6y1o+18YQgmD7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pshleW0txMBzhz86V56vfuCmkS4tcAPCweh0LYQrV9KowfhVwI5mdWbZOagVCgqz1DqHRBP/idMFsTT7X4xfOlgcapDXkftL65MgTcNSMXYgMOyUrlahBaC5ezUGSFMfbodOf3uOTHO/yv1kBC/pN9crvQMA8mxOGKpQuP0I7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=c7wejUds; arc=none smtp.client-ip=158.120.84.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="c7wejUds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772613876; h=from : subject
 : to : message-id : date;
 bh=xbrA9YZeGMtG25RjPVPDTCWMxFBr6tAPEzmQlhLARLA=;
 b=c7wejUdsFb5tlryCAooA1oXANxkA5oCOqkZHNXVqFEMRQeA7qiWHZ2Hvss1Ne/jWQPxxP
 Ga/UuaQm1F/Kt8k0pycf5UOAInNNybuorAm7dCAjkmwcMcgSslCAL/Uy2mPbvW0bUTm1ynv
 vcspt4YILjw+RbmwjgrjvD2PP+QOPFpki0uph103PxAwacVPtPcnqkQ/ZZom142w4FnIUZ0
 tt3oC+Rs0NZwTUR7joZjHGjN+V/vrL9I6sHqcj5bhYIp90oLM3cbY3kADKkVIMMj1i+rdGn
 T0sZCJ5zNftgphHGIV9Aa/OnsZHcxrdun9lTE0hqYRY0xofPp2FexT8OBoJg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vxhqL-4o5NDgroe1r-qrjL;
	Wed, 04 Mar 2026 08:44:33 +0000
Date: Wed, 4 Mar 2026 09:25:27 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache
 retention
Message-ID: <aafsd7ScsUFs7xhp@pilgrim>
References: <cover.1772178819.git.repk@triplefau.lt>
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
 <4490625.ejJDZkT8p0@weasel>
 <aadWf2Ox2YXdy0Yl@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aadWf2Ox2YXdy0Yl@codewreck.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sdCwzjTJ0C
X-smtpcorp-track: P2zw2yiglxhs.DqfXoQ4BiRrr.XboJWACNq4i

On Wed, Mar 04, 2026 at 06:45:35AM +0900, Dominique Martinet wrote:
> Christian Schoenebeck wrote on Tue, Mar 03, 2026 at 03:53:47PM +0100:
> > > +	fsparam_string	("source",		Opt_source),
> > > +	fsparam_u32hex	("debug",		Opt_debug),
> > > +	fsparam_uid	("dfltuid",		Opt_dfltuid),
> > > +	fsparam_gid	("dfltgid",		Opt_dfltgid),
> > > +	fsparam_u32	("afid",		Opt_afid),
> > > +	fsparam_string	("uname",		Opt_uname),
> > > +	fsparam_string	("aname",		Opt_remotename),
> > > +	fsparam_flag	("nodevmap",		Opt_nodevmap),
> > > +	fsparam_flag	("noxattr",		Opt_noxattr),
> > > +	fsparam_flag	("directio",		Opt_directio),
> > > +	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
> > > +	fsparam_string	("cache",		Opt_cache),
> > > +	fsparam_string	("cachetag",		Opt_cachetag),
> > > +	fsparam_string	("access",		Opt_access),
> > > +	fsparam_flag	("posixacl",		Opt_posixacl),
> > > +	fsparam_u32	("locktimeout",		Opt_locktimeout),
> > > +	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
> > > +	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),
> > 
> > That double entry is surprising. So this mount option is supposed to be used
> > like ndentrycache=n for a specific timeout value (in ms) and just ndentrycache
> > (without any assignment) for infinite timeout. That's a bit weird.

Yes I have seen this used in several other fs (see init_itable mount
option for ext4fs or compress one for btrfs). I do agree that is a bit
weird but this allow the whole 32bit range for timeout.

> 
> Could make it a s32 and say <0 means infinite? I think we have that
> somewhere

I did that on previous version, but was afraid that ~20days timeout max
value may be too restrictive?

I do agree that this is a bit odd though and if you both think s32 is
better that is fine with me.

> 
> > Documentation/filesystems/9p.rst should be updated as well BTW.
> > 
> > Nevertheless, like mentioned before, I really think the string "timeout"
> > should be used, at least in a user visible mount option. Keep in mind that
> > timeouts are a common issue to look at, so it is common to just grep for
> > "timeout" in a code base or documentation. An abbrevation like "tmo" or
> > leaving it out entirely is for me therefore IMHO inappropriate.
> > 
> > You found "ndentrycachetimeout" too horribly long, or was that again just
> > motivated by the code indention below? I personally find those indention
> > alignments completely irrelevant, not sure how Dominique sees that.
> > Personally I avoid them, as they cost unnecessary time on git blame.
> 
> I rarely use blame at all and it's possible to ignore whitespaces for
> blame, but I'd tend to agree here, I don't care if this stays aligned.
> 
> OTOH ndentrycachetimeout as a mount option is a mouthful,
> negativetimeout or negtimeout sounds clear enough to me?
> I can't think of anything else that'd be negative related
> to timeouts, but perhaps it's the lack of sleep speaking

No strong opinion on the option name though so any name that suits you
is alse fine by me.

-- 
Remi
