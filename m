Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9635200C
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019756; cv=none; b=jQukjVdJ7TG6R5tWN5IbRYUAsz1AyiDdoAq14c1HiH2/EltAHUz8RSMgKsPG3XCe1IcHjjG+2dsSL22GdNyfAKOoQGV3MQzu/wrHr5RIKex9NC2iXOsEmGFsWEnEBf6Se6TMp+tHGbWwrCWMXIx0I2WhYrpvwOHMIuPwZ+o6B/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019756; c=relaxed/simple;
	bh=BokC5YcE9dLmWV3dKA4g9fWBviGtcpu9HIVzdHN5iSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpYAQ32des3bBCBIhJ6UwE1C/Uv+jWPe+nhW9o7ejFij8Ngi4LoyDzfb4+oKvLFeoYNSUiyCFaZXyjEhhq0JbZ7TkQfNo2dJtNTXJGBXsItaiKtncJby9TXK5ys39EktpwDlD5skfVksEsbP94JqnY/utZfnPN+AJJXAB7A17Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zfvWLCob; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zfvWLCob"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C7E9814C2DF;
	Fri, 29 May 2026 03:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780019753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9rGhV6A2tWnycYhVa6BLhuk5wk5IYG9DpGJAANNf6Q=;
	b=zfvWLCob+y/K0Eu/i/5Oy1+Wo9FIF/dQBAtP1+NP/2aIGUT+I7S7rFW3Ta1KefFrH+mv0v
	ulAo2GuCtNyhrcSHpusrQd1RIXNMOXthbQyQFzasGsMXyCD0wup89DFSO+Nud1O9vEGNGP
	aFS4E+Ie7eCxt5uRtRtQ3L7CZ8bAKOUUS4Q/BCl2LvUQQ06Hfc5sKZaX9d34Pvo8sGv8pL
	RPxz9Prdr+Hei+W1yB0dKR3l/LjXjCv9BPsAonyKChvhvJnaH94IWiOBEkG8lsIRBNpTYf
	jlQgSJfXHVNxnP/rMfFQjgfBimbYrrZrLWZd15lj00HcUKnLExcJbuqx60+kaA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e2359820;
	Fri, 29 May 2026 01:55:49 +0000 (UTC)
Date: Fri, 29 May 2026 10:55:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhongling0719@126.com, David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2] 9p: avoid returning ERR_PTR(0) from mkdir operations
Message-ID: <ahjyFpRxu03SuyMA@codewreck.org>
References: <20260520022650.14217-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520022650.14217-1-zenghongling@kylinos.cn>

Hongling Zeng wrote on Wed, May 20, 2026 at 10:26:50AM +0800:
> When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
> ERR_PTR(0) which is incorrect. They should return NULL instead for
> success and ERR_PTR() only with negative error codes for failure.
> 
> Return NULL instead of passing to ERR_PTR while err is zero
> Fixes smatch warnings:
>   fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
>   fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'
> 
> This change does not alter the runtime behavior since ERR_PTR(0) and NULL
> are equivalent. However, it improves code readability and silences static
> analyzer warnings.
> 
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Thanks for the v2, this looks correct to me.

The commit message should mention that v9fs_create() never returns NULL
and v9fs_vfs_mkdir() can be simplified accordingly, but I'll fix that on
my end

-- 
Dominique
