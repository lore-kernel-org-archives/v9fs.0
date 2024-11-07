Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20118209F4B
	for <v9fs@lists.linux.dev>; Thu,  7 Nov 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981358; cv=none; b=XPgkCMB/jrY+t252kyVLOslxHZSRDjg2+QuUHDE2jk4zVE0d0WDimh9VOQ4lC3IphqpvvTDaI7TuJOhbKCqBDrtOqHYcMC+pofl+wT7V9Wm+XmtGGSV2n0XAWT7zDLfjtbOUn3DKW+s4BTKhdSjDSyJoEp+r5xlTC/Z4fTE+5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981358; c=relaxed/simple;
	bh=/9drwAQZ4B1kcyQrYubQ4oKjiSBhi8i9iVpWKQI/Meo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE88eNuvUnOhvxcNnwDxZAagEvd1eLgOdBB+67DaZfoAPSYJpfXdsqoPun9InSUbwcDxapkDMOBiwzKFbU1IC55CRp68CBRb3BA2omngWONLantgiOBIT6aHKyyMmJwaNI+pKdGlyw+fnS485oaOiypX0G1t8VnDBBdZrcjGsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3BicXjfd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3BicXjfd"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6E7D814C1E1;
	Thu,  7 Nov 2024 13:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730981348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1dSQjqgROr/M7ts/dndMf6m4fRKg6+zb+E0VD6A/Lc=;
	b=3BicXjfdxow0IfvtXWRetgBjceifSidGAcB2toFEDdSsh2WF7vlkZLx2FRlZwBMcax8ZDl
	8MAuwPjTDpfBK0zTttYeMSs2U8v84Z1OuRGBkIGz0YTHW+zd7C7+m/kr+PGl+JKAzRqyni
	Uus3wvGJTP9LbBvddm2ROLbhEKVeKgX2DDW3MIsFaR72VfuMVpZ3F05OaJfRYLYQRCnalB
	ylfcuysYGqseaKhf0RXrWiP2pK2XcSDgtwWA1B0JyWWaDVxxxXQoNNS+jZyQtAgBnqouiU
	JIbVO82TufStYVumK56D/AQ0ufuCnf1FPPVPRDJ2ZOe3HCmfnmJpRrMtMnPp3g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 362e5ccb;
	Thu, 7 Nov 2024 12:09:04 +0000 (UTC)
Date: Thu, 7 Nov 2024 21:08:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] fs/9p: replace functions
 v9fs_cache_{register|unregister} with direct calls
Message-ID: <Zyyt0XUv0Ypl56qI@codewreck.org>
References: <20241107095756.10261-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107095756.10261-1-colin.i.king@gmail.com>

Colin Ian King wrote on Thu, Nov 07, 2024 at 09:57:56AM +0000:
> The helper functions v9fs_cache_register and v9fs_cache_unregister are
> trivial helper functions that don't offer any extra functionality and
> are unncessary. Replace them with direct calls to v9fs_init_inode_cache
> and v9fs_destroy_inode_cache respectively to simplify the code.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks!

Acked-by: Dominique Martinet <asmadeus@codewreck.org>


@Dan, I don't have anything queued up 9p-wise so if you want to take it
through the janitor tree it'll probably get in faster; otherwise (if
you'd rather I take it or no reply in a while) I'll pick it up when
other patches come in.

-- 
Dominique
