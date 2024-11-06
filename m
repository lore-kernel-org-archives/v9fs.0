Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929531F9ABD
	for <v9fs@lists.linux.dev>; Wed,  6 Nov 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902107; cv=none; b=Sdqhkoa7Q3ZCNH/PnVs5Y2whNFpGUr100g89w2twgV8vsRgY12mSx9jcFAWfEHPm3L72H9WxYQMmgPfQkbU9azO0jWbzY8hYdzsahOdr6oYFeFQC8op4EXkJ0OWOFM39ohlgMIpBHU7/2JF64P+BphP3W3jZc0vD8+4nOroTxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902107; c=relaxed/simple;
	bh=mEgEXo6jI3RqGdpuK5lv/1GcybwqCzhnoE/PzpIRa68=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DRIeCqIiICrtT9vTIGYJFIl0Xt6/4ISrAfLyFM5jYk6yzG2eLdQoxmHlCEIdBNvS/k88RemUYvzJeOi/bkqP6g50V82HEj81YjV+fS7Gf9qlwc1rTl0ywBVYUg4NDp/F6sTl9Ciw5laEc4iBQ+W/PwO6bGK9VNlU0AnX954+3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abb901672so698793639f.3
        for <v9fs@lists.linux.dev>; Wed, 06 Nov 2024 06:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730902105; x=1731506905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xm6/+J8DMdyOJ6n3vMWjWOGl6q+2CvhCVd5gU5P+xCo=;
        b=mcmbKEHTU1Wx4kM+XI3i2VqU2T6c/E13J0Xip4eUx4cVmba3HqPYBWouT36zxDba55
         XrRrOCgfxe8JvRJa9r7fmGxzy3scseg1qMX1dDoR5eXdkvQFV1wm8FGQEXCN34g1QOJ7
         nqXnFVbEhqslmFR8KuXZWP/UkYGZ7VYxlgtdOL/tKBMhAhg4/SUxamrwywZN+nAWnOvp
         Sd0cWu9BqbDpEUQArMsK3OQ96YDWNj+0yVmF/HkK++SuIz2wTOS7rrUgWAOgYe6qOof6
         0m42BDW6x+IXkniGGFu3RRnxal6HV/0QU+Kez/LsG/wnDueI0RGjw9ex/EB1Es51dkJE
         cCIw==
X-Forwarded-Encrypted: i=1; AJvYcCV91gc/s4JuXp4JpB3elcyXlmXA797q8s6jojx6zQoMWBg3jRo33iLB7/u4vOQecfM561B3@lists.linux.dev
X-Gm-Message-State: AOJu0YxBuwIeRC/dcBeSkPLfR10ZuAIkyo//Xl//N46tZqWpowBz+1Tb
	FPjRwpqrGlLsduWXQ5/YlUMPL/lVX0UgAm4Qc2gyMe+DRrB0wpTKwDx9+lx7q1/baWHNa7PAgGr
	uFKORI5wPzcjGpU8H1Ca3HTovrpp/pu3eyjhALHOG8AsG77s0WEaT+gU=
X-Google-Smtp-Source: AGHT+IHVHngzvT3q7Roth4c2HBRTjPBHVicqMnol/OiJOBj8V6RoiMQ3qLiqL66ZZteAdwDrXThZoVa2fS18pOuVkiaJ5MoJefD0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6b25813e9mr210799945ab.2.1730902104867; Wed, 06 Nov 2024
 06:08:24 -0800 (PST)
Date: Wed, 06 Nov 2024 06:08:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b7858.050a0220.350062.0256.GAE@google.com>
Subject: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164f56a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cf8e30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a27587980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6887ff647109/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/958ab0c29314/bzImage-2e1b3cc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000482ff48 (stack is ffffc90004830000..ffffc90004838000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 6237 Comm: syz-executor663 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 c0 4d 7a
RSP: 0018:ffffc9000482ff50 EFLAGS: 00010086
RAX: 000000000000000c RBX: ffff8880306c2fba RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffff8880306c2f98 RDI: ffff8880306c2440
RBP: ffffc90004830088 R08: 0000000000000000 R09: 0000000000000006
R10: ffffffff96e2dd27 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880306c2f98 R14: 0000000000000008 R15: ffff8880306c2440
FS:  00007fedf3b6e6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000482ff48 CR3: 000000002c910000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 mark_usage kernel/locking/lockdep.c:4646 [inline]
 __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x123/0x1880 mm/slub.c:3695
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4141
 radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
 idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
 idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
 idr_alloc+0xc1/0x130 lib/idr.c:87
 p9_tag_alloc+0x394/0x870 net/9p/client.c:321
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
 p9_client_read_once+0x443/0x820 net/9p/client.c:1570
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
 v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
 netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
 netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
 netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
 vfs_readv+0x4cf/0x890 fs/read_write.c:1025
 do_preadv fs/read_write.c:1142 [inline]
 __do_sys_preadv fs/read_write.c:1192 [inline]
 __se_sys_preadv fs/read_write.c:1187 [inline]
 __x64_sys_preadv+0x22d/0x310 fs/read_write.c:1187
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedf3bd4dd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedf3b6e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007fedf3c5e318 RCX: 00007fedf3bd4dd9
RDX: 0000000000000001 RSI: 00000000200015c0 RDI: 0000000000000003
RBP: 00007fedf3c5e310 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fedf3c5e31c
R13: 000000000000000b R14: 00007fffe9d355b0 R15: 00007fffe9d35698
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 c0 4d 7a
RSP: 0018:ffffc9000482ff50 EFLAGS: 00010086
RAX: 000000000000000c RBX: ffff8880306c2fba RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffff8880306c2f98 RDI: ffff8880306c2440
RBP: ffffc90004830088 R08: 0000000000000000 R09: 0000000000000006
R10: ffffffff96e2dd27 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880306c2f98 R14: 0000000000000008 R15: ffff8880306c2440
FS:  00007fedf3b6e6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000482ff48 CR3: 000000002c910000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	55                   	push   %rbp
   6:	48 89 e5             	mov    %rsp,%rbp
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 89 d6             	mov    %edx,%r14d
  10:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  17:	fc ff df
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  23:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
* 2a:	48 c7 44 24 30 b3 8a 	movq   $0x41b58ab3,0x30(%rsp) <-- trapping instruction
  31:	b5 41
  33:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
  38:	48                   	rex.W
  39:	c7                   	.byte 0xc7
  3a:	44 24 38             	rex.R and $0x38,%al
  3d:	c0                   	.byte 0xc0
  3e:	4d                   	rex.WRB
  3f:	7a                   	.byte 0x7a


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
