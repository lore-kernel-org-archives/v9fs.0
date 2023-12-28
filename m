Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10BF4E9
	for <v9fs@lists.linux.dev>; Thu, 28 Dec 2023 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuvedcDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050C2C433C7;
	Thu, 28 Dec 2023 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703776069;
	bh=rpqAdqL690NqMs3qf6XvB4BKDcqQv755JZoD3Ziptt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuvedcDRSVvRezh2bGEENSMiUUToU5Ld55afZQIcZX6oTtLYmyVCo/nBhGYK7rKyG
	 TOTuZyZ6sDVq/LF2qyhD7JdEoKx/VHPp4tszy0ziKG13fDZcX1qnup4KX6jcu6u1+L
	 QFi5RahnlvZnL6rhXF36ej886jp40bMvbDTvBb6l3vTpwCy7qSLJLmkwVkSntex1W8
	 322fBHOHUN2MrmoLZcZLyWPnitatr3+QsEBKepUb4Sm7yEvv+lVTHbE7Xa3CSzT/HB
	 bf6W5T7tNECehaZIUumildvjHCQLPYkWmnyAerqloAljqzxXpnxXTnzkM+s5VpwsVt
	 vjLnIQJfvbqPw==
Date: Thu, 28 Dec 2023 09:07:46 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, asmadeus@codewreck.org, ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
 <ZYzCERk_dg1-CEjb@codewreck.org>
 <3936280.6WX1Z9CqS8@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3936280.6WX1Z9CqS8@silver>

On Thu, Dec 28, 2023 at 11:44:32AM +0100, Christian Schoenebeck wrote:
> On Thursday, December 28, 2023 1:32:17 AM CET Dominique Martinet wrote:
> > Eric Van Hensbergen wrote on Wed, Dec 27, 2023 at 11:39:19AM -0600:
> > > 
> > > Well, the server will do perm checks (ideally on walks), so do we really
> > > have to?  Feels like overkill to check in both places, in principal we
> > > expect/assume server perm checks.
> > 
> > The server should definitely check as well, yes.
> 
> I would rather see this as a brave kernel option for people who really know
> what they are doing, not as a potential default behaviour.
> 

Likely exposed first as one of the many cache options, but yes - I was
planning on potentially guarding this initially -- although as Dominique 
says the VFS may be doing checking regardless of what we do in v9fs and 
based on the protocol traces I was looking at before it seems we were likely
doing duplicate checks (or at the very least duplicate getattrs) and getting
rid of those is a bug fix not a feature change.  So I'm going to proceed
carefully and will post diffs on protocol traces.

> With QEMU there are two distinct behaviours: 'passthrough' permissions vs.
> 'mapped(-*)' permissions:
> 
>   https://wiki.qemu.org/Documentation/9psetup#Starting_the_Guest_directly
> 
> Where 'passthrough' means guest sees the exact same permissions for files as
> host (9p server) does. In this mode you could probably leave it to server
> doing the permission checks. However 'passthrough' mode is discouraged for
> security reasons, and one of the 'mapped' permissions modes is recommended
> instead, because we had several security issues in the past which showed that
> it's not a good idea using 'passthrough' (whereas 'mapped' was unaffected).
> 
> With 'mapped-(*)' however guest should do permissions checks. Because in this
> mode file permissions on host are different and separately handled between
> host and guest. So host sees something else than guest does.
> 

I think we've had this discussion before, but relying on the client to do
permission checks for the server sounds like a very dangerous behavior from
a security perspective.  If the server is configured for some form of mapped
mode then the server should be responsible for checking those semantics to
protect from a compromised client.  This is probably even more the case in 
a hosted guest environment.  In any case, the main point kicking off this 
thread was vfs_lookup cases where we are doing multi-walk -- I expect VFS
is still going to do double checks on any sort of transactions on the files
themselves so while I suppose it opens the window up to a traversal bypassing
a directory which doesn't have x permissions, that seems like a corner case.
Besides which, as per the previous paragraph, I think VFS is going to do 
the checks anyways and we were just doing duplicate checks so shouldn't be
a problem.


> > 
> > qemu mixes in some bits from st_dev to avoid this:
> > https://gitlab.com/qemu-project/qemu/-/blob/master/hw/9pfs/9p.c?ref_type=heads#L881
> 
> Inode numbers are always just unique within the same file system. And that
> makes sense. If a unique file ID is required system wide, then inode number
> must be combined with the file system's device ID.
> 

Ah, okay, good to know.  Christian do you remember anything about this
parallel unlink case?  Is there any special handling to guard against
reused inode numbers?  From the discussion this seems likely in the
tmpfs case.

> > > > >      - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
> > > > > longer used, can these be recovered?  I was thinking of reusing one of
> > > > > these to mark unlinked files which we could do a more comprehensive
> > > > > compare for if its actually necessary.
> > > >
> > > See above, mark fid/qids that are unlinked with a different type I think.
> > > I´m gonna look at how other filesystems handle this case before doing
> > > anything.
> > 
> > local filesystems don't do anything - the inode is just kept around, all
> > the way down to disk afaik (disk-mapped tmpfiles flush data to disk so
> > there must be some way to address them...)
> > (The last iput with nlink==0 calls evict_inode which does required
> > cleanup)
> > 
> > 
> > NFS doesn't delete the backing file but renames it - silly renames -
> > you've probably seen some .nfs1234 files around if you used a mount
> > point, the client won't let you delete them while it's open:
> > rm: cannot remove '.nfs000000000000f42300000001': Device or resource busy
> > 
> > And it's unlinked when file is closed (DCACHE_NFSFS_RENAMED check in
> > nfs_dentry_iput). That's necessary because the connexion to the server
> > can drop at any time, and reconnecting needs to be able to open the
> > file again.
> > Servers will also scrub these files after they're been unused for a
> > while.
> >

Yeah, there's the files and then there's the inode.  So if its just a rename,
its likely it kept the inode, right?  I guess I should just gaze at some
VFS traces to understand the behavior and whether or not we need to do
anything from an inode/qid.path perspective.

I have publically stated I hate the temporary file hack.  It just seems
awful, but I've punted this to be a server responsibility so I don't have
to think about it ;)  I get where it may cause trouble on a reconnect,
but that could be handled different ways as well, just with a lot more
invasiveness on the server-side (like holding on to dangling fids on 
unexpected disconnects) -- maybe something else to queue up for
future protocol revisions.
 
> 
> I use to gather ideas for 9p protocol changes here:
> https://wiki.qemu.org/Documentation/9p#Protocol_Plans
> 
> One thing that comes to my mind that's not yet on that list: server side push
> notifications, e.g. to inform guest that something changed on a file/dir guest
> currently keeps open. That might improve consistency when both on host and
> guest changes are made and caching being used by guest.
>

Yes, that list largely seems in line with mine except for adding the error
attribute on Rread/Rwrite -- that one maybe needs some discussion.  I do agree
that looking into server-push or some other notification method would be good
to add to the protocol. 

         -eric

