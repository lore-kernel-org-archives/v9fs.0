Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515D2DCBF4
	for <v9fs@lists.linux.dev>; Fri, 24 Oct 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312891; cv=none; b=bshXE3jITKgXohpvKcwb+Mui0AyVKvvYrmlMQQQ/0ODm4cJIdunHvaXnJKTq83WOQC6HL1v2xksJmAGpQtU/YXHUpzO9cD9weMt3ySbD0tS3tQHGShfkcgZqeKuOzn7bzpYuwD8c30enFmj/ENFaqyiALEi9pcriEPqQq2vqffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312891; c=relaxed/simple;
	bh=j50UC3gpZzM+sZcUvUP6Ut3HC1+zm/hUKXuj616DXSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrX8pqzddob0PUCTDdIl9TFgoJL+1WGSQeiGt5wYojOztJ6l7CdtjCHwJKL/3uCf3WKrzlKzVIlyJC+45Gzj9A01oMfkxcxc38Ni1NrF9d1eCzYWV7h1IsJBZuawG8n5Op4QOvVzcsdMngj7dJz35WCdaXyNDHSxgYECJsCq/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jToRp2QV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jToRp2QV"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9D7B314C2D3;
	Fri, 24 Oct 2025 15:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761312880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1/r7129Thb1q07EWwLnDb7V2mKBqHDrr+sIHFTvGfo=;
	b=jToRp2QVbPYnRqiNsobWoAssQ3moE8bSJytyjP8pQA6Ho7wRDhiXWICqVyQGI2TO5j4sQU
	2AedX+o0qlGY5wiWfGb74FmCWVZ5irz30LuXgQG7oAHRjVA2i/0IjqOQULOX72aIeGF8Ie
	iJBqW/gF9zZzaq5sKaBqv0a4sIxu83Fo1QHY4bMZx1Nt5xV5smWAgNxFjTTTF8wk+zEN7U
	FQfmZ33ymbBvoSkoCwZkQ7OfO1nMJcvs4W/qhSoKPysqoTk/I5NoXOKqYJiBOH/TSCeB8m
	OZx+4+PAqKA7ejcL7m/PppdE/T82r0mkJa839BZfAIJdvaFSV1hVOghY6RgJ5g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 02b4df75;
	Fri, 24 Oct 2025 13:34:36 +0000 (UTC)
Date: Fri, 24 Oct 2025 22:34:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p: delete unnnecessary condition
Message-ID: <aPuAXaHNWMhZOeuv@codewreck.org>
References: <aPtiSJl8EwSfVvqN@stanley.mountain>
 <13655400.bYd4YqkHfl@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13655400.bYd4YqkHfl@silver>

Christian Schoenebeck wrote on Fri, Oct 24, 2025 at 01:59:46PM +0200:
> On Friday, October 24, 2025 1:26:00 PM CEST Dan Carpenter wrote:
> > We already know that "retval" is negative, so there is no need to check
> > again.  Also the statement is not indented far enough.  Delete it.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> Fixes: 43c36a5
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> 
> Apparently a manual revert copy paste error. The rest of the revert commit
> LGTM.

Ah, I left that part of the reverted hunk while keeping the HEAD part:
```
<<<<<<< HEAD
                }
                if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
                        p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to type change\n",
                                 dentry, dentry);
                        return 0;
                }
                if (retval < 0) {
                        p9_debug(P9_DEBUG_VFS,
                                "refresh inode: dentry = %pd (%p), got error %pe\n",
                                dentry, dentry, ERR_PTR(retval));
||||||| 290434474c33 (fs/9p: Refresh metadata in d_revalidate for uncached mode too)
                if (!cached && v9inode->cache_validity & V9FS_INO_INVALID_ATTR)
                        return 0;
                if (retval < 0)
=======
                if (retval < 0)
>>>>>>> parent of 290434474c33 (fs/9p: Refresh metadata in d_revalidate for uncached mode too)
                        return retval;
```

For a proper revert I should have removed the first `if
(v9inode->cache_validity & V9FS_INO_INVALID_ATTR)` too :/

OTOH it still makes sense even without the rest of the patch (the only
reason V9FS_INO_INVALID_ATTR would still be set is on type change, and
in that case we do want to return 0 even on refresh inode error)


Anyway, thanksfully this particular double retval < 0 check is harmless
-- I'll pick this up for -next for now but hopefully we'll be able to
"revert the revert" and fix the other problems Tingmao pointed out by
the time we reach the 6.19 merge window...

Thank you both!
-- 
Dominique Martinet | Asmadeus
