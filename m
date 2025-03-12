Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057D24EF95;
	Wed, 12 Mar 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789533; cv=none; b=j/UWQf0Bn1aB8R5cgCATCK/187Db67yn3XHaFBWGlPnnTkLcaTqIkNW8ubI8AEt7S7224SN31jAkZ9aHm2FUf9KODjssXuQ7QWQ/oj/PujNZu5Sxl7JVXmeJfqH3DuQPcJUeS6kKFLK2kqvJUCq4qA9SlIvKmOdhSaAT4PzybwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789533; c=relaxed/simple;
	bh=x6T9aD4BdJmQwzEvC4ijUHZvSUttTlpvmtjHr0kVh38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNx/w7EAAYhssb1reIoebiKDaW8emrdGafuHfm6VtWQJnhd9ChFE309lyE1Si3pMVQyMfGGIS3J9oR44P3C4yT0ropmIpDcMjHki/rq3sdwv//wITXxq/AUQtr1lEHQ9e0l5+NRuqPoWBrWhjx9rmsaLItgUP4B8nhEGZIro5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=lGHVO7V1; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lGHVO7V1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=N1M5VC4eWrmyPabJyPrA1ksFNZYpzAlILTwOn36W+dg=; b=lGHVO7V1tb/YMji3+1EX36VaJL
	v+AOTW81qBDvA97wvJEfWmSmtS5sdGUEkfD58wxTIRN0Dwfuh0A63BNqh5VbLqf4hrz9yA3Skf+JJ
	r6Mt6uLkNRE5ZxyLDTnEZ4rRRW6fzK+xMtdAN3tmmH5391er4lbQvm1CGns+cT4hxx7JyDzkBam5H
	vb13dEvzNrVjh2ybJ0LmgOyDCas9X5Fl591QoESqOrjb0xG+EbZxWqaCcL6dDuD9aJ7yUceVSZaUF
	gPbmSGVnm69bbYBz5l8+54Pz2+HBvurjVh0MDaXuIWvxNwMEn5zAfhvsgz9E22aao6qnM49J9x2Cz
	fNG06sKA/cLKndhoXCfnpk+pv3h1QAc6OaGlPkemvLwALWm4WXyJ10Tmv9cGZm4NtDF/rAuO8Nl0V
	gKNmizQHkSHDa0fU4ziz4yKPGx6+VdU4CDHFmnACl9B5iJhyyFLXFmtGwyhVrzXsc+yc4KYW7ep0n
	4BGG8y1LWdLEHs4M98gjgwEtsiZ+flC1zeSQhlb+25y050Ka6Elv71Br6rGRsYFnJpe+uiLKDK37s
	2waWRPyt0lX6CIfqp+VlMpSOnm8sAY60XJy5JpGmwsPROAayvSKaY23DyGkGmSiWppqlS/A0nLuaW
	a6CrsZBlPaVgM9lYhp1kSzWyzPp43ZIfkO/9gDwNw=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
 syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [v9fs?] general protection fault in p9_client_walk
Date: Wed, 12 Mar 2025 15:25:27 +0100
Message-ID: <2115265.hiCNZqmPJN@silver>
In-Reply-To: <Z9F6cakkpF26_KJu@codewreck.org>
References:
 <67d12512.050a0220.14e108.0024.GAE@google.com> <34836920.9mNPFRc1x4@silver>
 <Z9F6cakkpF26_KJu@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 12, 2025 1:13:37 PM CET asmadeus@codewreck.org wrote:
> Christian Schoenebeck wrote on Wed, Mar 12, 2025 at 10:36:15AM +0100:
> > > RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
> > >  clone_fid fs/9p/fid.h:23 [inline]
> > >  v9fs_fid_xattr_set+0x119/0x2d0 fs/9p/xattr.c:121
> > >  v9fs_set_acl+0xe6/0x150 fs/9p/acl.c:276
> > >  v9fs_set_create_acl+0x4b/0x70 fs/9p/acl.c:306
> > >  v9fs_vfs_mkdir_dotl+0x517/0x6e0 fs/9p/vfs_inode_dotl.c:411
> > >  vfs_mkdir+0x57d/0x860 fs/namei.c:4313
> > >  do_mkdirat+0x301/0x3a0 fs/namei.c:4336
> > >  __do_sys_mkdir fs/namei.c:4356 [inline]
> > >  __se_sys_mkdir fs/namei.c:4354 [inline]
> > >  __x64_sys_mkdir+0xef/0x140 fs/namei.c:4354
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Just had a glimpse on it so far. IIUIC the trigger is in
> > v9fs_vfs_mkdir_dotl() [fs/9p/vfs_inode_dotl.c:411] ?
> > 
> >     // NULLs out fid (since dafbe6897)
> >     v9fs_fid_add(dentry, &fid);
> >     // expects fid being non-NULL
> >     v9fs_set_create_acl(inode, fid, dacl, pacl);
> 
> Sounds about right, inverting the two calls probably makes sense?

Yeah, that was also my first though. Just didn't have time yet to check
whether that dentry was needed somewhere downwards that v9fs_set_create_acl()
call stack.

> OTOH I don't get why all mkdirs don't hit that.. ah, it's only a problem
> if the parent directory has some ACL and none of our tests hit that :/

There are test cases now?

> Well, it shouldn't be too hard to trigger & fix anyway, since you've
> done this much want to send the patch?

If it is not super urgent then I'll schedule some cycles. Not worried if
anyone is faster of course.

/Christian


