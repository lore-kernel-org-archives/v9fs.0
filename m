Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F24CDDCD
	for <v9fs@lists.linux.dev>; Tue, 22 Sep 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066740; cv=none; b=D2tUE+HYIdMs6vcCOVRbXA/E1nZKcfJGiTAZeXE+w5MLwTM1jGfsGW7dvJIKoMANqcvJk4ahdmRiXo4uHUky1S5+MPbnkOA0FuD0wrgkyjXCVx38wEb+9G/uLeR/3cjtKOoffz/AikTGDCT8IbKtOAr5rqMqPd7BXAzyvn5bFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066740; c=relaxed/simple;
	bh=z+ErQH/dLPjY+2r8NmCdjY4tyB0zuO+gYvECMucs33c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVxuO4c/lhFFbsnchT0gl/OhFDtH4O3yyhRLOBVa2qVl2hmCYsgoZPoJUWm3vO/zDDRNsZRq6E+Dgud6Vr6KvN0WQn7F55GwssItEMxLfNVHbocMQA23vGw1EOL6rMXJC5xEVW/wZn676YtzlCM25VIhwWrVZMHOhnSEHOuDTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PoYMuCbD; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PoYMuCbD"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8158014C2D6;
	Tue, 22 Sep 2026 10:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1790066736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMkqWegiB0G0RPwXQW4iIweHXM+gp+p17tn0BymDpW4=;
	b=PoYMuCbD9oC73v8MabIRDQ3JYH4XeiHnm5aaAnrfKac+pcFVw4u0zG7Q5mO/e9wxlyeOe1
	wPCpRD4zwp1eT+md7c3/W0aYzOGHlnT6XAd34OlyX3hv644M2SrlvG9My5h0E0JjR/haAm
	ybqfvaacyuI66Ycljs6YAwFwuRtx0CHUVbs9OxdIiRyxGfXNdfcsrWzVw19u+VGcM8FNWY
	Im0iNN6j6OH7JGsKriu7qK96ggrORz8IKbl/de/VP6+UJsZ1LQ5eAIWIK96cIou9vZpJ7X
	62BWFHiHBNxIWrUKhHUP5AY/PpCAmhqqKAFZ0q7bndsF8kef3Gww0bAYOPxKFQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 02e7d134;
	Tue, 22 Sep 2026 08:45:29 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:45:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com>,
	apopple@nvidia.com, byungchul@sk.com, david@kernel.org,
	gourry@gourry.net, joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	matthew.brost@intel.com, rakie.kim@sk.com,
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in v9fs_fid_get_acl (2)
Message-ID: <arJAGlhkDJbcy2sw@codewreck.org>
References: <6aae188b.71f81b7d.15fa6d.0004.GAE@google.com>
 <20260919031451.3f47a8da8405e88fa1ab5398@linux-foundation.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919031451.3f47a8da8405e88fa1ab5398@linux-foundation.org>

(+Nguyen in Cc as he tried resending sloppy patches after this)

Andrew Morton wrote on Sat, Sep 19, 2026 at 03:14:51AM -0700:
> > WARNING: mm/page_alloc.c:5340 at alloc_order_allowed mm/page_alloc.c:5340 [inline], CPU#0: syz.1.357/7872
> > WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof+0x2137/0x3300 mm/page_alloc.c:5397, CPU#0: syz.1.357/7872
> 
> Thanks.  Caused by an old v9fs bug.  A fix was proposed but never merged:
> https://lists.openwall.net/linux-kernel/2024/02/02/806?utm_source=chatgpt.com

Right, we've been going in circle with this since forever, and nobody
answered Christian Schoenebeck's question[1] about what the limit should
be, and while I don't care much ultimately I sort of agree with him
(e.g. limit should be XATTR_SIZE_MAX for anything that the VFS layer
touches, but acl are converted within the 9p subsystem and could be
arbitrarily large so status quo of a KMALLOC_MAX_SIZE limit because they
could come from something else)

Andrew, if you have an opinion on whether we should cap the acl sizes
anyway, please say...

[1] https://lore.kernel.org/all/Z1n-Ue19Pa_AWVu0@codewreck.org/T/#md7c1e009696501b3b87940cb613150bdebd1db28


-- 
Dominique Martinet | Asmadeus
