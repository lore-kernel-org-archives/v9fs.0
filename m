Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012E26157D
	for <v9fs@lists.linux.dev>; Tue, 11 Feb 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304686; cv=none; b=ri2kdzWwRRoAL/S2gYgf6tIApVCrspqYR1Zq9gj+iTsl5/EYjROwgY3R6hEVHwycL85DaS6r/PGdXQbc4lEwdKtaLPiYkLt72C+jIVV8JSng1F8ouL6qb/YdkzyWaWg6tyi7vVQxM7aj4PgsKkWgneaCq4p0Fdi0x4SHwD3ZITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304686; c=relaxed/simple;
	bh=qkTtrfTVE2e5VnCCfLqDdAUacevlSdasx1HzE+O11r4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F0NgO419408P+R7HU6HYEMWuO407GsmF299GUxinc9UKSUz3ZogvikX2GKijLifIHeAe5nMTAzOn9H0A4w36ZOcr0sDD/cZ9vp19Zid5813uMKfG0wDVdPjuT27r34yYCIFj5x2nIWXt5OCI4heDJKfSvOFegMtFIg6qbpPf3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d1445827f9so29179115ab.2
        for <v9fs@lists.linux.dev>; Tue, 11 Feb 2025 12:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304684; x=1739909484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRVAjGpy53j9eMkWE5h3z1GKtU13K2c7lkx79j1/V8k=;
        b=DlYPT5ZIWSeI61j3wiy9BxhWLTsCHp3wqbj5vMQ3Pih0a3uHKdD9c68rIJj8POjVFf
         38XipvpP9jCeIywtGeC5yzTNd+773C8GWhLcXd/AxfiVHv/hrBrVgdSgHTp9XM4fl78e
         +U9NSBt/gn+OWAh2QIru64FHe+NJn4OGgvQSh3puv5Eekrh/zKpoY/Pgar4hNTl5IyCc
         gFYzlnGoGxvPE9Quao587kqDFmHs8JYGGmi4mtvH2DS8W2PRiLHbHjy0/XL7wi9wDLV9
         rmrZT36OYFc4I39pzktK6ohQm5TfXaBh24UGgcZVjuIonREhXDXT03xauV16xHYXfvTp
         /QIg==
X-Forwarded-Encrypted: i=1; AJvYcCVB7ghHcjTP1IVo88WsmRHTjyvTMSZlnMQXzslxcQrfVkenDMeO+Hmce+KK8pDoLDvan4Od@lists.linux.dev
X-Gm-Message-State: AOJu0YxpEEvHssVsfXy0w7UGphkxE70VbGF7sywmRtxM60XkDAfeua2+
	lPUp2A9D2dJiy6G8QQyHZpwPpG44MQK8FYDdilFPIxhbA94ux+qRG8N+qXovpurbnwvRREKClao
	e+ZO/dSB1Hu3uMu84Hoo8sHSMtWukAEbZ0DUfw8FpW0eHGLc8ViLuR1I=
X-Google-Smtp-Source: AGHT+IEB0erOopqlfKrN/oqmh8lDIEhXJynd0cj6id7WlVR43LgxciVegxBjDWXuto70F+E5kupPmj6oIrriPnUDIaYNc6jvPyHb
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3cf:fd28:852 with SMTP id
 e9e14a558f8ab-3d17bdfe77amr9760125ab.3.1739304684201; Tue, 11 Feb 2025
 12:11:24 -0800 (PST)
Date: Tue, 11 Feb 2025 12:11:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67abaeec.050a0220.3d72c.0087.GAE@google.com>
Subject: [syzbot] [v9fs?] KCSAN: data-race in p9_conn_cancel / p9_write_work (7)
From: syzbot <syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    febbc555cf0f Merge tag 'nfsd-6.14-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114123f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7722a092753bcf03
dashboard link: https://syzkaller.appspot.com/bug?extid=d69a7cc8c683c2cb7506
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e7d4c83286/disk-febbc555.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483282168b02/vmlinux-febbc555.xz
kernel image: https://storage.googleapis.com/syzbot-assets/510fcf6f96a7/bzImage-febbc555.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in p9_conn_cancel / p9_write_work

write to 0xffff88810db66428 of 4 bytes by task 23357 on cpu 1:
 p9_conn_cancel+0x89/0x400 net/9p/trans_fd.c:199
 p9_poll_mux net/9p/trans_fd.c:631 [inline]
 p9_poll_workfn+0x133/0x410 net/9p/trans_fd.c:1177
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff88810db66428 of 4 bytes by task 23378 on cpu 0:
 p9_write_work+0x26/0x750 net/9p/trans_fd.c:453
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0xffffff98

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 23378 Comm: kworker/0:8 Tainted: G        W          6.14.0-rc2-syzkaller-00034-gfebbc555cf0f #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events p9_write_work
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
