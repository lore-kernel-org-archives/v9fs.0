Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD03F9C3
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ZhDN5xdyT8ZvjweCNzylAZf/KC5Duc3I1+ahoL2VXIA=; b=KSOYynkSHA5y97Z6woL5qvdhRU
	xyYvERlso5ApWgz3OBU9rR3qoB/VrFcbPjhuokbbopAmHQByTFF5UJzn/geBP8E7NLK+Z6wf76uf3
	bsi+UT3uINfP6nn2akCUPJy14s8J+AFtbN8crMzAW8UF4WFclYf4z+jc8GuBDa9gVMzNOM4/3O3V/
	xhGdis7/x7fmTqJg5hxyUs/pW6wbCmcudmuJtihXNuODNqT6PbPZCGaJtqtr/Bh70IOoRupuyDwn+
	0fehpoq8NtFUgu/g4teTE4nCqMKyhMh+CvzyEKW2KKXuvoUPwDjAxry9uKhlj1EXLE+0CCs1YqWDh
	+bSIz/Bqhw+VTZhYYRYSZB0Ne6KwfgMNzHT4Ami7OYTaspT7D7KAG57q8c/Ol0B/hSW6nfVLK7nvm
	VK7/dmbu5ua3Zh08/Jdi+8N4D9KprAYXSqT0pwtXOfrv8apZoJCVADBnCZshxZAFDvXJDCjESPiug
	aQ+39bPh7ZWscTZLtVTKGJ7oE3O8N8pYFswue3y02g8mEMJVxXd2Q/yfF+KED7s3LqdX0Pc+1wqa9
	wqUb/T0iLKqNPLtLGYF4Q05HDgzg1KqPSuvDXlRjl/Dn9MNj74VnRZvIp9YmlS2T72HrhTYZKk9Sb
	Nr9qrcVIrxLje+3qEQofvTF9ijeL0eHyZqOda0iD4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH 3/3] fs/9p: fix type mismatch in file cache mode helper
Date: Tue, 18 Jul 2023 11:40:25 +0200
Message-ID: <2057058.f4oLnqTvTQ@silver>
In-Reply-To:
 <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
References:
 <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 17, 2023 6:29:02 PM CEST Eric Van Hensbergen wrote:
> There were two flags which had incorrect type in the
> paramaters of the file cache mode helper function.

1. typo: "parameters"

2. I would be more precise and actually name the two flags in question in the
commit log.

> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 297c2c377e3dd..29281b7c38870 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>   * NOTE: these are set after open so only reflect 9p client not
>   * underlying file system on server.
>   */
> -static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
> -	int s_cache, unsigned int f_flags)
> +static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
> +	unsigned int s_cache, unsigned int f_flags)
>  {
>  	if (fid->qid.type != P9_QTFILE)
>  		return;
> 
> 




