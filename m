Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3A2AEE2;
	Wed, 19 Mar 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376020; cv=none; b=lMfp/B048RPlrBQbnZxQLGJ+Z1Wo2D87nSg7MMwE56lrl/XdeY0HzgoemjzxEFaIGLZubkiAHoS3jQBsKsaEFgZzrUJZ7ecgahq9mKCmCQO2KzSxfdzYaWWSxxnlGfGTaUQDryQ4r1A+i0TR6et21XNfMA/gtwyUz5Rp9NoyDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376020; c=relaxed/simple;
	bh=vIVTyEyjGrgBv4ne1d/ZNjxcpWx+tNidE49j7wDt+QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1QuuPyw/Wov6PuGDKqfSXz+foiJaf8MvjB3KJ+a4nC+TTDfwKigocMm6pqGaQBZtkfD+XSzYuUMxywc6V7Sa16DPiymfmNIklZEbAC/zK5UsrzPC+rfMYdkYbpyLry0gYdBSRlZSfK9jiwA6jq2AQmkCgVbLSMzMoawb00xjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=etNHuQ3p; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="etNHuQ3p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=J8c71FLbSHhtY9pdbyK+bRWW8UQmp7cTMQ8VCxSrp0s=; b=etNHuQ3poEq8VxGfEeFb9RfIft
	N3s7OjpOibyf4dwGo0Ysxs7Tbp6rcVdV08OVQaxj8T/UVQTz+X8o+MJuVjKJgaOmHx5ctfQtS7z60
	8GNwSDatxD72VB3qS/PcTIV2XmXi4PeLkkNsR1KNsdIm29Xdk5SXl4oKDBb0ce4fM1hV4FN3kzY+Z
	tRS/zqJlASEQZGy7+HHD3JHPS1zZPPrtCgXJUQk2Eo9WBN62J0Parl9BIx+X0unKqLSYmxdmfkgdm
	VPuMohBFfeMzHpL/prBD00B47dVvqMURsi9CR0byC209y0mGG0VWVyfKIYm1HTBEt3YCB7RUgIWCs
	M+ZmG1M+M00V29m/XdIhnn91/OstOEfqn7FkWfbRrV+ecg2XN9S+LP5+jNJmoJwpo4woim1PAs/sq
	7w7U6AIfMN+cIftg1u7YToRIp0O/YDMkND4It1tQESLqMxwqy7Uf2POMbVNhZ3qjxx9OMmJNI1Wkj
	aHlayYPz+WAAjVW2pCv8orybEVaww7jnUs77fkrj3o1iuJWWFcUbGgm3h8lcn0mD7h3XNjzh68t3t
	7eMHiTfCXmn/Edm4cTN9FTbZsawTGFpci6DXOUv9FoJfkdWWaeqU2lYUj/FEDltRo4aym1ur1FFHL
	e0C73h8ys6tdtXosScPPhJOWpyywRs0mrbp2bzqnE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robert Morris <rtm@mit.edu>
Subject:
 Re: [PATCH v2] 9p/net: fix improper handling of bogus negative read/write
 replies
Date: Wed, 19 Mar 2025 10:20:05 +0100
Message-ID: <2056162.6bbq6Mt1IA@silver>
In-Reply-To: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>
References: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 16, 2025 10:32:56 PM CET Dominique Martinet wrote:
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
> Changes in v2:
> - fixed rsize to be u32 instead of size_t
> - Link to v1: https://lore.kernel.org/r/20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org
> ---
>  net/9p/client.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 09f8ced9f8bb..5e10fc174c3b 100644
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
> +		u32 rsize = fid->iounit;
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

  p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
           fid->fid, offset, rsize, count);

>  		/* Don't bother zerocopy for small IO (< 1024) */
> @@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  			break;
>  		}
>  		if (rsize < written) {
> -			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
> +			pr_err("bogus RWRITE count (%u > %zu)\n", written, rsize);

  pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);

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

Missing change for:

  p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u",
           fid->fid, offset, count);

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
> base-commit: 28e6f0643ff4431aac807e902ff0c8de16b2216d
> change-id: 20241222-9p_unsigned_rw-03f95da525a0
> 
> Best regards,
> 


