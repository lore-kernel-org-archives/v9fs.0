Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC25125BC
	for <v9fs@lists.linux.dev>; Fri, 29 Dec 2023 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnXpVm9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF20C433C8;
	Fri, 29 Dec 2023 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703865999;
	bh=KjYPf3TULfkOlrcDwAPjxBvurjvpefGvKAP9SBZIEaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnXpVm9+fte7CfYZmTvwr1qIurnm4iq2BQ8BxRxdswbrRPL/YpGJLYP6azs6nhu79
	 Ufgq/CWZ4xluaZzWbzknIL7B8OZEV+gZvY+tbNzDbEOzJyl5pCb8DcdQY67K2dyxNe
	 4pHM7pwlltujQ7adQllpyKYx2n9OeoE86FaqM3uAFjG2mHTjrhXVyezXEfPa06/c4K
	 SPNASWPSd+T7pYD1oBbsHk4J6sURvTtUa1ZjoJ6wmhbiXPeD//QTcaOLhr8L+EvYuR
	 dr+ZyRaGZ8lLkS5DnZBpw4yCI/yAKG6obCLYlScTgXHWJchbVVg8mpZWwNvHM9RQRh
	 NNeeQakMlEJSg==
Date: Fri, 29 Dec 2023 10:06:36 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: asmadeus@codewreck.org, v9fs@lists.linux.dev, ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY7ujCX6FnGq0PjC@FV7GG9FTHL>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
 <ZY3tJ0eD73Gmy_PQ@codewreck.org>
 <2850709.f7ZBceQk0b@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2850709.f7ZBceQk0b@silver>

On Fri, Dec 29, 2023 at 01:22:45PM +0100, Christian Schoenebeck wrote:
> On Thursday, December 28, 2023 10:48:23 PM CET asmadeus@codewreck.org wrote:
> > Eric Van Hensbergen wrote on Thu, Dec 28, 2023 at 09:07:46AM -0600:
> 
> BTW even if qid.path length is increased as part of a 9p protocol change, it
> would still be tricky for client implementation side, as that number is too
> big as simply being exposed as inode number by client. IIRC virtiofsd is
> handling this by automatically creating separate devices when needed. I
> haven't checked how exactly, whether there is e.g. some easy way to create
> "subdevices" with Linux.
> 

I'll have a look at this and see if there is something we can do that 
is similar with different mount points.

> > (iiuc from a networked filesystem's point of view (e.g. nfs), we ought
> > to check i_ino + i_generation as inode number can be reused after the
> > previous owner of the number was deleted, but we're guaranteed the
> > couple change... 

Current iget validation logic checks i_generation from getattr.  This was
one of the things I wasn't sure if we needed and would definitely mess
with qid lookup on our side.  This was why I was thinking if we marked
unlinked inodes in some way on the client side we'd be less likely to hit
a collision, but if the inode wasn't really released on server side (because
it was open), maybe this doesn't happen and we only have to worry about stale
inodes in cache on client that haven't been properly released.  But is that
ever a valid case? (it may be happening because of cache code being broken,
but that seems like a different case -- maybe if we see an inode lose its
last link and its not currently open we just garbage collect it?  Don't we
do that already?  I can see where this might screw up if we have multiple
instances of inode structs around, which the current code seems to gesture
towards, but I think its a bug.  I may write up some auditing checks to
look for dup inode structs and other things as part of debug.)

> > 
> > In cacheless modes we should drop dentries as soon as no file/process
> > use it, ad drop inodes as soon as there's no dentries left.
> > In cached mode we should have an extra ref to dentries (droppable on
> > memory pressure somehow -- we're not doing that correctly right now
> > afaik), that'll keep the inode alive, so we should try very hard to
> > always reuse the same inode/dentres to avoid needless lookups.
> 
> Yes, the cache currently just grows indefinitely. The question is what kind of
> metric shall be used to decide when to start dropping old things from the
> cache.
>

Some of this is to do with the fid/dentry handling though.  Fids stay in loose,
which mean dentries stay, which means inodes stay.  I think we can be a bit
more aggresive with transient fid recovery and decouple them from dentry by
attaching to inodes so we can aggresively clean up dcache if we want to without
impacting things -- this will mean less interstitial fids although transient
fids for cwd like references will exist, but we'll have one instaead of one
per path element.

I'll probably keep aggressive dentry recovery to a secondary change set since
it'll break a bunch of existing assumptions and I think that was what was
giving me trouble in my rewrite branch.
 
> > 
> > Well there's reconnect (connection troubles), and there's reconnect
> > (server restart, or migration) -- in nfsv4 the server is expected to
...
> 
> Right, QEMU live-migration doesn't work with 9p ATM, and probably won't in
> near future.
>

Yeah, I think there's a whole kettle of fish here.  I'm interested in tilting
at this windmill to support simulation checkpoint/restart cases, but I agree
its a hard problem so will hold off until this other stuff is sorted.  

	-eric
