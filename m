Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A9136F
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVsXVT3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1F8C433CA;
	Sat,  6 Jan 2024 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507077;
	bh=pl4xa9j0jvzdsgU27tdeu2QMqyC853DqIweh9gwWM/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVsXVT3SWG01KLTBRzDCb8N7B0X1m+kTYVe63TCgtUdd0/amDf//EYA5v1rqAhWPK
	 3I4/N7tZsgoL8FZCVogwkCEA5dGnd3bh+UCDqShCjXhfvqSCII78Mxifj99V/DlJHj
	 SOI0twJbsmJb87ig3Q1zaCVDUor+UrwiiF142WhwD3AZLxA1zzBDCaLkCr9ifrqPuT
	 0dkLH0AJBIrI9FoBSDRbLDrDWKO9OqbtrcwZYY0Ywi6EE4umBvbBxCvTr+g7h/CHl8
	 p5JmIoO9fVpYrW1HTiDHy9Y9WcrNWDt93MGg5hu2PDTszO/376zWtTvYLk6CAvWpcA
	 aJa4ak1xkNubA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:13 +0000
Subject: [PATCH 6/9] fs/9p: Eliminate now unused v9fs_get_inode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-6-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=pl4xa9j0jvzdsgU27tdeu2QMqyC853DqIweh9gwWM/A=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+a/4Wfh9PfHfUMoBfeBHQp4c+UTjJldgFY
 jXrkmp6lE+JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mMETD/4hEmvfMxf2Qx1IaFnJWctFLlYRcZhT1lzeazVTlAPi6kjJz7xe+OUQ2xlVEn6KXb/f3wi
 TZs0neZ3X+B/kfljWmpKH500+lWoJH9SnNf09bbpLqCiPCeSeJ5E9I1CLU07NF0+H7fOYASWygU
 cUbEe7C0mb4sX4XYt5RbiKlm1CHUcuIDGjv0msgO7VlqQdohiTe0oSAPnicnVheyPevBJ9PQdvO
 raUnvQ6xun+zq3wQtSKGP0EUx+o8FVaeWmXv1k6N1DnLRc5jLJM2xZ+uZSFqKtENteVqciGJH/B
 3K8zW2tAQa5Pn+Vt7mQHG6tnQjFHGe+Z4RJlUnv/VW0gluFlwthLc54RHPebnLR53d5XLM1LL3i
 FqcrlNosHTURBJnEIIpglMsAQ1+U1cvYNb2YyUpgL/LJ14IJNYiQZv4xh1dlBpuhi49LK0UvjBg
 rUSvqgMxMxjbi/i6XKAqVxUnIrnhHKgb8gLBsJZq40mWrjPN42jOXoQsvw0MT+PCEwXDiiAXLuc
 KTq4d56dV+/EflPvPoGDi/IyAGAxD/IErWrzopbRPKUQPwWzWH0cxiO1R7+lYMIeqjn8x8QXP3x
 412r2GV+fnDOCC0Fu/jJOm52x9452ZFpWPdDEQFYpKazU+UYHysj0jnWhI1I9KwfuAY/m9EeP2u
 QJolgIK9W688JdQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Now with all inode allocation going through get_from_fid
functions we can remove v9fs_get_inode and reduce us down
to a single inode allocation path.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs_vfs.h  |  2 --
 fs/9p/vfs_inode.c | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 731e3d14b67d..ad0310deb6c8 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -40,8 +40,6 @@ extern struct kmem_cache *v9fs_inode_cache;
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
-struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode,
-			     dev_t rdev);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 6d149ba12bc0..02761009946b 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -333,35 +333,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 
 }
 
-/**
- * v9fs_get_inode - helper function to setup an inode
- * @sb: superblock
- * @mode: mode to setup inode with
- * @rdev: The device numbers to set
- */
-
-struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
-{
-	int err;
-	struct inode *inode;
-	struct v9fs_session_info *v9ses = sb->s_fs_info;
-
-	p9_debug(P9_DEBUG_VFS, "super block: %p mode: %ho\n", sb, mode);
-
-	inode = new_inode(sb);
-	if (!inode) {
-		pr_warn("%s (%d): Problem allocating inode\n",
-			__func__, task_pid_nr(current));
-		return ERR_PTR(-ENOMEM);
-	}
-	err = v9fs_init_inode(v9ses, inode, mode, rdev);
-	if (err) {
-		iput(inode);
-		return ERR_PTR(err);
-	}
-	return inode;
-}
-
 /**
  * v9fs_evict_inode - Remove an inode from the inode cache
  * @inode: inode to release

-- 
2.41.0

