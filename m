Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DC15FA96
	for <v9fs@lists.linux.dev>; Tue,  6 Aug 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937533; cv=none; b=qORZ4KLVhl2ZBj/rZxAlxU1WvE/4Gnc3Sthgp8q2re9kC/WiMFHEq3WDNoSRvtshKVgMAfJRF5NHdWJbWEwaWPwbsEEah9Fd902IFxPWgWxwy9E7Y04X5sjqAxJ+7cNBnRUULf9BhR+dqXMjQo093Q3pzgp5WhbtjdaR1GV0CCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937533; c=relaxed/simple;
	bh=tu9a25U64jCbSxqqXBPxFQ1YyuA5n8O8iVZKcPVXOwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z0EA5TBZ+GRk7KBIc6Z4yeGD0z2bpF8f9J/90pBfsai5CHAQZJ1HiyBzm/lpRd1036eg/QF1qBCrLhH8Nhb9V28F++HTWq52WnZbLhhdMgutuI/rNpFpQjlQ5GXbk1V1i0JA+2WhauEcr0Cn23L8yEg5Q1fVW6Ad8E+AnjdxDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b28ea6f37so7758145ab.1
        for <v9fs@lists.linux.dev>; Tue, 06 Aug 2024 02:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722937531; x=1723542331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oV1Kl44AMk2B99r0J/5HNNLjueYPWtTB6yqfoBERVr0=;
        b=O+G1xSgyDh12E0jn8jFAWt3ikHDU1fy8ImrK1anz+ehH1S9uopzWMm1kprOZYnQQhn
         i+piOlbzrD/5UHbXvhSZx6QceaXFekt7QiHrAPIR4akfyj6LHxBtvEVac4eg4nwSNXQh
         pGrplciyWvTjS5wXhhSg5HC3F38vy4VMShX4oL8srwr1FG0wOLQeQekM97MW+NZcnP0u
         evvuVQ0EgYKtXQkTVPm4+/FjrGp/E8iR6WYJ3126tJKMawNPgjT3p24PFKSBFPTYDN/k
         KVbHYfhReKjxe6uh4Da0MS2RAdBabntJyUqOUM0ZsSLd77uhnDKcqgTYhgGMfYjo3e0F
         KlJg==
X-Forwarded-Encrypted: i=1; AJvYcCUxmFqyloR70HjEnxnQHr1/Ye61bky7Cz2D2UGx/JzEKJCdM5fUWEG9Xp9ibafkLASP2nnV+gPN1cTmyiVV1jXBxnjG9w==
X-Gm-Message-State: AOJu0YxEbma/xTFP3IQDI3Gwbb6xeytZiriMooh36DGXQQlGSB30I9iD
	StL7wW3na1r00AcdG05KzRmoBbFl4Tu7Cr9W9EB/TgM9wysdjWznCVAAHsAY730918OnF6AH6DY
	DNrc4zKn9XRjjU++gdTiKKvvUwmTia7cOS7G8T3Gn7phoGaUsvK4fYZY=
X-Google-Smtp-Source: AGHT+IFXF2sccMXHtW2qIwpdgqNKEG55y3f8O5nzkgNbm3N9yIkKZyPR8aIVb5XnVsizZJsVBt6q2e/8YD0hTjQQljddKXIBjQUA
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c24:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-39b1fb7398emr9098045ab.2.1722937530821; Tue, 06 Aug 2024
 02:45:30 -0700 (PDT)
Date: Tue, 06 Aug 2024 02:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ec511061f00a7b2@google.com>
Subject: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0ecd6388360 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133ac8d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ffa365980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e4b703980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c0ecd638.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e795892c4ac/vmlinux-c0ecd638.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e387ec3cd3f/bzImage-c0ecd638.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com

------------[ cut here ]------------
folio expected an open fid inode->i_ino=23005ff
WARNING: CPU: 2 PID: 1155 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 2 PID: 1155 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 2 UID: 0 PID: 1155 Comm: kworker/u32:9 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-55)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc9000610f480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880327a0670 RCX: ffffffff814cc379
RDX: ffff88802329a440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888012c4a408
R13: dffffc0000000000 R14: ffffc9000610f840 R15: ffff888012c4a658
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000011d46000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x656/0xde0 fs/netfs/write_issue.c:534
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
