Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C41D522
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="mRhRPQNC";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KXY2/Q37"
Received: by nautica.notk.org (Postfix, from userid 108)
	id C137FC009; Wed,  3 Jan 2024 21:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704313501; bh=zSdf1Vj4knMfrwKq9wtCOsWdK352FjF6DaVYlhCr9fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mRhRPQNCQ4Ms3HmRqHe7L9jhHPQudrKdboEZ0aVNLTwfnbjSyyg0yylX0XFOi4c/N
	 WlG6vfzG5KbyzvDdKGlzcYs1yLrqoRtd2ifFf72PiSfBe/sXNiIhPWkvG3p/YI3Ah5
	 eikK8XHnvwMcnESAQ525iGCi0VgoFkBtUsbbUFy1Levv9h0mCqs/9QWTzJw7vEftrv
	 swwnGjkFfHFYEB1L0mlV16yPnMkR1fOeximVmZH9bNNvXEeR57A9ra1kcdUDwzUPW3
	 b/PPmob8XWLwruxQARiq8q+CRBdMeL+jwllfQOBVqZQArFUIIpk0ll2pU1Fs683CXT
	 ivrG8rAaVuMHw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 44667C009;
	Wed,  3 Jan 2024 21:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704313500; bh=zSdf1Vj4knMfrwKq9wtCOsWdK352FjF6DaVYlhCr9fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KXY2/Q37+BJUMf00BP5PYseqxOH3DnHbsns+pFHq9c35t81Je/o17j+eES61cmGvd
	 DDjn/sKxRTPdUz37pkCAPKzKE8XMpZADuW0wWt+rH+bjhnQ22KK8iK/+2Mo9X2dWDU
	 D2C/1VasoaF+tJaTaLSiryQgAc8qQA5JlRwwBOfECyH9iUdbmA1qxVt70ZhVh5uojq
	 u1a4558HEA+nqhlj6lBotWSQjU8bprujwQTvEjrBbwxu0omRBZSWF7y209xPlqBb7d
	 fBxPWl8EG1zObqfaHGorh6E8OUJnN1h5M50eeD0MKM+w7rKDeyvmLnGmxaopZzV5kr
	 k83zwxMauSApQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 0fe95bd9;
	Wed, 3 Jan 2024 20:24:56 +0000 (UTC)
Date: Thu, 4 Jan 2024 05:24:41 +0900
From: asmadeus@codewreck.org
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZZXCiSlrAMI5sMr3@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZWi6fbgy8oGwR1D@FV7GG9FTHL>
 <ZY7qr1Dy_aS716dC@FV7GG9FTHL>

Eric Van Hensbergen wrote on Fri, Dec 29, 2023 at 09:50:07AM -0600:
> > So to recap there should only be one inode, then as many dentries as
> > there are paths to it, and as many files as there are "open handles" to
> > it
> > 
> > In cacheless modes we should drop dentries as soon as no file/process
> > use it, ad drop inodes as soon as there's no dentries left.
> > In cached mode we should have an extra ref to dentries (droppable on
> > memory pressure somehow -- we're not doing that correctly right now
> > afaik), that'll keep the inode alive, so we should try very hard to
> > always reuse the same inode/dentres to avoid needless lookups.
> >
> 
> I'm not convinced of the second part, I think we don't want to hold the
> extra ref to dentries because that causes fid explosion.

(Note: no longer relevant if we get rid of fid lookup by dentry)

Might have the wrong word -- we don't want to prevent the vfs from
cleaning up if there's cache pressure, but we need to differentiate
cacheless (drop the inode as soon as it's no longer used) and cache
(keep it around while it's here)

It definitely causes total fids open to rise (which can be a probem
depending on the server), I guess we could count how many there are and
have a watermark to start reclaiming if too many are around as an
option, but I've sort of given up on that at this point...

> There's another thing which has bugged me looking through the code -
> there's lots of code (lookup, create, open, link, etc.) which passes
> inode *parent which we only use for session information, but really
> that should be fine as a start-point for finding the parent fid versus
> doing a d_parent traversal.

That makes sense, I sort of assumed we didn't have the parent's inode
but looking back we seem to always have an inode *dir..
Would be great to get rid of this dentry fid cache.

(Note the dentry will still be kept around by the vfs anyway, but we
don't care about that anymore if it doesn't hold fids)

> Then for refresh logic we have inode_revalidate which can do different
> things depending on cache policy:
>    - cacheless - release immediately, clunk all fids (this assumes the
> 	mountpoint inode will have a reference as long as we are mounted,
> 	but I think that is correct
>    - data/dir cache - same semantics as now, inode holds data cache, all good
>    - policy differences: (which will trigger on inode_revalidate/refresh)
> 	- none: always call walk/getattr to revalidate inode from server
> 	  (the combo of walk/getattr may be a good new compount proto element)
> 	- loose: same as current semantics, keep around forever if we can,
> 		always assume client side cache is correct.
> 	- tight: use qid.version from walk/re-walk to validate, and getattr
> 		if stale.
> 	- temporal: cache times out after a mount configured timeo and we call
> 		getattr
> 	- push(future): use a subscription method to get updates on cache
> 		invalidations from server.

Sounds good.


Also I need to correct one point I said in this thread: I had assumed
creat+unlink worked, but something as simple as fstat on the unlinked
file doesn't work in cacheless mode:
---
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
	int fd;
	struct stat statbuf;

	fd = open("test_unlink_stat", O_CREAT|O_RDWR, 0600);
	if (fd < 0) {
		perror("open");
		return 1;
	}
	if (unlink("test_unlink_stat") < 0) {
		perror("unlink");
		return 2;
	}
	write(fd, "data\n", 5);
	if (fstat(fd, &statbuf) < 0) {
		perror("fstat");
		return 3;
	}
	printf("stat ok, size %zd\n", statbuf.st_size);
	return 0;
}
---

Perhaps that'll just start working with your fixes but either way it's
already not working cacheless, so I don't think you need to worry about
that at this point...

(I noticed because I finally took the time to boot a debian on 9p
rootfs, and apt breaks without this -- works fine with caches)


Eric Van Hensbergen wrote on Wed, Jan 03, 2024 at 12:09:45PM -0600:
> Okay, been delving through this code.  Most (all?) was added by
> Aneesh when he did the cache stuff and I clearly wasn't paying
> close attention a decade ago (mostly because I didn't care about
> the cache then).  In any case, I think there is a ton of code
> I am going to be able to delete (patches coming soon), but wanted
> to sanity check one thing with you folks.

Good work!

> Looking at the inode get code (which also doubles as inode creation
> code).  The inodes are hashed with qid2ino(qid) which I get to take
> the blame for because its been there for 18th years.
> If the size of the inode_tt is 64-bit, it just
> assigns the qid->path+2 (+2?)

hm, inode 1 is definitely usable (a tmpfs' root directory uses it), but
perhaps 0 would caus problems?
In which case +1 makes sense if qid->path can be 0, or +2 if it could be
-1 (I wouldn't put it past some servers); but I can only guess.

> to the i_ino.  If not (presumably for 32 bit)

I had assumed the conversion to inode64 was done in practice but the
struct inode's i_ino is still an unsigned long... Although kstat's ino
field is u64 so if userspace is willing to handle it we could just bump
the size.

I remember having troubles with 64 bit inodes on 32 bit binaries quite a
few years ago so I guess we still need to do that dance -- although not
necessarily internally; we could emulate xfs here:
 - they use xfs_ino_t internally which is unsigned long long (u64);
there's even a confusingly named i_ino in xfs_inode so the inode's
struct i_ino is actually never used as far as I can see
 - there are inode32/inode64 mount option to force allocating inodes in
the 32 bit range if requested (but doesn't try to remap existing inodes,
this is just for new files)

In our case we could add a 64bit inode field in v9fs_inode so we don't
need to worry about it, and remap for kstat (v9fs_vfs_getattr*) if a new
inode32 mount option is requested?

I wouldn't do it by default on 32 bit systems as that'll blow up, and
hopefully by now any userspace that'll upgrade their kernel will have
long converted to _FILE_OFFSET_BITS=64 (which also controls 64bit inode
for stat's st_ino)

> it sets the inode to (qid->path+2) ^ (qid->path+2 >> 32).

(Seems a bit simplistic but probably good enough in practice...)


> If ino_t goes to 64 bit this means we reduce precision for no reason,
> so that has to be fixed -- but I'm trying to remember the relevance
> of +2 which dates back all the way to the original submission.  I
> don't remember why we did this, but I think I'm gonna kill that in
> one patch and in a second patch fix the length check.

Unfortunately cannot help as my involvement started much later..

> Moving up the stack a bit, we use the modified qid.path to hash the
> inode, but then we also assign it (overriding the allocated inode number
> on the client).  I'm gonna say this is wrong (definitely wrong in the
> case where we are allocated inodes willy-nilly) and we should probably
> continue to use qid.path to hash, but then keep the client side inode
> number which is guarenteed unique on allocation.  Or do you folks think
> we should align client-side inode with server-side inode to help with
> debug?  We should still have consistent qid->paths regardless.  Thoughts?

I ended up suggesting something similar above without reading this
properly, if I read this correctly I think we agree -- use as much bits
as we can internally and keep it coherent, then just downsize for
getattr if required.

-- 
Dominique Martinet | Asmadeus
