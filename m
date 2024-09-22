Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128C13C9CD
	for <v9fs@lists.linux.dev>; Sun, 22 Sep 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727007024; cv=none; b=O5Y4UYtinBcTONf43egiljmh2B7OoN1im34RdCmjILI5CYsZES7Uiip0uG5uN91h7pBQjUD6AUVql9U2d5VLw5iR3fsi4jwyGYJCSMnT9O0r7MLCi7jpy2mOFDr+B1yYmTf4KFlQCuq9WENTGym5uidQoYE6kbuXhgMJ9+pFHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727007024; c=relaxed/simple;
	bh=wkTSsu2r9WPA2hyuI9gi6KM/Eyu9a/ZnSK+6gBIuI2k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AbKpWuBlUoTx9y3hYMRSSEVz+ZVX/S9DtLi/XjSTful7HWa9rYsfrbRoHSAV4hUsMtObn78qOwzYbA9kpvyAaSSEL9QwS0amE7xYqGOTHcSADkmv4E8A2ctFfnSBt6gRbNP0MlaKoJu+T1YFmuqWj20xs/tQqC96vQGLb5XbqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f510b3f81so41026055ab.0
        for <v9fs@lists.linux.dev>; Sun, 22 Sep 2024 05:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727007021; x=1727611821;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cANl+Bukp0SCc7uC+QBpR3AtFFwZd/WJUXbFl5ysWNA=;
        b=RlaO3+ktMG+ytndipFqIF1rxKc5HTTmQbIKJ/zGmYwg0jkKKR8qy7WyrY6NFtcVdyM
         In2ZfOrbx8J9MQ6WcIhcq1/z4O0dUZ9ZyrZe+rLzBnyxgtd+L07F620hBAEI0o98ISyG
         VT1HvXO46La1jstfeq4Q66nzKq8WrCB+r7m3i7EPvJPWUEzqAzOtWJrclZ4r6O/IU99C
         qNmXCa0N/eA5PJpvWkTI4xAlDvnqT34+xPqqnZnPMZp1u/zuQqtjTjN7yyqKPySTo4N8
         NnTDBzDoM4zb3IjjgcEPbtbihCnQzGYkfqHelOHMbSVedl8B73Cr48jl7NkH9QJ9vvpO
         GBdw==
X-Forwarded-Encrypted: i=1; AJvYcCX4v/Em1ePBxid9KmA4XwAt9X10yhSscPlmbu9Zs3kwPyXTlULA1OLZmlJbSuKZxGl5V2aq@lists.linux.dev
X-Gm-Message-State: AOJu0YwDPWKSWDrvx61Cw8dJVEgIH1KxFRtCKGGmKR2YjYditTy8Zzyp
	RjnsPg7NWOxEySxOv8y85QfjZYqa2BEau3Nx80mWrRPjgLVsU5tDNa/1vW1MWVhmWm7KF3w7lGy
	iT9iOTkjGMpzQ4sYaLABQmIWCCuVvMOuB08E0/sgdE4ZgYkFfQcc2zyA=
X-Google-Smtp-Source: AGHT+IGvo2StEdSWmniio6Vtdx5vqtbd6DbL60fPapY74Y44xpt2Yerk//i9yNEYuXb7rTDuQSd0OGaDhxaCR0fJSdIivJ11+2Ms
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a0c8997b3bmr56108365ab.6.1727007021599; Sun, 22 Sep 2024
 05:10:21 -0700 (PDT)
Date: Sun, 22 Sep 2024 05:10:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f0092d.050a0220.3195df.009b.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in p9_client_create (2)
From: syzbot <syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, cl@linux.com, ericvh@kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	pedro.falcato@gmail.com, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152d7fc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4540f5bcdd31e3de
dashboard link: https://syzkaller.appspot.com/bug?extid=3c5d43e97993e1fa612b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c98b00580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151424a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/disk-bdf56c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinux-bdf56c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/bzImage-bdf56c75.xz

The issue was bisected to:

commit 4c39529663b93165953ecf9b1a9ea817358dcd06
Author: Pedro Falcato <pedro.falcato@gmail.com>
Date:   Wed Aug 7 09:07:46 2024 +0000

    slab: Warn on duplicate cache names when DEBUG_VM=y

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111f269f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131f269f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=151f269f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com
Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")

------------[ cut here ]------------
kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 0 PID: 5221 at mm/slab_common.c:108 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 0 PID: 5221 at mm/slab_common.c:108 __kmem_cache_create_args+0xa7/0x350 mm/slab_common.c:294
Modules linked in:
CPU: 0 UID: 0 PID: 5221 Comm: syz-executor647 Not tainted 6.11.0-syzkaller-04744-gbdf56c7580d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xa7/0x350 mm/slab_common.c:294
Code: 8e 48 8b 1b 48 39 eb 74 25 48 8b 7b f8 4c 89 fe e8 ae 72 d5 09 85 c0 75 e8 90 48 c7 c7 03 a5 08 8e 4c 89 fe e8 5a 36 7d ff 90 <0f> 0b 90 90 4c 89 ff be 20 00 00 00 e8 08 74 d5 09 48 85 c0 0f 85
RSP: 0018:ffffc90003c07788 EFLAGS: 00010246
RAX: 158c5a6442ad7f00 RBX: ffff88814cccd428 RCX: ffff88802c34bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8ea168a0 R08: ffffffff8155af72 R09: 1ffff92000780e8c
R10: dffffc0000000000 R11: fffff52000780e8d R12: 0000000000020018
R13: 0000000000000000 R14: ffffc90003c07860 R15: ffffffff8d2c41c0
FS:  0000555573dac380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000075df4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
 p9_client_create+0xba5/0x1110 net/9p/client.c:1042
 v9fs_session_init+0x1e4/0x1b80 fs/9p/v9fs.c:410
 v9fs_mount+0xcf/0xaa0 fs/9p/vfs_super.c:122
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f29cf818069
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4a6d8418 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f29cf8610e8 RCX: 00007f29cf818069
RDX: 00000000200002c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000020000380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd4a6d8430
R13: 00007ffd4a6d8450 R14: 00007ffd4a6d8530 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
