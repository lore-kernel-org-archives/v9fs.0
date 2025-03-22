Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634F1DE2DC
	for <v9fs@lists.linux.dev>; Sat, 22 Mar 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678884; cv=none; b=Iuw5zhS8ID0bb9FlJxgz8n3LNaI8SH+/nX3EcoiBVFKS4eF2FjaNvPLVkmj5khjNfxvaOcpGT1XGNaw4dpmbISPVlDTLHzuLghT0jWM70P9+nYEt4gn5Zfmk5gRIxV7Z5DZQTTM4haccfwiVxEMPQJgYqvR9Jnu8gK4OXXCMACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678884; c=relaxed/simple;
	bh=20yCmNw+QyfnwkRDsX+TL+ca4UDmjCz3rrUZ4a8soRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQBZMU0LUBd1st7P80LcjbeKQrDS/N1+nEkWxYNzp9qEzPPz1Oino1ceVSTWFWMQQbf15qXOkQAtaq4LPDbF7z13IShY7J4JAr/AINJsmq8ve9+Sb7x1YmLN/AkMIRTr38H47DFQzGdWrY/VQ4IDnYcfK3LPUEMOB3yRoprX6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=D4BDkLai; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D4BDkLai"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 493F614C2DB;
	Sat, 22 Mar 2025 22:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742678881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u1yOfLqG6Yy5TZ+cq9/fOzYgeoaRmP3HAHZBaFpqhY=;
	b=D4BDkLaiESkGogJCUHlQYUwOZkVYFzY65sAhqz/GOak63aUtKlYo8XpAR/UhBVQnoavBsr
	sXF1OGryOPpH+/1zKIsRkSq8XIl0C0u9OYBtU3xSAGBwyjbQUnN09+XT33HLoCR08QbPOH
	alBFTwCATq8hd4jtCo+eUHR1eIdPLhOTzDC6n0K2RqG2dycBBIiOEGjnab+Fo6TyTmO+rC
	lvRBTDSV3WxhdY9k8IwD3IbGAHQMEe+hBqNvtoEf3wm09CWD41HCWuRZUn10N6wQUtf2PR
	UtJNPFsdPEWaA3VSAihcO/W+ZW8oGwZoSD73f55B7tCYqdjbc8YyVHPD1TOXqA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f7bd787b;
	Sat, 22 Mar 2025 21:27:57 +0000 (UTC)
Date: Sun, 23 Mar 2025 06:27:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tuomas Ahola <taahol@utu.fi>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/fs/9p: fix broken link
Message-ID: <Z98rTkLrIq5wEw1a@codewreck.org>
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

Thank you, applied to 9p's -next
(sorry for double reply Tuomas, I had apparently missed the reply-all
key...)

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
