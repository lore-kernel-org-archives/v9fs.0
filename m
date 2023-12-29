Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99379125B5
	for <v9fs@lists.linux.dev>; Fri, 29 Dec 2023 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7nVZdoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4AC433C7;
	Fri, 29 Dec 2023 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703865011;
	bh=mK7AmOK13HQf/uUKsVwKz5961/E+nFgwg8waGEGQLXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7nVZdoAwM8MHCCtvT53uiRKu+h6Gm019m3ajMj5n0c2HWq6IJ/VYz9D05nuWTuzN
	 jcvmsIP5NU9/Ivo77R+BBhjwxrYzASGO0RSFLg+yDlXKg9EApkMHXsiu35aivGz6dd
	 tA5tQ8OVVfqetIxaJTf1yXhEQtY7y/NpWiGG/OKqZthzH+5R+/FlpATwWWyGASyHZG
	 gu2A79juwAcr5w9iMbTzaFXiE+us780eik6IInBOlwmOrqYMHkEFmV9AVRww9VY0YE
	 zmeL/cWY24opWVgGRn309fpKvLrwxZMNxi9Y2mzdW2lhy4+36UrSiqDRieW8xQ/Bn0
	 vM11bJYJLkmnA==
Date: Fri, 29 Dec 2023 09:50:07 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY7qr1Dy_aS716dC@FV7GG9FTHL>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
 <ZYzCERk_dg1-CEjb@codewreck.org>
 <3936280.6WX1Z9CqS8@silver>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
 <ZY3tJ0eD73Gmy_PQ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY3tJ0eD73Gmy_PQ@codewreck.org>

On Fri, Dec 29, 2023 at 06:48:23AM +0900, asmadeus@codewreck.org wrote:
> Eric Van Hensbergen wrote on Thu, Dec 28, 2023 at 09:07:46AM -0600:
> 
> - the file struct, that'll back a fd somewhere (can be multiple fd per
> file with dup and friends); we keep the open 'fid' information around in
> the file's private data.
> 
> (I'm not 100% sure how process cwd is handled -- probably just a ref on
> the dentry? When opening a file we need to figure it out from the
> dentry, so get the parent's dentry and fids from there 

This was why I originally hooked transient fids up to dentries, because it
seemed like that was what was holding the open reference.  Of course,
every dentry points to an inode so either work for these purposes, but
I wanted to clunk transient fids on dentry release versus wait for inode
release (which can take a while, particularly when caching).

In the cache re-write I was looking at moving all fid management to inode, 
but clunking transient fids inodes lose all dentry references.  I need to go
back over the patches but I think I still had a clever way of linking 
transient fids to particular dentries so that the tracking worked as
expected.

>
> that parent's dentry cached fid, or build it up -- I guess if there's no
> cache file here we could do multi-level walk, but my understanding was
> that there should always be something cached at the point... 
>

The concern I have in the back of my head is a detached hierarchy where
we have a reference to the directory at the top of that hierarchy but
not all the way back to the mount point.  In that situation, we can't
multiwalk all the way from root, which was the logic behind the step by
step d_parent walk until we find a fid.  But I think that's the exception
case that has become the only case because of the structure of the code,
I think if we can't find a usable fid off of the d_parent, we try multi-walk
from root and if that fails we do the step-by-step.  To be clear, I'm not
even sure how often this would every happen (when we don't have a valid
d_parent with a fid, I don't think that happens at all in practice in cache
mode but we are hanging on to way too many fids in cache mode, so maybe it
should occur more than it does....)

>
> something like ls you'll stat all files in a directory, so if there
> wasn't a cached fid for the parent's dentry you'd do a lot of
> multi-level walks, where caching the parent's dentry sound more
> efficent?)
> 

yes, and I think this is what Ron was seeing recently -- although this
was without any cache mode.

> 
> So to recap there should only be one inode, then as many dentries as
> there are paths to it, and as many files as there are "open handles" to
> it
> 
> In cacheless modes we should drop dentries as soon as no file/process
> use it, ad drop inodes as soon as there's no dentries left.
> In cached mode we should have an extra ref to dentries (droppable on
> memory pressure somehow -- we're not doing that correctly right now
> afaik), that'll keep the inode alive, so we should try very hard to
> always reuse the same inode/dentres to avoid needless lookups.
>

I'm not convinced of the second part, I think we don't want to hold the
extra ref to dentries because that causes fid explosion.  Inodes can be
kept alive without a dentry (but we do need to be able to lookup an inode
by i_no / qid.path -- which we are able to do).  There's another thing which
has bugged me looking through the code - there's lots of code (lookup, create,
open, link, etc.) which passes inode *parent which we only use for session 
information, but really that should be fine as a start-point for finding the 
parent fid versus doing a d_parent traversal.

Then for refresh logic we have inode_revalidate which can do different
things depending on cache policy:
   - cacheless - release immediately, clunk all fids (this assumes the
	mountpoint inode will have a reference as long as we are mounted,
	but I think that is correct
   - data/dir cache - same semantics as now, inode holds data cache, all good
   - policy differences: (which will trigger on inode_revalidate/refresh)
	- none: always call walk/getattr to revalidate inode from server
	  (the combo of walk/getattr may be a good new compount proto element)
	- loose: same as current semantics, keep around forever if we can,
		always assume client side cache is correct.
	- tight: use qid.version from walk/re-walk to validate, and getattr
		if stale.
	- temporal: cache times out after a mount configured timeo and we call
		getattr
	- push(future): use a subscription method to get updates on cache
		invalidations from server.

       -eric
 
