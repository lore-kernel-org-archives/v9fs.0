Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0A2580F1
	for <v9fs@lists.linux.dev>; Wed, 19 Mar 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377385; cv=none; b=VwtyoDZ6nV5FNzF+uPaiRpCN59BJplZDaF/juwhKjD9RPeCsZ3VDHTXYdY7nIsNd8LoJUELUXzX53XescMQKara2cRKXKb9+XArn3SUBX2A8SpxID7XHMaP+DttbAHVA/HPaCFv0Hh103MrJErX44NB4fFFViH5F6CK7m4Yh3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377385; c=relaxed/simple;
	bh=a08oUPbwuS6nN9FHd6HDJcvlBbcFvaP2yPfm7m7N9n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nySzoE5SR65dUHRh/8MdRMV0S0A0Wi15ltCKZV9n+dEgWC3jrGanSq5nI8YWmXjhK0MkGT/YeckbQTXV/bH6JxcKTnd4jZ2w1w6QXXjw4HJLu3hT3MiyNgPBd+EOILxnRrL91uqURPFCuM/xsrvW9SsIXxj72uBqe94SQctQ39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Usi/O8Ba; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Usi/O8Ba"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AB55414C2D3;
	Wed, 19 Mar 2025 10:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742377381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f+AQeejVTY/DGRBNn5El3IB1En7TrUCw2+0mWS8+fmI=;
	b=Usi/O8BaHi0g3S7ri9dCiH+taynoA8eSC5LXhMHl3RAfDZzxS/u+spawDhiCjITTsSq4k4
	BEQRqz4sPufBvlCCutsnd7wRrjgjvdIY3KY2e0Ab9ziZ3cV1TgEWoaebq65ht9fniciDXw
	a3jkLt0Na76AmXKGvbEU6YyX1CYM1S/f3DgqK2jUTFNfANovC7nPlCBtxhM/ZMtRyiok/N
	TzqOj3vwmdx1OdTCJOsNyxgDoZmApCTEEoeMhyBNlRB2rpnVRrMqdTV9RzSoryEqHmR5z0
	g7S+8cJZbNjAYRCNb1mRjTjdx4X8vDmDqtKreNeQcKCbOTyU18mU2HtDo9Q4Ng==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 64fba2f6;
	Wed, 19 Mar 2025 09:42:57 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:42:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robert Morris <rtm@mit.edu>
Subject: Re: [PATCH v2] 9p/net: fix improper handling of bogus negative
 read/write replies
Message-ID: <Z9qRkkLhFOK7Pl2F@codewreck.org>
References: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>
 <2056162.6bbq6Mt1IA@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2056162.6bbq6Mt1IA@silver>

Christian Schoenebeck wrote on Wed, Mar 19, 2025 at 10:20:05AM +0100:
> > -		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
> > +		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu (/%zu)\n",
> >  			 fid->fid, offset, rsize, count);
> 
>   p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
>            fid->fid, offset, rsize, count);
> >  		if (rsize < written) {
> > -			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
> > +			pr_err("bogus RWRITE count (%u > %zu)\n", written, rsize);
> 
>   pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);

(Right, got these two as they cause a warning with W=1)

> >  int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
> >  {
> > -	int err, rsize, non_zc = 0;
> > +	int err, non_zc = 0;
> > +	u32 rsize;
> >  	struct p9_client *clnt;
> >  	struct p9_req_t *req;
> >  	char *dataptr;
> 
> Missing change for:
> 
>   p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u",
>            fid->fid, offset, count);

Oh, this one doesn't seem to cause a warning.
I guess it doesn't matter much unless we get something > 2^31 but might
as well fix, sending as a v2

-- 
Dominique
