Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88297BA37
	for <v9fs@lists.linux.dev>; Sun, 22 Sep 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017171; cv=none; b=fcrKjkULF7i/7UYdReSNg/zfP172sjvCbJXtO/tl3zhCbTkfMLfxT01KUAXGNrtinlU7AXEFMdQEdUCiUPYDIRdPkXsK5cLU80IEHP4QHjV1NQ2btxI3iwULJTLVdRC8jcYLdezRSC68iH8srGCkB9CnNIOzMizKlq17YHXJX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017171; c=relaxed/simple;
	bh=Jm9+rgdUUT9Nl7PoDsYwNBXvSFmpBtKorU3aLbdbm0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8Y9bxcLdYXKiQVmi0aQETEjBMNYDcnxVShBtd6gBj0BGVaISC3QneVw5ygzV2pk+sieOjWS3n3+jIf3tspAjEvF/gLzElMBjrmCvZTQJO0hmAokLZeu7CqoX73QofIfdl4hM0y26auUeHDgT5w4fN5/ICMDEvwLS2b5xbUOalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX/Ksc6l; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX/Ksc6l"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5010861905bso2317091e0c.1
        for <v9fs@lists.linux.dev>; Sun, 22 Sep 2024 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017168; x=1727621968; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5rjV7FhoGP2f/5V+yY+L2fJJOFCeIghdK+g8s1QwnU=;
        b=JX/Ksc6lRZC0dQ7yfcQfjBD+YT+77VDgQtk9erhFLSkcxjw3Xl79S+rz2GLpAyE3Hk
         QYnSJCvrXvBTLQKXrSkll42ujpw8x1OeIV2OGnLiPGv2+gCvWKH2kPkxFB+mzzovrV8O
         7dNATiKFj18GArDRyvK9/VW72zXeAIBXcAu3CraCIUKyy3n6ETcUJi14NzYLK+ZHuoqD
         bs/iu6watbXgbyTWo5oaK6jUNdfMm3PQho113lmSMEfIAW1o9qfE9aV6/kxzPuykB9Qg
         4yFeI87a9xjJ9ZkhIDdHo7iacQPvA2wWRizSEfnLX99mOEMdZYEXIwDa2Kwfo76sN+sU
         AZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017168; x=1727621968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5rjV7FhoGP2f/5V+yY+L2fJJOFCeIghdK+g8s1QwnU=;
        b=mWgxsZSXpVRriNLe2RClzL8GSl1RNsQrgO/0YEImT74YvKYj36dlEDdUS8Cm1maZL7
         pYkmqHe3L8sJDdoS3X+LbbtfFuycuTzIxFh6szKSx9TZTzoIh796bbced6koWnPK3tud
         dfChNedpUq0b8KAaIo7cWtcqN3smmKsxzDap+MNynC8ciY/444f2ey0ulCcR7v5W0/J7
         cTnXDoY0/uk22/IX/aoRBmOOSzHdRDx7ADEbJ0/+W4am3Zi7/sw+d/R7YC941+/dIBcf
         s0Ok99dR9/JmZuF5vcuz0oH6DzkhNa8SIkPhe1YGLUUuOOXXIagaxrt8EWjtw8shoAyF
         rigQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/MEK3h+6R9MSK0QYJRlq20glO1UXMxZSJYyV9xYQNUWbqzTvlK809ZSeFyiwDu5/JRp2@lists.linux.dev
X-Gm-Message-State: AOJu0YyMGHcyeIVXEFVpKfzRJSODgp8LyJ8xMZQ16WgQoLl46pGNqmV+
	O8cIui+bwvyHSVJHPytC6YUJxUniiCs+ewsHj5DI5jo+TZvQA1szKy3LbdM6sbIwQwAHw3qCN1B
	9BfH/2XThn7Enlc6hY68mFtz7IFM=
X-Google-Smtp-Source: AGHT+IHbE+QjPwJEc/YbejKgBqha2motfb9kzkvErGAzd8qbaZhambs8aRWfpj2nCor/0FOW+p2ZXA3NAwlUYLxZYZI=
X-Received: by 2002:a05:6122:3b08:b0:502:c218:383f with SMTP id
 71dfb90a1353d-503c9cfe08fmr7924839e0c.7.1727017168434; Sun, 22 Sep 2024
 07:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <66f0092d.050a0220.3195df.009b.GAE@google.com>
In-Reply-To: <66f0092d.050a0220.3195df.009b.GAE@google.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sun, 22 Sep 2024 15:59:17 +0100
Message-ID: <CAKbZUD08BQeK0R-KuU07=QUCW7GHbmZ0RgfUcOpzKd+Yv4b5CQ@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] WARNING in p9_client_create (2)
To: syzbot <syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org, cl@linux.com, ericvh@kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 1:10=E2=80=AFPM syzbot
<syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kerne=
l..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D152d7fc798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4540f5bcdd31e=
3de
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3c5d43e97993e1f=
a612b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15c98b00580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D151424a998000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/dis=
k-bdf56c75.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinu=
x-bdf56c75.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/b=
zImage-bdf56c75.xz
>
> The issue was bisected to:
>
> commit 4c39529663b93165953ecf9b1a9ea817358dcd06
> Author: Pedro Falcato <pedro.falcato@gmail.com>
> Date:   Wed Aug 7 09:07:46 2024 +0000
>
>     slab: Warn on duplicate cache names when DEBUG_VM=3Dy
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D111f269f98=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D131f269f98=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D151f269f98000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com
> Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=
=3Dy")
>
> ------------[ cut here ]------------
> kmem_cache of name '9p-fcall-cache' already exists
> WARNING: CPU: 0 PID: 5221 at mm/slab_common.c:108 kmem_cache_sanity_check=
 mm/slab_common.c:107 [inline]
> WARNING: CPU: 0 PID: 5221 at mm/slab_common.c:108 __kmem_cache_create_arg=
s+0xa7/0x350 mm/slab_common.c:294
> Modules linked in:
> CPU: 0 UID: 0 PID: 5221 Comm: syz-executor647 Not tainted 6.11.0-syzkalle=
r-04744-gbdf56c7580d2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
> RIP: 0010:__kmem_cache_create_args+0xa7/0x350 mm/slab_common.c:294
> Code: 8e 48 8b 1b 48 39 eb 74 25 48 8b 7b f8 4c 89 fe e8 ae 72 d5 09 85 c=
0 75 e8 90 48 c7 c7 03 a5 08 8e 4c 89 fe e8 5a 36 7d ff 90 <0f> 0b 90 90 4c=
 89 ff be 20 00 00 00 e8 08 74 d5 09 48 85 c0 0f 85
> RSP: 0018:ffffc90003c07788 EFLAGS: 00010246
> RAX: 158c5a6442ad7f00 RBX: ffff88814cccd428 RCX: ffff88802c34bc00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffffff8ea168a0 R08: ffffffff8155af72 R09: 1ffff92000780e8c
> R10: dffffc0000000000 R11: fffff52000780e8d R12: 0000000000020018
> R13: 0000000000000000 R14: ffffc90003c07860 R15: ffffffff8d2c41c0
> FS:  0000555573dac380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001000 CR3: 0000000075df4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
>  p9_client_create+0xba5/0x1110 net/9p/client.c:1042
>  v9fs_session_init+0x1e4/0x1b80 fs/9p/v9fs.c:410
>  v9fs_mount+0xcf/0xaa0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0xee/0x190 fs/fs_context.c:662
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>  do_new_mount+0x2be/0xb40 fs/namespace.c:3507
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4055 [inline]
>  __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f29cf818069
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd4a6d8418 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f29cf8610e8 RCX: 00007f29cf818069
> RDX: 00000000200002c0 RSI: 0000000020000080 RDI: 0000000000000000
> RBP: 00000000000f4240 R08: 0000000020000380 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd4a6d8430
> R13: 00007ffd4a6d8450 R14: 00007ffd4a6d8530 R15: 0000000000000001
>  </TASK>

This was one of the issues I actually ran into when using virtme.
Fix was submitted here back in August:
https://lore.kernel.org/v9fs/20240807094725.2193423-1-pedro.falcato@gmail.c=
om/

No replies nor was it picked up. Can it go through the slab tree?

--=20
Pedro
