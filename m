Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7E537FF
	for <v9fs@lists.linux.dev>; Thu, 13 Mar 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872851; cv=none; b=GgjgQ3Bwxr/hUmTQuxMbH8yFqOYOr549xUTXG0zScgh86w+snl0wlbeXEBHTA0hBaD907SaN/1qKWLJSzwz1l8K2xDX0ppMaY5fT+Smi2+ZWBIdfNbGVQvd8XcH9gwarE2YXv9Gvr1B/b1rayCCMa8CXg9tMjl03ts/wojElUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872851; c=relaxed/simple;
	bh=p9pO1Dh5i1mI+kxl7fBF0Z2buokBUlPWYzwtIDs2ZSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEAeE0ME2XT54sVaK9mOuWtXCEnSvqc7kGrl3Ut0FKxuj0/psyQsLgzircrGQjLpicvUXCpOKoP8GETbTQ5THfOwHSWXfTbBCsdp+9PhrEz6CSuaLHnSa3JcpG6OLKtFcT6QjPw+eavx24xOtWrKFZlH4KIxryZ2oODTLosKjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=27yAvhoh; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="27yAvhoh"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7D8E714C2D3;
	Thu, 13 Mar 2025 14:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1741872842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjTF37SNnxkBpB2MiFl8F1xIEEcE091gYhI+2+SrGcU=;
	b=27yAvhohID0fWiXqSYo3Za072nv27URh9jKoVEbwbnAN7jZfClvR3DaNVtJpuZMPCs5VKG
	uO457qloTAPYXSxXDyIm4Ps2sJTaO3PbOnGoy36sQhc4AhlVo6VAtt7qLsenqXDIhGYn+Q
	QD1aF9MYziobyfQCjzeEmSCrXFQR1RTA/3KuqCtu/IHfXpIglExj2D6Bpis6h808C2wr58
	8NNlgUX3KlNavcPYR8PK9+H8xDSAphovSqNQJwZ5I7k25MPXwL879KpMBIy2nsEIRCBTRz
	Xi48ChTaIWio4BkrfbQr9iJtMxLWb4i1p3oE4PgIYLxsNZL0e2xQKmMC1mMMuQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d99e76a3;
	Thu, 13 Mar 2025 13:33:58 +0000 (UTC)
Date: Thu, 13 Mar 2025 22:33:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/9p: fix NULL pointer dereference on mkdir
Message-ID: <Z9Let2cdA4dB7tTe@codewreck.org>
References: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
 <4597443.VRNSQfLuZI@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4597443.VRNSQfLuZI@silver>

Christian Schoenebeck wrote on Thu, Mar 13, 2025 at 02:29:42PM +0100:
> On Thursday, March 13, 2025 1:59:32 PM CET Christian Schoenebeck wrote:
> > When a 9p tree was mounted with option 'posixacl', parent directory had a
> > default ACL set for its subdirectories, e.g.:
> > 
> >   setfacl -m default:group:simpsons:rwx parentdir
> > 
> > then creating a subdirectory crashed 9p client, as v9fs_fid_add() call in
> > function v9fs_vfs_mkdir_dotl() sets the passed 'fid' pointer to NULL
> > (since dafbe689736) even though the subsequent v9fs_set_create_acl() call
> > expects a valid non-NULL 'fid' pointer:
> > 
> >   [   37.273191] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   ...
> >   [   37.322338] Call Trace:
> >   [   37.323043]  <TASK>
> >   [   37.323621]  ? __die+0x1f/0x60
> >   [   37.324448]  ? page_fault_oops+0x158/0x470
> >   [   37.325532]  ? search_module_extables+0x4a/0x80
> >   [   37.326742]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
> >   [   37.328006]  ? search_bpf_extables+0x5b/0x80
> >   [   37.329142]  ? exc_page_fault+0x72/0x190
> >   [   37.330196]  ? asm_exc_page_fault+0x22/0x30
> >   [   37.331330]  ? p9_client_walk+0x1c/0x2c0 [9pnet]
> >   [   37.332562]  ? v9fs_fid_xattr_get+0x59/0x120 [9p]
> >   [   37.333824]  v9fs_fid_xattr_set+0x6f/0x130 [9p]
> >   [   37.335077]  v9fs_set_acl+0x82/0xc0 [9p]
> >   [   37.336112]  v9fs_set_create_acl+0x41/0x60 [9p]
> >   [   37.337326]  v9fs_vfs_mkdir_dotl+0x20d/0x2e0 [9p]
> >   [   37.338590]  vfs_mkdir+0x192/0x250
> >   [   37.339535]  do_mkdirat+0x135/0x160
> >   [   37.340465]  __x64_sys_mkdir+0x42/0x60
> >   [   37.341455]  do_syscall_64+0x4b/0x110
> >   [   37.342447]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Oops, forgot to decode the trace back:
> 
> [   37.322338] Call Trace:
> [   37.323043]  <TASK>
> [   37.323621] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
> [   37.324448] ? page_fault_oops (arch/x86/mm/fault.c:714) 
> [   37.325532] ? search_module_extables (kernel/module/main.c:3733) 
> [   37.326742] ? p9_client_walk (net/9p/client.c:1165) 9pnet 
> [   37.328006] ? search_bpf_extables (kernel/bpf/core.c:804) 
> [   37.329142] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:686 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538) 
> [   37.330196] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574) 
> [   37.331330] ? p9_client_walk (net/9p/client.c:1165) 9pnet 
> [   37.332562] ? v9fs_fid_xattr_get (fs/9p/xattr.c:30) 9p 
> [   37.333824] v9fs_fid_xattr_set (fs/9p/fid.h:23 fs/9p/xattr.c:121) 9p 
> [   37.335077] v9fs_set_acl (fs/9p/acl.c:276) 9p 
> [   37.336112] v9fs_set_create_acl (fs/9p/acl.c:307) 9p 
> [   37.337326] v9fs_vfs_mkdir_dotl (fs/9p/vfs_inode_dotl.c:411) 9p 
> [   37.338590] vfs_mkdir (fs/namei.c:4313) 
> [   37.339535] do_mkdirat (fs/namei.c:4336) 
> [   37.340465] __x64_sys_mkdir (fs/namei.c:4354) 
> [   37.341455] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> [   37.342447] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Dominique, do you want me to send a v2 or would you update the commit log on
> your end?

Thank you for the quick patch!
I can update the message on my end unless there's another reason to send
a v2

Looks good to me, I'll test a bit over the weekend and send to Linus in
the merge window in a couple of weeks (I guess it could be sent right
away...)
-- 
Dominique
