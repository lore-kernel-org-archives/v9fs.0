Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4784206D
	for <v9fs@lists.linux.dev>; Sat, 31 Aug 2024 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725130462; cv=none; b=VaMvleMao+tKYx1a4VzLju6aokEWnQDv5j94eB48n+nBr6M0u2N7L5/o1ND8qrf5ncL9rgi71jrIe+FIZ3zk8b/Fvq+Fd9Poc0OWHd8SPDI/HaNzpyKsT87EfTIr4E6cFkPRYy4wZRrMXj0O6wqnC0EDnOHNbT2rczaRUa68W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725130462; c=relaxed/simple;
	bh=Qdl0oIRce2Gtbf9OZesLMZfTekQhJhFACaBtP6+TswI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ie1MkJCiVIvL/FnLoab3i2y45130oPsWA69jgXcI0JGkEH+Vm68iI2pIaOXrceU3sEipjcJLNqB+dDLIhB6kpeMAVbBo/ZmJ8wFnP0TG6RTSGTBcOp1vGBiOuShc9iKXWISM3bccxUvQXFL8QEEwjMndZV90vx91KmnXmeHKyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dee9722so37324885ab.0
        for <v9fs@lists.linux.dev>; Sat, 31 Aug 2024 11:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725130460; x=1725735260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqN1lQszzxOP74sD9OtrYjx9lvH8sgwYB56fgBMgbJs=;
        b=DpP3HMCR7awIruyayOxv2CjvH8OeMpbqnTrKyqoLqNu2fO/ZD3LPv0CcxCo2RUJFrj
         2ysIN4OJ0/Lqjn7DQIPqOm9g23EUS0jfCysOyYORsDayhBKIuURKP3zSBRtn8wssBgQ9
         RGnFfZjVxEz6iFO58Bc8nm3kbAByEYDmfSuU8MPWQbaZrSyOj1SCozlTCf86VB/I5LOP
         drfYWIFpFcCt/+Ji9MlMNH0h8HZH3CYIXDygFd8INdSDJygNRe8+eyK9UWLBC8pxSNZa
         3/z0ECweNJ9uwkOsWC92YUfysc9xbbr4czIcif/Cl6kUexNJV9mWrDay/R4rp8MHGO49
         Brzw==
X-Forwarded-Encrypted: i=1; AJvYcCXWtN7GhpieKnJe0AicYHHZCM2Ktxlo+7cH5LCqZGNKHQz/ITZJIdXE4E0yN26WZRAVi99G@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7l4O4zhPcf7V9dMWmujUh0UqbacApBrAM5r91nhLgwvWlgN44
	oQjfkUTN6eZTCaAT/cPncy0MoWlJPJ1q7vAbLyBEHnJrxBwUhgfDfp35ZVkeHs+xPkRXoS4xW0E
	G/qUtcX6NzbYOwbeROoRtVpQJzFmBVTF5SYaM9Z9EKfEMEvBCaTF8aGA=
X-Google-Smtp-Source: AGHT+IE4Omf+gKQHzkvaWlcTGdTwJ2vO0gAuSs5EosQ1cGQCHxAxTYSJaDCuiWOf0KoUj/E+0/MbvjcwmH+32+lXXDrSOqLXMaK6
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e7:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39f410b5da6mr4186585ab.5.1725130459981; Sat, 31 Aug 2024
 11:54:19 -0700 (PDT)
Date: Sat, 31 Aug 2024 11:54:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004235960620ff3c77@google.com>
Subject: [syzbot] [v9fs?] WARNING in p9_client_create
From: syzbot <syzbot+3c38ca819d922062d22a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6f923748057a Add linux-next specific files for 20240827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=117f47a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c4a779aad2633f
dashboard link: https://syzkaller.appspot.com/bug?extid=3c38ca819d922062d22a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4398d0ec73ed/disk-6f923748.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f7e004ef90a/vmlinux-6f923748.xz
kernel image: https://storage.googleapis.com/syzbot-assets/333e975a3aac/bzImage-6f923748.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c38ca819d922062d22a@syzkaller.appspotmail.com

------------[ cut here ]------------
kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 0 PID: 5316 at mm/slab_common.c:108 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 0 PID: 5316 at mm/slab_common.c:108 kmem_cache_create_usercopy+0xb6/0x370 mm/slab_common.c:311
Modules linked in:
CPU: 0 UID: 0 PID: 5316 Comm: syz.1.7 Not tainted 6.11.0-rc5-next-20240827-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:kmem_cache_create_usercopy+0xb6/0x370 mm/slab_common.c:311
Code: 48 8b 6d 00 48 39 dd 74 25 48 8b 7d f8 4c 89 f6 e8 ff 16 dd 09 85 c0 75 e7 90 48 c7 c7 38 0a 0a 8e 4c 89 f6 e8 9b c1 79 ff 90 <0f> 0b 90 90 4c 89 f7 be 20 00 00 00 e8 59 18 dd 09 48 85 c0 0f 85
RSP: 0018:ffffc900040d77a8 EFLAGS: 00010246
RAX: 2c465ce8c6b42a00 RBX: ffffffff8ea1ba80 RCX: 0000000000040000
RDX: ffffc90004ba2000 RSI: 0000000000005a3c RDI: 0000000000005a3d
RBP: ffff88802203e068 R08: ffffffff8155a5b2 R09: 1ffff9200081ae90
R10: dffffc0000000000 R11: fffff5200081ae91 R12: 0000000000020018
R13: 0000000000000000 R14: ffffffff8d2d3620 R15: 000000000000000b
FS:  00007f80561806c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000002b984000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 p9_client_create+0xb0b/0x1040 net/9p/client.c:1042
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
RIP: 0033:0x7f8055379e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8056180038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8055515f80 RCX: 00007f8055379e79
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00007f80553e793e R08: 0000000020000440 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8055515f80 R15: 00007ffc6f15d8c8
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
