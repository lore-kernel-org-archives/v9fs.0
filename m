Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBF1EEA2C
	for <v9fs@lists.linux.dev>; Fri,  7 Feb 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935086; cv=none; b=GKvDypTYYMckGMMXaK3oQEkbsKzwzzAWM9L2EgO+W1Um3x62VjswLeOYNnuzyf616AzzYFgNtIhx1JggWKI9vP5PeOYc8+C58ck65JEIJ7OPpBObUNxxdY+ujdpT03DQNmMoBfHbhNaqVI1BJ/iW0oSuvX+hroiHXInJ337R724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935086; c=relaxed/simple;
	bh=ymi60WGFjhscFdsIm802/d4yiAbwikj1UY4b2ntdXYQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ll0hbZ+cq37T5w0pmHFxdAfoo554YePkDq9aT5j2TseI5Zb9p4uQREQW+4bsd6SGM/aguqNiMp/o+0qG4Vj05oWLB9TNu9GNkOAsXJKrfLK9AvVWSpl/t9/e76rBFfkOeuAU5aAGnHhav2Vn+Z2+j+ln8YK83xuHxHT24g2gBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so13506565ab.1
        for <v9fs@lists.linux.dev>; Fri, 07 Feb 2025 05:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935084; x=1739539884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6g8IDLG4w77EqeqDl99QzpJ+8lhWFbIn4aXw92sJiDE=;
        b=Yv5E2mW6/bGXqllH9aNxto5W0cxkhlpwdEHky9kCkbIvXgLFInX8tT1zdxl67KRe6p
         /5cWOz+QKt6oXLXfAav9UCq89LAmCLJAQxxrzNR1Nm6DNeXTcZs3JcR0kP/+AGFojYbI
         sc38MvHvA/UQZJpEkSVW2cJCqEFMGBLWFMYQQ5pRT8DH9Wc1lJtqP5cpZrdSMjRCSeVZ
         ORV4QlwK+6d/6HtfL+wWJHYUzhoxP1MpBHQP/gs2j4HFCrFEf5ug8eJLkmiBGgDBp0df
         DzO1H4y3JZDcLRYFmplYjQaZPYul6PGomWYi7+t4uvFwaqb5n66WBlU6WbhkCYHR7Hpm
         gEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwRyADOdnJERmj1RANvyircVp2EThAsMaLPLYpwZ/XLK/KOF8/daUR+VAJeL8O2FmSl7bV@lists.linux.dev
X-Gm-Message-State: AOJu0YxATK13Wq/X8gshmiuqr/jEUWdvdHpYuDXI9JWOXD2zrOE7HnbE
	/eOzXNJdlsQA3rEImElwUhSm/Feru+tSyWSAe3nr5patf4Ca8kVT2p6hboYhhm8tf7mMi2PGteK
	PfZNXNVehdV8NsFpV+LbGjARuO7og/2DeQjM1OqJz5/JUr8yAjtTT4VM=
X-Google-Smtp-Source: AGHT+IEEEMx7RdpdFLSnbaxw+m3A6SKN4j28OAXJClu7C35gHTH+RVu2tWOKfT5A/JjOhP85IA3NHbIJfhttGMB4dy+suTM9AACz
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:3cf:bc71:94ee with SMTP id
 e9e14a558f8ab-3d13df3ea82mr17242165ab.14.1738935083638; Fri, 07 Feb 2025
 05:31:23 -0800 (PST)
Date: Fri, 07 Feb 2025 05:31:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a60b2b.050a0220.2b1e6.0026.GAE@google.com>
Subject: [syzbot] [v9fs?] KCSAN: data-race in p9_conn_cancel / p9_poll_workfn (9)
From: syzbot <syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb066fe812d6 Merge tag 'pci-v6.14-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167e64a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e757e3762bd630b
dashboard link: https://syzkaller.appspot.com/bug?extid=483d6c9b9231ea7e1851
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/96c2fa324092/disk-bb066fe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0c48f9198dc/vmlinux-bb066fe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9ae4ace7c1c/bzImage-bb066fe8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in p9_conn_cancel / p9_poll_workfn

write to 0xffff888164f81828 of 4 bytes by task 4264 on cpu 1:
 p9_conn_cancel+0x89/0x400 net/9p/trans_fd.c:199
 p9_write_work+0x3ac/0x750 net/9p/trans_fd.c:522
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff888164f81828 of 4 bytes by task 9 on cpu 0:
 p9_poll_mux net/9p/trans_fd.c:625 [inline]
 p9_poll_workfn+0xc0/0x410 net/9p/trans_fd.c:1177
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0xffffffe0

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.14.0-rc1-syzkaller-00081-gbb066fe812d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events p9_poll_workfn
==================================================================


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
