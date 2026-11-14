Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794687459;
	b=BG8bcUw0l4ayqzc978AmPepUd1jt/yI/lRzk4IYcDDK+sGGeUaharKm8JzuTMBgJtsY9
	 DFcDcHHJoMdcFmO/uIh6yT+/L72uF4QM2QqZjN73dAQ6Ff2ddfWmNG/i+dq2eE0Fvz1Fn
	 3V6lkdh1OXPonR7yD8BcB6BGZdoM1/PeT01PbP1SUPfqzAjerW8XGI1Cl8LyOJD00H7uO
	 Kt7naR0AGSm8bIIweE9hwtq0SVOQoX0ojkBerdZIR3E7SmwaLdEvV+YXoGwkBme3bznXT
	 GhWD+hRWkVjiXunh0kTT0Jv9WaLdyAfybAqK1kT8vsMOPU4fxzEXvRna8aNDrnnsrQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794687459;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=hxZtScjc23srK4XQG9qTJWS0pbU3WOLgEX045sllTfw=;
	b=VvX9ofzxM5FXEeABpQ7espZuR3wmLn+JVSq8WCXTJub5pC0qGXjfMEZjmezltB9CWsbB
	 7a6KHQ0XYHKkesU5fg83rSJc82kF1dJd0kG4RZpIT5budwapTeXg16R/E6asB6lq25cTb
	 VF21QKQW5gPYCKCNYcl7iI2IWI8NiGDmKv/TGUlyR3o39UMMpzwPL01Lx1tiL/boqRbrF
	 Cjam4UCiY/q0TMR5FmnL7wblPg7QsmXA3u61cLS/+fYtfvhBqWR0EjjgQXiY1fSsHnrKq
	 JIEkFl4xyyG3dxwA0Y4aHaff+t+6m5BpvKfpRrVW9q34NIRb2m1wd4Sb/mvYHqKKHuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7910606A329
	for <v9fs@lists.linux.dev>; Sat, 14 Nov 2026 20:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7910606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab8b4887d4so1467458b6e.1
        for <v9fs@lists.linux.dev>; Sat, 14 Nov 2026 12:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794687458; x=1795292258;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxZtScjc23srK4XQG9qTJWS0pbU3WOLgEX045sllTfw=;
        b=Dyhksl1mtlAvbpwkTXB01yrO/AfqgzxTOt7GTTjvrH+RoPLRgikAFqQcq3bOD0BQHO
         c97JGgJlwdgQYzsTN7xZLo5tSHdvVKgXgUqkxSwaPIrBabzFpmfgUjgqxJjX7USLc7KF
         juFxX2yOeGhjucHKYPXC3BFRUf2qtyKsHfnuzl8xMykkdIE9Z/KVk0p/H1Ai6qXsNHYu
         j8EcZYpn5ZqgEvrsEPc6dTTEkD6oMA4T+Z5VzGrpOQMqfChwQfdFeBpGP8U9gX9QhoBE
         2zCWYkuercOuAjtoq39c2e86V1FLZRUqNDSc6k3unkgBLU3NaIvKrce0rn2xhOzxWN/i
         VnGg==
X-Forwarded-Encrypted: i=1; AL+hErE52Laj/Rbg1z2r8v96cHkPzMbkJRf6O4LieZv6o/7UsAvzbu4KBrgAs9lSlRZDGVoW0tK8@lists.linux.dev
X-Gm-Message-State: APuU4Z8RBmrlyZaWYdVj/3cf/qyvhQQDFT9Kl0we52POWVCy8zQIUXZx
	rTcj5WxEYjthiDyl8u9thPC2pBYKL4idG2cmQGm4vQfcWgPAhxWViooiBXdKYZToOj9h2tUQjiQ
	fPzsu5PQVA+C8pya4l29ILLPx1+ZAaSoto+Ly/CJRxoYRt45nPkINqSSw2Pc=
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0b:b0:4d6:90f3:74b4 with SMTP id
 5614622812f47-56e6500f37bmr5812399b6e.52.1794687457766; Sat, 14 Nov 2026
 12:17:37 -0800 (PST)
Date: Sat, 14 Nov 2026 12:17:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af8c1e1.aa201734.33d248.0007.GAE@google.com>
Subject: [syzbot] [v9fs?] possible deadlock in __cachefiles_write
From: syzbot <syzbot+b8ae5f37f5baa84cb085@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2800868f6322 Merge tag 'sound-7.4-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110f4b69580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=b8ae5f37f5baa84cb085
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2800868f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a4b1a29003d/vmlinux-2800868f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02da498b013d/bzImage-2800868f.xz

AI-generated root cause summary:
A false-positive circular locking dependency is reported by lockdep between the
backing filesystem's freeze protection lock (`sb_writers`), the IMA integrity
cache mutex (`&ima_iint_mutex_key[depth]`), and the upper network filesystem
inode lock (`&sb->s_type->i_mutex_key`). In `do_open()` with `O_TRUNC`,
`mnt_want_write()` is held across `security_file_post_open()`, establishing
`sb_writers -> ima_iint_mutex`. During IMA file measurement on 9p,
`integrity_kernel_read()` takes 9p's `i_rwsem`, establishing `ima_iint_mutex ->
9p i_rwsem`. Finally, truncating a 9p file (`do_truncate()`) flushes dirty pages
through `netfs_writepages()` to cachefiles, where `__cachefiles_write()`
acquires `sb_writers` on the local backing filesystem. Because neither 9p nor
the local backing filesystem increments `s_stack_depth`, their distinct
per-inode `iint->mutex` instances share lockdep class `&ima_iint_mutex_key[0]`,
producing a spurious circular dependency report even though the actual lock
objects differ and cannot deadlock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=b8ae5f37f5baa84cb085

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8ae5f37f5baa84cb085@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.7.1192/10055 is trying to acquire lock:
ffff88802d3a6478 (sb_writers#5){.+.+}-{0:0}, at: __cachefiles_write+0x56f/0xd40 fs/cachefiles/io.c:355

but task is already holding lock:
ffff88810b968140 (&sb->s_type->i_mutex_key#30){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
ffff88810b968140 (&sb->s_type->i_mutex_key#30){++++}-{4:4}, at: do_truncate+0x14e/0x240 fs/open.c:63

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#30){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_read_interruptible+0x97/0x520 kernel/locking/rwsem.c:1584
       netfs_start_io_read+0x1f/0x100 fs/netfs/locking.c:67
       netfs_buffered_read_iter+0xf3/0x190 fs/netfs/buffered_read.c:940
       netfs_file_read_iter+0x10f/0x190 fs/netfs/buffered_read.c:978
       v9fs_file_read_iter+0x9b/0x100 fs/9p/vfs_file.c:369
       __kernel_read+0x397/0xac0 fs/read_write.c:512
       integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
       ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x952/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xe04/0x2360 security/integrity/ima/ima_main.c:425
       ima_file_check+0xbf/0x110 security/integrity/ima/ima_main.c:686
       security_file_post_open+0xc4/0x210 security/security.c:2777
       do_open fs/namei.c:4853 [inline]
       path_openat+0x5d0/0x23f0 fs/namei.c:5016
       do_file_open+0x20e/0x430 fs/namei.c:5045
       do_sys_openat2+0x163/0x1d0 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_open fs/open.c:1457 [inline]
       __se_sys_open fs/open.c:1453 [inline]
       __x64_sys_open+0xfe/0x1d0 fs/open.c:1453
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
       process_measurement+0x5ab/0x2360 security/integrity/ima/ima_main.c:319
       ima_file_check+0xbf/0x110 security/integrity/ima/ima_main.c:686
       security_file_post_open+0xc4/0x210 security/security.c:2777
       do_open fs/namei.c:4853 [inline]
       path_openat+0x5d0/0x23f0 fs/namei.c:5016
       do_file_open+0x20e/0x430 fs/namei.c:5045
       do_sys_openat2+0x163/0x1d0 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_open fs/open.c:1457 [inline]
       __se_sys_open fs/open.c:1453 [inline]
       __x64_sys_open+0xfe/0x1d0 fs/open.c:1453
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#5){.+.+}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       kiocb_start_write include/linux/fs.h:2799 [inline]
       vfs_iocb_iter_write+0x1fe/0xa50 fs/read_write.c:929
       __cachefiles_write+0x56f/0xd40 fs/cachefiles/io.c:355
       cachefiles_write+0xc2/0x150 fs/cachefiles/io.c:395
       cachefiles_issue_write+0x513/0x810 fs/cachefiles/io.c:607
       netfs_do_issue_write+0xee/0x340 fs/netfs/write_issue.c:256
       netfs_issue_write fs/netfs/write_issue.c:290 [inline]
       netfs_advance_write fs/netfs/write_issue.c:331 [inline]
       netfs_advance_write+0x37e/0x4c0 fs/netfs/write_issue.c:299
       netfs_write_folio fs/netfs/write_issue.c:510 [inline]
       netfs_writepages+0x10bb/0x2390 fs/netfs/write_issue.c:600
       do_writepages+0x278/0x600 mm/page-writeback.c:2562
       filemap_writeback+0x22d/0x2e0 mm/filemap.c:386
       v9fs_vfs_setattr+0x9d6/0xb80 fs/9p/vfs_inode.c:1087
       notify_change+0xb09/0x1350 fs/attr.c:556
       do_truncate+0x1df/0x240 fs/open.c:68
       handle_truncate fs/namei.c:4306 [inline]
       do_open fs/namei.c:4855 [inline]
       path_openat+0x1e93/0x23f0 fs/namei.c:5016
       do_file_open+0x20e/0x430 fs/namei.c:5045
       do_sys_openat2+0x163/0x1d0 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_open fs/open.c:1457 [inline]
       __se_sys_open fs/open.c:1453 [inline]
       __x64_sys_open+0xfe/0x1d0 fs/open.c:1453
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#5 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#30

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#30);
                               lock(&ima_iint_mutex_key[depth]);
                               lock(&sb->s_type->i_mutex_key#30);
  rlock(sb_writers#5);

 *** DEADLOCK ***

locks held by syz.7.1192/10055: 2, on CPU#0:
 #0: ffff88802ed0c478 (sb_writers#15){.+.+}-{0:0}, at: do_open fs/namei.c:4838 [inline]
 #0: ffff88802ed0c478 (sb_writers#15){.+.+}-{0:0}, at: path_openat+0x1920/0x23f0 fs/namei.c:5016
 #1: ffff88810b968140 (&sb->s_type->i_mutex_key#30){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
 #1: ffff88810b968140 (&sb->s_type->i_mutex_key#30){++++}-{4:4}, at: do_truncate+0x14e/0x240 fs/open.c:63

stack backtrace:
CPU: 0 UID: 0 PID: 10055 Comm: syz.7.1192 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write include/linux/fs/super.h:125 [inline]
 kiocb_start_write include/linux/fs.h:2799 [inline]
 vfs_iocb_iter_write+0x1fe/0xa50 fs/read_write.c:929
 __cachefiles_write+0x56f/0xd40 fs/cachefiles/io.c:355
 cachefiles_write+0xc2/0x150 fs/cachefiles/io.c:395
 cachefiles_issue_write+0x513/0x810 fs/cachefiles/io.c:607
 netfs_do_issue_write+0xee/0x340 fs/netfs/write_issue.c:256
 netfs_issue_write fs/netfs/write_issue.c:290 [inline]
 netfs_advance_write fs/netfs/write_issue.c:331 [inline]
 netfs_advance_write+0x37e/0x4c0 fs/netfs/write_issue.c:299
 netfs_write_folio fs/netfs/write_issue.c:510 [inline]
 netfs_writepages+0x10bb/0x2390 fs/netfs/write_issue.c:600
 do_writepages+0x278/0x600 mm/page-writeback.c:2562
 filemap_writeback+0x22d/0x2e0 mm/filemap.c:386
 v9fs_vfs_setattr+0x9d6/0xb80 fs/9p/vfs_inode.c:1087
 notify_change+0xb09/0x1350 fs/attr.c:556
 do_truncate+0x1df/0x240 fs/open.c:68
 handle_truncate fs/namei.c:4306 [inline]
 do_open fs/namei.c:4855 [inline]
 path_openat+0x1e93/0x23f0 fs/namei.c:5016
 do_file_open+0x20e/0x430 fs/namei.c:5045
 do_sys_openat2+0x163/0x1d0 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_open fs/open.c:1457 [inline]
 __se_sys_open fs/open.c:1453 [inline]
 __x64_sys_open+0xfe/0x1d0 fs/open.c:1453
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4b4eba94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4b4f9a7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f4b4ee25fa0 RCX: 00007f4b4eba94d9
RDX: 000000000000015b RSI: 00000000001e3342 RDI: 00002000000009c0
RBP: 00007f4b4ec3804e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4b4ee26038 R14: 00007f4b4ee25fa0 R15: 00007ffd7b80c5f8
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
