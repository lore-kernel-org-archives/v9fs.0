Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B204405;
	Thu, 25 Jul 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939477; cv=none; b=PEvIeTAcERhY6r9hX5ZpcLeZeXPHO5c0EcK2Q6j0tW8oX+3AAr0mhV4R69JZc4QwX2AutyyEAr9d3BYCUanBBHvRcvJWM33RJbeJ/HDezk2SbCRPgIW6NBnj1NYdkq3H5JxJC2QrswsbRPA6NbCjHn7JLCKWZ85c/XyjGmDQoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939477; c=relaxed/simple;
	bh=lfgzxkQJwbqFQ0S52vTyI2lNmUFIUL88s4fsxW/RFSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHF6t6SIIC2r33cyeTM9GFg0HGI7gCq4Z6RCr2rTPW+4tskXzct5nycUEIPqrZn284p4J3N8d63/x3av1JFK/zPRnAC+b5yp8sf/MObOM/JIvsk5dTBtRmsJIwVFquaEmnBfqVeoYtToPgi19v+419x+c6Y0xfA07HxoC5SCxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mwh0ZV4p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwh0ZV4p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NVbUcWjZLcESkt7nEQzUppDtjf4hflsbCAK+Disbdno=; b=mwh0ZV4pXVPQoaP7ucclB8fLl5
	IzmCAKSPiUbz6r9+SNgnxbGJT4xBn4HVZ9jZwb83uPlKEiiDIi47S6UCMujyOF4olhf3DQuWR1Vqo
	9WHiA7JriavcXKWeYEZFu1/9cEsJ3IGg42tbZdvGQIyjq6T+2A/rNHPfVGvUCnHy9FNNGe5Cd6jgK
	oElNWq+K66uazDRlw9A2ZYYRNFuEPxK8aMgpmh8DLA4PpIALqlDjQNIkPs4k47/leUygGyzgEO7vl
	gUPmpZLHjs0FjI8toCImFxfQrG5NnKqiI22yX2Lm0P2d8iQY8YZJpOiE0hbugIxIS8ui+qSOYLEsS
	/knIrBlw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX57L-000000022kC-2TEm;
	Thu, 25 Jul 2024 20:31:15 +0000
Message-ID: <55d1afd3-8ac5-4674-a8f6-e5bfc8a72f93@infradead.org>
Date: Thu, 25 Jul 2024 13:31:15 -0700
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/fs/9p: Expand goo.gl link
To: linux@treblig.org, ericvh@kernel.org, lucho@ionkov.net
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725180041.80862-1-linux@treblig.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240725180041.80862-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/24 11:00 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The goo.gl URL shortener is deprecated and is due to stop
> expanding existing links in 2025.
> 
> The old goo.gl link in the 9p docs doesn't work anyway,
> replace it by a kernel.org link suggested by Randy instead.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/9p.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 1e0e0bb6fdf9..d270a0aa8d55 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -31,7 +31,7 @@ Other applications are described in the following papers:
>  	* PROSE I/O: Using 9p to enable Application Partitions
>  	  http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
>  	* VirtFS: A Virtualization Aware File System pass-through
> -	  http://goo.gl/3WPDg
> +	  https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf
>  
>  Usage
>  =====

-- 
~Randy
