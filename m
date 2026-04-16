Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C713B58C
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776306684; cv=none; b=o+ry7zNOR4dDHnxf8BIDDzmM3sYWVikluPmjrWPHlkajEcChUQeuRLzcI5Som0saBpEX3RNh1AkUpBo8k2dZS2aJnLAoM58BSG8meQZqRqHmMMqGeq1NMC1I0jsvRsAdfNkIjUfSjID1+igy3Yg+vdH/DL+FH/7f8JBjGxYcwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776306684; c=relaxed/simple;
	bh=L3nEwYYKWud213QiKCH5nXb/f5LifqJnwiHbz8UTZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImeuO3lc3/GtTY2+DILfsEMydpKQncXgS1vqS1YsuJtH52PPl8csZ7Y+5LdkP8tfofg/HYbeSY6BRv55RsnNzUs1lNtU1ySTS8JY/0HfOx6bSD0E00h0x39+NEP1G64G8OtDoAXrSjHwYVJi7oPVsyUGT93VEn1FIDY/ITf0PSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UMSl+nVt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UMSl+nVt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D860314C2D6;
	Thu, 16 Apr 2026 04:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776306681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNFEcECLkjmnMv99mmT0WHYpKeBUVEBRN0ugXn5t+4c=;
	b=UMSl+nVt9lCTbm8mIYkAIGPpXue81qi83faRmu3X3JBh1EjlBsYDDcFLYFpFbIOBxHoaML
	AeyO07anqPRrWIMmWadxaqLqC3LGQFbdE2byIdz/oK1wkQefORikFV0XQTqxQZGkPIUmzt
	NrrM3Acq1iRAfBvnwGSnW6A1+Tir0TeFuKNBNkoDZsvROCAlxdQ2gNjByeXnjxDDGk2lUL
	KECLzywcxgq4CNn+tnv9zhQQGV0Lk/bNMpAcblX7QgWrK3ZRaQ5uV6CV51h8EZgRV5CIh4
	GEGVetS/uIllVHvVLYHH1lDJT4AacDnqd0BWFwn+3MxrxCoxKoQUPQd5BgOqzg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e2e13278;
	Thu, 16 Apr 2026 02:31:17 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:31:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pierre Barre <pierre@barre.sh>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: use kvzalloc for readdir buffer
Message-ID: <aeBJ5pT0WtMp-LO5@codewreck.org>
References: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
 <20260415100157.4aa33364@pumpkin>
 <a93672d6-1b99-4d4f-a8e4-c7f8b0d10b36@app.fastmail.com>
 <20260415113625.6d38441d@pumpkin>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415113625.6d38441d@pumpkin>

David Laight wrote on Wed, Apr 15, 2026 at 11:36:25AM +0100:
> > Perhaps what you describe can explain what I was seeing there:
> > https://lore.kernel.org/v9fs/496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com/
> (After seeking, getdents() returns stale cached entries instead of fetching from the new position.)
> 
> Absolutely.
> But the fix probably isn't trivial.
> The offset that you need for the seek isn't directly related to the number
> of bytes copied to the user buffer - which is what I suspect ftell() (or
> whatever gets used) returns.
> I think there is some mechanism for arbitrary directory offsets; but IIRC that
> requires the code put the 'file system offset for the next directory entry'
> somewhere in the directory entry.
> Such an offset would have to be one the remote system would understand.
> 
> A partial 'non-fix' would be to reject seeks to other than offset 0.


Thank you both for working on this and reviewing -- this is all
historical code that hasn't seen much love.


9p Treaddir sends an offset on each call, so I think it'd be fine to
invalidate buffer/remember whatever the client set in a custom llseek
function and send this to the server on readdir call, but I honestly
didn't give this any more thought than the past 2 mintes (I'm totally
swamped and can't keep up/didn't even notice the bug report this
december, sorry :/)
I think some filesystems only allow seeks to 0 already? So given there
is a precendent this might be fine, but I don't see the harm in allowing
custom offsets: the server needs to be able to deal with junk offsets in
read requests anyway, so it's not a problem for me if userspace can set
something invalid and get itself stuck on EINVAL or whatever.


As for locking the vfs takes the file's f_lock for seek, but there
doesn't seem to be anything in the readdir path that would do that, so I
guess it probably would blow up with parallel readdirs on the same fd,
and could use improving...

-- 
Dominique Martinet | Asmadeus
