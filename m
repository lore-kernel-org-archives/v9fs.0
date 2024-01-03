Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9851C687
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdq+OZrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB958C433C8;
	Wed,  3 Jan 2024 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704305388;
	bh=nUckmbnzJOyyjYd1SZWyF+hHhan8ASqO/qmJ4FIs76Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pdq+OZrDC4AcRCIE2iFDj9ZHdPGBFv0spbX2gxw8uJDE/cCW6leFC6gS2VKUT5vZr
	 fEFyB73nDg+4GqsG+ICrw2cYhXydnvIxCUfLD9T9eR0q7MOoqbqKpvrrQ9ElWUIn4a
	 VsOl3lojZyPm8R0lsaVyk17Yg4pCQfPgjsuiDNXCxq1yxkVwo25lkPKHQZcdVGHSMi
	 HX9yMh6yUmyioeO7H1rjJt9XS0A6nSCWWvBwYCgRRhTZ9u9CCN8fo+Cx0FwekZHoze
	 Rp/U0+dO143nyn4ef1b2xDV7iS7o/+0vaQccRy6Va6iXx3ZJzuF4dSkzWUANMANq2o
	 BEu9YaZJ9T3CA==
Date: Wed, 3 Jan 2024 12:09:45 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	ericvh@gmail.com
Subject: Re: cache fixes (redux) (a tale of many inode numbers...)
Message-ID: <ZZWi6fbgy8oGwR1D@FV7GG9FTHL>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
 <CAFkjPT=8CZHATaraBrqAZGDKjQLOp=U1gdgteJ5jpXRGJyBojQ@mail.gmail.com>
 <ZYzCERk_dg1-CEjb@codewreck.org>
 <3936280.6WX1Z9CqS8@silver>
 <ZY2PQkJ6jq4dx9p_@FV7GG9FTHL>
 <ZY3tJ0eD73Gmy_PQ@codewreck.org>
 <ZY7qr1Dy_aS716dC@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY7qr1Dy_aS716dC@FV7GG9FTHL>

Okay, been delving through this code.  Most (all?) was added by
Aneesh when he did the cache stuff and I clearly wasn't paying
close attention a decade ago (mostly because I didn't care about
the cache then).  In any case, I think there is a ton of code
I am going to be able to delete (patches coming soon), but wanted
to sanity check one thing with you folks.

Looking at the inode get code (which also doubles as inode creation
code).  The inodes are hashed with qid2ino(qid) which I get to take
the blame for because its been there for 18th years.
If the size of the inode_tt is 64-bit, it just
assigns the qid->path+2 (+2?) to the i_ino.  If not (presumably for 32
bit) it sets the inode to (qid->path+2) ^ (qid->path+2 >> 32). 

If ino_t goes to 64 bit this means we reduce precision for no reason,
so that has to be fixed -- but I'm trying to remember the relevance
of +2 which dates back all the way to the original submission.  I
don't remember why we did this, but I think I'm gonna kill that in
one patch and in a second patch fix the length check.

Moving up the stack a bit, we use the modified qid.path to hash the
inode, but then we also assign it (overriding the allocated inode number
on the client).  I'm gonna say this is wrong (definitely wrong in the
case where we are allocated inodes willy-nilly) and we should probably
continue to use qid.path to hash, but then keep the client side inode
number which is guarenteed unique on allocation.  Or do you folks think
we should align client-side inode with server-side inode to help with
debug?  We should still have consistent qid->paths regardless.  Thoughts?

        -eric
