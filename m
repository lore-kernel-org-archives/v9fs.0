Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F1125A4
	for <v9fs@lists.linux.dev>; Fri, 29 Dec 2023 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1LMHD63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDFC433C8;
	Fri, 29 Dec 2023 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703866611;
	bh=r+rcYgYIBVZ1rhwkMC4SW/XjhMxWtpxtlcug89+xlRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1LMHD63R9rSvzzYGI6p0Na5D+sNWSApLpBAO6yioEx4YxelFGMDlrAWC0HaEV7Nu
	 64LvRsba7duqcnfgbOuGu27sEI+TYiANu2N9UR0HaWELilEnDATb5MgWZODZRxXNPP
	 czS0kbqmHv80nt6bXd0/yMi0lDvqocUo2fOzXC//eo5mnXczdf+iLj9vgWrRUcJhpY
	 9Vg9EZkmJ/mTOI5LZQGxbeDSTXWPSrihIPrWRJXuDLi26twCf85ANLMKYK/r2uoxc4
	 I2e/eDSsu7Yo5qNlqdhBnkDeHREHFeVSAUIn9+g/7YWmaqhMpkGAo8kZqP/K6FIa09
	 U2ycdRWyAMipw==
Date: Fri, 29 Dec 2023 10:16:48 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux)
Message-ID: <ZY7w8NJdQ6CO8nQF@FV7GG9FTHL>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
 <ZY3tJ0eD73Gmy_PQ@codewreck.org>
 <2850709.f7ZBceQk0b@silver>
 <ZY7An6VBb0GCEMFu@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZY7An6VBb0GCEMFu@codewreck.org>

On Fri, Dec 29, 2023 at 09:50:39PM +0900, asmadeus@codewreck.org wrote:
> 
> It's not strictly needed though; in practice the vfs can handle
> duplicate i_ino as long as appropriate functions are used for iget
> (iget5_locked in fs/9p/vfs_inode.c); although now I'm thinking about it
> that won't work for programs like tar that'll notice the inode number is
> identical and consider the second file to be a hard link of the first...
>

This is the problem though, iget functions use lookup functions which
right now compare a bunch of state requiring a getattr to validate.  This
is one of the things I was trying to eliminate.  The other option would
be putting some of these additional bits (device, i_generation, etc.) in 
the qid.

>
> I guess we could swipe it under the rug by making the inode number a
> hash of everything in qid.path, and pretend collisions never happenTM?
> 

feels wrong, hashes always have collisions and it makes me uncomfortable.
I know some of the other on disk file systems have moved to 128-bit inodes,
does that help or just push out the problem (or make it less likely I suppose).
The combo of qid.path and qid.version is probably a pretty good mix, if
qid.version is some hash on time then the likelyhood of collision goes way
down (but notably isn't zero..) and servers don't always populate qid.version,
but that's something to fix server side.
 
> 
> ... Actually didn't think it'd be this easy to reproduce, but ext4
> reliably recyles the same inodes after unlink:
> h
> # touch a b c
> # ls -li a b c
> 357 -rw-r--r--. 1 root root 0 Dec 29 21:39 a
> 365 -rw-r--r--. 1 root root 0 Dec 29 21:39 b
> 366 -rw-r--r--. 1 root root 0 Dec 29 21:39 c
> # rm -f a b c
> # touch new
> # ls -li new
> 357 -rw-r--r--. 1 root root 0 Dec 29 21:40 new
> # rm -f new
> # touch again
> # ls -li again
> 357 -rw-r--r--. 1 root root 0 Dec 29 21:40 again
> 
> (works even if I actually write something into the files and sync them)
>
...
> 
> If the file's still open, it's not removed from the fs -- we're
> guaranted the inode won't come back yet.
> For a networked file system though I was thinking of cache more than
> open files, e.g. in the previous example a 9p client might think 'new'
> and 'again' are the same file.

So this is just a cache race problem potentially.  The real concern 
being that the cache is out of date with the server and then we get
an inode collision.  But that probably likely for other reasons with
a loose cache -- I guess the question is how to handle for a tight
cache.  qid.path+qid.vers maybe enough - but races still possible.

>
> I guess it doesn't really matter since we have no cache invalidation /
> refresh logic...
>

Well, we have logic - its just always valid or always invalid.  The real
question is how do we want it to work in tight mode.  Is qid valid or do
we always need to do a stat/getattr.

    -eric
