Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FB3CD8A4
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306458; cv=none; b=hjDUXgwM/1mbObuasRdOY4yilZcv1zWmNJaftLPcDhU9tjXGjNdakOMVeJekHD1NAfD0GLBsCPzrU6cIoKbpuX3cgstNgipWyuKlKlYCPs3fZ8n8F3hRCplGvMt84UWCmFpx6vHise0QwkLb0emQ+cSM/7CkY3++zfLACTewFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306458; c=relaxed/simple;
	bh=QyhBC7Vz2xk+HtXK9WdWFULIwQlWf4RSU/Gb+57Y9tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB6iuAcSf+XuyPy+QjedYSXp1EJd39XCR9caL4YixW7D2U8T/9dBE/zHA1y9ZwUEnlrqAzOpYUyqjmD8KqnVKRytZC2algWKmMWgsqsp4QwJ6wvLhP5JR8IsEyzJaA0hpadGjvDeKvwVbEsq23gRxpYzmAR+f8QOSHG7ub0FdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Pygf3Ubw; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Pygf3Ubw"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2971614C2D6;
	Sun, 13 Sep 2026 15:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789306455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAKCn9iFX1Ni+rniHWj6fUbOT3GCYgJfSvaynzBcuTQ=;
	b=Pygf3UbwCxIwKIQir4uOYdxI2gGV5JILyXA3o3qEXLS9C3FSZgslQ4/gYRIrfZOW52JQHM
	4iWSLx7o55Ipxr2cPPscyNvwWVrAicDcFTP5yd/TtYoVtTERBS/SbSsvGIXYuH4LbSshBy
	Yie5pRg+8e0Oa7Vr9z1MWH6LIUjPXcXAU2r7KDXg3cjktoOVQrt0FG/YtvNQ71GF92XprM
	/8Vjk8crzklP8UnHRC8MAve8HdvEoi90UT/DJwKyxM5jNEch2dz72FWYZUUZQOxbcO61Hh
	xxMsB38aR07K+8LPI5/02rmIPUeylHaTOSUgOtHgK2ykNSftnXRUOMezwuFXfA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0c35b757;
	Sun, 13 Sep 2026 13:34:11 +0000 (UTC)
Date: Sun, 13 Sep 2026 22:33:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
Subject: Re: [PATCH] 9p: don't WARN_ONCE on racy symlink fid lookup failure
Message-ID: <aqamRApMunI1mef9@codewreck.org>
References: <20260725014448.18711-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725014448.18711-1-kartikey406@gmail.com>

Deepanshu Kartikey wrote on Sat, Jul 25, 2026 at 07:14:48AM +0530:
> v9fs_init_request() WARN_ONCE()s when v9fs_fid_lookup() fails for a
> symlink read via the page cache. This is a benign TOCTOU race: a
> concurrent unlink()/rename() can remove the target between the walk
> finding the dentry and p9_client_walk() completing, so the lookup
> legitimately fails with -ENOENT (observed: dentry=/file0, err=-2).
> 
> With panic_on_warn=1, this WARN escalates to a full kernel panic --
> an unprivileged local DoS reachable by racing mount() against a
> concurrent unlink/rename.
> 
> Return the error directly instead of WARN_ONCE().
> 
> Reported-by: syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=344c09c64fcd8d3d2782
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Fair enough, picked up for 7.4
-- 
Dominique Martinet | Asmadeus
