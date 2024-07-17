Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2417FAAE
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239300; cv=none; b=cXTHSZFtHg6fWIu62EOpkCuAa3qr85O9Ie1M3LWKgNsGfyslu1D9i/xbrPFkIQz9WVsZBDmZYqrFlpk7dGHF2QvN0bMHRZ0qSVONtdK5BY7FV/tWHN3k5JrifbY39CfdZjHYmTezsDqKpebaAL3gdqOYSG3wYsVslGCzNnm0stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239300; c=relaxed/simple;
	bh=oGsQgr7hKqKkTzOqeuZMzgtMZ79GLr+lPwGU3iD7POM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZfiegdrej7VZOZgWd9uUvhXk3UM6F2gl6rYmaURQHazUY+B2W5HVrqfVnusCBF4e/oKApCx46owxOwEqJ4mzCmGjuYxlqaj1vXYg0Tem5ZPfw7FfMNjs3KucgMzFGbxM1WNaoZj7mEbvzX84X3fBMqzESehnqZe8pS5UOANma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URebUnvg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URebUnvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CDDC4AF0C
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721239299;
	bh=oGsQgr7hKqKkTzOqeuZMzgtMZ79GLr+lPwGU3iD7POM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=URebUnvgD09fl58P7P5RXOFHZDyIcm/DElVEBzk+B7jf7K0Ir/TE2ERECAZYQL4nM
	 f5gjzTVYsPXxZdnfsIqHnpPlcdckfqqdpSnIMv4rCLrL8iO8IRnf0wY5IukQg7UjpQ
	 pttbmUJLb8aoizwQtIHeh5VyAE07sJyf7j4aUptH5Ktb6B2FdtnfW7KnmHUDhT7ivM
	 4KVOM8XlYPTZzu1mlMWzLCEEx2AYpFdIQhck1WJQ/gaPPaOOCfl2aRCfHIm6i2HP8G
	 yCpsAX+bHR4uHWT3LLXTaNYosVgGswq5c+7064A4zuC5J7ub8/z1ftKTybkGIFXLkb
	 tT1obF3qN0Ysw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6659e81bc68so881807b3.0
        for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 11:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwRXWH5b3XQnQOhX8HNE+2JeqGA6Xf16I7QK24pwPQAacTC7yadXDmAXueYh8FCLipED7fTrDvCUZAAzcC9odEMB3ahQ==
X-Gm-Message-State: AOJu0Yx5QlchfsvlcDHiCgLlIfcryzfMmpwBz/PDuQQ6NQEGa3j1vPZ8
	Ia4xOMLOadXCueF1pqVMjJUS9Zy7rUsLICpHHzq80TQ/KDX0KIzMNSNXKR+z3lr7wi0vBJhGyFJ
	qG743F3AJF0VgLp9A/ml2mNPVmE0=
X-Google-Smtp-Source: AGHT+IFom6M34g5Z5/rP6mgug6Jfgw49cadGCzaj1+its+mNHcqTBFyaG7ddfzxKfyanKPomuOccW1j4+RFtzJqZe9w=
X-Received: by 2002:a81:b40f:0:b0:631:43e1:6b99 with SMTP id
 00721157ae682-664fdf787a8mr25148697b3.12.1721239298202; Wed, 17 Jul 2024
 11:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717102458.649b60be@kernel.org>
In-Reply-To: <20240717102458.649b60be@kernel.org>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 17 Jul 2024 13:01:26 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
Message-ID: <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
Subject: Re: hangs after merge window changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I held way back on adding anything new over the past cycle, so this
sounds likely some external change maybe perturbing an older issue.
What guest side mount options, qemu options and qemu version are you
using?

Dominique, you aware of anything coming in that might have messed with
this?  Maybe the new common code refactoring underpinning
readahead/etc.?

      -eric

On Wed, Jul 17, 2024 at 12:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Hi!
>
> Apologies for possible duplicate, I tried to search lore and haven't
> found anything, but also I can't find the exact 9p archive there :S
>
> After forwarding to Linus's tree yesterday, we see hangs in networking
> CI (which uses 9p over virtio to mount host FS), they seem sporadic,
> and are not very reproducible:
>
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/686601/10-b=
ridge-mdb-max-sh/stderr
> https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/687140/5-eth=
tool-coalesce-sh/stderr
> https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/687140/6-dev=
link-sh/stderr
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/686781/3-test-vxla=
n-mdb-sh/stderr
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/686601/61-r=
outer-bridge-sh/stderr
>
> We only got those 5 over 24h, meaning so roughly 1 in 500 runs hits
> this.
>
> For the benefits of the ML here's one of the five:
>
> [  247.084355][   T43] INFO: task ip:419 blocked for more than 122 second=
s.
> [  247.084693][   T43]       Not tainted 6.10.0-virtme #1
> [  247.084816][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  247.085041][   T43] task:ip              state:D stack:26288 pid:419  =
 tgid:419   ppid:233    flags:0x00000000
> [  247.085333][   T43] Call Trace:
> [  247.085477][   T43]  <TASK>
> [  247.085548][   T43]  __schedule+0x6e0/0x17e0
> [  247.085681][   T43]  ? __pfx___schedule+0x10/0x10
> [  247.085805][   T43]  ? schedule+0x1a5/0x210
> [  247.085925][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.086049][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.086178][   T43]  ? schedule+0x1a5/0x210
> [  247.086531][   T43]  schedule+0xdf/0x210
> [  247.086643][   T43]  d_alloc_parallel+0xaef/0xed0
> [  247.086788][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  247.086914][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  247.087085][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  247.087214][   T43]  __lookup_slow+0x17f/0x3c0
> [  247.087357][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  247.087486][   T43]  ? walk_component+0x29e/0x4f0
> [  247.087626][   T43]  walk_component+0x2ab/0x4f0
> [  247.087753][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  247.087921][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  247.088092][   T43]  path_openat+0x1be/0x440
> [  247.088240][   T43]  ? __pfx_path_openat+0x10/0x10
> [  247.088366][   T43]  ? __lock_acquire+0xaf0/0x1570
> [  247.088492][   T43]  do_filp_open+0x1b3/0x3e0
> [  247.088616][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  247.088736][   T43]  ? find_held_lock+0x2c/0x110
> [  247.088871][   T43]  ? do_raw_spin_lock+0x131/0x270
> [  247.088995][   T43]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  247.089118][   T43]  ? alloc_fd+0x1f5/0x650
> [  247.089214][   T43]  ? do_raw_spin_unlock+0x58/0x220
> [  247.089367][   T43]  ? _raw_spin_unlock+0x23/0x40
> [  247.089493][   T43]  ? alloc_fd+0x1f5/0x650
> [  247.089624][   T43]  do_sys_openat2+0x122/0x160
> [  247.089777][   T43]  ? __pfx_do_sys_openat2+0x10/0x10
> [  247.089901][   T43]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
> [  247.090060][   T43]  ? __virt_addr_valid+0x230/0x430
> [  247.090192][   T43]  __x64_sys_openat+0x123/0x1e0
> [  247.090329][   T43]  ? __pfx___x64_sys_openat+0x10/0x10
> [  247.090484][   T43]  do_syscall_64+0xc1/0x1d0
> [  247.090607][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  247.090758][   T43] RIP: 0033:0x7f4b57a460e8
> [  247.090901][   T43] RSP: 002b:00007ffd58925788 EFLAGS: 00000287 ORIG_R=
AX: 0000000000000101
> [  247.091085][   T43] RAX: ffffffffffffffda RBX: 00007ffd58925a0f RCX: 0=
0007f4b57a460e8
> [  247.091303][   T43] RDX: 0000000000080000 RSI: 00007ffd58925800 RDI: 0=
0000000ffffff9c
> [  247.091500][   T43] RBP: 00007ffd589257f0 R08: 0000000000080000 R09: 0=
0007ffd58925800
> [  247.091682][   T43] R10: 0000000000000000 R11: 0000000000000287 R12: 0=
0007ffd58925807
> [  247.091873][   T43] R13: 00007ffd58925a20 R14: 00007ffd58925800 R15: 0=
0007f4b57a17000
> [  247.092070][   T43]  </TASK>
> [  247.092167][   T43] INFO: task rename_device:421 blocked for more than=
 122 seconds.
> [  247.092346][   T43]       Not tainted 6.10.0-virtme #1
> [  247.092467][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  247.092690][   T43] task:rename_device   state:D stack:26464 pid:421  =
 tgid:421   ppid:1      flags:0x00004004
> [  247.092926][   T43] Call Trace:
> [  247.093016][   T43]  <TASK>
> [  247.093110][   T43]  __schedule+0x6e0/0x17e0
> [  247.093265][   T43]  ? __pfx___schedule+0x10/0x10
> [  247.093392][   T43]  ? schedule+0x1a5/0x210
> [  247.093497][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.093636][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.093763][   T43]  ? schedule+0x1a5/0x210
> [  247.093861][   T43]  schedule+0xdf/0x210
> [  247.093963][   T43]  __wait_on_freeing_inode+0x115/0x280
> [  247.094084][   T43]  ? __pfx___wait_on_freeing_inode+0x10/0x10
> [  247.094249][   T43]  ? __pfx_wake_bit_function+0x10/0x10
> [  247.094395][   T43]  ? lock_acquire+0x32/0xc0
> [  247.094525][   T43]  ? find_inode_fast+0x158/0x450
> [  247.094654][   T43]  find_inode_fast+0x18d/0x450
> [  247.094779][   T43]  iget_locked+0x7d/0x390
> [  247.094895][   T43]  ? hlock_class+0x4e/0x130
> [  247.095029][   T43]  v9fs_fid_iget_dotl+0x78/0x2d0
> [  247.095156][   T43]  v9fs_vfs_lookup.part.0+0x1ed/0x390
> [  247.095304][   T43]  ? __pfx_v9fs_vfs_lookup.part.0+0x10/0x10
> [  247.095455][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  247.095598][   T43]  __lookup_slow+0x209/0x3c0
> [  247.095721][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  247.095865][   T43]  ? walk_component+0x29e/0x4f0
> [  247.096013][   T43]  walk_component+0x2ab/0x4f0
> [  247.096137][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  247.096335][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  247.096492][   T43]  path_openat+0x1be/0x440
> [  247.096633][   T43]  ? __pfx_path_openat+0x10/0x10
> [  247.096770][   T43]  ? __lock_acquire+0xaf0/0x1570
> [  247.096895][   T43]  do_filp_open+0x1b3/0x3e0
> [  247.097025][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  247.097144][   T43]  ? find_held_lock+0x2c/0x110
> [  247.097310][   T43]  ? do_raw_spin_lock+0x131/0x270
> [  247.097433][   T43]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  247.097567][   T43]  ? alloc_fd+0x1f5/0x650
> [  247.097674][   T43]  ? do_raw_spin_unlock+0x58/0x220
> [  247.097797][   T43]  ? _raw_spin_unlock+0x23/0x40
> [  247.097923][   T43]  ? alloc_fd+0x1f5/0x650
> [  247.098022][   T43]  do_sys_openat2+0x122/0x160
> [  247.098144][   T43]  ? __pfx_do_sys_openat2+0x10/0x10
> [  247.098276][   T43]  ? __up_read+0x1a7/0x780
> [  247.098402][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.098523][   T43]  ? __pfx___up_read+0x10/0x10
> [  247.098650][   T43]  __x64_sys_openat+0x123/0x1e0
> [  247.098770][   T43]  ? __pfx___x64_sys_openat+0x10/0x10
> [  247.098907][   T43]  do_syscall_64+0xc1/0x1d0
> [  247.099029][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  247.099178][   T43] RIP: 0033:0x7fb4a75850e8
> [  247.099311][   T43] RSP: 002b:00007fffb3f40268 EFLAGS: 00000287 ORIG_R=
AX: 0000000000000101
> [  247.099490][   T43] RAX: ffffffffffffffda RBX: 00007fffb3f4033f RCX: 0=
0007fb4a75850e8
> [  247.099666][   T43] RDX: 0000000000080000 RSI: 00007fb4a75565f0 RDI: 0=
0000000ffffff9c
> [  247.099844][   T43] RBP: 00007fffb3f402d0 R08: 0000000000080000 R09: 0=
0007fb4a75565f0
> [  247.100022][   T43] R10: 0000000000000000 R11: 0000000000000287 R12: 0=
000000000000000
> [  247.100203][   T43] R13: 00007fffb3f40350 R14: 00007fb4a75565f0 R15: 0=
0007fffb3f40350
> [  247.100402][   T43]  </TASK>
> [  247.100496][   T43] INFO: task (spawn):422 blocked for more than 122 s=
econds.
> [  247.100660][   T43]       Not tainted 6.10.0-virtme #1
> [  247.100777][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  247.100969][   T43] task:(spawn)         state:D stack:26464 pid:422  =
 tgid:422   ppid:1      flags:0x00004006
> [  247.101202][   T43] Call Trace:
> [  247.101300][   T43]  <TASK>
> [  247.101367][   T43]  __schedule+0x6e0/0x17e0
> [  247.101494][   T43]  ? __pfx___schedule+0x10/0x10
> [  247.101614][   T43]  ? schedule+0x1a5/0x210
> [  247.101710][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.101828][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.101950][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.102080][   T43]  ? schedule+0x1a5/0x210
> [  247.102176][   T43]  schedule+0xdf/0x210
> [  247.102280][   T43]  d_alloc_parallel+0xaef/0xed0
> [  247.102411][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  247.102536][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  247.102690][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  247.102817][   T43]  __lookup_slow+0x17f/0x3c0
> [  247.102963][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  247.103092][   T43]  ? walk_component+0x29e/0x4f0
> [  247.103251][   T43]  walk_component+0x2ab/0x4f0
> [  247.103375][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  247.103549][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  247.103712][   T43]  path_openat+0x1be/0x440
> [  247.103838][   T43]  ? __pfx_path_openat+0x10/0x10
> [  247.103997][   T43]  ? hlock_class+0x4e/0x130
> [  247.104117][   T43]  ? mark_lock+0x38/0x3e0
> [  247.104244][   T43]  do_filp_open+0x1b3/0x3e0
> [  247.104375][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  247.104507][   T43]  ? __lock_release+0x103/0x460
> [  247.104625][   T43]  ? __create_object+0x5e/0xb0
> [  247.104746][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.104868][   T43]  ? hlock_class+0x4e/0x130
> [  247.104999][   T43]  ? mark_held_locks+0x9e/0xe0
> [  247.105120][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  247.105286][   T43]  do_open_execat+0xb0/0x280
> [  247.105421][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  247.105544][   T43]  ? getname_kernel+0x14c/0x2d0
> [  247.105689][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  247.105814][   T43]  open_exec+0x2b/0x50
> [  247.105909][   T43]  load_elf_binary+0x504/0x2880
> [  247.106069][   T43]  ? find_held_lock+0x2c/0x110
> [  247.106195][   T43]  ? __lock_release+0x103/0x460
> [  247.106345][   T43]  ? search_binary_handler+0x134/0x550
> [  247.106480][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.106599][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.106728][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.106847][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  247.106991][   T43]  ? search_binary_handler+0x134/0x550
> [  247.107126][   T43]  search_binary_handler+0x152/0x550
> [  247.107258][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  247.107438][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  247.107564][   T43]  ? exec_binprm+0x100/0x3c0
> [  247.107707][   T43]  exec_binprm+0x119/0x3c0
> [  247.107833][   T43]  bprm_execve+0xe9/0x4f0
> [  247.107927][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  247.108064][   T43]  __x64_sys_execve+0x8c/0xb0
> [  247.108193][   T43]  do_syscall_64+0xc1/0x1d0
> [  247.108344][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  247.108494][   T43] RIP: 0033:0x7fa4f34f740b
> [  247.108650][   T43] RSP: 002b:00007ffd893fd6d8 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  247.108832][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d5daf0 RCX: 0=
0007fa4f34f740b
> [  247.109026][   T43] RDX: 0000560ac3d62360 RSI: 0000560ac3d76bc0 RDI: 0=
000560ac3d8d8f0
> [  247.109213][   T43] RBP: 00007ffd893fd800 R08: 0000000000000000 R09: 0=
000000000000000
> [  247.109403][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffd89401890
> [  247.109604][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd893fd720 R15: 0=
000000000000000
> [  247.109792][   T43]  </TASK>
> [  247.109885][   T43] INFO: task (spawn):423 blocked for more than 122 s=
econds.
> [  247.110074][   T43]       Not tainted 6.10.0-virtme #1
> [  247.110188][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  247.110412][   T43] task:(spawn)         state:D stack:26608 pid:423  =
 tgid:423   ppid:1      flags:0x00004006
> [  247.110654][   T43] Call Trace:
> [  247.110744][   T43]  <TASK>
> [  247.110820][   T43]  __schedule+0x6e0/0x17e0
> [  247.110961][   T43]  ? __pfx___schedule+0x10/0x10
> [  247.111080][   T43]  ? schedule+0x1a5/0x210
> [  247.111196][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.111336][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.111458][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.111599][   T43]  ? schedule+0x1a5/0x210
> [  247.111693][   T43]  schedule+0xdf/0x210
> [  247.111786][   T43]  d_alloc_parallel+0xaef/0xed0
> [  247.111928][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  247.112051][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  247.112239][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  247.112367][   T43]  __lookup_slow+0x17f/0x3c0
> [  247.112490][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  247.112618][   T43]  ? walk_component+0x29e/0x4f0
> [  247.112753][   T43]  walk_component+0x2ab/0x4f0
> [  247.112877][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  247.113028][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  247.113186][   T43]  path_openat+0x1be/0x440
> [  247.113362][   T43]  ? __pfx_path_openat+0x10/0x10
> [  247.113483][   T43]  ? hlock_class+0x4e/0x130
> [  247.113612][   T43]  ? mark_lock+0x38/0x3e0
> [  247.113729][   T43]  do_filp_open+0x1b3/0x3e0
> [  247.113850][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  247.113989][   T43]  ? __lock_release+0x103/0x460
> [  247.114107][   T43]  ? __create_object+0x5e/0xb0
> [  247.114255][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.114388][   T43]  ? hlock_class+0x4e/0x130
> [  247.114514][   T43]  ? mark_held_locks+0x9e/0xe0
> [  247.114653][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  247.114814][   T43]  do_open_execat+0xb0/0x280
> [  247.114947][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  247.115089][   T43]  ? getname_kernel+0x14c/0x2d0
> [  247.115206][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  247.115347][   T43]  open_exec+0x2b/0x50
> [  247.115443][   T43]  load_elf_binary+0x504/0x2880
> [  247.115591][   T43]  ? find_held_lock+0x2c/0x110
> [  247.115713][   T43]  ? __lock_release+0x103/0x460
> [  247.115838][   T43]  ? search_binary_handler+0x134/0x550
> [  247.115984][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.116103][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.116272][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.116395][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  247.116526][   T43]  ? search_binary_handler+0x134/0x550
> [  247.116658][   T43]  search_binary_handler+0x152/0x550
> [  247.116801][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  247.116950][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  247.117081][   T43]  ? exec_binprm+0x100/0x3c0
> [  247.117248][   T43]  exec_binprm+0x119/0x3c0
> [  247.117378][   T43]  bprm_execve+0xe9/0x4f0
> [  247.117472][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  247.117596][   T43]  __x64_sys_execve+0x8c/0xb0
> [  247.117725][   T43]  do_syscall_64+0xc1/0x1d0
> [  247.117847][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  247.117994][   T43] RIP: 0033:0x7fa4f34f740b
> [  247.118116][   T43] RSP: 002b:00007ffd89405918 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  247.118309][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d94430 RCX: 0=
0007fa4f34f740b
> [  247.118483][   T43] RDX: 0000560ac3d5ff20 RSI: 0000560ac3d76cd0 RDI: 0=
000560ac3d5e240
> [  247.118660][   T43] RBP: 00007ffd89405a40 R08: 0000000000000008 R09: 0=
000000000000000
> [  247.118838][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
000560ac3d767d0
> [  247.119013][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd89405960 R15: 0=
000000000000000
> [  247.119201][   T43]  </TASK>
> [  247.119300][   T43] INFO: task (spawn):424 blocked for more than 122 s=
econds.
> [  247.119463][   T43]       Not tainted 6.10.0-virtme #1
> [  247.119583][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  247.119772][   T43] task:(spawn)         state:D stack:26464 pid:424  =
 tgid:424   ppid:1      flags:0x00004006
> [  247.120005][   T43] Call Trace:
> [  247.120096][   T43]  <TASK>
> [  247.120161][   T43]  __schedule+0x6e0/0x17e0
> [  247.120298][   T43]  ? __pfx___schedule+0x10/0x10
> [  247.120417][   T43]  ? schedule+0x1a5/0x210
> [  247.120519][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.120636][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.120756][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.120881][   T43]  ? schedule+0x1a5/0x210
> [  247.120976][   T43]  schedule+0xdf/0x210
> [  247.121069][   T43]  d_alloc_parallel+0xaef/0xed0
> [  247.121200][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  247.121443][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  247.121596][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  247.121728][   T43]  __lookup_slow+0x17f/0x3c0
> [  247.121849][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  247.122028][   T43]  ? walk_component+0x29e/0x4f0
> [  247.122162][   T43]  walk_component+0x2ab/0x4f0
> [  247.122295][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  247.122447][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  247.122713][   T43]  path_openat+0x1be/0x440
> [  247.122839][   T43]  ? __pfx_path_openat+0x10/0x10
> [  247.122959][   T43]  ? hlock_class+0x4e/0x130
> [  247.123078][   T43]  ? mark_lock+0x38/0x3e0
> [  247.123175][   T43]  do_filp_open+0x1b3/0x3e0
> [  247.123379][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  247.123511][   T43]  ? __lock_release+0x103/0x460
> [  247.123628][   T43]  ? __create_object+0x5e/0xb0
> [  247.123775][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.123990][   T43]  ? hlock_class+0x4e/0x130
> [  247.124128][   T43]  ? mark_held_locks+0x9e/0xe0
> [  247.124263][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  247.124444][   T43]  do_open_execat+0xb0/0x280
> [  247.124622][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  247.124747][   T43]  ? getname_kernel+0x14c/0x2d0
> [  247.124896][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  247.125019][   T43]  open_exec+0x2b/0x50
> [  247.125194][   T43]  load_elf_binary+0x504/0x2880
> [  247.125335][   T43]  ? find_held_lock+0x2c/0x110
> [  247.125466][   T43]  ? __lock_release+0x103/0x460
> [  247.125589][   T43]  ? search_binary_handler+0x134/0x550
> [  247.125723][   T43]  ? __pfx___lock_release+0x10/0x10
> [  247.125916][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  247.126036][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  247.126184][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  247.126330][   T43]  ? search_binary_handler+0x134/0x550
> [  247.126536][   T43]  search_binary_handler+0x152/0x550
> [  247.126659][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  247.126819][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  247.126943][   T43]  ? exec_binprm+0x100/0x3c0
> [  247.127144][   T43]  exec_binprm+0x119/0x3c0
> [  247.127281][   T43]  bprm_execve+0xe9/0x4f0
> [  247.127403][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  247.127529][   T43]  __x64_sys_execve+0x8c/0xb0
> [  247.127732][   T43]  do_syscall_64+0xc1/0x1d0
> [  247.127854][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  247.128016][   T43] RIP: 0033:0x7fa4f34f740b
> [  247.128140][   T43] RSP: 002b:00007ffd893fd6d8 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  247.128413][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d2df30 RCX: 0=
0007fa4f34f740b
> [  247.128601][   T43] RDX: 0000560ac3d7ff10 RSI: 0000560ac3d8d940 RDI: 0=
000560ac3d33950
> [  247.128798][   T43] RBP: 00007ffd893fd800 R08: 0000000000000000 R09: 0=
000000000000000
> [  247.129060][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffd89401890
> [  247.129249][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd893fd720 R15: 0=
000000000000000
> [  247.129440][   T43]  </TASK>
> [  247.129587][   T43]
> [  247.129587][   T43] Showing all locks held in the system:
> [  247.129764][   T43] 1 lock held by khungtaskd/43:
> [  247.129901][   T43]  #0: ffffffff97b54b80 (rcu_read_lock){....}-{1:2},=
 at: debug_show_all_locks+0x70/0x3a0
> [  247.130210][   T43] 1 lock held by ip/419:
> [  247.130311][   T43]  #0: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  247.130587][   T43] 1 lock held by rename_device/421:
> [  247.130713][   T43]  #0: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  247.131030][   T43] 2 locks held by (spawn)/422:
> [  247.131146][   T43]  #0: ffff888005bc4238 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  247.131431][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  247.131698][   T43] 2 locks held by (spawn)/423:
> [  247.131813][   T43]  #0: ffff888005bc0578 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  247.132112][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  247.132379][   T43] 2 locks held by (spawn)/424:
> [  247.132502][   T43]  #0: ffff888005bc0c38 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  247.132852][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  247.133095][   T43]
> [  247.133169][   T43] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [  247.133169][   T43]
> [  369.964331][   T43] INFO: task ip:419 blocked for more than 245 second=
s.
> [  369.964619][   T43]       Not tainted 6.10.0-virtme #1
> [  369.964734][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  369.964953][   T43] task:ip              state:D stack:26288 pid:419  =
 tgid:419   ppid:233    flags:0x00000000
> [  369.965192][   T43] Call Trace:
> [  369.965327][   T43]  <TASK>
> [  369.965400][   T43]  __schedule+0x6e0/0x17e0
> [  369.965536][   T43]  ? __pfx___schedule+0x10/0x10
> [  369.965659][   T43]  ? schedule+0x1a5/0x210
> [  369.965757][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.965881][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.966011][   T43]  ? schedule+0x1a5/0x210
> [  369.966113][   T43]  schedule+0xdf/0x210
> [  369.966209][   T43]  d_alloc_parallel+0xaef/0xed0
> [  369.966364][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  369.966502][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  369.966657][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  369.966785][   T43]  __lookup_slow+0x17f/0x3c0
> [  369.966907][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  369.967033][   T43]  ? walk_component+0x29e/0x4f0
> [  369.967172][   T43]  walk_component+0x2ab/0x4f0
> [  369.967305][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  369.967462][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  369.967617][   T43]  path_openat+0x1be/0x440
> [  369.967743][   T43]  ? __pfx_path_openat+0x10/0x10
> [  369.967867][   T43]  ? __lock_acquire+0xaf0/0x1570
> [  369.967993][   T43]  do_filp_open+0x1b3/0x3e0
> [  369.968115][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  369.968243][   T43]  ? find_held_lock+0x2c/0x110
> [  369.968374][   T43]  ? do_raw_spin_lock+0x131/0x270
> [  369.968499][   T43]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  369.968620][   T43]  ? alloc_fd+0x1f5/0x650
> [  369.968714][   T43]  ? do_raw_spin_unlock+0x58/0x220
> [  369.968837][   T43]  ? _raw_spin_unlock+0x23/0x40
> [  369.968960][   T43]  ? alloc_fd+0x1f5/0x650
> [  369.969059][   T43]  do_sys_openat2+0x122/0x160
> [  369.969181][   T43]  ? __pfx_do_sys_openat2+0x10/0x10
> [  369.969312][   T43]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
> [  369.969465][   T43]  ? __virt_addr_valid+0x230/0x430
> [  369.969591][   T43]  __x64_sys_openat+0x123/0x1e0
> [  369.969713][   T43]  ? __pfx___x64_sys_openat+0x10/0x10
> [  369.969869][   T43]  do_syscall_64+0xc1/0x1d0
> [  369.969996][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  369.970156][   T43] RIP: 0033:0x7f4b57a460e8
> [  369.970330][   T43] RSP: 002b:00007ffd58925788 EFLAGS: 00000287 ORIG_R=
AX: 0000000000000101
> [  369.970663][   T43] RAX: ffffffffffffffda RBX: 00007ffd58925a0f RCX: 0=
0007f4b57a460e8
> [  369.970849][   T43] RDX: 0000000000080000 RSI: 00007ffd58925800 RDI: 0=
0000000ffffff9c
> [  369.971027][   T43] RBP: 00007ffd589257f0 R08: 0000000000080000 R09: 0=
0007ffd58925800
> [  369.971241][   T43] R10: 0000000000000000 R11: 0000000000000287 R12: 0=
0007ffd58925807
> [  369.971439][   T43] R13: 00007ffd58925a20 R14: 00007ffd58925800 R15: 0=
0007f4b57a17000
> [  369.971675][   T43]  </TASK>
> [  369.971769][   T43] INFO: task rename_device:421 blocked for more than=
 245 seconds.
> [  369.971933][   T43]       Not tainted 6.10.0-virtme #1
> [  369.972051][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  369.972296][   T43] task:rename_device   state:D stack:26464 pid:421  =
 tgid:421   ppid:1      flags:0x00004004
> [  369.972551][   T43] Call Trace:
> [  369.972648][   T43]  <TASK>
> [  369.972715][   T43]  __schedule+0x6e0/0x17e0
> [  369.972860][   T43]  ? __pfx___schedule+0x10/0x10
> [  369.972980][   T43]  ? schedule+0x1a5/0x210
> [  369.973082][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.973237][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.973364][   T43]  ? schedule+0x1a5/0x210
> [  369.973463][   T43]  schedule+0xdf/0x210
> [  369.973555][   T43]  __wait_on_freeing_inode+0x115/0x280
> [  369.973687][   T43]  ? __pfx___wait_on_freeing_inode+0x10/0x10
> [  369.973840][   T43]  ? __pfx_wake_bit_function+0x10/0x10
> [  369.973966][   T43]  ? lock_acquire+0x32/0xc0
> [  369.974093][   T43]  ? find_inode_fast+0x158/0x450
> [  369.974257][   T43]  find_inode_fast+0x18d/0x450
> [  369.974383][   T43]  iget_locked+0x7d/0x390
> [  369.974501][   T43]  ? hlock_class+0x4e/0x130
> [  369.974629][   T43]  v9fs_fid_iget_dotl+0x78/0x2d0
> [  369.974762][   T43]  v9fs_vfs_lookup.part.0+0x1ed/0x390
> [  369.974902][   T43]  ? __pfx_v9fs_vfs_lookup.part.0+0x10/0x10
> [  369.975059][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  369.975189][   T43]  __lookup_slow+0x209/0x3c0
> [  369.975347][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  369.975483][   T43]  ? walk_component+0x29e/0x4f0
> [  369.975644][   T43]  walk_component+0x2ab/0x4f0
> [  369.975770][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  369.975964][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  369.976120][   T43]  path_openat+0x1be/0x440
> [  369.976269][   T43]  ? __pfx_path_openat+0x10/0x10
> [  369.976394][   T43]  ? __lock_acquire+0xaf0/0x1570
> [  369.976534][   T43]  do_filp_open+0x1b3/0x3e0
> [  369.976655][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  369.976796][   T43]  ? find_held_lock+0x2c/0x110
> [  369.976935][   T43]  ? do_raw_spin_lock+0x131/0x270
> [  369.977054][   T43]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  369.977181][   T43]  ? alloc_fd+0x1f5/0x650
> [  369.977283][   T43]  ? do_raw_spin_unlock+0x58/0x220
> [  369.977407][   T43]  ? _raw_spin_unlock+0x23/0x40
> [  369.977547][   T43]  ? alloc_fd+0x1f5/0x650
> [  369.977648][   T43]  do_sys_openat2+0x122/0x160
> [  369.977769][   T43]  ? __pfx_do_sys_openat2+0x10/0x10
> [  369.977908][   T43]  ? __up_read+0x1a7/0x780
> [  369.978036][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.978162][   T43]  ? __pfx___up_read+0x10/0x10
> [  369.978323][   T43]  __x64_sys_openat+0x123/0x1e0
> [  369.978446][   T43]  ? __pfx___x64_sys_openat+0x10/0x10
> [  369.978585][   T43]  do_syscall_64+0xc1/0x1d0
> [  369.978708][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  369.978877][   T43] RIP: 0033:0x7fb4a75850e8
> [  369.979008][   T43] RSP: 002b:00007fffb3f40268 EFLAGS: 00000287 ORIG_R=
AX: 0000000000000101
> [  369.979204][   T43] RAX: ffffffffffffffda RBX: 00007fffb3f4033f RCX: 0=
0007fb4a75850e8
> [  369.979427][   T43] RDX: 0000000000080000 RSI: 00007fb4a75565f0 RDI: 0=
0000000ffffff9c
> [  369.979602][   T43] RBP: 00007fffb3f402d0 R08: 0000000000080000 R09: 0=
0007fb4a75565f0
> [  369.979780][   T43] R10: 0000000000000000 R11: 0000000000000287 R12: 0=
000000000000000
> [  369.979957][   T43] R13: 00007fffb3f40350 R14: 00007fb4a75565f0 R15: 0=
0007fffb3f40350
> [  369.980151][   T43]  </TASK>
> [  369.980252][   T43] INFO: task (spawn):422 blocked for more than 245 s=
econds.
> [  369.980427][   T43]       Not tainted 6.10.0-virtme #1
> [  369.980548][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  369.980759][   T43] task:(spawn)         state:D stack:26464 pid:422  =
 tgid:422   ppid:1      flags:0x00004006
> [  369.980997][   T43] Call Trace:
> [  369.981110][   T43]  <TASK>
> [  369.981181][   T43]  __schedule+0x6e0/0x17e0
> [  369.981321][   T43]  ? __pfx___schedule+0x10/0x10
> [  369.981441][   T43]  ? schedule+0x1a5/0x210
> [  369.981533][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.981652][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.981775][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.981926][   T43]  ? schedule+0x1a5/0x210
> [  369.982024][   T43]  schedule+0xdf/0x210
> [  369.982122][   T43]  d_alloc_parallel+0xaef/0xed0
> [  369.982297][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  369.982422][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  369.982584][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  369.982738][   T43]  __lookup_slow+0x17f/0x3c0
> [  369.982859][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  369.982994][   T43]  ? walk_component+0x29e/0x4f0
> [  369.983152][   T43]  walk_component+0x2ab/0x4f0
> [  369.983293][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  369.983483][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  369.983641][   T43]  path_openat+0x1be/0x440
> [  369.983781][   T43]  ? __pfx_path_openat+0x10/0x10
> [  369.983900][   T43]  ? hlock_class+0x4e/0x130
> [  369.984034][   T43]  ? mark_lock+0x38/0x3e0
> [  369.984135][   T43]  do_filp_open+0x1b3/0x3e0
> [  369.984273][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  369.984430][   T43]  ? __lock_release+0x103/0x460
> [  369.984552][   T43]  ? __create_object+0x5e/0xb0
> [  369.984689][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.984811][   T43]  ? hlock_class+0x4e/0x130
> [  369.984957][   T43]  ? mark_held_locks+0x9e/0xe0
> [  369.985081][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  369.985256][   T43]  do_open_execat+0xb0/0x280
> [  369.985395][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  369.985521][   T43]  ? getname_kernel+0x14c/0x2d0
> [  369.985647][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  369.985772][   T43]  open_exec+0x2b/0x50
> [  369.985867][   T43]  load_elf_binary+0x504/0x2880
> [  369.985995][   T43]  ? find_held_lock+0x2c/0x110
> [  369.986118][   T43]  ? __lock_release+0x103/0x460
> [  369.986255][   T43]  ? search_binary_handler+0x134/0x550
> [  369.986399][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.986519][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.986661][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.986801][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  369.986926][   T43]  ? search_binary_handler+0x134/0x550
> [  369.987070][   T43]  search_binary_handler+0x152/0x550
> [  369.987193][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  369.987351][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  369.987473][   T43]  ? exec_binprm+0x100/0x3c0
> [  369.987598][   T43]  exec_binprm+0x119/0x3c0
> [  369.987728][   T43]  bprm_execve+0xe9/0x4f0
> [  369.987821][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  369.987947][   T43]  __x64_sys_execve+0x8c/0xb0
> [  369.988070][   T43]  do_syscall_64+0xc1/0x1d0
> [  369.988192][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  369.988347][   T43] RIP: 0033:0x7fa4f34f740b
> [  369.988472][   T43] RSP: 002b:00007ffd893fd6d8 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  369.988655][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d5daf0 RCX: 0=
0007fa4f34f740b
> [  369.988835][   T43] RDX: 0000560ac3d62360 RSI: 0000560ac3d76bc0 RDI: 0=
000560ac3d8d8f0
> [  369.989010][   T43] RBP: 00007ffd893fd800 R08: 0000000000000000 R09: 0=
000000000000000
> [  369.989188][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffd89401890
> [  369.989372][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd893fd720 R15: 0=
000000000000000
> [  369.989566][   T43]  </TASK>
> [  369.989659][   T43] INFO: task (spawn):423 blocked for more than 245 s=
econds.
> [  369.989828][   T43]       Not tainted 6.10.0-virtme #1
> [  369.989939][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  369.990129][   T43] task:(spawn)         state:D stack:26608 pid:423  =
 tgid:423   ppid:1      flags:0x00004006
> [  369.990382][   T43] Call Trace:
> [  369.990476][   T43]  <TASK>
> [  369.990547][   T43]  __schedule+0x6e0/0x17e0
> [  369.990674][   T43]  ? __pfx___schedule+0x10/0x10
> [  369.990795][   T43]  ? schedule+0x1a5/0x210
> [  369.990890][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.991008][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.991128][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.991321][   T43]  ? schedule+0x1a5/0x210
> [  369.991418][   T43]  schedule+0xdf/0x210
> [  369.991516][   T43]  d_alloc_parallel+0xaef/0xed0
> [  369.991647][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  369.991824][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  369.991973][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  369.992102][   T43]  __lookup_slow+0x17f/0x3c0
> [  369.992234][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  369.992416][   T43]  ? walk_component+0x29e/0x4f0
> [  369.992552][   T43]  walk_component+0x2ab/0x4f0
> [  369.992694][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  369.992846][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  369.993134][   T43]  path_openat+0x1be/0x440
> [  369.993291][   T43]  ? __pfx_path_openat+0x10/0x10
> [  369.993412][   T43]  ? hlock_class+0x4e/0x130
> [  369.993572][   T43]  ? mark_lock+0x38/0x3e0
> [  369.993671][   T43]  do_filp_open+0x1b3/0x3e0
> [  369.993858][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  369.994001][   T43]  ? __lock_release+0x103/0x460
> [  369.994124][   T43]  ? __create_object+0x5e/0xb0
> [  369.994282][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.994475][   T43]  ? hlock_class+0x4e/0x130
> [  369.994611][   T43]  ? mark_held_locks+0x9e/0xe0
> [  369.994733][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  369.994885][   T43]  do_open_execat+0xb0/0x280
> [  369.995060][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  369.995200][   T43]  ? getname_kernel+0x14c/0x2d0
> [  369.995349][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  369.995472][   T43]  open_exec+0x2b/0x50
> [  369.995619][   T43]  load_elf_binary+0x504/0x2880
> [  369.995745][   T43]  ? find_held_lock+0x2c/0x110
> [  369.995867][   T43]  ? __lock_release+0x103/0x460
> [  369.995986][   T43]  ? search_binary_handler+0x134/0x550
> [  369.996105][   T43]  ? __pfx___lock_release+0x10/0x10
> [  369.996289][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  369.996414][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  369.996536][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  369.996670][   T43]  ? search_binary_handler+0x134/0x550
> [  369.996863][   T43]  search_binary_handler+0x152/0x550
> [  369.997001][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  369.997154][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  369.997296][   T43]  ? exec_binprm+0x100/0x3c0
> [  369.997475][   T43]  exec_binprm+0x119/0x3c0
> [  369.997628][   T43]  bprm_execve+0xe9/0x4f0
> [  369.997730][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  369.997874][   T43]  __x64_sys_execve+0x8c/0xb0
> [  369.998058][   T43]  do_syscall_64+0xc1/0x1d0
> [  369.998212][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  369.998382][   T43] RIP: 0033:0x7fa4f34f740b
> [  369.998530][   T43] RSP: 002b:00007ffd89405918 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  369.998781][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d94430 RCX: 0=
0007fa4f34f740b
> [  369.998962][   T43] RDX: 0000560ac3d5ff20 RSI: 0000560ac3d76cd0 RDI: 0=
000560ac3d5e240
> [  369.999164][   T43] RBP: 00007ffd89405a40 R08: 0000000000000008 R09: 0=
000000000000000
> [  369.999409][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
000560ac3d767d0
> [  369.999584][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd89405960 R15: 0=
000000000000000
> [  369.999775][   T43]  </TASK>
> [  369.999921][   T43] INFO: task (spawn):424 blocked for more than 245 s=
econds.
> [  370.000087][   T43]       Not tainted 6.10.0-virtme #1
> [  370.000198][   T43] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  370.000445][   T43] task:(spawn)         state:D stack:26464 pid:424  =
 tgid:424   ppid:1      flags:0x00004006
> [  370.000676][   T43] Call Trace:
> [  370.000765][   T43]  <TASK>
> [  370.000833][   T43]  __schedule+0x6e0/0x17e0
> [  370.001017][   T43]  ? __pfx___schedule+0x10/0x10
> [  370.001136][   T43]  ? schedule+0x1a5/0x210
> [  370.001239][   T43]  ? __pfx___lock_release+0x10/0x10
> [  370.001372][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  370.001513][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  370.001692][   T43]  ? schedule+0x1a5/0x210
> [  370.001788][   T43]  schedule+0xdf/0x210
> [  370.001885][   T43]  d_alloc_parallel+0xaef/0xed0
> [  370.002017][   T43]  ? __pfx_d_alloc_parallel+0x10/0x10
> [  370.002195][   T43]  ? __pfx_default_wake_function+0x10/0x10
> [  370.002364][   T43]  ? lockdep_init_map_type+0x2cb/0x7c0
> [  370.002497][   T43]  __lookup_slow+0x17f/0x3c0
> [  370.002617][   T43]  ? __pfx___lookup_slow+0x10/0x10
> [  370.002884][   T43]  ? walk_component+0x29e/0x4f0
> [  370.003020][   T43]  walk_component+0x2ab/0x4f0
> [  370.003161][   T43]  link_path_walk.part.0.constprop.0+0x416/0x940
> [  370.003326][   T43]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x=
10
> [  370.003537][   T43]  path_openat+0x1be/0x440
> [  370.003660][   T43]  ? __pfx_path_openat+0x10/0x10
> [  370.003780][   T43]  ? hlock_class+0x4e/0x130
> [  370.003899][   T43]  ? mark_lock+0x38/0x3e0
> [  370.003997][   T43]  do_filp_open+0x1b3/0x3e0
> [  370.004178][   T43]  ? __pfx_do_filp_open+0x10/0x10
> [  370.004318][   T43]  ? __lock_release+0x103/0x460
> [  370.004442][   T43]  ? __create_object+0x5e/0xb0
> [  370.004562][   T43]  ? __pfx___lock_release+0x10/0x10
> [  370.004737][   T43]  ? hlock_class+0x4e/0x130
> [  370.004882][   T43]  ? mark_held_locks+0x9e/0xe0
> [  370.005005][   T43]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [  370.005160][   T43]  do_open_execat+0xb0/0x280
> [  370.005376][   T43]  ? __pfx_do_open_execat+0x10/0x10
> [  370.005503][   T43]  ? getname_kernel+0x14c/0x2d0
> [  370.005625][   T43]  ? __kmalloc_noprof+0x1d7/0x3d0
> [  370.005747][   T43]  open_exec+0x2b/0x50
> [  370.005896][   T43]  load_elf_binary+0x504/0x2880
> [  370.006022][   T43]  ? find_held_lock+0x2c/0x110
> [  370.006144][   T43]  ? __lock_release+0x103/0x460
> [  370.006278][   T43]  ? search_binary_handler+0x134/0x550
> [  370.006399][   T43]  ? __pfx___lock_release+0x10/0x10
> [  370.006572][   T43]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  370.006698][   T43]  ? trace_lock_acquire+0x14d/0x1f0
> [  370.006819][   T43]  ? __pfx_load_elf_binary+0x10/0x10
> [  370.006943][   T43]  ? search_binary_handler+0x134/0x550
> [  370.007121][   T43]  search_binary_handler+0x152/0x550
> [  370.007252][   T43]  ? __pfx_search_binary_handler+0x10/0x10
> [  370.007401][   T43]  ? __task_pid_nr_ns+0x11a/0x410
> [  370.007522][   T43]  ? exec_binprm+0x100/0x3c0
> [  370.007703][   T43]  exec_binprm+0x119/0x3c0
> [  370.007830][   T43]  bprm_execve+0xe9/0x4f0
> [  370.007923][   T43]  do_execveat_common.isra.0+0x3eb/0x530
> [  370.008047][   T43]  __x64_sys_execve+0x8c/0xb0
> [  370.008234][   T43]  do_syscall_64+0xc1/0x1d0
> [  370.008359][   T43]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  370.008506][   T43] RIP: 0033:0x7fa4f34f740b
> [  370.008628][   T43] RSP: 002b:00007ffd893fd6d8 EFLAGS: 00000246 ORIG_R=
AX: 000000000000003b
> [  370.008863][   T43] RAX: ffffffffffffffda RBX: 0000560ac3d2df30 RCX: 0=
0007fa4f34f740b
> [  370.009043][   T43] RDX: 0000560ac3d7ff10 RSI: 0000560ac3d8d940 RDI: 0=
000560ac3d33950
> [  370.009216][   T43] RBP: 00007ffd893fd800 R08: 0000000000000000 R09: 0=
000000000000000
> [  370.009461][   T43] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
0007ffd89401890
> [  370.009635][   T43] R13: 00007fa4f2c3a9d8 R14: 00007ffd893fd720 R15: 0=
000000000000000
> [  370.009830][   T43]  </TASK>
> [  370.009975][   T43] Future hung task reports are suppressed, see sysct=
l kernel.hung_task_warnings
> [  370.010169][   T43]
> [  370.010169][   T43] Showing all locks held in the system:
> [  370.010359][   T43] 1 lock held by khungtaskd/43:
> [  370.010531][   T43]  #0: ffffffff97b54b80 (rcu_read_lock){....}-{1:2},=
 at: debug_show_all_locks+0x70/0x3a0
> [  370.010753][   T43] 1 lock held by ip/419:
> [  370.010840][   T43]  #0: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  370.011146][   T43] 1 lock held by rename_device/421:
> [  370.011269][   T43]  #0: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  370.011511][   T43] 2 locks held by (spawn)/422:
> [  370.011678][   T43]  #0: ffff888005bc4238 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  370.011888][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  370.012133][   T43] 2 locks held by (spawn)/423:
> [  370.012365][   T43]  #0: ffff888005bc0578 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  370.012579][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  370.012874][   T43] 2 locks held by (spawn)/424:
> [  370.012988][   T43]  #0: ffff888005bc0c38 (&sig->cred_guard_mutex){+.+=
.}-{3:3}, at: bprm_execve+0x51/0x4f0
> [  370.013202][   T43]  #1: ffff888001470148 (&type->i_mutex_dir_key#3){+=
+++}-{3:3}, at: walk_component+0x29e/0x4f0
> [  370.013512][   T43]
> [  370.013571][   T43] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [  370.013571][   T43]
