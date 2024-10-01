Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175F1C9B84
	for <v9fs@lists.linux.dev>; Tue,  1 Oct 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799868; cv=none; b=n9KAYkVawOimWqjpjcerk5zmGaEDCXK/AwvEDQCMTID8s+iQEQkWbmGlkvqT7OITgtlwN+tDh+jxHrnFd2FkYI8Kx20oNGxQ4L5/hiofVOfuzADqkpfrqzSuEbaN6vtL27T5RmkvOoZtPb9q9mmGTr6jxbRbu3514+zMjMnOv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799868; c=relaxed/simple;
	bh=/VLMtqDMgC3DnVIAjVzN+k+XeQ4aWDwEu8diYZ4brjc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tjN8FAY86CTOTx4DfdhuHwfmiNiqRwvYthqs80fqD841xlXSdUFHEA2BFvBralScxGHIPEx/Xhz0YOONs30jacIa54jCjhURr1N7gCVwVaMSJYi8fyE9ap6ZVedbe8wok8vVUqbKY+b5/UUhEdFvJbXToSB/12WB+RhX87Cxpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1957c7cf3so58906125ab.2
        for <v9fs@lists.linux.dev>; Tue, 01 Oct 2024 09:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799865; x=1728404665;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOlCM0aIXtTKsX9B0pYhaWX7QLRXRQl2+uSddfIsi8A=;
        b=I151o2v7gV8EPPjHxYR7CpOxljku9UV9zj2gjFkz0PORbjuxtDOkRXCvHdNRgIk3XS
         G0xTCEfAkgwpuJOqdVPyaisgX2bRBwnHXeBg+pHuKx12jh2k1KWqLpimPYhDoPuJ6xUQ
         Ibb5tKL50KPpF8es5wDRQfSHxhY9dnZFpzZlL1YD2ZwH3958EX7mhNbBduw7QzOY705g
         YEvlgY4ANawX/UxGY2lhRWtCD0q2R0I0NQL4tfJXeLs/IWdMMcHsv48kbfQcGzAYiRKO
         SbRofBKRH56nTbEGnHf/QD1nHX7w02jTA4EPswVAkfvkdeljVEiV6c0H4p2MG44S1irq
         UX7w==
X-Forwarded-Encrypted: i=1; AJvYcCVYlB8zpZcaPvijaMYaROfLj1f//57U0Aldvd0CykXUQIfVS9pwuNcNNVMR/FbGHHZ/y/4a@lists.linux.dev
X-Gm-Message-State: AOJu0YytfqbclWfQDbaF2QsnMPmy8nEaSRHgnMTr0N8d7659SjUoJhT6
	duQ4Nzur+uLK4Q4dfKlo5tPfqOsoyaoLLJBtBWbdlDbQi8VfPNSC67udGBHce5+M/6OTpsgpnNS
	4+x6hfdgfeVMUS0PfVqjzzHZlAsOwJOagtFVBVJAwXuvadvnWwA7HOtc=
X-Google-Smtp-Source: AGHT+IFNQdeQJkmOqqj/F2KafGLbWgDZh6K5SjVTUA54kJfF0PcO3plMTkE4CImRPh3z53C54anY6u0pD/vg4gTBbIAz+/H7Pf1t
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:3a3:44e6:fe66 with SMTP id
 e9e14a558f8ab-3a36591c4cdmr415465ab.10.1727799865658; Tue, 01 Oct 2024
 09:24:25 -0700 (PDT)
Date: Tue, 01 Oct 2024 09:24:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc2239.050a0220.f28ec.04b8.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in p9pdu_vwritef
From: syzbot <syzbot+94b73a3e8ea625efcd05@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118086a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=94b73a3e8ea625efcd05
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c02adb371c0/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e56aa110f69/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94b73a3e8ea625efcd05@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5107 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4039 [inline]
 slab_alloc_node mm/slub.c:4115 [inline]
 __kmalloc_cache_noprof+0x6c/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 netfs_buffer_append_folio+0x1f1/0x8b0 fs/netfs/misc.c:25
 netfs_write_folio+0xe69/0x1fe0 fs/netfs/write_issue.c:421
 netfs_writepages+0x89f/0xe80 fs/netfs/write_issue.c:541
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 file_write_and_wait_range+0x195/0x280 mm/filemap.c:788
 v9fs_file_fsync+0xf3/0x1d0 fs/9p/vfs_file.c:418
 generic_write_sync include/linux/fs.h:2871 [inline]
 netfs_file_write_iter+0x36d/0x3f0 fs/netfs/buffered_write.c:487
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x561/0xe10 fs/read_write.c:1388
 __do_sys_sendfile64 fs/read_write.c:1455 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f198897df39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f19897ef038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f1988b35f80 RCX: 00007f198897df39
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007f19897ef090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1988b35f80 R15: 00007ffe59816f08
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5107 at lib/iov_iter.c:255 _copy_from_iter+0x300/0x1d60 lib/iov_iter.c:255
Modules linked in:
CPU: 0 UID: 0 PID: 5107 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:_copy_from_iter+0x300/0x1d60 lib/iov_iter.c:255
Code: 48 3b 84 24 20 01 00 00 0f 85 d2 19 00 00 4c 89 e0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 01 5c db fc 90 <0f> 0b 90 45 31 e4 eb 96 e8 f3 5b db fc 4d 89 ec e9 3e fe ff ff e8
RSP: 0018:ffffc90002e7e680 EFLAGS: 00010293
RAX: ffffffff84b9586f RBX: 0000000000000000 RCX: ffff88801ab9a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002e7e7f0 R08: ffffffff84b95627 R09: 1ffffffff2039b65
R10: dffffc0000000000 R11: fffffbfff2039b66 R12: 0000000000000007
R13: 0000000000000007 R14: ffff88801e137560 R15: ffff88801e137562
FS:  00007f19897ef6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1988b0b538 CR3: 00000000126de000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_from_iter include/linux/uio.h:219 [inline]
 copy_from_iter_full include/linux/uio.h:236 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x1c75/0x29e0 net/9p/protocol.c:614
 p9_client_prepare_req+0xa8d/0xf50 net/9p/client.c:651
 p9_client_rpc+0x19d/0xac0 net/9p/client.c:691
 p9_client_write+0x328/0x7a0 net/9p/client.c:1635
 v9fs_issue_write+0xfd/0x1c0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write fs/netfs/write_issue.c:223 [inline]
 netfs_issue_write fs/netfs/write_issue.c:250 [inline]
 netfs_advance_write+0x4c8/0xb20 fs/netfs/write_issue.c:291
 netfs_write_folio+0x12f4/0x1fe0 fs/netfs/write_issue.c:469
 netfs_writepages+0x89f/0xe80 fs/netfs/write_issue.c:541
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 file_write_and_wait_range+0x195/0x280 mm/filemap.c:788
 v9fs_file_fsync+0xf3/0x1d0 fs/9p/vfs_file.c:418
 generic_write_sync include/linux/fs.h:2871 [inline]
 netfs_file_write_iter+0x36d/0x3f0 fs/netfs/buffered_write.c:487
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x561/0xe10 fs/read_write.c:1388
 __do_sys_sendfile64 fs/read_write.c:1455 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f198897df39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f19897ef038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f1988b35f80 RCX: 00007f198897df39
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007f19897ef090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1988b35f80 R15: 00007ffe59816f08
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
