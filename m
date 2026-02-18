Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C931A04F
	for <v9fs@lists.linux.dev>; Wed, 18 Feb 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423906; cv=none; b=bkFT4zbyOEGarQlM89IKZujpAYXZcXy00dqMfo3DZZfZB+qwcPgVj3pyjgP4ixOHW/theMzvwMIWVujnn5UEjCKz8mGqC2Gay/QZ+78g8HOpBxzzhRLwyX5k+32BeOEuj5mvWjE1TH9v84kX5r47nitXynprDGfbL7NPquh6sPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423906; c=relaxed/simple;
	bh=X9kiPCAuHQdm/91UBJm57+g7q5XHg6w+IG2hlVmJs0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWoNQ5/pBx8ZWu+9Wr9IyWhgur2JtDf+lnRq0dn6lN8VjYcRRx5Zu69J4PVBwIB8N7S1LrhYn6scFTqVbVWbLATOdqKPtva8rfaT+0++cPqGXVP7ms8q3DL7h0NJY/1Fu+GkDL4d2R1RDGnmCE0yVBVNhGX6M8U0my4L6YayKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PpsBcghY; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PpsBcghY"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3FE4E14C2D6;
	Wed, 18 Feb 2026 15:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771423896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCYt+5aTUl1GkH+5nsvDzUuajWLWjNBe95p+8PBbo9U=;
	b=PpsBcghYUn6Ghb5UxOkgSuESeHUtvKmQlYPnMXylpalRE7uyqwrN+ezmWQ+cY51gIo4MAz
	oIk6To6TXg1n4JH/k9XhJ3MtLlsPYqaWPw+dffVpG5n88LlKX+ckA018psH6L4YM1Vi7vK
	Z0dxCJtiZyDGm9Jwf/DKR7bZDb3ZniLvBREHZMf9yWqX1BniTan3vjPxuIFdpVPeLQShY2
	Xf5mQ1ZQrkaTrErt1pt1sJzME0bFp+t7eRujlbzlcoV3lVlOu9BkqjHwzh8ZPMB4zhychZ
	fLCWhmAKAiYYP1fE5XcfON6sMrYJ3fc2nZB/V3j5y6J/4Gn8OmDEGd3lmw6zdQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c654fb4a;
	Wed, 18 Feb 2026 14:11:32 +0000 (UTC)
Date: Wed, 18 Feb 2026 23:11:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Pierre Barre <pierre@barre.sh>, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback
 caching
Message-ID: <aZXIhYJ9R16EQ3Tb@codewreck.org>
References: <1642497.1771421883@warthog.procyon.org.uk>
 <20251227180137.730385-1-pierre@barre.sh>
 <1642566.1771422085@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2AH5nl5syXKjOEO"
Content-Disposition: inline
In-Reply-To: <1642566.1771422085@warthog.procyon.org.uk>


--J2AH5nl5syXKjOEO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

David Howells wrote on Wed, Feb 18, 2026 at 01:41:25PM +0000:
> > A better way is probably, in v9fs_stat2inode() and v9fs_stat2inode_dotl(), if
> > the inode isn't new, compare the values for stat->mtime to inode->i_mtime and
> > stat->length to v9inode->netfs.remote_i_size and if they differ mark the inode
> > as being remotely modified, invalidate the pagecache and reset inode->i_size.
> > 
> > If stat->mtime == inode->i_mtime and stat->length ==
> > v9inode->netfs.remote_i_size, then don't alter inode->i_size.
> 
> Also, you'd need to update remote_i_size upon successful completion of a write
> RPC call to increase it up to the end of the write.

I pointed out a couple of problems with that on IRC, so replying here
for everyone:
- for msize, it's set by the server (using server clock) anywhere
between our write request and the reply, so we can't predict it (we
could, however, remember that there's been an io or not, and if mtime
changes when there was no io we could use it to invalidate our cache or
something)
- for size, we'd need to flush (like the v1 of this patch) -- apparently
this is fs specific but it might make sense to flush unless
AT_STATX_DONT_SYNC is specified similarly to what nfs_getattr() does


This part is just me thinking out loud (not discussed properly), but I
kind of like what nfs does in fs/nfs/inode.c nfs_wcc_update_inode() and
nfs_check_inode_attributes(): if there are IOs in progress, they ignore
the server i_size:
                if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
                        cur_size = i_size_read(inode);
                        new_isize = nfs_size_to_loff_t(fattr->size);
                        if (cur_size != new_isize)
                                invalid |= NFS_INO_INVALID_SIZE;
                }

If cache is used I agree with Christian that the client can be
considered correct, but I don't like the idea that we'd never catch a
server update that happens much later, but that might need work...


Right now I'm a bit torn between "it'd be good to fix this sooner than
later" (and want to take this as a stop-gap) and "it's scary to never
notice size changes I'm sure it'll break some CI again", so since David
said he'd look some more I'm thinking of giving him a bit more time
first but if there's no clear solution emerging in a week or two let's
first get this v2 in as a first step, then we can do better as a second
iteration...


I've attached irc logs for today, if anyone wants to read up

-- 
Dominique

--J2AH5nl5syXKjOEO
Content-Type: text/plain; charset=utf-8
Content-Description: #linuxfs.26-02-18.log
Content-Disposition: attachment; filename=#linuxfs.26-02-18.log

--- Log opened Wed Feb 18 00:00:52 2026
15:09 -!- jelly is now known as Guest3038
17:48 < dhowells> Asmadeus: okay, the problem is that netfs_perform_write() moves i_size after netfs_write_folio() has sampled it
17:49 < dhowells> but I'm not sure how because both functions access i_size with the folio locked
18:04 < Asmadeus> Are you sure it's not as he said in the commit? e.g. ls triggering a stat fetch from server, and outdated server value overriding the local one
18:05 < dhowells> Asmadeus: weird - I'm seeing i_size revert somehow
18:06 < Asmadeus> v9fs_vfs_getattr() calls v9fs_stat2inode() which in turn sets i_size (v9fs_i_size_write) if not told not to
18:07 < dhowells> 9p_repro.sh-1580 : netfs_write_iter: WRITE-ITER i=d306b44 s=1e l=3 f=10
18:07 < dhowells> 9p_repro.sh-1580 : netfs_modify: i=d306b44 ix=00000 o=1e l=3
18:07 < dhowells> 9p_repro.sh-1580 : netfs_folio: i=d306b44 ix=00000-00000 mod-streamw
18:07 < dhowells> 9p_repro.sh-1580 : netfs_i_size: i=d306b44 iz=21
18:07 < dhowells> 9p_repro.sh-1582 : netfs_write_iter: WRITE-ITER i=d306b44 s=1e l=3 f=10
18:07 < dhowells> 9p_repro.sh-1582 : netfs_finfo: i=d306b44 ix=00000 dirty=1e-21
18:07 < dhowells> 9p_repro.sh-1582 : netfs_flush: i=d306b44 ix=00000 o=1e l=3
18:07 < dhowells> 9p_repro.sh-1582 : netfs_folio: i=d306b44 ix=00000-00000 flush
18:07 < dhowells> 9p_repro.sh-1582 : netfs_write: R=000001fd WRITEBACK c=00000000 i=d306b44 by=0-ffffffffffffffff
18:07 < dhowells> 9p_repro.sh-1582 : netfs_i_size: i=d306b44 iz=1e
18:07 < dhowells> 9p_repro.sh-1582 : netfs_wback: i=d306b44 ix=00000 o=1e l=3 iz=1e
18:07 < dhowells> 9p_repro.sh-1582 : netfs_folio: i=d306b44 ix=00000-00000 store
18:07 < dhowells> hmmm
18:08 < dhowells> maybe 9p is reverting the inode size?
18:08 < Asmadeus> Yes, that's what his patch prevents (if cache is enabled)
18:08 < Asmadeus> Well, v2
18:09 < dhowells> ah - there's a patch at the beginning of the message sequence - I started in the middle of it
18:10 < dhowells> I have to go out for a bit, will try that patch when I get back
18:10 < Asmadeus> I'm not sure why v1 wanted to wait (and worked), so I'm tempted to just go with v2: if cache is enabled then the client view is authoritative... But 9p doesn't have any mechanism like nfs to lease or just re-check a file after 60s, so it's pretty permanent
18:11 < Asmadeus> Ah, sorry if you hadn't seen the patch. Christian says it works so I trust his test here, mostly wanted your opinion on this -- how is netfs supposed to handle remote file changes
20:56 -!- jelly is now known as Guest3067
21:30 < dhowells> Asmadeus: the 9P write RPC call doesn't return the new file attributes, does it?
21:41 -!- Guest3067 is now known as jelly
21:51 < dhowells> Asmadeus: I think your options are a bit limited with 9P as it doesn't have any equivalent of AFS's data version or NFS's change attribute
21:51 < dhowells> if a third party change happens, you're kind of stuffed
21:53 < dhowells> I think what we need to do is, check to see whether the size differs from that which we expect (ie. ->remote_i_size)
22:03 < Asmadeus> right, write returns the amount of data written, so we can keep track of what we wrote but it doesn't tell more
22:06 < Asmadeus> I didn't remember remote_i_size, we actually set it in a couple of places... but I don't see where it's actually used?
22:10 < Asmadeus> oh, in fs/nfs/inode.c they have an interesting check: if the new_isize obtained from server is different from the cur_isize, they only update the size if !nfs_have_writebacks(inode)
22:11 < Asmadeus> Is there a way to tell if there are writebacks in progress with netfs?
22:12 < Asmadeus> It apparently just checks if there are outstanding requests (atomic_long_read(&NFS_I(inode)->nrequests) != 0)
22:13 < Asmadeus> It seems to me that if there's no outstanding request/unflushed data and size from the server doesn't match we could invalidate the cache and set the new size -- it's not perfect (won't catch in-place writes) but better than just ignoring the size
22:14 < Asmadeus> If there's unflushed data or pending writes then keeping the local size is the sane thing to do
22:38 < dhowells> Asmadeus: see the reply I just sent
22:41 < Asmadeus> We can't check mtime, it's set by the server when it processes the IO but we don't know exactly when (won't exactly match whenever we update our's)
22:42 < Asmadeus> likewise remote_i_size is the last size we got, so if we just wrote to the file it's expected to have changed?
22:43 < dhowells> by "we don't know exactly when" - do you mean you don't know at what point the server will update it or do you mean that you don't know to what the server will update it?
22:43 < dhowells> "... to what the server will set it?" I should say
22:43 < Asmadeus> we don't know to what the server will set it, right
22:44 < Asmadeus> It should set it somewhere between a write call and it's reply, but the value will be any timestamp in between
22:44 < dhowells> wrt to i_size, I sent a follow up to my reply - we'd have to update remote_i_size on completion of the write
22:44 < dhowells> of the write RPC
22:45 < dhowells> hmmm
22:45 < dhowells> so we can predict the new i_size, but not the new mtime
22:45 < Asmadeus> Well I guess we could bound it, but then there's also the can of worms of the server and client not being synchronized properly.. it'll be set at the *server time* between these two, not our's
22:45 < dhowells> however, we can note that we expect the mtime to have changed
22:46 < dhowells> and forego the check
22:46 < Asmadeus> Right we could note that we expect it to not have changed if we didn't do any IO
22:46 < Asmadeus> (and thus any change means remote got updated)
22:47 < dhowells> I presume there's no way to "compound" a status fetch with a write?
22:47 < dhowells> (like you can do in cifs and nfs3+)
22:47 < Asmadeus> For size, just updating the size when write is done might not be enough for the same reason... Picture this: write starts -> sent to server, server updates size, meanwhile we send a stat() in parallel and get updated size.. but write is not complete so remote i_size isn't updated yet
22:48 < Asmadeus> Correct, we have no compound/chained IO either
22:48 < dhowells> actually, stat() is less of a problem
22:49 < Asmadeus> I think there's no way around either serializing stat() with other IOs, or ignoring the size if there are IOs in flight like nfs does
22:49 < dhowells> unless userspace states AT_STATX_DONT_SYNC, you're going to have to flush
22:49 < iokill> 
22:51 < Asmadeus> Would a flush make any further IO wait for the stat to complete as well?
22:51 < dhowells> I suppose not
22:51 < Asmadeus> (I don't think we're flushing at all right now.. that might look like the v1)
22:52 < dhowells> no, you call filemap_fdatawrite(), but that doesn't wait
22:52 < Asmadeus>        AT_STATX_SYNC_AS_STAT
22:52 < Asmadeus>               Do whatever stat(2) does.  This is the default and is very much filesystem-specific.
22:53 < dhowells> yes - because this is a flag for statx(), not stat()
22:53 < Asmadeus> Yes, but I meant according to this there is not standard about whether we need to sync or not?
22:53 < dhowells> for stat(), correct
22:53 < Asmadeus> (although we shouldn't ignore AT_STATX_FORCE_SYNC..)
22:54 < dhowells> I think you need to call filemap_write_and_wait()
22:54 < dhowells> unless AT_STATX_DONT_SYNC is specified
22:54 < dhowells> see nfs_getattr()
22:55 < Asmadeus> So that'd be his v1 - https://lore.kernel.org/all/20251227083751.715152-1-pierre@barre.sh/T/#u
22:55 < Asmadeus> (well, it actually does both waiting and ignores the value in cached mode)
22:56 < dhowells> yeah - it needs some work, I think
22:56 < dhowells> I can have a play with it
22:57 < dhowells> give me a little while to poke at it
22:59 < Asmadeus> Sure, thanks -- I'll reply to the mail anyway with what we discussed (perhaps just quote it all as well...) for others
23:00 < Asmadeus> And I still think something like nfs update-i_size-unless-nfs_have_writebacks() might be interesting if we can do it reasonably

--J2AH5nl5syXKjOEO--
