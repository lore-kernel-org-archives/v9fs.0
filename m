Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F114B972
	for <v9fs@lists.linux.dev>; Tue,  1 Oct 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817027; cv=none; b=mG/ujzJZuA6XTD9KUppdbtVPAg8RVQZSO7dSnSpjZj6/gbWmspfHg28fDbfszGV4fojMbalDfy4usqyn6L9L64UjFwnGIZHb8FRME9w7hjmmuVPGzLSy6AezNkkyUO62akrcSQ+OSjJu0MABsY2axu6iSuDGXdRur1rK743nVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817027; c=relaxed/simple;
	bh=UpBEPo04+d2HrbW9QvxVfNJJbfjw76eQqAvmLhvfRTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k1FijPv6F6Qm/Ru+qdObFSlWYY2DYQ8Z1J3T2ETZqUFAEKrvkHrpDxIOjD1h5lZ4+JfqrQo3ArcDIFmnT6Q+nu2rN/FHXgTSrOPt7kD7SLcYT+ZXcw2fzUV1i2ldgxGor9cRv8873tTP2vqsuelLwaZQHqqNEtuCROPn7wZaPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cdb749559so1082842239f.2
        for <v9fs@lists.linux.dev>; Tue, 01 Oct 2024 14:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817024; x=1728421824;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tfyFcihlETFm+A5IfYHL8hOTS2f/ye7cbla1LxQlUE=;
        b=deLt4pcW/Jxn8o555YivxZzNHe17Za247MOtjaJS/IZhiiktBL2DNOuBLcrYnnRBvn
         wOj8n6BEuZhKSpHIxcihlyYWG7/wT+SrVR6pwVMhI+IwwBErqzs7aSr5lr91vM+PCmqH
         zNGjLO8hqsnvAzPM9mzkAVUPFMCCRqA3BvBuBn5pfKA2odxDSYiGSeOr8qjrUEXSBaeW
         qmkX5Mq4RwljC70jllL1uIU1jkgF9M3Wjuf7zHFAQQfzUvxDt/bJgUK/oSENI0Pq/ica
         HMPwwAIHsiwwF222g9taNnbCAqVtQ5WenfGGlNaTiTbto9/a/SG1329UV0q0ukFe1Jid
         chwg==
X-Forwarded-Encrypted: i=1; AJvYcCUCbvbKm7pGu65OhyKUTVXA1CA7bQlSe+bdTlIcnw9in0qo6fzjjTXyPPZbA0ONrR2zzuEU@lists.linux.dev
X-Gm-Message-State: AOJu0YwwTyYBTbXpkrBbWDQ3jml2FFrOXAUrYsSaO/WpnL1Bs/v3tqOM
	Jz4mjqOnP+k224x3Cf3B9bsRrog8Rc4ZZajinMiUmV92VsD3a7DAZHxfdbyii6dJtEvd3lvKG5i
	XArXpdtVT5+BurRsSpuTK/s1NzYjbX6YIOthqHDOGjAOzh1fJIn/7Nvk=
X-Google-Smtp-Source: AGHT+IFm+0J0m41FowfwABd+pWgbZj8AwcCdjzF9XJ0IfhchAuItRobPcem8ndtBUYdISaCedRt4X2wd073kda9IJXKumtqB8Shj
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a36591ae72mr10485125ab.7.1727817024716; Tue, 01 Oct 2024
 14:10:24 -0700 (PDT)
Date: Tue, 01 Oct 2024 14:10:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc6540.050a0220.f28ec.04d2.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in legacy_get_tree
From: syzbot <syzbot+03231aee4187c1602cba@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e477dba5442c Merge tag 'for-6.12/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f77a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35e823d88dbbbfe5
dashboard link: https://syzkaller.appspot.com/bug?extid=03231aee4187c1602cba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e477dba5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9ec64056ebb/vmlinux-e477dba5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87b5c9bcdaed/bzImage-e477dba5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03231aee4187c1602cba@syzkaller.appspotmail.com

kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 2 PID: 14626 at mm/slab_common.c:107 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 2 PID: 14626 at mm/slab_common.c:107 __kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Modules linked in:
CPU: 2 UID: 0 PID: 14626 Comm: syz.1.2250 Not tainted 6.11.0-syzkaller-11624-ge477dba5442c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d d0 b7 f1 8d 74 25 48 8b 7b 60 48 89 ee e8 b5 06 33 09 85 c0 75 e0 90 48 c7 c7 30 f7 57 8d 48 89 ee e8 b1 cc 7e ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 3f 08 33 09 48 85 c0 0f 85
RSP: 0018:ffffc90002b0f8f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888049cdb540 RCX: ffffc9002363b000
RDX: 0000000000040000 RSI: ffffffff814dc916 RDI: 0000000000000001
RBP: ffffffff8ca1d8e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000020018 R14: ffffc90002b0f9e0 R15: 0000000000020018
FS:  0000000000000000(0000) GS:ffff88802b600000(0063) knlGS:00000000f5716b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73dbc38 CR3: 0000000000282000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000047d
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3834
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf742e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f571656c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
CPU: 2 UID: 0 PID: 14626 Comm: syz.1.2250 Not tainted 6.11.0-syzkaller-11624-ge477dba5442c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 <TASK>
 check_panic_on_warn+0xab/0xb0 kernel/panic.c:243
 __warn+0xf6/0x3d0 kernel/panic.c:748
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x3c0/0x580 lib/bug.c:219
 handle_bug+0x54/0xa0 arch/x86/kernel/traps.c:285
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d d0 b7 f1 8d 74 25 48 8b 7b 60 48 89 ee e8 b5 06 33 09 85 c0 75 e0 90 48 c7 c7 30 f7 57 8d 48 89 ee e8 b1 cc 7e ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 3f 08 33 09 48 85 c0 0f 85
RSP: 0018:ffffc90002b0f8f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888049cdb540 RCX: ffffc9002363b000
RDX: 0000000000040000 RSI: ffffffff814dc916 RDI: 0000000000000001
RBP: ffffffff8ca1d8e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000020018 R14: ffffc90002b0f9e0 R15: 0000000000020018
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
RIP: 0023:0xf742e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f571656c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000200001c0 RCX: 0000000020000480
RDX: 00000000200004c0 RSI: 0000000000000000 RDI: 0000000000000000
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
