Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895F14A86
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 15:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E25EC433C8;
	Wed, 19 Jul 2023 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689781214;
	bh=xNbruBqmHsICY//n4TOvdUjRXvhkYlxcSQDGD+e21c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHlNWkFcwitKAVo5hGU1MQPh43L+YzWTNceZAIJj8J5IKkL50VqCb548IO/i3jXrM
	 SNIyVlZsqHP0VGIKwqwcYdn8hCz1ymnn/RTtk+oWuH2IqgoIGh326IqJPGTB6GnUmX
	 EN/EEglt2v9y5rXLe9VoXyZr3uxP8ZcP0aNsGeD0=
Date: Wed, 19 Jul 2023 17:40:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, stable@vger.kernel.org,
	Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
Message-ID: <2023071902-dropkick-deity-0f6f@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-4-769791f474fd@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-4-769791f474fd@kernel.org>

On Wed, Jul 19, 2023 at 03:17:08PM +0000, Eric Van Hensbergen wrote:
> There was an invalidate_inode_pages2
> added to mmap that is unnecessary.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/vfs_file.c | 1 -
>  1 file changed, 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
