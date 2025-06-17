Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613A21B91F
	for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152855; cv=none; b=rp3vAe9n/p9vcpG7+4M/A0Bi8MFOquyJgu0hFxTwiWkw8UkE7IVpbdu6YYI7rd0SCJmcjhoqE0gIwI4KmX0HAh/SA6aYnHucy7/3jMsQUwC11Ukvowmq3pENATQDab6ZjMmSyMkaeQeVR3/7NtCA7ZZm2itiRHf3wI13mL3ncdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152855; c=relaxed/simple;
	bh=G5eezadzLBW93ru6voapn97o+0muFg8uZIO6GHGGoCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPqKw+GJs0doQW0zMC+xutjeau6Xx8awToNg0ZSLT7TYNSYAepYsAqoiMFRJZRdMTQC2q+YosMWsdSNgQS45Xl5S/tCQ4oNh5ObAVjpMGaleH1ACoGfBrIXfWaAr605Y5a3I7bw0BweC8K1nzNMgD/pMWqhg7VsmuDWER3O1FzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIGtoXAL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIGtoXAL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313910f392dso4944546a91.2
        for <v9fs@lists.linux.dev>; Tue, 17 Jun 2025 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750152852; x=1750757652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy9ozREwXM6yajfHwp8sB5SkUjs9u/5sdv2yga+HurE=;
        b=LIGtoXALJoFBELjrvP8WYdNnV+f3EXrE7e9y6A68ahPRNYW7nMjbzLUYcritnIrh3z
         qM1ZuKAoSAKn1QotUhEqgR2xank2725VOJbIV+/JXZHwlQ/jdQoqrSXAZ4GYNJ+fNp/b
         juRUoZtCSksv1u/vaVVim+9yPoXQYfyggYqaEdf231YA3iHgOROZQATWQcN6okxqtNyd
         Wh5Kwlu7nsWv3ZJUMcwqtYgiA9gVeTt2QOV6rVeABrTkKAFAwOrtQIsA53ZH52KMDlw5
         p2Y+opAde4XjF2n9z00DdmwNywf/EfKnk3j5IV+U2MYRTRAu5KN9+mTf8yJ1mESfA9+4
         7zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152852; x=1750757652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy9ozREwXM6yajfHwp8sB5SkUjs9u/5sdv2yga+HurE=;
        b=gI86BAk2UdAl1P0eemjqPm5K+aiQysRin/Skc9x6nVHablKaIbQfOvruY9qknMXxoT
         xxXjw3dVr/kROqt+d4oJ56Ef/oHLVzvwhT+3+ySJaHBEX4IGM8dzQBygWIDByv8PHZDn
         74GHBli1kenynvh4RAuVCZA5pWgrPZtJlMT75cN0vsELtxCUgPNDNBQe2GMC7IcGoqvH
         9R0WDxEQc253Rc5TVU8a2Tpd7J1UlqXuLk8TGJ33wB7XSIiQ8tmH3RrwUFl0bl8eYKvl
         4GAPDsCvMoQAR34NOLQ7TqwkNkvwE8CT7GuP9G238Dq0qP4DA1rHEWvWgUvZYofJ7kbB
         6wtw==
X-Forwarded-Encrypted: i=1; AJvYcCWDPpxuZpwUmpYY+GRw/inukAO408zqysdcLk+DKf4oCpMS/ZJ/AyU5LwItB6CM76p0xpZ4@lists.linux.dev
X-Gm-Message-State: AOJu0YzGXOpcRwj6tUWaW97ge2Dwa2yVOADAPJ6vBMdvgOkFIg65Vk3E
	B5tr8eIF7MCjsgL1ZcD+W19XIgish+5TDfmJH2i5Rxy9fJZKw6HfKS9rGxxtv426QYq/RouJlcJ
	EdIkyulCry4r2CCAUBG1RVORPuo2dXuLwzazGVhXF
X-Gm-Gg: ASbGncvjTZTC10YDlpX1VYXucuXxK74NExHvOdV6z3JXDOhQrNv+TUvmIvZGEanblX2
	SL8JMSabYYe1WKRBaC2+U8cTdo7ebirDlpLQnYIFkdX8ft15QA5GcTZXQKKsXP1ryhdhiz/T8OG
	iFa19WeyVIX9cPkBWvbAzdW4cKaBlJHh3bCImCiG/QbSZ/JXGCidNC69DQheqPDX1L4U6k6Ti5
X-Google-Smtp-Source: AGHT+IGmEOYrE0DsdOuE8bNLBAUcGIGtWS0fLaxdWfeUWjsCOySE0e4ca0Wc/AhJzhXC0KwRwmQwOczpGP+O7aLEQL8=
X-Received: by 2002:a17:90b:35ce:b0:311:d670:a10d with SMTP id
 98e67ed59e1d1-313f1d96b23mr16599599a91.26.1750152852309; Tue, 17 Jun 2025
 02:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68512333.a70a0220.395abc.0207.GAE@google.com>
In-Reply-To: <68512333.a70a0220.395abc.0207.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Jun 2025 11:33:59 +0200
X-Gm-Features: AX0GCFt3-7Tensh_rDRvxoQAm3XeFrHhfv0OAVC0DXQfsgghdTDrMcup7qn11gs
Message-ID: <CANp29Y5oXu0WN79EOvCLAYy7-ThWQoz8vswCo0OTuS+5bhJkzQ@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] WARNING: mm/page_alloc.c:LINE at
 __alloc_frozen_pages_noprof, CPU: syz.NUM.NUM/NUM
To: syzbot <syzbot+c44c80c9d28ec68d1c06@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz dup: WARNING in __alloc_frozen_pages_noprof


On Tue, Jun 17, 2025 at 10:11=E2=80=AFAM syzbot
<syzbot+c44c80c9d28ec68d1c06@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17949e8258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd2efc7740224b=
93a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc44c80c9d28ec68=
d1c06
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14fd95d4580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/dis=
k-050f8ad7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinu=
x-050f8ad7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/b=
zImage-050f8ad7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c44c80c9d28ec68d1c06@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: mm/page_alloc.c:4935 at __alloc_frozen_pages_noprof+0x2c8/0x370 =
mm/page_alloc.c:4935, CPU#1: syz.0.16/6030
> Modules linked in:
> CPU: 1 UID: 0 PID: 6030 Comm: syz.0.16 Not tainted 6.16.0-rc2-next-202506=
16-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:4935
> Code: 74 10 4c 89 e7 89 54 24 0c e8 d4 12 0d 00 8b 54 24 0c 49 83 3c 24 0=
0 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 f3 c0 73 0d 01 90 <0f> 0b 90 e9 18=
 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
> RSP: 0018:ffffc90003cdf9c0 EFLAGS: 00010246
> RAX: ffffc90003cdfa00 RBX: 000000000000002a RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003cdfa28
> RBP: ffffc90003cdfaa8 R08: ffffc90003cdfa27 R09: 0000000000000000
> R10: ffffc90003cdfa00 R11: fffff5200079bf45 R12: 0000000000000000
> R13: 1ffff9200079bf3c R14: 0000000000040d40 R15: dffffc0000000000
> FS:  000055557e5fb500(0000) GS:ffff888125d40000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff1db25138 CR3: 00000000762fa000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __alloc_pages_noprof+0xa/0x30 mm/page_alloc.c:4993
>  __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
>  ___kmalloc_large_node+0x85/0x210 mm/slub.c:4272
>  __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4300
>  __do_kmalloc_node mm/slub.c:4316 [inline]
>  __kmalloc_noprof+0x36f/0x4f0 mm/slub.c:4340
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  v9fs_fid_get_acl+0x4f/0x100 fs/9p/acl.c:32
>  __v9fs_get_acl fs/9p/acl.c:66 [inline]
>  v9fs_get_acl+0x9a/0x360 fs/9p/acl.c:92
>  v9fs_qid_iget_dotl fs/9p/vfs_inode_dotl.c:131 [inline]
>  v9fs_inode_from_fid_dotl+0x221/0x2b0 fs/9p/vfs_inode_dotl.c:154
>  v9fs_get_new_inode_from_fid fs/9p/v9fs.h:251 [inline]
>  v9fs_mount+0x6eb/0xa50 fs/9p/vfs_super.c:144
>  legacy_get_tree+0xfa/0x1a0 fs/fs_context.c:666
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1802
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3885
>  do_mount fs/namespace.c:4222 [inline]
>  __do_sys_mount fs/namespace.c:4433 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4410
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f87d618e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe32d1a898 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f87d63b5fa0 RCX: 00007f87d618e929
> RDX: 0000200000000b80 RSI: 00002000000003c0 RDI: 0000000000000000
> RBP: 00007f87d6210b39 R08: 0000200000000580 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f87d63b5fa0 R14: 00007f87d63b5fa0 R15: 0000000000000005
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68512333.a70a0220.395abc.0207.GAE%40google.com.
