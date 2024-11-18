Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D21A9B4A
	for <v9fs@lists.linux.dev>; Mon, 18 Nov 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947765; cv=none; b=PZ2kmhDLSRTCfXPFiieOAocKcnfnGiM8zFcyNn49eN7OSgf+iwEf/tgwC5ccRmZxaTgHVutxlZS1ZbOevhiDNRW3m1n3qpZOERYGvio6ftzxaZIYsGyklrTDRWgUlk/Drk1rpH/djEau7dWHpUMipaGABDV9dNsOCuVq/vYYYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947765; c=relaxed/simple;
	bh=bCE59yqbsa4YSa+goCd4obZaV+Ry2vSifSrYQMVyGTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oERRQL7BYkWTzKAZfuKFVld8THKNq/eZGgBAayQ0GpUfAPDN47CWCyd7Tc7ZKr1/rcHevS5/NCDkOJDQErMYi7Mj9Kw+vt1pwlY83g6G6GGPvxtAreK+2/GB5AybCafu3cK7m3d+o5YUroxuftTSvsneTVkQyfa7spfCGyE6yhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7642d452dso12733245ab.1
        for <v9fs@lists.linux.dev>; Mon, 18 Nov 2024 08:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947763; x=1732552563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8AJ4XbjzD3EsOHV7pa4sjS6AZRvhnAFfDyspYKkyvw=;
        b=Ct1bsrX+0JuaTOA4aXokR9jihv3C622GeUih6Y2RrIlVQZU2tUdprj4fFvO73yG5cG
         WtuebblpGv+Yk61dQ6pMnzKyzY1MF5fNj/bfSamnWekJUuaGG8qly65CNb4Bhh7Fx14H
         igg25f+U9Too/EHkR6JowSq95hHmhYyL8ZomeqmLGNCCoMw5A07WabHVBZess7w8IKEo
         1/8BhYufCAfC4djy8ELBcXy1aTFSepgzL0hSFenTfTLwH7KWhk6bqcWloruvyprIBssA
         bJV6slRb8isJ1VNjKrK1NBsMnl90Ctc+VfjR3bJzFf6mw1EosZo59H0G1G+JfmpKzAsw
         Md1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxrwXvNrf4oRvwfM9iL4FjsPZM7T+WUrkPvesXOnd8ldJgKuAuJgFk5dVL1ivrK1mOo+K3@lists.linux.dev
X-Gm-Message-State: AOJu0YzYrpZL7Sdqabt6YHkmndZ10GNemw1fS4FqzCPt1okrXquP4XPH
	CREox0Bla4/mVXAfVm6lrD0m7ikQYo5aj61A6hDybzY8oEhOwFKExz28bsTf26FGkll/QP1zzit
	QnTRqjKfIPhUVVIEzBrDKwR5eh0LyJ8DW8HucsMri1pCWhgCfZygRCHs=
X-Google-Smtp-Source: AGHT+IGxp1zYNQU3z94f5pPzojEdMjCcrw6uv3/3JhCJlchlnSJstpZ9yLFryMMSVvUUHHuDc6rS+H2VMShI+Uha2Xl36F8sOvhZ
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3a7:6467:2e0b with SMTP id
 e9e14a558f8ab-3a7772569aamr448485ab.0.1731947763204; Mon, 18 Nov 2024
 08:36:03 -0800 (PST)
Date: Mon, 18 Nov 2024 08:36:03 -0800
In-Reply-To: <941062.1731947033@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b6cf3.050a0220.87769.004c.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, dhowells@redhat.com, 
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in netfs_retry_reads

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff81670f76>] prepare_to_wait+0xa6/0x380 kernel/sched/wait.c:237
WARNING: CPU: 2 PID: 6504 at kernel/sched/core.c:8576 __might_sleep+0x117/0x170 kernel/sched/core.c:8576
Modules linked in:
CPU: 2 UID: 0 PID: 6504 Comm: syz.0.19 Not tainted 6.12.0-rc6-syzkaller-gaf01434f267f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__might_sleep+0x117/0x170 kernel/sched/core.c:8576
Code: 49 8d bc 24 68 17 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 75 38 49 8b 94 24 68 17 00 00 48 c7 c7 40 49 6c 8b e8 ba 41 f2 ff 90 <0f> 0b 90 90 e9 70 ff ff ff e8 fb d9 92 00 e9 1e ff ff ff 89 34 24
RSP: 0018:ffffc90003a5eb48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8b83c8e0 RCX: ffffffff814e6e79
RDX: ffff888023afc880 RSI: ffffffff814e6e86 RDI: 0000000000000001
RBP: 0000000000000049 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888023afc880
R13: 0000000000000000 R14: 1ffff9200074bd83 R15: ffff88803ea60700
FS:  00007f803b8a96c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005635a9d4bc60 CR3: 0000000031d88000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wait_on_bit include/linux/wait_bit.h:73 [inline]
 netfs_retry_reads+0xe4/0x1dc0 fs/netfs/read_retry.c:263
 netfs_collect_read_results fs/netfs/read_collect.c:333 [inline]
 netfs_read_collection+0x2990/0x3bb0 fs/netfs/read_collect.c:414
 netfs_wait_for_read+0x1e6/0x440 fs/netfs/read_collect.c:629
 netfs_unbuffered_read fs/netfs/direct_read.c:156 [inline]
 netfs_unbuffered_read_iter_locked+0x1247/0x1860 fs/netfs/direct_read.c:231
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:266
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 __kernel_read+0x3f1/0xb50 fs/read_write.c:527
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x8e/0x210 security/security.c:3129
 do_open fs/namei.c:3776 [inline]
 path_openat+0x1419/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f803ab7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f803b8a9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f803ad35f80 RCX: 00007f803ab7e719
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007f803abf175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f803ad35f80 R15: 00007fff5dc85c38
 </TASK>


Tested on:

commit:         af01434f rxrpc: Fix missing locking causing hanging ca..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=11796ac0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
