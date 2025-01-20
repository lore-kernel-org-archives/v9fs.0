Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6714C96
	for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361328; cv=none; b=rJs8DDNbSJZc4MILsBw6pqA+cPLV3nQJoGJPddQsop/461J/do+PXvhqgn+53h8V+g64yXiCaKiBkCeMVO98Pc+ti+N0AnH1AXty7x8qOU8UGoTG1LXLS7ycyavcoFMgHBCqgRgLwWbeBZH4GlQil/hB9lOQq9dsqhs06+6l3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361328; c=relaxed/simple;
	bh=sedZohR0X0teSiBIucZYZ7UXTLWld0XSrl2cicD8gOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDbgaZkNDK6QU/gruqDsNGQK8QwcScN4a8YpAPa9TTWdBNLZAabRsFOW0IwAQbioH6d4aX96Dfmd2f6T1uVTN3ppsaBizhmLujteHSehcJCNAZfiqO/Mch/SOHyCpDngDHU0AjiAywY6P3a1JfuyE0DNSm93V0nF1ReqDfpY+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0aGjsQ6U; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0aGjsQ6U"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B1FA214C1E1;
	Mon, 20 Jan 2025 09:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1737361318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GHJ6VuEecZnMD4pZdXIH/hqEbUVNCEv/8xG4AfEZq0=;
	b=0aGjsQ6U9uDJACuYbIq7f7ogGU75syRSQtjXKwgpaylpi3JTdy840MwnfeFeQU6CYMB2bK
	BzSCo7etku7sz3hfVJ5f+1QoTnPmRJR7VK4weJ/IocsFO8SZUlOhDNLy14EeZv1c2RzOvX
	70Eqa7rSp/25WaiG+ySWUKWLYvRFrtqKsB+veTXciqZoNaOuxSqFpZuN0oU70Ji+0Y/mXI
	KdNjFK/L0E1EKYVLLywDrTmI7lGHLrv2zYQ6gN4RnnMXkvEP9K/xMscvSIEjBbgZMubPD3
	egF9ze5vuqd4QolL4g0suk6fRj4ueBIeeByCgWts+h6kyFr7hZ+SzrECDeF6Cw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a1d7a4e;
	Mon, 20 Jan 2025 08:21:54 +0000 (UTC)
Date: Mon, 20 Jan 2025 17:21:39 +0900
From: asmadeus@codewreck.org
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v3] net/9p/fd: support ipv6 for trans=tcp
Message-ID: <Z44Hk0FEm5bTx7SZ@codewreck.org>
References: <20250118192122.327-2-joshuamurphy@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250118192122.327-2-joshuamurphy@posteo.net>

Joshua Murphy wrote on Sat, Jan 18, 2025 at 07:12:36PM +0000:
> Allows specifying an IPv6 address when mounting a remote 9p file system.
> 
> Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>

Thank you!

I don't have any problem with this, I need to find some time to take the
dust off my 9p tcp server setup to try this out.

Meanwhile I should have tried earlier but checkpatch has a few qualms
about style; if you send a v4 for any other reason please try running it
yourself.
--------
$ git show --format=email | ./scripts/checkpatch.pl -
CHECK: No space is necessary after a cast
#56: FILE: net/9p/trans_fd.c:965:
+               ((struct sockaddr_in *) &stor)->sin_addr.s_addr = htonl(INADDR_ANY);

CHECK: No space is necessary after a cast
#58: FILE: net/9p/trans_fd.c:967:
+               ((struct sockaddr_in6 *) &stor)->sin6_addr = in6addr_any;

CHECK: No space is necessary after a cast
#63: FILE: net/9p/trans_fd.c:970:
+                       ((struct sockaddr_in *) &stor)->sin_port = htons((ushort)port);

CHECK: No space is necessary after a cast
#65: FILE: net/9p/trans_fd.c:972:
+                       ((struct sockaddr_in6 *) &stor)->sin6_port = htons((ushort)port);

CHECK: No space is necessary after a cast
#66: FILE: net/9p/trans_fd.c:973:
+               err = kernel_bind(sock, (struct sockaddr *) &stor, sizeof(stor));

CHECK: Comparison to NULL could be written "!addr"
#89: FILE: net/9p/trans_fd.c:993:
+       if (addr == NULL)

WARNING: braces {} are not necessary for single statement blocks
#95: FILE: net/9p/trans_fd.c:999:
+       if (err < 0) {
+               return err;
+       }

CHECK: No space is necessary after a cast
#117: FILE: net/9p/trans_fd.c:1026:
+                                              (struct sockaddr *) &stor,
--------

(Some aren't new and I don't mind too much, but most are on new code)


I can't make any promise about testing but will try to find time around
next weekend, after which the patch will slowly make its way in next
cycle.
-- 
Dominique
