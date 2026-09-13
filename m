Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA2E1EFC
	for <v9fs@lists.linux.dev>; Sun, 13 Sep 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306172; cv=none; b=upXV0fHM4lr3Cn8zltr/srUKLxYVq2p3ik8yXJ4EvZOn6G5k+s70bvOGaaKfSfYo4sRAeii/LuktUwY4k5FCzW5YuUwYArnqOvzrfqWfBUnjBQMkhaUmJHEarfyVL8UPBHSdzp/QyTr6ZaMtvsOcd+7TUzcMeIDuXu0QvhoqcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306172; c=relaxed/simple;
	bh=jNFssGSCNFIqp+aGw6NHmUktGzDWLVNnfI7SiR3g3os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldH6Qdn11xfkvRHzmLH1xvmUuOyWLVrUyqT/26bkdNCLDTBwcH2zKgT4VnRCMPDjWyc6Eq2JNWV90gcnYb6QxAbTEQc66fivsDi0P0yekKLYojs31PuRfia+F9knQ6dG3YCo0QYaiYUM2daL7Y8kh98UCkNa4ROtMBhQ07eslyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Qgab5eJl; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Qgab5eJl"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3554A14C2D6;
	Sun, 13 Sep 2026 15:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789306168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmId3lwKSVtOLOjq7690pUXYfPaXwb4OqoFxjSAHgA0=;
	b=Qgab5eJlbPp18lnyjUN6TieLPVF6DAd4+JeMMyrG+2vPTDETOeBhqlfk+j+WB+pjWwC3br
	qYed42jQyL+IXcUSKkD/rYY+PeEyzye2TKt/eYVIsXLQHLUXrrnuuTRpra14fgypAPOTtC
	lH2qrNRWP6ZTBIOg3dN68om3rf6lwECi24U8fYneDy9Xrlr9IvfMYXKGFbAJOZHbqIl2VR
	mprfBxnyWBX3x0jG6eZVZbZCVw9P4mH5W+Y7ut/eo8Y5kpKBt9QeJI2QW8kLkmwbha0Dr5
	vrc3aMdSc5u+guLD9EPS42ZemXFHUUczIzb6u6rzfnR6Yeq8eekXti25gUFIaQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a9de48bc;
	Sun, 13 Sep 2026 13:29:23 +0000 (UTC)
Date: Sun, 13 Sep 2026 22:29:08 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: v9fs@lists.linux.dev, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, rpembry@gmail.com, yuantan098@gmail.com,
	zcliangcn@gmail.com, bird@lzu.edu.cn, zzhan461@ucr.edu
Subject: Re: [PATCH 1/1] 9p: fix caches_show() out-of-bounds write
Message-ID: <aqalJHemXACB8r63@codewreck.org>
References: <cover.1781908090.git.zzhan461@ucr.edu>
 <abfb65f4800634dafb08238bba20cb48797e796f.1781908090.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abfb65f4800634dafb08238bba20cb48797e796f.1781908090.git.zzhan461@ucr.edu>

Ren Wei wrote on Sat, Jun 20, 2026 at 11:53:03PM +0800:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> The sysfs show handler for /sys/fs/9p/caches appends cache tags with
> snprintf(buf + count, limit, ...) and then advances count and limit by
> the return value. This is incorrect for truncation because snprintf()
> returns the full would-have-been length, not the number of bytes stored.
> 
> Once the accumulated output exceeds PAGE_SIZE, count can advance past
> the sysfs buffer and limit can become negative. A later iteration then
> passes an out-of-bounds destination pointer and an oversized size_t
> into snprintf(), leading to an out-of-bounds write.
> 
> Use sysfs_emit_at() for the append instead. It follows the sysfs buffer
> contract and returns the number of bytes actually stored, so the offset
> remains bounded even when the output is truncated.
> 
> Fixes: 86db0c32f16c ("9p: fix /sys/fs/9p/caches overwriting itself")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>

nit: this is missing a Co-authored-by tag between the two sign-offs if
you touched the patch, or should not have your sign-off at all if you
didn't, see Documentation/process/submitting-patches.rst

Co-authored-by: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Less minor nit: please always cc linux-kernel@vger.kernel.org when
sending patches; it should come up if you use get_maintainer.pl
(In this case I'd also add fsdevel but that doesn't get listed for some
reason, so I guess I can't argue about that one; doesn't really matter
for something simple as this though, but not having linux-kernel@ means
sashiko didn't run)

> ---
>  fs/9p/v9fs.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index acda42499ca9..0668bad681bf 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
> +#include <linux/sysfs.h>
>  #include <net/9p/9p.h>
>  #include <net/9p/client.h>
>  #include <net/9p/transport.h>
> @@ -592,21 +593,14 @@ static ssize_t caches_show(struct kobject *kobj,
>  			   struct kobj_attribute *attr,
>  			   char *buf)
>  {
> -	ssize_t n = 0, count = 0, limit = PAGE_SIZE;
> +	ssize_t count = 0;
>  	struct v9fs_session_info *v9ses;
>  
>  	spin_lock(&v9fs_sessionlist_lock);
>  	list_for_each_entry(v9ses, &v9fs_sessionlist, slist) {
> -		if (v9ses->cachetag) {
> -			n = snprintf(buf + count, limit, "%s\n", v9ses->cachetag);
> -			if (n < 0) {
> -				count = n;
> -				break;
> -			}
> -
> -			count += n;
> -			limit -= n;
> -		}
> +		if (v9ses->cachetag)
> +			count += sysfs_emit_at(buf, count, "%s\n",
> +					       v9ses->cachetag);

This makes sense to me, there's just a nit: looking at sysfs_emit_at()
if count is already >= PAGE_SIZE then this emits a WARN(), which can be
problematic for some people;
I think we should explicitly break if count >= PAGE_SIZE to avoid this


>  	}
>  
>  	spin_unlock(&v9fs_sessionlist_lock);

-- 
Dominique Martinet | Asmadeus
