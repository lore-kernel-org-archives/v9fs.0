Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDC37144
	for <v9fs@lists.linux.dev>; Thu, 28 Sep 2023 11:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00001C433C8;
	Thu, 28 Sep 2023 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899069;
	bh=gMKvmRXp972OYt1KIoLm1NC/jDCunsGX2jl689W73G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFqCDKGarV5U3VWmY4tvVnReKQ3wRK5JN2JTbyffcy75PfIin864DidI3nngnDFmv
	 slLhZDQg1cP7vtJK8LnHhJuVDxFbqBY0jr2x/Xi1PFQon8Il4lYfgXFgd4cznXFjIM
	 Y4v8Z/XGuW7TOfyqDjF38FvFnV9RmnDbcYD2BwD8kq2oVKTMeIUuqsqHxJfZx0prex
	 FlH/ujcDZecDxg1MYOJkrtr5SjkWrhu1lNE7YZHlKH8xGOsMi/uXK71sMoElBPTN7y
	 7ZEDENfZ90v/Hvkv2x7qvVqiHTLET1G6QuxwVrL+RIiOAevVPjG0MWPFq63ldFiTQh
	 P/QwYx85OUEgQ==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH 15/87] fs/9p: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:02:24 -0400
Message-ID: <20230928110413.33032-14-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

