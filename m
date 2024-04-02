Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE5399
	for <v9fs@lists.linux.dev>; Tue,  2 Apr 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016171; cv=none; b=pCzk/ESJRpq1cxUxL//q1pXphSvQLRJ4t1hikNnaEECgAglvO5W7vYOtV2MsIkTYzh4/Nxh7hJCLlgJ7A+WO/sQ5y6iWa+zgkVeKI4vdmoOlXG921Qxt7dI7j3SNvH/+NF/9MbvIrg8K54DnBlmI+kwq7p5TKIVJok+370BGHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016171; c=relaxed/simple;
	bh=5ugNaTOoEyBIJw4yJEYmq2Z1amkvna4DXa6aPOGdG7Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=C1MlvY6pouoI7w9YXQiJrc2kwp5Cjug+Dy9Hjb3W+NUcFNyAD73wR4OiP24NQmd/G1hYLJZdeUYc9HE39rHMrndFNpF+42oIuymAgJKXccXF4pVQxlAUrs6Zl8g/eL4i6IBuQqPDu+Wcztyz2WMZpUhWo1Eis1IPn9uITcJcXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rU6rlAwH; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rU6rlAwH"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712016166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ugNaTOoEyBIJw4yJEYmq2Z1amkvna4DXa6aPOGdG7Y=;
	b=rU6rlAwH3ttE4BsRBt90zz4lGzqJOGwJ+tgxqcdDu2MvY+09L6STDNpv3V0ir9qLgSO9bh
	iMRf5iNP4o4Y5RBx6NnjRl77QrqZT4MJPIGOW32qEiNz4sOqmFgLIpDdhACaEo58HmZBoZ
	M0OD8uLNFnsNHctk7P7/WaJfycaQPJc=
Date: Tue, 02 Apr 2024 00:02:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <0ac82d20c88c8d227064737fdc62b3195548c5ea@linux.dev>
TLS-Required: No
Subject: Re: new 9p kasan splat in 6.9
To: "Kent Overstreet" <kent.overstreet@linux.dev>, v9fs@lists.linux.dev
In-Reply-To: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
References: <f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on>
X-Migadu-Flow: FLOW_OUT

This should be fixed in -rc2.

March 31, 2024 at 12:33 AM, "Kent Overstreet" <kent.overstreet@linux.dev>=
 wrote:
>=20
>=2000000 Running test kasan-ec.ktest on farm2 at /home/testdashboard/lin=
ux-5
>=20
>=2000164 building kernel... done
>=20
>=2000169 systemd[1]: Failed to find module 'autofs4'
>=20
>=2000170 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=2000170 BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0x7f8/0=
x988
>=20
>=2000170 Read of size 8 at addr ffff0000c12f9000 by task mount/217
>=20
>=2000170=20
>=20
> 00170 CPU: 3 PID: 217 Comm: mount Not tainted 6.9.0-rc1-ktest-ga097468f=
fe82 #10998
>=20
>=2000170 Hardware name: linux,dummy-virt (DT)
>=20
>=2000170 Call trace:
>=20
>=2000170 dump_backtrace+0xa4/0xe0
>=20
>=2000170 show_stack+0x1c/0x30
>=20
>=2000170 dump_stack_lvl+0x70/0x88
>=20
>=2000170 print_report+0x110/0x5b8
>=20
>=2000170 kasan_report+0x80/0xc0
>=20
>=2000170 __asan_report_load8_noabort+0x1c/0x28
>=20
>=2000170 v9fs_stat2inode_dotl+0x7f8/0x988
>=20
>=2000170 v9fs_fid_iget_dotl+0x164/0x1f0
>=20
>=2000170 v9fs_mount+0x380/0x718
>=20
>=2000170 legacy_get_tree+0xd4/0x198
>=20
>=2000170 vfs_get_tree+0x78/0x240
>=20
>=2000170 path_mount+0xc6c/0x15f0
>=20
>=2000170 do_mount+0xc4/0x100
>=20
>=2000170 __arm64_sys_mount+0x228/0x330
>=20
>=2000170 invoke_syscall.constprop.0+0x74/0x1e8
>=20
>=2000170 do_el0_svc+0xc8/0x200
>=20
>=2000170 el0_svc+0x20/0x60
>=20
>=2000170 el0t_64_sync_handler+0xb8/0xc0
>=20
>=2000170 el0t_64_sync+0x14c/0x150
>=20
>=2000170=20
>=20
> 00170 Allocated by task 217:
>=20
>=2000170=20
>=20
> 00170 Freed by task 217:
>=20
>=2000170=20
>=20
> 00170 The buggy address belongs to the object at ffff0000c12f9000
>=20
>=2000170 which belongs to the cache kmalloc-192 of size 192
>=20
>=2000170 The buggy address is located 0 bytes inside of
>=20
>=2000170 freed 192-byte region [ffff0000c12f9000, ffff0000c12f90c0)
>=20
>=2000170=20
>=20
> 00170 The buggy address belongs to the physical page:
>=20
>=2000170=20
>=20
> 00170 Memory state around the buggy address:
>=20
>=2000170 ffff0000c12f8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
>=20
>=2000170 ffff0000c12f8f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc =
fc
>=20
>=2000170 >ffff0000c12f9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb
>=20
>=2000170 ^
>=20
>=2000170 ffff0000c12f9080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc =
fc
>=20
>=2000170 ffff0000c12f9100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc
>=20
>=2000170 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=2000170 Kernel panic - not syncing: kasan.fault=3Dpanic set ...
>=20
>=2000170 CPU: 3 PID: 217 Comm: mount Not tainted 6.9.0-rc1-ktest-ga09746=
8ffe82 #10998
>=20
>=2000170 Hardware name: linux,dummy-virt (DT)
>=20
>=2000170 Call trace:
>=20
>=2000170 dump_backtrace+0xa4/0xe0
>=20
>=2000170 show_stack+0x1c/0x30
>=20
>=2000170 dump_stack_lvl+0x34/0x88
>=20
>=2000170 dump_stack+0x18/0x20
>=20
>=2000170 panic+0x4dc/0x520
>=20
>=2000170 end_report+0xec/0xf0
>=20
>=2000170 kasan_report+0x90/0xc0
>=20
>=2000170 __asan_report_load8_noabort+0x1c/0x28
>=20
>=2000170 v9fs_stat2inode_dotl+0x7f8/0x988
>=20
>=2000170 v9fs_fid_iget_dotl+0x164/0x1f0
>=20
>=2000170 v9fs_mount+0x380/0x718
>=20
>=2000170 legacy_get_tree+0xd4/0x198
>=20
>=2000170 vfs_get_tree+0x78/0x240
>=20
>=2000170 path_mount+0xc6c/0x15f0
>=20
> 00170 do_mount+0xc4/0x100
>=20
>=2000170 __arm64_sys_mount+0x228/0x330
>=20
>=2000170 invoke_syscall.constprop.0+0x74/0x1e8
>=20
>=2000170 do_el0_svc+0xc8/0x200
>=20
>=2000170 el0_svc+0x20/0x60
>=20
>=2000170 el0t_64_sync_handler+0xb8/0xc0
>=20
>=2000170 el0t_64_sync+0x14c/0x150
>=20
>=2000170 SMP: stopping secondary CPUs
>=20
>=2000170 Kernel Offset: disabled
>=20
>=2000170 CPU features: 0x0,00000003,80000008,4240500b
>=20
>=2000170 Memory Limit: none
>=20
>=2000170 ---[ end Kernel panic - not syncing: kasan.fault=3Dpanic set ..=
. ]---
>=20
>=2000175 =3D=3D=3D=3D=3D=3D=3D=3D=3D FAILED TIMEOUT (no test) in 1200s
>
