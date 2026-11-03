Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708069;
	b=RkX2W9AImci6RFyIJXHcZyxXBL8T6wPFUOHtTxnaM0b5n/l4kZK4OUYiJSzc8aCtnBRb
	 VU9ecLyLi1oFnqnp9ezg9D4gJpZamjIVdqoZC7bBBCvm03ng8imVGvrOlevQzk8H8+14r
	 2QSWKaULzZNnxUK0pOYv68xuZLpu0HXV9+KIjhUBvaKtZTstkjxcHB4cvAniVI79begwf
	 cFKTVDKDrB6ZZez/LavzaxenBwGTMVz+9TrdIIzFjuxS6wR+h4bzNQseNdBn54KhIQrT/
	 2o8ZO9eA20zK0T5A4eVa/J5B7U4oY6EWdAYLCZ+2IiVykAx4Wq5htUEnnjoTE68Jtew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708069;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 List-Id;
	bh=2VuRkx1ifV+1qy8E2tw7ebAsUaRcxKdh18yyLgfwynU=;
	b=iH+rFj2G6mYslNll3ze9v9onTtm7tW3t8WKlUeue7gNWeFA5VFuAx7MOG/Vq4WuM99p6
	 eRQCztpO4iqT6Lk0/rEfuk+dI0p+8vcJiUb+Lr0qZSTTC6Pdoev6xBm+wMobzegh8Rx4V
	 okNLUsQZA/7yFPfVCAqgo6Rqdv/9tW6TO2GT+vZ26oyJqFiKg5du2jdaYIFPAK9LsXNrT
	 3Ix5PVv+jVNlKIfmoD94oaQyoTIAEvcyZSXtPdIXs+teRPPNjHcMyl+Pktt63LIuSzU++
	 madHFAlDI6XHRuOhr/F1Dv5jCK2HFSeTWfmFID//K079jRLEUNqsS2zNuQTeWUEMPCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=kCUPi9ZX;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482C606A326
	for <v9fs@lists.linux.dev>; Tue,  3 Nov 2026 12:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8482C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=kCUPi9ZX
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CB2AB14C2D6;
	Tue,  3 Nov 2026 13:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793708050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 list-id; bh=2VuRkx1ifV+1qy8E2tw7ebAsUaRcxKdh18yyLgfwynU=;
	b=kCUPi9ZXiw4H+Y0/iTwMHLMHvkSKqnZK+dhM0GkxEOJM5Q2wxrXl8404938h+olRG8nz/1
	JLJ/ojeqWijKidbS1AunJAAyOkO+S6b7NGzNyLut5i4/js8SWtgXpqwJXuT9d5BWDDIWm7
	HZ2pd5rPbhJBRKtxGqZm69QQQuDnTP7/sObFlWssusp9VUKNtaxWfXrWH7OfOu4fC7mrOQ
	MYnGi7UyB727p7eHV1AvjX+1udF54jHEtpL1Q9kiNwsgTHq5uOXVgfTzzUWLIvmWgjnGkq
	F/7DQdTz7L295Bh2NxMlLaX+eE/q0bTGdux/RV2QIut/AlsRXJ7EBxPqmESxqQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id baf2ab49;
	Tue, 3 Nov 2026 12:14:07 +0000 (UTC)
Date: Tue, 3 Nov 2026 21:13:52 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 7.4-rc2
Message-ID: <aunQAEOa6mn2E5wm@codewreck.org>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Sorry for being late to the merge window, I still don't have much time
for this and the flu hit at a bad time.
At least the LLM fixes sort of slowed down recently? Or maybe it's just
the time of the cycle and/or I got used to it, time will tell...


The following changes since commit c60ae98c5aa64021751b38ab1313b19d620bf640:

  9p: Fix v9fs_issue_write() to update i_size and remote_i_size (2026-09-12 07:49:22 +0000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-7.4-rc2

for you to fetch changes up to 35ecd40c0d7e4f772d00dfec9f7077315ba5ca82:

  9p: optimize p9_fcall struct (2026-10-29 06:05:56 +0000)

----------------------------------------------------------------
This is mostly a huge wave of LLM-driven fixes

A few exceptions:
- a new vsock transport was added, since it's a variant of the existing
fd/tcp transport there is little harm in taking it in
- there's an incomplete fix for when file actual size doesn't match
the size attribute (e.g. exports of sysfs), the fix addresses when
st_size > actual size with cache=none but just about everything else
is still broken (st_size=0 with actual data regardless of cache, or
with data cache st_size > actual is still wrong and so are symlinks
with 0 size)... Maybe at some point I'll find time to understand how
netfs works and address these :|
- some fixes for the usbg transport by its author, thank you!

----------------------------------------------------------------
Ankit Thakur (4):
      9p: fix header guard comment in acl.h
      9p: fix typos and wrong parameter docs in vfs_inode.c
      9p: remove duplicated assignment in v9fs_fill_super()
      9p: fix typo in file header comments

Barret Rhoden (1):
      9p: treat read return values of 0 as EOF

Chengfeng Ye (1):
      net/9p/usbg: clear stale request context after abort

Deepanshu Kartikey (1):
      9p: don't WARN_ONCE on racy symlink fid lookup failure

Dmitry Antipov (1):
      9p: simplify v9fs_cache_session_get_cookie()

Dominique Martinet (1):
      9p: optimize p9_fcall struct

Haobin Wu (3):
      9p: skip intermediate directory entry name copy in p9dirent_read()
      9p: skip directory entries with names longer than NAME_MAX
      9p: skip over-long directory entry names for legacy 9p2000 too

Hemanth Selam (1):
      net/9p: fix typos in comments

Hui Peng (1):
      9p: reject RERROR/RLERROR with zero errcode

Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Kees Cook (1):
      9p: Add const and unsigned to wnames allocation type

Matus Skvarla (1):
      net/9p: add vsock transport

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Grzeschik (6):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()
      net/9p/usbg: fix out_req buffer leak in disable_usb9pfs
      net/9p/usbg: remove bogus context initialization in alloc_requests

Omokefe Emmanuel Onanaroghene (1):
      9p: fix kernel-doc warning for enum p9_session_flags

Rosen Penev (1):
      9p/xen: Use array for data rings

Stefano Garzarella (1):
      9p: fix privport option setting wrong RDMA field

Yehyeong Lee (1):
      9p/xen: validate the response size from the backend

Yifei Gao (1):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag

Yizhou Zhao (6):
      9p: use fc->net_ns for network namespace in RDMA and socket transports
      net/9p/usbg: fix descriptor cleanup use-after-free
      net/9p/usbg: fix prefix matching in device lookup
      net/9p/usbg: Fix use-after-free on usb9pfs_clear_tx
      9p/xen: drain response work after unbinding IRQ
      net/9p/usbg: Fix use-after-free in disable_usb9pfs()

Yuanfu Xie (3):
      9p: don't decrement a server-owned zero nlink
      9p: fall back to the normal open path for non-regular files
      9p: do not store the create fid on special files

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

 Documentation/filesystems/9p.rst |  12 ++++++++-
 fs/9p/acl.h                      |   2 +-
 fs/9p/cache.c                    |   7 ++----
 fs/9p/fid.c                      |   2 +-
 fs/9p/v9fs.c                     |  18 +++++--------
 fs/9p/v9fs.h                     |  26 +++++++++++++------
 fs/9p/vfs_addr.c                 |  10 ++++++--
 fs/9p/vfs_dentry.c               |   2 +-
 fs/9p/vfs_dir.c                  |  32 +++++++++++++++++------
 fs/9p/vfs_file.c                 |   2 +-
 fs/9p/vfs_inode.c                |  26 ++++++++++++++++---
 fs/9p/vfs_inode_dotl.c           |  36 ++++++++++++++++++++------
 fs/9p/vfs_super.c                |   2 +-
 include/net/9p/9p.h              |   4 +--
 include/net/9p/client.h          |  14 +++++++----
 net/9p/Kconfig                   |  10 ++++++++
 net/9p/client.c                  |   3 +++
 net/9p/protocol.c                |  12 ++-------
 net/9p/trans_fd.c                | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 net/9p/trans_rdma.c              |   2 +-
 net/9p/trans_usbg.c              | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 net/9p/trans_virtio.c            |   5 ++++
 net/9p/trans_xen.c               |  79 +++++++++++++++++++++++++++++----------------------------
 23 files changed, 372 insertions(+), 144 deletions(-)
-- 
Dominique Martinet | Asmadeus
