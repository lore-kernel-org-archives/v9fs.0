Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A24F217
	for <v9fs@lists.linux.dev>; Sun, 12 May 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542956; cv=none; b=GdQbj7r+HZHcbif/c3bF0R2sb4hnDcMJXLzw/U0KBSU2TxYzhMC+FHToBg6tuCrbuwKPKvReHUxf+raFxDp5PGluHbnvSZZilvHlj7bDAb5A+L9lDYT7ZN7OcwXnTYBaLN+jh79LvyrgeQzquaIkTrcPcxyLbG9neS3jCYIufxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542956; c=relaxed/simple;
	bh=d2dOjc8x5dO3/om9et9AkseCZ86N4yjNUyvS0baIIak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PH6/pNQx0JePLDgNc2iCNxF60Po51KZcN2sfAo4YKLEqKLvozrc/0LsUuyM5mmCAi5Wbmbie1uXkWMtTcGhERzZX6Guowz71YV1hKeQ94yLDY/Wa7RSed863M9fKppZZFYs//0zWaqncR0k5Wwr1NLzsihvp1HSOoqWjQgWIgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so292363339f.0
        for <v9fs@lists.linux.dev>; Sun, 12 May 2024 12:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715542954; x=1716147754;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swvX3MoEgR7T58qLqXbRm6r0O8bNRwxhXEmLrZYDuZo=;
        b=I/ETl33Ge51g8xn8DcRFWUD8sl8crrHdtElPzb5hIoKSL3VVgLJlNNYusHnRDwBSIS
         bH6N3xeD+9nI1DVfnkFvhBXeT+0XlcVfTMjNYRxVpbvJiB4OvF3mMkFHDfobd4oMCx+K
         BaoN5F9YqG9iX61NO3SAYp2wbOLTMHKhT4yJkdy7r4NT7MrYZdrWWlDEpA+Q9KE2DZMU
         jDVSXrerAkQrwf/oaN1M9PoAiwX7zV0NicB6ZLpBTUUNEqsPlTqIZQnCZ67hGeRvocNK
         pY/sJxQKMPLuXrl7inI5JkRx2q2S0FlIAPx69F8u5l/d/c/J/2ffj3YHp9tNgVqJsgTK
         8WBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsGqUBmuGj+ZS6dWAGEJE9Gzaa5WTaXFbpLlnZLziF+X4YsHwe9zfV4BR6V0Bjm2GoMdGAwBIf8cErOoRGGMhy4+Ettw==
X-Gm-Message-State: AOJu0YzUaf/XuimzABWXs0Yb2YfF/etak4kV9g6RD658+wBpRjLpu7Xl
	XmJ0mx5JcjL3u0weDjfCrdcl241T9XrDCYr4Ndh5nYXXB0/QfoaDRG5jfXI8kGhMrN+81NPck05
	fn4KtuPMQC2Dcqai2wfEFwIJiHLPjdpREMYicA9WZ3goHI3vkgRgnpLc=
X-Google-Smtp-Source: AGHT+IG7ctNVN7I9vbc4tZ2ugEA6a1PlvchJIksiD3XHZsS2/19WlnfKOkNt8hQGqaT+HH9wboA8fevXEctX+RjgfIWIBurQCOMv
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:75e3:f3c1 with SMTP id
 8926c6da1cb9f-489589d7ba6mr739326173.0.1715542953808; Sun, 12 May 2024
 12:42:33 -0700 (PDT)
Date: Sun, 12 May 2024 12:42:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005be0aa061846f8d6@google.com>
Subject: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
From: syzbot <syzbot+df038d463cca332e8414@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba16c1cf11c9 Merge tag 'edac_urgent_for_v6.9' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bd04e0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=df038d463cca332e8414
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/064cbe6db807/disk-ba16c1cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64148bd6b9f3/vmlinux-ba16c1cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26dda4f66cf6/bzImage-ba16c1cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df038d463cca332e8414@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:264 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:307 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:325 [inline]
BUG: KASAN: slab-use-after-free in p9_fid_put include/net/9p/client.h:275 [inline]
BUG: KASAN: slab-use-after-free in v9fs_free_request+0x5f/0xe0 fs/9p/vfs_addr.c:128
Write of size 4 at addr ffff8880624f428c by task kworker/u8:12/18964

CPU: 1 PID: 18964 Comm: kworker/u8:12 Not tainted 6.9.0-rc7-syzkaller-00188-gba16c1cf11c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound v9fs_upload_to_server_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 p9_fid_put include/net/9p/client.h:275 [inline]
 v9fs_free_request+0x5f/0xe0 fs/9p/vfs_addr.c:128
 netfs_free_request+0x246/0x600 fs/netfs/objects.c:97
 v9fs_upload_to_server fs/9p/vfs_addr.c:36 [inline]
 v9fs_upload_to_server_worker+0x200/0x3e0 fs/9p/vfs_addr.c:44
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5219:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x370 mm/slub.c:4003
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 p9_fid_create+0x4f/0x230 net/9p/client.c:853
 p9_client_walk+0x103/0x690 net/9p/client.c:1154
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x285/0xa60 fs/9p/vfs_file.c:56
 do_dentry_open+0x909/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1491
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 32641:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2111 [inline]
 slab_free mm/slub.c:4286 [inline]
 kfree+0x153/0x3b0 mm/slub.c:4396
 p9_fid_destroy net/9p/client.c:889 [inline]
 p9_client_destroy+0x1fb/0x660 net/9p/client.c:1070
 v9fs_session_close+0x51/0x210 fs/9p/v9fs.c:506
 v9fs_kill_super+0x5c/0x90 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xc6/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x251/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880624f4280
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 12 bytes inside of
 freed 96-byte region [ffff8880624f4280, ffff8880624f42e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x624f4
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888015041780 ffffea00007efa00 dead000000000005
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 32059, tgid 32059 (syz-executor.0), ts 2629641976105, free_ts 2629624772681
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2180
 allocate_slab mm/slub.c:2343 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2396
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3530
 __slab_alloc mm/slub.c:3615 [inline]
 __slab_alloc_node mm/slub.c:3668 [inline]
 slab_alloc_node mm/slub.c:3841 [inline]
 __do_kmalloc_node mm/slub.c:3971 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:3985
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 tomoyo_path_unlink+0xd0/0x110 security/tomoyo/tomoyo.c:162
 security_path_unlink+0xe3/0x140 security/security.c:1857
 do_unlinkat+0x3e6/0x830 fs/namei.c:4396
 __do_sys_unlink fs/namei.c:4447 [inline]
 __se_sys_unlink fs/namei.c:4445 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4445
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 32059 tgid 32059 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __slab_free+0x31b/0x3d0 mm/slub.c:4198
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 __do_kmalloc_node mm/slub.c:3971 [inline]
 __kmalloc+0x1e2/0x4a0 mm/slub.c:3985
 kmalloc include/linux/slab.h:632 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
 security_file_ioctl+0x77/0xb0 security/security.c:2764
 __do_sys_ioctl fs/ioctl.c:898 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880624f4180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880624f4200: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff8880624f4280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                      ^
 ffff8880624f4300: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff8880624f4380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


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
