Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4138D686
	for <v9fs@lists.linux.dev>; Sat,  6 Jun 2026 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745731; cv=none; b=T0ghg/bfWJ5JtFkeUwBFoT5QTPLXmzp9OGswsw3h1Mr2vkXALYOuTI9tDoUcN+J9/x33ratLbAIMChNFydc1d0sdbTMd9lBMa64FH8EvuiQ9WyGRyXgMOYTG9jCwN/7MWU2pmgSzfJgEQmbN6R79MhCdEGCA+uma4tsBDdES1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745731; c=relaxed/simple;
	bh=KqgjCuIrP89vDH6/1LxePh7LUQ2elAch0ohcuf70Xh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g1ExUBXSGrl6Knnwx7fVv9KR45WFIDHm6+G0pCa+bdKubWQTYboeIHsF4WKdcnIrCYvcpMb152hT3Lx+snrK6/u/9iVRHJSEnXCKOjDEgc1r0U/uz6QDtfwK6yvqIampX+HA8+O09W6pyp2+dp66SmophU0h0lmK0i7PXhIBJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e6dd45f2b6so4439795a34.3
        for <v9fs@lists.linux.dev>; Sat, 06 Jun 2026 04:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745728; x=1781350528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seam925cmATIMzNd5sJ3dMURXXOJD0ydiGoUv2W/eCs=;
        b=cjvYHgy8mDP9FI7RMUe4G6EmhbWpc0xVOlaBygRdgOujHmgGrzB33YXDnoZQAIWPc5
         0joRQMwTqVoCtHSkLjgMiQ+iGGM+o32NbPS/qJacNP7xTI03iCmgG7yOQgnVl24Fk715
         lxZy8Z1TkgJ0wG3Ioj7etwq/ZJG5BN5hSHB3IccKHavgd4mkxQosymqCB8ucs31DWHse
         bQOiwMIBJoDlJB4NRQsB1vyoxwWov/Xe0uwtMbhCAvqccZ66wmi5JJ9JGEXt5m5ibD8F
         Saa4fV9lvrMStcQZrRr5p1AQh4HQ7FlFZwyNlBmmTCXnyEx9AAFEFdVrfsxJU2N77gvD
         sIeg==
X-Forwarded-Encrypted: i=1; AFNElJ/rYzG900FFwklv7qAIscMPuGxLK/yJbosDFBv4Fxpv08l/bDEn33raeZ7XDHEh9qmlm8+1@lists.linux.dev
X-Gm-Message-State: AOJu0YzPDNPGCPp+MEkURI5Vvo9I7sO+2RM6o4FEsAU/O3T3XKKTeo25
	Cv196d95VS7HRZEABxspUM07hlJIAHKFYJ90zMVLJtWF2gFwUnJVXyoD0El4Yv3i1jV/63tTdDO
	iMkK6K1nAb64yq0/3Wn7WmkkrsGq5mJQ3fs3uPEx9OiplaHmSsYpzH3hUoC0=
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1789:b0:69d:b26c:7aa6 with SMTP id
 006d021491bc7-69e68cd56a8mr4243721eaf.56.1780745728390; Sat, 06 Jun 2026
 04:35:28 -0700 (PDT)
Date: Sat, 06 Jun 2026 04:35:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a240600.c25708ab.1b19ef.0003.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING: refcount bug in p9_req_put (4)
From: syzbot <syzbot+f6fdb3bdd2c1d419e263@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba3e43a9e601 Merge tag 'soc-fixes-7.1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b65a86580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=f6fdb3bdd2c1d419e263
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158b5f2e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d47dd2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ba3e43a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12db9228338c/vmlinux-ba3e43a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8dfb3210b18/bzImage-ba3e43a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6fdb3bdd2c1d419e263@syzkaller.appspotmail.com

9pnet: Tag 0 still in use
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xf4/0x130 lib/refcount.c:28, CPU#2: syz-executor/5869
Modules linked in:
CPU: 2 UID: 0 PID: 5869 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:refcount_warn_saturate+0xf4/0x130 lib/refcount.c:28
Code: cc e8 b0 53 0f fd 48 8d 3d 89 44 e8 0b 67 48 0f b9 3a e8 9f 53 0f fd 5b 5d e9 d8 4f 93 06 e8 93 53 0f fd 48 8d 3d 7c 44 e8 0b <67> 48 0f b9 3a e8 82 53 0f fd 5b 5d c3 cc cc cc cc e8 76 53 0f fd
RSP: 0018:ffffc900060a7c38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803ecb7218 RCX: ffffffff84f95c3b
RDX: ffff88802b710000 RSI: ffffffff84f95ccd RDI: ffffffff90e1a150
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88803ecb7218
R13: ffff888035c59800 R14: ffffc900060a7cc8 R15: ffff88801fa88040
FS:  000055557717e500(0000) GS:ffff8880d6583000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e3b8556be0 CR3: 0000000037a35000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 p9_req_put+0x1ec/0x250 net/9p/client.c:281
 p9_tag_cleanup net/9p/client.c:308 [inline]
 p9_client_destroy.cold+0x20/0xe9 net/9p/client.c:963
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:543
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:175
 deactivate_locked_super+0xc1/0x1b0 fs/super.c:476
 deactivate_super fs/super.c:509 [inline]
 deactivate_super+0xe7/0x110 fs/super.c:505
 cleanup_mnt+0x21f/0x450 fs/namespace.c:1312
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x157/0x670 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbad779e097
Code: a2 c7 05 5c 06 25 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffe847bc88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fbad78321ca RCX: 00007fbad779e097
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffe847bd40
RBP: 00007fffe847bd40 R08: 00007fffe847cd40 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffe847cdd0
R13: 00007fbad78321ca R14: 000000000004828a R15: 00007fffe847ce10
 </TASK>
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	e8 b0 53 0f fd       	call   0xfd0f53b6
   6:	48 8d 3d 89 44 e8 0b 	lea    0xbe84489(%rip),%rdi        # 0xbe84496
   d:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  12:	e8 9f 53 0f fd       	call   0xfd0f53b6
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	e9 d8 4f 93 06       	jmp    0x6934ff6
  1e:	e8 93 53 0f fd       	call   0xfd0f53b6
  23:	48 8d 3d 7c 44 e8 0b 	lea    0xbe8447c(%rip),%rdi        # 0xbe844a6
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e8 82 53 0f fd       	call   0xfd0f53b6
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	e8 76 53 0f fd       	call   0xfd0f53b6


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
