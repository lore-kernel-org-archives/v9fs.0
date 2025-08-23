Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35044EEC0
	for <v9fs@lists.linux.dev>; Sat, 23 Aug 2025 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755930882; cv=none; b=dnh5M+tu1oTkdu2Pih/eSlP77CIXeIOSo49AZrbki6OPZ11Bk27ilS/Zw5S8R1pSLKmHoavUYmtwJnaEcv5nXtJYmuDwnZaGsRHcmJXGY/HVqx524PIwP+t6RZ6ESkr29cr9Ro86MPLhVBO40we1wuTCCUwSPNEWx8kNWK7cfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755930882; c=relaxed/simple;
	bh=tBCcDaH3buD1JEH+rBJXt3RrWkInRrwKYPxpbY0wMUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzkRUy687130+jTxrXPAUJUdcSSIARX+pY4FRbZVmEr+d56IM34m9HQ2MVjuGf9f74ACeCHgfzBgWm02EDxJ3dwN9LcV4FmoIPQApPPMYvlqtYAXJ6heruHg1vcEAHwtk+DU71wnWVNIUv6d2IoUhPTFWvXv+P/TqiU/Nhv3Gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=I2vzf60X; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="I2vzf60X"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2419114C2D3;
	Sat, 23 Aug 2025 08:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755930871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQLgEGsOJ9htfFE7QX5FnGvss/ba3u3E33LwS80L08M=;
	b=I2vzf60Xa6iV/Cco/5XUWIZ1MosQpt/ZH++Gq8A7BawpF1Ofp/xWQO8VSjqty8maLIiJDs
	NX8shLu3k/hNg2ZhpIYke1BYJYPXfjA3rPvL+qmTH0Lg1CX9yZn3NIyEfl14HpLfMSEfBo
	dcAedo6QTw71OUvIbIxV/logCE5/r+tR3kxaBqZ/qI7w+IDTt4Tp2UyFX/kBsbIcNOyHII
	zf9PChYZ6AqS47znNN7/+KA2sFpM3kpX4OnNZ74wWj/pUdqVoyGRSvPbnKKXhdevENBMR6
	YqXL6R1RIUAYqloElmsv0okf2gA+ifuqDt/AR1TfiQWwUTgQhxKwEQrg7XV/eg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1bfb246e;
	Sat, 23 Aug 2025 06:34:27 +0000 (UTC)
Date: Sat, 23 Aug 2025 15:34:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Edward Adam Davis <eadavis@qq.com>, Eric Sandeen <sandeen@redhat.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH next V2] 9p: Correct the session info
Message-ID: <aKlg5Ci4WC11GZGz@codewreck.org>
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
 <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>

Edward Adam Davis wrote on Sat, Aug 23, 2025 at 07:22:13AM +0800:
> syz report a shift-out-of-bounds in v9fs_get_tree.
> 
> This is because the maxdata value is 0, causing fls to return 32, meaning
> the s_blocksize_bits value is 32, which causes an out of bounds error.
> The root cause of this is incorrect session information obtained during
> fill super. Since v9ses is stored in sb, it is used directly.

Thanks for the patch.

Eric, ignore the other part of the thread -- I guess the int max limit
wasn't related...

What I'm not following now is how the v9ses is created/handled around
the new mount API:
- in v9fs_get_tree a v9ses is allocated and passed along in
fc->s_fs_info (that this patches now uses)
- but in v9fs_init_fs_context then a `v9fs_context` is created that
also embeds (not a pointer) a v9ses struct, which is accessed through
fc->fs_private as the code before this patch.

So at least for some time we have two v9ses which obviously don't hold
the same fields, and I'm not confident I can review which is used where
and when.

Now I probably should read up about the "new" mount API, but I don't
like that there are two v9ses around.
I don't have a clue about the fs_context lifetime: is it kept around all
the time the fs is mounted and can we rely on it to be present (and get
rid of the v9ses allocated in v9fs_get_tree), or is the context only a
temporary thing and we should avoid having a v9ses in there instead?
(I'd be tempted to think the later?)


Edward, thanks for investingating this; at this point I'm worried there
are other inconsistencies so I'll just remove the new mount API patches
from my -next branch instead of applying the patch, but this is really
appreciated.

> Fixes: 4d18c32a395d ("9p: convert to the new mount API")
> Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V1 -> V2: remove the unused ctx
> 
>  fs/9p/vfs_super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index f6065b5e0e5d..bcb6ebdb8037 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -49,8 +49,7 @@ static int v9fs_set_super(struct super_block *s, struct fs_context *fc)
>  static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	int ret;
> -	struct v9fs_context	*ctx = fc->fs_private;
> -	struct v9fs_session_info *v9ses = &ctx->v9ses;
> +	struct v9fs_session_info *v9ses = sb->s_fs_info;
>  
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);

-- 
Dominique Martinet | Asmadeus
