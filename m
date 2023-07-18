Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4A7F0
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 02:54:59 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id A6F20C01F; Tue, 18 Jul 2023 04:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1689648346; bh=bfiP+yKbVIO9jSH+HYOyJipP/EVz+Og+4JBj21twlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plzjsD5TCUwYBtbFivsaJvTUfrj60khDc38GJxKGoiqSgaZPAjtxi5aXtfFa16wAK
	 rUMMx+a6zj0uiaHOMVR/d7qhGRtPCw4N7cpyNA/XEewCdJojnH0LCyQ0tp35F9R/YL
	 iTp972pOjDZwUi8yYCe1R6y63UV2TrT+uWthZ3dCxR2aXkOP8ymu/KgIZMKaQkSCD/
	 X6wFZut76BSYf3Al9h9NpKxm8dzFX5SEa+7mP42dnfyITXiSte/lS0dMvOIDoOpJ0U
	 WxEj0vGL3RD+73GCfconYnM7b9SyWHF253vl7k3FPdW1Juu/Hzu3B1g69KZXaaYTuS
	 MoA75uyaFUjcw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id B30D8C009;
	Tue, 18 Jul 2023 04:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1689648345; bh=bfiP+yKbVIO9jSH+HYOyJipP/EVz+Og+4JBj21twlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hs4KMFsTgYK0UatIvvXFRwdwDEOS628ggn7y1KOaN7Rei1Hz2VDp5j78PI568LpX3
	 u1aOpS2c/XXEngV3E/SjB5KIx0RnIt2NtM0lqFJQJ4/N1bNxck+TQorQpJ8hREXm0d
	 etamwFmae7bqqYgkzz6NwwoVDLzLUVR+h8hrlKvLHtYFzJiMxQnM9jekGrykeZ2aLB
	 LOsrjHiJb4Ifq+XioQZaZz5ON2PyiidmgZjgJnm3+onTRl45Cph2OQlWEy4Av9RxoO
	 uHCYvqPrsckS0f5wjAxFKkmsEs+4pu7Lk2T/NlXwtTl7cjK81J6aj/LkiyZ1JnatOA
	 qm5JxD2GC/lyA==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id 389a44b3;
	Tue, 18 Jul 2023 02:45:40 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:45:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 1/3] fs/9p: remove unecessary and overrestrictive check
Message-ID: <ZLX8xUdCRLYj3cjk@codewreck.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-1-0683b283b932@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-1-0683b283b932@kernel.org>

Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:00PM +0000:
> This eliminates a check for shared that was overrestrictive and
> duplicated a check in generic_file_readonly_mmap.

generic_file_readonly_mmap checks for VM_SHARED + VM_MAYWRITE,
so it isn't exactly "duplicating" the check.. But I agree we don't need
it; we used to have the mmap op be generic_file_readonly_mmap directly
previously.

I'd argue we don't need to invalidate inode pages either if there is no
writeback cache, there shouldn't be anything in it? but that can be done
separately, and extra invalidation won't bring harm anyway.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> 
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
> -		if (vma->vm_flags & VM_MAYSHARE)
> -			return -ENODEV;
>  		invalidate_inode_pages2(filp->f_mapping);
>  		return generic_file_readonly_mmap(filp, vma);
>  	}
> 

-- 
Dominique Martinet | Asmadeus
