Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DD2F26
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710817245; cv=none; b=RXj3kPNRHe4a09if3/wx7YtQG9HxkVuZsQXEwB9vmi2WLRF8bBxOrSwPXXtlIbkmXKDJZWlhmEFWNKSHyzGI4GbpBB6BeBEzFM2jmXRReEnQT92LF/gp+YeoXlQFYrVDBlMuWkdj1WphFOkgYAThhSJB4DM5Fk41TnEX9tsUt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710817245; c=relaxed/simple;
	bh=nIWQ3K9hAtpm6E9A42ZiKYric144d715C5y4KtuOTdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEGU3nkaOQhBVin7QeTtR1RI5lDiCBGjCPSOLJFNwguTiO/4XRmTui8RW2BwWqJti99xzNOF33mRbQlK06N7s+SnEm0tEC1FTXWYt97UWhonlMSwEcI8cWEabJeZrovq0th86g6G7Z3ch6Hl86qJb7jCiMCGrXGFHHr4kNVFubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9y+rhdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9y+rhdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85EC433C7
	for <v9fs@lists.linux.dev>; Tue, 19 Mar 2024 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710817245;
	bh=nIWQ3K9hAtpm6E9A42ZiKYric144d715C5y4KtuOTdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9y+rhdUeh7EaHABV1wFGDoAI0f0D6yETgt6R0Nh7pwhZewAHLtplawDPNr4BNMJI
	 4XjluqJu2K6YOLOfrYz6c8yxYkg07kKMjjwHavtU3tGhojmqdBghWefXq4Wa505Nl+
	 +CB/FbzVuhMl4Y1yCNJGcFuCvR4ZyHG/QecSzcsBqKSeItgkKJeLNnacLn1E38CsHn
	 ko/sf1pLLXMe2j55kvzduOyiGtRWtGUhXZPlXabzzax+jiLF02JxXmAHhAn55XYkB9
	 lEI1EkL1xPbogV2Bu1lVVhL+VOQMG4pS1uLABgk58iwbv7Vxr0Am+ojfiDDiU5CHQG
	 temufrQ6eE8Jg==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc742543119so4532355276.0
        for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 20:00:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzg+0i2vKeA7nX0dX3zUTnxBpSPRZ9FtT9pfMRbZxK/EIMwBX4C
	m7qTkx1MoYZ6pyEaA+lr7o+7J1pG3Np4iHIa4+FlB4MbebJibL1EXx3y0WuG/40jwXXRa7HXwxt
	BlQuzE7yYYKgVppNuE10nAinEIto=
X-Google-Smtp-Source: AGHT+IFTFxR3Mvg0UJ3Qt0F/3lhZSyXqV3SxRjQUpOZE6WjlDTfPXbLnnQFL+hBRhn4W/hpLs+8PrR5qCCLuQTzrDxc=
X-Received: by 2002:a25:ac62:0:b0:dc6:bcd5:9503 with SMTP id
 r34-20020a25ac62000000b00dc6bcd59503mr10061129ybd.48.1710817244587; Mon, 18
 Mar 2024 20:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZfW3eyENMB1P5jLS@vm3>
In-Reply-To: <ZfW3eyENMB1P5jLS@vm3>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 18 Mar 2024 22:00:33 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnOcmgr8iPjBR+4+sd5LqOd3nfKZ9DecSYvZfxzzNg3WA@mail.gmail.com>
Message-ID: <CAFkjPTnOcmgr8iPjBR+4+sd5LqOd3nfKZ9DecSYvZfxzzNg3WA@mail.gmail.com>
Subject: Re: 9P2000 bug in mainline
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fix for this already in my for-next tree, will be sending a pull
request shortly along with a fix for another kasan reported bug.

thanks,

    -eric

On Mon, Mar 18, 2024 at 9:25=E2=80=AFPM Itaru Kitayama <itaru.kitayama@linu=
x.dev> wrote:
>
> Hi,
>
> I bisected down to this commit in Linus's tree:
>
> [724a08450f74b02bd89078a596fd24857827c012] fs/9p: simplify iget to remove=
 unnecessary paths
>
> 9P2000 stopped working on FVP with the arm64 kernel.
>
> # mount -t 9p FM /mnt
> [   99.367520] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   99.367817] BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0x=
818/0x9a0
> [   99.368266] Read of size 8 at addr ffff0008068a99a8 by task mount/165
> [   99.368608]
> [   99.368787] CPU: 1 PID: 165 Comm: mount Not tainted 6.8.0-rc1-00008-gb=
e57855f5050 #99
> [   99.369190] Hardware name: FVP Base RevC (DT)
> [   99.369442] Call trace:
> [   99.369637]  dump_backtrace+0x94/0xf0
> [   99.369960]  show_stack+0x1c/0x2c
> [   99.370265]  dump_stack_lvl+0xb0/0x14c
> [   99.370644]  print_report+0xdc/0x578
> [   99.371010]  kasan_report+0xb4/0x100
> [   99.371378]  __asan_report_load8_noabort+0x24/0x34
> [   99.371807]  v9fs_stat2inode_dotl+0x818/0x9a0
> [   99.372193]  v9fs_fid_iget_dotl+0x174/0x208
> [   99.372576]  v9fs_mount+0x37c/0x740
> [   99.372921]  legacy_get_tree+0xd4/0x198
> [   99.373301]  vfs_get_tree+0x78/0x284
> [   99.373637]  path_mount+0x738/0x1500
> [   99.373958]  __arm64_sys_mount+0x48c/0x5c4
> [   99.374297]  invoke_syscall+0xd4/0x24c
> [   99.374690]  el0_svc_common.constprop.0+0xb0/0x23c
> [   99.375128]  do_el0_svc+0x44/0x60
> [   99.375514]  el0_svc+0x3c/0x7c
> [   99.375893]  el0t_64_sync_handler+0x128/0x134
> [   99.376232]  el0t_64_sync+0x1b0/0x1b4
> [   99.376552]
> [   99.376724] Allocated by task 165 on cpu 1 at 99.359984s:
> [   99.377046]  kasan_save_stack+0x40/0x6c
> [   99.377402]  kasan_save_track+0x24/0x44
> [   99.377760]  kasan_save_alloc_info+0x6c/0x80
> [   99.378164]  __kasan_kmalloc+0xe0/0xe4
> [   99.378517]  kmalloc_trace+0x164/0x300
> [   99.378874]  p9_client_getattr_dotl+0x50/0x19c
> [   99.379269]  v9fs_fid_iget_dotl+0xb4/0x208
> [   99.379641]  v9fs_mount+0x37c/0x740
> [   99.379978]  legacy_get_tree+0xd4/0x198
> [   99.380356]  vfs_get_tree+0x78/0x284
> [   99.380678]  path_mount+0x738/0x1500
> [   99.380992]  __arm64_sys_mount+0x48c/0x5c4
> [   99.381322]  invoke_syscall+0xd4/0x24c
> [   99.381713]  el0_svc_common.constprop.0+0xb0/0x23c
> [   99.382137]  do_el0_svc+0x44/0x60
> [   99.382516]  el0_svc+0x3c/0x7c
> [   99.382892]  el0t_64_sync_handler+0x128/0x134
> [   99.383217]  el0t_64_sync+0x1b0/0x1b4
> [   99.383527]
> [   99.383699] Freed by task 165 on cpu 1 at 99.367506s:
> [   99.384014]  kasan_save_stack+0x40/0x6c
> [   99.384371]  kasan_save_track+0x24/0x44
> [   99.384729]  kasan_save_free_info+0x54/0x90
> [   99.385130]  poison_slab_object+0x118/0x16c
> [   99.385498]  __kasan_slab_free+0x40/0x98
> [   99.385863]  kfree+0xec/0x290
> [   99.386190]  v9fs_fid_iget_dotl+0x138/0x208
> [   99.386564]  v9fs_mount+0x37c/0x740
> [   99.386902]  legacy_get_tree+0xd4/0x198
> [   99.387279]  vfs_get_tree+0x78/0x284
> [   99.387602]  path_mount+0x738/0x1500
> [   99.387915]  __arm64_sys_mount+0x48c/0x5c4
> [   99.388246]  invoke_syscall+0xd4/0x24c
> [   99.388637]  el0_svc_common.constprop.0+0xb0/0x23c
> [   99.389061]  do_el0_svc+0x44/0x60
> [   99.389439]  el0_svc+0x3c/0x7c
> [   99.389815]  el0t_64_sync_handler+0x128/0x134
> [   99.390135]  el0t_64_sync+0x1b0/0x1b4
> [   99.390451]
> [   99.390622] The buggy address belongs to the object at ffff0008068a99a=
8
> [   99.390622]  which belongs to the cache kmalloc-192 of size 192
> [   99.391063] The buggy address is located 0 bytes inside of
> [   99.391063]  freed 192-byte region [ffff0008068a99a8, ffff0008068a9a68=
)
> [   99.391530]
> [   99.391703] The buggy address belongs to the physical page:
> [   99.391960] page:fffffc00201a2a00 refcount:1 mapcount:0 mapping:000000=
0000000000 index:0xffff0008068a9af0 pfn:0x8868a8
> [   99.392411] head:fffffc00201a2a00 order:1 entire_mapcount:0 nr_pages_m=
apped:0 pincount:0
> [   99.392784] flags: 0x5fffe0000000a40(workingset|slab|head|node=3D0|zon=
e=3D2|lastcpupid=3D0xffff)
> [   99.393178] page_type: 0xffffffff()
> [   99.393490] raw: 05fffe0000000a40 ffff00080000ce40 ffff000800000850 ff=
ff000800000850
> [   99.393884] raw: ffff0008068a9af0 0000000000180015 00000001ffffffff 00=
00000000000000
> [   99.394211] page dumped because: kasan: bad access detected
> [   99.394479]
> [   99.394650] Memory state around the buggy address:
> [   99.394921]  ffff0008068a9880: 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00
> [   99.395270]  ffff0008068a9900: 00 00 fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   99.395619] >ffff0008068a9980: fc fc fc fc fc fa fb fb fb fb fb fb fb =
fb fb fb
> [   99.395935]                                   ^
> [   99.396210]  ffff0008068a9a00: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fc fc fc
> [   99.396558]  ffff0008068a9a80: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   99.396874] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   99.397370] Disabling lock debugging due to kernel taint
>
