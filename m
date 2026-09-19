Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AF3148DD;
	Sat, 19 Sep 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822963; cv=none; b=i1I53PXBaC4ElFtDVdBpDGsG20H8I8pSQrRbYWnRrztqRLHwMMJv5y/iBr+RMyjkb5JmRcBpmEeeoJr1gdSZu3iJboKXHloD+3ai0M+Ji1kZtG1+N0iSjAvBXwbIWF/qGjdC2vnX5d8CPKO7Co6CO6fgsQp/QHnKS7d0gbVFa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822963; c=relaxed/simple;
	bh=IKVk5OIpvugDSMBiaVhBQdzChjVl2iCFVHAM1QgyDSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyqwKIxJ/+gnRB7LO44dPbSOllpsCKPKREafg1cLy63oizsAo4inJZztfc4AZoE3qq/pKULUajV3xoIws1ASWiCDzzcHoGi2cWSmEUJgSzfM/PC11YaSjJvMSwBy45DJoGc4bONEGlak0eOZ9SjZsy+aWQPV3ENDetDOe0dcy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=oWxsM/c1; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oWxsM/c1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=oI9K/UH/ZbHWvfF5GUmjJfEBAfabY1ZkFekF4ks9tmg=; b=oWxsM/c1/zLCicXWFg4WC1NQq3
	Rmo3I5zcS/BgyomEEe1XdqJpAjC9vg6J8KThJeLI2ALAZJJfVsqiGMJBN981sUT75Llw4MWD1hcDS
	733Cw8QTzUuMn539oXr0yY0icKkVP0vTv5uI6feZ27+n4Z5e6IUvZtHzmqPwc7z+UHeIoOfHWRy8P
	ZymHy+3q6S2amZrLUIQ/R3VZEmpZyXnpmsJZyy/p6ZdsDKBM+gQzj63GeYyChG6v0Wo2qODNM1qQF
	LnFGeIehBmJxQAvd2O2dY4j2NtYYXvcclHRwvQrp+RxxeAPOh2b0ZEKmUiVFaTunQmW07QjXRpQ8P
	9R8Cp9bMI9YpVlY9B4Od1dvFO7UYSULW7cPEnPU01JjuHUoG6HDvuCNHgK5wnUTy+X3WC/eZadGUJ
	xKUEtPXJh40mi3E4yp6BJPX00A9m054syLgFYEfcimmK3TRF27hIo8zjbRl0QNTdsWkPOwPdxmTj8
	dqK1pCi4ZhEffnUKws2k6N7VoZ9YoCifvDgRi8Mpv4v5r80QRbRAnwP2bXK34zsGadOnqw96VqpH9
	xBfqRFSvYWkP3lsXgz1xXk2hSz9wxyXGa4/5nntzFPabYUPghiGPG0KBMhgkx663Nmc492YG+ArmI
	13T8p0SMYpyH0y7iKyY9XHHuJY2L3K5aQ/kgqY5+0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: bound the xattr size used to allocate the ACL buffer
Date: Sat, 19 Sep 2026 15:02:25 +0200
Message-ID: <8777483.NyiUUSuA9g@weasel>
In-Reply-To: <20260919102958.142460-1-ngocthang2710.1999@gmail.com>
References: <20260919102958.142460-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 19 September 2026 12:29:58 CEST Nguyen Ngoc Thang wrote:
> v9fs_fid_get_acl() sizes its kzalloc() buffer from the xattr length
> reported by the 9p server. A server, or a syzbot-style fake one, can
> report an arbitrarily large value. When it exceeds what the page
> allocator can serve, mounting with posixacl,access=client trips:
> 
>   WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof
>    ___kmalloc_large_node
>    v9fs_fid_get_acl
>    v9fs_get_acl
>    v9fs_inode_from_fid_dotl
>    v9fs_get_tree
> 
> A valid POSIX ACL always fits in an xattr value, so reject sizes above
> XATTR_SIZE_MAX. __v9fs_get_acl() already maps this error to -EIO.

What it currently does is calling kzalloc() and if that fails, it remaps the 
error to -EIO. However the Linux ACL subsystem does currently not impose its 
own limit, and therefore ACL size > XATTR_SIZE_MAX doesn't necessarily render 
it invalid, at least not if 9p server supports larger (9p) xattrs.

> Reported-by: syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de6fd6789748a8aa64a0
> Fixes: 85ff872d3f4a ("fs/9p: Implement POSIX ACL permission checking
> function") Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  fs/9p/acl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/9p/acl.c b/fs/9p/acl.c
> index ae7e7cf7523a..0dd7e72bbdd3 100644
> --- a/fs/9p/acl.c
> +++ b/fs/9p/acl.c
> @@ -29,6 +29,9 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid
> *fid, const char *name) return ERR_PTR(size);
>  	if (size == 0)
>  		return ERR_PTR(-ENODATA);
> +	/* the size is server-controlled; a valid ACL fits in an xattr */
> +	if (size > XATTR_SIZE_MAX)
> +		return ERR_PTR(-E2BIG);

We already had related discussions about this before (without decision), i.e. 
XATTR_SIZE_MAX vs. KMALLOC_MAX_SIZE. Note the source location was different, 
but it is the same issue:

https://lore.kernel.org/all/Z1n-Ue19Pa_AWVu0@codewreck.org/

XATTR_SIZE_MAX < KMALLOC_MAX_SIZE

KMALLOC_MAX_SIZE is currently (already) the real effective upper bound, and 
therefore catching KMALLOC_MAX_SIZE here would basically just silence syzbot 
reports. The only actual reason to address this issue at all.

Capping to XATTR_SIZE_MAX here would make sense, assuming 9p server is a Linux 
system as well. But it may not be. So for non-Linux 9p servers (and for Linux 
9p servers that do not map 9p xattrs to filesystem xattrs) you would 
unnecessarily lower the size limit for ACLs, and ACLs can be huge.

> 
>  	value = kzalloc(size, GFP_NOFS);
>  	if (!value)


