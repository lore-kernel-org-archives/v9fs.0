Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F64399DC
	for <v9fs@lists.linux.dev>; Tue, 22 Sep 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065605; cv=none; b=CJTdsmBZskt6rFtzcVGdjHtToLgztclfC9o52envimVlkak/YQWDO25BStYuZYeypu5cbtquD0F86S1h91zUWVT4bZJc5Zc6y64P45Hn6xNgAoAaCYQ3aD2JuCKOpbAy4QxPP8M0ie9B9y+U0ffkZHckUfgscRIWUBB9eCjrL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065605; c=relaxed/simple;
	bh=XZ+3rwImauD6ysvIuqZI73fbnM4zM7XysFY97rdVia4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TodgBo2AVCNC7J3o7LrpvFMpHdSdgkSQkF/+aq9/3Thh2q2ErH5X5mZVB1o/DRgwM2QnqQieBSbqXxCHunFweNulyMkWuf+HiXZrTEQqqjBmGeds41f0OrIbDqA4zrx2wd+DYvcFb+2fpEj+RN0o5gTIu2ecDdTxh46mWWYLxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=F0B3NFG3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="F0B3NFG3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D9AB414C2D6;
	Tue, 22 Sep 2026 10:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1790065594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfKGS+9CQZJPuhu2yyLT6uSV59VV3jnw8NH/pJRJq7E=;
	b=F0B3NFG3Cm5JHWOdZfGoHgj/FJd/T8r0m35NO3UNw98RKjkMIQQEjaZx5jpkm/e1MIGmc5
	QDXSU9tf6ODVShWqFyrAsXAm2C8xGuSDeNHHAaF8oEXrpMUv3sZAvjFv5FYmwFOYGl8qJE
	h1HL1NNQ+t971f8sUtU4MYxDoEGMjCV4la7POc9jUuTERh4gF1DSWnfOhcumVcFnUzxpkO
	D+T9TV6OQMKecF64L83c5d9HKS8QMiG8zEPLC9Cwn8IsreHA9p5cHb+nxrfPGjWFMnzquT
	a3rlqEUVWMmTThFncpsxmJlUIawZFAx2R+0a6L/5qKKyHVw7wUpTkOkS6W9t5g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 633e2b9a;
	Tue, 22 Sep 2026 08:26:30 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:26:15 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: skvarlamatus@gmail.com
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stefanha@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH v3] net/9p: add vsock transport
Message-ID: <arI7p2EinDektW0n@codewreck.org>
References: <aqiGy_7S_cYs_6or@codewreck.org>
 <20260916194204.99506-1-skvarlamatus@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916194204.99506-1-skvarlamatus@gmail.com>

skvarlamatus@gmail.com wrote on Wed, Sep 16, 2026 at 09:42:04PM +0200:
> On Mon, Sep 14, 2026 at 23:44 +0000, asmadeus@codewreck.org wrote:
> > Right, diod has an open issue[1] for vsock but since there were no
> > obvious client available either it was never done.
> > I don't think it's difficult to do (probably more work to add the option
> > parsing than the actual vsock support)
> 
> Definitely agree. I think with this in the client, it could encourage
> more servers to add vsock support too.

Just had a quick look at diod code and their handling of the listen
option is purely string based, passed to getaddrinfo() to figure out if
the user requested ipv4/ipv6 -- I'm pretty sure getaddrinfo() doesn't
want to have anything to do with vsock, but I don't suppose there's a
canonical string representation for vsock is there? (something like
`cid:<cid>:<port>` instead of the usual <cid>:<port> couple printed?)

I didn't want to add a new option such as --vsock-listen, but I'd hate
to disambiguate vsock from ipv4/v6 as a string even more... :)



FWIW commit message ended up like this (everything ellipsed is exactly
as you sent), so just extending the sentence a bit to mention Hyper-V
and podman machine:
```
    net/9p: add vsock transport
    
    Add vsock as a transport option for 9P client connections. This
    allows mounting 9P filesystems over VM sockets without requiring TCP/IP
    networking or additional userspace tools, which can be useful with
    hypervisors other than Qemu/KVM, for example Hyper-V/WSL which is used
    by podman machine on Windows[1][2].

    [implementation details]

    Usage:
      mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point
    
    Link: https://github.com/podman-container-tools/podman/blob/main/cmd/podman/machine/server9p.go [1]
    Link: https://github.com/podman-container-tools/podman/blob/main/cmd/podman/machine/client9p.go [2]
    [sign-offs/reviews]
```

Thanks,
-- 
Dominique Martinet | Asmadeus
