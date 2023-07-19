Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE214A86
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 15:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C52C433C7;
	Wed, 19 Jul 2023 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689781234;
	bh=VHgF1bTcOvcb/8pCRZRg1ZSHoMzSjJRqBK8i/jC32uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1oGVNf61A0zOzmqRqKK+/H2eLb/Oi9s95XoJnVr5QppcVZiDfnhnJwJthWGIdhlW
	 0ys197Oi8jGpOBgLJgWVrBb8pLFcV5Eg22TYbwQ7imLcLSitltQfUmTBwDue2bRLkG
	 1B6w7rlz/DNwwNbZ8BmVF5wTCmVroWPDErJdOsHQ=
Date: Wed, 19 Jul 2023 17:40:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, stable@vger.kernel.org,
	Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] fs/9p: fix typo in comparison logic for cache mode
Message-ID: <2023071924-alright-prepaid-e5e4@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-2-769791f474fd@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-2-769791f474fd@kernel.org>

On Wed, Jul 19, 2023 at 03:17:06PM +0000, Eric Van Hensbergen wrote:
> There appears to be a typo in the comparison statement for the logic
> which sets a file's cache mode based on mount flags.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
