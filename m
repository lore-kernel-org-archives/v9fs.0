Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5A85C5E;
	Tue, 22 Oct 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609317; cv=none; b=u/UBIFXya22IdZzj6njAHShxJ78wZNgaoyBG9caUPkWCy8tqMJjbXdBtj4MBw7qYoQXjbnkeFFYnk1rOdtzYUuWJk+fv7ckajfbYvlMdpCFblttgvBnoYSqf10w9FmTJbLvumFbivdQ1I/Ahcx2WrpL66q3zfIU7WOVy5dZgh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609317; c=relaxed/simple;
	bh=wLqL5G1fJBdDKZdoYSyYQ6Gn8QO4wi41ipLs3UAmGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ4slrSe9t7y/2NOyUbq9DeSW1iMKGMHp0ZFp61AWHR3BvzfOMQCC7fDnMaA5h731ftEOOyv/hK8EWC5SrhgBpSaXwHYWA6YLi+/8WjmqtuPahNKopx7XeEg+Ra2pjrQF9ulYvzPeTjgmAUFrRQanhaos5RUH+JiuwHEYuneaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRgoLqoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRgoLqoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F5C4CEC3;
	Tue, 22 Oct 2024 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729609316;
	bh=wLqL5G1fJBdDKZdoYSyYQ6Gn8QO4wi41ipLs3UAmGBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRgoLqoLkCtpHyliTt/1PQ8RP5Q4lwET601tPX3cyOlCHlt0t9C3GrTfTgA2dcD5G
	 8xOzMum+13B0yZpnqyFF9CJ7rNQJAsvtXTIIt0iwkKq5CSNtIvDWZPW+accC06iup+
	 KWlI05rk/rZuz0G+1vDBOhttOWhEK9BVlu6aiLQTZryFZzxMicjdCr3/cqhvSka/0d
	 Fnvj0A/lWw1vyHH6zcCP3oY/UWOk3fmp+H48env2qqZvirSWV0PA+d29HGD6Pjc77T
	 4xm2L6lTb9sAvDA4Ru70TtmB4QQDPuZP9dfEVU8kAX+NFkzLLPPJi4Ip/tLGZyD2g/
	 Rn9GBJZrzjXbQ==
Date: Tue, 22 Oct 2024 16:01:49 +0100
From: Will Deacon <will@kernel.org>
To: asmadeus@codewreck.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, ericvh@kernel.org,
	lucho@ionkov.net, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com,
	keirf@google.com, regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20241022150149.GA27397@willie-the-truck>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
 <Zw-J0DdrCFLYpT5y@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-J0DdrCFLYpT5y@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Dominique,

On Wed, Oct 16, 2024 at 06:39:28PM +0900, asmadeus@codewreck.org wrote:
> Thorsten Leemhuis wrote on Tue, Oct 15, 2024 at 08:07:10PM +0200:
> > Thx for bringing this to my attention. I had hoped that Eric might reply
> > and waited a bit, but that did not happen. I kind of expected that, as
> > he seems to be  somewhat afk, as the last mail from him on lore is from
> > mid-September; and in the weeks before that he did not post much either.
> > Hmmm. :-/
> 
> Right, I had hoped he'd find time to look further into this and kept my
> head in the ground, but it looks like we'll have to handle this somehow...
> 
> One note though he did sent a patch that seems related and wasn't sent
> for merge:
> https://lore.kernel.org/all/CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com/T/#u
>
> Will, perhaps you can try it? I'm pretty sure the setup to reproduce
> this is easy enough that I'll be able to reproduce in less than an hour
> (export two tmpfs [sequential inode number fs] wthin the same 9p mount
> in qemu without 'multidevs=remap'), but I don't even have that time
> right now.
> 
> (I didn't even read the patch properly and it might not help at all,
> sorry in this case)

I think this patch landed upsteam as d05dcfdf5e16 (" fs/9p: mitigate
inode collisions") and so I can confirm that it doesn't help with the
issue.

> > CCed Christian and Al, maybe they might be able to help directly or
> > indirectly somehow. If not, we likely need to get Linus involved to
> > decide if we want to at least temporarily revert the changes you mentioned.
> 
> I'm not sure this really needs to get Linus involved - it's breaking a
> server that used to work even if qemu has been printing a warning about
> these duplicate qid.path for a while, and the server really is the
> better place to remap these inodes as we have no idea of the underlying
> device id as far as I know...

FWIW, I'm not using QEMU at all. This is with kvmtool which, for better
or worse, prints no such diagnostic and used to be reliable enough with
whatever magic the kernel had prior to v6.9.

> So the question really just is do we have or can we build a workable, so
> the question is can we resonable do any better, or do we just want to
> live wth the old behaviour.
> (Note that as far as I understand the old code isn't 100% "loop" proof
> either anyway, a open(O_CREAT)/mkdir/mknod could happen to get identical
> inode numbers as well, it's just less likely so folks haven't been
> hitting it)

I'm happy to test patches if there's anything available, but otherwise
the reverts at least get us back to the old behaviour if nobody has time
to come up with something better.

Cheers,

Will
