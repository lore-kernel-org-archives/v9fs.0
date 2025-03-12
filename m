Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B71DF735;
	Wed, 12 Mar 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773909; cv=none; b=nvHVDXKYixPuJ+AQTzDIdkRWTBr7T6VW7yBPbpSQWnm4S3saq8uUQGWl3WbPZZb8dXhPOBgGAb9bSSDV93mrlE2E28ayV6qGAYthJawGihE9FxyXl3jt8Pm7UCM3zya6MVKw9ljp8m62kbA58zy5Ya/aeYeamEb4UBRTj51At6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773909; c=relaxed/simple;
	bh=W17geC8O76oOSoaemmRBa62PV0mRbp043YTD+HRUYnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUPCeZVQ7PZWakM57S/dHBoRnk0twlS6vKhcqNRuzMkXkw/lyoHt7kOZmWurwFjPZJgypXfwzbmWF4dqv+dtwdpVwo+p8J9J9p6y9cd3hMi7YUVHKPWMRGcOPStYQEoKcBzgGndbamUuJlPoEobzB/U5ZuyVYMmz3NpmYKzhaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=rjoyd4mQ; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="rjoyd4mQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
	Content-ID:Content-Description;
	bh=soJ+7cSs0XAkqlkvlTIv9267QzTdaow+9b6Ns8vHX1g=; b=rjoyd4mQbsvG1wumRuzw7+XhRI
	uri5qMZzLMJsTOPq26FLWFyjGPhQgsfBoNunxpOcY+JAasvyZxDP0wEj630LPQoLINI43/yoAjaxr
	zf6VVeFm3QZ+AuV8NEWePIcCw/87TcoRn+tpG4onShV8vxiueN34cKT41DyvkvYRBQRRTnBHsLJ+i
	sje0/GuYuSCAfIz6Qu+g/hrEzLVJXIGVKyO0Kwd/hhN21YtdNM/MRuyDgIr49H8v3A23VNpeoOrFE
	LRk2xvHtVwyRDjm0Jg+tjol5ILNHv3gMoWTt4+R+svWaGQ+Lp30HRda2imMOOnsuJ7wJXgZH+8OsR
	dbIYbe/N+4xEV7e5JHvcWCQwvMFP+Sdwgb19nUTdoL8AbdNSlf3phFGnHmN6Z/1X10JGmcKtT87JX
	/WMsZoBUSxp3IuaT1KpF/EBg/M7b0Qz58h7efOnLbk39Ck18wNi4Rdfah0/mnSceNCrsI5Fm9ese6
	yiWMgld7nvUxJtUo1Hdklk9XeIXDknlELkn9L8/NTBYSfI4vzGFKYrWZlHCbMIT2gxoubxCD6gTDg
	0XrZOHn9y2hImNRLYEcvhIspd+HEp6X9to8yv6jxzu3Y5Wq1j0BBwCLVQaB9x1Ka7npdsPLNrb/wh
	+wtcwhfm1W7GUtShwqibRywu0Xy2V55lzOt+2qT6s=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org,
 lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
 syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [v9fs?] general protection fault in p9_client_walk
Date: Wed, 12 Mar 2025 10:36:15 +0100
Message-ID: <34836920.9mNPFRc1x4@silver>
In-Reply-To: <67d12512.050a0220.14e108.0024.GAE@google.com>
References: <67d12512.050a0220.14e108.0024.GAE@google.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 12, 2025 7:09:22 AM CET syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0fed89a961ea Merge tag 'hyperv-fixes-signed-20250311' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=173fa654580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f71f17a9b92472b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b667f9a1fee4ba3775a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6874580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138b17a8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0fed89a9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/178c4c7fb0b4/vmlinux-0fed89a9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/97ef169a8fde/bzImage-0fed89a9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 3 UID: 0 PID: 5936 Comm: syz-executor316 Not tainted 6.14.0-rc6-syzkaller-00016-g0fed89a961ea #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
> Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 3d 44 b0 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 0f 3f b0
> RSP: 0018:ffffc9000380faa0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: ffff88802a9bc880 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
> R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000701f56
> FS:  000055558c345380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f412d1932a9 CR3: 000000002107c000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  clone_fid fs/9p/fid.h:23 [inline]
>  v9fs_fid_xattr_set+0x119/0x2d0 fs/9p/xattr.c:121
>  v9fs_set_acl+0xe6/0x150 fs/9p/acl.c:276
>  v9fs_set_create_acl+0x4b/0x70 fs/9p/acl.c:306
>  v9fs_vfs_mkdir_dotl+0x517/0x6e0 fs/9p/vfs_inode_dotl.c:411
>  vfs_mkdir+0x57d/0x860 fs/namei.c:4313
>  do_mkdirat+0x301/0x3a0 fs/namei.c:4336
>  __do_sys_mkdir fs/namei.c:4356 [inline]
>  __se_sys_mkdir fs/namei.c:4354 [inline]
>  __x64_sys_mkdir+0xef/0x140 fs/namei.c:4354
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Just had a glimpse on it so far. IIUIC the trigger is in
v9fs_vfs_mkdir_dotl() [fs/9p/vfs_inode_dotl.c:411] ?

    // NULLs out fid (since dafbe6897)
    v9fs_fid_add(dentry, &fid);
    // expects fid being non-NULL
    v9fs_set_create_acl(inode, fid, dacl, pacl);

/Christian

> RIP: 0033:0x7fd26f335429
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff6d918e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 00004000000000c0 RCX: 00007fd26f335429
> RDX: 00007fd26f335429 RSI: 0000000000000040 RDI: 00004000000000c0
> RBP: 0000000000000073 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff6d919008 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
> Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 3d 44 b0 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 0f 3f b0
> RSP: 0018:ffffc9000380faa0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: ffff88802a9bc880 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
> R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000701f56
> FS:  000055558c345380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f412d1932a9 CR3: 000000002107c000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	28 00                	sub    %al,(%rax)
>    2:	00 00                	add    %al,(%rax)
>    4:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
>    b:	00
>    c:	31 c0                	xor    %eax,%eax
>    e:	e8 3d 44 b0 f6       	call   0xf6b04450
>   13:	48 89 d8             	mov    %rbx,%rax
>   16:	31 f6                	xor    %esi,%esi
>   18:	48 c1 e8 03          	shr    $0x3,%rax
>   1c:	66 89 74 24 40       	mov    %si,0x40(%rsp)
>   21:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
>   28:	00 00
> * 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>   2f:	0f 85 3e 04 00 00    	jne    0x473
>   35:	31 ff                	xor    %edi,%edi
>   37:	89 ee                	mov    %ebp,%esi
>   39:	4c 8b 33             	mov    (%rbx),%r14
>   3c:	e8                   	.byte 0xe8
>   3d:	0f 3f                	(bad)
>   3f:	b0                   	.byte 0xb0
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 


