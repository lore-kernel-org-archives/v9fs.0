Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC675808
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338975; cv=none; b=kcGvkbUvjovh9mZUrEfOxg7ZGbA4JqJjwAVoEINMB/ibuT6ta2PUqi7NOXSh3LdlBhIe7GKK/5mozvdR74MwZ/CPTiUXD8Z6P8jW/5WW+pSmNDPnfyRBvWeEBr0s/Tm9/U+ZcfbQcIAaeBXX3x46JIDgKAwZgC/+gZWv+Vn+63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338975; c=relaxed/simple;
	bh=rwBrBSOWEvecCpPOsN8DxHsjyJveE8a6kM3AAAAnytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1/Am/pkTaqJE+uNrGTF8c1doiVaQiEZ58RDbPMQ9Le5gYc97VbP5hcjxPw7YODuSDcHFWL8QILQa8/3GlzFTAyX8eg3OX0pjeXIZZfcg5CFJGPyJxn2+Dybdtgmjq016wHEXQV3FYcTYKAGQz6Ti5xFcIssvqojIPNDVYNEcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=U8DYPjfB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="U8DYPjfB"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AACCE14C2DD;
	Thu, 18 Jul 2024 23:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721338971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/bUkXzKitNH6YGqYdzXljxkIPFqMZav005MXLILfYg=;
	b=U8DYPjfBivQPvUxmsnle9Iu4s6VEg3rqZbt8V2nYogOSm1ufX5X9yfzr6U2s8pH2jHsodQ
	cCeRoMdTz4DO58ZIv4qrSIBWULt0kVJ1d+QyNIXOFKARamBVEWVW1Rz4CEXxogu7JU+dPY
	qDapbQGi7omx4MLeM09z/oEoo/u3vPVc220ZzM3L+/G994eBmoz5Tb3T92WACbd5QZjWf4
	0wcYaPgjHyqZb4msgY4R1K3GD7h7n0BeslfPIbJui3C8i7GKwxMLM+PxTqk9S1XjWxKdps
	AltuOXRY3jPIdytIbx+Du9Roca8i0zDsVuRyNg5MfStRU575pQIgdmpoATy3+w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3e6bcb59;
	Thu, 18 Jul 2024 21:42:46 +0000 (UTC)
Date: Fri, 19 Jul 2024 06:42:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, v9fs@lists.linux.dev
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Message-ID: <ZpmMRzyE-mVrK74M@codewreck.org>
References: <20240718151838.611807-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240718151838.611807-1-mjguzik@gmail.com>

Mateusz Guzik wrote on Thu, Jul 18, 2024 at 05:18:37PM +0200:
> Lockless hash lookup can find and lock the inode after it gets the
> I_FREEING flag set, at which point it blocks waiting for teardown in
> evict() to finish.
> 
> However, the flag is still set even after evict() wakes up all waiters.
> 
> This results in a race where if the inode lock is taken late enough, it
> can happen after both hash removal and wakeups, meaning there is nobody
> to wake the racing thread up.
> 
> This worked prior to RCU-based lookup because the entire ordeal was
> synchronized with the inode hash lock.
> 
> Since unhashing requires the inode lock, we can safely check whether it
> happened after acquiring it.
> 
> Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Fixes: 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> The 'fixes' tag is contingent on testing by someone else. :>

Thanks for the quick fix!

> I have 0 experience with 9pfs and the docs failed me vs getting it
> running on libvirt+qemu, so I gave up on trying to test it myself.

I hadn't used it until yesterday either, but virtme-ng[1] should be easy
enough to get running without much effort: just cloning this and running
/path/to/virtme-ng/vng from a built linux tree will start a vm with /
mounted as 9p read-only (--rwdir /foo for writing)
[1] https://github.com/arighi/virtme-ng 

> Dominique, you offered to narrow things down here, assuming the offer
> stands I would appreciate if you got this sorted out :)

Unfortunately I haven't been able to reproduce this :/
I'm not running the exact same workload but 9p should be instanciating
inodes from just a find in a large tree; I tried running finds in
parallel etc to no avail.

You mentioned adding some sleep to make this easier to hit, should
something like this help or did I get this wrong?
----
diff --git a/fs/inode.c b/fs/inode.c
index 54e0be80be14..c2991142a462 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
+#include <linux/delay.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -962,6 +963,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
                        continue;
                if (inode->i_sb != sb)
                        continue;
+               usleep_range(10,100);
                spin_lock(&inode->i_lock);
                if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
                        __wait_on_freeing_inode(inode, locked);
----
unfortunately I've checked with a printk there too and I never get there
in the first place, so it probably needs to hit another race first where
we're getting an inode that's about or has just been dropped or
something, but none of my "9p stress" workloads seem to be hitting it
either...
Could be some scheduling difference or just that my workloads aren't
appropriate; I need to try running networking tests but ran out of time
for today.

> Even if the patch in the current form does not go in, it should be
> sufficient to confirm the problem diagnosis is correct.
> 
> A debug printk can be added to validate the problematic condition was
> encountered, for example:

That was helpful, thanks.

> > diff --git a/fs/inode.c b/fs/inode.c
> > index 54e0be80be14..8f61fad0bc69 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2308,6 +2308,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
> >         if (unlikely(inode_unhashed(inode))) {
> >                 BUG_ON(locked);
> >                 spin_unlock(&inode->i_lock);
> > +               printk(KERN_EMERG "%s: got unhashed inode %p\n", __func__, inode);
> >                 return;
> >         }

-- 
Dominique Martinet | Asmadeus
