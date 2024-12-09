Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051041B4245
	for <v9fs@lists.linux.dev>; Mon,  9 Dec 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756828; cv=none; b=rOYFRCfrGt8/LWRWaYWvJwYAZSNjkc9FJMxy57W1pEtSYW9Un4SO2rbWmZnb/XAa9AjlytF/MxB/MMqoWRxokXxef5uBDPxT6oYMC6T0R7zki/lDhu84sY9wGSdxJeb8at5CrCA1vxZSO11j22oGL729f1DNeUh0s9hH1I94OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756828; c=relaxed/simple;
	bh=erU6nZTNkXoRFcVcZc1N0+s+5zFtZl1ki3beqp2JtYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KleLYlIXqUj6zQ8FGioaMPbkeVbyFmTn1knFlCkVIWWltYKDuPyQL1Gn5zAxicbtgugZLHHyeg9fMkoA+JKeudwriC6pxLnlundfU5Knq/RfbWrbJcI8eUHQd/H+3hfIB5bqoy1tmQnnEEY3GL2K+B9UzXE8+Gk2fudsTL8CH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso42305845ab.0
        for <v9fs@lists.linux.dev>; Mon, 09 Dec 2024 07:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756825; x=1734361625;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGQBWcDcxC8PTUtma5Rl3wbg+XdVdV4St9AhsdLUDTI=;
        b=e204qF7JVOPiQ0yT1pQHO/+aNcJMg38OV94XH7HWy8aTvlNnegkod/TVzzfFOLVA0w
         xpcwGpqbfn/aco+i6bKlyJyCauJW9qBf2cBhciXuyeiNF4/O8OzJTp24nPUrjLTZRxl4
         BzLlcEEmSD8cLDC9SlfIBMwgwoDXZvoNi48OD9BABXHw9qME990t+u3ELyIOkD9WCym8
         97OW7F9XHc68UYL9Z+A7KrK4a9py2QoyHojhewNvISqEsdvYvT2XsXO8bCzqPCzsrx3j
         nErtUT7cGdXltremJoK7Mz4qmRxOZCV8YgRILA3Jd0+sCWvThAaURISZzNd5SdyMBuwN
         rLhA==
X-Forwarded-Encrypted: i=1; AJvYcCViSYaVg3DQ+NjKd7v+LD6hsDqib2Dnjc9d8CgapcaJXa4t9O88PtKNcSOS9bqx72xzYjSB@lists.linux.dev
X-Gm-Message-State: AOJu0YyKI6WyczIe+aDDkahjANvBwehpQCvcehsiKsPHldKGDO/gO/ee
	LlqatW5fH4KBI2rI3VLzZAAEObKyRnszmHlxe7OrPfRjWUwUvkshxMQJhX7sXS+i8wX+wfeHBnG
	zCLjJK12O1jQrzeMRwFny3kBxlI9qZ/ZxDp5I4NnXiQfhhUbUuiesQyA=
X-Google-Smtp-Source: AGHT+IFRIi9dd8FkLIwn/Td/R1grHmgTm25yl5feYxK8cblH/9KhVr7xCO/WQGh0mAllToNsKcrr7EqVVYiiApC+jAkWiOJlfwkv
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3a811e02ee5mr136405305ab.9.1733756825068; Mon, 09 Dec 2024
 07:07:05 -0800 (PST)
Date: Mon, 09 Dec 2024 07:07:05 -0800
In-Reply-To: <2131863.1733756813@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67570799.050a0220.a30f1.01a6.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: akpm@linux-foundation.org, asmadeus@codewreck.org, dhowells@redhat.com, 
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 3

>
> commit 78513c0ee0d9a767b5c2568c6c220a941e73529c
> Author: Lizhi Xu <lizhi.xu@windriver.com>
> Date:   Fri Nov 8 11:40:20 2024 +0800
>
>     netfs: If didn't read new data then abandon retry
>     
>     syzkaller reported a three-level circle calls (netfs_rreq_assess,
>     netfs_retry_reads, netfs_rreq_terminated), during an unbuffered or direct
>     I/O read.  [1]
>     
>     netfs_rreq_terminated() only checks that subreq's transferred is greater
>     than consumed and then sets the retry flag. There is no limit on the number
>     of retries, and there is no judgment on whether the retry is effective in
>     reading new data. This hitting the stack guard page.
>     
>     To avoid the issue, let's add retry read times and the length of the data
>     just read in struct netfs_io_subrequest, use them to assess the state of a
>     read request and decide what to do retry.
>     
>     [1]
>     BUG: TASK stack guard page was hit at ffffc9000482ff48 (stack is ffffc90004830000..ffffc90004838000)
>     Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
>     CPU: 3 UID: 0 PID: 6237 Comm: syz-executor663 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>     RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
>     Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 c0 4d 7a
>     RSP: 0018:ffffc9000482ff50 EFLAGS: 00010086
>     RAX: 000000000000000c RBX: ffff8880306c2fba RCX: 0000000000000002
>     RDX: dffffc0000000000 RSI: ffff8880306c2f98 RDI: ffff8880306c2440
>     RBP: ffffc90004830088 R08: 0000000000000000 R09: 0000000000000006
>     R10: ffffffff96e2dd27 R11: 0000000000000000 R12: dffffc0000000000
>     R13: ffff8880306c2f98 R14: 0000000000000008 R15: ffff8880306c2440
>     FS:  00007fedf3b6e6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffc9000482ff48 CR3: 000000002c910000 CR4: 0000000000352ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <#DF>
>      </#DF>
>      <TASK>
>      mark_usage kernel/locking/lockdep.c:4646 [inline]
>      __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
>      lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
>      local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
>      ___slab_alloc+0x123/0x1880 mm/slub.c:3695
>      __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>      __slab_alloc_node mm/slub.c:3961 [inline]
>      slab_alloc_node mm/slub.c:4122 [inline]
>      kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4141
>      radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
>      idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
>      idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
>      idr_alloc+0xc1/0x130 lib/idr.c:87
>      p9_tag_alloc+0x394/0x870 net/9p/client.c:321
>      p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
>      p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
>      p9_client_read_once+0x443/0x820 net/9p/client.c:1570
>      p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
>      v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
>      netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
>      netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
>      netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>      netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>      netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>      netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>      netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>      netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>      netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>      ...
>      netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>      netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>      netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>      netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>      netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>      netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
>      netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
>      netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
>      netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
>      netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
>      netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
>      v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
>      do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
>      vfs_readv+0x4cf/0x890 fs/read_write.c:1025
>      do_preadv fs/read_write.c:1142 [inline]
>      __do_sys_preadv fs/read_write.c:1192 [inline]
>      __se_sys_preadv fs/read_write.c:1187 [inline]
>      __x64_sys_preadv+0x22d/0x310 fs/read_write.c:1187
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7fedf3bd4dd9
>     Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007fedf3b6e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
>     RAX: ffffffffffffffda RBX: 00007fedf3c5e318 RCX: 00007fedf3bd4dd9
>     RDX: 0000000000000001 RSI: 00000000200015c0 RDI: 0000000000000003
>     RBP: 00007fedf3c5e310 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000246 R12: 00007fedf3c5e31c
>     R13: 000000000000000b R14: 00007fffe9d355b0 R15: 00007fffe9d35698
>      </TASK>
>     
>     Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
>     Closes: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Suggested-by: Lizhi Xu <lizhi.xu@windriver.com> [2]
>     cc: Dominique Martinet <asmadeus@codewreck.org>
>     cc: Jeff Layton <jlayton@kernel.org>
>     cc: v9fs@lists.linux.dev
>     cc: netfs@lists.linux.dev
>     cc: linux-fsdevel@vger.kernel.org
>     Link: https://lore.kernel.org/r/20241108034020.3695718-1-lizhi.xu@windriver.com/ [2]
>
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 819c75233235..3bc9ce6c575e 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -57,6 +57,8 @@ static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
>  	int err, len;
>  
>  	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
> +	if (len > 0)
> +		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>  	netfs_write_subrequest_terminated(subreq, len ?: err, false);
>  }
>  
> @@ -80,8 +82,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  	if (pos + total >= i_size_read(rreq->inode))
>  		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
>  
> -	if (!err)
> +	if (!err) {
>  		subreq->transferred += total;
> +		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +	}
>  
>  	netfs_read_subreq_terminated(subreq, err, false);
>  }
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 34107b55f834..ccb6aa8027c5 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -122,7 +122,7 @@ static void afs_issue_write_worker(struct work_struct *work)
>  	if (subreq->debug_index == 3)
>  		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
>  
> -	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
> +	if (!subreq->retry_count) {
>  		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
>  	}
> @@ -149,6 +149,9 @@ static void afs_issue_write_worker(struct work_struct *work)
>  	afs_wait_for_operation(op);
>  	ret = afs_put_operation(op);
>  	switch (ret) {
> +	case 0:
> +		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +		break;
>  	case -EACCES:
>  	case -EPERM:
>  	case -ENOKEY:
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index 46ce3b7adf07..47ed3a5044e2 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -438,7 +438,7 @@ void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
>  	     rreq->origin == NETFS_READPAGE ||
>  	     rreq->origin == NETFS_READ_FOR_WRITE)) {
>  		netfs_consume_read_data(subreq, was_async);
> -		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> +		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>  	}
>  }
>  EXPORT_SYMBOL(netfs_read_subreq_progress);
> @@ -497,7 +497,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
>  		     rreq->origin == NETFS_READPAGE ||
>  		     rreq->origin == NETFS_READ_FOR_WRITE)) {
>  			netfs_consume_read_data(subreq, was_async);
> -			__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> +			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>  		}
>  		rreq->transferred += subreq->transferred;
>  	}
> @@ -511,10 +511,13 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
>  		} else {
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
>  			if (subreq->transferred > subreq->consumed) {
> -				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> -				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> -				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
> -			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
> +				/* If we didn't read new data, abandon retry. */
> +				if (subreq->retry_count &&
> +				    test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
> +					__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +					set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
> +				}
> +			} else if (test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
>  				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
>  			} else {
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 0350592ea804..0e72e9226fc8 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -56,6 +56,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
>  				break;
>  			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> +				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +				subreq->retry_count++;
>  				netfs_reset_iter(subreq);
>  				netfs_reissue_read(rreq, subreq);
>  			}
> @@ -137,7 +139,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			stream0->sreq_max_len = subreq->len;
>  
>  			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> -			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +			subreq->retry_count++;
>  
>  			spin_lock_bh(&rreq->lock);
>  			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> @@ -213,7 +216,6 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			subreq->error = -ENOMEM;
>  		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
>  		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> -		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  	}
>  	spin_lock_bh(&rreq->lock);
>  	list_splice_tail_init(&queue, &rreq->subrequests);
> diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
> index 82290c92ba7a..ca3a11ed9b54 100644
> --- a/fs/netfs/write_collect.c
> +++ b/fs/netfs/write_collect.c
> @@ -179,7 +179,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
>  				struct iov_iter source = subreq->io_iter;
>  
>  				iov_iter_revert(&source, subreq->len - source.count);
> -				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  				netfs_reissue_write(stream, subreq, &source);
>  			}
> @@ -234,7 +233,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
>  			/* Renegotiate max_len (wsize) */
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
>  			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> -			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +			subreq->retry_count++;
>  			stream->prepare_write(subreq);
>  
>  			part = min(len, stream->sreq_max_len);
> @@ -279,7 +278,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
>  			subreq->start		= start;
>  			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
>  			subreq->stream_nr	= to->stream_nr;
> -			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +			subreq->retry_count	= 1;
>  
>  			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
>  					     refcount_read(&subreq->ref),
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index bf6d507578e5..ff0e82505a0b 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -244,6 +244,8 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
>  	iov_iter_advance(source, size);
>  	iov_iter_truncate(&subreq->io_iter, size);
>  
> +	subreq->retry_count++;
> +	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
>  	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
>  	netfs_do_issue_write(stream, subreq);
>  }
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index bd42a419458e..6cb1e81993f8 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -1319,14 +1319,16 @@ cifs_readv_callback(struct mid_q_entry *mid)
>  	}
>  
>  	if (rdata->result == -ENODATA) {
> -		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
>  		rdata->result = 0;
> +		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
>  	} else {
>  		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
>  		if (trans < rdata->subreq.len &&
>  		    rdata->subreq.start + trans == ictx->remote_i_size) {
> -			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
>  			rdata->result = 0;
> +			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
> +		} else if (rdata->got_bytes > 0) {
> +			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
>  		}
>  	}
>  
> @@ -1670,10 +1672,13 @@ cifs_writev_callback(struct mid_q_entry *mid)
>  		if (written > wdata->subreq.len)
>  			written &= 0xFFFF;
>  
> -		if (written < wdata->subreq.len)
> +		if (written < wdata->subreq.len) {
>  			result = -ENOSPC;
> -		else
> +		} else {
>  			result = written;
> +			if (written > 0)
> +				__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
> +		}
>  		break;
>  	case MID_REQUEST_SUBMITTED:
>  	case MID_RETRY_NEEDED:
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 010eae9d6c47..458b53d1f9cb 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4615,6 +4615,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>  			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
>  			rdata->result = 0;
>  		}
> +		__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
>  	}
>  	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
>  			      server->credits, server->in_flight,
> @@ -4840,10 +4841,12 @@ smb2_writev_callback(struct mid_q_entry *mid)
>  		if (written > wdata->subreq.len)
>  			written &= 0xFFFF;
>  
> -		if (written < wdata->subreq.len)
> +		if (written < wdata->subreq.len) {
>  			wdata->result = -ENOSPC;
> -		else
> +		} else if (written > 0) {
>  			wdata->subreq.len = written;
> +			__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
> +		}
>  		break;
>  	case MID_REQUEST_SUBMITTED:
>  	case MID_RETRY_NEEDED:
> @@ -5012,7 +5015,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
>  	}
>  #endif
>  
> -	if (test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
> +	if (wdata->subreq.retry_count > 0)
>  		smb2_set_replay(server, &rqst);
>  
>  	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 5eaceef41e6c..4083d77e3f39 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -185,6 +185,7 @@ struct netfs_io_subrequest {
>  	short			error;		/* 0 or error that occurred */
>  	unsigned short		debug_index;	/* Index in list (for debugging output) */
>  	unsigned int		nr_segs;	/* Number of segs in io_iter */
> +	u8			retry_count;	/* The number of retries (0 on initial pass) */
>  	enum netfs_io_source	source;		/* Where to read from/write to */
>  	unsigned char		stream_nr;	/* I/O stream this belongs to */
>  	unsigned char		curr_folioq_slot; /* Folio currently being read */
> @@ -194,14 +195,13 @@ struct netfs_io_subrequest {
>  #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
>  #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
>  #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
> -#define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
> +#define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
>  #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
>  #define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
>  #define NETFS_SREQ_HIT_EOF		7	/* Set if short due to EOF */
>  #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
>  #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
> -#define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
> -#define NETFS_SREQ_FAILED		11	/* Set if the subreq failed unretryably */
> +#define NETFS_SREQ_FAILED		10	/* Set if the subreq failed unretryably */
>  };
>  
>  enum netfs_io_origin {
>
