Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F814A86
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9FCC433D9;
	Wed, 19 Jul 2023 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689781225;
	bh=yX/Ul0q6k+gD3JIVRJJiWvifByik2J4h1betQHGgVIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2WQq4ocf3+cbAQZPfeA0Q53vhtgOdCkfpVphsaeGYXyTMBDhAqLepxMq1fT7w7X8o
	 VtL0tCtyBeEgGrq402GARJ2rpt9AdzNnLycNBKC7tr4BOXH1Hdg11EbqXL0ZKWZf++
	 vwDH5H+ZzKEswf5JHHNFFD/LpDIgFk84uKmo7DQ0=
Date: Wed, 19 Jul 2023 17:40:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, stable@vger.kernel.org,
	Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] fs/9p: fix type mismatch in file cache mode helper
Message-ID: <2023071914-serotonin-balmy-5d58@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>

On Wed, Jul 19, 2023 at 03:17:07PM +0000, Eric Van Hensbergen wrote:
> There were two flags (s_flags and s_cache) which had incorrect signed
> type in the parameters of the file cache mode helper function.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
