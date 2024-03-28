Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BE39FCF
	for <v9fs@lists.linux.dev>; Thu, 28 Mar 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640651; cv=none; b=MsurxcvMEOEoRHPpV2m0I2fSxM7+5jXsgfODf/puAj0NQJJ2E+BFO3Du1XES8jU2w1q/KMjUz/P+NsMFa2p6AOxcokIs+e7DQfHR6a9NEGFiCopoTu1/RSLnkIEOKcOZsWGkRwkxP2unUSdpUh8h/yS+dUAiiVW28bMHnQsuxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640651; c=relaxed/simple;
	bh=uoyAIf/qEu61Wyvx0Q/klA+RxVVfAK/6K/hGD+TN4FQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SUjJbwTlniFWK/1DMxiCx4AZvebDBL1oxhO9zEXAviS1/PiRABydMFurd7RsdkflkjZnKB+VOh4kMQiP8NNYZ+bnxvTxpR+msN2bFXYq7NBsNm+6J6/cBt2JkgwBlM0y3I2YD7mhspkrCSVO9wL5AA//wQCumU2iBj5+WFkKJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=e6dDf5Oi; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="e6dDf5Oi"
Received: from donnerschlag.zhasha.com (unknown [192.168.0.230])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 27B20325653;
	Thu, 28 Mar 2024 16:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1711640274;
	bh=O7ljGWIT+F01FQd35I/xaP12h6pu/KQOlziQz7EFT/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e6dDf5Oih4xvoW/jbZYoXdFJwOkchyyKEUYPMwS0ev3bnvHrnLc0vpDx8JQ2qc3DI
	 wag5y3nMqJxmu+6SyWw8szK30hZVjXGCCTAdoSm+a4ysc8eJzZZM+l+lVKu8fId/6G
	 1Y5r6Rf19xivCEItBDKo6fthgVX2StX1/D+51wA4=
Date: Thu, 28 Mar 2024 16:37:53 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
Message-Id: <20240328163753.eb3541f4c8595de40f5e3c82@zhasha.com>
In-Reply-To: <145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
References: <20240318112542.18863-1-opensource@zhasha.com>
	<20240318112542.18863-3-opensource@zhasha.com>
	<145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:08:59 +0000, "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev> wrote:
> Slowly parsing through these, thanks for the fixes.
> This one has a bit of a problem in that we don't have a v9fs specific
> drop_inode anymore (either in legacy or .L). The release of the fid should 
> be handled by v9fs_dir_release in both versions of the protocol. 

My apologies. I didn't realize that it had been changed in the next
branch until after sending it and I haven't had the time to check how
it's supposed to work now.

> I had convinced myself we could just use generic_drop_inode because we 
> decoupled clunking fids from the dentry/inode structures and just handled
> them directly in v9fs_dir_release -- so really by recovering the inode 
> structure every time we were just forcing churn in the inode alloc/dealloc
> routines that seemed unnecessary (even in the uncached mode).

I agree that the alloc followed by immediately dropping it from the
cache is a waste of cycles. This was just the most reliable way I knew
of fixing it without impacting anything else.

> Was your concern the performance of the client side lookup of the inode
> based on qid or the server side based on fid and can you give me a bit
> more information on what you are seeing?  Are you not seeing fid clunks
> for certain conditions (ie. transient fids, etc.)?

This is what I'm seeing in slabtop on a system with no caching enabled
on a 6.1 kernel. I never tested if it persisted on the 6.6 kernel but I
assume it would.

 Active / Total Objects (% used)    : 2738808 / 2788118 (98.2%)
 Active / Total Slabs (% used)      : 89853 / 89853 (100.0%)
 Active / Total Caches (% used)     : 164 / 261 (62.8%)
 Active / Total Size (% used)       : 1071558.97K / 1084648.27K (98.8%)
 Minimum / Average / Maximum Object : 0.02K / 0.39K / 16.01K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
1235968 1235915  99%    0.06K  19312       64     77248K lsm_inode_cache
1200339 1200339 100%    0.75K  57159       21    914544K v9fs_inode_cache
 62136  54815  88%    0.11K   1726       36      6904K buffer_head
 49400  45639  92%    0.20K   2600       19     10400K dentry
 26368  26364  99%    0.03K    206      128       824K avtab_node
 26222  15713  59%    0.57K   1873       14     14984K radix_tree_node
 19162  18337  95%    1.20K   1474       13     23584K ext4_inode_cache
 ...

What this is not showing, and it's really rather difficult to show, is
that it also causes a large amount of CPU usage on any file operations.
I'm not sure if it's simply because the table is enormous or if it's
because most of the qids v9fs gets to contend with are identical ones
from a whole host of synthetic file systems that it then has to iterate
over linearly.
The v9fs_inode_cache grows until it takes up all available RAM.

And snatching this one from your second mail:

> Which server are you testing against?  I'm wondering if the underlying problem
> might actually be i_nlink being maintained incorrectly by the server which would
> lead to inodes lingering since that is the primary way the generic_inode_drop
> differentiates.  It is possible that we could could add an v9fs_inode_always_drop
> in for legacy if the servers weren't reporting i_nlink a compatible fashion
> although that might result in never caching legacy 9p2000 (which is probably
> what most legacy folks want anyways).

I'm running against a regular old 9P2000 server that I wrote myself. No
extensions of any kind, so there are no links. I don't really have any
objection to the kind of qid.version contextual you implemented in 6.6
and would actually quite like to use it in the near future, but I
wouldn't be terribly sad if you removed it either.
