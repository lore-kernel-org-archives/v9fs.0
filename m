Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E1301012;
	Fri, 15 Aug 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266118; cv=none; b=gbdGsXq86zglOjoJ7sKEUKxg4OqkxBWd061n1f49dAUcofP7rdnFIdeDTsg3bqCAE0sT6660/WW51IMuM+NxQ3ePCot7l03ENEwGLwctLz7E5/4HsB87wYIuDT8xjK9aaf9W8DuARFWD90RI0nEZcqnytanOrJKC/mydF2iM960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266118; c=relaxed/simple;
	bh=7eykCYyj2bHv4lzOzcSeNagcGE9LJ/ld+1sNUo509n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYBmMkXAcPjfhdbHtkZs9JDjhpnZ/ZSDx5YlMmOLDT2B++X3RVv9CTpqfE9oewvYXUI6ZB9IcaKBxrpDW4s5aWPPr3Lic0o2S7fE0Gq+PZ3L/IEAscUA6diMalfpaIhYfMH+hiWG2AM9kKw8WTMxZ8YuInIKMhKxlB5AHQuVIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLgEwIOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLgEwIOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5879C4CEEB;
	Fri, 15 Aug 2025 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266118;
	bh=7eykCYyj2bHv4lzOzcSeNagcGE9LJ/ld+1sNUo509n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLgEwIOwEsE7jLywFBdqxyd/p29mJkppU7N+A8HsOKnVmKp//jovr3rbYIO0YuS/w
	 GZJwsqwHyqelAlFHWgWIaL/yIR6+XlKYXYp2WYBjgXcv+JvRR7CXDlSbqJpYPeVyxn
	 qzgVsDnPLfLXxf860PzkjyLSQpkl9C0b46KhwgnxGYH6WDhLmLHtDFTiXPjoYDPryR
	 UYJN6tksxXKxhm3+Kexr/f8xhODLxdgzd+QW/sx4HRWMszkACvDPF5i7i4YoRgu4cy
	 KwYqecSCzjIGpHiLZ5IxPl5XUAcNEczp2CCoXp0q9ssfxz5FqJUqpgDhRS2Ex2gHpk
	 j57dHkS7EWsTg==
Date: Fri, 15 Aug 2025 15:55:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, 
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, dhowells@redhat.com
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <20250815-gebohrt-stollen-b1747c01ce40@brauner>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ6SPLaYUEtkTFWc@codewreck.org>

On Fri, Aug 15, 2025 at 10:49:48AM +0900, Dominique Martinet wrote:
> Eric Sandeen wrote on Thu, Aug 14, 2025 at 11:55:20AM -0500:
> > >> I was able to test this to some degree, but I am not sure how to test
> > >> all transports; there may well be bugs here. It would be great to get
> > >> some feedback on whether this approach seems reasonable, and of course
> > >> any further review or testing would be most welcome.
> > > 
> > > I still want to de-dust my test setup with rdma over siw for lack of
> > > supported hardware, so I'll try to give it a try, but don't necessarily
> > > wait for me as I don't know when that'll be..
> > 
> > Any news on testing? :)
> 
> Thanks for the prompting, that's the kind of things I never get around
> to if not reminded...
> 
> I got this to run with a fedora-based host (unlike debian siw is
> built-in):
> 
> - host side
> ```
> $ sudo modprobe siw
> $ sudo rdma link add siw0 type siw netdev br0
> (sanity check)
> $ ibv_devices
>     device          	  node GUID
>     ------          	----------------
>     siw0            	020000fffe000001
> ( https://github.com/chaos/diod build)
> $ ./configure --enable-rdma --disable-auth && make -j
> (diod run, it runs rdma by default; not squashing as root fails with
>   rdma because of the ib_safe_file_access check:
>   [611503.258375] uverbs_write: process 1490213 (diod) changed security contexts after opening file descriptor, this is not allowed.
> )
> $ sudo ./diod -f -e /tmp/linux-test/ --no-auth -U root -S 
> ```
> - guest side (with -net user)
> ```
> # modprobe siw
> # rdma link add siw0 type siw netdev eth0
> # mount -t 9p -o trans=rdma,aname=/tmp/linux-test <hostip> /mnt
> ```
> 
> I've tested both the new and old mount api (with util-linux mount and
> busybox mount) and it all seems in order to me;
> as discussed in the other part of the thread we're now failing on
> unknown options but I think that's a feature and we can change that if
> someone complains.
> 
> > As for "waiting for you," I assume that's more for your maintainer peers
> > than for me? I'm not sure if this would go through Christian (cc'd) or
> > through you?
> 
> Sorry, I wasn't paying attention and confused you with another Eric
> (Van Hensbergen) who is a 9p maintainer, so I was thinking you'd take
> the patches, but that wasn't correct.
> And that's after seeing your name all the time in #xfs, I'm sorry..
> 
> Christian is "just" a reviewer (for now!), and none of the other
> maintainers pick much up lately, so I'll give this a second look and
> take the patches.

Fyi, Eric (Sandeen) is talking about me, Christian Brauner, whereas you
seem to be thinking of Christian Schoenebeck...
