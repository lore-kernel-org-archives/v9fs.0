Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5748272E42;
	Mon, 24 Nov 2025 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028571; cv=none; b=Vtngzy4wDABbTHXbFYq6nWaR27iclwtn6djBAtchT3PTKmBCFb3M0fvS12Ohe2mwIijLZu5CQ11zQ+Nm8eqBobA7iFH39W5rMRKNuePB6C7oMjgmldZi+eiT1qrBIIJ8u+6NPEFssCoAUDawfr9fsbpchEjAFiMrFTUdZ1T71wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028571; c=relaxed/simple;
	bh=n8td3E9mxi8iNdDiqfI1lvkOYiEBEweMGJEQaEReb+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns/KtULsXhI1TvxV+uU3ObG94dlDYyCFR/DdmNIBWhye0oWcknvQJ4wrVWYDUSpUeJbg661mv5ePT6gUcnRouEOzlMcdrJdfbstpFmLo7iQk3xaDUE4IJW8+DZY8KTwPrbGt4fUxYkdglkFy8FttEJXVAm5v2TIz9Mex08BtSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mmtt5cuC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mmtt5cuC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O1BUj4eVctyTFfaPNQamWHvQ+gHOmzbeIKhaKroCxao=; b=mmtt5cuCoTAg64fTnWBRhe/OSv
	2Y4jnbpmXfjbsJD0HYIRhHEenS+xfCR3dKpTzZ5AOa+K+lKylQWDR+hQdAxWEIakoBQpaT2nm2fG2
	Ys/OJE6rqDHhMhm8D5pLpVoIGY3AV5+opGKpHNgGE2WzLCOvDZNmTOgDpJ4D0EkcH6yNj4n2M+4It
	0tiVAKe0dUp6ZGGh0ty2Iy10JHNRtfXdpQ9Zwzv7XDg67BNOD/BL/8p7jb0OcdsJUM2HN7xLeUmN7
	DhZ6aJO4kd69LgRgFQP19+kv1UqMClRS/OCqFpBQ+frd+HDvs55wlTiYLr1suA5T2O14vQwfwfpMz
	moRGLPhw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgPX-00000007j59-25wg;
	Mon, 24 Nov 2025 23:55:59 +0000
Date: Mon, 24 Nov 2025 23:55:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Chris Arges <carges@cloudflare.com>,
	David Howells <dhowells@redhat.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: kernel BUG when mounting large block xfs backed by 9p (folio ref
 count bug)
Message-ID: <aSTwj8LfyFvAXEqc@casper.infradead.org>
References: <aSR-C4ahmNRoUV58@861G6M3>
 <aSTmUTOIm4hnU7aw@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTmUTOIm4hnU7aw@codewreck.org>

On Tue, Nov 25, 2025 at 08:12:17AM +0900, Dominique Martinet wrote:
> > When the loop-back mount occurs the system crashes immediately with
> > the following:
> > [   31.276957][  T255] loop0: detected capacity change from 0 to 614400
> > [   31.286377][  T255] XFS (loop0): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
> > [   31.286624][  T255] XFS (loop0): Mounting V5 Filesystem fa3c2d3c-b936-4ee3-a5a8-e80ba36298cc
> > [   31.395721][   T62] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102600
> > [   31.395833][   T62] head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [   31.395915][   T62] flags: 0x2ffff800000040(head|node=0|zone=2|lastcpupid=0x1ffff)
> > [   31.395976][   T62] page_type: f8(unknown)

        PGTY_large_kmalloc      = 0xf8,

So somebody called kmalloc(2 * 1024 * 1024).  Not sure if that's helpful
in tracking this down?

> > [   31.396004][   T62] raw: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
> > [   31.396092][   T62] raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
> > [   31.396174][   T62] head: 002ffff800000040 0000000000000000 dead000000000122 0000000000000000
> > [   31.396251][   T62] head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
> > [   31.396339][   T62] head: 002ffff800000009 ffffea0004098001 00000000ffffffff 00000000ffffffff
> > [   31.396425][   T62] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000200
> > [   31.396523][   T62] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
> > [   31.396641][   T62] ------------[ cut here ]------------
> > [   31.396689][   T62] kernel BUG at include/linux/mm.h:1386!
> > [   31.396748][   T62] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > [   31.396820][   T62] CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 6.18.0-rc7-cloudflare-2025.11.11-21-gab0ed6ff #1 PREEMPT(voluntary)
> > [   31.396947][   T62] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 2025.02-8 05/13/2025                                                                                                                   [   31.397031][   T62] Workqueue: loop0 loop_rootcg_workfn
> > [   31.397084][   T62] RIP: 0010:__iov_iter_get_pages_alloc+0x7b6/0x920
> > [   31.397152][   T62] Code: 08 4c 89 5d 10 44 88 55 20 e9 0d fb ff ff 0f 0b 4d 85 ed 0f 85 fc fb ff ff e9 38 fd ff ff 48 c7 c6 20 88 6d 83 e8 fa 2f b7 ff <0f> 0b 31 f6 b9 c0 0c 00 00 ba 01 00 00 00 4c 89 0c 24 48 8d 3
> > c dd
> > [   31.397310][   T62] RSP: 0018:ffffc90000257908 EFLAGS: 00010246
> > [   31.397365][   T62] RAX: 000000000000005c RBX: 0000000000000020 RCX: 0000000000000003
> > [   31.397424][   T62] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff83f38508
> > [   31.397498][   T62] RBP: ffff888101af90f8 R08: 0000000000000000 R09: ffffc900002577a0
> > [   31.397571][   T62] R10: ffffffff83f084c8 R11: 0000000000000003 R12: 0000000000020000
> > [   31.397654][   T62] R13: ffffc90000257a70 R14: ffffc90000257a68 R15: ffffea0004098000
> > [   31.397727][   T62] FS:  0000000000000000(0000) GS:ffff8882b3266000(0000) knlGS:0000000000000000
> > [   31.397819][   T62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   31.397890][   T62] CR2: 00007f846eb985a0 CR3: 0000000004620003 CR4: 0000000000772ef0
> > [   31.397964][   T62] PKRU: 55555554
> > [   31.398005][   T62] Call Trace:
> > [   31.398045][   T62]  <TASK>
> > [   31.398075][   T62]  ? kvm_sched_clock_read+0x11/0x20
> > [   31.398131][   T62]  ? sched_clock+0x10/0x30
> > [   31.398179][   T62]  ? sched_clock_cpu+0xf/0x1d0
> > [   31.398234][   T62]  iov_iter_get_pages_alloc2+0x20/0x50
> > [   31.398277][   T62]  p9_get_mapped_pages.part.0.constprop.0+0x6f/0x280 [9pnet_virtio]

Oh, hang on.  You're passing a kmalloc'ed page to
iov_iter_get_pages_alloc().  That's not allowed ...

see https://lore.kernel.org/all/20250310142750.1209192-1-willy@infradead.org/

> > [   31.398354][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
> > [   31.398413][   T62]  ? pdu_write+0x2d/0x40 [9pnet]
> > [   31.398464][   T62]  p9_virtio_zc_request+0x92/0x69a [9pnet_virtio]
> > [   31.398530][   T62]  ? p9pdu_vwritef+0xe0/0x6e0 [9pnet]
> > [   31.398582][   T62]  ? p9pdu_finalize+0x32/0x90 [9pnet]
> > [   31.398620][   T62]  ? p9_client_prepare_req+0xbe/0x150 [9pnet]
> > [   31.398693][   T62]  p9_client_zc_rpc.constprop.0+0xf4/0x2f0 [9pnet]
> > [   31.398768][   T62]  ? p9_client_xattrwalk+0x148/0x1d0 [9pnet]
> > [   31.398840][   T62]  p9_client_write+0x16a/0x240 [9pnet]
