Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297715AD86
	for <v9fs@lists.linux.dev>; Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945652; cv=none; b=XCaPBq8ROlxQreiBfWXpWSGqSwUQ/Q8cWXvGNI039cAURkd4l+hFCRpx01sttyJziroBE95/4CF4dqwGyxqh+bo9vU23gNxH8f6Bo+QEpMbc1QpVpexLO177sQf0+05Nw4oDFH+0fpDFEzGHgzWm0cQwkrA+p4Lb1SFPkHvhZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945652; c=relaxed/simple;
	bh=0IpIY6svVVqs936/3Ecv6ppMPPOb1PbWw/SJkBQdBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E9pyIMBrYuXcNW21Tzwmt3wnqkMYU5+o5cre+KyfrOvT/xAiP4n/cit+3R3YHg7/ZJmT/BKMSU+cODZKzuvW4uR5P/0arA0G/uf7rNQ+IYAqBjS0ZMmUxEZpnb7jtQfQ+nLH8YvkZHHM8mohDAOxafAMK00CHUfKZ0WGk8aL7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=F9DCJFET; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="F9DCJFET"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D6A3114C1E1;
	Wed, 29 May 2024 03:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716945642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Q10rdA6tlxh/SUGCLGRTZhLPngV4CNCKcsEszGpgXGk=;
	b=F9DCJFETCjLYVNh+zE23ywNLvZHlKJrkgdfW89ezkztqGi/mJ5yVBlcggbgX3859SHDlIh
	lWMMUSaOHQJZp+xASCg+bbF98I5MA77lnb7lueOV6Owxw44kBtycO/Ofz695iFX/piBV0C
	VJO8tEVIl5fnJKt7gZTaAtELvVT6miupHE2i2FN5XvTrz2u0670mgD2foUNWgjaXg/fyTe
	Cv7J6+LYIv/iBMA3WINZmCh8mfl8VWHlFXKnXP2nnqrZWFLDcmAOSPuehtvgzP4DQxfqMU
	8nqoYV96NDwd7EF7FpSHx2VkO/aCBmPsDSV72Qsh9dxDTUN8BRP5fqOsIZ/rXA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id dfdcbf57;
	Wed, 29 May 2024 01:20:36 +0000 (UTC)
Date: Wed, 29 May 2024 10:20:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.10-rc2
Message-ID: <ZlaC1Sn6WZtEGsbK@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.10-rc2

for you to fetch changes up to c898afdc15645efb555acb6d85b484eb40a45409:

  9p: add missing locking around taking dentry fid list (2024-05-23 20:29:09 +0900)

----------------------------------------------------------------
Two fixes headed to stable trees:

- some trace event was dumping uninitialized values
- a missing lock somewhere that was thought to have exclusive access,
and it turned out not to

----------------------------------------------------------------
Dominique Martinet (1):
      9p: add missing locking around taking dentry fid list

Nikita Zhandarovich (1):
      net/9p: fix uninit-value in p9_client_rpc()

 fs/9p/vfs_dentry.c | 9 +++++++--
 net/9p/client.c    | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
Dominique Martinet | Asmadeus
