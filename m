Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD41126C1E
	for <v9fs@lists.linux.dev>; Thu,  3 Apr 2025 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656421; cv=none; b=m5zTfkj4HdPF7jk86NxSZj9kf2p2E+rdPWAfbVAMsrVIRyI2o3EM/UlIN1+TmBAg094KQUzV84hJ2K/os2maIJ+wF0jTy8Caxr9QYbp69hP5Ly58yOiUZc+ja76wzMQHyhl1DTsPx7aQPx487GYvjhTQfalCT4WdNoOy0kAp5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656421; c=relaxed/simple;
	bh=9W9fICorWCVVP8Tt2aX6G1O4+4v+o1wA9LyrbmM+Pz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jHju5AEXWExNAKgg3l24F6CD8NySHxGg9XXFKFRLpF50Bg9VNQhDqRTN4umwAqcWFhwEq2x73+1oFCYRmqq6C6jNBtDf3jq2mnWMH5ZE2bMz66sR/LIgYy8+61GNXUdagE/iF+nGjnPDK46YZ+ovPPzrODa/c+fuiTvdW5BPVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Xoi2pgvQ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Xoi2pgvQ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3608E14C2DB;
	Thu,  3 Apr 2025 07:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1743656416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bz8pkuiCVevLhJcEPyvjJnCOcx3k3QvKU0VYjJOuDeY=;
	b=Xoi2pgvQlphtyCNpv9oKdEZPYPtT0GQup4TctzrCWcTPPOMZyJoCWn8sUhaioALofBnjMF
	AhvPzZwWkt7ffHXEA63P0q2aMu2dIsELdXr5UbrApPOs6wn4hAtNw6mdc9W2OD2j+1NKqE
	IHsAJqIpQLzpAnE1zkajNyzf9S/+HC8Kmi3Ie+xii0Tde4TclGE9wpYkzCmZDVN93poMqT
	pv2m3hpppkbKXdXmEuUgeGcIolpFshsYEmgDeuKsC2kKj6xmgTs5wKHy4QsLfclCnmRlCm
	7jjfg05bGdK8G0L72tsF02EdN+nEs/zYcm5ThsztMmnflkuKFmW0zRwnOQeO1w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f2b81bce;
	Thu, 3 Apr 2025 05:00:13 +0000 (UTC)
Date: Thu, 3 Apr 2025 13:59:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.15-rc1
Message-ID: <Z-4Vzhdi_3XZDFfV@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit ffd294d346d185b70e28b1a28abe367bbfe53c04:

  Linux 6.13 (2025-01-19 15:51:45 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.15-rc1

for you to fetch changes up to 4210030d8bc4834fcb774babc458d02a2432ee76:

  docs: fs/9p: Add missing "not" in cache documentation (2025-04-03 12:31:11 +0900)

(^ sorry for the recent date here, I just pulled the last documentation
fix and no code changed with that)

----------------------------------------------------------------
9p update for 6.15-rc1

- fix handling of bogus (negative/too long) replies
- fix crash on mkdir with ACLs
(... looks like nobody is using ACLs with semi-recent kernels...)
- ipv6 support for trans=tcp
- minor concurrency fix to make syzbot happy
- minor cleanup

----------------------------------------------------------------
Christian Schoenebeck (1):
      fs/9p: fix NULL pointer dereference on mkdir

Dominique Martinet (2):
      9p/net: fix improper handling of bogus negative read/write replies
      9p/net: return error on bogus (longer than requested) replies

Ignacio Encinas (1):
      9p/trans_fd: mark concurrent read and writes to p9_conn->err

Joshua Murphy (1):
      net/9p/fd: support ipv6 for trans=tcp

Sasha Levin (1):
      9p: Use hashtable.h for hash_errmap

Tingmao Wang (1):
      docs: fs/9p: Add missing "not" in cache documentation

Tuomas Ahola (1):
      Documentation/fs/9p: fix broken link

 Documentation/filesystems/9p.rst |  6 +++---
 fs/9p/vfs_inode_dotl.c           |  2 +-
 net/9p/client.c                  | 44 ++++++++++++++++++++++++++------------------
 net/9p/error.c                   | 21 +++++++++------------
 net/9p/trans_fd.c                | 73 ++++++++++++++++++++++++++++++++++---------------------------------------
 5 files changed, 73 insertions(+), 73 deletions(-)

-- 
Dominique Martinet | Asmadeus
