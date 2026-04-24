Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03D364E9C
	for <v9fs@lists.linux.dev>; Fri, 24 Apr 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026558; cv=none; b=snLm/gkQJtLp3Mb2+lGVrhykTFSiBb/cnANJBNUDGgvjFb5NbPZ/pfo3YUG8m8N1CUNb/ovIcXxiILAyoCwJZ90yLYupvIUG5bhGmb2Ar85L4WyeZ0tJY/1aB9Jl2qHWmhdJPzxHXIxkUYvFGAC8MCvmdC048X7VCV8eWchohfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026558; c=relaxed/simple;
	bh=A0ff2V0e2rZM+/AJtNjrZnQFGA9orO7/CNZshk9QPVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cb6nC3vXNqKg+5cd9yyr6qtc2GYEv2J6rEFNwKiIRNU9lNvPq9/BxSuGx4FDoJGdCLU8sppKz5cyUv+oXGYPNiTIuEqY0JdTyIc+lkUDpOVRzXZF+4CAsH30mbHCGstS8MgX2SuwFuJFDdZBjJjBtOiuBvZf+Qgk4g2dw/zLP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=v5Y8DmI+; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="v5Y8DmI+"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 21DCB14C2D6;
	Fri, 24 Apr 2026 12:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1777026546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+ZA99h9LEloqnPmBx1Vr12IH6WgsqSRSL4oP/JQVP1E=;
	b=v5Y8DmI+k3zfu/GleIHOA4OsHStY87Vi4LqAHOBn9lIzp2/eG3zchmCPwslDGu4dL+CElq
	QuVq5y1WcwqM0rQ+LYlIzIjCvukjzX+roll8liF4q+bRWygTfd4ue6CTa1rmYCKv9VrT1K
	n33UpiRayms+mONuyO0HxFl0Fu7QA+NhM8JF65kFkkZOmAcI4QAhR74J9eNpRkMT9X0bwI
	6aeul1jSXjJ24AqR4Rl/KrhulD1h4qXXtjo8PHgHK+gZsw3AuxO2/d37/+TAwNePCoVqNj
	uPA6LVQ5nJh1C1gN/CCYaDMX+4paysrAopHGjfBJuDcb2gZhVI31aSzOpIXKmA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 354b8ae8;
	Fri, 24 Apr 2026 10:29:03 +0000 (UTC)
Date: Fri, 24 Apr 2026 19:28:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 7.1-rc1
Message-ID: <aetF4EENt3meh6lt@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


Hi Linus,

I'm a bit swamped with real life priorities; there are a couple of other
known 9p bugs that I'd have liked to see fixed for 7.1 but fixes aren't
obvious and there's doesn't seem to be any consensus so here's what's
safe to take for now.

Thanks,

--------
The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-7.1-rc1

for you to fetch changes up to 8fc518e489c1386fd0cf7f4256d055960ed6a2e4:

  9p/trans_xen: replace simple_strto* with kstrtouint (2026-04-16 02:57:01 +0000)

----------------------------------------------------------------
- 9p access flag fix (cannot change access flag since new mount API implem)
- some minor cleanup

----------------------------------------------------------------
Kit Dallege (1):
      9p: document missing enum values in kernel-doc comments

Pierre Barre (1):
      9p: fix access mode flags being ORed instead of replaced

Sasha Levin (1):
      9p: fix memory leak in v9fs_init_fs_context error path

Yufan Chen (2):
      9p/trans_xen: make cleanup idempotent after dataring alloc errors
      9p/trans_xen: replace simple_strto* with kstrtouint

 fs/9p/v9fs.c        |  4 ++++
 fs/9p/vfs_super.c   |  6 +++---
 include/net/9p/9p.h | 38 +++++++++++++++++++++++++++++++++++---
 net/9p/trans_xen.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 4 files changed, 95 insertions(+), 30 deletions(-)

-- 
Dominique Martinet | Asmadeus

