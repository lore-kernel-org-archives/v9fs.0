Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF402144CF
	for <v9fs@lists.linux.dev>; Mon, 29 Sep 2025 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172558; cv=none; b=N905M2dIJmcXIPqa1DOykKVCHXCXe0j2uGHvBAQPzCa0Pxu4YtNZOMfvnZFJvsvygwqjyUsr+RT3QpunZg8kPRMSjN2JKShz5dbyW8RjiD9SaCNoAGyWW0/GItVDwY/f0JKLR6Kd68avzRnIPa4XIceI4mjWE89FK+1jk/QZQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172558; c=relaxed/simple;
	bh=K6p8mq/2fU4+3oJomm4Qkg6AeXya7kEJdFwnKlSnsag=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F3WpDU8ij+u97zZXC4vLC+CEhZ3aBWHX31SF+pSNPhTq1oLwuha6bMEPDonrxffXg3xXJAjUeazdsYFtJn+r5RXWMSnO3weeltqgs4Noq5Nb3B4OlMxjgNZ4mOQjJoPk2jc24FZ+r5pz4XSYKZNJdFO7/CuOtsxKf4IXaxaFJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-92c4374566fso74648739f.1
        for <v9fs@lists.linux.dev>; Mon, 29 Sep 2025 12:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172555; x=1759777355;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/A8gJl7+heYdkIpABgFNKu/+gPLokFXzc5EV+0qd3Y=;
        b=Fw2QJsWBKpJ7k1fpLOaimnLDvswsXeKz92O2O+wR0BWY3p1h+xvVBmmfjw2wYC1dCZ
         BeOTcPHFDYKWDLnn6+YjaZOHPn5aZBegLa/CUwWpwMC4ptZCM+EOl7iLcJ3j5CNUaaWO
         GtpJpNG+5js/TKlEgfoLMASwfbw8pFFJQUPHiwOaO8/pE0zLYl+GgQy1kUPd7id6vVJ/
         ra2RnsS+iDZlk2hz2LzCBFsqF+Nrdk5LDJxiLl3N43JYQQh7n8LNuTOw+sqbgNA2TDzo
         PGEUWXnC/7//lg9x5MZ6dIopIWX5lOhUVDTYC1sLyH1jz1j0ubBd51aTxD+x7tiZlByW
         OdOA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7sHhKGxN6RzN3Gh/GXTvcu9ELJ9Ng9AAVv2AO8DiOb5T7dmxqdhvf2piIPkN9ucgNU8f@lists.linux.dev
X-Gm-Message-State: AOJu0YwACmQc6ROlG91ldwNY0Cwk4MSnfrKN6/lCK5jeT5wYO0E5MwCT
	zMZky4TvxlAk8HysUsdjW8draajIz/xqdjAwCtjbCcgB+psURxuaE/s8NKHimPLgFe0n5uLfMzU
	uYGYgnpYOybA5ABo460ZMz9OZ5sgiQDHpva+mD0ANE3Ik3SS0WWA8PqYNG6A=
X-Google-Smtp-Source: AGHT+IErodArNS86lb28FE/Llj7aELISObHz6KVhWz43PkVs3jD5eDl6h2Gp+cmCkefr2ZEFcDJHgb+XVQzvgfE9a1IeiwHc6r4D
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c982:0:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-4259566ca81mr205778495ab.27.1759172555474; Mon, 29 Sep 2025
 12:02:35 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:02:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dad7cb.a00a0220.102ee.003e.GAE@google.com>
Subject: [syzbot] [v9fs?] possible deadlock in flush_all_rcu_sheaves
From: syzbot <syzbot+aecb85f534f8915b6f5b@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    262858079afd Add linux-next specific files for 20250926
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1710bd34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=997066872b7941b6
dashboard link: https://syzkaller.appspot.com/bug?extid=aecb85f534f8915b6f5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b65e4026db8/disk-26285807.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30f313e0811e/vmlinux-26285807.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13fbc9bd375c/bzImage-26285807.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aecb85f534f8915b6f5b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.3803/16566 is trying to acquire lock:
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4896 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:5220 [inline]
ffffffff8e645260 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_noprof+0x45/0x6e0 mm/slub.c:5251

but task is already holding lock:
ffffffff8e62d2b0 (slab_mutex){+.+.}-{4:4}, at: __kmem_cache_create_args+0x45/0x320 mm/slab_common.c:308

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (slab_mutex){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       flush_all_rcu_sheaves+0x21/0x210 mm/slub.c:4095
       kvfree_rcu_barrier+0x13/0x160 mm/slab_common.c:2059
       kmem_cache_destroy+0x2e/0x170 mm/slab_common.c:495
       p9_client_destroy+0x491/0x4e0 net/9p/client.c:1088
       v9fs_session_close+0x4f/0x200 fs/9p/v9fs.c:506
       v9fs_kill_super+0x5c/0x90 fs/9p/vfs_super.c:198
       deactivate_locked_super+0xbc/0x130 fs/super.c:473
       v9fs_mount+0x805/0xa50 fs/9p/vfs_super.c:179
       legacy_get_tree+0xfd/0x1a0 fs/fs_context.c:663
       vfs_get_tree+0x92/0x2b0 fs/super.c:1751
       fc_mount fs/namespace.c:1208 [inline]
       do_new_mount_fc fs/namespace.c:3651 [inline]
       do_new_mount+0x302/0x9e0 fs/namespace.c:3725
       do_mount fs/namespace.c:4048 [inline]
       __do_sys_mount fs/namespace.c:4236 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4213
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (cpu_hotplug_lock){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:491
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       udp_tunnel_encap_enable include/net/udp_tunnel.h:203 [inline]
       setup_udp_tunnel_sock+0x34f/0x550 net/ipv4/udp_tunnel_core.c:92
       l2tp_tunnel_register+0xcb6/0x1320 net/l2tp/l2tp_core.c:1679
       pppol2tp_tunnel_get net/l2tp/l2tp_ppp.c:662 [inline]
       pppol2tp_connect+0x87c/0x1750 net/l2tp/l2tp_ppp.c:710
       __sys_connect_file net/socket.c:2089 [inline]
       __sys_connect+0x316/0x440 net/socket.c:2108
       __do_sys_connect net/socket.c:2114 [inline]
       __se_sys_connect net/socket.c:2111 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2111
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1424 [inline]
       nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:702
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0x6b5/0x2300 kernel/exit.c:966
       do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
       __do_sys_exit_group kernel/exit.c:1118 [inline]
       __se_sys_exit_group kernel/exit.c:1116 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
       x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1429
       elevator_switch+0x12b/0x640 block/elevator.c:588
       elevator_change+0x315/0x4c0 block/elevator.c:691
       elevator_set_default+0x186/0x260 block/elevator.c:767
       blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       elevator_change+0x1e5/0x4c0 block/elevator.c:689
       elevator_set_none+0x42/0xb0 block/elevator.c:782
       blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
       blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4896 [inline]
       slab_alloc_node mm/slub.c:5220 [inline]
       kmem_cache_alloc_noprof+0x45/0x6e0 mm/slub.c:5251
       create_cache mm/slab_common.c:239 [inline]
       __kmem_cache_create_args+0x19b/0x320 mm/slab_common.c:340
       __kmem_cache_create include/linux/slab.h:384 [inline]
       ieee80211s_init net/mac80211/mesh.c:29 [inline]
       ieee80211_mesh_init_sdata+0x35f/0x610 net/mac80211/mesh.c:1783
       ieee80211_setup_sdata+0x80e/0xb50 net/mac80211/iface.c:1869
       ieee80211_if_change_type+0x156/0x990 net/mac80211/iface.c:2008
       ieee80211_change_iface+0xd5/0x510 net/mac80211/cfg.c:254
       rdev_change_virtual_intf net/wireless/rdev-ops.h:74 [inline]
       cfg80211_change_iface+0x795/0xef0 net/wireless/util.c:1238
       nl80211_set_interface+0x773/0xaa0 net/wireless/nl80211.c:4633
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpu_hotplug_lock --> slab_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(slab_mutex);
                               lock(cpu_hotplug_lock);
                               lock(slab_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz.0.3803/16566:
 #0: ffffffff8f9b93d0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f9538c8 (rtnl_mutex){+.+.}-{4:4}, at: nl80211_pre_doit+0x5f/0x8e0 net/wireless/nl80211.c:17927
 #2: ffff888028c28788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_lock include/net/cfg80211.h:6343 [inline]
 #2: ffff888028c28788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: nl80211_pre_doit+0x281/0x8e0 net/wireless/nl80211.c:18000
 #3: ffffffff8e62d2b0 (slab_mutex){+.+.}-{4:4}, at: __kmem_cache_create_args+0x45/0x320 mm/slab_common.c:308

stack backtrace:
CPU: 1 UID: 0 PID: 16566 Comm: syz.0.3803 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
 fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4896 [inline]
 slab_alloc_node mm/slub.c:5220 [inline]
 kmem_cache_alloc_noprof+0x45/0x6e0 mm/slub.c:5251
 create_cache mm/slab_common.c:239 [inline]
 __kmem_cache_create_args+0x19b/0x320 mm/slab_common.c:340
 __kmem_cache_create include/linux/slab.h:384 [inline]
 ieee80211s_init net/mac80211/mesh.c:29 [inline]
 ieee80211_mesh_init_sdata+0x35f/0x610 net/mac80211/mesh.c:1783
 ieee80211_setup_sdata+0x80e/0xb50 net/mac80211/iface.c:1869
 ieee80211_if_change_type+0x156/0x990 net/mac80211/iface.c:2008
 ieee80211_change_iface+0xd5/0x510 net/mac80211/cfg.c:254
 rdev_change_virtual_intf net/wireless/rdev-ops.h:74 [inline]
 cfg80211_change_iface+0x795/0xef0 net/wireless/util.c:1238
 nl80211_set_interface+0x773/0xaa0 net/wireless/nl80211.c:4633
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2617
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
 __sys_sendmsg net/socket.c:2703 [inline]
 __do_sys_sendmsg net/socket.c:2708 [inline]
 __se_sys_sendmsg net/socket.c:2706 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f061378eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f06145cc038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f06139e5fa0 RCX: 00007f061378eec9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000006
RBP: 00007f0613811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f06139e6038 R14: 00007f06139e5fa0 R15: 00007fff245198a8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
