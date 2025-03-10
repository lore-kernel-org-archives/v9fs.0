Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F516225412
	for <v9fs@lists.linux.dev>; Mon, 10 Mar 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599561; cv=none; b=Qpnbqe6L3xDfsJlyl5yoWdYqdMXS3ja6DpBgQTjmk9PGNOYyT7Q6S2EGzqt/WlovW1xb/HNKMfqg0cGksZmvADkCITN6un1E8NkGlkK1sJS4Ild1wWk6kV5mW0Y36ufBaxmNvAhICV1nCRZRamJ4indWW59+1tYjoJzhuHHJ1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599561; c=relaxed/simple;
	bh=Kn+3VjX0l0w7IT102rLK2Fh8MIqfdH443fSXGI5aGZE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=okhT36ykonmHNHAZVbTgUzrAI5XJt17OFNNTC25sXDLK5Gd370hHJhKHi/NHTmgSmgxVnDUkvl77lDT/aJ0fdY4Vd1JNWH8nNyXPZ58zFk430WypWo/SXIOUKhjkpAjuK/yinI1/HH9uOoHLqRNykASm0XLxs+mc8EDF9HIB/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so32268565ab.1
        for <v9fs@lists.linux.dev>; Mon, 10 Mar 2025 02:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599559; x=1742204359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFoVqAg6REDEXJBJqfrIxbuubr4FSelQDBMfFrtoIhs=;
        b=swTQTEPY0FKDkOihJYW5yvCs64VJHcS6J4RfnuImwuKHxtLypDcj8dtzWC8juH/AIx
         65ZJR+FrU9UJDt24XjwicIWRWXUY0Ok+iTdKOzDOpdW9Thh8yEWUykp6j40gypt5ahW/
         fYl1gVGCtRlvkpi/YzNVwOhvqApQhAY9VPDsYcxJ0GdbHbo8Nsn+GAz+MBXPyxJXTwIl
         AViqSUrSedLWCT6QHlL/y/oi4OFJ/mhO1JHB+2kfglRQW+eA9VJ+0b0McISH90saDXPX
         2Ly8cHznS92pkFCetF9K5TbknREsGs2mMb7M6anv/pbLvr7ht1pYuOdOMtBOuTUlc7Jv
         dkZA==
X-Forwarded-Encrypted: i=1; AJvYcCXTyWYqNY4Kt4rcoXMNExkNkxhpiSJMafe2zQiIKRE6EdYfKimq+G45McrBi2iSZ//LwOTa@lists.linux.dev
X-Gm-Message-State: AOJu0YzIr7ubgwcRDk3tDelUe5Kkbqa9BuLcEq4xgINa30Tm6ZzkZACi
	j+5ji7w/RXfYdFgHTBhrye16KTayFdell5rAKABc5F13mvSsNV0zEArk7fB2TBpmRd9TrZ4cDpV
	CYEC1UlQeu0EiIrGA4CW5XfRP+n7bqZdJLz/enGZYJ8K50/gq26qcIrc=
X-Google-Smtp-Source: AGHT+IEhrwHsP/tAVFxVBPYxZcNfPE1Du/V72WIMBBt5fwGmzK6JmMSzSsYumGknELubQrcO4xPNhdFARLfy0hdxlqzAb1uWJDMw
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0f:b0:3d3:fdb8:1799 with SMTP id
 e9e14a558f8ab-3d4419b2bdemr175954665ab.22.1741599559244; Mon, 10 Mar 2025
 02:39:19 -0700 (PDT)
Date: Mon, 10 Mar 2025 02:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ceb347.050a0220.3d01d1.000c.GAE@google.com>
Subject: [syzbot] [v9fs?] general protection fault in p9_client_walk
From: syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb2281fb05e5 Merge tag 'x86_microcode_for_v6.14_rc6' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154078b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bed8205d3b84ef81
dashboard link: https://syzkaller.appspot.com/bug?extid=5b667f9a1fee4ba3775a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bb2281fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a0a6e98a402/vmlinux-bb2281fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55357371f99f/bzImage-bb2281fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 UID: 0 PID: 21142 Comm: syz.4.3149 Not tainted 6.14.0-rc5-syzkaller-00023-gbb2281fb05e5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 dd 95 b2 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 af 90 b2
RSP: 0018:ffffc90006b77a90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002bc05000
RDX: 0000000000080000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000d6ef54
FS:  0000000000000000(0000) GS:ffff88802b600000(0063) knlGS:00000000f5106b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000630b2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_xattr_set+0x119/0x2d0 fs/9p/xattr.c:121
 v9fs_set_acl+0xe6/0x150 fs/9p/acl.c:276
 v9fs_set_create_acl+0x4b/0x70 fs/9p/acl.c:306
 v9fs_vfs_mkdir_dotl+0x517/0x6e0 fs/9p/vfs_inode_dotl.c:411
 vfs_mkdir+0x57d/0x860 fs/namei.c:4313
 do_mkdirat+0x301/0x3a0 fs/namei.c:4336
 __do_sys_mkdirat fs/namei.c:4351 [inline]
 __se_sys_mkdirat fs/namei.c:4349 [inline]
 __ia32_sys_mkdirat+0x82/0xb0 fs/namei.c:4349
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:387
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fe0579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000080000140
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 dd 95 b2 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 af 90 b2
RSP: 0018:ffffc90006b77a90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002bc05000
RDX: 0000000000080000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000d6ef54
FS:  0000000000000000(0000) GS:ffff88802b600000(0063) knlGS:00000000f5106b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055eba214e600 CR3: 00000000630b2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	28 00                	sub    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
   b:	00
   c:	31 c0                	xor    %eax,%eax
   e:	e8 dd 95 b2 f6       	call   0xf6b295f0
  13:	48 89 d8             	mov    %rbx,%rax
  16:	31 f6                	xor    %esi,%esi
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	66 89 74 24 40       	mov    %si,0x40(%rsp)
  21:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  28:	00 00
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 3e 04 00 00    	jne    0x473
  35:	31 ff                	xor    %edi,%edi
  37:	89 ee                	mov    %ebp,%esi
  39:	4c 8b 33             	mov    (%rbx),%r14
  3c:	e8                   	.byte 0xe8
  3d:	af                   	scas   %es:(%rdi),%eax
  3e:	90                   	nop
  3f:	b2                   	.byte 0xb2


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
