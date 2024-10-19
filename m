Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3621DEFD8
	for <v9fs@lists.linux.dev>; Sat, 19 Oct 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330715; cv=none; b=eITjocf9pAOJzxPCLlREdKYKGCYm6vz+BgxDUwFJ9jmDgs8hrNmnymByE7ZSiRGR1fOy/0nxrtdfEdAz2AwvoV7vhjTj0slU+xWRk5JLi0P+kyiXk/ygTiLpcF8KQwNDiWGAff9oh9QDXEgAvZsOPBeniNqOU8jtqvzjMlK3nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330715; c=relaxed/simple;
	bh=I20eAtM1sueVrolMX5f8jvCYaEOwWpWJHyx0Ra0pf+E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UoaKq4so9cJYZLE9XQQOexlT/ZVXC4LzgQerEuIj6CE8u8Gf0cXSBe+NRA6P+/fCTb4KwY/JBHO2U2QDLHEKIJJk/RKWyg8wgMcUP9M0z0r1uBRiPG3lVR/2pc3nwY67Rm0+raW44aBvaSbpXxR1qwt2fqvTWYO/qFivgcNxko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3cd35858aso26886775ab.1
        for <v9fs@lists.linux.dev>; Sat, 19 Oct 2024 02:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729330712; x=1729935512;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpGfap+bbwD6ZDUMdIGioCyFzGa4Wx1sgehvuo3v+IY=;
        b=n0FfkmsHy5tyM+zv4uoNvUY0pUAnqLt1DjZtBXxolWAFw4cy2qMGzn2tTS9F81HsT1
         n5C1tTk/RxqfhnDE5Lj0HDz5ZnQoNlsLg32e6YYpyv7j9l5lZZIZVduE/lwi4Pskq0kQ
         jU1oQQRmrCKUf4Gq5NvGxT12aXBLY1FTsijkUYE4RuhTNl2c3WARZ4gp4Jgrms844cCC
         C/O6bRfSMMClEZ+2L1BmXt0elSjaggsYTL/cjCWmf/m12xDM0O5rgJkX6nxoZ1PTMiF1
         PFasV8jQM5OyJGmypFy1pBy9TQ6CiehP3rF/IEOJwI7OfGxwX6M+JRU0va1X4txGcv4z
         /Fjg==
X-Forwarded-Encrypted: i=1; AJvYcCXzhX2ez4XyLYx5aSRkDEFwQnnqYaF8M0iT4MRMqfOxTWWM39AJobRYWjw/owIAsgV7ArlR@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3Yiw3/lajdaECywgPDMueiQfUMZ9gYSkujLAxU2rUD5JbWjd4
	WC5Wm2OA5AqkEMyyPIRkW28HGNjpW/+fPNOrlXZgW87ZMV2N0j1c5IT0zvNpSjA348YWPaapiDn
	qRyt/7E6ogPEShFSU5jZJQWlFXDQFSdSnwjuYhtx3tAsnF4dc4GAGrrI=
X-Google-Smtp-Source: AGHT+IFNx5RXfnLOOOF2nnUF7dWDk7fKnqYv2619GjRnBg76F+1t3sAyIgsYhpt/yXYpnysJBgoCRKnMKrtrCNhmN6x+Cc510uQR
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a3f404ff3amr49955855ab.2.1729330712142; Sat, 19 Oct 2024
 02:38:32 -0700 (PDT)
Date: Sat, 19 Oct 2024 02:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67137e18.050a0220.1e4b4d.0025.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in v9fs_session_init
From: syzbot <syzbot+6cecd33924c207032259@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b2c030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64667415a04ab9c4
dashboard link: https://syzkaller.appspot.com/bug?extid=6cecd33924c207032259
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eca631b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b977614f67ec/vmlinux-eca631b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72397bc76f94/bzImage-eca631b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cecd33924c207032259@syzkaller.appspotmail.com

------------[ cut here ]------------
kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 0 PID: 6253 at mm/slab_common.c:107 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 0 PID: 6253 at mm/slab_common.c:107 __kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Modules linked in:
CPU: 0 UID: 0 PID: 6253 Comm: syz.3.288 Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d 10 bb f1 8d 74 25 48 8b 7b 60 48 89 ee e8 b5 98 34 09 85 c0 75 e0 90 48 c7 c7 68 20 58 8d 48 89 ee e8 31 b1 7e ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 3f 9a 34 09 48 85 c0 0f 85
RSP: 0018:ffffc900033e78f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880481808c0 RCX: ffffc9002447c000
RDX: 0000000000040000 RSI: ffffffff814e38c6 RDI: 0000000000000001
RBP: ffffffff8ca1dfe0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000001000 R14: ffffc900033e79e0 R15: 0000000000020018
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5696b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020001740 CR3: 0000000063442000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __ia32_sys_mount+0x292/0x310 fs/namespace.c:4032
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f17579
CPU: 0 UID: 0 PID: 6253 Comm: syz.3.288 Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x3d/0x1f0 lib/dump_stack.c:120
 panic+0x71d/0x800 kernel/panic.c:354
 check_panic_on_warn+0xab/0xb0 kernel/panic.c:243
 __warn+0xf6/0x3d0 kernel/panic.c:748
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x3c0/0x580 lib/bug.c:219
 handle_bug+0x54/0xa0 arch/x86/kernel/traps.c:285
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d 10 bb f1 8d 74 25 48 8b 7b 60 48 89 ee e8 b5 98 34 09 85 c0 75 e0 90 48 c7 c7 68 20 58 8d 48 89 ee e8 31 b1 7e ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 3f 9a 34 09 48 85 c0 0f 85
RSP: 0018:ffffc900033e78f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880481808c0 RCX: ffffc9002447c000
RDX: 0000000000040000 RSI: ffffffff814e38c6 RDI: 0000000000000001
RBP: ffffffff8ca1dfe0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000001000 R14: ffffc900033e79e0 R15: 0000000000020018
 kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
 p9_client_create+0xe04/0x1150 net/9p/client.c:1042
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __ia32_sys_mount+0x292/0x310 fs/namespace.c:4032
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f17579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f569656c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000020000180
RDX: 0000000020000200 RSI: 0000000000000000 RDI: 0000000020000280
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
