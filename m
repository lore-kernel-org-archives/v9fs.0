Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794794912;
	b=lSo6RdA0i2chvo/DT70kgy3psMcEoHkPaDwtkTvdE7ux0KFJ0cO3jfokNgNuo0s1X0GG
	 eqN5GDoVf04Rs2EGEhRwe2sX4HRF4mWFlGK7+dEMJC9ycFTT7GWy1eFGXD6N7WmSkYAvd
	 4HCKyL+vMjKMjg+Dx8DcpSmmtGhoBsNRiLN39wDrYxs0JJzOx4WwzxKGHMW1vrReTPRbp
	 ePFQlzzBFcI8E8AW/EEC1oi5+MJD72dM8kP+qMOATWuPnoZl7v+1hFSa440+os74Xwnjq
	 AvRF4IlKmJPdFaOCwD3bEGP4VeP02ZiJuOZvYgkP4mkbDX1RlUpDpTQgT9pDukXTZiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794794912;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fJnAmOw+zWik9HFbxpQz60BOx4ny8/48ik5U8Sf98Xo=;
	b=Am4pIC2E1AKLtjujqQZghTCTpvykruYHIN3NgaFA7G/nv3huiMTK4UKRZwXl37rfvdRY
	 LeCiX8K4L34QC3SSt0ZOrk9yEP9W1nV9My2/gFshUIUq76COfoH3GEdtdTsCiKD+eIcjO
	 PVyI3PzRMQ9sGLHj468b0fnpWdW+k0IT6be7FA2BkqRxJdXQWuG4Xkf1VuyTecUcz5Dam
	 z1FmihwND2TvKBpRcrL4PyRnSYPXj65Rt2R+l1RuO69a0NztkerqqvIXlEyfewr+3441P
	 H/r2S9joYky5K3SYXnCJmynfCuMSQM2sO1QFWwLY/1iFse6ExO1PUU660xKIvv81/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF1606A31F
	for <v9fs@lists.linux.dev>; Mon, 16 Nov 2026 02:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54CF1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c467e19391so4642043b6e.3
        for <v9fs@lists.linux.dev>; Sun, 15 Nov 2026 18:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794794911; x=1795399711;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fJnAmOw+zWik9HFbxpQz60BOx4ny8/48ik5U8Sf98Xo=;
        b=yDvdnizxEgYg6lr9rR4+AbGffv2/bb8H35S3tWcH6VNiG241gqeFx/6/QpiB17HBzs
         8kn2qTppdRaX9y37hrtXUwDHtjWOdROpK0edL8OY/JKdLPJVVB2NNr3yK7gbySlfh6fC
         fQ+lN8nNOeiG6XP/YUDCTUhJgNZMJ9wJ2zyNShXEFiYtsX7efopnBTeohDxlFpnNW3gi
         OHbn1ONj76e4FyA0UevFc+2M3RmG3Oyy2oCecPQTokkuREYl4g/C2pnFC63oHfM/eJe/
         xhT2cnRw0svXlssM2jEW9lBs9YP0rSZVnyGwF58UH0IW1ZGuYrPUyVU6vJIslCJYqysS
         xSow==
X-Forwarded-Encrypted: i=1; AL+hErGlM0Ta9jRkg2CqADKSuqn7tIPXGwc7KAO3BuTy5gB91TwTEPcwr1+GrCOah+SMd89I6Bob@lists.linux.dev
X-Gm-Message-State: APuU4Z+aVmXEXggvQ9qpIITer8hz09gvY/Nz+DERTA6+XqIfydF6VnxL
	438rHakXR2gUXOFlUO3kPkeBSpzfkzfzArhfpmg0o8cyfDcS/xEDgsUr6WeZUbTf6z4FIIVPQN5
	B2dP4C8SkBlqF2jup0pp3tW6gZYjpGxW34W0I2qDK3hC906mKTvgBYaQ3tuA=
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:221a:b0:55c:7ce:cb77 with SMTP id
 5614622812f47-56e63ba2c90mr7811308b6e.36.1794794911284; Sun, 15 Nov 2026
 18:08:31 -0800 (PST)
Date: Sun, 15 Nov 2026 18:08:31 -0800
In-Reply-To: <6af8c1e1.aa201734.33d248.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afa659f.920b2b3a.148c65.005a.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] possible deadlock in __cachefiles_write
From: syzbot <syzbot+b8ae5f37f5baa84cb085@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fa2933aac170 Merge tag 'x86-urgent-2026-11-15' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1673d5a1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=b8ae5f37f5baa84cb085
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e2e44d580000

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
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor273/6102 is trying to acquire lock:
ffff88802c81e478 (sb_writers#5){.+.+}-{0:0}, at: __cachefiles_write+0x56f/0xd40 fs/cachefiles/io.c:355

but task is already holding lock:
ffff888052ca8d00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
ffff888052ca8d00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x14e/0x240 fs/open.c:63

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#25){++++}-{4:4}:
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
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1460
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
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1460
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
       v9fs_vfs_setattr_dotl+0x8fe/0xcf0 fs/9p/vfs_inode_dotl.c:585
       notify_change+0xb09/0x1350 fs/attr.c:556
       do_truncate+0x1df/0x240 fs/open.c:68
       handle_truncate fs/namei.c:4306 [inline]
       do_open fs/namei.c:4855 [inline]
       path_openat+0x1e93/0x23f0 fs/namei.c:5016
       do_file_open+0x20e/0x430 fs/namei.c:5045
       do_sys_openat2+0x163/0x1d0 fs/open.c:1443
       do_sys_open fs/open.c:1449 [inline]
       __do_sys_openat fs/open.c:1465 [inline]
       __se_sys_openat fs/open.c:1460 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1460
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#5 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#25

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#25);
                               lock(&ima_iint_mutex_key[depth]);
                               lock(&sb->s_type->i_mutex_key#25);
  rlock(sb_writers#5);

 *** DEADLOCK ***

locks held by syz-executor273/6102: 2, on CPU#3:
 #0: ffff88802ea90478 (sb_writers#14){.+.+}-{0:0}, at: do_open fs/namei.c:4838 [inline]
 #0: ffff88802ea90478 (sb_writers#14){.+.+}-{0:0}, at: path_openat+0x1920/0x23f0 fs/namei.c:5016
 #1: ffff888052ca8d00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:1032 [inline]
 #1: ffff888052ca8d00 (&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: do_truncate+0x14e/0x240 fs/open.c:63

stack backtrace:
CPU: 3 UID: 0 PID: 6102 Comm: syz-executor273 Not tainted syzkaller #0 PREEMPT(full) 
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
 v9fs_vfs_setattr_dotl+0x8fe/0xcf0 fs/9p/vfs_inode_dotl.c:585
 notify_change+0xb09/0x1350 fs/attr.c:556
 do_truncate+0x1df/0x240 fs/open.c:68
 handle_truncate fs/namei.c:4306 [inline]
 do_open fs/namei.c:4855 [inline]
 path_openat+0x1e93/0x23f0 fs/namei.c:5016
 do_file_open+0x20e/0x430 fs/namei.c:5045
 do_sys_openat2+0x163/0x1d0 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feefe53f45e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fff976f93e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000555558a8a400 RCX: 00007feefe53f45e
RDX: 0000000000000202 RSI: 00007feefe58e995 RDI: ffffffffffffff9c
RBP: 00007feefe58e995 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00007fff976fa3f0 R14: 00007feefe58e979 R15: 0000000000000003
 </TASK>
CacheFiles: File cache on CacheFiles unregistering
netfs: Withdrawing cache "CacheFiles" (1 objs)
