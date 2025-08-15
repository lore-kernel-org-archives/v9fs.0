Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC91459F7
	for <v9fs@lists.linux.dev>; Fri, 15 Aug 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222619; cv=none; b=nVt94bF6MMD4s4ZCHHJd7jwFhNI6IjR2jYv7+feUw1MduWHYuZzvcJTxK5j08V1mmu1VieihCq/Xyjjd8Es4vshp1gBCm4FxEZ4Rykiykgz1tCSwTPfGdwI3AXhnPMtQ+FDbrHMCS7e3WtPUzfiDWddapysAvOsQRpLn4vkx2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222619; c=relaxed/simple;
	bh=9STSGVzQphpj6dFmAksTJ1kJlaYQgdw0RQrDoY9RmQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzRuZ0puyWkknkP0b/yHljT2qsqbA1JBN29JLmBYMR1iwT5PTfiNXQrALmuMwpZ9r0TOtZoMR2Jy0SH47UG8CMwH0bylTvtOuyoJUTLl6sSbDNLKqVCKg3ihqoa2cIuwqwfwikW4d1+KVZFbEr2lw8gQehTkEhGSlnjQhb2/iPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Mx7tjzwd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Mx7tjzwd"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7C86F14C2D3;
	Fri, 15 Aug 2025 03:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755222608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0fx5fxYEfcNExsKt98qeu7O41VdbcAfsk/i6vcUeUs=;
	b=Mx7tjzwdU96GCGBMQRvmlmLFqzgfqqC251QPZohxkdtoh3SaCvGknV0jqwj3hj7BN4ufBy
	NR6POnZk4nSdS16SQU28GLQU8Vv7Wtc36MnMj0PrLxGp6kToP+LZ1g5BJ7bECPJN7DGZcC
	kw6Eo07BKmoD1wRyiR/AyBEvqCWZgSX9JzfmjDEhjTGhmj3zelwRQyub7HlnVQ+aJNhrxU
	ewsAWEutXPJIbRsfDKu/eAFeMbiShWqjtWKny4TqB7iCIrjNYMFBEH7obmQ+bET/KInLZd
	xJWYtZXV1n1YKNX6HhX6QvvyplQFw4CbDXxV+LAIxkglnBf5KhizqqYoit0fyA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 178574c4;
	Fri, 15 Aug 2025 01:50:03 +0000 (UTC)
Date: Fri, 15 Aug 2025 10:49:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	dhowells@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aJ6SPLaYUEtkTFWc@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>

Eric Sandeen wrote on Thu, Aug 14, 2025 at 11:55:20AM -0500:
> >> I was able to test this to some degree, but I am not sure how to test
> >> all transports; there may well be bugs here. It would be great to get
> >> some feedback on whether this approach seems reasonable, and of course
> >> any further review or testing would be most welcome.
> > 
> > I still want to de-dust my test setup with rdma over siw for lack of
> > supported hardware, so I'll try to give it a try, but don't necessarily
> > wait for me as I don't know when that'll be..
> 
> Any news on testing? :)

Thanks for the prompting, that's the kind of things I never get around
to if not reminded...

I got this to run with a fedora-based host (unlike debian siw is
built-in):

- host side
```
$ sudo modprobe siw
$ sudo rdma link add siw0 type siw netdev br0
(sanity check)
$ ibv_devices
    device          	  node GUID
    ------          	----------------
    siw0            	020000fffe000001
( https://github.com/chaos/diod build)
$ ./configure --enable-rdma --disable-auth && make -j
(diod run, it runs rdma by default; not squashing as root fails with
  rdma because of the ib_safe_file_access check:
  [611503.258375] uverbs_write: process 1490213 (diod) changed security contexts after opening file descriptor, this is not allowed.
)
$ sudo ./diod -f -e /tmp/linux-test/ --no-auth -U root -S 
```
- guest side (with -net user)
```
# modprobe siw
# rdma link add siw0 type siw netdev eth0
# mount -t 9p -o trans=rdma,aname=/tmp/linux-test <hostip> /mnt
```

I've tested both the new and old mount api (with util-linux mount and
busybox mount) and it all seems in order to me;
as discussed in the other part of the thread we're now failing on
unknown options but I think that's a feature and we can change that if
someone complains.

> As for "waiting for you," I assume that's more for your maintainer peers
> than for me? I'm not sure if this would go through Christian (cc'd) or
> through you?

Sorry, I wasn't paying attention and confused you with another Eric
(Van Hensbergen) who is a 9p maintainer, so I was thinking you'd take
the patches, but that wasn't correct.
And that's after seeing your name all the time in #xfs, I'm sorry..

Christian is "just" a reviewer (for now!), and none of the other
maintainers pick much up lately, so I'll give this a second look and
take the patches.
Linus just closed up 6.17-rc1 so I guess this will get in 6.18 in the
next cycle, unless there'd be a reason to hurry?

Thanks,
-- 
Dominique Martinet | Asmadeus
