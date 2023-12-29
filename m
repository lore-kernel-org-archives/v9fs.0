Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37208111A4
	for <v9fs@lists.linux.dev>; Fri, 29 Dec 2023 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="f9YyANfK";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="f9YyANfK"
Received: by nautica.notk.org (Postfix, from userid 108)
	id EE2A1C009; Fri, 29 Dec 2023 13:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703854259; bh=CrW6nF4ZETsDTG1DJonoHtzsSG6nsLqzea6NtJLWgA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9YyANfKgz8TrX03/K0sgWdMZrG3+e4lzxGzer2c23EimYc5qYdYnUMNIxGLqdNeg
	 EYRJKzVOTmrnmhNQlZ2Irg1yne8qwzjKQ4cP0Zum9MDPimDUyKNoQWWucH0CN3NJFP
	 Lo5dzZHiTJ4jIgbDqGqfUR+jlqZS4aEQ4tfTI2iE//AXYEYACvkPO3Cqg9Fu2a6HB4
	 tB0tkiM01Vb9RaHA1mCO96MjZC5Di2yiQQ6h16u6b7KTnRIsd0IEoiD3AHO0FCZkPV
	 aoQ/m/tpHfCZP+avZYJ88IQVdMtbyCj7zDRflSSfN7L42uR7rikUgC1XFSqmYsiN3k
	 s85yAErV2Z3XA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id B9657C009;
	Fri, 29 Dec 2023 13:50:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703854259; bh=CrW6nF4ZETsDTG1DJonoHtzsSG6nsLqzea6NtJLWgA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9YyANfKgz8TrX03/K0sgWdMZrG3+e4lzxGzer2c23EimYc5qYdYnUMNIxGLqdNeg
	 EYRJKzVOTmrnmhNQlZ2Irg1yne8qwzjKQ4cP0Zum9MDPimDUyKNoQWWucH0CN3NJFP
	 Lo5dzZHiTJ4jIgbDqGqfUR+jlqZS4aEQ4tfTI2iE//AXYEYACvkPO3Cqg9Fu2a6HB4
	 tB0tkiM01Vb9RaHA1mCO96MjZC5Di2yiQQ6h16u6b7KTnRIsd0IEoiD3AHO0FCZkPV
	 aoQ/m/tpHfCZP+avZYJ88IQVdMtbyCj7zDRflSSfN7L42uR7rikUgC1XFSqmYsiN3k
	 s85yAErV2Z3XA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id dec55b80;
	Fri, 29 Dec 2023 12:50:54 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:50:39 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY7An6VBb0GCEMFu@codewreck.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2850709.f7ZBceQk0b@silver>

Christian Schoenebeck wrote on Fri, Dec 29, 2023 at 01:22:45PM +0100:
> Which is the expected, correct behaviour, as you can still distinguish the two
> by their device IDs:

(Yes, just meant to say one can produce collisions easily if they want)

> BTW even if qid.path length is increased as part of a 9p protocol change, it
> would still be tricky for client implementation side, as that number is too
> big as simply being exposed as inode number by client. IIRC virtiofsd is
> handling this by automatically creating separate devices when needed. I
> haven't checked how exactly, whether there is e.g. some easy way to create
> "subdevices" with Linux.

NFS also automatically creates a new mountpoint at junctions, so it's
definitely possible (fs/nfs/namespace.c):
/*      
 * nfs_d_automount - Handle crossing a mountpoint on the server
 * @path - The mountpoint
 *      
 * When we encounter a mountpoint on the server, we want to set up
 * a mountpoint on the client too, to prevent inode numbers from
 * colliding, and to allow "df" to work properly.
 * On NFSv4, we also want to allow for the fact that different
 * filesystems may be migrated to different servers in a failover
 * situation, and that different filesystems may want to use
 * different security flavours.
 */

It's not strictly needed though; in practice the vfs can handle
duplicate i_ino as long as appropriate functions are used for iget
(iget5_locked in fs/9p/vfs_inode.c); although now I'm thinking about it
that won't work for programs like tar that'll notice the inode number is
identical and consider the second file to be a hard link of the first...

I guess we could swipe it under the rug by making the inode number a
hash of everything in qid.path, and pretend collisions never happen™?


> > (iiuc from a networked filesystem's point of view (e.g. nfs), we ought
> > to check i_ino + i_generation as inode number can be reused after the
> > previous owner of the number was deleted, but we're guaranteed the
> > couple change... At any given point though i_ino is unique so we've been
> > relying on just that for two reasons: no room to send i_generation, and
> > the field isn't easily obtainable from userspace (need to get in through
> > bytes in export_to_handle_at which is file system dependant), so we only
> > rely on inode number -- if the field gets bigger it should be variable
> > length and we should write the whole mnt_id + export_to_handle_at
> > content for a stable, truly unique handle. That's what userspace NFS
> > servers do.)
> 
> Why is that? The inode number is a serial number which is consecutively
> incremented:

It's serial for tmpfs, but that's an implementation detail.
ext4 and xfs will both allocate through some larger stride.

... Actually didn't think it'd be this easy to reproduce, but ext4
reliably recyles the same inodes after unlink:
h
# touch a b c
# ls -li a b c
357 -rw-r--r--. 1 root root 0 Dec 29 21:39 a
365 -rw-r--r--. 1 root root 0 Dec 29 21:39 b
366 -rw-r--r--. 1 root root 0 Dec 29 21:39 c
# rm -f a b c
# touch new
# ls -li new
357 -rw-r--r--. 1 root root 0 Dec 29 21:40 new
# rm -f new
# touch again
# ls -li again
357 -rw-r--r--. 1 root root 0 Dec 29 21:40 again

(works even if I actually write something into the files and sync them)

> So I would not expect an inode number to be reused before the consecutive
> counter wraps at 2^64. And then, this discussion is about files still being
> open. So host's file system can't recycle the inode number unless 9p client
> closes the corresponding old FID.

If the file's still open, it's not removed from the fs -- we're
guaranted the inode won't come back yet.
For a networked file system though I was thinking of cache more than
open files, e.g. in the previous example a 9p client might think 'new'
and 'again' are the same file.
I guess it doesn't really matter since we have no cache invalidation /
refresh logic...

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

My understanding is that the vfs already can keep track of this for us.
Look at e.g. prune_icache_sb in fs/inode.c
It's called when there's memory pressure, and it'll call inode op's
evict_inode when actually freeing thing so we could close any still
remembered fid there, and I think it'd work out in general...
Except that we keep an explicit ref so it doesn't have anything to free
iirc.

Well, it's more stuff that'd need experimenting with...

-- 
Dominique Martinet | Asmadeus
