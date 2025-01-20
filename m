Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265731E0E01
	for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378822; cv=none; b=RnhHDJHHO+fGjTz8DLseG2DYRUIxQjo4kHQ3dAJABYflO/1+9Hn9MtnUAtzAXn+tfkKRg7kyMZjInWTjXDDPnN91wJ8NMQzV6SXClrbRxj9OFjzwgxc3nQ+WTlqd84sMMBjp/fhn6Y4aL048cZFBMQpnN9WQnA8+IoeFIUq1uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378822; c=relaxed/simple;
	bh=mvt1oyTERPerrYDETvStjkEzg7jAE6+nc8g3GkrqONU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwKPnW6bGEPy8wIJlRv3EtVr1i1O11zIch2b7RCjnZCOLefp3eMHATddVwehG19yEPx2YkO2aaZheOXW3wyHjhwJTxIainapo6pxfaGyO/NAQYfShG/Sg3G3VChUTp75kWfbOd5Dl5ELhH4RAaUjnA1vr7uCjTOW+bmn8qCwjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=GJHzcJNr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="GJHzcJNr"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2A04C14C1E1;
	Mon, 20 Jan 2025 14:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1737378816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPqcYMDcozu4P2FMU4Oia/QMeb3MAqzIT757UuY4vDc=;
	b=GJHzcJNrIs1MPqup6eLQt37RJC6+iKmbwso8F8aQRQNXUNfpda7xplsI2BaYLGTY+/eA3O
	KFotdRKKn7yCzc9L/DXvqwom4+yDdXZ53JUSEleK/ZYcU/Kn8RkWXPJCvtkPaxPmPN4ri2
	YRl8XT9gYAItlJjZ7Apctmt8Mlzev5IkFunv1mQ7RMoy4C1VDCFLyr1SfpHyG/hk4ywYyH
	Cp95YP+kBRK7FiaHWHRBXm0L/Jo/k+btcy+XFmiqcJMBdyKZ70FRIzQsml0hnHz7TgazM2
	jR84tjGqSGW8nEUP7TbIWhRcn1KKg0iWHwfj/nAGGa4fns25tPaMgrwn57nIiQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4969dc2a;
	Mon, 20 Jan 2025 13:13:33 +0000 (UTC)
Date: Mon, 20 Jan 2025 22:13:18 +0900
From: asmadeus@codewreck.org
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v3] net/9p/fd: support ipv6 for trans=tcp
Message-ID: <Z45L7uHk5PCbE6zG@codewreck.org>
References: <20250118192122.327-2-joshuamurphy@posteo.net>
 <Z44Hk0FEm5bTx7SZ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z44Hk0FEm5bTx7SZ@codewreck.org>

asmadeus@codewreck.org wrote on Mon, Jan 20, 2025 at 05:21:39PM +0900:
> Meanwhile I should have tried earlier but checkpatch has a few qualms
> about style; if you send a v4 for any other reason please try running it
> yourself.
> [..]

There's no value in having you send a v4 just for this so I went ahead
and just removed a couple of spaces in my tree;
you can find the commit here if you want to check:
https://github.com/martinetd/linux/commits/9p-next

> I can't make any promise about testing but will try to find time around
> next weekend, after which the patch will slowly make its way in next
> cycle.

And I found time for this sooner than I thought I would: mount worked
just fine, both in v4 and v6.

Since there is no obvious regression I've pushed the patch to my "next"
branch, which will be merged into linux-next shortly and I'll submit to
Linus next cycle -- we're in a merge window right now but I don't have
any other patch ready and this doesn't feel like it needs to be rushed
so it'll be in a couple of months.


FWIW, the "current" workaround that also works with any released kernel
is to mount as follow, with shells like bash that allow /dev/tcp this is
actually easy to script:
```
exec 3<>"/dev/tcp/$TCP_SERVER/$TCP_PORT"
mount -t 9p -o trans=fd,aname="$TCP_ANAME",rfdno=3,wfdno=3 none /mnt
exec 3<&-
```


Thank you again, this has been on my todo list for almost as long as I've
been cattering to this 9p client!

(and I'll conveniently ignore the fact that trans_rdma has the very same
problem, I haven't had access to hardware to test RDMA for years so
unless someone cares it's probably better to leave it untouched..)

-- 
Dominique Martinet | Asmadeus
