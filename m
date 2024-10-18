Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7F20E33E
	for <v9fs@lists.linux.dev>; Fri, 18 Oct 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295532; cv=none; b=KeHkZEvhyIo8yDBZWODMd2+P6/qKWPxCVRWLM0573sXFGxcv6KjtpZFWntEv+7wcY2XAXpJeofsfjQ/NsyoGVmXLH0cBhErgYHwsTw7XkMupL7sRrggQ6CzQ6GBn/Hv2kUsHNeY/kQB8xKe+gutCOR5S37V/KUbH2W7ZMqhy/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295532; c=relaxed/simple;
	bh=OxY9Q1tiKFv9F6E1b4/6a8e/ANMJ02eAI6eokcUakNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cg2v4IkYqYNekq+fBq38ClObQVl2UYz1XF6PzvGHaHh2KbluK9IgqiVeabDE3eM51qsfsofGZBNCrIhn/cAKKmm9Mc1UGPtxJ7yo5irofYVk95AO5yc/+igfBU+A1xUgsZttM5asQsf/OTRCLaxYyyr4TCUE/bd6t6+06qOD1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=s8lYF/8O; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="s8lYF/8O"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5396514C1E1;
	Sat, 19 Oct 2024 01:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729295523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YLWxW+rt13XcBnLClpIjcUjwEi7QRMT/CGkxYg0YTAE=;
	b=s8lYF/8OC5lZXqK4Tvf7eNmu76rO4oI9SEO5FT4EcsafQPkSZl7U5cCEG5zEqC0oZCmaw3
	biYs0EDEE9D3JhMNHsCR3/iwJ+Uoyi8SlFPRxxl7cLdXF5+19lzPk7uvBSlxKsbiFf34nQ
	C4RM7FnhQxKCTd78APZWxLYzX21JTYkOBK5P9d2x/i2dC9FoMJLTR/Skf16CivP598kytU
	xGPE3N3avdo7G0ImBMFli6pnehhTBGVlsghOcue2ffhmzNYF9ekL/dQIUBNhc0+RX530Z7
	4eBxl5FlT9JPlNmKylRqhCxUu04Ct1zIBp9pthdJ0YFdxkYbL1gXUFyJhss4dQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e8b7294a;
	Fri, 18 Oct 2024 23:51:59 +0000 (UTC)
Date: Sat, 19 Oct 2024 08:51:44 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] 9p fixes for 6.12-rc4
Message-ID: <ZxL0kMXLDng3Kw_V@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.12-rc4

for you to fetch changes up to 79efebae4afc2221fa814c3cae001bede66ab259:

  9p: Avoid creating multiple slab caches with the same name (2024-09-23 05:51:27 +0900)

----------------------------------------------------------------
Mashed-up update that I sat on too long:

- fix for multiple slabs created with the same name
- enable multipage folios
- theorical fix to also look for opened fids by inode if none
was found by dentry

----------------------------------------------------------------
David Howells (1):
      9p: Enable multipage folios

Dominique Martinet (1):
      9p: v9fs_fid_find: also lookup by inode if not found dentry

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

 fs/9p/fid.c       |  5 ++---
 fs/9p/vfs_inode.c |  1 +
 net/9p/client.c   | 10 +++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
Dominique Martinet | Asmadeus
