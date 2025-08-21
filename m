Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40722F764
	for <v9fs@lists.linux.dev>; Thu, 21 Aug 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748117; cv=none; b=R4JEbimdA2C8979Apr4bkYfVymuI16y33PqS/O4gdgi+19P1x8v4+3qHZ5zFtppW8yfd83PxhfJL9hor6X9tfFFm57gHBZKc818MknGQf/3pLACk8d6guZIZvA8BBNougGqKwXgq8W/CFno4j1Ir2BE8LX0a2YLdBapSvY1GJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748117; c=relaxed/simple;
	bh=olXJrF8t7oUlO43zmSrMYNCvokq4aUhJjs+rJ6zAxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3BDKyw50o0FbslNteccwWikRDHxjPgIXED+tpxIoZf5ClKSpG/qGCsOtKgAMakgEdV7J4XUolN42eS0BXcQOfG5gXL5rpMmRKFXyIWPH+LbcSinvq2MPyqFXZXZE1dHGfaj+3vPZG06tKtJAMISAXmvVUfTeQv5hNOJ5t7sOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jwsMvzBF; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jwsMvzBF"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D8C4D14C2D3;
	Thu, 21 Aug 2025 05:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755748104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Q0l/pepFb0UQcSiId8Kpfa1b1R1Hcz1V8en1YvbWWU=;
	b=jwsMvzBFTbWbNVpp+8yRFSTlhFCY7jh68XiUoNyDMtUV3vhn2VHAN6ezACWw5lOGPkD7vF
	hOgH6CHAksbni93Hhwr8T4ud44oYEXUNh4ls/GMmtciC0B2otqNf5LTaXlmVaruGcxEaTE
	+kMzJafFw5krPgf9CpP5hl7ve6Bw5Au19gUmVyAHJCMV0wQ46eohfaKUYWH3s18ZnutlYs
	FTaxmKrF9a+tOkhDklEQg2aq8Q5Qqgwv+Sf15jhpZk8+eyci5EdPEFS/W2J7zz7mRPhAFr
	NB12+3x6S19LgMlly9i7ceBbcIx4UJ6S6bne/gnhOXpXT/MrcfnOoTIZ1/ewkg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c6f93705;
	Thu, 21 Aug 2025 03:48:20 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:48:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Message-ID: <aKaW9bi5INq7OwGy@codewreck.org>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>

Hi Eric,

syzbot wrote on Wed, Aug 20, 2025 at 07:58:31PM -0700:
> UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
> shift exponent 32 is too large for 32-bit type 'int'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
>  v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
>  do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
>  do_mount fs/namespace.c:4138 [inline]

I thinks the mount rework triggered this one (full copy below or at [1])
[1] https://lore.kernel.org/all/68a68b57.050a0220.3d78fd.0012.GAE@google.com/T/#u

From a quick look the old code bound msize to 4k-INT_MAX, but the new
code accepts higher uint32 values.
To be honest I'm not sure INT_MAX even makes sense as later allocations
are likely to work :) but for now something as simple as this is likely
to work (I'm not sure I got the test thing right, let's see...)

Shall I just roll that into your patch, unless you know of a more
appropriate limit?
There doesn't seem to be any easy to use variable about max allocation
size, a limit of a few MB is probably sensible but I don't like
artificial restrictions just to please syzbot so happy to defer to
someone else here.


#syz test

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 55ba26186351..cc65330ee684 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -302,6 +302,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
                        p9_debug(P9_DEBUG_ERROR, "msize should be at least 4k\n");
                        return -EINVAL;
                }
+               if (result.uint_32 > INT_MAX) {
+                       p9_debug(P9_DEBUG_ERROR, "msize too big\n");
+                       return -EINVAL;
+               }
                clnt->msize = result.uint_32;
                break;
        case Opt_trans:

syzbot wrote on Wed, Aug 20, 2025 at 07:58:31PM -0700:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3ac864c2d9bb Add linux-next specific files for 20250818
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13706442580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1acc6b9e1fca1b
> dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141586f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c9ba2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/37dbe82593f0/disk-3ac864c2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d2fea0824445/vmlinux-3ac864c2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6f2a83735a01/bzImage-3ac864c2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
> shift exponent 32 is too large for 32-bit type 'int'
> CPU: 0 UID: 0 PID: 5861 Comm: syz-executor379 Not tainted 6.17.0-rc2-next-20250818-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
>  v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
>  do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
>  do_mount fs/namespace.c:4138 [inline]
>  __do_sys_mount fs/namespace.c:4349 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4326
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff35edd46a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeee8a4078 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00002000000025c0 RCX: 00007ff35edd46a9
> RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
> RBP: 0000200000000280 R08: 0000200000000280 R09: 00007ffeee8a4258
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35ee1d017
> R13: 00007ffeee8a4248 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ---[ end trace ]---
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

-- 
Dominique Martinet | Asmadeus
