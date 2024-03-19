Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A133CA
	for <v9fs@lists.linux.dev>; Sun, 24 Mar 2024 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246327; cv=none; b=pbnhUZ3ykjXsAzAkxxPUF4G8M3u+my9R4rRqFWMmTYacA3qLFM9iIYLGbng7YQO2mAgUORiI27R60zP0F3TmEP7AqgdauQ62TuFn9MT51NXZHxYzdNb/6Zi92QxGLig8BP1Y105HIHtx+4589zTA82YL7AII5lcUODMfRX7BjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246327; c=relaxed/simple;
	bh=RmySQCLqF8qfUzjXWXFsnI6Lze/4J36XZmPRALV0Fyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhnGLel0fvQ7f1/rhqBrxK3U7UrGhfPGwCXUtLVXwQHPHmfiMRrlT2pqRpmZrGdTvCg6Cz3XpwiD60d7H5YQoS9RvVKwVfFg1APUEjGqvEqqpio1hTWAmsCPVMv3uBKvFL2UWXAeEYnnlBunySZsdpT7WQCqjus3Mx4DjItvmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6p6uOLv; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6p6uOLv"
Date: Tue, 19 Mar 2024 19:49:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711246321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2Yt6VUjbkkXcpGFtAZ1uSAkeG3kbYVU93knkBa9axU=;
	b=o6p6uOLvuk+t0l3fhttU458b15wCoMThprJN+e0woiGlgKMpw1PwMqCClLt2odQssOx1lC
	cEpJqu7FW+wSnG58uKETiUVbiLyCHRxzZ0y6GGFZ8/Nz9uafB4xZ7pUrPGgkjH9nsEz/6S
	8sNLlqigExfO04fu3M46gHhaJ1zGzAo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev
Subject: Re: 9P2000 bug in mainline
Message-ID: <ZfltuzRK7uM5TKvv@vm3>
References: <ZfW3eyENMB1P5jLS@vm3>
 <CAFkjPTnOcmgr8iPjBR+4+sd5LqOd3nfKZ9DecSYvZfxzzNg3WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkjPTnOcmgr8iPjBR+4+sd5LqOd3nfKZ9DecSYvZfxzzNg3WA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 18, 2024 at 10:00:33PM -0500, Eric Van Hensbergen wrote:
> fix for this already in my for-next tree, will be sending a pull
> request shortly along with a fix for another kasan reported bug.
> 
> thanks,
> 
>     -eric

I don't see the regression in linux-20240322.

Tested-by: itaru.kitayama@fujitsu.com

Thanks,
Itaru.

> 
> On Mon, Mar 18, 2024 at 9:25 PM Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
> >
> > Hi,
> >
> > I bisected down to this commit in Linus's tree:
> >
> > [724a08450f74b02bd89078a596fd24857827c012] fs/9p: simplify iget to remove unnecessary paths
> >
> > 9P2000 stopped working on FVP with the arm64 kernel.
> >
> > # mount -t 9p FM /mnt
> > [   99.367520] ==================================================================
> > [   99.367817] BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0x818/0x9a0
> > [   99.368266] Read of size 8 at addr ffff0008068a99a8 by task mount/165
> > [   99.368608]
> > [   99.368787] CPU: 1 PID: 165 Comm: mount Not tainted 6.8.0-rc1-00008-gbe57855f5050 #99
> > [   99.369190] Hardware name: FVP Base RevC (DT)
> > [   99.369442] Call trace:
> > [   99.369637]  dump_backtrace+0x94/0xf0
> > [   99.369960]  show_stack+0x1c/0x2c
> > [   99.370265]  dump_stack_lvl+0xb0/0x14c
> > [   99.370644]  print_report+0xdc/0x578
> > [   99.371010]  kasan_report+0xb4/0x100
> > [   99.371378]  __asan_report_load8_noabort+0x24/0x34
> > [   99.371807]  v9fs_stat2inode_dotl+0x818/0x9a0
> > [   99.372193]  v9fs_fid_iget_dotl+0x174/0x208
> > [   99.372576]  v9fs_mount+0x37c/0x740
> > [   99.372921]  legacy_get_tree+0xd4/0x198
> > [   99.373301]  vfs_get_tree+0x78/0x284
> > [   99.373637]  path_mount+0x738/0x1500
> > [   99.373958]  __arm64_sys_mount+0x48c/0x5c4
> > [   99.374297]  invoke_syscall+0xd4/0x24c
> > [   99.374690]  el0_svc_common.constprop.0+0xb0/0x23c
> > [   99.375128]  do_el0_svc+0x44/0x60
> > [   99.375514]  el0_svc+0x3c/0x7c
> > [   99.375893]  el0t_64_sync_handler+0x128/0x134
> > [   99.376232]  el0t_64_sync+0x1b0/0x1b4
> > [   99.376552]
> > [   99.376724] Allocated by task 165 on cpu 1 at 99.359984s:
> > [   99.377046]  kasan_save_stack+0x40/0x6c
> > [   99.377402]  kasan_save_track+0x24/0x44
> > [   99.377760]  kasan_save_alloc_info+0x6c/0x80
> > [   99.378164]  __kasan_kmalloc+0xe0/0xe4
> > [   99.378517]  kmalloc_trace+0x164/0x300
> > [   99.378874]  p9_client_getattr_dotl+0x50/0x19c
> > [   99.379269]  v9fs_fid_iget_dotl+0xb4/0x208
> > [   99.379641]  v9fs_mount+0x37c/0x740
> > [   99.379978]  legacy_get_tree+0xd4/0x198
> > [   99.380356]  vfs_get_tree+0x78/0x284
> > [   99.380678]  path_mount+0x738/0x1500
> > [   99.380992]  __arm64_sys_mount+0x48c/0x5c4
> > [   99.381322]  invoke_syscall+0xd4/0x24c
> > [   99.381713]  el0_svc_common.constprop.0+0xb0/0x23c
> > [   99.382137]  do_el0_svc+0x44/0x60
> > [   99.382516]  el0_svc+0x3c/0x7c
> > [   99.382892]  el0t_64_sync_handler+0x128/0x134
> > [   99.383217]  el0t_64_sync+0x1b0/0x1b4
> > [   99.383527]
> > [   99.383699] Freed by task 165 on cpu 1 at 99.367506s:
> > [   99.384014]  kasan_save_stack+0x40/0x6c
> > [   99.384371]  kasan_save_track+0x24/0x44
> > [   99.384729]  kasan_save_free_info+0x54/0x90
> > [   99.385130]  poison_slab_object+0x118/0x16c
> > [   99.385498]  __kasan_slab_free+0x40/0x98
> > [   99.385863]  kfree+0xec/0x290
> > [   99.386190]  v9fs_fid_iget_dotl+0x138/0x208
> > [   99.386564]  v9fs_mount+0x37c/0x740
> > [   99.386902]  legacy_get_tree+0xd4/0x198
> > [   99.387279]  vfs_get_tree+0x78/0x284
> > [   99.387602]  path_mount+0x738/0x1500
> > [   99.387915]  __arm64_sys_mount+0x48c/0x5c4
> > [   99.388246]  invoke_syscall+0xd4/0x24c
> > [   99.388637]  el0_svc_common.constprop.0+0xb0/0x23c
> > [   99.389061]  do_el0_svc+0x44/0x60
> > [   99.389439]  el0_svc+0x3c/0x7c
> > [   99.389815]  el0t_64_sync_handler+0x128/0x134
> > [   99.390135]  el0t_64_sync+0x1b0/0x1b4
> > [   99.390451]
> > [   99.390622] The buggy address belongs to the object at ffff0008068a99a8
> > [   99.390622]  which belongs to the cache kmalloc-192 of size 192
> > [   99.391063] The buggy address is located 0 bytes inside of
> > [   99.391063]  freed 192-byte region [ffff0008068a99a8, ffff0008068a9a68)
> > [   99.391530]
> > [   99.391703] The buggy address belongs to the physical page:
> > [   99.391960] page:fffffc00201a2a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0008068a9af0 pfn:0x8868a8
> > [   99.392411] head:fffffc00201a2a00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [   99.392784] flags: 0x5fffe0000000a40(workingset|slab|head|node=0|zone=2|lastcpupid=0xffff)
> > [   99.393178] page_type: 0xffffffff()
> > [   99.393490] raw: 05fffe0000000a40 ffff00080000ce40 ffff000800000850 ffff000800000850
> > [   99.393884] raw: ffff0008068a9af0 0000000000180015 00000001ffffffff 0000000000000000
> > [   99.394211] page dumped because: kasan: bad access detected
> > [   99.394479]
> > [   99.394650] Memory state around the buggy address:
> > [   99.394921]  ffff0008068a9880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [   99.395270]  ffff0008068a9900: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [   99.395619] >ffff0008068a9980: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
> > [   99.395935]                                   ^
> > [   99.396210]  ffff0008068a9a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
> > [   99.396558]  ffff0008068a9a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [   99.396874] ==================================================================
> > [   99.397370] Disabling lock debugging due to kernel taint
> >
