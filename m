Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF17FB
	for <v9fs@lists.linux.dev>; Thu, 28 Dec 2023 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3N5fXbNf";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DHeyV6Nh"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 34A8FC01C; Thu, 28 Dec 2023 01:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703723558; bh=qUGNisbjPFPKESTgajUbCVr5R5n0kuON1ILLZEyWqOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3N5fXbNfBgnS5uwm59SsUhYMqczbq8cn+1XuHdUcicELzzXFLp9PsArM2Ow2E6WbW
	 odNhj2U0+azc48S4UnTx+6gFOPvDo2qQl5YMoH0hgmijnilgsLhxTabUYxYThS58Sk
	 p/wIbXwqcz4nWg4g/SGmvZlOHDKSSC725n50WxKj6sYF6rMfGqlcMipG96j+/eOIP4
	 RKGQJ69nimQ8Sv9AILoOqAC3tcqtr49Ato4ciUBGutJCQomFzhUH1BHQ7vxH0aNK5s
	 8HUMfH2NvcXIerRkmKhyhUzf1U/U7xT8+cCbAhT/+touWSrzc6x6gE5nkHjAt/E8l1
	 Hum1QGubvYhvQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 2A5CAC009;
	Thu, 28 Dec 2023 01:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703723557; bh=qUGNisbjPFPKESTgajUbCVr5R5n0kuON1ILLZEyWqOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHeyV6NhHSRoBHWy6F7lHyXCeu67AGTVtLl7HU9mTsd4cAYImCa8WAcPt46NvQ11f
	 Ss9za5rFTQG9Qn5FN4g9a6omfL2gvg0JkxkT2HSJoElXROplwzwWYDcGBbDasSTRK8
	 Bvfx6IR7QmSufClxzVHulNyL9B7SPAuDumKk1fSAdg9t/0RU1YFMFDhxW9ZJoRQnJq
	 58qIIOEblbMOh72xlhsNZjPdLi6MqLs5LJUABSQGTcImbCwcjVdHADQnzASJOg5cbJ
	 J6K/p/aS5tTOxwmzNxeTRV14ehxeMH5fPE4MX318gXmKS0X8g8dq0X76KKR/9aeAr+
	 305ecLtcd2clA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 641d895b;
	Thu, 28 Dec 2023 00:32:32 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:32:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Subject: Re: cache fixes (redux)
Message-ID: <ZYzCERk_dg1-CEjb@codewreck.org>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <ZYvcBbcNOHEQ-JMw@codewreck.org>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>

Eric Van Hensbergen wrote on Wed, Dec 27, 2023 at 11:39:19AM -0600:
> On Wed, Dec 27, 2023 at 2:11 AM Dominique Martinet <asmadeus@codewreck.org>
> wrote:
> > I'm not sure multi-walk is possible in practice: even opening a file
> > directly through e.g. cat /mnt/long/path/to/file will have the VFS check
> > permissions along the path, so the VFS will need to stat all elements
> > along the way.
> 
> Well, the server will do perm checks (ideally on walks), so do we really
> have to?  Feels like overkill to check in both places, in principal we
> expect/assume server perm checks.

The server should definitely check as well, yes.
I'm not sure it's possible to tell the linux VFS that the server already
checked though; ultimately the plan back when I was working on 9p for my
previous job was to plug in MPI-IO into a user-space client library
(e.g. https://github.com/martinetd/space9 -- now unmaintained) so we
wouldn't have to deal with the vfs...

But once again, if you can manage to tell it that, I'm all for it. Some
servers might not check properly but that can/should be fixed when it
comes up.

> it did strike me that inodes are only unique per filesystem and I doubt the
> servers guarantee uniqueness across underlying mounts - but in principal we
> shouldnt have to rely on looking up inodes by qid.path anyways….however
> nothing I’m planning on should make this worse, but something to keep an
> eye out for.

We've had collisions a few times -- most "real" file systems I'm aware
of pseudo-randomize inode generation but in particular tmpfs inode
numbering is linear per mount so it's very easy to trigger collisions.

qemu mixes in some bits from st_dev to avoid this:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/9pfs/9p.c?ref_type=heads#L881


> > >      - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
> > > longer used, can these be recovered?  I was thinking of reusing one of
> > > these to mark unlinked files which we could do a more comprehensive
> > > compare for if its actually necessary.
> >
> > Since we don't support reconnects, unlinked files have been working just
> > fine with servers that keep the underlying files open (e.g. qemu)
> >
> > What's your plan exactly?
> 
> 
> See above, mark fid/qids that are unlinked with a different type I think.
> I’m gonna look at how other filesystems handle this case before doing
> anything.

local filesystems don't do anything - the inode is just kept around, all
the way down to disk afaik (disk-mapped tmpfiles flush data to disk so
there must be some way to address them...)
(The last iput with nlink==0 calls evict_inode which does required
cleanup)


NFS doesn't delete the backing file but renames it - silly renames -
you've probably seen some .nfs1234 files around if you used a mount
point, the client won't let you delete them while it's open:
rm: cannot remove '.nfs000000000000f42300000001': Device or resource busy

And it's unlinked when file is closed (DCACHE_NFSFS_RENAMED check in
nfs_dentry_iput). That's necessary because the connexion to the server
can drop at any time, and reconnecting needs to be able to open the
file again.
Servers will also scrub these files after they're been unused for a
while.


For 9p since we don't handle reconnect I think we're fine just not doing
anything -- servers that don't close backing files will de facto keep
the file existing through their fd. There's a process with the file open
so we have an open fid somewhere and the inode won't get killed either.
When the last fd is closed the inode is evicted and we'll have all fids
closed so server will release its fd as well and backing filesystem will
cleanup appropriately.

If we want to handle reconnect at some point (CEA/Bull did that work but
never tried to publish it...), then we ought to do silly renames as
well, but servers really need background cleanup as well or it'll end
up full of .nfsxxx files...


> > We don't have any way of driving protocol changes forward (and there's
> > no compatibility negotiation on client connect...), but I recall
> > Christian also was looking forward to some other changes so we might
> > want to try to move this forward again...
> >
> 
> Well, those bits unused (I think) so shouldnt be protocol change.

Right, I didn't realize it was just local use -- we can do whatever we
want in memory yes.
I'd avoid reusing the bits and define some new ones at the end of the
permissible range to make the "can come from server" and "client mess"
separation but leaving this up to you -- ultimately as long as there's
no conflict with what's on wire we should be fine.

> However we can bump to
> new protocol when necessary (9p2023?  its been 23 years, why not?). big on
> my list would be qid.path -> 128 bit and qid.version -> 128 bit and maybe
> include filesystem uid in qid to differentiate underlying mounts and maybe
> i_generation.  This would help with cache maintenance and uniqueness
> concerns.  I’m also thinking of how we might handle security differently
> (use kernel TLS, public key auth integration, etc. although those might not
> require protocol changes).  i’m also in favor of dirread senantics for
> cache modes so we retrieve attributes with the file list.  What other
> things should we be considering?  maybe time to start putting together an
> RFC.

Right; there's plenty to improve if we start...
My free time is basically rock bottom as it has been for a few years so
I probably won't help much, but I wouldn't push back.

-- 
Dominique Martinet | Asmadeus
