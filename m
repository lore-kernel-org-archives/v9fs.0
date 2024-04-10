Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0017B514
	for <v9fs@lists.linux.dev>; Wed, 10 Apr 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768577; cv=none; b=i6xtUS4eowO1ffAoEzeVIQXYQoZcedNiDTWd+dpL39Rdru/sVIC1SJjdIFUur6P2Y/ITecWkRwScVc9xqPhP95HFGGDEz92naS5lXkatRoFdPbPYnvgx1KCdQcSWsEy6qsuh4/u+MkZCx7aoGIkhGzBKZzj4pfndbuMF157ocHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768577; c=relaxed/simple;
	bh=L5sRSwaoNOYVFYcTF+DBEJAtyUiOW+Z5SSK04Ej/TvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJlCV/VdbaSwdztewK76NNtvLKKaO5XK0TkhC43en9hlhODsRV6g05ydb4TJ6VP0b1Cl4YuE7i8DUGDfSiVMw/ggrfsL21xiFNjD1lV95YJwz7wYAM4Ljbsv37fGUlYp59+bTl5KRpADBZslvpyRw6PxsXGzwp6rbu2epEC6UjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vld1MxHM; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vld1MxHM"
Date: Wed, 10 Apr 2024 13:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712768573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1GxujnLogSAuvDq3fFnDwaWMXQeAw1XJDA3ZKc+JPk=;
	b=Vld1MxHMhWMrJRAu2Atg1r3tVT5S5VZFviyMVPp4GVGEtX9XDGKAlLDQVuGkGGn8zmQAhE
	EF8LigB0olpsf+RDt3trtomYi0DCMrXYczWW7HBs3AlGXtxaSmoj+zFkI6TRJ5P37276Un
	f008+LcrIpCF034uZJUlUEjRIbQIksQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: new 9p kasan splat in 6.9
Message-ID: <ahtzctuhy25ptcztbbzmbjhkrh3sjpsjz4ixvrtmpl64iq4hej@vox2llmlv5im>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
 <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
 <ikookkidwzvjwuexmsco437lusgk24rffec7pyxwnquhydsk4p@evfumg2ygpsq>
 <CAFkjPTk1WE_LuuiJ-fz3v_BHKZUaNSA2LUPD+KAULeH4R9rgCA@mail.gmail.com>
 <oyo4rhetu752bdnh3vlojiq5apgndnvsg3g2qcftvoho5vqr34@n6li2x5jwpml>
 <1f79a506bdf50cfd456acfa876df8a502d64b976@linux.dev>
 <29d9bb670a489a38dc9112e21dcf73d44b67d2f6@linux.dev>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d9bb670a489a38dc9112e21dcf73d44b67d2f6@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 10, 2024 at 11:43:44AM +0000, Eric Van Hensbergen wrote:
> I'm having a hard time reproducing the 
> 
> April 1, 2024 at 8:27 PM, "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev> wrote:
> > 
> > April 1, 2024 at 8:12 PM, "Kent Overstreet" <kent.overstreet@linux.dev> wrote:
> > > 
> > > Any other details you can give me from your environment (how is
> > >  9p mounted, is this qemu?, etc.)?
> > >  It's qemu, standard mount options:
> > > 
> > >  host /host 9p rw,relatime,access=client,trans=virtio 0 0
> > > 
> > 
> 
> I'm continuing to have a hard time reproducing on my test system -
> I've added a bunch of BUG_ON to the code to catch where I thought
> potential problems might be and have not tripped across any of them.
> Can I get two pieces of data:
>   a) which 9P CONFIG options are enabled in your kernel?

$ grep 9P ktest-out/kernel_build.x86_64/.config
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_9P_FS=y
# CONFIG_9P_FS_POSIX_ACL is not set
# CONFIG_9P_FS_SECURITY is not set

>   b) what is the underlying file system on the server

ext4

>   c) what version of qemu are you running

QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-1)

> I'm going to try to spend all day today chasing this down, I may
> revert anyways if I can't reproduce since there's clearly degraded
> behavior -- I'd just feel better about it if I understood what the
> problem was.  In your reverted version that doesn't experience the
> problem, was it just the last two patches that you reverted or the
> whole series?

Whole series. I've tested each revert individually, but unfortunately
the bug is so sporadic that none of them jumped out as the culprit (and
I'm running 1600 tests on each commit).

I don't have a way to tell my CI "run this test x number of times" or
I'd try to give you better information.
