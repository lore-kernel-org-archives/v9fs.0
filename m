Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892A3B8922
	for <v9fs@lists.linux.dev>; Tue, 22 Sep 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066879; cv=none; b=ZUnsTbcpcDkIAkwrwE4ZP8m0X7/Fw+N5mIre1YIPt55f6xg8IZhTkH3GQBRsfkJOL27uP1S+9Uj6VrvN2D5RYdHgtlvSEwFDB/jiPf/Y3AhU9JsZJNgeNy6OgAEJTkrqSKKScIklghCvYym7U++M9jeqCEyPSaqBk589Pgg1CNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066879; c=relaxed/simple;
	bh=HYBBPq2C8/scO5vMh5BM7GPxkjTYDwN9/krhBR0OWdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJxFkXhZhvYS1Wt2hGoE/PWraUmvSbpDOq0eIKKECujmy8mXPqpIaB1QWPKn0KZqZSvNa2xwCD2KBKJwhq5UIwX1JrWQsSwUM5y8PQv9pdKYjO+zg4Mp1HEYkzmeeqLh3IfKJGtXxrHMig30qmq9YH/H8yqhz9WwrAPK3G0nE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=n3e8iavL; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="n3e8iavL"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A7C7D14C2D6;
	Tue, 22 Sep 2026 10:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1790066876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Lp/uaTJFIwfnxHOSctS/0LIEn2qNu8pB5WlDKG/3OM=;
	b=n3e8iavL1MBV2ILxbbG0ij1hpKL/oOexDoPC2Ir1+VZQ0zZcfmUPMWZu3nJIcdhFnz4R9N
	lYnYL6n6afBnSJWZa84pKKBej0XQERBFt/e+N0LyYOKpUWTsbxCGcbzaKYyznSAtFG/Vbp
	byywfnEG8AhHpB1mqmoaAEfWkPBoaduNeTr75kZpwyjdQdoBBDXaqLdIGPHXdMQ2QeMKM6
	wS9DP92B8HDUfWSoaUcSrSSc0Qy9Tf4Z1ej4dIJVKp9GOh1TBgC2k84sPsA6e1YGYR2/EO
	/dM1YupCY/V5JagmUv4OwEuVe+NB3wtuyXIQ/KupOePxzE7uGJrn+4bun9PkJg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7f290b15;
	Tue, 22 Sep 2026 08:47:52 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:47:37 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hui Peng <benquike@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: reject RERROR/RLERROR with zero errcode and guard
 0-link drop_nlink()
Message-ID: <arJAqVPrm1XfL1w-@codewreck.org>
References: <20260919221734.3708000-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919221734.3708000-1-benquike@gmail.com>

Hui Peng wrote on Sat, Sep 19, 2026 at 10:17:34PM +0000:
> Fix two issues in 9p client and VFS inode handling:

Please split this in two commits.

> 1. In p9_check_errors() (net/9p/client.c), a malicious or buggy 9p
>    server returning P9_RERROR or P9_RLERROR with ecode == 0 causes
>    p9_check_errors() to return 0 (success) while leaving the unparsed
>    response payload as if the expected reply message type succeeded. Map
>    ecode == 0 on RERROR / RLERROR to -EPROTO.

Sure

> 2. In v9fs_dec_count() (fs/9p/vfs_inode.c), only call drop_nlink() when
>    inode->i_nlink > 0 so unlinking an inode whose server-reported nlink
>    was already 0 does not underflow i_nlink and trigger
>    WARN_ON(inode->i_nlink == 0).

I'm pretty sure this is racy but the dir case already is anyway, so meh,
why not, ok.

-- 
Dominique Martinet | Asmadeus
