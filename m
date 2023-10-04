Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1818E29
	for <v9fs@lists.linux.dev>; Wed,  4 Oct 2023 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax0NZpCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB14C433CA;
	Wed,  4 Oct 2023 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445643;
	bh=YXOAZwpmSmMbKCHyuLupLOi4EQCnsa9Gey6/PpLo2dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax0NZpCPmEOTSvooJuFbBm6D20fN0zJ158OnQZkprETjvEUl1Hw6+yjzvJT9e3RW8
	 U8Wg65vvaKaxCILA9fZr7kuXCoFu808QagaXkz7BuAHFmocY591c3YS7XOiJodSn0E
	 hzkfEqsy5rBdQHzfW0w9estzT0k9m5iRiS7tsdbILj0uW2lYJP9MHS8mZiEvVumpvG
	 1gsm0sOm143apja90GRCkN8vqjGpQjdL9F5az303UP81l1HOYKjxGoyzidL+1sq3Sd
	 HayDfuvWBNU6EDjt6DZZatnmdKsARPTHF1nH+Shcu7okfrx14htd6bt+qe2pEhSp+j
	 XeA0w8C+A9GXQ==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH v2 15/89] 9p: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:52:00 -0400
Message-ID: <20231004185347.80880-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_inode.c      |  6 +++---
 fs/9p/vfs_inode_dotl.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0d28ecf668d0..b845ee18a80b 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -260,7 +260,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
 	inode->i_rdev = rdev;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
 	inode->i_private = NULL;
 
@@ -1150,8 +1150,8 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 
 	set_nlink(inode, 1);
 
-	inode->i_atime.tv_sec = stat->atime;
-	inode->i_mtime.tv_sec = stat->mtime;
+	inode_set_atime(inode, stat->atime, 0);
+	inode_set_mtime(inode, stat->mtime, 0);
 	inode_set_ctime(inode, stat->mtime, 0);
 
 	inode->i_uid = v9ses->dfltuid;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 1312f68965ac..c7319af2f471 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -641,10 +641,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 
 	if ((stat->st_result_mask & P9_STATS_BASIC) == P9_STATS_BASIC) {
-		inode->i_atime.tv_sec = stat->st_atime_sec;
-		inode->i_atime.tv_nsec = stat->st_atime_nsec;
-		inode->i_mtime.tv_sec = stat->st_mtime_sec;
-		inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
+		inode_set_atime(inode, stat->st_atime_sec,
+				stat->st_atime_nsec);
+		inode_set_mtime(inode, stat->st_mtime_sec,
+				stat->st_mtime_nsec);
 		inode_set_ctime(inode, stat->st_ctime_sec,
 				stat->st_ctime_nsec);
 		inode->i_uid = stat->st_uid;
@@ -660,12 +660,12 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 		inode->i_blocks = stat->st_blocks;
 	} else {
 		if (stat->st_result_mask & P9_STATS_ATIME) {
-			inode->i_atime.tv_sec = stat->st_atime_sec;
-			inode->i_atime.tv_nsec = stat->st_atime_nsec;
+			inode_set_atime(inode, stat->st_atime_sec,
+					stat->st_atime_nsec);
 		}
 		if (stat->st_result_mask & P9_STATS_MTIME) {
-			inode->i_mtime.tv_sec = stat->st_mtime_sec;
-			inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
+			inode_set_mtime(inode, stat->st_mtime_sec,
+					stat->st_mtime_nsec);
 		}
 		if (stat->st_result_mask & P9_STATS_CTIME) {
 			inode_set_ctime(inode, stat->st_ctime_sec,
-- 
2.41.0

