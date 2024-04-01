Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E347A76
	for <v9fs@lists.linux.dev>; Mon,  1 Apr 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987770; cv=none; b=izMF/Xa2HVBCH555CA9eK0dtx45kntk/SKx04nEO7HW4uuZnO0bETYuXd6M0CoOAgkq81sb2gEJ6IVFaeJQ3+1fnQvLL8TiU/xj5FDIvjsYGaaFZJThFLvOxZj21+qpIFq01NmXGF/rRuU9WAeiuaIoC/l32nCgmSUgTR4WyrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987770; c=relaxed/simple;
	bh=9MJQaaNhjZxg8cTjUe//Brvwr9I7kgQyflReATtuETk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RKnNZRAqCkid2duWY3au6NU8i2d2HLeipN2fjMY8gvZHRTJa/6xrkKRfFQlqSBYwF9aHLTHBgM8wGbKn16Qq2AZwJzZn7b7rpNCAigIJNcTxkPXJoE4dd7eXP2S1R06LwXiCWT+MCpt9xfKi2JtOtzh2mmIEo3rdF83BN0Y04b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368c8628504so30579695ab.2
        for <v9fs@lists.linux.dev>; Mon, 01 Apr 2024 09:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987768; x=1712592568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8ltHQaZ4qCuEtVlYYBAXZvP0KfucEV94mRShkDJKW8=;
        b=MVWXT1xutN2cAKcYXSyLox03aQ6oTUquJNhXpGq/lL+sulqcid1bq9Gsu3mcPwTgSI
         cuWktV+2IpWEoQw21Vla1HBY5DP8cGBha5BstCYJNItIjzs9ines2VIVtlmr+aPm5lQI
         Tw5AAivcKzFOw3XlZt1VxDBXZhwOoKDaAVglZp7tQl/2hnVs09Xr/OT0hMnynJ6+2aYU
         TfHx9XO/cRrmhTXHR4+9Ph0Nz6XMoaCFLFcPys53zRlELDBAZHZCLCIOixOLKif490IE
         PVXwCl6nD8h8/eOnhb98BWJ83SnvSbnG/No1RVu5uu7fvBnTORed0bZRy9x7GwZS4PRV
         nCfA==
X-Forwarded-Encrypted: i=1; AJvYcCXKgKEcDFIuOt0CoJgtyNPA7YEy882U6JCqSr8W53OKwCuXJnjnk56dKXqXdI82lkgbIL4W7k08BvBsIZM1igHwlREy2w==
X-Gm-Message-State: AOJu0Yy2psMzsnHr0RFFQcozav4iPOymGfXRLsnOCycrhz2htquGJwV9
	+DyYIL38I1uoRYdWmAscGxv8zISoiSVEYDx/8sL7HugtPq5dHzZiUFcpUAYRkjfwrcFxlCn1C4D
	6dzn9IKEODleE3fnUHXZN+f809pBrUwKMsf44Zm13DMTwRlWhpCAzO9Y=
X-Google-Smtp-Source: AGHT+IG5j4u78ZNjb/Jw67+iM4et54jH7d48y5fTefaiTFr2aCnztjUBHPyzxghJLrWbFnQq+DceoHsnDB5Fr3f+SkbuiyO/zPa6
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:369:8ea5:f650 with SMTP id
 w9-20020a056e021a6900b003698ea5f650mr408782ilv.3.1711987768088; Mon, 01 Apr
 2024 09:09:28 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6ea9b06150b361c@google.com>
Subject: [syzbot] [v9fs?] WARNING in v9fs_init_request
From: syzbot <syzbot+0354394655e838206fba@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cb6d7e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2fbd4c518bbb6b3
dashboard link: https://syzkaller.appspot.com/bug?extid=0354394655e838206fba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-8d025e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8028eb34add3/vmlinux-8d025e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1edea22db964/bzImage-8d025e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0354394655e838206fba@syzkaller.appspotmail.com

------------[ cut here ]------------
folio expected an open fid inode->i_ino=2
WARNING: CPU: 2 PID: 1121 at fs/9p/vfs_addr.c:115 v9fs_init_request+0x346/0x380 fs/9p/vfs_addr.c:115
Modules linked in:
CPU: 2 PID: 1121 Comm: kworker/u32:9 Not tainted 6.9.0-rc1-syzkaller-00061-g8d025e2092e2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-36)
RIP: 0010:v9fs_init_request+0x346/0x380 fs/9p/vfs_addr.c:115
Code: ff ff 37 00 48 c1 e0 2a 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 35 48 8b 73 40 48 c7 c7 60 03 4e 8b e8 cb 20 12 fe 90 <0f> 0b 90 90 eb 9a e8 1f d0 ab fe e9 51 fe ff ff e8 25 cf ab fe e9
RSP: 0018:ffffc90006ebf2e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888029e72920 RCX: ffffffff8150eb39
RDX: ffff888018f42440 RSI: ffffffff8150eb46 RDI: 0000000000000001
RBP: ffff88805d9bfc00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: ffff88805d9bfd42 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000058389000 CR3: 0000000043388000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_alloc_request+0x54c/0x9a0 fs/netfs/objects.c:53
 netfs_write_back_from_locked_folio fs/netfs/buffered_write.c:910 [inline]
 netfs_writepages_begin fs/netfs/buffered_write.c:1100 [inline]
 netfs_writepages_region.constprop.0+0xffe/0x1bc0 fs/netfs/buffered_write.c:1123
 netfs_writepages+0x2fa/0x420 fs/netfs/buffered_write.c:1169
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x5a6/0x10d0 fs/fs-writeback.c:1941
 wb_writeback+0x28a/0xb30 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2304
 process_one_work+0x902/0x1a30 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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
