Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7E1B87DB
	for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391768; cv=none; b=n8djq7fCpkYgMoYJWtdnfjLMUsvszo4CBBEHkuiyGLXVWKaYWNeoleVX7j50iw9OPjdBc+ejXhAk7bzO+DzF3/JTQQDUByqJoHDE3icezQcP+hyzuumbVaUPVeuucHm/chDgIXki96EOtLCClYENOI4zkcl80GemaH/cFOHNXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391768; c=relaxed/simple;
	bh=NKzMXIvPOGPefliANuEFXjZNLdD355Tc9mQYVxX5FCk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K7b/OJeo8a2tqD+1M6atgTJ6TD6UtYfNkYkENXKYZRtL3jDJq6dHp2R4btI6l2aQj+OBwfQULBRPUyoOIlgGS/I9Crnq3vEv1EBF77KQYH91sfXx62k5YERs3t8+3y10Uw/J/Tl+Xurr2kToXQ9lIJvXgR3XxTxNaHB6ZSa/gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce848eae40so68588985ab.2
        for <v9fs@lists.linux.dev>; Mon, 20 Jan 2025 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391766; x=1737996566;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcqlhkaZN3uZJpo5iLIcVNHQ+wqjRKLuUC5cTvA+G3s=;
        b=IhteSubH/q8TsI2lQI4bn+P/AB5ZPUAxti+lsKMUta5PkSwOcVQh4o42kiYxjsoSa5
         eFDuIdT3QlIthHq6VyUEjX23myVmYLzse4yZpWBdpll8ARjs3w9UDPaFbxuIwUpK4+kb
         JkaNUNxM41IVW+AwxlZPsp9P8dKPo4KbMuKaiDUZTI1Hr8JDHfHc029YF6eOzvWtnG6e
         h8W2jia4r/c5broaKZdcqb4TOnQLTO4omTmxHL+90kD1oDi5EvWC/mcEy1oabAoQTSXk
         63c8xu690oxVm3pEAJOufJkweXyHcIgSSVLji4wSt97TaWzgL6Km4F9kx3m8h46bFArq
         3Tog==
X-Forwarded-Encrypted: i=1; AJvYcCVLnzyy5v5ZN7IiiCCBlyxHCxOa/WUDeMFBcu8JE1TY8Zmo7Wfzg/M5kyjNacHEiBOJxv4m@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpy+SAJ6KQ26B/RqhAT6uLa6zqLOqFskQnmbSeyzyTRusvdnIn
	/berzwChG7oZwl4ybCLFXjVfS7qdr2m7FrdLUrEvi2uoaCPtzBv/XXcSFyePDZacbbWSCYJ66fh
	15fc5TPolv3VkZc7f93bghoKOjpg13vPFCUVlLCnc91NWiiXzFDXXdUA=
X-Google-Smtp-Source: AGHT+IE7bnU/xT3mgqJSk9AkJwTIL3ipBfzp4HBWUw7xCdjgwTPKiwZx4tpwVrrQQVZMumoKA5FFx/4f7TYS7gNK5tbJiS9k2awf
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c3:b0:3a7:9347:544c with SMTP id
 e9e14a558f8ab-3cf743ba928mr113067335ab.5.1737391765878; Mon, 20 Jan 2025
 08:49:25 -0800 (PST)
Date: Mon, 20 Jan 2025 08:49:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e7e95.050a0220.303755.007d.GAE@google.com>
Subject: [syzbot] [v9fs?] BUG: stack guard page was hit in loop_process_work
From: syzbot <syzbot+1fc139801105ed807f06@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, ericvh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    619f0b6fad52 Merge tag 'seccomp-v6.13-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bbfcb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e182416a4b418f
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc139801105ed807f06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-619f0b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc1185951a22/vmlinux-619f0b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f614d80b6c2/bzImage-619f0b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fc139801105ed807f06@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc900001dffc8 (stack is ffffc900001e0000..ffffc900001e8000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 12 Comm: kworker/u32:1 Not tainted 6.13.0-rc7-syzkaller-00043-g619f0b6fad52 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop8 loop_workfn
RIP: 0010:mark_lock+0xb0/0xc60 kernel/locking/lockdep.c:4727
Code: fe 09 0f 87 e3 00 00 00 41 83 fe 08 49 89 fc 48 89 f3 0f 84 97 00 00 00 41 bd 01 00 00 00 44 89 f1 41 d3 e5 4d 63 ed 48 89 df <e8> 1b 6b ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 60 48 89 f9
RSP: 0018:ffffc900001dffd0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff88801ca953d8 RCX: 0000000000000004
RDX: 0000000000000002 RSI: ffff88801ca953d8 RDI: ffff88801ca953d8
RBP: ffffc900001e0108 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff969b9e27 R11: 00000000000254be R12: ffff88801ca94880
R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff9200003c000
FS:  0000000000000000(0000) GS:ffff88802b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900001dffc8 CR3: 0000000058ec0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 mark_usage kernel/locking/lockdep.c:4670 [inline]
 __lock_acquire+0x9f1/0x3c40 kernel/locking/lockdep.c:5180
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3a/0x310 mm/page_ext.c:525
 __set_page_owner+0x9a/0x790 mm/page_owner.c:322
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2de/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 p9_fcall_init+0x97/0x260 net/9p/client.c:233
 p9_tag_alloc+0x17a/0x870 net/9p/client.c:298
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
 p9_client_read_once+0x443/0x820 net/9p/client.c:1570
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
 lo_rw_aio.isra.0+0x90a/0xcc0 drivers/block/loop.c:470
 do_req_filebacked drivers/block/loop.c:514 [inline]
 loop_handle_cmd drivers/block/loop.c:1909 [inline]
 loop_process_work+0xa65/0x2000 drivers/block/loop.c:1944
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mark_lock+0xb0/0xc60 kernel/locking/lockdep.c:4727
Code: fe 09 0f 87 e3 00 00 00 41 83 fe 08 49 89 fc 48 89 f3 0f 84 97 00 00 00 41 bd 01 00 00 00 44 89 f1 41 d3 e5 4d 63 ed 48 89 df <e8> 1b 6b ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 60 48 89 f9
RSP: 0018:ffffc900001dffd0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff88801ca953d8 RCX: 0000000000000004
RDX: 0000000000000002 RSI: ffff88801ca953d8 RDI: ffff88801ca953d8
RBP: ffffc900001e0108 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff969b9e27 R11: 00000000000254be R12: ffff88801ca94880
R13: 0000000000000200 R14: 0000000000000009 R15: 1ffff9200003c000
FS:  0000000000000000(0000) GS:ffff88802b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900001dffc8 CR3: 0000000058ec0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fe 09                	decb   (%rcx)
   2:	0f 87 e3 00 00 00    	ja     0xeb
   8:	41 83 fe 08          	cmp    $0x8,%r14d
   c:	49 89 fc             	mov    %rdi,%r12
   f:	48 89 f3             	mov    %rsi,%rbx
  12:	0f 84 97 00 00 00    	je     0xaf
  18:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  1e:	44 89 f1             	mov    %r14d,%ecx
  21:	41 d3 e5             	shl    %cl,%r13d
  24:	4d 63 ed             	movslq %r13d,%r13
  27:	48 89 df             	mov    %rbx,%rdi
* 2a:	e8 1b 6b ff ff       	call   0xffff6b4a <-- trapping instruction
  2f:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  36:	fc ff df
  39:	48 8d 78 60          	lea    0x60(%rax),%rdi
  3d:	48 89 f9             	mov    %rdi,%rcx


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
