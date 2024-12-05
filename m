Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169E19007E
	for <v9fs@lists.linux.dev>; Thu,  5 Dec 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394508; cv=none; b=Es9IHXhwUyIvgqTVlIe8JhsZ3trDZ1mdQT57+5TW6juklRMTsaWLf+iguJIF/h2STNezht6VgiOuFriMjD9qJ5OkP67FEXUcqKbyUC7dE3w0oWcCq+yiFANZmnhthMJhvJpNuV/uDIr1PwPE80L3WGq951c5NRtPyeZR7LTv9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394508; c=relaxed/simple;
	bh=ORoh/JBIeL4xUw8V6YZ0B4jqJHmp6i0zSTjhSv4hdFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MdJ+SrqvQlBHOy9RdBj0nSt9USQmpO8aSSWEaaYNIefCelZTpQHRzWCURdzzHreHHFksikXnafGndWnC+ULZ6FwgfWdm9xRajBUp/czmCRkNmRJ6B9pcMLtWxEzUlAaqA/vWft34HtpIlqmISA2VMd1HuROO7eyQGGe7fTBOr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-841963a1fb4so118601739f.2
        for <v9fs@lists.linux.dev>; Thu, 05 Dec 2024 02:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394506; x=1733999306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8KbNEV/lPNOeyeMlgzjF4k2zcfrT5xclIxTCtjGuUQ=;
        b=gAOwo8ZTlqCQLI0ZbPsseU6N9/XNQdEpv9mOo0y+KDeJDWwdEMdOyuO9eUfGF0/cMo
         T46jOGjVIHYKGfSe9zLA5+FujvKcfiocuo4CAA3dnhcSOuKrye18IRXx+NphGt3+Mc9/
         MNamQTFPeRtoGGunnvbxX5kRlCqmb+aT8tw9HZ5qw1647U1lQjvfye19uqQeYxVnyemj
         LSpPdU+BHUOoCFE9kOoGVOMgPzguWpIPkDjX7luafLZqS3bREDaNsSQTOSyBlhjQPUEG
         PsDvih9fiPyVw4mmq5S0aE3/Mfv5NXq4fZRGwhZvGewIlaxSF4+SZbvDMdvReDWinKPh
         ScYA==
X-Forwarded-Encrypted: i=1; AJvYcCXvCLzAPgHt62VKGtFDsd+JC7r9aeWaNTHXzXC7VQDcBUbsyWBNFjZSsfmODt2ICIV7I3IZ@lists.linux.dev
X-Gm-Message-State: AOJu0YwtzOVhKg4AHZ1uvan/jfT/WwiRXyAP1F48qegew+QEzm/Qz+74
	PvJjnOLC4Qgx4nVcu98ZAHsIybp9Z0P46vbY3cPCkDL5TLS/G2BuNPDX5uCNHkHVBHzcCqnTmQO
	4NQQSrf1zitB/R7RW2xXp511y+SSpqC25ktrhnKcGw7hHqSVzWivgN70=
X-Google-Smtp-Source: AGHT+IGElam6A8Bqaw0H97kGC36yyRWIC/j2lkZCveXRK0BFGDny2FxgTCQKQmIfZW2XlWRDQS0lljzAVD89OesvVCGMhvbAfRC7
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3a7f9a3b564mr119264425ab.9.1733394506086; Thu, 05 Dec 2024
 02:28:26 -0800 (PST)
Date: Thu, 05 Dec 2024 02:28:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751804a.050a0220.17bd51.009a.GAE@google.com>
Subject: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
From: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159927c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c765e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com

INFO: task syz-executor:5928 blocked for more than 143 seconds.
      Not tainted 6.12.0-next-20241128-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20080 pid:5928  tgid:5928  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 netfs_wait_for_outstanding_io include/linux/netfs.h:558 [inline]
 v9fs_evict_inode+0x171/0x360 fs/9p/vfs_inode.c:348
 evict+0x4e8/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:625
 dput+0x19f/0x2b0 fs/dcache.c:867
 shrink_dcache_for_umount+0xb4/0x180 fs/dcache.c:1577
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 v9fs_kill_super+0x4c/0x90 fs/9p/vfs_super.c:193
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a37781b77
RSP: 002b:00007ffe40eae1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f8a37781b77
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe40eae260
RBP: 00007ffe40eae260 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe40eaf2e0
R13: 00007f8a377f3824 R14: 000000000003f13f R15: 00007ffe40eaf320
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937b20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937b20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937b20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
2 locks held by kworker/u8:8/3481:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000cdb7d00 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000cdb7d00 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
2 locks held by getty/5584:
 #0: ffff88814e3000a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032eb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5928:
 #0: ffff8880352ee0e0 (&type->s_umount_key#51){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880352ee0e0 (&type->s_umount_key#51){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880352ee0e0 (&type->s_umount_key#51){+.+.}-{4:4}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
1 lock held by syz.5.407/7698:
1 lock held by syz.3.408/7704:
1 lock held by syz.4.409/7705:
1 lock held by syz.0.410/7711:
1 lock held by syz.2.411/7714:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7698 Comm: syz.5.407 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_preemption_disabled+0x2/0x120 lib/smp_processor_id.c:13
Code: 8d 5f 8c 48 c7 c6 80 8d 5f 8c eb 1c 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 <41> 56 41 54 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24
RSP: 0018:ffffc9000478ee90 EFLAGS: 00000283
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff817aaec4
RDX: 0000000000000000 RSI: ffffffff8c5f8d80 RDI: ffffffff8c5f8d40
RBP: ffffc9000478f008 R08: ffffffff90199eb7 R09: 1ffffffff20333d6
R10: dffffc0000000000 R11: fffffbfff20333d7 R12: 1ffff920008f1de0
R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f71caed9d58 CR3: 0000000065d88000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:737
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5820
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __page_table_check_zero+0xb1/0x350 mm/page_table_check.c:148
 page_table_check_free include/linux/page_table_check.h:41 [inline]
 free_pages_prepare mm/page_alloc.c:1128 [inline]
 free_unref_folios+0xf76/0x1a90 mm/page_alloc.c:2740
 folios_put_refs+0x76c/0x860 mm/swap.c:962
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x64c/0x1cf0 mm/shmem.c:1040
 shmem_truncate_range mm/shmem.c:1152 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1280
 evict+0x4e8/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:625
 dput+0x19f/0x2b0 fs/dcache.c:867
 __fput+0x5ba/0xa50 fs/file_table.c:458
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3016
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fefa3180849
Code: Unable to access opcode bytes at 0x7fefa318081f.
RSP: 002b:00007fefa3eb0058 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: 0000000000010106 RBX: 00007fefa3346080 RCX: 00007fefa3180849
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000008
RBP: 00007fefa31f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fefa3346080 R15: 00007ffc05aa9138
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
