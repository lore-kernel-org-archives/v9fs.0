Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B71EF393;
	Tue, 17 Jun 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170805; cv=none; b=POq6Z/QTka+SRV06UiEJ81Nfc+z0CwOqM/hqUW3bKkj3ZKCBRos7eouX0TpbO6gcXRd42JhHfoGvR8GHMx5/TT5IgvRygo9iUbcremyNh/f3hXIPS9DSucNEzKyyunsIq5mv6whZlRJsmhgNYWR1PJbDCbJaKF9XP4mDY8hVApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170805; c=relaxed/simple;
	bh=gcu/3QI/ZmcHFZBzm/wNfp2iWXoCJscg0Eq6ubEbo8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o/Ie7dc5AdvAZoxOjyqAkDKJgkDx5HYuZ3Uz1I/p+0iqIFpFbVnQeZNn75oX6WAOLWK+09ixtqCVIhFqd+dM06VJL/33tZXkwYaiV/FMYsFZ1OJVMHoOPbTT/txZhvWmdb0O1f8MLfFU3W7IOzcqAnRtWlITkpz9QG9BYJ+YViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yw7t8IhX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yw7t8IhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ACCC4CEE3;
	Tue, 17 Jun 2025 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170804;
	bh=gcu/3QI/ZmcHFZBzm/wNfp2iWXoCJscg0Eq6ubEbo8A=;
	h=Subject:To:Cc:From:Date:From;
	b=yw7t8IhX4LmlgWGhtynjBRsWYrEpWf5+YnUXpoKGgceTkeFjpeUxCDsTv07o2UQyn
	 H1f2ZZ6xESthrGGZcA+b2iAqCmUSh03h9Z0Fsdp2JTlFrMW9+tJVtRDCoL+t2XV4gU
	 5XX9rgV71AlOjTRtZzqO5JC58QHJD4ASg+aeL6yU=
Subject: Patch "9p: Add a migrate_folio method" has been added to the 6.15-stable tree
To: asmadeus@codewreck.org,brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,v9fs@lists.linux.dev,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:32:17 +0200
Message-ID: <2025061716-gallantly-reborn-d229@gregkh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    9p: Add a migrate_folio method

to the 6.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     9p-add-a-migrate_folio-method.patch
and it can be found in the queue-6.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 03ddd7725ed1b39cf9251e1a420559f25dac49b3 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 2 Apr 2025 15:59:55 +0100
Subject: 9p: Add a migrate_folio method

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 03ddd7725ed1b39cf9251e1a420559f25dac49b3 upstream.

The migration code used to be able to migrate dirty 9p folios by writing
them back using writepage.  When the writepage method was removed,
we neglected to add a migrate_folio method, which means that dirty 9p
folios have been unmovable ever since.  This reduced our success at
defragmenting memory on machines which use 9p heavily.

Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250402150005.2309458-2-willy@infradead.org
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_addr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -165,4 +165,5 @@ const struct address_space_operations v9
 	.invalidate_folio	= netfs_invalidate_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
+	.migrate_folio		= filemap_migrate_folio,
 };


Patches currently in stable-queue which might be from willy@infradead.org are

queue-6.15/bio-fix-bio_first_folio-for-sparsemem-without-vmemma.patch
queue-6.15/fs-dax-fix-don-t-skip-locked-entries-when-scanning-e.patch
queue-6.15/block-fix-bvec_set_folio-for-very-large-folios.patch
queue-6.15/9p-add-a-migrate_folio-method.patch
