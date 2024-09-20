Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9314375C
	for <v9fs@lists.linux.dev>; Fri, 20 Sep 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838431; cv=none; b=NwmvoKpZv0JGuIcZ3maG95PzF8ZPeoXmuCwgKSZWZlsINR5eZTh9mBhHpuPBD4GV8L+BWcuHbLUR+da1xeS2jzPUg7qlHP/W3PfKREBkjY7jVAgU21rlLlBpj5nH9kK4tBy5UiiQbEYZdSAB0oLx14BidIgNP05HJjr01PY4Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838431; c=relaxed/simple;
	bh=SQnhVeao6LussQck6/GnYJDb5UNqut3j4CrKhIAjdy8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dpapwe0feJ/xO1EAPn7QPxUXTvlPkxfmzTsGQeNaP+l5ZBGiT0pm38aOOSJ7VqfSR+4DPVDb31u+WkT9swxBKmQ+XRyakS0ID3NpNVjjgk4uR4PXQsTmZfXm4rPPoJrsi13j6tFmaiUat993ct6NnrrymXlPxc4Cp8yOxds4DZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so7249785ab.3
        for <v9fs@lists.linux.dev>; Fri, 20 Sep 2024 06:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726838429; x=1727443229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=On7O81qOkJhRt96d8bfkYQIh6Mj6uglGVSxoGbzSX2I=;
        b=uyKECA5xNVFE0eAQqhGOuQRuUYEaymRsjBWA5Wb9Y2ejT9HMacUG9mtnQgiK65k2PB
         QNk2qQQGWQ3qDWnFhli5gcCCrGboyclIf84wehQ1XX+2L8SCPko2kXZECu6F8Qae3v3T
         jB22Zx02YUQhWaUxchaFfx1nr7CFqLaIiq349Vd8mX1VyGONMKE6o7696nk6uNHtnBY5
         SaGL9Z8QYgoNpm5h5oOo1gHEPWh3eu7lVoDfWEdN+iysHpJuTK2qE/jReNfP/zl2i9XD
         zrEz9UxxsEbDdeYHQxy0ZxmTxFWsd+3FUdJ3ZaSAZFoTMtNWPmFjQbCkPbIzjeqeART+
         XvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTKm1sV+ODvGU2Jh7aBnLjYQP/Iodgnv53w8ZAqmSeXTYu0/IuGf3QYn8VTu6D318X0HSa@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6OrNUE8ABLg4HKle0HHorwHLiLP9IaJrapwRyZk9BLXtFEjj2
	gh8vtlCl6Cp9vVOBoqLdlVVOf0FOQtBdpmESFxwIm0ebEnYefz+6w/mRYKblgRjybiNNRPK4+Tq
	UyDFzf93WagwM2HbOyioG0xgv232Y5Ai+3p9dwEUaaKQWPF2sLYWHcsY=
X-Google-Smtp-Source: AGHT+IFZm+VhYecoq9LksEntgGiEW5L169DgHNE7WEORNxASfQLlC4Hsb8oqNcNYcDLOHAL7P6zpsusWBT/POIZRGZiqKcjJhuEm
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3a0:8d8a:47c with SMTP id
 e9e14a558f8ab-3a0c8cd7f8amr31801915ab.14.1726838428888; Fri, 20 Sep 2024
 06:20:28 -0700 (PDT)
Date: Fri, 20 Sep 2024 06:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed769c.050a0220.29194.0056.GAE@google.com>
Subject: [syzbot] [v9fs?] kernel BUG in __iov_iter_get_pages_alloc
From: syzbot <syzbot+2fcb246021c963371c20@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d5469f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=2fcb246021c963371c20
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16089207980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f3b500580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9929bfe422c/vmlinux-a940d9a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6c74ee261ed/bzImage-a940d9a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fcb246021c963371c20@syzkaller.appspotmail.com

 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1460!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 5341 Comm: syz-executor307 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:folio_get include/linux/mm.h:1460 [inline]
RIP: 0010:get_page include/linux/mm.h:1466 [inline]
RIP: 0010:iter_folioq_get_pages lib/iov_iter.c:1030 [inline]
RIP: 0010:__iov_iter_get_pages_alloc+0x1d1e/0x2240 lib/iov_iter.c:1201
Code: b0 8b 48 89 df e8 c2 b0 48 fd 90 0f 0b 49 89 c5 e9 99 f6 ff ff e8 82 2f 04 fd 48 c7 c6 00 ba b0 8b 4c 89 e7 e8 a3 b0 48 fd 90 <0f> 0b e8 6b 2f 04 fd 4c 8b 64 24 48 49 83 ec 01 e9 94 fd ff ff 4c
RSP: 0018:ffffc9000574ece8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff888023220000 RSI: ffffffff848814ed RDI: ffff888023220444
RBP: ffffea0000ceec34 R08: 0000000000000001 R09: fffffbfff2d3a8fd
R10: ffffffff969d47ef R11: ffff88806a928a40 R12: ffffea0000ceec00
R13: ffff8880296f6400 R14: 0000000000001000 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd26c837308 CR3: 000000000db7c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iov_iter_get_pages_alloc2+0x53/0xf0 lib/iov_iter.c:1225
 p9_get_mapped_pages.part.0.constprop.0+0x4ca/0x7d0 net/9p/trans_virtio.c:333
 p9_get_mapped_pages net/9p/trans_virtio.c:318 [inline]
 p9_virtio_zc_request+0x1be/0x1390 net/9p/trans_virtio.c:439
 p9_client_zc_rpc.constprop.0+0x29a/0x880 net/9p/client.c:808
 p9_client_write+0x447/0x680 net/9p/client.c:1631
 v9fs_issue_write+0xe2/0x180 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x92/0x110 fs/netfs/write_issue.c:223
 netfs_issue_write fs/netfs/write_issue.c:250 [inline]
 netfs_advance_write fs/netfs/write_issue.c:291 [inline]
 netfs_advance_write+0x384/0xbd0 fs/netfs/write_issue.c:259
 netfs_write_folio+0xc44/0x18f0 fs/netfs/write_issue.c:469
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fd26c7b4516
Code: Unable to access opcode bytes at 0x7fd26c7b44ec.
RSP: 002b:00007fd26c745200 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007fd26c837338 RCX: 00007fd26c7b4589
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000249f0
RBP: 00007fd26c837330 R08: 0000000000000000 R09: 00007fd26c7456c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd26c804324
R13: 00007fd26c83733c R14: 0030656c69662f2e R15: 00007ffe2af0b088
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_get include/linux/mm.h:1460 [inline]
RIP: 0010:get_page include/linux/mm.h:1466 [inline]
RIP: 0010:iter_folioq_get_pages lib/iov_iter.c:1030 [inline]
RIP: 0010:__iov_iter_get_pages_alloc+0x1d1e/0x2240 lib/iov_iter.c:1201
Code: b0 8b 48 89 df e8 c2 b0 48 fd 90 0f 0b 49 89 c5 e9 99 f6 ff ff e8 82 2f 04 fd 48 c7 c6 00 ba b0 8b 4c 89 e7 e8 a3 b0 48 fd 90 <0f> 0b e8 6b 2f 04 fd 4c 8b 64 24 48 49 83 ec 01 e9 94 fd ff ff 4c
RSP: 0018:ffffc9000574ece8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff888023220000 RSI: ffffffff848814ed RDI: ffff888023220444
RBP: ffffea0000ceec34 R08: 0000000000000001 R09: fffffbfff2d3a8fd
R10: ffffffff969d47ef R11: ffff88806a928a40 R12: ffffea0000ceec00
R13: ffff8880296f6400 R14: 0000000000001000 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd26c837308 CR3: 0000000025612000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
