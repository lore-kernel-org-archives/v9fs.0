Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B060198A0F
	for <v9fs@lists.linux.dev>; Tue, 26 Nov 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732661566; cv=none; b=hApBsZk2GVcoSXJBH+294VL2QW2BICiHT2RJu6P/4p0RbgxHLhnbXTDtX6qlqkb655p45syNNnX3zb3KdB7zKklM82jhK8SbAeJla3R8CjcDdVypt/Bfg8pIPP6iNFv2n5RBHjLY1mLK+beKKRq96Z3f9bL2J8zXVPxFAUILJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732661566; c=relaxed/simple;
	bh=EuGaJ/mZjaH7jxVupFZcPBWvhV2IcdiVCjvTI/XbS0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJTKXZkBjh52n7zCPmOQ/zo9GcyNqqL8bRSqSsas/sgJenGgxPCuWCaVyGFFNScMD7uHAVeE7UjszqGZxhFoIh/exHTJhSPsVeTR2gO/zBPuSR5qnxoJ/nvesaV69XvoIzzlc5zjPHYtmnhD0oWP3meneWo/PPwMkZ57p74P0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rZPLSEqw; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rZPLSEqw"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9F4CE14C1E1;
	Tue, 26 Nov 2024 23:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732661555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyaRRZ0tTk1QQVewkHdtrvnitidFGtwFZBAQhVsH+MY=;
	b=rZPLSEqwSzh2jGGTDujnbqRFYoU/QRv+GIAmdyxT+GTkoeTZ+9TBYoQFWTGtbTvqs2Y0SE
	gEWqg2YC5naCkddKhzZqc/hF1wnAjuMsylsPBA7jB4BghDuADoA8HXAn9Ey9l+1VrT6xD6
	Zcpla/xuHBzcke5adY3e1R0YTNgVpxoEme1JpiS2r/NCJPnZL+QngekPloQDdg4bIEyrkC
	4bIvx63rBbqXcvMex0tEW53E67k0+yy0NDyG7aOXpnRcp2jLP7BWQR68n2d7RPFsjicOig
	wLe3dwOgmydxmNxGJM6o0bNXOTMEmbURABSw6ZoY1R9/wjUv5iXzMvv3dy0TgA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 36b02ea3;
	Tue, 26 Nov 2024 22:52:30 +0000 (UTC)
Date: Wed, 27 Nov 2024 07:52:15 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+f86e49ba96853e315c26@syzkaller.appspotmail.com>,
	ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] BUG: stack guard page was hit in io_uring_enter
Message-ID: <Z0ZRH-gUl59t5AHa@codewreck.org>
References: <6745dced.050a0220.1286eb.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6745dced.050a0220.1286eb.0019.GAE@google.com>

I guess it's another dup
#syz dup: [syzbot] [v9fs?] BUG: stack guard page was hit in sys_open

Leaving quote below for David
syzbot wrote on Tue, Nov 26, 2024 at 06:36:29AM -0800:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    05b92660cdfe Merge tag 'pci-v6.12-fixes-2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=155e9630580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=728f7ffd25400452
> dashboard link: https://syzkaller.appspot.com/bug?extid=f86e49ba96853e315c26
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-05b92660.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/240ba8a2a878/vmlinux-05b92660.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fed8acdd322e/bzImage-05b92660.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f86e49ba96853e315c26@syzkaller.appspotmail.com
> 
> BUG: TASK stack guard page was hit at ffffc90001717fd8 (stack is ffffc90001718000..ffffc90001720000)
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 3 UID: 0 PID: 8268 Comm: syz.0.692 Not tainted 6.12.0-rc5-syzkaller-00291-g05b92660cdfe #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:unwind_next_frame+0x76/0x20c0 arch/x86/kernel/unwind_orc.c:470
> Code: 41 5f c3 cc cc cc cc 49 8d 6d 48 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 00 18 00 00 49 8b 45 48 <48> 89 44 24 08 49 8d 45 38 48 89 c2 48 89 04 24 48 b8 00 00 00 00
> RSP: 0018:ffffc90001717fe8 EFLAGS: 00010046
> RAX: ffffffff813d7404 RBX: 0000000000000001 RCX: ffffc90001718140
> RDX: 1ffff920002e301e RSI: ffff888022fc0000 RDI: ffffc900017180a8
> RBP: ffffc900017180f0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc900017180a8 R11: 0000000000000000 R12: fffff520002e3017
> R13: ffffc900017180a8 R14: ffffc900017180a8 R15: ffffc900017180b0
> FS:  00007f483b1d36c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90001717fd8 CR3: 000000004e7f6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  </#DF>
>  <TASK>
>  __unwind_start+0x45f/0x7f0 arch/x86/kernel/unwind_orc.c:760
>  unwind_start arch/x86/include/asm/unwind.h:64 [inline]
>  arch_stack_walk+0x74/0x100 arch/x86/kernel/stacktrace.c:24
>  stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:247 [inline]
>  slab_post_alloc_hook mm/slub.c:4085 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
>  radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
>  idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
>  idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
>  idr_alloc+0xc1/0x130 lib/idr.c:87
>  p9_tag_alloc+0x394/0x870 net/9p/client.c:321
>  p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
>  p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
>  p9_client_read_once+0x24f/0x820 net/9p/client.c:1575
>  p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
>  v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
>  netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
>  netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>  netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
>  netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
>  netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
>  netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
>  v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
>  io_iter_do_read io_uring/rw.c:771 [inline]
>  __io_read+0x320/0x1190 io_uring/rw.c:865
>  io_read+0x1e/0x70 io_uring/rw.c:943
>  io_issue_sqe+0x175/0x13d0 io_uring/io_uring.c:1739
>  io_queue_sqe io_uring/io_uring.c:1953 [inline]
>  io_submit_sqe io_uring/io_uring.c:2209 [inline]
>  io_submit_sqes+0x9b4/0x2530 io_uring/io_uring.c:2324
>  __do_sys_io_uring_enter+0xc0f/0x1170 io_uring/io_uring.c:3343
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f483a37e719
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f483b1d3038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> RAX: ffffffffffffffda RBX: 00007f483a536058 RCX: 00007f483a37e719
> RDX: 0000000000000000 RSI: 0000000000000567 RDI: 0000000000000007
> RBP: 00007f483a3f132e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f483a536058 R15: 00007ffc2e04f068
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:unwind_next_frame+0x76/0x20c0 arch/x86/kernel/unwind_orc.c:470
> Code: 41 5f c3 cc cc cc cc 49 8d 6d 48 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 00 18 00 00 49 8b 45 48 <48> 89 44 24 08 49 8d 45 38 48 89 c2 48 89 04 24 48 b8 00 00 00 00
> RSP: 0018:ffffc90001717fe8 EFLAGS: 00010046
> RAX: ffffffff813d7404 RBX: 0000000000000001 RCX: ffffc90001718140
> RDX: 1ffff920002e301e RSI: ffff888022fc0000 RDI: ffffc900017180a8
> RBP: ffffc900017180f0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc900017180a8 R11: 0000000000000000 R12: fffff520002e3017
> R13: ffffc900017180a8 R14: ffffc900017180a8 R15: ffffc900017180b0
> FS:  00007f483b1d36c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90001717fd8 CR3: 000000004e7f6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	41 5f                	pop    %r15
>    2:	c3                   	ret
>    3:	cc                   	int3
>    4:	cc                   	int3
>    5:	cc                   	int3
>    6:	cc                   	int3
>    7:	49 8d 6d 48          	lea    0x48(%r13),%rbp
>    b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   12:	fc ff df
>   15:	48 89 ea             	mov    %rbp,%rdx
>   18:	48 c1 ea 03          	shr    $0x3,%rdx
>   1c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>   20:	0f 85 00 18 00 00    	jne    0x1826
>   26:	49 8b 45 48          	mov    0x48(%r13),%rax
> * 2a:	48 89 44 24 08       	mov    %rax,0x8(%rsp) <-- trapping instruction
>   2f:	49 8d 45 38          	lea    0x38(%r13),%rax
>   33:	48 89 c2             	mov    %rax,%rdx
>   36:	48 89 04 24          	mov    %rax,(%rsp)
>   3a:	48                   	rex.W
>   3b:	b8 00 00 00 00       	mov    $0x0,%eax
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
Dominique Martinet | Asmadeus
