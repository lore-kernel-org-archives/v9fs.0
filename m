Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4B143C76
	for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315937; cv=none; b=r/E+mMXpMzv0CqPqdeq8Lk0Y4ZQdUTD0dGzaEzG/e0cpjYBaT3Fh0yM8eP689SQXrTBaFCm58MdH5ZdCJguglWzkuxvA0YDtRgMoZTLx9ilGiFci/zB8ljKR84hVcFltMjCWKIwuOqmn14q/UOq99ap0WhBuHLfFarkyikMH674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315937; c=relaxed/simple;
	bh=TfJwI1DxA0iQKpb1qdrSRO0yvas7Lmr0kvx/NkBIRtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4bJaeLwzsmN9rSfjlsgziIN0L4MVYSrGTkG2YKKCdZQPRw5F1WnCaE34xciPpIweLcoRgh1Mjvt5LL4z/W37HlGh8l5TuPrIFq9BPL/99EDmidaMR8alTsvTz3opeoyY6jKgrqk/qQIXt3isnFcqNCl2o/bVJoRK2T9WgvhU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO/qo60z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO/qo60z"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so790064a12.1
        for <v9fs@lists.linux.dev>; Thu, 18 Jul 2024 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721315934; x=1721920734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66tOt3U7e+mliJJ0zIhh+HtH8ytlVxjCTIQsAfp/IiY=;
        b=BO/qo60zSgdLBX+5FceNY6z1ehDCmR0bJbaak15tNOy9nco+S0TGglrv/UNUGTrzn4
         deOHL1hTDMYgg5uH2FrRbUcCEw6V8kOld/VLy5ps9TX0oTjlueP+5Wm9ypZRdTpf4pkk
         AD+EK56iZF87bPKBnbHGJ5MCVzFGHUpiPqz04HqdyPgZT+N8bMc7ZuQvxTG/TeQCmctE
         209evm+/cF0QhHLsglJYHoU4CLI6Zj7SsldKsPB470tRZGd3TtYDZ6Vks5hrF+WUULte
         cguLazneLgWdOmJrRiVDPDBSNGO1yaq+BCrAb3NpSLd+JOLMZhB6OytzO5JBfhJNqf7B
         oKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315934; x=1721920734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66tOt3U7e+mliJJ0zIhh+HtH8ytlVxjCTIQsAfp/IiY=;
        b=uNdcyMHSS2KoSX8gFyugxCIbFqvHVMBk/PsMmRDaBQzXehTp7td6K5k0QU6W2stRb2
         UfS9XoKipCePBi3oCbfnOzBwtB1xvNdnErTtkhK+VsB6VI90v0mLGomhVd38pjS/RhI2
         MJThrJcpLgksdSgbHoq6tQcdiZR3WteqVmFhtUcCdK02vuxRF477MzpFigbAqrKjqh49
         hwX34yQZLbvUXU5mkGUePWesPeJ0U+vgmWe720rm1jgJkroCiq/7NARHdPOEVlAACm9m
         DEn/1TKWMIVEmkiaYkmI5QI7yzHSnM7L+QPGv16YWgovH9jj3vyINbF102VMZUp2P80z
         mxyA==
X-Forwarded-Encrypted: i=1; AJvYcCW4zLZApQBJlBwPZ87Mtv6iAZR8k/YrybO6ogCc7l0BdvwgS+NHPW/LBigCwFYJRkz7Pf1WhcPrdzePKH41wN6VkmooJA==
X-Gm-Message-State: AOJu0Ywd9sd9Dr75qsZsdODf/mUthC93/Mw4Eig4ByWRW7Ol6Hx3o0kb
	X+W+qWazqzMu6cgSeVEsbyPG4hCQ6fFUeNG/aWzj9vMS77pLOxIv
X-Google-Smtp-Source: AGHT+IE5uwWjaNe+xWyJsYA3Q9W9tES3ir/K/R4AB7aMUxALfpcM+4hBfX86Yv6StyXC7bfdgiipqw==
X-Received: by 2002:a05:6402:2110:b0:57d:3e48:165d with SMTP id 4fb4d7f45d1cf-5a1557cd01fmr4004540a12.4.1721315933804;
        Thu, 18 Jul 2024 08:18:53 -0700 (PDT)
Received: from f.. (cst-prg-77-238.cust.vodafone.cz. [46.135.77.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm4218581a12.68.2024.07.18.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:18:53 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>,
	v9fs@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Date: Thu, 18 Jul 2024 17:18:37 +0200
Message-ID: <20240718151838.611807-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockless hash lookup can find and lock the inode after it gets the
I_FREEING flag set, at which point it blocks waiting for teardown in
evict() to finish.

However, the flag is still set even after evict() wakes up all waiters.

This results in a race where if the inode lock is taken late enough, it
can happen after both hash removal and wakeups, meaning there is nobody
to wake the racing thread up.

This worked prior to RCU-based lookup because the entire ordeal was
synchronized with the inode hash lock.

Since unhashing requires the inode lock, we can safely check whether it
happened after acquiring it.

Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Fixes: 7180f8d91fcb ("vfs: add rcu-based find_inode variants for iget ops")
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The 'fixes' tag is contingent on testing by someone else. :>

I have 0 experience with 9pfs and the docs failed me vs getting it
running on libvirt+qemu, so I gave up on trying to test it myself.

Dominique, you offered to narrow things down here, assuming the offer
stands I would appreciate if you got this sorted out :)

Even if the patch in the current form does not go in, it should be
sufficient to confirm the problem diagnosis is correct.

A debug printk can be added to validate the problematic condition was
encountered, for example:

> diff --git a/fs/inode.c b/fs/inode.c
> index 54e0be80be14..8f61fad0bc69 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2308,6 +2308,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
>         if (unlikely(inode_unhashed(inode))) {
>                 BUG_ON(locked);
>                 spin_unlock(&inode->i_lock);
> +               printk(KERN_EMERG "%s: got unhashed inode %p\n", __func__, inode);
>                 return;
>         }


 fs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..54e0be80be14 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,6 +676,16 @@ static void evict(struct inode *inode)
 
 	remove_inode_hash(inode);
 
+	/*
+	 * Wake up waiters in __wait_on_freeing_inode().
+	 *
+	 * Lockless hash lookup may end up finding the inode before we removed
+	 * it above, but only lock it *after* we are done with the wakeup below.
+	 * In this case the potential waiter cannot safely block.
+	 *
+	 * The inode being unhashed after the call to remove_inode_hash() is
+	 * used as an indicator whether blocking on it is safe.
+	 */
 	spin_lock(&inode->i_lock);
 	wake_up_bit(&inode->i_state, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
@@ -2291,6 +2301,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool locked)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
+
+	/*
+	 * Handle racing against evict(), see that routine for more details.
+	 */
+	if (unlikely(inode_unhashed(inode))) {
+		BUG_ON(locked);
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-- 
2.43.0

