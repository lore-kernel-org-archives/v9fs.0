Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08652459FE
	for <v9fs@lists.linux.dev>; Sun, 21 Jun 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782047950; cv=none; b=SFemz0nr72bAs3PnFg+ihGZmGiRJKvTEUqEmZ6eTzMfXhhkBd6jF9dYIEUzyWZohrvW01EH2mH7MepXLtAHOdOYjp6uACFPe/RpMtDXcI/MKNXe+/ZJ9ScnZ3BKmb8271dUyzZDOFE/9uPN1p80xuLE3Tol8y2uKU23Q+ufYRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782047950; c=relaxed/simple;
	bh=/Pm/iE/XsgTNm1IJVDaGCkCxIDlYq6Rws2aZLy8Q4fk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QH1zu68w9hns7lrrqqqke3nXwndB529GVD1mDNwSmvyeeRlfsNKE+oXOkvDHw5R9jpfm9Zx1tk+1WuHiuVWWQ7zXawnUdWQIbSuDUnfi8cmCDkcz3iEQH0KQH8Z2vQu2L+CgLuYz3psTAIP2nr05wK1bNxJN0X3hyNvNkk25XKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=x9UV+euZ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="x9UV+euZ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B1FAB14C2D6;
	Sun, 21 Jun 2026 15:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1782047947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=liQ5jB33jAAcOLk8emX5dp7cKV6efHPOI1wHywnlGRk=;
	b=x9UV+euZBYKdoGZDGUgUmcKipKVpUPsSh8n4iYDfokF3+OmW6vWmQXwbrUFUrSPB/Rdfr3
	wv7Rly7Vfpp/ywXZmBKtKSNuympSaoHelAOGJL4GfE5O0MytQhIHdRBUAtHe6oWWxw/pci
	JHJ1vy3JkIJ/eQH1C6runFgQf6BqgzN9n8/7K0vSuu+SNG/Ji5h4iTTs0B7EgzNTlg2ts4
	bMtoIt7eYA5J/vZ5TAa7ThKsmXLhYecQNnRueYarldaXeUvVE8clRREE8v2FatlLHoVydL
	yuIpdWgd85Dl2eAljuekjYypMokzxT3Nn2lxJ5O+pYPXI6vOOSiIw8A3II2csA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c62a2421;
	Sun, 21 Jun 2026 13:19:04 +0000 (UTC)
Date: Sun, 21 Jun 2026 22:18:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 7.2-rc1
Message-ID: <ajfkuS-kgmJXentl@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

same report as usual with barely keeping up: there's actually another
half a dozen of LLM patches I didn't pick up for this cycle and will try
to find time to review for next one, and I'm not as happy as I want to
be about how thoroughly I've checked the patches that did get in (please
let me know if you'd rather I drop the "fix infinite loop in
p9_client_rpc on fatal signal" patch I mentioned in the tag, I think
the patch should be ok, but I don't necessarily judge the risk the same
as you would)

The commit date being a bit earlier today was just me dropping a commit
I hadn't intended to send, nothing else was reworked recently.

-------
The following changes since commit 8fc518e489c1386fd0cf7f4256d055960ed6a2e4:

  9p/trans_xen: replace simple_strto* with kstrtouint (2026-04-16 02:57:01 +0000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-7.2-rc1

for you to fetch changes up to aa88278693cbfaf7a2acf961379973fbb63b165c:

  9p: Add missing read barrier in virtio zero-copy path (2026-06-21 05:22:57 +0000)

----------------------------------------------------------------
Asides of the avalanche of LLM-driven fixes, there are a couple of
big changes this cycle:

- negative dentry and symlink cache
- a way out of the unkillable "io_wait_event_killable" (because it
  looped around waiting for the request flush to come back from
  server; this has been bugging syzcaller folks since forever):
  I'm still not 100% sure about this patch, but I think it's as
  good as we'll ever get, and will keep testing a bit further in the
  coming weeks

The rest is more noisy than usual, but shouldn't cause any trouble.

----------------------------------------------------------------
Aayush Patil (1):
      docs/filesystems/9p: fix broken external links

Breno Leitao (1):
      9p: skip nlink update in cacheless mode to fix WARN_ON

Christophe JAILLET (1):
      net/9p/usbg: Constify struct configfs_item_operations

David Laight (1):
      net/9p: Replace strlen() strcpy() pair with strscpy()

Dominique Martinet (1):
      9p: v9fs_file_do_lock: replace WARN_ONCE with p9_debug

Gui-Dong Han (1):
      9p: Add missing read barrier in virtio zero-copy path

Hongling Zeng (1):
      9p: avoid returning ERR_PTR(0) from mkdir operations

Pierre Barre (2):
      9p: use kvzalloc for readdir buffer
      9p: invalidate readdir buffer on seek

Remi Pommarel (4):
      9p: Cache negative dentries for lookup performance
      9p: Add mount option for negative dentry cache retention
      9p: Set default negative dentry retention time for cache=loose
      9p: Enable symlink caching in page cache

Vasiliy Kovalev (1):
      net/9p: fix infinite loop in p9_client_rpc on fatal signal

Yizhou Zhao (2):
      9p: avoid putting oldfid in p9_client_walk() error path
      net/9p: fix race condition on rdma->state in trans_rdma.c

 Documentation/filesystems/9p.rst |  10 +++++---
 fs/9p/fid.c                      |  11 +++++----
 fs/9p/v9fs.c                     |  27 ++++++++++++++++++++-
 fs/9p/v9fs.h                     |  28 +++++++++++++--------
 fs/9p/v9fs_vfs.h                 |  15 ++++++++++++
 fs/9p/vfs_addr.c                 |  36 +++++++++++++++++++++++++--
 fs/9p/vfs_dentry.c               | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 fs/9p/vfs_dir.c                  |  14 ++++++++++-
 fs/9p/vfs_file.c                 |   2 +-
 fs/9p/vfs_inode.c                |  46 ++++++++++++++++++++---------------
 fs/9p/vfs_inode_dotl.c           |  58 ++++++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_super.c                |   1 +
 include/net/9p/client.h          |   2 ++
 net/9p/client.c                  |   7 ++++--
 net/9p/trans_fd.c                |   6 ++---
 net/9p/trans_rdma.c              |  19 +++++++++++++--
 net/9p/trans_usbg.c              |   2 +-
 net/9p/trans_virtio.c            |   5 ++++
 18 files changed, 320 insertions(+), 74 deletions(-)

-- 
Dominique Martinet | Asmadeus
