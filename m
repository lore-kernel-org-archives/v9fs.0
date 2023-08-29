Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514014F7B
	for <v9fs@lists.linux.dev>; Tue, 29 Aug 2023 11:05:01 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 35DCFC01C; Tue, 29 Aug 2023 12:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1693306667; bh=8ncS0sunhziwWJklUPIh2wAfxFidnYA26XwXE4eHzI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZGy4a+pFCPeQhCEdezlmiB8TAM/rFX5NnuwZnC23utMMRC5lCInhizOcC5hMnY70
	 G1vk4sGEKQwPvCuGh1/1HteuHM/R3P9eU/N/WJUqTXTQKyr/Un6nldoZRfkrrSVwR1
	 HRBf+bCcK03twUdcGdLxUNR1q0Xs5wluO/UJKxAHUh7ckiPSMSnmfFVJXpzSJWAMuN
	 qtBPOdESdXGqyEDYNGlOMYLfoOTQoYQVixLaI87Nt+3VuYxMeqA4ckJ7+X3qwPVyK9
	 ar3ydV4g5jnbzSwGSyc2Umsr7nNAsO1GYj9YnWwuFUcXBk3EqnUAllpwlcjAsV6HgU
	 7hemX89VcWG/w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id AF1DEC009;
	Tue, 29 Aug 2023 12:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1693306666; bh=8ncS0sunhziwWJklUPIh2wAfxFidnYA26XwXE4eHzI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coDLhUKfSCF2HjK0+x7m5GxYs6z6XkXXjMBabkNL1AKWL+X/onFLFKU0lkVo9qR33
	 aYTaL6IIWBYQGeAM1c3C09bgtjZTt3+NwI6wTrzbZJOh00caH02waJcnPgaTWa5qoB
	 q2rxwdfv+XGtfmR8JotfUB+AsripW8xpRWg6Esrw1YjQyUox0+YkcA+C2pXWWQQmz0
	 Pi3HyUaQgGAEaaoesUlJeGkHGvONCQqQsUYHGgK4FSwUMT3OcYQYeMmzME6+IS8/cG
	 8SvuGbpzHqzXE2Aa7hqkjf58CE+SRl4+dA1qIDtLUJhwDFFJNykdjR+gOl/BuFwetx
	 iZtjnlfIKOGbw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id d7e74f75;
	Tue, 29 Aug 2023 10:57:39 +0000 (UTC)
Date: Tue, 29 Aug 2023 19:57:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, ericvh@kernel.org,
	kuba@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
Message-ID: <ZO3PFO_OpNfBW7bd@codewreck.org>
References: <000000000000d26ff606040c9719@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000d26ff606040c9719@google.com>

syzbot wrote on Tue, Aug 29, 2023 at 02:39:53AM -0700:
> ==================================================================
> BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
> 
> read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
>  p9_fd_open net/9p/trans_fd.c:842 [inline]
>  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
>  p9_client_create+0x595/0xa70 net/9p/client.c:1010
>  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
>  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
>  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
>  vfs_get_tree+0x51/0x190 fs/super.c:1519
>  do_new_mount+0x203/0x660 fs/namespace.c:3335
>  path_mount+0x496/0xb30 fs/namespace.c:3662
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
>  p9_fd_open net/9p/trans_fd.c:842 [inline]
>  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
>  p9_client_create+0x595/0xa70 net/9p/client.c:1010
>  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
>  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
>  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
>  vfs_get_tree+0x51/0x190 fs/super.c:1519
>  do_new_mount+0x203/0x660 fs/namespace.c:3335
>  path_mount+0x496/0xb30 fs/namespace.c:3662
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00008002 -> 0x00008802

Yes well that doesn't seem too hard to hit, both threads are just
setting O_NONBLOCK to the same fd in parallel (0x800 is 04000,
O_NONBLOCK)

I'm not quite sure why that'd be a problem; and I'm also pretty sure
that wouldn't work anyway (9p has no muxing or anything that'd allow
sharing the same fd between multiple mounts)

Can this be flagged "don't care" ?

-- 
Dominique Martinet | Asmadeus
