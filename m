Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730B3DB62B
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191862; cv=none; b=XDGeXvuYQZ/CCKWYxDdlBU6C7sCxVeJBzAG5j9ae3SvfAYL13109bK7EPNMD3qlsraKUJ2iSnLzzGvmna0L+D8OUrK2nuSdrkHWrnkiGxhT8To/dPXBdfLGn/W5cf/D6SXcB2s4FuN3E6w7jgg5PRJPxFJG7CxICmDMSIra7/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191862; c=relaxed/simple;
	bh=4dPKQ9opV6gOooBUTbLMR8rKLrGkspBje29ouV83hm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFYMUvT1dBT5qjUy+vWkXWK+/um6B6LYv5Y1QAIYy6Y7ubpux92sp4wPiZE45y1U16vcznjWF1RxvSVxBnwZAVsTQ8GYJMiUfuXpjw/Es+4TMhAbp9L5dJWrMNPqQx2Kw8dlSMZH22qk5DnUFxR+KwFQ/eN0uR0no/9kp3O0Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NHH0yM0O; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NHH0yM0O"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 24C4314C2D6;
	Tue, 19 May 2026 13:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1779191851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Chm15fitpyfQYupOgZiAfu0H10bNgX3DVvg0qzfbx2w=;
	b=NHH0yM0OKo4wFpr6rJ6zyYaVznF99lZm8vpNIg4UEnlueLqHvB2L9e+euQn+EYkDpp9DUZ
	/ey30D2vBAiOvYLSGDKIbOi1zY31WIAkbaV7oqQIYsJNzc+Hj4VIixn3vZX3KGWoXeXA/u
	sFlzqYw8Kqfjfx0Nrk8RmLfRWvV9Y2o3Tk1TBnfZtVoHcPYYR/v49Un+IWmf0qbcFb/HSP
	eo+CxPzFewLLpP1pnehJYvQYgM0uJdmvmbK0Fb0Y+zy7YvYcBJdpSK+dSuiafFEe4cZz/X
	E5odtDZB7DsXIuvwTL5Jru2Bgg/qfSB/MMNX+bios5XereWgh3Tn7THVCrKSWQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7a5442b8;
	Tue, 19 May 2026 11:57:27 +0000 (UTC)
Date: Tue, 19 May 2026 20:57:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH net-next] net/9p/usbg: Constify struct
 configfs_item_operations
Message-ID: <agxQGEpSE9ytZSDV@codewreck.org>
References: <2478bdabd7d169a686879c049f11dc307b5debbd.1778922467.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2478bdabd7d169a686879c049f11dc307b5debbd.1778922467.git.christophe.jaillet@wanadoo.fr>

Christophe JAILLET wrote on Sat, May 16, 2026 at 11:08:28AM +0200:
> 'struct configfs_item_operations' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   25167	   9336	    256	  34759	   87c7	net/9p/trans_usbg.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   25231	   9272	    256	  34759	   87c7	net/9p/trans_usbg.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, this makes sense -- I've picked it up in the 9p tree

-- 
Dominique
