Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC9211711
	for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147894; cv=none; b=R2kfCl/S8qx7Y2vq532duSKiCvFDbVfiiOCIPqIs/tBxn3qzuPhEn+vzqltaBdVIV4u4LvKi1wFZbgHVlpgeKB3W8C8WARbwc5xLe62EL813N7ZINe6M6IhE7hO+Z+pt1WR07weyJ66bP7nS4yRDznliLVqP8FebUlTsH2nZMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147894; c=relaxed/simple;
	bh=LLh1T9NCrSyBBb9YCM0UyUGK1vNCwixsxbrE7G4i7BM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C0nTTrebH3yfn3diSy4KzpLwZiOMHr2xcS9srbVF+ml0bH5pRh37VTHCCxPCxRGyjiC8lzTsdGkODb9jHSM4DI+caDJ7uSsXoZCnQPCtGdkhpfuuoENpV1L6+2zuvWowj/hlPrAiM3js9UsifldJoXzhG71cgl6dK7a3CL1fa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8754cf2d6e2so525575239f.3
        for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 01:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147891; x=1750752691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGIF4L/u6ab23S78GFpA99wi1ae62gL4pOEWHGKGUG0=;
        b=iMmFZrUqp7CFkm9VVudVOrSmzHq78YvOcP9z1/FdwkXKH3sHvI5WlLEbR70VDWD7AD
         jbQZUbVk6ye5AuUAUQOsFQiw3eGnRWIre20LB66EnNr2+yWNuQRN0zW5DE+WzYnFccXy
         c7cp+Aj3gEMTVyCb2NycVYOZgRaj+jgImkCmAdUag/OPBGrR3Zl8gbTVyTKiHAdnGTUR
         boPD5ZZ+XXTBog0NtXI7q8YykKyipTwdJvooGpNfPQHQ0bmRrZcJXmGpY2FoLCbxB+ti
         3XBQizHonVAYWjFraM/RqMHoDo1hOV5jGTUJS49LRL6j95o3Z49yptnSIEUSbrWonSLZ
         +K7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXpntznaehz0YNbW5HUvwJKxaI9oP9Lxeyrt3UlW93yj0sz/Wk+NlaPJWd2t8NRYBrqS98@lists.linux.dev
X-Gm-Message-State: AOJu0YwqH/V9T3VnHNHzeN8l/lj+U8fdFp3F3UV34WyUS5vcx87veouW
	Qtqz8icDRW4HGfZzoijvQhzJtnKOYvNnNNJFGamZNVcgPmb+RFc8UoBdQgK+5uH7pjMilOs+6s1
	4JXl54v77kr+tA0OKT1kbDTKoLss745ZLRckcSUY8GqPwZrqP8YivX5hubdg=
X-Google-Smtp-Source: AGHT+IEdfDmdUHQIErVm6JKr9GB/nDGLvVxg6E6Nw3Gf96h/xUOvYLpAOEZBUELykawYgmliN9xX4zNskxICz9uph63xoY3bOKDT
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:3dd:b655:2d6a with SMTP id
 e9e14a558f8ab-3de07cff8camr132537355ab.7.1750147891698; Tue, 17 Jun 2025
 01:11:31 -0700 (PDT)
Date: Tue, 17 Jun 2025 01:11:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68512333.a70a0220.395abc.0207.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING: mm/page_alloc.c:LINE at __alloc_frozen_pages_noprof,
 CPU: syz.NUM.NUM/NUM
From: syzbot <syzbot+c44c80c9d28ec68d1c06@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17949e82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2efc7740224b93a
dashboard link: https://syzkaller.appspot.com/bug?extid=c44c80c9d28ec68d1c06
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fd95d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/disk-050f8ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinux-050f8ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/bzImage-050f8ad7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c44c80c9d28ec68d1c06@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/page_alloc.c:4935 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:4935, CPU#1: syz.0.16/6030
Modules linked in:
CPU: 1 UID: 0 PID: 6030 Comm: syz.0.16 Not tainted 6.16.0-rc2-next-20250616-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:4935
Code: 74 10 4c 89 e7 89 54 24 0c e8 d4 12 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 f3 c0 73 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc90003cdf9c0 EFLAGS: 00010246
RAX: ffffc90003cdfa00 RBX: 000000000000002a RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003cdfa28
RBP: ffffc90003cdfaa8 R08: ffffc90003cdfa27 R09: 0000000000000000
R10: ffffc90003cdfa00 R11: fffff5200079bf45 R12: 0000000000000000
R13: 1ffff9200079bf3c R14: 0000000000040d40 R15: dffffc0000000000
FS:  000055557e5fb500(0000) GS:ffff888125d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff1db25138 CR3: 00000000762fa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_noprof+0xa/0x30 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x85/0x210 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_noprof+0x36f/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 v9fs_fid_get_acl+0x4f/0x100 fs/9p/acl.c:32
 __v9fs_get_acl fs/9p/acl.c:66 [inline]
 v9fs_get_acl+0x9a/0x360 fs/9p/acl.c:92
 v9fs_qid_iget_dotl fs/9p/vfs_inode_dotl.c:131 [inline]
 v9fs_inode_from_fid_dotl+0x221/0x2b0 fs/9p/vfs_inode_dotl.c:154
 v9fs_get_new_inode_from_fid fs/9p/v9fs.h:251 [inline]
 v9fs_mount+0x6eb/0xa50 fs/9p/vfs_super.c:144
 legacy_get_tree+0xfa/0x1a0 fs/fs_context.c:666
 vfs_get_tree+0x92/0x2b0 fs/super.c:1802
 do_new_mount+0x24a/0xa40 fs/namespace.c:3885
 do_mount fs/namespace.c:4222 [inline]
 __do_sys_mount fs/namespace.c:4433 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4410
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f87d618e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe32d1a898 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f87d63b5fa0 RCX: 00007f87d618e929
RDX: 0000200000000b80 RSI: 00002000000003c0 RDI: 0000000000000000
RBP: 00007f87d6210b39 R08: 0000200000000580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f87d63b5fa0 R14: 00007f87d63b5fa0 R15: 0000000000000005
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
