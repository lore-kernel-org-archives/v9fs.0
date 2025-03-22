Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105618DB14
	for <v9fs@lists.linux.dev>; Sat, 22 Mar 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678444; cv=none; b=hzYnaJdbDf01i1YSbA4xIALgbJwDF8kucx3EJi43NxjJlOWOFQURrm979hdEJ20lxwNwRsP01nxv8hBeAG8qer0bKe776DIP1CoSYqxryhTfp8CI+ROjgzEk+HK3t89nx8/ZVa/NuuulnLLF6jlNVuq+G08fEEnHczo2IWYneM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678444; c=relaxed/simple;
	bh=cyFNK89NgMLZ3xDWkwxzV2SM3xQXavlfGlrHVOrvwmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th2UvIaWt/B2xvru5EdlxMnisUa8b0tSM0RRfwFuo3joSkji8+sOsBNIMO9/3RICcNrm/6tYSU1w2Lt/Tb3cfLV+365hXOgwks2BF3uyhjrX9XLl2C3DPA6VT9+oWMghzMZ/Ry51+0/5gIxBJWKnnDEQjmz6rqyp12TkVykz95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qr/+QTY7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qr/+QTY7"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7195614C2DB;
	Sat, 22 Mar 2025 22:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742678433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0TjEf7FGRwFB0dAZVdeDg8D+prsnYkCAo5szH4wkaU=;
	b=qr/+QTY7h9M8K+P97DGzWaAdHE/R8xPrJW5EugVRavIhoJNuQTPW1tarPA6fWVUYFVGmRZ
	FadvjOTVEktYqP9UdA/lko52/QS+bUnU6eBEGNA/B7vI/BiwGEWW6QYKpxcdXDg3ZmiQJD
	CPJ4kWl8a4GMDy3Wh2zhxRKINNPWGHwmsya2jost7HOqQZpp9WeM+8DLKj8WdJjSWB7H2B
	K0MtFnPtyQNFioTM+vo2V9Vy9zgjwZXHJpasjgeUsVQ4MVME6bTTyOlI4ZGuXXL3KMttA3
	fOKV6C7kPK+HiVxXGi6Wu2MdN+ZC39fqt8iLgAEcR3+goHV5Rlzrorpb2LpPQw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e68e2ca7;
	Sat, 22 Mar 2025 21:20:29 +0000 (UTC)
Date: Sun, 23 Mar 2025 06:20:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tuomas Ahola <taahol@utu.fi>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/fs/9p: fix broken link
Message-ID: <Z98pjo6ptwNee8d7@codewreck.org>
References: <20250322153639.4917-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250322153639.4917-1-taahol@utu.fi>
X-Spam: Yes

Tuomas Ahola wrote on Sat, Mar 22, 2025 at 05:36:39PM +0200:
> In b529c06f9dc7 (Update the documentation referencing Plan 9 from User
> Space., 2020-04-26), another instance of the link was left unfixed.
> Fix that as well.

Thank you, applied to 9p tree

> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/filesystems/9p.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 2bbf68b56b0d..28871200e87c 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -40,7 +40,7 @@ For remote file server::
>  
>  	mount -t 9p 10.10.1.2 /mnt/9
>  
> -For Plan 9 From User Space applications (http://swtch.com/plan9)::
> +For Plan 9 From User Space applications (https://9fans.github.io/plan9port/)::
>  
>  	mount -t 9p `namespace`/acme /mnt/9 -o trans=unix,uname=$USER
>  
> 
> base-commit: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15

-- 
Dominique Martinet | Asmadeus
