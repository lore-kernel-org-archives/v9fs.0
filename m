Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A72D3ED7
	for <v9fs@lists.linux.dev>; Thu, 21 Aug 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745114; cv=none; b=doTb8VcmZNrk3QVQYTroMkB5IbeuKbIyNFCqMW0k59r6N4GOZlZVOEifyWnx7QEeS84ZpIkVdR3+66bNN0/4gQE/8hXvPIl1XZGHoRiJjyAy1XCLGDFnhTsF/vtGO+PU+D34ypPS523Z1Bvk4J/wBUeIGyBBWjPSC0cY4YNiH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745114; c=relaxed/simple;
	bh=Ckzyyo8fMNJ1pKXd2LuWDzsluunYZETjwc3xFjhjF8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e/Kta7RhiQN3X4+tQBPZWH8tLIt+MD01fkCegSiWBW4VHjOk3ZTrS+/DxQHQq75Z2tju967o/F9DRf/gpmt95ExPnbB0nAjZigLTGANgn9OXPyiBCOV25cL1IUxGRGwNZNxX+8yOXn5G8IqdT8DYkvFajHGdazrteOogfgQRREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e7172dea48so6053195ab.1
        for <v9fs@lists.linux.dev>; Wed, 20 Aug 2025 19:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745111; x=1756349911;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HahCLua8zUrTqOzXr4U9vE+qOFX9I1AwrpiJRZveyPs=;
        b=cu9KJ3DvlmzrRjlrHHHrcoBWZPY7L4w3jXEuf5ySyGviI7TlmszDCKqZYL6ClEzam/
         n/PYgkpOr41kYKLKqOv38OjxSnYAN84ms3/1t30V3v6xMD4KWwPr25rDH25FpD8xJ6Pz
         /kALUqQNsoDX7N3yOBzUfWQoN2OQ6UiyKzRJyyblj9N0UvEUGX8T2wiR6AKM1mxwHtVK
         GqlRScZlH6PkV9YTiF5koLYtuuZXReWOqAmpXb3KjXkSMTEyczW2TIiUOjxRGwq+LGxJ
         HXG6D0I1t1ESFEcEizB+Vg/cZmIUuUfSGJZdG6KKae5di1wgw95YgEkm1CXWHsiI0Kxu
         lpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWaOf+uiCJVnp6YW/inlJJgIsJMWWifhzKu2m179L8y8yqUvputcm88CRwrQWwJpOELESF1@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcqd64/Ok5CXaqy4pIg1q4I2hnAnXtKZ1KwPeWhRhqjiBm6oY4
	WkAjeLZg7NHlStKs/t3lnkDONj4DshEO1+mffZjbd589sTN3jVL+QP8hhdpajin1ds0zTwCWgMu
	LTUmWot2qW7RnYyaNkX5dsaojWEGbUFyh/VFui58rzLQ/CMXLerq3q5ynhII=
X-Google-Smtp-Source: AGHT+IHslzf/hk+X+HthHyVz9yOLGrLH/CQVRtSQ53f0E0gtvbiEL1S8Fb7DRaqQ5HM3GthZ4IEjMx0f1lrJamHWW/gdSlWybJ+o
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3e5:5937:e555 with SMTP id
 e9e14a558f8ab-3e6d4060f71mr17648015ab.6.1755745111642; Wed, 20 Aug 2025
 19:58:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:58:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Subject: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ac864c2d9bb Add linux-next specific files for 20250818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13706442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1acc6b9e1fca1b
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141586f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c9ba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37dbe82593f0/disk-3ac864c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2fea0824445/vmlinux-3ac864c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f2a83735a01/bzImage-3ac864c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
shift exponent 32 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5861 Comm: syz-executor379 Not tainted 6.17.0-rc2-next-20250818-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
 v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff35edd46a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeee8a4078 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00002000000025c0 RCX: 00007ff35edd46a9
RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
RBP: 0000200000000280 R08: 0000200000000280 R09: 00007ffeee8a4258
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35ee1d017
R13: 00007ffeee8a4248 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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
