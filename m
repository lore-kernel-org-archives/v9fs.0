Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C1A32
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737185295; cv=none; b=udzjAf3zs7S6jEUbUd1+eZxBRjzX0viPRs0iOREJDRIhfPZpPtanCt3hqlkw4oGT0eXkHxfTqoanVsa3zNFvnrTDl4JBMDADG0un2aWDAXBe6R3dczFQSMU74m2X1ta0TiUw3wQRt1o1tfnO0RMOeWe/NcX7XmhWKLb5RqzTiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737185295; c=relaxed/simple;
	bh=5cTli6ryIbKwBUU3SybmUVAv6fdBDoGwN7aeYz61+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI8nt/LatC15tHkzRcuu0lxjgrbpy5E/ktR4PMaVc/6i6Gk3S5WzThFJWejyQ5kVH8JYbxTBrLUU6KB62owxXrJqjrTCYE4eTTwpau8gKcgT+7Vhiulb+Na8DqmJSaeBh4ob4TJ2vqRVG8fKNejSOGoJNuoyGIyPVfAMcFC4HbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=1gZA0qWs; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="1gZA0qWs"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 52F6114C1E1;
	Sat, 18 Jan 2025 08:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1737185284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr7dac1zmqnrzqkesUpUOaL/a2glUcTSDtgEtcvSxag=;
	b=1gZA0qWsFc8evqVeAHhrmM0OGUL9ARJsocRhms52+RcUEhdE5P/6O4cLJnmKC5QaBwf/BB
	6uHPjFTQxIIaJi38GThWAJqRolxLoZiY0l4nI6KDmFYiNsMivYIdk47pK6yOzTLx2BcEj2
	LTI52b4rxnR5XluYw0LsdjyuRIEpY4TC/nTxTJ5UOVGFjerIjb6HsnRCdBguBJaJUsDPRx
	bJDcFQafnaTYccEO7/2PUtDuRlTGs1MOV2paCfZXI6Gs5IN/BaB6cGgrQhftVe5KP6VInX
	ioR95RrqlbESgu5h8YiYVEE/lVNNQ5kwQF6wJqd5xnkmlun2P0NIPNu1XXHdiQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 667a2b61;
	Sat, 18 Jan 2025 07:28:01 +0000 (UTC)
Date: Sat, 18 Jan 2025 16:27:46 +0900
From: asmadeus@codewreck.org
To: Joshua Murphy <joshuamurphy@posteo.net>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p/fd: support ipv6 for trans=tcp
Message-ID: <Z4tX8nnJAO8zw9c1@codewreck.org>
References: <20250117214943.6368-2-joshuamurphy@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117214943.6368-2-joshuamurphy@posteo.net>

Joshua Murphy wrote on Fri, Jan 17, 2025 at 09:44:46PM +0000:
> Allows specifying an IPv6 address when mounting a remote 9p file system.

Thanks for the v2!

Daniel beat me to the important bits, just a couple more.

> -	if (addr == NULL || valid_ipaddr4(addr) < 0)

valid_ipaddr4 is no longer used so please also remove the function
definition just above as well

> -		return -EINVAL;
> +	sprintf(port_str, "%u", opts.port);

Oh, I hadn't realized this takes a string..

The previous string -> u16 conversion into opts.port happens in the same
file (parse_opts), and trans_opts is only used to print options in
/proc/mount later so can be made a char * as well, but that is code
cleanup that can (and probably should) be done in a separate patch.
Let's keep the sprintf here and I'll try to find time for that later
unless you want to do it.


Cheers,
-- 
Dominique Martinet | Asmadeus
