Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF62331EB7;
	Wed, 23 Sep 2026 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129333; cv=none; b=ZZhS11ZIlQ0zUVxlEioS/wgz8XrvO1FHDeozND2j7UpDOWJv/qCMIa1p00eGGoonItKAPZ4vg007p4REqZTHe48aRSCIKmpm5Rj8KiaF6ZdJ+H7+WsPuBJ9XPEM2jv3glR82a5jjTwWWD9lZ18MLQYpPYWzm4c7Wwiy9ne8G+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129333; c=relaxed/simple;
	bh=PmTjRKDBXgh+W5tWEsZYZ9KHLKFUVFFLh0ZRc6EnRQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LtGwk9wGuEsDTAGfqoS7VASiz2OVdWf5S7vt1+yBIsC+BV8gvoc2lE43AwGvfmPpOqB6hACWsXIAs5XdWYSdczc/w06pOcQp2LalwG2Je67RuRpcglnRt1RyQd7dRMC1seY7/fuY3U/dtNrhsmqC98VTz8XIJEMkWug8rmIipfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LCZRO966; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LCZRO966"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BCF1F000FF;
	Wed, 23 Sep 2026 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790129331;
	bh=/Xadl+2XfugsueWfpjgIKjzsO4w2kEQaJhd+prKQ42Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LCZRO966MJXtXlmSnshT6skldVpCIVltLpzcANgImksrNBMw4dR0xcJfeHpjJixW6
	 /kLRDerxNAmBzlCUo+jtAldaykUQ3uGfcpfuCWVlmpjJjSz0B6vjzyBddSxi6twTrE
	 RUbUTdwWJBLX58EqtVnMHKXUEFgHN+FjKK1xGa1U=
Date: Tue, 22 Sep 2026 19:08:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: syzbot <syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com>,
 apopple@nvidia.com, byungchul@sk.com, david@kernel.org, gourry@gourry.net,
 joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Christian
 Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, Nguyen Ngoc
 Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in v9fs_fid_get_acl (2)
Message-Id: <20260922190850.02e782b7196791602163a3a9@linux-foundation.org>
In-Reply-To: <arJAGlhkDJbcy2sw@codewreck.org>
References: <6aae188b.71f81b7d.15fa6d.0004.GAE@google.com>
	<20260919031451.3f47a8da8405e88fa1ab5398@linux-foundation.org>
	<arJAGlhkDJbcy2sw@codewreck.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:45:14 +0900 Dominique Martinet <asmadeus@codewreck.org> wrote:

> (+Nguyen in Cc as he tried resending sloppy patches after this)
> 
> Andrew Morton wrote on Sat, Sep 19, 2026 at 03:14:51AM -0700:
> > > WARNING: mm/page_alloc.c:5340 at alloc_order_allowed mm/page_alloc.c:5340 [inline], CPU#0: syz.1.357/7872
> > > WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof+0x2137/0x3300 mm/page_alloc.c:5397, CPU#0: syz.1.357/7872
> > 
> > Thanks.  Caused by an old v9fs bug.  A fix was proposed but never merged:
> > https://lists.openwall.net/linux-kernel/2024/02/02/806?utm_source=chatgpt.com
> 
> Right, we've been going in circle with this since forever, and nobody
> answered Christian Schoenebeck's question[1] about what the limit should
> be, and while I don't care much ultimately I sort of agree with him
> (e.g. limit should be XATTR_SIZE_MAX for anything that the VFS layer
> touches, but acl are converted within the 9p subsystem and could be
> arbitrarily large so status quo of a KMALLOC_MAX_SIZE limit because they
> could come from something else)
> 
> Andrew, if you have an opinion on whether we should cap the acl sizes
> anyway, please say...

whome.  Well, if the converted ACLs can be large and it's hard to
figure out how large then yes, some pre-canned limit is difficult.  So
it's OK to leave the decision up to kmalloc() and just put a (nicely
commented!) __GFP_NOWARN in there.

otoh, if we're permitting workloads to trigger a large number of large
allocations then that might be a problem from a utilization or even DoS
point of view.

