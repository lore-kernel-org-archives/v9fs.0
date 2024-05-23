Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05EF84D04
	for <v9fs@lists.linux.dev>; Thu, 23 May 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498433; cv=none; b=ZHKRqEKUDPYi/RkOd1UoMHSRWq5gVFJplDRLEPJAAwRJrdgD2hqvTT+QXBeRt2wPrxlViKO0SlICETtb5O1DBW1vgr5TNqzIunZlg1lpAx35m24Oeh6Neuw2P3GBaugoEBJj5IJfFLfiLWg3GvWjIFpm3gEzCVAc9OKWnTwPaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498433; c=relaxed/simple;
	bh=H+tXmNcAhZCbaunf+q9hDNC+6YJEJeVLs4fE/NM4B9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlfWAEnA9h2C0DlA0DKfro+5uBW0G+P3kXKDolNZSBGP+/Ce7X/gAIrDDcYXBEsTsk8jhoPb5oKppPMuttOTArcmP3UM40/A7uKGzXh3izEE+nhXzlWhsXKyDCnFlS5ji25vfRG2wpiptRgyWDvXxaWg1cpH6Bk1drdIUf6hahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=l2ErYLa3; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="l2ErYLa3"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id BE1F814C2DD;
	Thu, 23 May 2024 23:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716498430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqrl7gT/QrJWExYUn9SPbHv1Q/3kOtxE9vuanTdHAGg=;
	b=l2ErYLa3VLyXjJ/Pnue62aacJzVIA0mgOYGCu0tXvHYSM4BMZ8rHwtzDqYVrgjORHw5YZ9
	BWflDAJ3EdsFRyk/QSyEZbk4OerS7bvYrgyyGthejcri3vzN8pANf1W43tH/l/nQ/xpe2t
	6nY5BKSZ9LaWPSxZ0injTgwOxjGm+TeRP9X8wo30ubW4m0PdFv8E1FPtYaf7l1K+ix39LA
	82E+XL0mg0872R9Y7KKgpyr2Kn2mdUc+73W5S5QnPTxkhP3ydHbL50EXdekKsZ3gu6cDnE
	ViAyX244L0GovcBVZdy1LDCEjUHuHrMvCbMpPHz3ePI96P6oufQokqendZxILw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d50f76f6;
	Thu, 23 May 2024 21:07:04 +0000 (UTC)
Date: Fri, 24 May 2024 06:06:49 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>,
	syzbot <syzbot+4e2269434184f95684d6@syzkaller.appspotmail.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fd_request
Message-ID: <Zk-v6Tuy7KSSXjks@codewreck.org>
References: <000000000000b03c66061923502f@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000b03c66061923502f@google.com>

syzbot wrote on Thu, May 23, 2024 at 11:35:28AM -0700:
> syzbot found the following issue on:
> 
> HEAD commit:    1b294a1f3561 Merge tag 'net-next-6.10' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1507ead0980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bddb81daac38d475
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e2269434184f95684d6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Looks like another duplicate of the same destroy vs netfs issue, marking
as dup (or trying to at least)

#syz dup: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_client_destroy


> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cf1ddff37cc/disk-1b294a1f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/85de01f27485/vmlinux-1b294a1f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cc17337dab81/bzImage-1b294a1f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4e2269434184f95684d6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
> Read of size 8 at addr ffff888079d8f848 by task kworker/u8:15/9021
> 
> CPU: 1 PID: 9021 Comm: kworker/u8:15 Not tainted 6.9.0-syzkaller-05151-g1b294a1f3561 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Workqueue: events_unbound netfs_write_collection_worker
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  p9_fd_request+0x53/0x520 net/9p/trans_fd.c:674
>  p9_client_rpc+0x305/0xac0 net/9p/client.c:704
>  p9_client_clunk+0x75/0x260 net/9p/client.c:1439
>  netfs_free_request+0x246/0x5e0 fs/netfs/objects.c:133
>  netfs_write_collection_worker+0x507c/0x5640 fs/netfs/write_collect.c:701
>  process_one_work kernel/workqueue.c:3267 [inline]
>  process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Allocated by task 14624:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  kmalloc_trace+0x1db/0x370 mm/slub.c:4070
>  kmalloc include/linux/slab.h:628 [inline]
>  kzalloc include/linux/slab.h:749 [inline]
>  p9_fd_open net/9p/trans_fd.c:828 [inline]
>  p9_fd_create+0x17b/0x530 net/9p/trans_fd.c:1102
>  p9_client_create+0x862/0x1040 net/9p/client.c:1013
>  v9fs_session_init+0x1e4/0x1b80 fs/9p/v9fs.c:410
>  v9fs_mount+0xce/0xa90 fs/9p/vfs_super.c:122
>  legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
>  vfs_get_tree+0x92/0x2a0 fs/super.c:1779
>  do_new_mount+0x2be/0xb40 fs/namespace.c:3352
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 14191:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2121 [inline]
>  slab_free mm/slub.c:4353 [inline]
>  kfree+0x153/0x3b0 mm/slub.c:4463
>  p9_client_destroy+0xc9/0x660 net/9p/client.c:1065
>  v9fs_session_close+0x51/0x210 fs/9p/v9fs.c:506
>  v9fs_kill_super+0x5c/0x90 fs/9p/vfs_super.c:196
>  deactivate_locked_super+0xc6/0x130 fs/super.c:472
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
>  task_work_run+0x251/0x310 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Last potentially related work creation:
>  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>  insert_work+0x3e/0x330 kernel/workqueue.c:2261
>  __queue_work+0xc24/0xef0 kernel/workqueue.c:2413
>  queue_work_on+0x14f/0x250 kernel/workqueue.c:2448
>  queue_work include/linux/workqueue.h:605 [inline]
>  schedule_work include/linux/workqueue.h:666 [inline]
>  p9_poll_mux net/9p/trans_fd.c:639 [inline]
>  p9_poll_workfn+0x3b0/0x5e0 net/9p/trans_fd.c:1177
>  process_one_work kernel/workqueue.c:3267 [inline]
>  process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Second to last potentially related work creation:
>  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>  insert_work+0x3e/0x330 kernel/workqueue.c:2261
>  __queue_work+0xc24/0xef0 kernel/workqueue.c:2413
>  queue_work_on+0x14f/0x250 kernel/workqueue.c:2448
>  queue_work include/linux/workqueue.h:605 [inline]
>  schedule_work include/linux/workqueue.h:666 [inline]
>  p9_fd_request+0x2e1/0x520 net/9p/trans_fd.c:691
>  p9_client_rpc+0x305/0xac0 net/9p/client.c:704
>  p9_client_write+0x328/0x7a0 net/9p/client.c:1633
>  v9fs_issue_write+0xfd/0x1c0 fs/9p/vfs_addr.c:59
>  netfs_issue_write fs/netfs/write_issue.c:258 [inline]
>  netfs_advance_write+0x776/0xe00 fs/netfs/write_issue.c:298
>  netfs_write_folio+0x1263/0x1f70 fs/netfs/write_issue.c:468
>  netfs_writepages+0x91f/0xf20 fs/netfs/write_issue.c:536
>  do_writepages+0x35b/0x870 mm/page-writeback.c:2613
>  filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
>  __filemap_fdatawrite_range mm/filemap.c:430 [inline]
>  __filemap_fdatawrite mm/filemap.c:436 [inline]
>  filemap_fdatawrite+0xfb/0x160 mm/filemap.c:441
>  v9fs_dir_release+0x154/0x560 fs/9p/vfs_dir.c:219
>  __fput+0x42b/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1556 [inline]
>  __se_sys_close fs/open.c:1541 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1541
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888079d8f800
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 72 bytes inside of
>  freed 1024-byte region [ffff888079d8f800, ffff888079d8fc00)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888079d8c800 pfn:0x79d88
> head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000a40(workingset|slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000a40 ffff888015041dc0 ffffea0000471810 ffffea0000aef810
> raw: ffff888079d8c800 000000000010000f 00000001ffffffff 0000000000000000
> head: 00fff00000000a40 ffff888015041dc0 ffffea0000471810 ffffea0000aef810
> head: ffff888079d8c800 000000000010000f 00000001ffffffff 0000000000000000
> head: 00fff00000000003 ffffea0001e76201 dead000000000122 00000000ffffffff
> head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 62, tgid 62 (kworker/u8:4), ts 255477095338, free_ts 255425419447
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
>  prep_new_page mm/page_alloc.c:1541 [inline]
>  get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
>  __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page+0x5f/0x160 mm/slub.c:2190
>  allocate_slab mm/slub.c:2353 [inline]
>  new_slab+0x84/0x2f0 mm/slub.c:2406
>  ___slab_alloc+0xb07/0x12e0 mm/slub.c:3592
>  __slab_alloc mm/slub.c:3682 [inline]
>  __slab_alloc_node mm/slub.c:3735 [inline]
>  slab_alloc_node mm/slub.c:3908 [inline]
>  __do_kmalloc_node mm/slub.c:4038 [inline]
>  __kmalloc+0x2e5/0x4a0 mm/slub.c:4052
>  kmalloc include/linux/slab.h:632 [inline]
>  kzalloc include/linux/slab.h:749 [inline]
>  ieee802_11_parse_elems_full+0xd5/0x2870 net/mac80211/parse.c:880
>  ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2330 [inline]
>  ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2337 [inline]
>  ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1574 [inline]
>  ieee80211_ibss_rx_queued_mgmt+0x4c8/0x2d70 net/mac80211/ibss.c:1605
>  ieee80211_iface_process_skb net/mac80211/iface.c:1605 [inline]
>  ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1659
>  cfg80211_wiphy_work+0x223/0x260 net/wireless/core.c:437
>  process_one_work kernel/workqueue.c:3267 [inline]
>  process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> page last free pid 7787 tgid 7785 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1141 [inline]
>  free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
>  free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
>  __folio_put_large+0x168/0x1d0 mm/swap.c:132
>  __folio_put+0x299/0x390 mm/swap.c:140
>  page_to_skb+0x3dd/0x9b0 drivers/net/virtio_net.c:810
>  receive_mergeable drivers/net/virtio_net.c:1834 [inline]
>  receive_buf+0x3bd/0x3830 drivers/net/virtio_net.c:1955
>  virtnet_receive drivers/net/virtio_net.c:2259 [inline]
>  virtnet_poll+0x7f8/0x18c0 drivers/net/virtio_net.c:2362
>  __napi_poll+0xcd/0x490 net/core/dev.c:6721
>  napi_poll net/core/dev.c:6790 [inline]
>  net_rx_action+0x7bb/0x10a0 net/core/dev.c:6906
>  handle_softirqs+0x2d8/0x990 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>  common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> 
> Memory state around the buggy address:
>  ffff888079d8f700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888079d8f780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff888079d8f800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                               ^
>  ffff888079d8f880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888079d8f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
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
