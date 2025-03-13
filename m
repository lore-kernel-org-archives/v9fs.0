Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3D267701;
	Thu, 13 Mar 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872589; cv=none; b=WWPm66freWgMxIEjg3nRR8WFb///mc8nETgtEzKG3P5y4m5JqC9er8r1uuaXST006kywRVt74iBqk3qt/GdStcBc6/0+gfui0pqk1B+2ycf0/f67govVA9iMWdcv89ZTSkkDfcHLHM1wTEgnUPFwlvJw/0+D6ySiIWCIvaiiaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872589; c=relaxed/simple;
	bh=SWcBEiDC6xd/PujYJvpj52/K9l9YFvwj3Xw6G6hAUuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFwaTTVD265Dxq5p4rOB3AkjMT64rqLKhLpDG634QLR/Q+nix/qTHJ7Nz6jiuHEoOxzp3zhHNYL6BbhuPOZIDxUsWtfphMmmagMRBbMmcmLX5pEmuNxbD3tQE0BiTj9ze9X3lcBHgCzOT8Ul9DU3O7DqJQvZPpdqkPyjTZSeqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=fQbnOpSb; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fQbnOpSb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ITLasxmQDerXuSjwxhFppjXCgBmI89lbRmvF9Iy20jA=; b=fQbnOpSbDJIJdf3sQaILolccPG
	DQWcJ4ixHQF2Kts21kpaZ64J6HoOt0b/6kEwDpofSKO9VBIcTVZRFASmIImcSQ5Vp7NgGFxPNDgKa
	Qu+UD+6qVeVbg42s+Rm2o/LBPu95oyy/x6yic9ETZhWh+mxoft7vEqaN8f93kX7DsqG6bBXI89NKt
	5wddGm4BYPbOlP0Q910pGiRRgXxFiW1tdyectSqVfpWVx9Ura3YcwTE8C6vLGLBlfGCEaclwCXhjP
	On39TH1+c8xdIsdp68i/Rl8caM7n8yU9BWRPtXDWhCKxYhXPou8ZcYjBnXh4E4/Vt9wMSgCgTjBBG
	dON0V5WfUNQE7qCBMN6vaG4sHaBWkPpw+belxDr7nQwBshraDyf5yLa9QrRiTcUtd7KDMo8rGDoOD
	pJPPdWTgeZMkroEO/AJJ3JuFHaVT0gPM3YUOV+G+xPFyjK4+5hvL8ojs8E3gLyiv8BpI0wmz8U65x
	FFyHNlLbjJl2YhOhBkbIpcpRq9TM9TvTcgVgQaIxN5DhN1At9Wg76dpSQ0DaDPuNpJFf+ECuOvs8D
	b81ZvExbeezTTh32CFm4WjXSYAgx5CMQRoPQgUHWwy0Io8VmUhTB/OQ838EXZI8FPaEMy0zGE3vfg
	cp/fQn7qK5BhAImvwwIOWGsLaprnsXNLaT6F6XqB8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/9p: fix NULL pointer dereference on mkdir
Date: Thu, 13 Mar 2025 14:29:42 +0100
Message-ID: <4597443.VRNSQfLuZI@silver>
In-Reply-To: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
References: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, March 13, 2025 1:59:32 PM CET Christian Schoenebeck wrote:
> When a 9p tree was mounted with option 'posixacl', parent directory had a
> default ACL set for its subdirectories, e.g.:
> 
>   setfacl -m default:group:simpsons:rwx parentdir
> 
> then creating a subdirectory crashed 9p client, as v9fs_fid_add() call in
> function v9fs_vfs_mkdir_dotl() sets the passed 'fid' pointer to NULL
> (since dafbe689736) even though the subsequent v9fs_set_create_acl() call
> expects a valid non-NULL 'fid' pointer:
> 
>   [   37.273191] BUG: kernel NULL pointer dereference, address: 0000000000000000
>   ...
>   [   37.322338] Call Trace:
>   [   37.323043]  <TASK>
>   [   37.323621]  ? __die+0x1f/0x60
>   [   37.324448]  ? page_fault_oops+0x158/0x470
>   [   37.325532]  ? search_module_extables+0x4a/0x80
>   [   37.326742]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
>   [   37.328006]  ? search_bpf_extables+0x5b/0x80
>   [   37.329142]  ? exc_page_fault+0x72/0x190
>   [   37.330196]  ? asm_exc_page_fault+0x22/0x30
>   [   37.331330]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
>   [   37.332562]  ? v9fs_fid_xattr_get+0x59/0x120 [9p]
>   [   37.333824]  v9fs_fid_xattr_set+0x6f/0x130 [9p]
>   [   37.335077]  v9fs_set_acl+0x82/0xc0 [9p]
>   [   37.336112]  v9fs_set_create_acl+0x41/0x60 [9p]
>   [   37.337326]  v9fs_vfs_mkdir_dotl+0x20d/0x2e0 [9p]
>   [   37.338590]  vfs_mkdir+0x192/0x250
>   [   37.339535]  do_mkdirat+0x135/0x160
>   [   37.340465]  __x64_sys_mkdir+0x42/0x60
>   [   37.341455]  do_syscall_64+0x4b/0x110
>   [   37.342447]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Oops, forgot to decode the trace back:

[   37.322338] Call Trace:
[   37.323043]  <TASK>
[   37.323621] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[   37.324448] ? page_fault_oops (arch/x86/mm/fault.c:714) 
[   37.325532] ? search_module_extables (kernel/module/main.c:3733) 
[   37.326742] ? p9_client_walk (net/9p/client.c:1165) 9pnet 
[   37.328006] ? search_bpf_extables (kernel/bpf/core.c:804) 
[   37.329142] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:686 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538) 
[   37.330196] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574) 
[   37.331330] ? p9_client_walk (net/9p/client.c:1165) 9pnet 
[   37.332562] ? v9fs_fid_xattr_get (fs/9p/xattr.c:30) 9p 
[   37.333824] v9fs_fid_xattr_set (fs/9p/fid.h:23 fs/9p/xattr.c:121) 9p 
[   37.335077] v9fs_set_acl (fs/9p/acl.c:276) 9p 
[   37.336112] v9fs_set_create_acl (fs/9p/acl.c:307) 9p 
[   37.337326] v9fs_vfs_mkdir_dotl (fs/9p/vfs_inode_dotl.c:411) 9p 
[   37.338590] vfs_mkdir (fs/namei.c:4313) 
[   37.339535] do_mkdirat (fs/namei.c:4336) 
[   37.340465] __x64_sys_mkdir (fs/namei.c:4354) 
[   37.341455] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[   37.342447] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Dominique, do you want me to send a v2 or would you update the commit log on
your end?

/Christian

> Fix this by simply swapping the sequence of these two calls in
> v9fs_vfs_mkdir_dotl(), i.e. calling v9fs_set_create_acl() before
> v9fs_fid_add().
> 
> Fixes: dafbe689736 ('9p fid refcount: cleanup p9_fid_put calls')
> Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com
> Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> ---
>  fs/9p/vfs_inode_dotl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 143ac03b7425..3397939fd2d5 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -407,8 +407,8 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
>  			 err);
>  		goto error;
>  	}
> -	v9fs_fid_add(dentry, &fid);
>  	v9fs_set_create_acl(inode, fid, dacl, pacl);
> +	v9fs_fid_add(dentry, &fid);
>  	d_instantiate(dentry, inode);
>  	err = 0;
>  	inc_nlink(dir);
> 


