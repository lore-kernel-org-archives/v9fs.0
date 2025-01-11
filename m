Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2B1BBBCA
	for <v9fs@lists.linux.dev>; Sat, 11 Jan 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736632703; cv=none; b=a179TVyXHRBaQ6hJS10LmPg2tc8p4L0V45DTFzpZDYq3GJjGS9vQ4KFvdSotQUnJGjhECPl1FSrWhdEURcoJFKrksNfy5+dFwuXQJ/ppY/oTGRDk7bLi5VsHBmiuO4K+CB7RyiUeAPReo8zGsrMpPi9FRIku9nT9us6+zSR3lOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736632703; c=relaxed/simple;
	bh=HcPrOdBCxaG5phSngMErfHbiaEYdauRRQjfCqkk7wpU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X+FvG7fcMpsVgoxCthfZF2DWIpCc6oDh9dgVJyg9siCFmZHIJCHZOmhuUslweyfMzH//X+vzotdIQJLwP6SjWIAUHQtJUhJiWMjYec3UcGCsb8oMOK/7et4ycXBYl82T3wnncg8QTBQEAvQc+hRd3E+VtEz2V5tfthxjaVnAGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso27743755ab.1
        for <v9fs@lists.linux.dev>; Sat, 11 Jan 2025 13:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736632698; x=1737237498;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OkZKVlUm5d5mGaMq1XobPUxvdPA3LE0GIrafvm6uGQ=;
        b=TQjKLQViQ3+Kdfnlsr/zIcrGhqMT895Ebp54RRmvSyZclXfFJJ78OEgdqd/Tl7t/C/
         EHMqZenL01uFE1OeqtzsyH+0nOjSK4KcuiFNjNAEupeJt1pILccFLJ+r6GPoMRNlgmr0
         ZI4YOehX7PTnB79FPlXmab/w1QH/ksFa9nJLrWIN/IVGabCEjkB16Ib9o1hl6/PMswoa
         e8eUlDhtqzPW/HD83KCYCYtSwJG/JyuubnTQB1SHlq60BEX2bbDM0OO6Rxt4r8pNuh5e
         cPIcZcWTNhOaPV3SbsTbpFuMZ14tiCEDkzpx+Eo0gsSDzvb33yM5OfoFS4YBA5NXNtTt
         EA/A==
X-Forwarded-Encrypted: i=1; AJvYcCUa2gA3VK6bPEUy7mizf00lZBLcA06lWkkN7U2aWLHCUqBKLU/zwjx/cToKrKMpVFhoh/zU@lists.linux.dev
X-Gm-Message-State: AOJu0YxlRKugIJQCH1we0f3mWw7RscjzkG+kUfs3h8J+Dbes+3Dtzgph
	RR5N18tvEqbLB+cpCOXdsFTwo4ycnL2j1bYTvf+FMVT4bXLRbLoiUgg323a9HHYLBRWNA65p4n+
	cjdNQ9pw2C5g+cr94q8mWYMFazq8kfhJ9QX85i0dgmOGvb/nZRxeb4tI=
X-Google-Smtp-Source: AGHT+IEN/Nh1rDHnOIJRhHWfAF8m8MY5OgcDiXR2FAZxv3it4Bp4+QvJRyf2lgFpVi92/8C6fQ7IEsgKP9HGmj2NBUxtI6bPMF/H
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3ce3a90ef12mr115232355ab.2.1736632698592; Sat, 11 Jan 2025
 13:58:18 -0800 (PST)
Date: Sat, 11 Jan 2025 13:58:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6782e97a.050a0220.d0267.004b.GAE@google.com>
Subject: [syzbot] [v9fs?] BUG: stack guard page was hit in io_wq_worker
From: syzbot <syzbot+6f691675b0810bf591ec@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, ericvh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbfd64d25c7a Merge tag 'vfs-6.13-rc7.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101a0ef8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bdfbaac3fbb90d6
dashboard link: https://syzkaller.appspot.com/bug?extid=6f691675b0810bf591ec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e33edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11520dc4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-fbfd64d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/106ee8380ff0/vmlinux-fbfd64d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09437c87aa26/bzImage-fbfd64d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f691675b0810bf591ec@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc900034d7ff8 (stack is ffffc900034d8000..ffffc900034e0000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 5942 Comm: iou-wrk-5940 Not tainted 6.13.0-rc6-syzkaller-00036-gfbfd64d25c7a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kasan_check_range+0x19/0x1a0 mm/kasan/generic.c:188
Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 50 01 00 00 48 89 f8 41 54 44 0f b6 c2 48 01 f0 <55> 53 0f 82 c6 00 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 0f
RSP: 0018:ffffc900034d8000 EFLAGS: 00010082
RAX: ffffffff96e51cc8 RBX: 0000000000000021 RCX: ffffffff8175d18e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff96e51cc0
RBP: ffffc900034d8158 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff96e51daf R11: 000000000009dbe3 R12: ffff888025064880
R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff9200069b00a
FS:  000055556e7a2380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900034d7ff8 CR3: 00000000208ec000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 mark_lock+0xb5/0xc60 kernel/locking/lockdep.c:4727
 mark_usage kernel/locking/lockdep.c:4670 [inline]
 __lock_acquire+0x9f1/0x3c40 kernel/locking/lockdep.c:5180
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3a/0x310 mm/page_ext.c:525
 __set_page_owner+0x96/0x560 mm/page_owner.c:322
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
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
 p9_tag_alloc+0x21c/0x870 net/9p/client.c:300
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
 p9_client_flush.isra.0+0x1ff/0x420 net/9p/client.c:609
 p9_client_zc_rpc.constprop.0+0x7d2/0x880 net/9p/client.c:826
 p9_client_read_once+0x443/0x820 net/9p/client.c:1570
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
 v9fs_issue_read+0x115/0x340 fs/9p/vfs_addr.c:76
 netfs_retry_read_subrequests fs/netfs/read_retry.c:62 [inline]
 netfs_retry_reads+0x1508/0x1d40 fs/netfs/read_retry.c:234
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_retry_reads+0x159a/0x1d40 fs/netfs/read_retry.c:237
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:374
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:409
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
 netfs_unbuffered_read_iter_locked+0x12e1/0x19a0 fs/netfs/direct_read.c:221
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 io_iter_do_read io_uring/rw.c:770 [inline]
 __io_read+0x320/0x1190 io_uring/rw.c:869
 io_read+0x1e/0x70 io_uring/rw.c:947
 io_issue_sqe+0x175/0x1200 io_uring/io_uring.c:1740
 io_wq_submit_work+0x3fc/0xec0 io_uring/io_uring.c:1849
 io_worker_handle_work+0x4e5/0x1680 io_uring/io-wq.c:601
 io_wq_worker+0x33f/0xdf0 io_uring/io-wq.c:655
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_check_range+0x19/0x1a0 mm/kasan/generic.c:188
Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 50 01 00 00 48 89 f8 41 54 44 0f b6 c2 48 01 f0 <55> 53 0f 82 c6 00 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 0f
RSP: 0018:ffffc900034d8000 EFLAGS: 00010082
RAX: ffffffff96e51cc8 RBX: 0000000000000021 RCX: ffffffff8175d18e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff96e51cc0
RBP: ffffc900034d8158 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff96e51daf R11: 000000000009dbe3 R12: ffff888025064880
R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff9200069b00a
FS:  000055556e7a2380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900034d7ff8 CR3: 00000000208ec000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	66 0f 1f 00          	nopw   (%rax)
  15:	48 85 f6             	test   %rsi,%rsi
  18:	0f 84 50 01 00 00    	je     0x16e
  1e:	48 89 f8             	mov    %rdi,%rax
  21:	41 54                	push   %r12
  23:	44 0f b6 c2          	movzbl %dl,%r8d
  27:	48 01 f0             	add    %rsi,%rax
* 2a:	55                   	push   %rbp <-- trapping instruction
  2b:	53                   	push   %rbx
  2c:	0f 82 c6 00 00 00    	jb     0xf8
  32:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
  39:	7f ff ff
  3c:	48 39 f8             	cmp    %rdi,%rax
  3f:	0f                   	.byte 0xf


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
