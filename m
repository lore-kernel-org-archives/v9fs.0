Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DE1CAA87;
	Mon, 31 Mar 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410113; cv=none; b=iW5FQI9AnPKGEcQNVzT5OXel/hBpcqM63J54ynN83pArF/d07K6iJ+R3vjyZNoBXEK/hqen6FRO9U1S+UOhTOsPtXPRyuOBj3ZDlaqJKskrOIzrYQ0VA/5vtxEy3WJdFwHyuhdv4zRv54PLZr7B8xbeRF196NgzylinZvtQgRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410113; c=relaxed/simple;
	bh=pXyTOxQ6Zf+1HXKG0wsfG1ed/KhRNifgCxb817XNzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6/cH+BewGmhzzr/uS6vjqFJyYFcNVpso8oWdOob1A6MRgHtskd4UGb/r+Pi5Q9NjagBbMNPpx4OAAWOWnhqoTrm5fT5BORwISIUTO4Ii8C7NuANDDxsXNDdU9rFyYFlAWX8wN11KqICrzftn0A8BwQYcCbGsBF83C9TRVPoA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=VZJjLreK; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VZJjLreK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=aT2V1sz8yLOA2w9EOGsMnfr5x7JQjaboWZRV6dDfBQg=; b=VZJjLreK1D9Pm42wOj1fZN44cs
	Rw+eXh9HAnvgpXyqcC5g4QUr1vMjuPFKhlhx2cvUR9o3p/XqK8oyDP+UlApIBaJsYiXhcHHHfaGsh
	7BEG2B5ps956Jfk7Uv9ShhYvB/s0ezJJ/uYwnRvNkawhdd61siPeukFi8e4cHPOvflv4mStnp/VSF
	PGQCA4qnA62TV/u6DRz9ah99gzVc64momajJ4JTyVPUo1hvrUSeNR2OMrf7o4MtWn+M23VscyrHC7
	ICmzHnLq80L9M8Qj55kRbGX+KqwEgW/tGg525PI1fx0z97mOwzC3yEfZu/i+QkAPwaZV96VEEcbFG
	mHfyJyj8qiOHOQmXs0ETzcJAE0k/GP21XuCA8IMY0voys9EPH2bTmWqAr+Snn3ZvRi1GntDhXjDb3
	W9edBR0S3QusjEQEDFjXiHNx+/X9/PPc7qlSAD+CMrX4oqa3o/nFog384HJA340z7q3iMNnDqFxgv
	QbytMfETgQnAWwMueJ3gvsOoj+TsSG1M8pkzUXdujGZ2zYob1i9nsW5uD8XRzbVz0prHDnVFPygHp
	5pOZym+boZ0VM8p2b/XIu0uq0VI3JFnAXl8mfPDXvsLnk2hm3djVqAcF2zExOLuZr8WRQJriOvWHY
	zdfo5kkPf9Y+0fiK4ooel/Jq3u2BIQZKDuNQXdVck=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Tingmao Wang <m@maowtm.org>,
 v9fs@lists.linux.dev
Cc: linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fs/9p: Add missing "not" in cache documentation
Date: Mon, 31 Mar 2025 09:54:09 +0200
Message-ID: <36322483.C5m3dU8G8V@silver>
In-Reply-To: <20250330213443.98434-1-m@maowtm.org>
References: <20250330213443.98434-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 30, 2025 11:34:42 PM CEST Tingmao Wang wrote:
> A quick fix for what I assume is a typo.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  Documentation/filesystems/9p.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 2bbf68b56b0d..c9f0274c808e 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -165,8 +165,8 @@ Options
>  		do not necessarily validate cached values on the server.  In other
>  		words changes on the server are not guaranteed to be reflected
>  		on the client system.  Only use this mode of operation if you
> -		have an exclusive mount and the server will modify the filesystem
> -		underneath you.
> +		have an exclusive mount and the server will not modify the
> +		filesystem underneath you.
>  
>    debug=n	specifies debug level.  The debug level is a bitmask.
>  
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> 


