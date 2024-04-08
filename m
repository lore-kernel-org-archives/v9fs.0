Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A879C2
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549855; cv=none; b=ONA+V5wyfjJTVixhzXBdkjBaSnMzUtenvrfHuWOcXNphpaHYKfqdftI1/wUrNQ92cw25qCAtyAzqpVUJLdP6Btz/1J4raPO2Uw4NP0WHzSLt7zMbb3IeDxBhr0IF/OmlupHAxF/AOJHzsgnzDvUeO2+n+XunThrmRmBYv0xMYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549855; c=relaxed/simple;
	bh=ZcI6mEXe3BnwhId0+ICZfVvo78rdnKhip5+omPZs+Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jRrBKwPshLijAEww0LzxWOCHsPToXAqGz9SKaUXXJhIXQvP2NKIlg/6jJKG02iVUDuWr1plqnRQNDe9HHRaimL0JqrssEzBPfIj5FeLkjP+q/lTqdmmGEGZcSKEJcry/3/WX5+uwlDZ1X9RdvvnbXhXoafa1SXUgrn+Xt/GYS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rAa/xI86; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=mGmziWWC; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rAa/xI86";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="mGmziWWC"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 1A5FDC01A; Mon,  8 Apr 2024 06:17:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712549848; bh=Xx1HXxU+PxvelRh6zy5L53/cJB2bVRhUgkgrb2r3YXk=;
	h=Date:From:To:Cc:Subject:From;
	b=rAa/xI86hENNSGbiPXuGjHz+arELpQx3t58wU4Elt+L7sTg9m8PKVYs+j3uzsd1x3
	 mNQbGFsw8zou0Wm/p2XG9TbsebYTf4N12mhHBBxvUaPPefAoS8SCy0Lz6ck/S3DcNP
	 szie/HpE9inoseZdWvc23hare8D1B60ZcXBH79RwsCYwdQIlg94S4RXwU/bU+luwiM
	 rLqJ17pMqe2GibH6GNzR3sKzrpgeu76FSsiy3h1YEwLBGV8DTAYAb4NKAfnaTHQzVh
	 das3/rSWuBEyLp0yfVzgmU3Q3PyVXAot1s7fmDZ3lcqS9JekCWk3wip3gTwYeBdfpR
	 oaeZvfxRhFUwQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C28D4C01A;
	Mon,  8 Apr 2024 06:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712549847; bh=Xx1HXxU+PxvelRh6zy5L53/cJB2bVRhUgkgrb2r3YXk=;
	h=Date:From:To:Cc:Subject:From;
	b=mGmziWWCJbwVhKKX+EhxNcjf/vl3rMvwqDd1tM+GZaHnEtlC0dwfxO7axPO1JbUAt
	 trAmRqZITfZAGXkh46vw7o54nQLz6/bzpqtYipA+pD69BmzzSuaFnWbgG7X/e1uAc/
	 eexbAJ9VQ1RimqVlStrtME5ACoq++AAG29of+yrOrwUAtITGiNGye281b1CqsajJUt
	 NAYZNiRNiCyEI6NOV8LfL65b1PvkI/lD7c66dvmtg4+2ceLE5jKqn+SOBg7QgBivkM
	 JG980KoolW6tYrABATeZG7GAMiWfDubKa09KQDw70NtgyCeNi9k97AL+90EZxIUKMC
	 umRH0Tt7YH2BA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 33e72318;
	Mon, 8 Apr 2024 04:17:22 +0000 (UTC)
Date: Mon, 8 Apr 2024 13:17:07 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: recap of 9p problems in 6.9
Message-ID: <ZhNvwwYRN4-EczYi@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Eric (& anyone else reading on the list),

I've spent quite a bit of time testing after Kent's report last week and
we have a few problems, so trying to recap a bit before I blow up (I'm
really busy right now so this is eating up work hours I'm not really
comfortable using for this, and will need to tone it down quite fast)


* Kent's weird error when running xfstests from 9p:
https://lkml.kernel.org/r/f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on
He's saying reverting new patches that got in 6.9 fixes it but didn't
have time to bisect yet as reproduction rate is too low;
I couldn't reproduce yet on my end but we need to either confirm a
single patch to revert or revert the whole thing for another cycle if we
don't figure it out in a few weeks as I don't like the idea of a stable
release with this bug.


* open / unlink / fstat|ftruncate etc fail
https://lkml.kernel.org/r/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev

I didn't confirm yet but I think it's a new bug? maybe the 'fix dups
even in uncached mode' patch dropping v9fs_drop_inode(); that's easy
enough to test just a new bug so didn't look yet


* running apt install in a VM with 9p as rootfs in default cache=none
got me this warning once:
```
[   64.291867] ------------[ cut here ]------------
[   64.292458] WARNING: CPU: 0 PID: 161 at fs/inode.c:332 drop_nlink+0x2a/0x40
[   64.293380] Modules linked in: 9p netfs
[   64.293818] CPU: 0 PID: 161 Comm: dpkg Not tainted 6.9.0-rc2+ #20
[   64.294583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   64.296043] RIP: 0010:drop_nlink+0x2a/0x40
[   64.296518] Code: 0f 1f 44 00 00 55 8b 47 38 48 89 e5 85 c0 74 1a 83 e8 01 89 47 38 75 0c 48 8b 47 18 3e 48 ff 80 30 04 00 00 5d c3 cc cc cc cc <0f> 0b c7 47 38 ff ff ff ff 5d c3 cc cc cc cc 0f 1f 80 00 00 00 00
[   64.298896] RSP: 0018:ffff9e3c8072be18 EFLAGS: 00010246
[   64.299440] RAX: 0000000000000000 RBX: ffff9c49414c4540 RCX: 000000000002bd46
[   64.300239] RDX: ffff9c4941bdac0c RSI: 0000000000033990 RDI: ffff9c49414e8dc0
[   64.301034] RBP: ffff9e3c8072be18 R08: 0000000000000000 R09: ffff9e3c8072bd78
[   64.302328] R10: ffff9e3c8072bd80 R11: ffff9c4942997298 R12: ffff9c49414e8b00
[   64.303610] R13: 0000000000000000 R14: ffff9c49414e8dc0 R15: 0000000000000000
[   64.304904] FS:  00007fdf1a979d00(0000) GS:ffff9c495f200000(0000) knlGS:0000000000000000
[   64.306407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.307390] CR2: 0000561961b47000 CR3: 0000000002580000 CR4: 00000000000006b0
[   64.308679] Call Trace:
[   64.308956]  <TASK>
[   64.309152]  ? show_regs+0x64/0x70
[   64.309644]  ? __warn+0x84/0x120
[   64.310121]  ? drop_nlink+0x2a/0x40
[   64.310620]  ? report_bug+0x15d/0x180
[   64.311182]  ? handle_bug+0x44/0x90
[   64.311684]  ? exc_invalid_op+0x18/0x70
[   64.312268]  ? asm_exc_invalid_op+0x1b/0x20
[   64.312928]  ? drop_nlink+0x2a/0x40
[   64.313429]  v9fs_remove+0x132/0x280 [9p]
[   64.314077]  v9fs_vfs_unlink+0x10/0x20 [9p]
[   64.314732]  vfs_unlink+0x135/0x2c0
[   64.315245]  do_unlinkat+0x231/0x2b0
[   64.315764]  __x64_sys_unlink+0x23/0x30
[   64.316340]  do_syscall_64+0x5f/0x130
[   64.316883]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   64.317734] RIP: 0033:0x7fdf1ab0ea07
[   64.318257] Code: f0 ff ff 73 01 c3 48 8b 0d f6 83 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 83 0d 00 f7 d8 64 89 01 48
[   64.322093] RSP: 002b:00007fff0b13fc58 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
[   64.323478] RAX: ffffffffffffffda RBX: 00005619848be5e0 RCX: 00007fdf1ab0ea07
[   64.324768] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000056198492ad40
[   64.326081] RBP: 000056198492ad40 R08: 0000000000000007 R09: 00005619848bdfb0
[   64.327371] R10: ed3dec18d54433a1 R11: 0000000000000202 R12: 00005619848bdef0
[   64.328657] R13: 0000561961b30040 R14: 0000561961b431d8 R15: 00007fdf1ac6e020
[   64.329969]  </TASK>
[   64.330185] ---[ end trace 0000000000000000 ]---
```

Doesn't seem to be everytime, I don't think it happened before but given
I didn't look into reproducing it I couldn't say for sure.


* some refcounting bug running this (creating/removing the same files many
times in parallel).

This doesn't seem new as I reproduce it without the 6.9 patches, I'll
need to dig into it.

```
mkdir tmp
echo test > tmp/test
for i in 1 2 3 4 5; do
	seq 1 1000 | while read _; do
		cp -a tmp copy 2>/dev/null
		rm -rf copy 2>/dev/null 
	done &
done
wait
```

I also had a qemu segfault after a similar script (copying/removing a
larger tree), but looking at the code/locals I don't see how it could
fail there given the locals... giving up on this for now, it happened
after refcount UAF error on linux so might be caused by garbage we sent,
but that's still a problem obviously)
```
(gdb) bt
#0  __memcmp_avx2_movbe () at ../sysdeps/x86_64/multiarch/memcmp-avx2-movbe.S:415
#1  0x000064d9dd7a5716 in v9fs_mark_fids_unreclaim (pdu=pdu@entry=0x64d9e16ffe58, path=path@entry=0x74d9888c8f70) at ../hw/9pfs/9p.c:545
#2  0x000064d9dd7aa7ad in v9fs_unlinkat (opaque=0x64d9e16ffe58) at ../hw/9pfs/9p.c:3189
#3  0x000064d9ddd4d64b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
#4  0x000074da302bf510 in ?? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:90 from /nix/store/cyrrf49i2hm1w7vn2j945ic3rrzgxbqs-glibc-2.38-44/lib/libc.so.6
#5  0x00007fff7b8c4e30 in ?? ()
#6  0x0000000000000000 in ?? ()
(gdb) p fidp->path
$1 = {size = 29, data = 0x74d96c001010 "./copy/1/tests/btrfs/007.out"}
(gdb) p *path
$2 = {size = 29, data = 0x74da1c001e00 "./copy/4/tests/btrfs/049.out"}
# failing on this line:...
	!memcmp(fidp->path.data, path->data, path->size)) {
```

-- 
Dominique Martinet | Asmadeus
