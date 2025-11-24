Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCC25B1FF
	for <v9fs@lists.linux.dev>; Mon, 24 Nov 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764026852; cv=none; b=iEPTbNbf3YNMi6zF0I6gMdsnDpqzOUXIwad8jfEORl44RCWVW4X5ccR8IvgpLvQEzgXB/vuRkKeYrxtDhgJ7rEuZKQmZiu1kvbiK/LYkPTc54HaOI0fMqYfTyH4ghrSt0GP2y7skz8Co5MBL9ZxZS2ZZvoRZKtJ9TUrDrOQb+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764026852; c=relaxed/simple;
	bh=dGAG10xO8VXPW+sUE1sXmgiahpve12/AcxOg5jgZeiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUfcx+fH82W//V6c2VaRBSFo+p0rJKtnM9Tey9ZEhtvWXqvQHRzbJyjyIhZOPBjvKCAuUZ9l1nvArKXQojbLfIAXDtYj7UXCOSAjmBRylv4aKt5rtNmDwXlv/qrR+6LsKjle2GoPG/0WROiFWi1ElMKY9Fr36Zfas5X0tgpboXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=SRVHDbDK; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="SRVHDbDK"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9408B14C2D6;
	Tue, 25 Nov 2025 00:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764025957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHe8kA3UixkjmHdRvcFr/2nQDsUu3jj+kP//EkNN89c=;
	b=SRVHDbDKXLwtYbc8mx4GRNwNFR3+jfNKuKMbR7Yrz4Vc9jGV5FDzVqhBzlfEXi7fPOYJ2E
	o6vfuelGBngxcp6P5TIEW/YoT4PQ0L8PslQiaACNlGMfGdqepW58GwpYW858aHblO7pCmv
	rABlXZiUHT76JKi98lWul7TcsJ2kvW2K+PA6GOeyvsC8N3LpeFLg2x+Rwk0efx2QKK3iC2
	ELpME1vtC/FSsHfsxlt1zpy0Mw5YScXKMq0iaqcnld2RjdxzK2LylsgsNn8liSFeb8af/G
	q9lW0vkTU5U+95cuYL9r7p8uQrFtMtiPdu+in87MSe51YKfAyLTdmcy00LT2ww==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9e7c5e13;
	Mon, 24 Nov 2025 23:12:32 +0000 (UTC)
Date: Tue, 25 Nov 2025 08:12:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aSTmUTOIm4hnU7aw@codewreck.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSR-C4ahmNRoUV58@861G6M3>

Chris Arges wrote on Mon, Nov 24, 2025 at 09:47:23AM -0600:
> Hello, I found a potential issue in 9p/netfs, I can easily reproduce this on
> my end. Happy to run additional tests, collect info or test patches as needed.

Thanks for the report! I've added a few folks in cc.

> When testing v6.18-rc7 I noticed a crash when doing the following:
> - Launch the kernel using vng: https://github.com/arighi/virtme-ng
>   - This uses 9p/virtio to connect to the root filesystem as RW
> - From within the VM do the following:
> ```
> dd if=/dev/zero of=./xfs.img bs=1M count=300
> yes | mkfs.xfs -b size=8192 ./xfs.img
> rm -rf ./mount && mkdir -p ./mount
> mount -o loop ./xfs.img ./mount
> ```

Just a note this needs CONFIG_TRANSPARENT_HUGEPAGE to mount a xfs
filesystem with block size > page size
With this (and loop, xfs, 9p etc) enabled I could run this script,
but it didn't blow up on my 9p-next branch;
I'll try on v6.18-rc7 next but I ran out of time before going to work.
If you could attach your .config it'd be great to check if I still don't
repro.


> When the loop-back mount occurs the system crashes immediately with
> the following:
> [   31.276957][  T255] loop0: detected capacity change from 0 to 614400
> [   31.286377][  T255] XFS (loop0): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
> [   31.286624][  T255] XFS (loop0): Mounting V5 Filesystem fa3c2d3c-b936-4ee3-a5a8-e80ba36298cc
> [   31.395721][   T62] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102600
> [   31.395833][   T62] head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   31.395915][   T62] flags: 0x2ffff800000040(head|node=0|zone=2|lastcpupid=0x1ffff)
> [   31.395976][   T62] page_type: f8(unknown)
> [   31.396004][   T62] raw: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
> [   31.396092][   T62] raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
> [   31.396174][   T62] head: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
> [   31.396251][   T62] head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
> [   31.396339][   T62] head: 002ffff800000009 ffffea0004098001 00000000ffffffff 00000000ffffffff
> [   31.396425][   T62] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000200
> [   31.396523][   T62] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
> [   31.396641][   T62] ------------[ cut here ]------------
> [   31.396689][   T62] kernel BUG at include/linux/mm.h:1386!
> [   31.396748][   T62] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   31.396820][   T62] CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 6.18.0-rc7-cloudflare-2025.11.11-21-gab0ed6ff #1 PREEMPT(voluntary)
> [   31.396947][   T62] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 2025.02-8 05/13/2025                                                                                                                   [   31.397031][   T62] Workqueue: loop0 loop_rootcg_workfn
> [   31.397084][   T62] RIP: 0010:__iov_iter_get_pages_alloc+0x7b6/0x920
> [   31.397152][   T62] Code: 08 4c 89 5d 10 44 88 55 20 e9 0d fb ff ff 0f 0b 4d 85 ed 0f 85 fc fb ff ff e9 38 fd ff ff 48 c7 c6 20 88 6d 83 e8 fa 2f b7 ff <0f> 0b 31 f6 b9 c0 0c 00 00 ba 01 00 00 00 4c 89 0c 24 48 8d 3
> c dd
> [   31.397310][   T62] RSP: 0018:ffffc90000257908 EFLAGS: 00010246
> [   31.397365][   T62] RAX: 000000000000005c RBX: 0000000000000020 RCX: 0000000000000003
> [   31.397424][   T62] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff83f38508
> [   31.397498][   T62] RBP: ffff888101af90f8 R08: 0000000000000000 R09: ffffc900002577a0
> [   31.397571][   T62] R10: ffffffff83f084c8 R11: 0000000000000003 R12: 0000000000020000
> [   31.397654][   T62] R13: ffffc90000257a70 R14: ffffc90000257a68 R15: ffffea0004098000
> [   31.397727][   T62] FS:  0000000000000000(0000) GS:ffff8882b3266000(0000) knlGS:0000000000000000
> [   31.397819][   T62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.397890][   T62] CR2: 00007f846eb985a0 CR3: 0000000004620003 CR4: 0000000000772ef0
> [   31.397964][   T62] PKRU: 55555554
> [   31.398005][   T62] Call Trace:
> [   31.398045][   T62]  <TASK>
> [   31.398075][   T62]  ? kvm_sched_clock_read+0x11/0x20
> [   31.398131][   T62]  ? sched_clock+0x10/0x30
> [   31.398179][   T62]  ? sched_clock_cpu+0xf/0x1d0
> [   31.398234][   T62]  iov_iter_get_pages_alloc2+0x20/0x50
> [   31.398277][   T62]  p9_get_mapped_pages.part.0.constprop.0+0x6f/0x280 [9pnet_virtio]
> [   31.398354][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
> [   31.398413][   T62]  ? pdu_write+0x2d/0x40 [9pnet]
> [   31.398464][   T62]  p9_virtio_zc_request+0x92/0x69a [9pnet_virtio]
> [   31.398530][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
> [   31.398582][   T62]  ? p9pdu_finalize+0x32/0x90 [9pnet]
> [   31.398620][   T62]  ? p9_client_prepare_req+0xbe/0x150 [9pnet]
> [   31.398693][   T62]  p9_client_zc_rpc.constprop.0+0xf4/0x2f0 [9pnet]
> [   31.398768][   T62]  ? p9_client_xattrwalk+0x148/0x1d0 [9pnet]
> [   31.398840][   T62]  p9_client_write+0x16a/0x240 [9pnet]
> [   31.398887][   T62]  ? __kmalloc_cache_noprof+0x2f3/0x5a0
> [   31.398939][   T62]  v9fs_issue_write+0x3a/0x80 [9p]
> [   31.399002][   T62]  netfs_advance_write+0xd3/0x2b0 [netfs]
> [   31.399069][   T62]  netfs_unbuffered_write+0x66/0xb0 [netfs]
> [   31.399131][   T62]  netfs_unbuffered_write_iter_locked+0x1cd/0x220 [netfs]
> [   31.399202][   T62]  netfs_unbuffered_write_iter+0x100/0x1d0 [netfs]
> [   31.399265][   T62]  lo_rw_aio.isra.0+0x2e7/0x330
> [   31.399321][   T62]  loop_process_work+0x86/0x420
> [   31.399380][   T62]  process_one_work+0x192/0x350
> [   31.399434][   T62]  worker_thread+0x2d3/0x400
> [   31.399493][   T62]  ? __pfx_worker_thread+0x10/0x10
> [   31.399559][   T62]  kthread+0xfc/0x240
> [   31.399605][   T62]  ? __pfx_kthread+0x10/0x10
> [   31.399660][   T62]  ? _raw_spin_unlock+0xe/0x30
> [   31.399711][   T62]  ? finish_task_switch.isra.0+0x8d/0x280
> [   31.399764][   T62]  ? __pfx_kthread+0x10/0x10
> [   31.399820][   T62]  ? __pfx_kthread+0x10/0x10
> [   31.399878][   T62]  ret_from_fork+0x113/0x130
> [   31.399931][   T62]  ? __pfx_kthread+0x10/0x10
> [   31.399992][   T62]  ret_from_fork_asm+0x1a/0x30
> [   31.400050][   T62]  </TASK>
> [   31.400088][   T62] Modules linked in: kvm_intel kvm irqbypass aesni_intel rapl i2c_piix4 i2c_smbus tiny_power_button button configfs virtio_mmio virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_console
>  9pnet_virtio virtiofs virtio virtio_ring fuse 9p 9pnet netfs
> [   31.400365][   T62] ---[ end trace 0000000000000000 ]---
> [   31.405087][   T62] RIP: 0010:__iov_iter_get_pages_alloc+0x7b6/0x920
> [   31.405166][   T62] Code: 08 4c 89 5d 10 44 88 55 20 e9 0d fb ff ff 0f 0b 4d 85 ed 0f 85 fc fb ff ff e9 38 fd ff ff 48 c7 c6 20 88 6d 83 e8 fa 2f b7 ff <0f> 0b 31 f6 b9 c0 0c 00 00 ba 01 00 00 00 4c 89 0c 24 48 8d 3
> c dd
> [   31.405281][   T62] RSP: 0018:ffffc90000257908 EFLAGS: 00010246
> [   31.405328][   T62] RAX: 000000000000005c RBX: 0000000000000020 RCX: 0000000000000003
> [   31.405383][   T62] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff83f38508
> [   31.405456][   T62] RBP: ffff888101af90f8 R08: 0000000000000000 R09: ffffc900002577a0
> [   31.405516][   T62] R10: ffffffff83f084c8 R11: 0000000000000003 R12: 0000000000020000
> [   31.405593][   T62] R13: ffffc90000257a70 R14: ffffc90000257a68 R15: ffffea0004098000
> [   31.405665][   T62] FS:  0000000000000000(0000) GS:ffff8882b3266000(0000) knlGS:0000000000000000
> [   31.405730][   T62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.405774][   T62] CR2: 00007f846eb985a0 CR3: 0000000004620004 CR4: 0000000000772ef0
> [   31.405837][   T62] PKRU: 55555554
> [   31.434509][    C4] ------------[ cut here ]------------
> 

Thanks,
-- 
Dominique Martinet | Asmadeus
