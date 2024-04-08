Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12E537F2
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618054; cv=none; b=k09/vRk2WEL6I98ODa16yaFw+V4lwbCLI3Y4BceDiDxf7SFT0/PvDkbYx7YDsdOeZn92PIf0Y6mvYI0H/muGIuN2ESQvK8hh7WD/yNvvzVUwiAU80o3DwR/HFA9cy6ynW9jZj/a7aJ0piEzy7u8WMPKqtv7zIhMY0JQ+LIvHmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618054; c=relaxed/simple;
	bh=Y1XmjadP0UQavwBJowKrtO5Y7QfJiFUvfkjmu91XHyk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ToLCP9PQB23wDqSLEgJnynUuoitUZA13fyObBzWCmudLlbF8FWFiNUEXeN4kVwyGxR9iOUXFZPvEH96e+MnbPzhJ9xMHlMNM7yGBvcIzGZLeDiC5kp+QVSF1LN65MSQ4xjLHelvmmCA8dd7G73icKi5ynLQ7i9xlKlljH9ptek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nirahfpy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nirahfpy"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712618049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdudENDXMR0S+UHLa4DYrEZmFtMix2tC5QjdIWhKe1A=;
	b=nirahfpy1N6sIM/1ju6nwbih6gFQJGTaEpLtHVowpWUvC5wycg6EP3lhMto0B6EcXUZ2FG
	pa64tHgtPC8jTdhcGXVU8HWeu/+vdDdAlMKbFPnd5iB4BV4HWflesUlBtQU53Orerxv5K/
	RVz+OVwS6d4TuG0M0JnGvcjlaBgziPQ=
Date: Mon, 08 Apr 2024 23:14:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <6d35e1a6600bf15f835685dc4406c94b902ba0ea@linux.dev>
TLS-Required: No
Subject: Re: recap of 9p problems in 6.9
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
In-Reply-To: <ZhNvwwYRN4-EczYi@codewreck.org>
References: <ZhNvwwYRN4-EczYi@codewreck.org>
X-Migadu-Flow: FLOW_OUT

Thanks for looking into these Dominique - I've got the reports queued up =
and am just looking to ring fence some time to dig into them before I com=
mit to a revert.  The change in handling of inode matching and keeping in=
odes around in the cache longer are likely the root of all of these, but =
the old code had so much unexplained corner cases I really want to unders=
tand the problems before revert.=20=20

The=20create/remove a file multiple times in parallel could be linked to =
an underlying issue with only using qid.path for match -- the old extende=
d match logic also matched i_generation number -- but I convinced myself =
it wasn't necessary and it required a fresh getattr every time which seem=
ed excessive.  The alternative is to work this into a server-side fix, bu=
t if that breaks all legacy than that's likely unacceptable.

    -eric


April 7, 2024 at 11:17 PM, "Dominique Martinet" <asmadeus@codewreck.org> =
wrote:
>=20
>=20Hi Eric (& anyone else reading on the list),
>=20
>=20I've spent quite a bit of time testing after Kent's report last week =
and
>=20
>=20we have a few problems, so trying to recap a bit before I blow up (I'=
m
>=20
>=20really busy right now so this is eating up work hours I'm not really
>=20
>=20comfortable using for this, and will need to tone it down quite fast)
>=20
>=20* Kent's weird error when running xfstests from 9p:
>=20
>=20https://lkml.kernel.org/r/f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qs=
ufg2lo6@2ellaad6b2on
>=20
>=20He's saying reverting new patches that got in 6.9 fixes it but didn't
>=20
>=20have time to bisect yet as reproduction rate is too low;
>=20
>=20I couldn't reproduce yet on my end but we need to either confirm a
>=20
>=20single patch to revert or revert the whole thing for another cycle if=
 we
>=20
>=20don't figure it out in a few weeks as I don't like the idea of a stab=
le
>=20
>=20release with this bug.
>=20
>=20* open / unlink / fstat|ftruncate etc fail
>=20
>=20https://lkml.kernel.org/r/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.=
dev
>=20
>=20I didn't confirm yet but I think it's a new bug? maybe the 'fix dups
>=20
>=20even in uncached mode' patch dropping v9fs_drop_inode(); that's easy
>=20
>=20enough to test just a new bug so didn't look yet
>=20
>=20* running apt install in a VM with 9p as rootfs in default cache=3Dno=
ne
>=20
>=20got me this warning once:
>=20
>=20```
>=20
>=20[ 64.291867] ------------[ cut here ]------------
>=20
>=20[ 64.292458] WARNING: CPU: 0 PID: 161 at fs/inode.c:332 drop_nlink+0x=
2a/0x40
>=20
>=20[ 64.293380] Modules linked in: 9p netfs
>=20
>=20[ 64.293818] CPU: 0 PID: 161 Comm: dpkg Not tainted 6.9.0-rc2+ #20
>=20
>=20[ 64.294583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>=20
>=20[ 64.296043] RIP: 0010:drop_nlink+0x2a/0x40
>=20
>=20[ 64.296518] Code: 0f 1f 44 00 00 55 8b 47 38 48 89 e5 85 c0 74 1a 83=
 e8 01 89 47 38 75 0c 48 8b 47 18 3e 48 ff 80 30 04 00 00 5d c3 cc cc cc =
cc <0f> 0b c7 47 38 ff ff ff ff 5d c3 cc cc cc cc 0f 1f 80 00 00 00 00
>=20
>=20[ 64.298896] RSP: 0018:ffff9e3c8072be18 EFLAGS: 00010246
>=20
>=20[ 64.299440] RAX: 0000000000000000 RBX: ffff9c49414c4540 RCX: 0000000=
00002bd46
>=20
>=20[ 64.300239] RDX: ffff9c4941bdac0c RSI: 0000000000033990 RDI: ffff9c4=
9414e8dc0
>=20
>=20[ 64.301034] RBP: ffff9e3c8072be18 R08: 0000000000000000 R09: ffff9e3=
c8072bd78
>=20
>=20[ 64.302328] R10: ffff9e3c8072bd80 R11: ffff9c4942997298 R12: ffff9c4=
9414e8b00
>=20
>=20[ 64.303610] R13: 0000000000000000 R14: ffff9c49414e8dc0 R15: 0000000=
000000000
>=20
>=20[ 64.304904] FS: 00007fdf1a979d00(0000) GS:ffff9c495f200000(0000) knl=
GS:0000000000000000
>=20
>=20[ 64.306407] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>=20
>=20[ 64.307390] CR2: 0000561961b47000 CR3: 0000000002580000 CR4: 0000000=
0000006b0
>=20
>=20[ 64.308679] Call Trace:
>=20
>=20[ 64.308956] <TASK>
>=20
>=20[ 64.309152] ? show_regs+0x64/0x70
>=20
>=20[ 64.309644] ? __warn+0x84/0x120
>=20
>=20[ 64.310121] ? drop_nlink+0x2a/0x40
>=20
>=20[ 64.310620] ? report_bug+0x15d/0x180
>=20
>=20[ 64.311182] ? handle_bug+0x44/0x90
>=20
>=20[ 64.311684] ? exc_invalid_op+0x18/0x70
>=20
>=20[ 64.312268] ? asm_exc_invalid_op+0x1b/0x20
>=20
>=20[ 64.312928] ? drop_nlink+0x2a/0x40
>=20
>=20[ 64.313429] v9fs_remove+0x132/0x280 [9p]
>=20
>=20[ 64.314077] v9fs_vfs_unlink+0x10/0x20 [9p]
>=20
>=20[ 64.314732] vfs_unlink+0x135/0x2c0
>=20
>=20[ 64.315245] do_unlinkat+0x231/0x2b0
>=20
>=20[ 64.315764] __x64_sys_unlink+0x23/0x30
>=20
>=20[ 64.316340] do_syscall_64+0x5f/0x130
>=20
>=20[ 64.316883] entry_SYSCALL_64_after_hwframe+0x71/0x79
>=20
>=20[ 64.317734] RIP: 0033:0x7fdf1ab0ea07
>=20
>=20[ 64.318257] Code: f0 ff ff 73 01 c3 48 8b 0d f6 83 0d 00 f7 d8 64 89=
 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 83 0d 00 f7 d8 64 89 01 48
>=20
>=20[ 64.322093] RSP: 002b:00007fff0b13fc58 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000057
>=20
>=20[ 64.323478] RAX: ffffffffffffffda RBX: 00005619848be5e0 RCX: 00007fd=
f1ab0ea07
>=20
>=20[ 64.324768] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000561=
98492ad40
>=20
>=20[ 64.326081] RBP: 000056198492ad40 R08: 0000000000000007 R09: 0000561=
9848bdfb0
>=20
>=20[ 64.327371] R10: ed3dec18d54433a1 R11: 0000000000000202 R12: 0000561=
9848bdef0
>=20
>=20[ 64.328657] R13: 0000561961b30040 R14: 0000561961b431d8 R15: 00007fd=
f1ac6e020
>=20
>=20[ 64.329969] </TASK>
>=20
>=20[ 64.330185] ---[ end trace 0000000000000000 ]---
>=20
>=20```
>=20
>=20Doesn't seem to be everytime, I don't think it happened before but gi=
ven
>=20
>=20I didn't look into reproducing it I couldn't say for sure.
>=20
>=20* some refcounting bug running this (creating/removing the same files=
 many
>=20
>=20times in parallel).
>=20
>=20This doesn't seem new as I reproduce it without the 6.9 patches, I'll
>=20
>=20need to dig into it.
>=20
>=20```
>=20
>=20mkdir tmp
>=20
>=20echo test > tmp/test
>=20
>=20for i in 1 2 3 4 5; do
>=20
>=20 seq 1 1000 | while read _; do
>=20
>=20 cp -a tmp copy 2>/dev/null
>=20
>=20 rm -rf copy 2>/dev/null=20
>=20
>  done &
>=20
>=20done
>=20
>=20wait
>=20
>=20```
>=20
>=20I also had a qemu segfault after a similar script (copying/removing a
>=20
>=20larger tree), but looking at the code/locals I don't see how it could
>=20
>=20fail there given the locals... giving up on this for now, it happened
>=20
>=20after refcount UAF error on linux so might be caused by garbage we se=
nt,
>=20
>=20but that's still a problem obviously)
>=20
>=20```
>=20
>=20(gdb) bt
>=20
>=20#0 __memcmp_avx2_movbe () at ../sysdeps/x86_64/multiarch/memcmp-avx2-=
movbe.S:415
>=20
>=20#1 0x000064d9dd7a5716 in v9fs_mark_fids_unreclaim (pdu=3Dpdu@entry=3D=
0x64d9e16ffe58, path=3Dpath@entry=3D0x74d9888c8f70) at ../hw/9pfs/9p.c:54=
5
>=20
>=20#2 0x000064d9dd7aa7ad in v9fs_unlinkat (opaque=3D0x64d9e16ffe58) at .=
./hw/9pfs/9p.c:3189
>=20
>=20#3 0x000064d9ddd4d64b in coroutine_trampoline (i0=3D<optimized out>, =
i1=3D<optimized out>) at ../util/coroutine-ucontext.c:175
>=20
>=20#4 0x000074da302bf510 in ?? () at ../sysdeps/unix/sysv/linux/x86_64/_=
_start_context.S:90 from /nix/store/cyrrf49i2hm1w7vn2j945ic3rrzgxbqs-glib=
c-2.38-44/lib/libc.so.6
>=20
>=20#5 0x00007fff7b8c4e30 in ?? ()
>=20
>=20#6 0x0000000000000000 in ?? ()
>=20
>=20(gdb) p fidp->path
>=20
>=20$1 =3D {size =3D 29, data =3D 0x74d96c001010 "./copy/1/tests/btrfs/00=
7.out"}
>=20
>=20(gdb) p *path
>=20
>=20$2 =3D {size =3D 29, data =3D 0x74da1c001e00 "./copy/4/tests/btrfs/04=
9.out"}
>=20
>=20# failing on this line:...
>=20
>=20 !memcmp(fidp->path.data, path->data, path->size)) {
>=20
>=20```
>=20
>=20--=20
>=20
> Dominique Martinet | Asmadeus
>
