Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5D620
	for <v9fs@lists.linux.dev>; Wed,  5 Jul 2023 19:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3559FC433C8;
	Wed,  5 Jul 2023 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688583820;
	bh=1ESAF7Gh63wnUhvuz8PjyVJK4ESwbnRSUgq8ZwhC9qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMDbQQ5p4EHCOkOXtHInEdH7AcWARlUqG1pXKHuQF3mAzWDLAkO7F2B/jizDJ64+D
	 v9rtAWEz8M3o8oO1hoHzLkDJHhzCzhstVofAwyn1lAk9PMjnfp4wFcUlUdZRY4AWLG
	 kxPPGkKypVYeaxacOQHZU78hdkF3lIFQJH9pRtHsGK/Q7u31Vfi3b5M55AaqQ1QuUj
	 pxOEj9LIFl+VWpQlK4D0SUWXaR1Uvt04WxG3z1exDR2x8OsE1HhljKdMt292oi6ab9
	 GT1iV64cmjr2NLDpiAg+V+zLVgK9S5HFJjh2l6Zw7v6dNKi4pJB/Gu7FqupFwYa00u
	 UGO+n6nHB9Oew==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: [PATCH v2 21/92] 9p: convert to ctime accessor functions
Date: Wed,  5 Jul 2023 15:00:46 -0400
Message-ID: <20230705190309.579783-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_inode.c      | 4 ++--
 fs/9p/vfs_inode_dotl.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 36b466e35887..16d85e6033a3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -261,7 +261,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
 	inode->i_rdev = rdev;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
 	inode->i_private = NULL;
 
@@ -1158,7 +1158,7 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 
 	inode->i_atime.tv_sec = stat->atime;
 	inode->i_mtime.tv_sec = stat->mtime;
-	inode->i_ctime.tv_sec = stat->mtime;
+	inode_set_ctime(inode, stat->mtime, 0);
 
 	inode->i_uid = v9ses->dfltuid;
 	inode->i_gid = v9ses->dfltgid;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5361cd2d7996..464ea73d1bf8 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -646,8 +646,8 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 		inode->i_atime.tv_nsec = stat->st_atime_nsec;
 		inode->i_mtime.tv_sec = stat->st_mtime_sec;
 		inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
-		inode->i_ctime.tv_sec = stat->st_ctime_sec;
-		inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
+		inode_set_ctime(inode, stat->st_ctime_sec,
+				stat->st_ctime_nsec);
 		inode->i_uid = stat->st_uid;
 		inode->i_gid = stat->st_gid;
 		set_nlink(inode, stat->st_nlink);
@@ -669,8 +669,8 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 			inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
 		}
 		if (stat->st_result_mask & P9_STATS_CTIME) {
-			inode->i_ctime.tv_sec = stat->st_ctime_sec;
-			inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
+			inode_set_ctime(inode, stat->st_ctime_sec,
+					stat->st_ctime_nsec);
 		}
 		if (stat->st_result_mask & P9_STATS_UID)
 			inode->i_uid = stat->st_uid;
-- 
2.41.0

