Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B335DA53
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019485; cv=none; b=P4yJqSvFdp6BMrKqY3aqRofKZImNJPgseNBPz3kaU2r4jOgDoASyJHGDfMV1Rp0R255UoXSXaTqxbiBwJD2Zsiz2+ojw4DYqiSjA/AwugdJ9n2JquVACjiUCvKS1gssupO3ao7SAuQaIzrM+a/zLcsN4C3DWpAGXg/7spAezHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019485; c=relaxed/simple;
	bh=fqq21v15RPx1Rh84bVvFeMQ9Bl5lBwGOOcLH5C32L08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNrAnaM+BjBabIRpKoagZz5yEYa5q2bt45B/9faJxrAE1oCuRJ7U+AigTrfMDwlijiV6yv3/5BYkWZBbpt0NYXclCFQOx2DtC6kyruTT1q5H++J6pL80S1KqqJQ4LubOL4fdmBM4JaIl5jCTyEjDaPZp/Te8/xWNd5fPVjqnMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3l1ccd/s; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3l1ccd/s"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1CCE214C2DE;
	Fri, 29 May 2026 03:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780019479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZxdwFMzc6brX3cLB9sUc8WNeZOIPdhM8Hcj9v1X2TI=;
	b=3l1ccd/suhuJaUEEnBVwNc0ku1zS0kePM/evo1sgCSC82YxXSvg0ya/50+jrUzq80PvqKU
	esu6GruCKBSsvxITCAxWI3e85bkXbhQ2wYLZiX6V5pdKXJJiALD6Pje/qJkZvPR2gNyyym
	V/sVQOZc2vj6C8ft+hAfMw7hpeStIga/trltLirvjlKNF/MKPqXFl/+LyqCRHXnQI/iIvi
	yFkvTtVr8dNQ7I9jAeNfwYZwTN9tUiHfFGQMgI6DYQGuWXStc+ecjRReRMzIkRqRVjkmFk
	x8/nclytoZcbHh5sHjNu0uRNjZgCXeGfllIB2rJORC7lfo/2JxKyl1UEDe8h1w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9d59e7a5;
	Fri, 29 May 2026 01:51:14 +0000 (UTC)
Date: Fri, 29 May 2026 10:50:59 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] 9p: avoid putting oldfid in p9_client_walk() error path
Message-ID: <ahjxA57V3QkISzR2@codewreck.org>
References: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Thu, May 28, 2026 at 01:39:16PM +0800:
> When p9_client_walk() is called with clone set to false, fid aliases
> oldfid. If the walk subsequently fails after the request has been sent,
> the error path jumps to clunk_fid, which currently calls p9_fid_put(fid)
> unconditionally.
> 
> This drops a reference to oldfid even though ownership of oldfid remains
> with the caller. If this is the last reference, oldfid can be clunked and
> destroyed while the caller still expects it to be valid. A later use or
> put of oldfid can then trigger a use-after-free or refcount underflow.
> 
> Fix this by only putting fid in the clunk_fid error path when it does not
> alias oldfid, matching the existing guard in the error path below.
> 
> This can be triggered when a multi-component walk is split into multiple
> p9_client_walk() calls and a later non-cloning walk fails. A reproducer
> and refcount warning logs are available on request.
> 
> Fixes: b48dbb998d70 ("9p fid refcount: add p9_fid_get/put wrappers")
> Cc: stable@vger.kernel.org
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM 5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

This makes sense, thanks.
Queueing the patch.

> ---
>  net/9p/client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index f0dcf25..4b942d0 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1092,7 +1092,8 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
>  
>  clunk_fid:
>  	kfree(wqids);
> -	p9_fid_put(fid);
> +	if (fid != oldfid)
> +		p9_fid_put(fid);
>  	fid = NULL;
>  
>  error:

-- 
Dominique Martinet | Asmadeus
