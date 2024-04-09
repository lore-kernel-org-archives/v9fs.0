Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24981591E9
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707105; cv=none; b=FkK7OhvNRHJ9uxLMNOiAgKXgxxNI8pRxgZehP2mDEU30i3bPJnD/MpZpLKOkqamm8O/5aHlorLyNvGW54I/VW2SuunNTbbAhBuPE0cZvCXjK0uyK1LiEsLb2WnPvMe5ksDV1xaROmmwp+pjdoT5nQ4YP2z+H8mlwDHW7KDlfB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707105; c=relaxed/simple;
	bh=pDKcHDWVg6SllAYmGIggd4oa6WPgPJopx5cEkUvT16g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z1nUD53IVgygepgEnqYX8XIWVkiWB8RTo3HXhjGZwpe6SFRK5NU1KQ6/8Pj9OEdAlGJMvBSXh2bnmsl96ur4kLeC0V+aKqYzDSlz7S+87PURKrjiIMA8JH7PKctZBnKbFY2BRXv2MxC/EvjgSCheSYp0Cj1rPFpQL89lKbXbr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7Nu0sgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7Nu0sgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7374C433C7
	for <v9fs@lists.linux.dev>; Tue,  9 Apr 2024 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712707105;
	bh=pDKcHDWVg6SllAYmGIggd4oa6WPgPJopx5cEkUvT16g=;
	h=Date:From:To:Subject:From;
	b=Y7Nu0sgSzQloghf22df2PBwf5tKHb/RMisnN+pr1JHASjfztqs0Eg0/kUfMB1g7qz
	 Y1hLLR7G4TIuRZyxffIezEETnxzDhnYavk9yXa/HK4wYdxuZr3FJ63ZFKoSt+8mKgE
	 KGJMN9WklTrsgxR08MKqgV2QjQeHdwZrPbWSNBI7WCEtzzvinCuM/ZAMcoXJVWmV+D
	 i9b2rgujSDVbpGWwVK2r3KO2ZDSxtLRvI86B3kZiVgUhXjEyVqt4ZRnrmjZqlftCE8
	 DufpZthB6DPwzEABV8a7mJWjzK9cYXAz60h7bjzdjes7FPPPe5sPMxiO1z2BcRqt/q
	 x4n+G3FgSxp2Q==
Date: Tue, 9 Apr 2024 23:58:22 +0000
From: Eric Van Hensbergen <ericvh@kernel.org>
To: v9fs@lists.linux.dev
Subject: [PATCH] fs/9p: remove erroneous nlink init from legacy stat2inode
Message-ID: <ZhXWHh0GR8U9qLv+@3f3e8491d9e9>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In 9p2000 legacy mode, stat2inode initializes nlink to 1,
which is redundant with what alloc_inode should have already set.
9p2000.u overrides this with extensions if present in the stat
structure, and 9p2000.L incorporates nlink into its stat structure.

At the very least this probably messes with directory nlink
accounting in legacy mode.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c5b4d3631c47e..47bd77199e20c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1064,8 +1064,6 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
        struct v9fs_session_info *v9ses = sb->s_fs_info;
        struct v9fs_inode *v9inode = V9FS_I(inode);
 
-       set_nlink(inode, 1);
-
        inode_set_atime(inode, stat->atime, 0);
        inode_set_mtime(inode, stat->mtime, 0);
        inode_set_ctime(inode, stat->mtime, 0);
-- 
2.41.0
