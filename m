Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0B188704;
	Sun, 22 Dec 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734884052; cv=none; b=QnRx5DNplZrcZe9e6cY8OgjxVMTGwLsFIF24rsEZlssBjwNjTZmQEHLHaqQMt4JfmY01pMyvVQCdv371O0PrLSSnlsPKJkNWDOe+51kkX6Z/D8qi2P8klky960WKkCpb5yGTIyL+UqQaTL5j0VI4QIGaSgL2/FVncYGuOi4hBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734884052; c=relaxed/simple;
	bh=o5xSuusLjZ/vh3RkXkHdCortUWTceCMvP7ek6A8euQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F63RbyikRy3nUHfmy5IkbonY4nds/InulaPtOxYFMOSwL/DvPZjJA+B6rfDbklCbOHZPsIjX5W84soVG1KmkJ28902UcqgWBQPOFQDGepAmQLENUCvucNbhAHC8S5Ydgw6+JUjf80GaS8+rMcN0PeIeubwQIUGs7aH/0J+rfJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=QOrJSIJ1; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="QOrJSIJ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=r74tdFu+KEe3Pgsb8TGCunJr9cOrpvPA0zriEIiTRNE=; b=QOrJSIJ1a2HlPyJJiSW+91yeSv
	D+JAsPR2v6BqLxsSTPaHxCvZkbfqKB/PgXcCpGmyEHwuiX7iQbTSWj3Brhf1InifXj7gzPPXJ3KUC
	tPj/RDxAv11RmGvlaUs+rGvnpDQr2y6LqPutcH5UCElcmngomYPRsGoojIaKzXpN1tu/8QRxVr1T8
	oQpkPe477zIeAko4XghfJoT09NFdG4bANUFKJfg7g3CuJZiCEUCqk3y/ECftj7V5nWu22ZUshGQD4
	3QUQ2Y4OxqKZ9Gl51u7KACCz/IZB2lp3U9K6e51iprEWA9+QvA3gOaFCg+oARJYTIHT73ck9wOTFO
	KgsbmCwTzt5e+dFCv+xp9SHf0ToPiR75ITkmLSBTi3E1/SlzbG0bTtvQSVSucD18COgDVs4PCujcj
	I8JxOub5nBfMaz3wVplvir/SA82US+JdB1u9c1V1PO3RXrig5zLqFEUVergyOOAIab0HZ9CUdWk82
	a0fiiibSEZdAeocqkp79T7zsRUO6rmQlEjp8XWYXWaFONHv3V2YwQC+VcMyBMSgK7DRCZe6IfHKnI
	+bt0KalTUy0P9UJ5cNX0jXeZTUBiY200RR1xOu+kgGJMON2xaZjPmltKBa00XtAYzkxjdajm0XN4g
	7H6ZwY99d4Zh8oQK0zCgL5oDgIu8rGGs6y0Dv5XJc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robert Morris <rtm@mit.edu>, Dominique Martinet <asmadeus@codewreck.org>
Subject:
 Re: [PATCH] 9p/net: fix improper handling of bogus negative read/write
 replies
Date: Sun, 22 Dec 2024 16:29:58 +0100
Message-ID: <4171850.H1WhmIdAfj@silver>
In-Reply-To: <20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org>
References: <20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 22, 2024 2:57:48 PM CET Dominique Martinet wrote:
> In p9_client_write() and p9_client_read_once(), if the server
> incorrectly replies with success but a negative write/read count then we
> would consider written (negative) <= rsize (positive) because both
> variables were signed.
> 
> Make variables unsigned to avoid this problem.
> 
> The reproducer linked below now fails with the following error instead
> of a null pointer deref:
> 9pnet: bogus RWRITE count (4294967295 > 3)
> 
> Reported-by: Robert Morris <rtm@mit.edu>
> Closes: https://lore.kernel.org/16271.1734448631@26-5-164.dynamic.csail.mit.edu
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  net/9p/client.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 09f8ced9f8bb..c290d96e1bb3 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1548,7 +1548,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  	struct p9_client *clnt = fid->clnt;
>  	struct p9_req_t *req;
>  	int count = iov_iter_count(to);
> -	int rsize, received, non_zc = 0;
> +	u32 rsize, received;
> +	bool non_zc = false;
>  	char *dataptr;
>  
>  	*err = 0;
> @@ -1571,7 +1572,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  				       0, 11, "dqd", fid->fid,
>  				       offset, rsize);
>  	} else {
> -		non_zc = 1;
> +		non_zc = true;
>  		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
>  				    rsize);
>  	}
> @@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  		return 0;
>  	}
>  	if (rsize < received) {
> -		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
> +		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
>  		received = rsize;

Does `received = rsize` make sense here? I would rather do `received = 0` to
prevent copying garbage below, that would be ignored by caller on error case
anyway.

>  	}
>  
> -	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
> +	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
>  
>  	if (non_zc) {
>  		int n = copy_to_iter(dataptr, received, to);
> @@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  	*err = 0;
>  
>  	while (iov_iter_count(from)) {
> -		int count = iov_iter_count(from);
> -		int rsize = fid->iounit;
> -		int written;
> +		size_t count = iov_iter_count(from);
> +		size_t rsize = fid->iounit;

I think that would break 64-bit big-endian systems, as `rsize` is passed via
format below as "d" (32-bit) type.

> +		u32 written;
>  
>  		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
>  			rsize = clnt->msize - P9_IOHDRSZ;
> @@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  		if (count < rsize)
>  			rsize = count;
>  
> -		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
> +		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu (/%zu)\n",
>  			 fid->fid, offset, rsize, count);
>  
>  		/* Don't bother zerocopy for small IO (< 1024) */
> @@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  			break;
>  		}
>  		if (rsize < written) {
> -			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
> +			pr_err("bogus RWRITE count (%u > %zu)\n", written, rsize);
>  			written = rsize;
>  		}
>  
> -		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
> +		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
>  
>  		p9_req_put(clnt, req);
>  		iov_iter_revert(from, count - written - iov_iter_count(from));
> @@ -2098,7 +2099,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
>  
>  int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
>  {
> -	int err, rsize, non_zc = 0;
> +	int err, non_zc = 0;
> +	u32 rsize;
>  	struct p9_client *clnt;
>  	struct p9_req_t *req;
>  	char *dataptr;
> @@ -2142,11 +2144,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
>  		goto free_and_error;
>  	}
>  	if (rsize < count) {
> -		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
> +		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
>  		count = rsize;
>  	}
>  
> -	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
> +	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
>  
>  	if (non_zc)
>  		memmove(data, dataptr, count);
> 
> ---
> base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
> change-id: 20241222-9p_unsigned_rw-03f95da525a0
> 
> Best regards,
> 


