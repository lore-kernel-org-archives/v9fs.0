Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FE1D14FA
	for <v9fs@lists.linux.dev>; Fri, 25 Oct 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892191; cv=none; b=df7l4MLpOLt4j9klcp/iffamJYVbEY2UymB4+Y9IQ0vteSb7GChPA1rfQW7PKWFCKERsoZwK+K/VbfaNmF92aBtqzm6rAnYO/aLNub0wpE+osJcsbbdxwTDV6NSGT9xycUpG+eWpHNZrithpyP4a8LIG2HeSfceymWfMQjHAjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892191; c=relaxed/simple;
	bh=3+KFcHbQIWjyeAheH/KxRYzNPHaMjPzLwH/4JdM3JuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iPCu21N2IDesGSJZWo9LBNaAGMpvC0L91Hu/yzCoxR8fl3TC6+rHWesDROEeF8hCrw2pUVTFsFQ4cuos605DHXfFslkFdOvfzGJ1yCvmnX0opDPPESjDcsOZkmnv455N5ve71rOaPGkDfWnZzPOmVa40h05ZndTzaEY9/S4INTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=D6PWwpMd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D6PWwpMd"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7BB8614C1E1;
	Fri, 25 Oct 2024 23:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729892180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=msbetZUBXaor1UFV07AVhHFCrgXr3mbw/IjluhVXHM4=;
	b=D6PWwpMdLY9aY8+NBHz88UfHB9v/5gbTZODCv5WB5kCgPBrqKxROqb1TIn1y4ZnIETEzz3
	HJYic+0mrXHc8otqob6EONxI+PFNOEff5v6QYskoCEBRTYekQDePo6QSIQDmSWshddyt/B
	4E3Dp9jP6U8gv5icTcGuen6HMUi2Vt1NgEs5rg4gX+CkMIalAd8mfbKKvMO3Pj3/v+GOhb
	S9oczEeLcaEf2V46lxLNmeOFunRXneWCbNgGMoqqgNxzX1Qn3tQjk62mV1KGFK78lQdBE0
	IzU/4t+Qe3IUk+12Jy9XhD1iRe3bBvrxfIUu4eP9IliIvuRmKOCnHoGj25jqUg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1d34c561;
	Fri, 25 Oct 2024 21:36:16 +0000 (UTC)
Date: Sat, 26 Oct 2024 06:36:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] more 9p reverts for 6.12-rc5
Message-ID: <ZxwPQTUCnbGEt1KQ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

- see tip commit (simplify iget revert) for full explanation.
This problem had been ignored for too long and the reverts will also
head to stable (6.9+)
- rebased yesterday to remove the use-folio revert that was applied
directly, but patches are fairly new anyway. I'm confident this set of
patches gets us back to previous behaviour (another related patch had
already been reverted back in April and we're almost back to square 1,
and the rest didn't touch inode lifecycle)

Thanks!


The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.12-rc5

for you to fetch changes up to be2ca3825372085d669d322dccd0542a90e5b434:

  Revert "fs/9p: simplify iget to remove unnecessary paths" (2024-10-25 06:26:09 +0900)

----------------------------------------------------------------
Revert patches causing inode collision problems

----------------------------------------------------------------
Dominique Martinet (4):
      Revert " fs/9p: mitigate inode collisions"
      Revert "fs/9p: remove redundant pointer v9ses"
      Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
      Revert "fs/9p: simplify iget to remove unnecessary paths"

 fs/9p/v9fs.h           |  34 +++++++++++++++----
 fs/9p/v9fs_vfs.h       |   2 +-
 fs/9p/vfs_inode.c      | 129 ++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 fs/9p/vfs_inode_dotl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++------------------
 fs/9p/vfs_super.c      |   2 +-
 5 files changed, 192 insertions(+), 87 deletions(-)

--
Dominique Martinet | Asmadeus
