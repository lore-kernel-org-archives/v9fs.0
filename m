Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942F11193
	for <v9fs@lists.linux.dev>; Fri, 29 Dec 2023 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="vKUKrEFz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=0JdGM6jJuWhd4OgNwIhzbS3iAHT0ym2BYm5XWSrGC4k=; b=vKUKrEFzfZNGTszCeAtOmc2IrO
	Y+Smp+D8fw8graSreouWscK7+hWuk5RDDmurncqFvyi1giP1Ox2bDFB16vsf/IgSG/J5YDeaXBY7h
	eHn9pxA2R1N5r7Y/Tm8BT7+9+5/ymfJvc8Oh75v/URADYACxGt68BnwmfWQ4hA/DET+HIkJjCYwGS
	BGjVG6NFn5LTB3kFgHhqCg1/Vg0tGiuG6UtGv1jEsrmvt3FYsRnUrqOEBH8yo4Jv3zSY6CGSZHqsa
	mM3PYOZ/+TN8uy6qcRVvjwrx3GA6W9D07z8I/4LPQJ1AVO33x5AaVZDeoNaikESxXu/tdWW91hUV6
	4PTeCE7ZdnW1rRNtghq64/kW+i8MPpf5q6aE+x4BtfOYQH1Z573AZ4tCPEt/lp6Umy/5Rlgzbk6kP
	9vfTqFwzE1OWifjAxzrtv9yf94gB9vvF27RT0YUiVkOhtSG5SVcBtjR5oL9dwKLi0SHegAfdaeXiw
	SenqAuwbakQrJ/x6HAyyWIEMb13zdITyh6IuehtfDEze0HN1rKAI9k1vIXAZso/+RCWpKl8XAsCT6
	w8yAsGYSXe8IKWzfUzIkD4KJ2cUyNw6kMbIfpzZgPY5PK1waWZseakuMIGBKO9z3Q5nYjDw5RNGlE
	eCdfP2uqPCFvFIpd213quhA9ANevNj6UCIjv3AqaM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>, asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, ericvh@gmail.com
Subject: Re: cache fixes (redux)
Date: Fri, 29 Dec 2023 13:22:45 +0100
Message-ID: <2850709.f7ZBceQk0b@silver>
In-Reply-To: <ZY3tJ0eD73Gmy_PQ@codewreck.org>
References:
 <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL> <ZY3tJ0eD73Gmy_PQ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 28, 2023 10:48:23 PM CET asmadeus@codewreck.org wrote:
> Eric Van Hensbergen wrote on Thu, Dec 28, 2023 at 09:07:46AM -0600:
> > > > qemu mixes in some bits from st_dev to avoid this:
> > > > https://gitlab.com/qemu-project/qemu/-/blob/master/hw/9pfs/9p.c?ref_type=heads#L881
> > > 
> > > Inode numbers are always just unique within the same file system. And that
> > > makes sense. If a unique file ID is required system wide, then inode number
> > > must be combined with the file system's device ID.
> > 
> > Ah, okay, good to know.  Christian do you remember anything about this
> > parallel unlink case?  Is there any special handling to guard against
> > reused inode numbers?  From the discussion this seems likely in the
> > tmpfs case.
> 
> Just to clarify: I've quoted tmpfs as a way of manually generating
> duplicates, but it still needs multiple mount points (as single tmpfs
> will still ensure uniqueness)
> e.g.
> 
> ---
> # mkdir dup
> # cd dup
> # mkdir 1 2
> # mount -t tmpfs tmpfs 1
> # mount -t tmpfs tmpfs 2
> # echo one > 1/one
> # echo second > 2/second
> # ls -li 1 2
> # ls -li 1 2
> 1:
> total 4
> 2 -rw-r--r--. 1 root root 4 Dec 29 06:10 one
> 
> 2:
> total 4
> 2 -rw-r--r--. 1 root root 7 Dec 29 06:10 second
> ---

Which is the expected, correct behaviour, as you can still distinguish the two
by their device IDs:

# stat 1/one
  File: 1/one
  Size: 4               Blocks: 8          IO Block: 4096   regular file
Device: 2dh/45d Inode: 2           Links: 1
  ...
# stat 2/second
  File: 2/second
  Size: 7               Blocks: 8          IO Block: 4096   regular file
Device: 2eh/46d Inode: 2           Links: 1
  ...

> Then export that 'dup' directory without remapping to see how it
> behaves; you'll find some weird behaviours with cached modes.
> 
> 
> I don't think we can do anything if the server sends us identical
> inodes, that's the server's job.

Right.

BTW even if qid.path length is increased as part of a 9p protocol change, it
would still be tricky for client implementation side, as that number is too
big as simply being exposed as inode number by client. IIRC virtiofsd is
handling this by automatically creating separate devices when needed. I
haven't checked how exactly, whether there is e.g. some easy way to create
"subdevices" with Linux.

> (iiuc from a networked filesystem's point of view (e.g. nfs), we ought
> to check i_ino + i_generation as inode number can be reused after the
> previous owner of the number was deleted, but we're guaranteed the
> couple change... At any given point though i_ino is unique so we've been
> relying on just that for two reasons: no room to send i_generation, and
> the field isn't easily obtainable from userspace (need to get in through
> bytes in export_to_handle_at which is file system dependant), so we only
> rely on inode number -- if the field gets bigger it should be variable
> length and we should write the whole mnt_id + export_to_handle_at
> content for a stable, truly unique handle. That's what userspace NFS
> servers do.)

Why is that? The inode number is a serial number which is consecutively
incremented:

# ls -li one
2 -rw-r--r-- 1 me  me  4 Dec 29 12:42 one
# rm one
# echo one > one
# ls -li one
3 -rw-r--r-- 1 me  me  4 Dec 29 12:55 one

So I would not expect an inode number to be reused before the consecutive
counter wraps at 2^64. And then, this discussion is about files still being
open. So host's file system can't recycle the inode number unless 9p client
closes the corresponding old FID.

> > 
> > Yeah, there's the files and then there's the inode.  So if its just a rename,
> > its likely it kept the inode, right?  I guess I should just gaze at some
> > VFS traces to understand the behavior and whether or not we need to do
> > anything from an inode/qid.path perspective.
> 
> Yes, renames won't change the inode at all (ls -i will keep the same
> number, and all props will be identical)
> 
> 
> In linux VFS speak, there's:
>  - dentries, what you called files?, pointer to an inode from
> directories; that's what get updated on renames; there can be multiple
> dentries for a single inode (hardlinks for regular files)
> We keep some fid in there for directories to walk from there as needed
> (one per uid)
> 
>  - inode numbers, that identify a given ""file"" (common speech file,
> actual data); it must not change for the lifetime of the file and there
> should be no collision
> 
> - the inode struct e.g. "file" informations (size, various times,
> i_version..) that get updated when file is modfied (rename shouldn't
> touch these either, but writes will);
> I guess with what you said there can be multiple inode structs alive for
> a given "file"? But that sounds like a bug to me, we should always reuse
> as it's also what governs the vfs cache data: at best you'll be fetching
> stats twice, at worse you'll end up with two mmap in parallel that don't
> get updated the same...
> 
> - the file struct, that'll back a fd somewhere (can be multiple fd per
> file with dup and friends); we keep the open 'fid' information around in
> the file's private data.
> 
> (I'm not 100% sure how process cwd is handled -- probably just a ref on
> the dentry? When opening a file we need to figure it out from the
> dentry, so get the parent's dentry and fids from there and use
> that parent's dentry cached fid, or build it up -- I guess if there's no
> cache file here we could do multi-level walk, but my understanding was
> that there should always be something cached at the point... Also, for
> something like ls you'll stat all files in a directory, so if there
> wasn't a cached fid for the parent's dentry you'd do a lot of
> multi-level walks, where caching the parent's dentry sound more
> efficent?)
> 
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

Yes, the cache currently just grows indefinitely. The question is what kind of
metric shall be used to decide when to start dropping old things from the
cache.

> > I have publically stated I hate the temporary file hack.  It just seems
> > awful, but I've punted this to be a server responsibility so I don't have
> > to think about it ;)  I get where it may cause trouble on a reconnect,
> > but that could be handled different ways as well, just with a lot more
> > invasiveness on the server-side (like holding on to dangling fids on 
> > unexpected disconnects) -- maybe something else to queue up for
> > future protocol revisions.
> 
> Well there's reconnect (connection troubles), and there's reconnect
> (server restart, or migration) -- in nfsv4 the server is expected to
> have some persistent states so e.g. file leases will persist, so I guess
> it would be possible to also store information for tmpfiles there too,
> but at the very least the server needs to also be able to re-open the
> file so it needs to be kept around...
> (speaking of which, I guess qemu live migration doesn't work with 9p
> mounts? or maybe just not tmpfiles... Can't say I tried...)

Right, QEMU live-migration doesn't work with 9p ATM, and probably won't in
near future.

> Anyway, we don't need to work on reconnect here, that's distinct enough
> from the problems you've seen;
> let's not worry about it at this point, and we can bring it back up
> later if/when someone has energy for it :)



