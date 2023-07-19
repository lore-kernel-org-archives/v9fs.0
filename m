Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0814AA3
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=7L+Xkt1Em2DaemKP30bcX/bfNhleDwpX/9tOCT336L4=; b=U4Cm0gWu1IAKrXYF/GNlt975nB
	c4D6vwd57ekgrf2ZTFg8NYrSlSEFihb3WFyUDoaV/Qm94mTOqq+7SKhzEeiyypAg9JPQj0VlPJoJ3
	2HJZ35jbGlOx6QY236ZXdtsV+uWvdXhqxnElXznKrswBKJ3Y3elAO9qG+bHs/ck4zjugDZyID0fsu
	5XcJhod2BXu4tb26RPdCh7O9nrnUb0SMIeGKUFLaHTe/gWFjdphsNmU6SnDbbKy8RZw56Gw1s1rRp
	X/GZ5ddcjjr26rS8nZ4lo1NgMtNZVesMMndI0xb+tjJLlgw2OglOD3+PxapXfjLeMyNQzu3Synfq6
	LdFLWIPBfIUNVIKq+3r9b4CHmYbeWvQcemnMLr5zk14aaMGhGCkk1WefwGgMsll1DXgfWIFcRfL4f
	En5WbUCFRwtXdaNdnvqonl98MSRL0/NyNuqObO4Rp5PZ9e/UIKGQuVnlOeKRK2HNDNw/lbJsptUAW
	nZEqw5EVqDaGr9ewjVYOQzfZHGIaPrlLDgCQBVw2p2SHHBE0j0sWMjbly272WAo/kPNttgbZ8CES+
	iETlW1cxbAT8fRKtvbVUxSkBaZvOmjQDdz/8Dpcg2Pdxc3kEtSPHyJ4uNCbkpQDu+XFpAxqnHKJPs
	rHapZ2eGivRDGrBtJwNa72ebKGCwXOeJkbMnMqe5E=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>
Subject:
 Re: [PATCH v2 1/4] fs/9p: remove unnecessary and overrestrictive check
Date: Wed, 19 Jul 2023 15:18:33 +0200
Message-ID: <5578264.lUQuLdSRdS@silver>
In-Reply-To:
 <20230716-fixes-overly-restrictive-mmap-v2-1-147d6b93f699@kernel.org>
References:
 <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v2-1-147d6b93f699@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 18, 2023 10:50:15 PM CEST Eric Van Hensbergen wrote:
> This eliminates a check for shared that was overrestrictive and
> duplicated a check in generic_file_readonly_mmap.
> 
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/vfs_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 2996fb00387fa..bda3abd6646b8 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -506,8 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	if (!(v9ses->cache & CACHE_WRITEBACK)) {
>  		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");

"(r/o mmap mode)" ?

> -		if (vma->vm_flags & VM_MAYSHARE)
> -			return -ENODEV;
>  		invalidate_inode_pages2(filp->f_mapping);
>  		return generic_file_readonly_mmap(filp, vma);
>  	}
> 
> 


