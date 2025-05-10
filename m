Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC2236EE
	for <v9fs@lists.linux.dev>; Sat, 10 May 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746896430; cv=none; b=VP7SYq8QE5bYvVJhIfJQBb9cWzRxw3arTEgx/4196F3Q5gok8j3cUHwJbYPlDZ52Tg03AcR6uDF9NZXbSMkwIGmNqeaPNk3r0oGtbpWB+9Q+aHr5JLdRHwhBiGWDu4I3S6nFwEbY5g1CxjUgsoDly1/3o2axvduI1nOwHIBm9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746896430; c=relaxed/simple;
	bh=K8n0HpR/neCLBEbB828sJp2oVFAuaDVp3vnH2yHape8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sr7d+36C5Hk99ABk5MPwOawHhp7x5eTUBy56mneVDhFUT+hpUX9+CeADv6DO2nWjK6t0AXuUkbyA/kUc6vG+1yNr3qkfYLLMeYyAwFJduq61nbca/mYjaQKqZI5WlMVdHFPYkZTd5smMwx3YiRjl4UjxIc12eOXGgZWNzeQuCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3da76423ba1so60679415ab.0
        for <v9fs@lists.linux.dev>; Sat, 10 May 2025 10:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746896426; x=1747501226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtpNmZE2s/t0daIHScYq92YukUSpQckx6jyaq+D5Br8=;
        b=sz3NGBUeGBQ/DkAzto3FieA6wqw1u4oH7b5RD5rGQyZQq9D3FyJvnCVOv5XkQ550dw
         czEV0IjXGczFjTJB4yh42iiQQaphyd/oMeo4fnKdJV/WXvQxpSbAHy86T8SaF7adn+6M
         0kEctLb47uVFHiYlGyRgGXO8NnN52RfO0R9qWQfduIrD3oyv9BK2dHjJMqsk2PW2BnhV
         H+T0eE8b+EBUv2U4K2SQmisGkrwyBm/UJ4B1DBn8AGQI/1NJ+YV8aEiliG6pe02P1z4N
         v1C8SgllbQIirQSCxlSww8PV7F90ZAOYnI8NvMUxg+wh2yHzJGIRmzHvQBrN/V6I33IT
         iSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzKp0CrWPrxoCWT8PzUU16XadbJN6MGR/5pNACto6RR/QQ7rJtYPLiU8mrRnggBGqOVbl1@lists.linux.dev
X-Gm-Message-State: AOJu0YzeU0EyWHQwOWiDoAAr1MQFNgpLiu58ocxv2w6DWre9obtOpHFk
	kR+t6GwVCVSiX6lVOs8qH1gaWitYpPYGY4+LLSpVUiEElKt2tNOA8GWeZZ+uhyUhjiJJuEBS5ho
	Ix5U0+SaHzwhKhE2ZA0hS0E0KHq199iGaZYrVK76HnRqLr1k/NHYqoWo=
X-Google-Smtp-Source: AGHT+IG+r3FmrD5d5RAbjotiKkqlITeXPybWN4TiJr1WK6tG+KercdVCnbQ3u8Ti8yLdQKniJj2pwKPjdUZGKbLF37ezZK0GTdLT
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c83:b0:3d9:66ba:1ad2 with SMTP id
 e9e14a558f8ab-3da7e169228mr94328825ab.0.1746896426468; Sat, 10 May 2025
 10:00:26 -0700 (PDT)
Date: Sat, 10 May 2025 10:00:26 -0700
In-Reply-To: <6751804a.050a0220.17bd51.009a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681f862a.050a0220.f2294.0013.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
From: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0e1329d4045c Merge tag 'rust-fixes-6.15-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a76cf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d34d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d91670580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab812a79f364/disk-0e1329d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f8097de4dd6/vmlinux-0e1329d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58fe086be90f/bzImage-0e1329d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com

INFO: task syz-executor256:5823 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc5-syzkaller-00204-g0e1329d4045c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor256 state:D stack:25112 pid:5823  tgid:5823  ppid:5816   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 netfs_wait_for_outstanding_io include/linux/netfs.h:558 [inline]
 v9fs_evict_inode+0x170/0x320 fs/9p/vfs_inode.c:348
 evict+0x501/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:660
 dput+0x19f/0x2b0 fs/dcache.c:902
 shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1612
 generic_shutdown_super+0x67/0x2c0 fs/super.c:620
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 v9fs_kill_super+0x4c/0x90 fs/9p/vfs_super.c:193
 deactivate_locked_super+0xb9/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1435
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work+0x5e/0x80 include/linux/resume_user_mode.h:50
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x9a/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f938ec869b7
RSP: 002b:00007ffcc34c98a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000001a18b RCX: 00007f938ec869b7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcc34c9960
RBP: 00007ffcc34c9960 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffcc34ca9d0
R13: 000055556f5f06c0 R14: 00007ffcc34ca9d0 R15: 00000000000000a9
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
2 locks held by kworker/u8:6/1320:
 #0: ffff88801a089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc900045cfc60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc900045cfc60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
2 locks held by kworker/u8:10/3558:
 #0: ffff88801a089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc9000c4e7c60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000c4e7c60 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
2 locks held by getty/5579:
 #0: ffff888030a8b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002ffe2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor256/5819:
 #0: ffffffff8df41200 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3774
1 lock held by syz-executor256/5821:
 #0: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:336 [inline]
 #0: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b7/0x730 kernel/rcu/tree_exp.h:998
1 lock held by syz-executor256/5822:
 #0: ffff888077f8e0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888077f8e0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888077f8e0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
1 lock held by syz-executor256/5823:
 #0: ffff88807f15a0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807f15a0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807f15a0e0 (&type->s_umount_key#43){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
1 lock held by syz-executor256/11897:
 #0: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:304 [inline]
 #0: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f4/0x730 kernel/rcu/tree_exp.h:998

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc5-syzkaller-00204-g0e1329d4045c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc5-syzkaller-00204-g0e1329d4045c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 03 1b 19 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: aeb744c0f33a6400 RBX: ffffffff81974e28 RCX: aeb744c0f33a6400
RDX: 0000000000000001 RSI: ffffffff8d7372f8 RDI: ffffffff8bc0fee0
RBP: ffffc90000197f20 R08: ffff8880b8932b5b R09: 1ffff1101712656b
R10: dffffc0000000000 R11: ffffed101712656c R12: ffffffff8f7da770
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff110038d9b40
FS:  0000000000000000(0000) GS:ffff888126200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556f5f86f8 CR3: 0000000078712000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:748
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:423
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
