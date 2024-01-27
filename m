Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2383BA55
	for <v9fs@lists.linux.dev>; Sat, 27 Jan 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320432; cv=none; b=ZTdB5QqqH5LZ9JeTLFH7kx4ocTIwJbHqQlIRegupG0iuUEHj7IGKBt7RubtXOuI8xJA0J9sE8e57GCBJEcb1JIQeVrT+yIfnamS6HbeOHeHPGteOB4kTb91BB+fv0FH8Y0uNxu0CiVOqi7KsTnbHZEZX6sdj4iKgzH9jm7qSkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320432; c=relaxed/simple;
	bh=Y6yN27k74/Y+JOEcNkTKQ6x5QUFGRFBeklM6SZJHkpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM0g3SvBTRAsfbcJcwp3cTUCSq6sXeiZeSNgf9dRkNfykxWQQqRKrS1frh51t564kTLX2OSU5EcmmK/+95cwbq9O+DvKGpER3hs1NcmoZoAymAv+iQwCehv8enM11pWwali3BklPeG4gXZb3N8qRCXPfgu9sUB1Wy6w71pr19Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=bI7Lipyj; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=bI7Lipyj; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="bI7Lipyj";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="bI7Lipyj"
Received: by nautica.notk.org (Postfix, from userid 108)
	id BC8EDC01C; Sat, 27 Jan 2024 02:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706320421; bh=8ATDnkgivy7+0wg7TR6l159yJcdnVSLc63oTKtEwX6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bI7Lipyjqhxx73YxidLmgkTp/hBb1nQ0vuiRN4ePEwkCwxe50idK0x+/tILSzxkKQ
	 lNC6LgzSJedUnwABd3b4D4HjCYnLgQgN0Q9tA/4WEfTIunXrMSj7U8mxp7fGF8fAEo
	 GxxwiI4P6YY7jTOSXMwCCyz1F7wvTzGzET8cED/QJVdIedHHQwlWi2t6rN/0y4ICp1
	 rUyf8lsrCmZRxkKbB539SZP6qePcsXjLQXS7lvfq17nD5GR0/fcjXwQ2tW8az4i/+5
	 V2ZXI0mK1z/GS4XC/iHtRC+WuNCnLW3uX1q+gMBFA/STURusWkm1BJD6U8u6AZSvqJ
	 loZPXxPlfTsVg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id E6AE1C009;
	Sat, 27 Jan 2024 02:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706320421; bh=8ATDnkgivy7+0wg7TR6l159yJcdnVSLc63oTKtEwX6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bI7Lipyjqhxx73YxidLmgkTp/hBb1nQ0vuiRN4ePEwkCwxe50idK0x+/tILSzxkKQ
	 lNC6LgzSJedUnwABd3b4D4HjCYnLgQgN0Q9tA/4WEfTIunXrMSj7U8mxp7fGF8fAEo
	 GxxwiI4P6YY7jTOSXMwCCyz1F7wvTzGzET8cED/QJVdIedHHQwlWi2t6rN/0y4ICp1
	 rUyf8lsrCmZRxkKbB539SZP6qePcsXjLQXS7lvfq17nD5GR0/fcjXwQ2tW8az4i/+5
	 V2ZXI0mK1z/GS4XC/iHtRC+WuNCnLW3uX1q+gMBFA/STURusWkm1BJD6U8u6AZSvqJ
	 loZPXxPlfTsVg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 18b062bd;
	Sat, 27 Jan 2024 01:53:34 +0000 (UTC)
Date: Sat, 27 Jan 2024 10:53:19 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: dhowells@redhat.com, v9fs@lists.linux.dev, linux_oss@crudebyte.com
Subject: Re: fs/9p: regression in 6.8-rc1
Message-ID: <ZbRiD2a6F9cDm_9n@codewreck.org>
References: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZbQUU6QKmIftKsmo@FV7GG9FTHL>

Eric Van Hensbergen wrote on Fri, Jan 26, 2024 at 02:21:39PM -0600:
> I caught a problem in the new netfs code when running in 9p when running
> with nocache mode.  A regression sweep is turning up a:
>  [ 1084.438387] netfs: Zero-sized write [R=1b6da]
> when running my ldconfig test (included at the end of this)
> it reports:
> /sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> I will try to dig into this later today if I have time, but not sure I'll get
> to it so I wanted to make other folks aware.  I'm not sure how much other
> elements of my test harness are contributing to reproducing the problem.


The syzbot report (refcount underflow[1]) is also probably related; I'll
try to find some time to check a bit more this weekend

[1] https://lkml.kernel.org/r/000000000000ee5c6c060fd59890@google.com

-- 
Dominique Martinet | Asmadeus
