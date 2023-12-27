Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE56FC3
	for <v9fs@lists.linux.dev>; Wed, 27 Dec 2023 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cOHICrUt";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oJni+N/2"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 0AF67C01B; Wed, 27 Dec 2023 09:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703664666; bh=5XoClKibf6Zlh/1JyeRji9d9fayCdX9Ovc/74tpcSvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOHICrUtBQ6sj2Kg2IuG/4Ekt2CHtR7q22DzIqPU38EFsvD1tv4J50Ri1rGCnsaC5
	 ufFwhHan8QNMGavM0QTU9mOPPi/YxqQDNsMSRJbJcCy3S/hGzqSwcyrHiXadRDyspF
	 Jmc9XtobkkYNpvIDUMDq2V19+cwSiVZYDF/AaXsY674lh56ynOn58hVWlWkOidDu1G
	 1Xpda/LF18rCNvKCJxu+RhLNMQnxpvWDY2x7xePgTw6YfT2ABJWLT2k/og6fZh3cjM
	 BNkQma3APoXyy7780vztgNGCWuHgUnFskFaylLVcQiJC9lxzgqwFUJ7MMczgxXVKgA
	 2Nej0+Dtxh5QQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 8EE60C009;
	Wed, 27 Dec 2023 09:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703664665; bh=5XoClKibf6Zlh/1JyeRji9d9fayCdX9Ovc/74tpcSvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJni+N/2o+0f9OmjjLfhyylMgCE9gaMpxMR81dkC4wErOtH7lsGAHGF7sFGVWXv1D
	 n1nou0S60/Xj0V6XPtspUoveXTohEz0UbM3S2jrPt2PlVZLMqR++26Dk4Q/VmEWyAe
	 aopEZm8xb1mEwpCU8rXBUh5kJx1dZ0sz+IHZkWdiUr3doEJBIab4OpKTjkqcXmePSt
	 X35M+uCp6+2o3Mf4PJECC3wJYW+oXZmIpq0URv+uczGOzXGSeiRyurkmGNntrQmhZq
	 aOK4xz2NuqVw2ZwjG8Sg2o4WixjtFG2trBBSvQA5m/JXKwrvubgq0irD6M0CqePaQg
	 0BBAAYinpNaZA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 6181787c;
	Wed, 27 Dec 2023 08:11:00 +0000 (UTC)
Date: Wed, 27 Dec 2023 17:10:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: v9fs@lists.linux.dev, Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: cache fixes (redux)
Message-ID: <ZYvcBbcNOHEQ-JMw@codewreck.org>
References: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkjPTk-kgjejhMs1q5XB_PMhVk8awhevkPkxQwQCPNcUSwdAQ@mail.gmail.com>

Hi Eric!

Eric Van Hensbergen wrote on Tue, Dec 26, 2023 at 10:13:20AM -0600:
> - The fact that we never seem to use multi-walk (this isn't a cache
> specific problem, it actually is somewhat worse in non-cache mode).
> This seems to be because fid_lookup goes recursive before entering
> multiwalk.  This should be a fairly simple fix - I'm just going to add
> an argument to limit recursion, but I'm noodling on whether we need
> that path a bit first.

I'm not sure multi-walk is possible in practice: even opening a file
directly through e.g. cat /mnt/long/path/to/file will have the VFS check
permissions along the path, so the VFS will need to stat all elements
along the way.

If you can get it to work though it's certainly worth implementing the
possibility, let's give it a try.


> - figure out why even in loose mode we seem to be sending a lot of
> stat/getattr -- this seems to be related to some code that came in
> with the cache code.  It seems we almost always stat/getattr because
> we are constantly creating new inodes.  There's some comments in
> vfs_inode.c:755 that talk about needing to do this for parallel lookup
> -- but this all seems like a hack.  Anyone have better insight into
> why we need this?  We always to the stat/getattr to retreive the stat
> to compare against because we don't trust qid.path -- which I think is
> wrong.  If there is an issue with unlinked files, I think we can do
> something smarter to differentiate them, maybe using a qid.type

Hmm in loose mode we definitely should be reusing the inodes...
No idea why we had this in the first place, I'd say rip it out and
compare?

>      - QUESTION: it seems like P9_QTLINK and P9_QTSYMLINK are no
> longer used, can these be recovered?  I was thinking of reusing one of
> these to mark unlinked files which we could do a more comprehensive
> compare for if its actually necessary.

Since we don't support reconnects, unlinked files have been working just
fine with servers that keep the underlying files open (e.g. qemu)

What's your plan exactly?

We don't have any way of driving protocol changes forward (and there's
no compatibility negotiation on client connect...), but I recall
Christian also was looking forward to some other changes so we might
want to try to move this forward again...


-- 
Dominique Martinet | Asmadeus
