Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFE6FA7
	for <v9fs@lists.linux.dev>; Sun, 31 Mar 2024 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863231; cv=none; b=kJcwOPx3q9s7LfAi42SHLLrIt/bbcAYR/8b00Zc8BkcDkuJhsIpTdLfDVnNkMPXRjE0ashNdn01IhnhUIyquZl0Gz94qXAVU5ORLafpsXbjOD4jyLfgKUTnr13aJbPp2TcFR88b58iVdg+Z8pakwScbU89Eztg1TuTIF2tj913Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863231; c=relaxed/simple;
	bh=3jfilzt/0f9+GTsk+WmZkpD3G6FRHcuN6HxD3SqY18I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eqEl/XLEn1akLoVQXyONkTGcydrSjrTFeg4KMUzjqm+kS+MWeZFcTz3rKI1yiIdBS0N9k2OqI09Lj1fEkT8a2a0sGQlXqX5gFMTDuR8vqAYuI36CvG4gOGZ63fx+JeUST5+mhP9iToWpCF5T28QCMxAWQunO0U+ZhU1L7fozcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PXpxgwq9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PXpxgwq9"
Date: Sun, 31 Mar 2024 01:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711863225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jUnk5kh1m4H8MOsikY0d/g/mRAYq0waGaXn41UlKb+g=;
	b=PXpxgwq9VgL+FbRUhmar4YUm3PlQuRPmWISLNv9DgDXYtNUqGCMZJbCALDbkM+q+GIdfD6
	CCkmC1jIlufV+9G5+pw4HtK4ZKgfKtY3UNcq/CIIkZ0rP3BSiTyKfOf5r38ZyM+3BA8Zs6
	jVaQEHtvZElbEDGDph7EHsak0u9s2W0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: v9fs@lists.linux.dev
Subject: new 9p kasan splat in 6.9
Message-ID: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

00000 Running test kasan-ec.ktest on farm2 at /home/testdashboard/linux-5
00164 building kernel... done
00169 systemd[1]: Failed to find module 'autofs4'
00170 ==================================================================
00170 BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0x7f8/0x988
00170 Read of size 8 at addr ffff0000c12f9000 by task mount/217
00170 
00170 CPU: 3 PID: 217 Comm: mount Not tainted 6.9.0-rc1-ktest-ga097468ffe82 #10998
00170 Hardware name: linux,dummy-virt (DT)
00170 Call trace:
00170  dump_backtrace+0xa4/0xe0
00170  show_stack+0x1c/0x30
00170  dump_stack_lvl+0x70/0x88
00170  print_report+0x110/0x5b8
00170  kasan_report+0x80/0xc0
00170  __asan_report_load8_noabort+0x1c/0x28
00170  v9fs_stat2inode_dotl+0x7f8/0x988
00170  v9fs_fid_iget_dotl+0x164/0x1f0
00170  v9fs_mount+0x380/0x718
00170  legacy_get_tree+0xd4/0x198
00170  vfs_get_tree+0x78/0x240
00170  path_mount+0xc6c/0x15f0
00170  do_mount+0xc4/0x100
00170  __arm64_sys_mount+0x228/0x330
00170  invoke_syscall.constprop.0+0x74/0x1e8
00170  do_el0_svc+0xc8/0x200
00170  el0_svc+0x20/0x60
00170  el0t_64_sync_handler+0xb8/0xc0
00170  el0t_64_sync+0x14c/0x150
00170 
00170 Allocated by task 217:
00170 
00170 Freed by task 217:
00170 
00170 The buggy address belongs to the object at ffff0000c12f9000
00170  which belongs to the cache kmalloc-192 of size 192
00170 The buggy address is located 0 bytes inside of
00170  freed 192-byte region [ffff0000c12f9000, ffff0000c12f90c0)
00170 
00170 The buggy address belongs to the physical page:
00170 
00170 Memory state around the buggy address:
00170  ffff0000c12f8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00170  ffff0000c12f8f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
00170 >ffff0000c12f9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
00170                    ^
00170  ffff0000c12f9080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
00170  ffff0000c12f9100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
00170 ==================================================================
00170 Kernel panic - not syncing: kasan.fault=panic set ...
00170 CPU: 3 PID: 217 Comm: mount Not tainted 6.9.0-rc1-ktest-ga097468ffe82 #10998
00170 Hardware name: linux,dummy-virt (DT)
00170 Call trace:
00170  dump_backtrace+0xa4/0xe0
00170  show_stack+0x1c/0x30
00170  dump_stack_lvl+0x34/0x88
00170  dump_stack+0x18/0x20
00170  panic+0x4dc/0x520
00170  end_report+0xec/0xf0
00170  kasan_report+0x90/0xc0
00170  __asan_report_load8_noabort+0x1c/0x28
00170  v9fs_stat2inode_dotl+0x7f8/0x988
00170  v9fs_fid_iget_dotl+0x164/0x1f0
00170  v9fs_mount+0x380/0x718
00170  legacy_get_tree+0xd4/0x198
00170  vfs_get_tree+0x78/0x240
00170  path_mount+0xc6c/0x15f0
00170  do_mount+0xc4/0x100
00170  __arm64_sys_mount+0x228/0x330
00170  invoke_syscall.constprop.0+0x74/0x1e8
00170  do_el0_svc+0xc8/0x200
00170  el0_svc+0x20/0x60
00170  el0t_64_sync_handler+0xb8/0xc0
00170  el0t_64_sync+0x14c/0x150
00170 SMP: stopping secondary CPUs
00170 Kernel Offset: disabled
00170 CPU features: 0x0,00000003,80000008,4240500b
00170 Memory Limit: none
00170 ---[ end Kernel panic - not syncing: kasan.fault=panic set ... ]---
00175 ========= FAILED TIMEOUT (no test) in 1200s
