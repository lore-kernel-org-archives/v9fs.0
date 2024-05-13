Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02014D2B2
	for <v9fs@lists.linux.dev>; Mon, 13 May 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601075; cv=none; b=Bq45RXujeRqFzQrLKpSKQY6/VH5hgc0Tm8BTR3/tPv2SrAqmXK/qMvXDT2P+/XhRCnXJsIKl7sTsabcBVnTg4DC2W7EhABoT4SWKrHhco3TT33ZJ2+AEZvpX+ogAKcmjZyeTDRcgA6Yasc3vMCzGp6+Xa9cR4N1j5vStNjLaqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601075; c=relaxed/simple;
	bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dEMC3HV8kJiNl3OaRiAK8Z/gzj60bQBL6inoOaEIW3VAUNIHsfyL3J+so4JJj+OZu3dhtzpC5cINVPWFELJ8ifSqRiu+07pk6b4RLvgiRtwu2gcQV9J5VKIVF4whLE5HFXPYbPdzuFAOU5kWlhFZg5Lgd1UMmeU37eFYZN3AZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLW1WPHR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLW1WPHR"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2438843a12.2
        for <v9fs@lists.linux.dev>; Mon, 13 May 2024 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715601073; x=1716205873; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
        b=kLW1WPHRD4evGzQLasdlrVKQoll7nZsMshFUkRE7mXuPnmS9qj4UMFXeRFm3RvdauD
         uJmbSAyXnzAj+N3sDlTi+NYO+zcDNpwHEqF9WaF7GeGEwyXxxgLZlULB3qu9qTRfybmg
         EkX7WaOJH5iVWDiVbTEg6fsUE/x8NyvEXamA+Ol6zjGQDTPFNf+8AUISwwMV0AH4dkcj
         zokM55I4/f8ElhaMo9nrIPBUeuGmHMzLj8SHyhe7XbUW0818hHFI9GfCkGOL16BwMs6a
         gg4gfzHFkQNHaGGiu7fpUwRE1Z/rK9WuLgWsMmShjmj8qg3gPA8Grs08wTMHAaHDFX01
         nMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601073; x=1716205873;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxXGmCzHTBG68V4Sgj+E7JBboKRnNrioG4mXmhP1BNk=;
        b=GHwKIOqHWmemfF4fo6Ps66pfsWLP919+GFGQrVvFzHRbUKC8DtVckwYY3/2vMNQlur
         N/XrpLB2nHe4KE1RmO07E0471XgFFnrza0y8Hsbn439fgWa1Oo3EwfoYka4DoZcMuEUk
         qxYokwkwPiOKQ1dvu/Sz0ymS/zyUprw/HlTDwyEIc+YLUgG+fT0C9PBPqO4EJ6N/xBm/
         6RT0Owx9jdBVHWHvyn7yyE1jmayvwDbyZdkF5ZkUXEnrMQFFoquZTmI/B525/G7el2UO
         iO0t1sOMjG+QJnCQ8EBQ3vksAnt4YnqnwaPYVwdvc8+UVu3HqpCZ4hmpvH2LEqgZRtHE
         NDig==
X-Forwarded-Encrypted: i=1; AJvYcCWZGbmxkuUv2ezy7+3kQ+0/nR5NUIo4ranEYEYC2fyGM80bsnC+NIfCAe1ve9EEw+/nYtwXhcbId3W7raVSc6kduqs2Aw==
X-Gm-Message-State: AOJu0YyxUR8jL4bTDyDyzNG1atYwcHiptxi7j43TL1ljB4t/3cDxAImW
	XECUxuwqpBpYP736CuFi2L2NUp9h7NFse0TrWepo+pDNF53RwyQgdELCRM0sxQxWQjXVqO/xYfa
	3i5gqEbEjlRiiHFYmLX9kIBGEL6g=
X-Google-Smtp-Source: AGHT+IEOdoW7RZJ+pycKQshemWD1e3dxnN/hwaDK8MOqft+DrxWTbjjN161+npD1FT97ymJXDAH0f9lhhkb43Uxi2ew=
X-Received: by 2002:a05:6a20:9747:b0:1af:8fa8:3126 with SMTP id
 adf61e73a8af0-1afde07cd39mr8141290637.6.1715601072540; Mon, 13 May 2024
 04:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Mon, 13 May 2024 19:50:59 +0800
Message-ID: <CABOYnLygfZLue33Z6GKhY-WoDqXmKfc6KWpffQ0QF5TAaJX_+g@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
To: syzbot+df038d463cca332e8414@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello, I found a reproducer for this bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance
git tree: upstream ba16c1cf11c9f264b5455cb7d57267b39925409a
kernel config: https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=df038d463cca332e8414
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Since, this may be a concurrency bug, we need to run the PoC for a
while, like ./syz-execprog -repeat 0 ../prog for 5 minus, and I test
that only syzlang repro work.
[ 106.007857][ T39]
==================================================================
[ 106.008516][ T39] BUG: KASAN: slab-use-after-free in
v9fs_free_request+0x69/0xf0
[ 106.009146][ T39] Write of size 4 at addr ffff88802842620c by task
kworker/u17:1/39
[ 106.009773][ T39]
[ 106.009976][ T39] CPU: 2 PID: 39 Comm: kworker/u17:1 Not tainted
6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 106.010722][ T39] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 106.011521][ T39] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 106.012083][ T39] Call Trace:
[ 106.012351][ T39] <TASK>
[ 106.012585][ T39] dump_stack_lvl+0x250/0x380
[ 106.012976][ T39] ? __pfx_dump_stack_lvl+0x10/0x10
[ 106.013396][ T39] ? __pfx__printk+0x10/0x10
[ 106.013783][ T39] ? _printk+0xda/0x120
[ 106.014118][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.014532][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.014943][ T39] print_report+0x169/0x550
[ 106.015306][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.015712][ T39] ? __virt_addr_valid+0x19b/0x580
[ 106.016119][ T39] ? __virt_addr_valid+0x4a8/0x580
[ 106.016526][ T39] ? __phys_addr+0xc3/0x180
[ 106.016892][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.017287][ T39] kasan_report+0x143/0x180
[ 106.017650][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.018053][ T39] kasan_check_range+0x282/0x290
[ 106.018444][ T39] v9fs_free_request+0x69/0xf0
[ 106.018828][ T39] ? __pfx_v9fs_free_request+0x10/0x10
[ 106.019260][ T39] netfs_free_request+0x259/0x630
[ 106.019660][ T39] ? netfs_free_subrequest+0x26f/0x420
[ 106.020092][ T39] v9fs_upload_to_server_worker+0x211/0x400
[ 106.020564][ T39] ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 106.021055][ T39] ? process_scheduled_works+0x93a/0x1840
[ 106.021510][ T39] process_scheduled_works+0xa39/0x1840
[ 106.021966][ T39] ? __pfx_process_scheduled_works+0x10/0x10
[ 106.022441][ T39] ? assign_work+0x3b7/0x430
[ 106.022811][ T39] worker_thread+0x89c/0xdc0
[ 106.023187][ T39] ? __kthread_parkme+0x172/0x1d0
[ 106.023589][ T39] kthread+0x310/0x3b0
[ 106.023918][ T39] ? __pfx_worker_thread+0x10/0x10
[ 106.024330][ T39] ? __pfx_kthread+0x10/0x10
[ 106.024702][ T39] ret_from_fork+0x52/0x80
[ 106.025062][ T39] ? __pfx_kthread+0x10/0x10
[ 106.025432][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.025826][ T39] </TASK>
[ 106.026072][ T39]
[ 106.026259][ T39] Allocated by task 34417:
[ 106.026608][ T39] kasan_save_track+0x3f/0x80
[ 106.026981][ T39] __kasan_kmalloc+0x98/0xb0
[ 106.027347][ T39] kmalloc_trace+0x1db/0x370
[ 106.027721][ T39] p9_fid_create+0x54/0x230
[ 106.028083][ T39] p9_client_walk+0x118/0x6c0
[ 106.028456][ T39] v9fs_file_open+0x2b9/0xae0
[ 106.028827][ T39] do_dentry_open+0x93d/0x1610
[ 106.029213][ T39] path_openat+0x29ba/0x33f0
[ 106.029578][ T39] do_filp_open+0x23c/0x4a0
[ 106.029946][ T39] do_sys_openat2+0x122/0x1c0
[ 106.030323][ T39] __x64_sys_creat+0x128/0x170
[ 106.030706][ T39] do_syscall_64+0xf5/0x240
[ 106.031064][ T39] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 106.031529][ T39]
[ 106.031722][ T39] Freed by task 8234:
[ 106.032036][ T39] kasan_save_track+0x3f/0x80
[ 106.032412][ T39] kasan_save_free_info+0x40/0x50
[ 106.032817][ T39] poison_slab_object+0xa6/0xe0
[ 106.033205][ T39] __kasan_slab_free+0x37/0x60
[ 106.033582][ T39] kfree+0x153/0x3b0
[ 106.033905][ T39] p9_client_destroy+0x205/0x6b0
[ 106.034296][ T39] v9fs_session_close+0x5b/0x220
[ 106.034690][ T39] v9fs_kill_super+0x61/0x90
[ 106.035056][ T39] deactivate_locked_super+0xcb/0x140
[ 106.035477][ T39] cleanup_mnt+0x444/0x4e0
[ 106.035836][ T39] task_work_run+0x25c/0x320
[ 106.036206][ T39] syscall_exit_to_user_mode+0x168/0x370
[ 106.036650][ T39] do_syscall_64+0x102/0x240
[ 106.037023][ T39] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 106.037485][ T39]
[ 106.037673][ T39] The buggy address belongs to the object at ffff888028426200
[ 106.037673][ T39] which belongs to the cache kmalloc-96 of size 96
[ 106.038739][ T39] The buggy address is located 12 bytes inside of
[ 106.038739][ T39] freed 96-byte region [ffff888028426200, ffff888028426260)
[ 106.039789][ T39]
[ 106.039979][ T39] The buggy address belongs to the physical page:
[ 106.040480][ T39] page: refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x28426
[ 106.041162][ T39] flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
[ 106.041770][ T39] page_type: 0xffffffff()
[ 106.042117][ T39] raw: 00fff00000000800 ffff888015042780
ffffea00006db8c0 dead000000000002
[ 106.042783][ T39] raw: 0000000000000000 0000000000200020
00000001ffffffff 0000000000000000
[ 106.043442][ T39] page dumped because: kasan: bad access detected
[ 106.043944][ T39] page_owner tracks the page as allocated
[ 106.044388][ T39] page last allocated via order 0, migratetype
Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY),
pid 8265, tgid 626513798 (syz-executor), ts 8265, free_ts 69218878619
[ 106.045775][ T39] post_alloc_hook+0x1ea/0x210
[ 106.046156][ T39] get_page_from_freelist+0x3410/0x35b0
[ 106.046598][ T39] __alloc_pages+0x256/0x6c0
[ 106.046963][ T39] alloc_slab_page+0x5f/0x160
[ 106.047337][ T39] new_slab+0x84/0x2f0
[ 106.047661][ T39] ___slab_alloc+0xc73/0x1260
[ 106.048034][ T39] kmalloc_trace+0x269/0x370
[ 106.048404][ T39] nsim_fib_event_nb+0x191/0x1130
[ 106.048812][ T39] notifier_call_chain+0x1ae/0x400
[ 106.049213][ T39] atomic_notifier_call_chain+0xea/0x1a0
[ 106.049651][ T39] call_fib_notifiers+0x3f/0x70
[ 106.050049][ T39] call_fib_entry_notifiers+0x218/0x380
[ 106.050492][ T39] fib_table_insert+0xf43/0x1fe0
[ 106.050888][ T39] fib_magic+0x3df/0x620
[ 106.051225][ T39] fib_add_ifaddr+0x156/0x610
[ 106.051597][ T39] fib_inetaddr_event+0x16f/0x200
[ 106.051996][ T39] page last free pid 34 tgid 34 stack trace:
[ 106.052460][ T39] free_unref_page_prepare+0x97b/0xaa0
[ 106.052893][ T39] free_unref_page+0x37/0x3f0
[ 106.053264][ T39] __put_partials+0xeb/0x130
[ 106.053628][ T39] put_cpu_partial+0x17c/0x250
[ 106.054014][ T39] __slab_free+0x2ea/0x3d0
[ 106.054371][ T39] qlist_free_all+0x5e/0xc0
[ 106.054733][ T39] kasan_quarantine_reduce+0x14f/0x170
[ 106.055163][ T39] __kasan_slab_alloc+0x23/0x80
[ 106.055546][ T39] kmalloc_trace+0x16f/0x370
[ 106.055913][ T39] nsim_fib_event_work+0xe30/0x41d0
[ 106.056325][ T39] process_scheduled_works+0xa39/0x1840
[ 106.056759][ T39] worker_thread+0x89c/0xdc0
[ 106.057123][ T39] kthread+0x310/0x3b0
[ 106.057451][ T39] ret_from_fork+0x52/0x80
[ 106.057811][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.058194][ T39]
[ 106.058383][ T39] Memory state around the buggy address:
[ 106.058816][ T39] ffff888028426100: fa fb fb fb fb fb fb fb fb fb fb
fb fc fc fc fc
[ 106.059435][ T39] ffff888028426180: 00 00 00 00 00 00 00 00 00 fc fc
fc fc fc fc fc
[ 106.060052][ T39] >ffff888028426200: fa fb fb fb fb fb fb fb fb fb
fb fb fc fc fc fc
[ 106.060667][ T39] ^
[ 106.061009][ T39] ffff888028426280: 00 00 00 00 00 00 00 00 00 00 fc
fc fc fc fc fc
[ 106.061630][ T39] ffff888028426300: fa fb fb fb fb fb fb fb fb fb fb
fb fc fc fc fc
[ 106.062256][ T39]
==================================================================
[ 106.071000][ T39] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[ 106.071654][ T39] CPU: 0 PID: 39 Comm: kworker/u17:1 Not tainted
6.9.0-rc7-00136-gf4345f05c0df-dirty #6
[ 106.072473][ T39] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 106.073339][ T39] Workqueue: events_unbound v9fs_upload_to_server_worker
[ 106.073954][ T39] Call Trace:
[ 106.074242][ T39] <TASK>
[ 106.074500][ T39] dump_stack_lvl+0x250/0x380
[ 106.074910][ T39] ? __pfx_dump_stack_lvl+0x10/0x10
[ 106.075361][ T39] ? __pfx__printk+0x10/0x10
[ 106.075765][ T39] ? preempt_schedule+0xe1/0xf0
[ 106.076188][ T39] ? vscnprintf+0x64/0x90
[ 106.076563][ T39] panic+0x35a/0x890
[ 106.076905][ T39] ? check_panic_on_warn+0x2b/0xb0
[ 106.077351][ T39] ? __pfx_panic+0x10/0x10
[ 106.077738][ T39] ? _raw_spin_unlock_irqrestore+0x130/0x140
[ 106.078260][ T39] ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[ 106.078803][ T39] ? print_report+0x502/0x550
[ 106.079216][ T39] check_panic_on_warn+0x8f/0xb0
[ 106.079643][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.080066][ T39] end_report+0x77/0x160
[ 106.080434][ T39] kasan_report+0x154/0x180
[ 106.080821][ T39] ? v9fs_free_request+0x69/0xf0
[ 106.081249][ T39] kasan_check_range+0x282/0x290
[ 106.081674][ T39] v9fs_free_request+0x69/0xf0
[ 106.082092][ T39] ? __pfx_v9fs_free_request+0x10/0x10
[ 106.082562][ T39] netfs_free_request+0x259/0x630
[ 106.082991][ T39] ? netfs_free_subrequest+0x26f/0x420
[ 106.083475][ T39] v9fs_upload_to_server_worker+0x211/0x400
[ 106.083992][ T39] ? __pfx_v9fs_upload_to_server_worker+0x10/0x10
[ 106.084551][ T39] ? process_scheduled_works+0x93a/0x1840
[ 106.085056][ T39] process_scheduled_works+0xa39/0x1840
[ 106.085554][ T39] ? __pfx_process_scheduled_works+0x10/0x10
[ 106.086086][ T39] ? assign_work+0x3b7/0x430
[ 106.086498][ T39] worker_thread+0x89c/0xdc0
[ 106.086908][ T39] ? __kthread_parkme+0x172/0x1d0
[ 106.087354][ T39] kthread+0x310/0x3b0
[ 106.087717][ T39] ? __pfx_worker_thread+0x10/0x10
[ 106.088171][ T39] ? __pfx_kthread+0x10/0x10
[ 106.088567][ T39] ret_from_fork+0x52/0x80
[ 106.088952][ T39] ? __pfx_kthread+0x10/0x10
[ 106.089352][ T39] ret_from_fork_asm+0x1a/0x30
[ 106.089777][ T39] </TASK>
[ 106.090207][ T39] Kernel Offset: disabled
[ 106.090585][ T39] Rebooting in 86400 seconds..


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
r3 = creat(&(0x7f00000004c0)='./file0\x00', 0x600000000000000)
write$FUSE_DIRENTPLUS(r3, &(0x7f0000000200)=ANY=[], 0x1001)

and see also in
https://gist.github.com/xrivendell7/f9a108d59abc4c4fe1883e6d347f7b17.

I hope it helps.
Best regards
xingwei lee
