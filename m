Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582C21255A
	for <v9fs@lists.linux.dev>; Sun,  7 Dec 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111994; cv=none; b=NFwQLrJBDsODaeBhV0oHyPGeQE+TW1UcKrKshGzpiYcpwpR5kGIC35eISTi3F4RYc5VtAxG+nJhD226CGuaPeRwN6I6xwKvDcx+QyFAC0taIEvxnjA3omkfEM0yhh4G5sSlvB4Lc72jhadC6m8EaeB7820RSgGXmcElKs+h6ngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111994; c=relaxed/simple;
	bh=PVDeqqD6/E+WxT8GJ8ou+xRGOfSJIMEGtQn3CNaVC9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RS+rPcdMMDtbp0S3d+TLKV2pRm/CZJikplzND3ZMhwY9Lovphfsr2yw47xoGZpuEcY+d8yT6nOnI0prlVAbQtAt88ZOB2KH+JHi0iiabhvoQdiZmoyqCQ39pM7JX9zJuqcc3NI1qb8Lj5VdrvisDQ9Pi70h/afumXqKtElolILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=tGnaEFbr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="tGnaEFbr"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E196714C2D6;
	Sun,  7 Dec 2025 13:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765111982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=av0j+9gam9s2gUKnSXKp0I7nvwnA24IsOzVB8wO+XrE=;
	b=tGnaEFbrBTbJkmXQiN+gesQ5Fm/162XSGH7U73Xqye9WPiARXzKdZ1NeH3RFLE6ToqiLyj
	oZ5Qoxq/Ipp4nEtjXH1N+gS8LNCFKKlvy8lZx95rqgLlSxZwWApgyRhoqb+MD/S+rXWCp+
	vZ+p3fgejQNeiH7pfdzyybQEYTZ0fHbyIUig2ys92zcbzXQ/rh6SBhsCFpoIq1F/EWSd4g
	PTSZHKmfNqIL4fj2P7j+NrDPFoPi0ShbEVJ1UVKlibONhVrRA/vw62hlc3gyfFV72az91l
	4j7Z6/MJZOOYOX+03jNoD2aGqWzwuhgB4DqM1mv7Oiq8laqW7AXkKbOMgCtgEQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b1b3ef22;
	Sun, 7 Dec 2025 12:52:59 +0000 (UTC)
Date: Sun, 7 Dec 2025 21:52:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.19-rc1
Message-ID: <aTV4nH9k3WGz9P4Q@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

I probably sat too long on Tingmao's O_APPEND fix, but here's this merge
window's batch.
There's another bug open with loopback mount on virtio that probably
will have a fix soon so I'll likely send another PR with just that in
~1-2 weeks.

Thanks!

--------
The following changes since commit 43c36a56ccf6d9b07b4b3f4f614756e687dcdc01:

  Revert "fs/9p: Refresh metadata in d_revalidate for uncached mode too" (2025-10-22 14:25:27 +0900)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.19-rc1

for you to fetch changes up to 3e281113f871d7f9c69ca55a4d806a72180b7e8a:

  9p: fix new mount API cache option handling (2025-12-05 12:54:05 +0000)

----------------------------------------------------------------
- fix a bug with O_APPEND in cached mode causing data to be written multiple times on server
- use kvmalloc for trans_fd to avoid problems with large msize and fragmented memory
This should hopefully be used in more transports when time allows
- convert to new mount API
- minor cleanups

----------------------------------------------------------------
Dan Carpenter (1):
      fs/9p: delete unnnecessary condition

Dominique Martinet (1):
      net/9p: cleanup: change p9_trans_module->def to bool

Eric Sandeen (6):
      fs/fs_parse: add back fsparam_u32hex
      net/9p: move structures and macros to header files
      9p: create a v9fs_context structure to hold parsed options
      9p: convert to the new mount API
      9p: fix cache/debug options printing in v9fs_show_options
      9p: fix new mount API cache option handling

Pierre Barre (1):
      9p: Use kvmalloc for message buffers on supported transports

Tingmao Wang (1):
      fs/9p: Don't open remote file with APPEND mode when writeback cache is used

 fs/9p/v9fs.c               | 542 +++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 fs/9p/v9fs.h               |   7 +-
 fs/9p/vfs_dentry.c         |   1 -
 fs/9p/vfs_file.c           |  11 +-
 fs/9p/vfs_inode.c          |   3 +-
 fs/9p/vfs_inode_dotl.c     |   2 +-
 fs/9p/vfs_super.c          | 130 ++++++++++++++-------
 include/linux/fs_parser.h  |   2 +
 include/net/9p/client.h    |  98 +++++++++++++++-
 include/net/9p/transport.h |  15 ++-
 net/9p/client.c            | 165 ++++----------------------
 net/9p/mod.c               |   2 +-
 net/9p/trans_fd.c          | 136 +++-------------------
 net/9p/trans_rdma.c        | 134 ++-------------------
 net/9p/trans_usbg.c        |   5 +-
 net/9p/trans_virtio.c      |  11 +-
 net/9p/trans_xen.c         |   7 +-
 17 files changed, 573 insertions(+), 698 deletions(-)

-- 
Dominique Martinet | Asmadeus
