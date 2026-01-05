Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34EAD24;
	Mon,  5 Jan 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614871; cv=none; b=tf0Vy6R2mWvlgE+70wFCH950Abg5qe0PNXUtov/zKFTVZaJfbGQxfZTRqZgglSTNzdQComAIZx/b7Kh6eMHFWa+qFMX+g0UkwysIaE8BzYDrO/UEZlzzehcjniP9Tlzc0Gd/G4A8okNOWDu+l0PnToupPT4mLNaJVSI/RqMv6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614871; c=relaxed/simple;
	bh=8yevn518m31rNK7FUGBjP1EMqqarpDE6dCHeU35IfuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NT9SNMB/b+E9fcE6YYZ9pI331BV9/EWZiVGi8/ZO3pCnjOdYjTyll8Bj+oW3Q6IEfzdqCFQO4FVzhJAu8MIGRDuNmHUc14OwuEhvjXhyK1V5xsSFzZlnt4JafS2VdGPOqByjJ1/fTWVIgnIQUsHdqdvKuUUUH/yTVz02r4h40v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=CIEkNh1l; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CIEkNh1l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=aMsBYhfMeQpamnQVk0OcW4dklUFY8yclRPpO6YXRCy8=; b=CIEkNh1lNLOH2XNZ/cozza3E9D
	bmesLTXkYtfcU69xcXMcyKG20iCO9KyWussGr+B0WM9ctZBYs74eC/YH9NOqSuAmSqcRWcRAs7+OZ
	jOBX/RORHD10OkL4bZGimTjdJ7slUqH3oqZZiLTWcrjyh3Vhzgj9pDWCJfhiSsJ/45UKvuxaUW+8/
	VWJ0OgZakyDxb2b7CPRWz/VqxzxkxZu5B0UKRbXUaTsWknm1iWmNxamvanxQGpJ4BhNh8uJY7XnSa
	k9f1fbScEP6FfOUaRg5F1gqQv6Wl9+jyVzmjeyXTxgioNDvc83QnbmRVHBiXfMEoh6yMQdXfuPGrx
	9guZeZef5OUB2GDLSxQkBP65wH2d9rQCuSshdxiu9WYJlA4YNrs9QQBczPJW3xyR6MdvIKS3F9PjC
	JEuFdrelLWSaAOSBBR5oxB/vynIs2znmjv6a1Stc7Bs8Ld8HFL45OE03LaV9xZW/lrXswsAJXdS9R
	oah1TlEBAdHYLdNke9p8r3yDdj3blvCNKQUfLFgLNzQCL6ouxN6HaNcGSFEbhZw6fZ/QBXuCRZoqX
	/qS4LvPybVYvlchafUCB3pO69YppTEVtAk2Ww62AmXf4vAdzrHD2/4EzBmNo/HSZRozcnm6ug1KrD
	tNToELHfPst6AdEVBq8dKsMpRqQ+5sKSAjz3Ufi9k=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Pierre Barre <pierre@barre.sh>, David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Pierre Barre <pierre@barre.sh>
Subject:
 Re: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Date: Mon, 05 Jan 2026 12:35:28 +0100
Message-ID: <2025543.PYKUYFuaPT@weasel>
In-Reply-To: <20251227180137.730385-1-pierre@barre.sh>
References: <20251227180137.730385-1-pierre@barre.sh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 27 December 2025 19:01:37 CET Pierre Barre wrote:
> With writeback caching (cache=mmap), v9fs_stat2inode() and
> v9fs_stat2inode_dotl() unconditionally overwrite i_size from the server
> response, even when dirty pages may exist locally. This causes processes
> using lseek(SEEK_END) to see incorrect file sizes, leading to data
> corruption when extending files while concurrent stat() calls occur.
> 
> Fix by passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is
> enabled to preserve the client's authoritative i_size.
> 
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---

Adding David Howells to this discussion.

David, I read today that you suggested [1] to go for a wait approach instead?
So somewhat similar to what Pierre suggested in v1 [2].

[1] https://lore.kernel.org/all/1696785.1767599663@warthog.procyon.org.uk/
[2] https://lore.kernel.org/all/20251227083751.715152-1-pierre@barre.sh/

I understand the point about cifs and nfs, where you must expect foreign
changes on server side by another client.

For 9pfs though IMO it would make sense to distinguish:

for cache=loose (and cache=fscache?) we are not expecting host side changes,
so we could safely go for the approach suggested by this patch here and not
wait for flushing dirty data and just use the locally cached file size (for
performance reasons).

And for all other cache modes going for the cifs/nfs approach and wait for
flushing? Does this make sense?

I just tested this reported issue with the following reproducer:

--------------------------

#!/bin/bash

rm -f foo.txt

for i in {1..50}
do
  echo $i >> foo.txt &
  ls -lha foo.txt &
done

sync

cat foo.txt

echo

wc -l foo.txt

--------------------------

For cache=loose I couldn't reproduce, but with cache=mmap I could reproduce
data corruption, folio writeback hangup and the following error message:

[   60.847671] [append] R=134d: No submit

...

[  243.153292] INFO: task sync:986 blocked for more than 120 seconds.
[  243.161516]       Tainted: G            E       6.19.0-rc1+ #107
[  243.168847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.178702] task:sync            state:D stack:0     pid:986   tgid:986   ppid:884    task_flags:0x400000 flags:0x00080002
[  243.190379] Call Trace:
[  243.192285]  <TASK>

[  243.193891]  __schedule (kernel/sched/core.c:5256 kernel/sched/core.c:6863)
[  243.195999]  schedule (kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[  243.197730]  io_schedule (kernel/sched/core.c:7764 (discriminator 1) kernel/sched/core.c:7790 (discriminator 1))
[  243.199418]  folio_wait_bit_common (mm/filemap.c:1312)
[  243.201451]  ? __pfx_wake_page_function (mm/filemap.c:1134)
[  243.203399]  folio_wait_writeback (./arch/x86/include/asm/bitops.h:202 ./arch/x86/include/asm/bitops.h:232 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:597 mm/page-writeback.c:3087)
[  243.205371]  __filemap_fdatawait_range (mm/filemap.c:529 (discriminator 1))
[  243.207377]  ? _raw_spin_unlock (./include/linux/spinlock_api_smp.h:143 (discriminator 3) kernel/locking/spinlock.c:186 (discriminator 3))
[  243.209305]  ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt.h:671 kernel/sched/sched.h:1570 kernel/sched/core.c:4995 kernel/sched/core.c:5112)
[  243.212030]  ? __schedule (kernel/sched/core.c:5259)
[  243.214083]  ? wb_wait_for_completion (fs/fs-writeback.c:227)
[  243.215925]  filemap_fdatawait_keep_errors (./arch/x86/include/asm/bitops.h:202 ./arch/x86/include/asm/bitops.h:232 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 mm/filemap.c:363 mm/filemap.c:627)
[  243.217628]  sync_inodes_sb (./include/linux/sched.h:2062 fs/fs-writeback.c:2777 fs/fs-writeback.c:2897)
[  243.218914]  ? __pfx_sync_inodes_one_sb (fs/sync.c:75)
[  243.220186]  __iterate_supers (fs/super.c:64 fs/super.c:925)
[  243.221601]  ksys_sync (fs/sync.c:103)
[  243.222746]  __do_sys_sync (fs/sync.c:115)
[  243.223950]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  243.226140]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
[  243.228375] RIP: 0033:0x7f51e4613707
[  243.230260] RSP: 002b:00007ffdb2fccad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  243.234092] RAX: ffffffffffffffda RBX: 00007ffdb2fccc38 RCX: 00007f51e4613707
[  243.238153] RDX: 00007f51e46f3501 RSI: 00007ffdb2fcef3e RDI: 00007f51e46ae557
[  243.241063] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[  243.244028] R10: 00007f51e45be0d0 R11: 0000000000000246 R12: 00005568f2d350fb
[  243.247586] R13: 0000000000000000 R14: 0000000000000000 R15: 00005568f2d37b00
[  243.251622]  </TASK>

BTW running this script with cache=loose made me realize that Linux 9p client
is always requesting server for every "ls foo.txt", which makes it extremely
slow unnecessarily.

>  fs/9p/vfs_inode.c      | 7 ++++++-
>  fs/9p/vfs_inode_dotl.c | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 97abe65bf7c1..bfba21f5d8a9 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -993,7 +993,12 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct
> path *path, if (IS_ERR(st))
>  		return PTR_ERR(st);
> 
> -	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
> +	/*
> +	 * With writeback caching, the client is authoritative for i_size.
> +	 * Don't let the server overwrite it with a potentially stale value.
> +	 */
> +	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
> 
>  	p9stat_free(st);
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 643e759eacb2..67a0ded2e223 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -453,7 +453,12 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
>  	if (IS_ERR(st))
>  		return PTR_ERR(st);
> 
> -	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
> +	/*
> +	 * With writeback caching, the client is authoritative for i_size.
> +	 * Don't let the server overwrite it with a potentially stale value.
> +	 */
> +	v9fs_stat2inode_dotl(st, d_inode(dentry),
> +		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
>  	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
>  	/* Change block size to what the server returned */
>  	stat->blksize = st->st_blksize;



