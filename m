Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328F10A01
	for <v9fs@lists.linux.dev>; Thu, 28 Dec 2023 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Zb1cykjX";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jQeKFBCE"
Received: by nautica.notk.org (Postfix, from userid 108)
	id ACD92C01D; Thu, 28 Dec 2023 22:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703800123; bh=3DNDBmGOorDQwTyB+MEJkPAA4YtScDFMxbluvMqCfhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zb1cykjXPjgRibxyHSqUt8l3/tOltpVyp+kjbWFZkDWb4ImngRJK0g4qc4Ftt9qrR
	 MXzq5R6BT3Durq7vnJwmRIbauPjSTM0CUsDVjN1QmDXhngjrF7vOxPG6KBUbpeSm5w
	 05h+gTUPcLijG51wc8thsz/bRnajvqMwBdcRWYJPFSnMmMXutRe+bvCj/tXRv72xlK
	 mlFW3PRCoWP3pxIABEcfTy2j/70mq9TfRsrtKkbhVO3GDfRko/8fN44/FWYV9lWIPu
	 uKlxGjcTwNYlQmkN7Q8KCEpn/PScrKFEYeB2JbPWYU1/80K4ALSaDxKvkHN25U3c9N
	 ku8COWg5lnkxQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 51875C009;
	Thu, 28 Dec 2023 22:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703800122; bh=3DNDBmGOorDQwTyB+MEJkPAA4YtScDFMxbluvMqCfhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQeKFBCEJg2yrXs5iL0e8OPL7v8VJ0bMPHgeNbvGa+0fgLEFmFBHEwP18DYhS6JCP
	 wwvd6kibPiU4tsNev11nOumuF050bDpalG232AxihgyD1/NOZvjQICaaT6caP2y4Df
	 q+ZthmilPal+hZljOvMmWl3jhz/xQhTqgIjkwpQ6gzAzfIoCIOvGof2zs4jtg828IJ
	 9ChWRzdaUj6uFlRI+t9ZfJTTEHRpuWLzfkCR/14orXkCIyh9Xj+o/TX8TUOLkbXrZn
	 ugxgpLdRm9piptj0V74k1EiDyn1LwyzQqcfbNW+75HtZSvVHcfId6lnxkfQ32Ltycb
	 ndeRs1i93vIEg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 3654a994;
	Thu, 28 Dec 2023 21:48:38 +0000 (UTC)
Date: Fri, 29 Dec 2023 06:48:23 +0900
From: asmadeus@codewreck.org
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY3tJ0eD73Gmy_PQ@codewreck.org>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
 <ZYzCERk_dg1-CEjb@codewreck.org>
 <3936280.6WX1Z9CqS8@silver>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>

Eric Van Hensbergen wrote on Thu, Dec 28, 2023 at 09:07:46AM -0600:
> > > qemu mixes in some bits from st_dev to avoid this:
> > > https://gitlab.com/qemu-project/qemu/-/blob/master/hw/9pfs/9p.c?ref_type=heads#L881
> > 
> > Inode numbers are always just unique within the same file system. And that
> > makes sense. If a unique file ID is required system wide, then inode number
> > must be combined with the file system's device ID.
> 
> Ah, okay, good to know.  Christian do you remember anything about this
> parallel unlink case?  Is there any special handling to guard against
> reused inode numbers?  From the discussion this seems likely in the
> tmpfs case.

Just to clarify: I've quoted tmpfs as a way of manually generating
duplicates, but it still needs multiple mount points (as single tmpfs
will still ensure uniqueness)
e.g.

---
# mkdir dup
# cd dup
# mkdir 1 2
# mount -t tmpfs tmpfs 1
# mount -t tmpfs tmpfs 2
# echo one > 1/one
# echo second > 2/second
# ls -li 1 2
# ls -li 1 2
1:
total 4
2 -rw-r--r--. 1 root root 4 Dec 29 06:10 one

2:
total 4
2 -rw-r--r--. 1 root root 7 Dec 29 06:10 second
---

Then export that 'dup' directory without remapping to see how it
behaves; you'll find some weird behaviours with cached modes.


I don't think we can do anything if the server sends us identical
inodes, that's the server's job.

(iiuc from a networked filesystem's point of view (e.g. nfs), we ought
to check i_ino + i_generation as inode number can be reused after the
previous owner of the number was deleted, but we're guaranteed the
couple change... At any given point though i_ino is unique so we've been
relying on just that for two reasons: no room to send i_generation, and
the field isn't easily obtainable from userspace (need to get in through
bytes in export_to_handle_at which is file system dependant), so we only
rely on inode number -- if the field gets bigger it should be variable
length and we should write the whole mnt_id + export_to_handle_at
content for a stable, truly unique handle. That's what userspace NFS
servers do.)
> 
> Yeah, there's the files and then there's the inode.  So if its just a rename,
> its likely it kept the inode, right?  I guess I should just gaze at some
> VFS traces to understand the behavior and whether or not we need to do
> anything from an inode/qid.path perspective.

Yes, renames won't change the inode at all (ls -i will keep the same
number, and all props will be identical)


In linux VFS speak, there's:
 - dentries, what you called files?, pointer to an inode from
directories; that's what get updated on renames; there can be multiple
dentries for a single inode (hardlinks for regular files)
We keep some fid in there for directories to walk from there as needed
(one per uid)

 - inode numbers, that identify a given ""file"" (common speech file,
actual data); it must not change for the lifetime of the file and there
should be no collision

- the inode struct e.g. "file" informations (size, various times,
i_version..) that get updated when file is modfied (rename shouldn't
touch these either, but writes will);
I guess with what you said there can be multiple inode structs alive for
a given "file"? But that sounds like a bug to me, we should always reuse
as it's also what governs the vfs cache data: at best you'll be fetching
stats twice, at worse you'll end up with two mmap in parallel that don't
get updated the same...

- the file struct, that'll back a fd somewhere (can be multiple fd per
file with dup and friends); we keep the open 'fid' information around in
the file's private data.

(I'm not 100% sure how process cwd is handled -- probably just a ref on
the dentry? When opening a file we need to figure it out from the
dentry, so get the parent's dentry and fids from there and use
that parent's dentry cached fid, or build it up -- I guess if there's no
cache file here we could do multi-level walk, but my understanding was
that there should always be something cached at the point... Also, for
something like ls you'll stat all files in a directory, so if there
wasn't a cached fid for the parent's dentry you'd do a lot of
multi-level walks, where caching the parent's dentry sound more
efficent?)


So to recap there should only be one inode, then as many dentries as
there are paths to it, and as many files as there are "open handles" to
it

In cacheless modes we should drop dentries as soon as no file/process
use it, ad drop inodes as soon as there's no dentries left.
In cached mode we should have an extra ref to dentries (droppable on
memory pressure somehow -- we're not doing that correctly right now
afaik), that'll keep the inode alive, so we should try very hard to
always reuse the same inode/dentres to avoid needless lookups.

> I have publically stated I hate the temporary file hack.  It just seems
> awful, but I've punted this to be a server responsibility so I don't have
> to think about it ;)  I get where it may cause trouble on a reconnect,
> but that could be handled different ways as well, just with a lot more
> invasiveness on the server-side (like holding on to dangling fids on 
> unexpected disconnects) -- maybe something else to queue up for
> future protocol revisions.

Well there's reconnect (connection troubles), and there's reconnect
(server restart, or migration) -- in nfsv4 the server is expected to
have some persistent states so e.g. file leases will persist, so I guess
it would be possible to also store information for tmpfiles there too,
but at the very least the server needs to also be able to re-open the
file so it needs to be kept around...
(speaking of which, I guess qemu live migration doesn't work with 9p
mounts? or maybe just not tmpfiles... Can't say I tried...)

Anyway, we don't need to work on reconnect here, that's distinct enough
from the problems you've seen;
let's not worry about it at this point, and we can bring it back up
later if/when someone has energy for it :)

-- 
Dominique Martinet | Asmadeus
