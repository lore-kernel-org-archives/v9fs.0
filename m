Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35A28EA
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737686970; cv=none; b=Dn65R0vYwM3XZWPt1Fo1ailJuSW+xDzfZ9/NjlGVb1ZrV1KqzLgYcxWFJqPB50WpeUo683CvPEeRwuNC8IJ2RRcmVZ0BjxXcVQ7DdVomVVOOLfrDaNOZ6K0oNldpVyPkVGk4UqLy3sRogQlqDyhHbsl8Uvg0dekEfuT3g8LTNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737686970; c=relaxed/simple;
	bh=KbZJ7ukzOJg/pOMuMPHF9ODEbI/DoefeN8NaSyy4FzE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EM51vVby/0TQ89BpQqyO4zprFQwLUlZSwExKoPtFfiGLcu3KdYBYbwYRxRmxPPyQzXvoymeDHR4XGp+YRnttjixQwQNugl4xSdJus7zBkcAS7W7CGcaAyBhH+cZLswtK50AeVc1DDDxYX3CoQuY84T+7PscMi8zlYmNvQTgKu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso11415975ab.1
        for <v9fs@lists.linux.dev>; Thu, 23 Jan 2025 18:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737686968; x=1738291768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLZnp9naXV0ytPIf3YX8FE2FugwReNMId899MNv+qlU=;
        b=nZ9w7bn3ubyfL2Hqb84aUfwqwzDKyGE4+iA8umhF8ltP5MKoObmHZcSPDWppTVdiS4
         raJF2RtgRVfVqB/taAGwsa7iB3pGtlYpe9x36tkdrGWsr1M2AD/Igr4PNpXtGJXB5hLj
         JFZlsK6HkOD6Emd1At8WxYQI7+A5RXmo+OrRKLZcrBfRSbWUVqJKRQ/96Zi0Im5wjklk
         rjIpNT1ocMH+u3UnByXVA+OhCxdkww8jglakw1ddtqwPZ1zijqLnLLoxCVCHfDYZGYZg
         T1JJRcrnFat7ymW4OoAQ5CUswfhpRt8+2ayyZu2UWVhKZs3O+QQCHbRS8SbyYh+R8Bx1
         NNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWjjDdqcI4tbyQbgJ0cMiuUUMJydHIj6YQAwDu7LTqq9Ux3JWtoUoCtDIND8FS3cNG9FeRN@lists.linux.dev
X-Gm-Message-State: AOJu0Yx82YH93gcfpY32Eql2u2qM5IcQIVADNZGWTIok3crZ6E7uq4m4
	QCwZu30wI6p5o7gGe/IHh94yUb+Qo1zGyMEQuhTIijQYfz7fVQUMou4QSh9BjG/6bXzr1Vn5DqG
	zPpYK2BK8NgcE+BzQ4fm4ciFUzfA7pklY0JJjxKj7kWZ8Pf4XvopySXw=
X-Google-Smtp-Source: AGHT+IEK38xdS9GtqeQodCstSkB6mt9r6Wj9kqRjdH2xBN86BYm9BzaRtubA0Tjv5uu2JCFxiF1H5ECmm4+vvzTV8CFDOkC06Q65
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:3ce:5af3:79d5 with SMTP id
 e9e14a558f8ab-3cf743eb4aemr193846455ab.6.1737686967794; Thu, 23 Jan 2025
 18:49:27 -0800 (PST)
Date: Thu, 23 Jan 2025 18:49:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6792ffb7.050a0220.3ab881.0005.GAE@google.com>
Subject: [syzbot] [v9fs?] BUG: stack guard page was hit in sys_openat
From: syzbot <syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9528d418de4d Merge tag 'x86_urgent_for_v6.13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149252b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7f05e16f48c5834
dashboard link: https://syzkaller.appspot.com/bug?extid=1f18c9b1bb51239d82f2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17808824580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129252b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00bcc6e6ccca/disk-9528d418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a3be632c086/vmlinux-9528d418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/513818683d52/bzImage-9528d418.xz

The issue was bisected to:

commit 4acb665cf4f3e5436844f17ece0a8a55ce688c7b
Author: David Howells <dhowells@redhat.com>
Date:   Fri Dec 13 13:50:08 2024 +0000

    netfs: Work around recursion by abandoning retry if nothing read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d4b1f8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d4b1f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d4b1f8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com
Fixes: 4acb665cf4f3 ("netfs: Work around recursion by abandoning retry if nothing read")

BUG: TASK stack guard page was hit at ffffc9000308ff88 (stack is ffffc90003090000..ffffc90003098000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5811 Comm: syz-executor387 Not tainted 6.13.0-rc7-syzkaller-00209-g9528d418de4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__lock_acquire+0x24/0x3c40 kernel/locking/lockdep.c:5077
Code: 90 90 90 90 90 90 41 57 41 56 41 89 f6 41 55 41 54 49 89 fc 55 89 d5 53 44 89 cb 48 81 ec f0 00 00 00 48 8b 84 24 28 01 00 00 <44> 89 04 24 48 c7 84 24 90 00 00 00 b3 8a b5 41 48 c7 84 24 98 00
RSP: 0018:ffffc9000308ff98 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8880b8644c58
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff905f7c97 R11: 0000000000000003 R12: ffff8880b8644c58
R13: ffff8880b8644c58 R14: 0000000000000000 R15: 0000000000000000
FS:  000055556c371480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000308ff88 CR3: 0000000078d02000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
 _raw_spin_trylock+0x63/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 rmqueue_pcplist mm/page_alloc.c:3032 [inline]
 rmqueue mm/page_alloc.c:3076 [inline]
 get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3473
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xd7d/0x17a0 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 p9_fcall_init+0x97/0x260 net/9p/client.c:233
 p9_tag_alloc+0x17a/0x870 net/9p/client.c:298
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
 p9_client_read_once+0x24f/0x820 net/9p/client.c:1575
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
 v9fs_issue_read+0x115/0x340 fs/9p/vfs_addr.c:76
 netfs_retry_read_subrequests fs/netfs/read_retry.c:62 [inline]
 netfs_retry_reads+0x1512/0x1d40 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x15a4/0x1d40 fs/netfs/read_retry.c:238
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
 netfs_unbuffered_read_iter_locked+0x12e1/0x19a0 fs/netfs/direct_read.c:221
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 __kernel_read+0x3f1/0xb50 fs/read_write.c:523
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_check+0xbd/0x100 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x8e/0x210 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1419/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe490f95c49
Code: d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8855d5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe490f95c49
RDX: 0000000000020842 RSI: 000000002000c380 RDI: 00000000ffffff9c
RBP: 00007fe490fdd570 R08: 00007fe490fdd5a0 R09: 00007fe490fdd5a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe490fdd4f5
R13: 0000000000000001 R14: 00007fe491010420 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x24/0x3c40 kernel/locking/lockdep.c:5077
Code: 90 90 90 90 90 90 41 57 41 56 41 89 f6 41 55 41 54 49 89 fc 55 89 d5 53 44 89 cb 48 81 ec f0 00 00 00 48 8b 84 24 28 01 00 00 <44> 89 04 24 48 c7 84 24 90 00 00 00 b3 8a b5 41 48 c7 84 24 98 00
RSP: 0018:ffffc9000308ff98 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8880b8644c58
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff905f7c97 R11: 0000000000000003 R12: ffff8880b8644c58
R13: ffff8880b8644c58 R14: 0000000000000000 R15: 0000000000000000
FS:  000055556c371480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000308ff88 CR3: 0000000078d02000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	41 57                	push   %r15
   8:	41 56                	push   %r14
   a:	41 89 f6             	mov    %esi,%r14d
   d:	41 55                	push   %r13
   f:	41 54                	push   %r12
  11:	49 89 fc             	mov    %rdi,%r12
  14:	55                   	push   %rbp
  15:	89 d5                	mov    %edx,%ebp
  17:	53                   	push   %rbx
  18:	44 89 cb             	mov    %r9d,%ebx
  1b:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  22:	48 8b 84 24 28 01 00 	mov    0x128(%rsp),%rax
  29:	00
* 2a:	44 89 04 24          	mov    %r8d,(%rsp) <-- trapping instruction
  2e:	48 c7 84 24 90 00 00 	movq   $0x41b58ab3,0x90(%rsp)
  35:	00 b3 8a b5 41
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	84 24 98             	test   %ah,(%rax,%rbx,4)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
