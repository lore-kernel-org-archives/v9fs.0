Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404F2EF642;
	Tue, 17 Jun 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170742; cv=none; b=FvvZ70QuoI/Q4ORM7JHAlp8hItbKOS8Hiuq3C8EHRD5zsELhS0fJA/QciFi5cb04xjWzVDGudeZMdooHE9bZeNkbOMguqTsD5JbBgrM0xARuP0Ljs5TPJ2TPyRPbs/syAGi6z4jhb/KHBtKtTJHZWNd1WiWWzTMRw7CkKrTuBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170742; c=relaxed/simple;
	bh=921+9ahDKxO8p5MXAFyH9tzmzeY6qrfUl6b8qL26Q48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nICzITGmgMFu7Yw5AbAF95HyMGPFuBW3FMhaP+0pNIvYLVQdDm06ixhNKkS77IZb9LXTaAdpkp49OYXzqEDiaLgOmnzHE7K4EfeYKsXsN8PtrStKUUAG5XvwiI1+mDgR9Tnh4i9IdB88e9fJV+8OsuuhqcEbb/KwtXeQB2vAfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jnIAnXyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jnIAnXyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F79C4CEE3;
	Tue, 17 Jun 2025 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170741;
	bh=921+9ahDKxO8p5MXAFyH9tzmzeY6qrfUl6b8qL26Q48=;
	h=Subject:To:Cc:From:Date:From;
	b=jnIAnXyTftKiTRQNh4S8SCmpEpBH2YGGzMKrF6dAgzc0rY/vLZRuRHVv2VMrrOJZn
	 2WsuNM88L+RUyynIXVYQyeDmakz+ARqMhVQHanNHmfqVWksGF5gnO9I4K2sf9Zjp/O
	 90CGSNfQRSLxlQfyenAh942zGLC7Z4rYmirbVb1g=
Subject: Patch "9p: Add a migrate_folio method" has been added to the 6.12-stable tree
To: asmadeus@codewreck.org,brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,v9fs@lists.linux.dev,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:31:52 +0200
Message-ID: <2025061752-epiphany-rotten-1cd1@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     9p-add-a-migrate_folio-method.patch
and it can be found in the queue-6.12 subdirectory.

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
@@ -160,4 +160,5 @@ const struct address_space_operations v9
 	.invalidate_folio	= netfs_invalidate_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
+	.migrate_folio		= filemap_migrate_folio,
 };


Patches currently in stable-queue which might be from willy@infradead.org are

queue-6.12/bio-fix-bio_first_folio-for-sparsemem-without-vmemma.patch
queue-6.12/block-fix-bvec_set_folio-for-very-large-folios.patch
queue-6.12/9p-add-a-migrate_folio-method.patch
