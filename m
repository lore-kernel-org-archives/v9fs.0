Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F614F67
	for <v9fs@lists.linux.dev>; Tue, 29 Aug 2023 09:39:53 +0000 (UTC)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68a3ba17c7bso4445365b3a.2
        for <v9fs@lists.linux.dev>; Tue, 29 Aug 2023 02:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301993; x=1693906793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkrIRuB/KPiotjwKowWNb1HI/98DR9xAPXUPa4EZXHE=;
        b=DyRglI/QYKAHGCcFUBoZXmW0uT69RptD39kZz64gKHU3ukycXr9l3V0M5ayI9CO6m6
         xxUhmQs/MoU8sqk56hEguQTFxpym0puSXKReTlVz2yHwhpBLRR3ouyt/pRzqoeeAuMmX
         CQbRtjWZ9fDq05tOn0Gi6erwfcBmEoUNixXj/TJqixLTCi93Aq0R3jIcNqUUx5P2Vnzr
         zLjfUjBZOTBGWV+QThFpBkUCrP6Iz2SmlWHb/ht5hrCn0WKKV/lDhnxiST7zsNbu4YBL
         YCLt0go5wfCI2cpQ8lymDgxuZjtdDOLndT8i+hW+Auw9EeTla1ikIJySX8b+sPIV5hq9
         pyxA==
X-Gm-Message-State: AOJu0YyoDv1zjc6VOxdo5+UmtY/0JxpDV//sZLlkrx5taiqNJLtQTxNL
	cqWWTlnHQ+uDfYbVB+ErBTE47OYXvWTd0fHpy42ZgCdiyE6w
X-Google-Smtp-Source: AGHT+IEdy+SdGk+xeL79w68etB+bpMNJdFi/Zg+lDXeT5igRdxr5vPtbLZDZoPGe/9Fh97TleRSOarPSGNJSggDQ6tT9LAX0TQa0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1491:b0:68b:dfef:de87 with SMTP id
 v17-20020a056a00149100b0068bdfefde87mr5135810pfu.4.1693301993531; Tue, 29 Aug
 2023 02:39:53 -0700 (PDT)
Date: Tue, 29 Aug 2023 02:39:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d26ff606040c9719@google.com>
Subject: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
From: syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, davem@davemloft.net, edumazet@google.com, 
	ericvh@kernel.org, kuba@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    53663f4103ff Merge tag 'nfs-for-6.5-2' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103fc55fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f12c32a009b80107
dashboard link: https://syzkaller.appspot.com/bug?extid=e441aeeb422763cc5511
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f32101f0e8a2/disk-53663f41.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e577e9d7daf/vmlinux-53663f41.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af8ae7d4d06e/bzImage-53663f41.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in p9_fd_create / p9_fd_create

read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 p9_fd_open net/9p/trans_fd.c:842 [inline]
 p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 p9_client_create+0x595/0xa70 net/9p/client.c:1010
 v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 vfs_get_tree+0x51/0x190 fs/super.c:1519
 do_new_mount+0x203/0x660 fs/namespace.c:3335
 path_mount+0x496/0xb30 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 p9_fd_open net/9p/trans_fd.c:842 [inline]
 p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 p9_client_create+0x595/0xa70 net/9p/client.c:1010
 v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 vfs_get_tree+0x51/0x190 fs/super.c:1519
 do_new_mount+0x203/0x660 fs/namespace.c:3335
 path_mount+0x496/0xb30 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00008002 -> 0x00008802

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15563 Comm: syz-executor.3 Not tainted 6.5.0-rc7-syzkaller-00013-g53663f4103ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
