Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10C1487D1
	for <v9fs@lists.linux.dev>; Mon, 13 May 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590804; cv=none; b=JujbG1QGUxTMouawBOxAOIzbTIw9eO4yDbhEbXnrIqWhuJjHoSzq98/CKRQjmok/Ne2mqoS0U/FPG0ul4WDUcPIoOdHBQ371sHlKtrk71YUDUaRb2QI8giEhuHr3HgzeGbN8hH0LscmZZM9Jpi326ddVUldKLx5+QfYdic3MceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590804; c=relaxed/simple;
	bh=BOh/6eYqpb1Ud8ocZQbqlut1M6k+C6KJVsqR6apXKXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kdOsBVEBIQHIUbZCNJiJfOvwks5Ir99RQfqqp7VtW6eXlZxL6WX4uWkBjuVi9z+k0xUY9Zp6oSjpiG3bTI+LEKszIxvVOQf8O4CI38f6BNJyHGdGRtxw1F9eovSQbRBHcjcg9gR3ankqD5nOhbPCF6oWB87f3kuxOznxLTkjwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCBgmwbK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCBgmwbK"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3322573a12.2
        for <v9fs@lists.linux.dev>; Mon, 13 May 2024 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715590802; x=1716195602; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXCYNDZ+8EZq/bdSREbHXfPWWwh6PcqPDhCII/e8SHs=;
        b=dCBgmwbK7ZQ9cr8Cvqw5Tk3lEOSeFSTPllXTjvf1eL5gW5sShj63NT6kwTpZWHpQ6H
         TdDL5q2JIzOAC9qVEs7PYY0DDpNOWgAFpAcQ/p49eIqcedFqPd8quev3CMGDYt6DV0h4
         kcJD976giw4OIo76xS2460OkF24Xzy0dW08D79/rho9Mj+MrW+QFqpGSkbr7J+2d+FZI
         LqWMdNyyULB1vd3dhHeSxE/1hJJ7xTP/vM6klPI0z/1HFqy2TsZNUQEMXTmZfPcg0pt0
         4glKbfhD+uzqSTWINa78RnyHgjl1QSTeE9QqUyCKoPggqLpsaHpqG609UUQZcvWWXGPz
         A24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590802; x=1716195602;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXCYNDZ+8EZq/bdSREbHXfPWWwh6PcqPDhCII/e8SHs=;
        b=LK0CnHr/VfkMr9c3RMz98PbYcPOV4zFHRCVrT20aeE1UGVKYuR3qq6hr6sInHJoA4b
         VIC23ndWT2kytuCd7zPKgq80U9MHQfxb1aoJJqSP+6WOrHVslZZV7eaKOu1L+2aXIrr6
         6clMYs9MXm+Pgk1Iiu9ymKttEnCWQPhHDrUZSszgvzuAnLxp+dTEY3hlFpevtVp7V2O0
         70zLXegmJg2GoALcNcPd30kjlsmh/GklxuuwoXJ3Viv4BOgNJoahbeggsttfn5o9O9fT
         3cmvQN+pUSrLpOcS85FX7XPDzs0ycB3PbejStGuqXDSfPRI4+00w6v2GJVS3C4MIw9gT
         M5yw==
X-Forwarded-Encrypted: i=1; AJvYcCUjtKnT54ZEBpfYg5spYz4gsDgUau8DPbDH0ZKDEG6fTCxBGebkH4I15s9zc3gvMUQ2mmGL5JuF+2OK0DD8RxE9yv/icQ==
X-Gm-Message-State: AOJu0YyATBcwz2zO9aiRWWw71V6JGoP2pWSc6zGit193rG5LptfKuVRi
	nlFN0MIksShd4Jo47IZ9w6d8yG7DQ9GCtkOtZLw2pRpWB3E2B+hjq2wkucwMkKjmq539M2zMzno
	dBfQ8XB9hy3GW0HzNy2zfINEQ+4A=
X-Google-Smtp-Source: AGHT+IGZGi8cF1I6eJHVIIseG8p8cLIS1+Ucoke4KMlATiFwAl1MyB3eOQ4wOX3ZjkRhvucLfiY9poYx6YxfHfUcwrQ=
X-Received: by 2002:a05:6a20:72a5:b0:1a7:59b5:4276 with SMTP id
 adf61e73a8af0-1afde1df5b2mr9123007637.54.1715590801762; Mon, 13 May 2024
 02:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Mon, 13 May 2024 16:59:50 +0800
Message-ID: <CABOYnLyFSHNg7Sq+vsJr=P-8ydMEf1M+KCFMvufPS6z09UiupA@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_client_destroy
To: syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello, I found a reproducer for this bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance
git tree: upstream f4345f05c0dfc73c617e66f3b809edb8ddd41075
console output: https://syzkaller.appspot.com/x/log.txt?x=122bfdb8980000
kernel config: https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=1527696d41a634cc1819
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Since, this maybe a concurrency bug, we need run the PoC for a while,
like ./syz-execprog -repeat 0 ../prog1 for 5 minus.
[ 1073.122493][T289310] 9pnet: Found fid 1 not clunked
[ 1073.123673][T107993]
==================================================================
[ 1073.124336][T107993] BUG: KASAN: slab-use-after-free in
__lock_acquire+0x78/0x1fd0
[ 1073.124965][T107993] Read of size 8 at addr ffff888179f5c048 by
task kworker/u18:0/107993
[ 1073.125609][T107993]
[ 1073.125814][T107993] CPU: 0 PID: 107993 Comm: kworker/u18:0 Not
tainted 6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 1073.126599][T107993] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1073.127402][T107993] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 1073.128037][T107993] Call Trace:
[ 1073.128315][T107993]  <TASK>
[ 1073.128563][T107993]  dump_stack_lvl+0x250/0x380
[ 1073.128959][T107993]  ? __pfx_dump_stack_lvl+0x10/0x10
[ 1073.129383][T107993]  ? __pfx__printk+0x10/0x10
[ 1073.129749][T107993]  ? _printk+0xda/0x120
[ 1073.130097][T107993]  ? __virt_addr_valid+0x19b/0x580
[ 1073.130628][T107993]  ? __virt_addr_valid+0x19b/0x580
[ 1073.131239][T107993]  print_report+0x169/0x550
[ 1073.131590][T289310] 9pnet: Tag 0 still in use
[ 1073.131756][T107993]  ? __virt_addr_valid+0x19b/0x580
[ 1073.132258][T289310] 9pnet: Packet with tag 0 has still references
[ 1073.132657][T107993]  ? __virt_addr_valid+0x19b/0x580
[ 1073.133576][T107993]  ? __virt_addr_valid+0x4a8/0x580
[ 1073.133994][T107993]  ? __phys_addr+0xc3/0x180
[ 1073.134368][T107993]  ? __lock_acquire+0x78/0x1fd0
[ 1073.134763][T107993]  kasan_report+0x143/0x180
[ 1073.135136][T107993]  ? __lock_acquire+0x78/0x1fd0
[ 1073.135567][T107993]  __lock_acquire+0x78/0x1fd0
[ 1073.135963][T107993]  ? p9_client_prepare_req+0x9fb/0xe50
[ 1073.136402][T107993]  ? p9pdu_vwritef+0x145/0x2a40
[ 1073.136799][T107993]  ? __pfx_p9pdu_writef+0x10/0x10
[ 1073.137206][T107993]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 1073.137692][T107993]  lock_acquire+0x1ed/0x550
[ 1073.138059][T107993]  ? p9_fd_request+0x55/0x530
[ 1073.138444][T107993]  ? __pfx_lock_acquire+0x10/0x10
[ 1073.138852][T107993]  ? __pfx_p9_client_prepare_req+0x10/0x10
[ 1073.139322][T107993]  ? kasan_save_track+0x3f/0x80
[ 1073.139765][T107993]  _raw_spin_lock+0x2e/0x40
[ 1073.140139][T107993]  ? p9_fd_request+0x55/0x530
[ 1073.140520][T107993]  p9_fd_request+0x55/0x530
[ 1073.140892][T107993]  p9_client_rpc+0x30e/0xaf0
[ 1073.141281][T107993]  ? v9fs_free_request+0x7f/0xf0
[ 1073.141687][T107993]  ? __pfx_p9_client_rpc+0x10/0x10
[ 1073.142105][T107993]  ? netfs_free_request+0x1ff/0x630
[ 1073.142533][T107993]  ? __pfx_lock_release+0x10/0x10
[ 1073.142941][T107993]  ? do_raw_spin_lock+0x14f/0x370
[ 1073.143355][T107993]  p9_client_clunk+0x7a/0x280
[ 1073.143785][T107993]  ? __pfx_v9fs_free_request+0x10/0x10
[ 1073.144211][T107993]  netfs_free_request+0x259/0x630
[ 1073.144615][T107993]  ? netfs_free_subrequest+0x26f/0x420
[ 1073.145050][T107993]  v9fs_upload_to_server_worker+0x211/0x400
[ 1073.145525][T107993]  ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 1073.146032][T107993]  ? process_scheduled_works+0x93a/0x1840
[ 1073.146496][T107993]  process_scheduled_works+0xa39/0x1840
[ 1073.146953][T107993]  ? __pfx_process_scheduled_works+0x10/0x10
[ 1073.147435][T107993]  ? assign_work+0x3b7/0x430
[ 1073.147853][T107993]  worker_thread+0x89c/0xdc0
[ 1073.148233][T107993]  ? __kthread_parkme+0x172/0x1d0
[ 1073.148641][T107993]  kthread+0x310/0x3b0
[ 1073.148979][T107993]  ? __pfx_worker_thread+0x10/0x10
[ 1073.149388][T107993]  ? __pfx_kthread+0x10/0x10
[ 1073.149753][T107993]  ret_from_fork+0x52/0x80
[ 1073.150122][T107993]  ? __pfx_kthread+0x10/0x10
[ 1073.150537][T107993]  ret_from_fork_asm+0x1a/0x30
[ 1073.151154][T107993]  </TASK>
[ 1073.151512][T107993]
[ 1073.151750][T107993] Allocated by task 320544:
[ 1073.152173][T107993]  kasan_save_track+0x3f/0x80
[ 1073.152558][T107993]  __kasan_kmalloc+0x98/0xb0
[ 1073.152932][T107993]  kmalloc_trace+0x1db/0x370
[ 1073.153306][T107993]  p9_fd_create+0x180/0x540
[ 1073.153674][T107993]  p9_client_create+0x873/0x1080
[ 1073.154075][T107993]  v9fs_session_init+0x1e9/0x1bf0
[ 1073.154482][T107993]  v9fs_mount+0xd9/0xb10
[ 1073.154830][T107993]  legacy_get_tree+0xff/0x1b0
[ 1073.155210][T107993]  vfs_get_tree+0x97/0x2c0
[ 1073.155620][T107993]  do_new_mount+0x2e1/0xb90
[ 1073.156001][T107993]  __se_sys_mount+0x362/0x3d0
[ 1073.156382][T107993]  do_syscall_64+0xf5/0x240
[ 1073.156755][T107993]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1073.157230][T107993]
[ 1073.157428][T107993] Freed by task 289310:
[ 1073.157761][T107993]  kasan_save_track+0x3f/0x80
[ 1073.158143][T107993]  kasan_save_free_info+0x40/0x50
[ 1073.158554][T107993]  poison_slab_object+0xa6/0xe0
[ 1073.158948][T107993]  __kasan_slab_free+0x37/0x60
[ 1073.159336][T107993]  kfree+0x153/0x3b0
[ 1073.159708][T107993]  p9_client_destroy+0xd1/0x6b0
[ 1073.160106][T107993]  v9fs_session_close+0x5b/0x220
[ 1073.160511][T107993]  v9fs_kill_super+0x61/0x90
[ 1073.160888][T107993]  deactivate_locked_super+0xcb/0x140
[ 1073.161325][T107993]  cleanup_mnt+0x444/0x4e0
[ 1073.161693][T107993]  task_work_run+0x25c/0x320
[ 1073.162068][T107993]  syscall_exit_to_user_mode+0x168/0x370
[ 1073.162524][T107993]  do_syscall_64+0x102/0x240
[ 1073.162905][T107993]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1073.163376][T107993]
[ 1073.163616][T107993] Last potentially related work creation:
[ 1073.164068][T107993]  kasan_save_stack+0x3f/0x60
[ 1073.164452][T107993]  __kasan_record_aux_stack+0xac/0xc0
[ 1073.164886][T107993]  insert_work+0x43/0x340
[ 1073.165241][T107993]  __queue_work+0xc91/0xf70
[ 1073.165608][T107993]  queue_work_on+0x158/0x260
[ 1073.165982][T107993]  p9_poll_workfn+0x3c5/0x600
[ 1073.166362][T107993]  process_scheduled_works+0xa39/0x1840
[ 1073.166802][T107993]  worker_thread+0x89c/0xdc0
[ 1073.167174][T107993]  kthread+0x310/0x3b0
[ 1073.167531][T107993]  ret_from_fork+0x52/0x80
[ 1073.167925][T107993]  ret_from_fork_asm+0x1a/0x30
[ 1073.168314][T107993]
[ 1073.168511][T107993] Second to last potentially related work creation:
[ 1073.169030][T107993]  kasan_save_stack+0x3f/0x60
[ 1073.169409][T107993]  __kasan_record_aux_stack+0xac/0xc0
[ 1073.169843][T107993]  insert_work+0x43/0x340
[ 1073.170198][T107993]  __queue_work+0xc91/0xf70
[ 1073.170567][T107993]  queue_work_on+0x158/0x260
[ 1073.170936][T107993]  p9_fd_request+0x2ee/0x530
[ 1073.171309][T107993]  p9_client_rpc+0x30e/0xaf0
[ 1073.171725][T107993]  p9_client_write+0x334/0x7f0
[ 1073.172114][T107993]  v9fs_upload_to_server_worker+0x1ca/0x400
[ 1073.172588][T107993]  process_scheduled_works+0xa39/0x1840
[ 1073.173034][T107993]  worker_thread+0x89c/0xdc0
[ 1073.173409][T107993]  kthread+0x310/0x3b0
[ 1073.173740][T107993]  ret_from_fork+0x52/0x80
[ 1073.174106][T107993]  ret_from_fork_asm+0x1a/0x30
[ 1073.174492][T107993]
[ 1073.174689][T107993] The buggy address belongs to the object at
ffff888179f5c000
[ 1073.174689][T107993]  which belongs to the cache kmalloc-1k of size 1024
[ 1073.175820][T107993] The buggy address is located 72 bytes inside of
[ 1073.175820][T107993]  freed 1024-byte region [ffff888179f5c000,
ffff888179f5c400)
[ 1073.176897][T107993]
[ 1073.177094][T107993] The buggy address belongs to the physical page:
[ 1073.177600][T107993] page: refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x179f58
[ 1073.178297][T107993] head: order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[ 1073.178887][T107993] flags:
0x57ff00000000840(slab|head|node=1|zone=2|lastcpupid=0x7ff)
[ 1073.179546][T107993] page_type: 0xffffffff()
[ 1073.179917][T107993] raw: 057ff00000000840 ffff8880150430c0
ffffea000565d610 ffffea0005eb9410
[ 1073.180593][T107993] raw: 0000000000000000 00000000000a000a
00000001ffffffff 0000000000000000
[ 1073.181272][T107993] head: 057ff00000000840 ffff8880150430c0
ffffea000565d610 ffffea0005eb9410
[ 1073.181995][T107993] head: 0000000000000000 00000000000a000a
00000001ffffffff 0000000000000000
[ 1073.182670][T107993] head: 057ff00000000003 ffffea0005e7d601
ffffea0005e7d648 00000000ffffffff
[ 1073.183343][T107993] head: 0000000800000000 0000000000000000
00000000ffffffff 0000000000000000
[ 1073.184063][T107993] page dumped because: kasan: bad access detected
[ 1073.184570][T107993] page_owner tracks the page as allocated
[ 1073.185018][T107993] page last allocated via order 3, migratetype
Unmovable, gfp_mask
0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GF9
[ 1073.186576][T107993]  post_alloc_hook+0x1ea/0x210
[ 1073.186957][T107993]  get_page_from_freelist+0x3410/0x35b0
[ 1073.187395][T107993]  __alloc_pages+0x256/0x6c0
[ 1073.187820][T107993]  alloc_slab_page+0x5f/0x160
[ 1073.188197][T107993]  new_slab+0x84/0x2f0
[ 1073.188526][T107993]  ___slab_alloc+0xc73/0x1260
[ 1073.188906][T107993]  __kmalloc_node_track_caller+0x2d6/0x4f0
[ 1073.189371][T107993]  kmalloc_reserve+0x11b/0x290
[ 1073.189764][T107993]  __alloc_skb+0x21c/0x490
[ 1073.190126][T107993]  inet6_rt_notify+0xed/0x2a0
[ 1073.190510][T107993]  fib6_add+0x1ebf/0x45c0
[ 1073.190864][T107993]  ip6_ins_rt+0x11b/0x190
[ 1073.191227][T107993]  __ipv6_ifa_notify+0x5ef/0x1260
[ 1073.191681][T107993]  addrconf_dad_completed+0x18c/0xd10
[ 1073.192109][T107993]  addrconf_dad_work+0xe0b/0x1740
[ 1073.192513][T107993]  process_scheduled_works+0xa39/0x1840
[ 1073.192959][T107993] page last free pid 4572 tgid 4572 stack trace:
[ 1073.193459][T107993]  free_unref_page_prepare+0x97b/0xaa0
[ 1073.193898][T107993]  free_unref_page+0x37/0x3f0
[ 1073.194281][T107993]  __slab_free+0x353/0x3d0
[ 1073.194644][T107993]  qlist_free_all+0x5e/0xc0
[ 1073.195010][T107993]  kasan_quarantine_reduce+0x14f/0x170
[ 1073.195450][T107993]  __kasan_slab_alloc+0x23/0x80
[ 1073.195889][T107993]  kmem_cache_alloc+0x174/0x350
[ 1073.196285][T107993]  getname_flags+0xc6/0x520
[ 1073.196653][T107993]  user_path_at_empty+0x31/0x60
[ 1073.197046][T107993]  do_readlinkat+0x11d/0x3c0
[ 1073.197422][T107993]  __x64_sys_readlinkat+0x9f/0xb0
[ 1073.197831][T107993]  do_syscall_64+0xf5/0x240
[ 1073.198204][T107993]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1073.198675][T107993]
[ 1073.198873][T107993] Memory state around the buggy address:
[ 1073.199327][T107993]  ffff888179f5bf00: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[ 1073.199998][T107993]  ffff888179f5bf80: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[ 1073.200631][T107993] >ffff888179f5c000: fa fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 1073.201260][T107993]                                               ^
[ 1073.201768][T107993]  ffff888179f5c080: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 1073.202482][T107993]  ffff888179f5c100: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 1073.203410][T107993]
==================================================================
[ 1073.204153][T107993] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[ 1073.204721][T107993] CPU: 0 PID: 107993 Comm: kworker/u18:0 Not
tainted 6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 1073.205507][T107993] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1073.206307][T107993] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 1073.206872][T107993] Call Trace:
[ 1073.207142][T107993]  <TASK>
[ 1073.207388][T107993]  dump_stack_lvl+0x250/0x380
[ 1073.207827][T107993]  ? __pfx_dump_stack_lvl+0x10/0x10
[ 1073.208249][T107993]  ? __pfx__printk+0x10/0x10
[ 1073.208626][T107993]  ? rcu_is_watching+0x15/0xb0
[ 1073.209018][T107993]  ? lock_release+0xbf/0x9f0
[ 1073.209388][T107993]  ? vscnprintf+0x64/0x90
[ 1073.209745][T107993]  panic+0x35a/0x890
[ 1073.210067][T107993]  ? check_panic_on_warn+0x2b/0xb0
[ 1073.210480][T107993]  ? __pfx_panic+0x10/0x10
[ 1073.210841][T107993]  ? do_raw_spin_unlock+0x13c/0x8b0
[ 1073.211263][T107993]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[ 1073.211787][T107993]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[ 1073.212293][T107993]  ? print_report+0x502/0x550
[ 1073.212679][T107993]  check_panic_on_warn+0x8f/0xb0
[ 1073.213081][T107993]  ? __lock_acquire+0x78/0x1fd0
[ 1073.213474][T107993]  end_report+0x77/0x160
[ 1073.213819][T107993]  kasan_report+0x154/0x180
[ 1073.214192][T107993]  ? __lock_acquire+0x78/0x1fd0
[ 1073.214587][T107993]  __lock_acquire+0x78/0x1fd0
[ 1073.214967][T107993]  ? p9_client_prepare_req+0x9fb/0xe50
[ 1073.215405][T107993]  ? p9pdu_vwritef+0x145/0x2a40
[ 1073.215841][T107993]  ? __pfx_p9pdu_writef+0x10/0x10
[ 1073.216246][T107993]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[ 1073.216726][T107993]  lock_acquire+0x1ed/0x550
[ 1073.217088][T107993]  ? p9_fd_request+0x55/0x530
[ 1073.217469][T107993]  ? __pfx_lock_acquire+0x10/0x10
[ 1073.217875][T107993]  ? __pfx_p9_client_prepare_req+0x10/0x10
[ 1073.218341][T107993]  ? kasan_save_track+0x3f/0x80
[ 1073.218743][T107993]  _raw_spin_lock+0x2e/0x40
[ 1073.219116][T107993]  ? p9_fd_request+0x55/0x530
[ 1073.219510][T107993]  p9_fd_request+0x55/0x530
[ 1073.219913][T107993]  p9_client_rpc+0x30e/0xaf0
[ 1073.220291][T107993]  ? v9fs_free_request+0x7f/0xf0
[ 1073.220694][T107993]  ? __pfx_p9_client_rpc+0x10/0x10
[ 1073.221105][T107993]  ? netfs_free_request+0x1ff/0x630
[ 1073.221524][T107993]  ? __pfx_lock_release+0x10/0x10
[ 1073.221930][T107993]  ? do_raw_spin_lock+0x14f/0x370
[ 1073.222338][T107993]  p9_client_clunk+0x7a/0x280
[ 1073.222930][T107993]  ? __pfx_v9fs_free_request+0x10/0x10
[ 1073.223621][T107993]  netfs_free_request+0x259/0x630
[ 1073.224075][T107993]  ? netfs_free_subrequest+0x26f/0x420
[ 1073.224546][T107993]  v9fs_upload_to_server_worker+0x211/0x400
[ 1073.225027][T107993]  ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 1073.225574][T107993]  ? process_scheduled_works+0x93a/0x1840
[ 1073.226033][T107993]  process_scheduled_works+0xa39/0x1840
[ 1073.226497][T107993]  ? __pfx_process_scheduled_works+0x10/0x10
[ 1073.227001][T107993]  ? assign_work+0x3b7/0x430
[ 1073.227370][T107993]  worker_thread+0x89c/0xdc0
[ 1073.227817][T107993]  ? __kthread_parkme+0x172/0x1d0
[ 1073.228227][T107993]  kthread+0x310/0x3b0
[ 1073.228564][T107993]  ? __pfx_worker_thread+0x10/0x10
[ 1073.229016][T107993]  ? __pfx_kthread+0x10/0x10
[ 1073.229387][T107993]  ret_from_fork+0x52/0x80
[ 1073.229754][T107993]  ? __pfx_kthread+0x10/0x10
[ 1073.230157][T107993]  ret_from_fork_asm+0x1a/0x30
[ 1073.230547][T107993]  </TASK>
[ 1073.230964][T107993] Kernel Offset: disabled
[ 1073.231321][T107993] Rebooting in 86400 seconds.


=* repro.c =*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg) {
 pthread_t th;
 pthread_attr_t attr;
 pthread_attr_init(&attr);
 pthread_attr_setstacksize(&attr, 128 << 10);
 int i = 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) == 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno == EAGAIN) {
     usleep(50);
     continue;
   }
   break;
 }
 exit(1);
}

typedef struct {
 int state;
} event_t;

static void event_init(event_t* ev) {
 ev->state = 0;
}

static void event_reset(event_t* ev) {
 ev->state = 0;
}

static void event_set(event_t* ev) {
 if (ev->state)
   exit(1);
 __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
 syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
 while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
 return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
 uint64_t start = current_time_ms();
 uint64_t now = start;
 for (;;) {
   uint64_t remain = timeout - (now - start);
   struct timespec ts;
   ts.tv_sec = remain / 1000;
   ts.tv_nsec = (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
     return 1;
   now = current_time_ms();
   if (now - start > timeout)
     return 0;
 }
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] = 0;
 int len = strlen(buf);
 int fd = open(file, O_WRONLY | O_CLOEXEC);
 if (fd == -1)
   return false;
 if (write(fd, buf, len) != len) {
   int err = errno;
   close(fd);
   errno = err;
   return false;
 }
 close(fd);
 return true;
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i = 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) == pid)
     return;
   usleep(1000);
 }
 DIR* dir = opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent = readdir(dir);
     if (!ent)
       break;
     if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd = open(abort, O_WRONLY);
     if (fd == -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) != pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
 struct thread_t* th = (struct thread_t*)arg;
 for (;;) {
   event_wait(&th->ready);
   event_reset(&th->ready);
   execute_call(th->call);
   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
   event_set(&th->done);
 }
 return 0;
}

static void execute_one(void) {
 int i, call, thread;
 for (call = 0; call < 10; call++) {
   for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th = &threads[thread];
     if (!th->created) {
       th->created = 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done))
       continue;
     event_reset(&th->done);
     th->call = call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter = 0;
 for (;; iter++) {
   int pid = fork();
   if (pid < 0)
     exit(1);
   if (pid == 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status = 0;
   uint64_t start = current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff,
                0xffffffffffffffff};

void execute_call(int call) {
 intptr_t res = 0;
 switch (call) {
   case 0:
     memcpy((void*)0x20000240, "./file0\000", 8);
     syscall(__NR_creat, /*file=*/0x20000240ul, /*mode=*/0ul);
     break;
   case 1:
     res = syscall(__NR_pipe2, /*pipefd=*/0x20000080ul, /*flags=*/0ul);
     if (res != -1) {
       r[0] = *(uint32_t*)0x20000080;
       r[1] = *(uint32_t*)0x20000084;
     }
     break;
   case 2:
     memcpy((void*)0x20000480,
            "\x15\x00\x00\x00\x65\xff\xff\x01\x80\x00\x00\x08\x00\x39\x50\x32"
            "\x30\x30\x30",
            19);
     syscall(__NR_write, /*fd=*/r[1], /*data=*/0x20000480ul, /*size=*/0x15ul);
     break;
   case 3:
     res = syscall(__NR_dup, /*oldfd=*/r[1]);
     if (res != -1)
       r[2] = res;
     break;
   case 4:
     *(uint32_t*)0x20000100 = 0x18;
     *(uint32_t*)0x20000104 = 0;
     *(uint64_t*)0x20000108 = 0;
     *(uint64_t*)0x20000110 = 0;
     syscall(__NR_write, /*fd=*/r[2], /*arg=*/0x20000100ul, /*len=*/0x18ul);
     break;
   case 5:
     *(uint32_t*)0x200000c0 = 0x14c;
     *(uint32_t*)0x200000c4 = 5;
     *(uint64_t*)0x200000c8 = 0;
     *(uint64_t*)0x200000d0 = 0;
     *(uint64_t*)0x200000d8 = 0;
     *(uint64_t*)0x200000e0 = 0;
     *(uint32_t*)0x200000e8 = 0;
     *(uint32_t*)0x200000ec = 0;
     syscall(__NR_write, /*fd=*/r[2], /*arg=*/0x200000c0ul, /*len=*/0x137ul);
     break;
   case 6:
     memcpy((void*)0x20000000, "./file0\000", 8);
     memcpy((void*)0x20000040, "9p\000", 3);
     memcpy((void*)0x20000280, "trans=fd,", 9);
     memcpy((void*)0x20000289, "rfdno", 5);
     *(uint8_t*)0x2000028e = 0x3d;
     sprintf((char*)0x2000028f, "0x%016llx", (long long)r[0]);
     *(uint8_t*)0x200002a1 = 0x2c;
     memcpy((void*)0x200002a2, "wfdno", 5);
     *(uint8_t*)0x200002a7 = 0x3d;
     sprintf((char*)0x200002a8, "0x%016llx", (long long)r[2]);
     *(uint8_t*)0x200002ba = 0x2c;
     memcpy((void*)0x200002bb, "cache=mmap", 10);
     *(uint8_t*)0x200002c5 = 0x2c;
     *(uint8_t*)0x200002c6 = 0x6b;
     syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x20000000ul,
             /*type=*/0x20000040ul, /*flags=*/0ul, /*opts=*/0x20000280ul);
     break;
   case 7:
     memcpy((void*)0x20000140, "./file0\000", 8);
     syscall(__NR_chmod, /*file=*/0x20000140ul, /*mode=*/0ul);
     break;
   case 8:
     memcpy((void*)0x200004c0, "./file0\000", 8);
     res = syscall(__NR_creat, /*file=*/0x200004c0ul,
                   /*mode=*/0x1200000000000000ul);
     if (res != -1)
       r[3] = res;
     break;
   case 9:
     syscall(__NR_write, /*fd=*/r[3], /*arg=*/0x20000200ul, /*len=*/0x1001ul);
     break;
 }
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
         /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 loop();
 return 0;
}


=* repro.txt =*
creat(&(0x7f0000000240)='./file0\x00', 0x0)
pipe2$9p(&(0x7f0000000080)={<r0=>0xffffffffffffffff,
<r1=>0xffffffffffffffff}, 0x0)
write$P9_RVERSION(r1,
&(0x7f0000000480)=ANY=[@ANYBLOB="1500000065ffff018000000800395032303030"],
0x15)
r2 = dup(r1)
write$FUSE_BMAP(r2, &(0x7f0000000100)={0x18}, 0x18)
write$FUSE_NOTIFY_RETRIEVE(r2, &(0x7f00000000c0)={0x14c}, 0x137)
mount$9p_fd(0x0, &(0x7f0000000000)='./file0\x00', &(0x7f0000000040),
0x0, &(0x7f0000000280)={'trans=fd,', {'rfdno', 0x3d, r0}, 0x2c,
{'wfdno', 0x3d, r2}, 0x2c, {[{@cache_mmap}], [], 0x6b}})
chmod(&(0x7f0000000140)='./file0\x00', 0x0)
r3 = creat(&(0x7f00000004c0)='./file0\x00', 0x1200000000000000)
write$FUSE_DIRENTPLUS(r3, &(0x7f0000000200)=ANY=[], 0x1001)

and see also in
https://gist.github.com/xrivendell7/c1540d905cdbcc43fc134a76dd364f6d.

I hope it helps.
Best regards
xingwei lee
