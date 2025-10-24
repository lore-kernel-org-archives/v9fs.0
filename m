Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEF3101D3;
	Fri, 24 Oct 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308943; cv=none; b=RKrIbH83viwXheLmzRv5CIuo9c8jyIR6yci7FMTh1xsPnCAnVWWKfjNGwBmcGiSloytXGoNElBvWkl56kAKwSbxI4rTk3MW6TL3UEEu57Y2fUs2nEU3BCEPUL4jIqimk6vnn+trcJRLVMo3HS4YOIFwOAH+T0bPBzNlIpfNTIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308943; c=relaxed/simple;
	bh=p1zcp/BvsovSEjsHM4m3I4WnClUB4hHeWZ+LV7Ag+ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujNvAP7nVc6E78OITxL7pgKKZ/uBFIgdoSMRtOtdpOQ/6IFKrD5dXuBUfv7+R4rsV4G7pPBe8OdS9kmePmRCgR1lQ6XouK+eWgP1Fol31kA65re6m7QA4LL+k33hj4k3dSF1qUwf/Wr4oWbRKHa26lX7RbFCtaLoPYo+3aKrNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=HiVeJ2fD; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HiVeJ2fD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=Z8lNTQOCrGiG4a2LitzVK325/I8OKhv/L7kNAExDh40=; b=HiVeJ2fDXSd7OUtBlYfXJ569Lg
	nA8JC6NAJoesNdl1ZZuwEHNmiYTB980ige4cGRfdlxr6Y0nqcBYC/HieOquCw0hOAQoV8eyJ2AITP
	1WhthtkRbgqzQ1YcJoO8j1bBJ2o/mYsu9qFAtOi678GSJ3WgnT17VjMNFaXBra/9euAmrZ17xkxu7
	0tDve9GzYa0L+XCT3t0gC6JNscW1tgqpC6jyH0Iqk89zvf6hM85Te4cq+LpKA0fKRQJz4I59wOixe
	FsOwIEcWedJXqKbhNWusuoFcTDClS1iISJ3h4tNfqzGEeRH4knRZC9xFTox2WpzzowH7GKuWm3fB4
	06svTj6Uo3S8GQkX4LW7JQ7Smtio04Cggh8SbPn4zseY4qISRlxGdnWzHUvaPPJxH237nVlPIh8/m
	46x3Efyqr65tS2iPUWvwPZnqmbZqi9rEMdKLcUqLm53InWyKIviTXHCv65sdzh3rAPpv6dv/bETqy
	IlH/Dec26zsaUGQ4IByhggyNNWiZ+rbTIBswUGNaLkEE4/M5hxorMwB/Fdc2kZHkP7VX1GLp0aYGb
	7aUmcDoPWSqkFDDXvglvZ+p3sXvtMZIb1MedwnO6NU9KFTbvYwfKCe219m3odaOlBsAxRPUPd3sI+
	ElWdE0o+e+3fanm28uYFHgXXf2ddVp0I0Ix/AnbT4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p: delete unnnecessary condition
Date: Fri, 24 Oct 2025 13:59:46 +0200
Message-ID: <13655400.bYd4YqkHfl@silver>
In-Reply-To: <aPtiSJl8EwSfVvqN@stanley.mountain>
References: <aPtiSJl8EwSfVvqN@stanley.mountain>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, October 24, 2025 1:26:00 PM CEST Dan Carpenter wrote:
> We already know that "retval" is negative, so there is no need to check
> again.  Also the statement is not indented far enough.  Delete it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Fixes: 43c36a5
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Apparently a manual revert copy paste error. The rest of the revert commit
LGTM.

/Christian

>  fs/9p/vfs_dentry.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index c1acbc98465d..c5bf74d547e8 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -109,7 +109,6 @@ static int __v9fs_lookup_revalidate(struct dentry
> *dentry, unsigned int flags) p9_debug(P9_DEBUG_VFS,
>  				"refresh inode: dentry = %pd (%p), got error %pe\n",
>  				dentry, dentry, ERR_PTR(retval));
> -		if (retval < 0)
>  			return retval;
>  		}
>  	}


