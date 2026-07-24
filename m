Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED5378814
	for <v9fs@lists.linux.dev>; Fri, 24 Jul 2026 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870794; cv=none; b=j8xCBVmZ0Vy9aJL1aqALzfkoT2eA9TG2+q/5lrq54oq18AlDFSgEvPUOXwaoKdGML/J/apPz+AmEG2LJomVsof71LaclTBIy9X3lzX00vNKaW160rxj4HVA0JSKVVgGuu2isA7Y4AJRuppGZAEGnm0KHukqlG/xIm/mHjdU3TaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870794; c=relaxed/simple;
	bh=aF5rDTTyCrjXazZxKss3GLaAIfwD/vVgzxocUX41xQI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GRjlNu6Wb/S/smoULE8YoE0KWZI5w4xTSyuQpLuClvDGFwOAt/ifFHmKxy1e3n+AcSUe32BT6NUIBCn0WaB+KIjXiTgR/mhSL2vZqEfEVANwiwUN17zVuixwLuw6EaFHICjQggLRqQZwyBw/kT/WlH8HwDQhudpttJuT0mw6Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a41e3d6fe9so1689026b6e.2
        for <v9fs@lists.linux.dev>; Thu, 23 Jul 2026 22:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784870792; x=1785475592;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmUFzu43pABgV2pRLEWsoSw9dcXXBe1fYb+qPcLhuMQ=;
        b=cQlcT/23mU4QzEptuPipAy3voobjZIpWfpJYqjnOkO7L5AAguj9iv1Te10oVEH0Gdn
         EJGf4YJpEGXBUg0pCoDUEBRHIZ9PVFhDzAtvvElEEMB9qI3+LVwHHerhJqL4YlkuV6FQ
         je6AXjlY/DjlE/ROKPO9iRWF2AdhXMmEQ/+NE+qwa1ex0Efk3hXO20UG/NvOWQaQjdCT
         6JTLTBsuOI3xFZ13ZUjtrXWT3WQB1X3FpGmFQk4p3sjQH58mlIY0Dt8SWFyYO2xw0hQL
         3SwNp/42raukOooCKEGyjxBZxY0+vSjp6zjqY/gBysndpMST+TpOkoyMg6DnR6hTm8v4
         ddQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlZFNCtEASHNekceUwAXULkDY77hcrpRLoAVdPbaQW0v/vKKCoBEO2gTxyZW9aaYtWhMfA@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5aKY04eGYs6qw20RH0X91pquM7wC595RnrzWkiVvLrPAZMaC6
	ViRZXruaBUE+mi908sMBNa3563eNidjdalNMds1W+Z8Q2w0x8IWvG/g66S00EQpcQ8cjQJbkk42
	W3Cv7Lrh3axmsnwqK7MEPntR2Xlkn2W+B/p75HJZkW9Q1Twf91KMWo56DS1w=
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1909:b0:4a4:989:bb20 with SMTP id
 5614622812f47-4ab353f0b8amr4188739b6e.24.1784870792044; Thu, 23 Jul 2026
 22:26:32 -0700 (PDT)
Date: Thu, 23 Jul 2026 22:26:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a62f788.dde6c935.cf6c8.000e.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in v9fs_init_request (2)
From: syzbot <syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1590cf032971 Linux 7.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1446a746580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=344c09c64fcd8d3d2782
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1632bc32580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e0b789580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-1590cf03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ad7477f3064/vmlinux-1590cf03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e7a9174d4d6/bzImage-1590cf03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+344c09c64fcd8d3d2782@syzkaller.appspotmail.com

------------[ cut here ]------------
folio expected an open fid inode->i_ino=4580113
WARNING: fs/9p/vfs_addr.c:168 at v9fs_init_request+0x451/0x540 fs/9p/vfs_addr.c:168, CPU#2: syz.0.21/5945
Modules linked in:
CPU: 2 UID: 0 PID: 5945 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:v9fs_init_request+0x455/0x540 fs/9p/vfs_addr.c:168
Code: 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 db 00 00 00 48 8d 3d bf b1 20 0d 48 8b 73 40 <67> 48 0f b9 3a bb ea ff ff ff e9 41 fe ff ff e8 f7 98 ff fd be 02
RSP: 0018:ffffc90003c5f778 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888056c2d240 RCX: ffffffff840a4337
RDX: 1ffff1100ad85a50 RSI: 0000000004580113 RDI: ffffffff912af550
RBP: fffffffffffffffe R08: 0000000000000007 R09: fffffffffffff000
R10: fffffffffffffffe R11: 0000000000000000 R12: ffff888038e04178
R13: ffff888050c78e41 R14: ffff888050c78bd0 R15: ffff888056c2d240
FS:  00007ff5dd1fe6c0(0000) GS:ffff8880d5fe6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff5dd1bbff8 CR3: 000000003d81d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_alloc_request+0x71c/0xcb0 fs/netfs/objects.c:72
 netfs_read_folio+0x20c/0x13f0 fs/netfs/buffered_read.c:513
 filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2510
 do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4140
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 __page_get_link.isra.0+0x30/0x350 fs/namei.c:6336
 page_get_link+0x44/0xf0 fs/namei.c:6366
 v9fs_vfs_get_link_dotl+0x27b/0x310 fs/9p/vfs_inode_dotl.c:930
 pick_link+0xd17/0x13c0 fs/namei.c:2068
 step_into_slowpath+0x9ba/0xf90 fs/namei.c:2127
 step_into fs/namei.c:2152 [inline]
 walk_component fs/namei.c:2288 [inline]
 lookup_last fs/namei.c:2789 [inline]
 path_lookupat+0x58b/0xc40 fs/namei.c:2813
 filename_lookup+0x202/0x590 fs/namei.c:2842
 user_path_at+0x3c/0x60 fs/namei.c:3641
 do_mount fs/namespace.c:4171 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount fs/namespace.c:4367 [inline]
 __x64_sys_mount+0x1fb/0x310 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5ddb9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff5dd1fe028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ff5dde25fa0 RCX: 00007ff5ddb9de99
RDX: 00002000000004c0 RSI: 0000200000000480 RDI: 0000000000000000
RBP: 00007ff5ddc33eaf R08: 0000200000000c00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff5dde26038 R14: 00007ff5dde25fa0 R15: 00007ffc18202cd8
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   7:	fc ff df
   a:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
   e:	48 89 fa             	mov    %rdi,%rdx
  11:	48 c1 ea 03          	shr    $0x3,%rdx
  15:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  19:	0f 85 db 00 00 00    	jne    0xfa
  1f:	48 8d 3d bf b1 20 0d 	lea    0xd20b1bf(%rip),%rdi        # 0xd20b1e5
  26:	48 8b 73 40          	mov    0x40(%rbx),%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
  34:	e9 41 fe ff ff       	jmp    0xfffffe7a
  39:	e8 f7 98 ff fd       	call   0xfdff9935
  3e:	be                   	.byte 0xbe
  3f:	02                   	.byte 0x2


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
