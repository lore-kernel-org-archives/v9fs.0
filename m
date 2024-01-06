Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71515AB
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/N6gf3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C52CC433C9;
	Sat,  6 Jan 2024 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507078;
	bh=2ilIaYqvoK/mkCBgHWHH98EX4M0yVCJ+u5eYGKqTQl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V/N6gf3AGxRPO1WlDUF4zrPkV1GVqwq5+m0P0wnfK9UB9vWtjFDSubsIPtxRlBApZ
	 9+YG0ggEXxhw5QNWnh7HUXHgLIp9tvtZggpykYyJr3s/Jbx23XBiaPzHpRzSRXXYIP
	 j0mQpENLNGgQRCTUv2zDl3qclccuJ7+EO1RMjOMNvT7rOC8BK1Mf6TD8gfqJPPVEOk
	 n+e7lq+ckDstVLriqhG8sdMfEhsAMUsLXGYeHP4h0eIl9/04ej4QuDFWo+hnF7Czh7
	 K3ZeqxMN4kseJP0dVKY7TpWAl3ID69TpXr2cYYBnds8hNxbKovWbyrZ0KOZP5Uoptt
	 U/jGjholnVcVQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:15 +0000
Subject: [PATCH 8/9] fs/9p: simplify iget path to remove unnecessary paths
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-8-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7048; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=2ilIaYqvoK/mkCBgHWHH98EX4M0yVCJ+u5eYGKqTQl0=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+SX8BZNa7ItTLF9b/EwzrhZnPQI+4Tg/J/
 h1Ve05H6ROJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mPEaD/9G4EKChdSUz+kcorjbYR4+taa3UWXSWpeud6RAu/dWIoyI7i4MH0A8fnmIsxhdVhrIf69
 wB4Fb4ZzUE98UKe1lVGee0W4bE8DMzVK1bb6C1EYzRLEm4X5gzR9XPZPp6NwyNv5ZY9jbMfBXsi
 /MNun++2WDqfB/r6Y9fPg5LE13EZf8cGkZnSo3ck7XClY144S9p4nwa4O41QOceBezO6KEhQSTN
 bLMyLyUpdNix6hg2xbjg4ftuQAhiQ3blm/fjGFCSHRWIkPAZQKfp4eSpfOoRhzUx90NPXvkE4zG
 uilalsu1APGEuhcDZr01qPiJzxh7VTpHOzw0ErQoR6wK24atnN7UeHj9193IXv9mdEfjOoMzScs
 yMHorlmy5kjByRtiE35sCOnpaddJMEZQtLY9SUfygAvagEKbJXdcokZWT+KVlIl2QVcVdVjkYpA
 5p2Wtrg6vN/x6i50FIkPD/fHSG4Q2eAORjw4hLw4tdFEF5eU37KkaWlrSGrA9pyEloeVlvJVt/S
 n0qhBz/I/ANF0ZeOtX7v4WUrW3MUVCQLdiv65hz4GDenmxvD6N9RNd2FnKVjLZhg6eJH2cO6FPU
 Jawo5I02zFMzpZrudx8aUxlDDc7jzjFWkjNgEW5WVcJMjPOdRXP5BWkyTakZ0TvaALddxXL28zA
 cFDypYPuP5Kx/Jw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Remove the additional comparison operators and switch to
simply lookup by inode number (aka qid.path).

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs_vfs.h       |  2 +-
 fs/9p/vfs_inode.c      | 67 +++++++++++---------------------------------------
 fs/9p/vfs_inode_dotl.c | 67 +++++++++-----------------------------------------
 3 files changed, 27 insertions(+), 109 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 789e1188d5dc..791231b31b95 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -41,7 +41,7 @@ extern struct kmem_cache *v9fs_inode_cache;
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, umode_t mode, dev_t rdev);
+		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
 #if (ULONG_MAX == 0xffffffffUL)
 #define QID2INO(q) (ino_t) (((q)->path+2) ^ (((q)->path) >> 32))
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index fe8cbcdf4b5f..766496579b28 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -253,9 +253,12 @@ static void v9fs_set_netfs_context(struct inode *inode)
 }
 
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, umode_t mode, dev_t rdev)
+		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev)
 {
 	int err = 0;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+
+	memcpy(&v9inode->qid, qid, sizeof(struct p9_qid));
 
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
@@ -359,75 +362,33 @@ void v9fs_evict_inode(struct inode *inode)
 #endif
 }
 
-static int v9fs_test_inode(struct inode *inode, void *data)
-{
-	int umode;
-	dev_t rdev;
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
-
-	umode = p9mode2unixmode(v9ses, st, &rdev);
-	/* don't match inode of different type */
-	if (inode_wrong_type(inode, umode))
-		return 0;
-
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
-	if (v9inode->qid.type != st->qid.type)
-		return 0;
-
-	if (v9inode->qid.path != st->qid.path)
-		return 0;
-	return 1;
-}
-
-static int v9fs_test_new_inode(struct inode *inode, void *data)
-{
-	return 0;
-}
-
-static int v9fs_set_inode(struct inode *inode,  void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
-
-	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
-	return 0;
-}
-
 static struct inode *v9fs_qid_iget(struct super_block *sb,
 				   struct p9_qid *qid,
-				   struct p9_wstat *st,
-				   int new)
+				   struct p9_wstat *st)
 {
 	dev_t rdev;
 	int retval;
 	umode_t umode;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
-	int (*test)(struct inode *inode, void *data);
 
-	if (new)
-		test = v9fs_test_new_inode;
-	else
-		test = v9fs_test_inode;
-
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
-	if (!inode)
+	inode = iget_locked(sb, QID2INO(qid));
+	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
+	if (unlikely(st == NULL)) {
+		retval = -EINVAL;
+		goto error;
+	}
+		
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
+	retval = v9fs_init_inode(v9ses, inode, qid, umode, rdev);
 	if (retval)
 		goto error;
 
@@ -452,7 +413,7 @@ v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget(sb, &st->qid, st, new);
+	inode = v9fs_qid_iget(sb, &st->qid, st);
 	p9stat_free(st);
 	kfree(st);
 	return inode;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 2699d7b3b8e8..2200c5f77d58 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,75 +52,31 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
-static int v9fs_test_inode_dotl(struct inode *inode, void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
-
-	/* don't match inode of different type */
-	if (inode_wrong_type(inode, st->st_mode))
-		return 0;
-
-	if (inode->i_generation != st->st_gen)
-		return 0;
-
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
-	if (v9inode->qid.type != st->qid.type)
-		return 0;
-
-	if (v9inode->qid.path != st->qid.path)
-		return 0;
-	return 1;
-}
-
-/* Always get a new inode */
-static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
-{
-	return 0;
-}
-
-static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
-
-	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
-	inode->i_generation = st->st_gen;
-	return 0;
-}
-
 static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					struct p9_qid *qid,
 					struct p9_fid *fid,
-					struct p9_stat_dotl *st,
-					int new)
+					struct p9_stat_dotl *st)
 {
 	int retval;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
-	int (*test)(struct inode *inode, void *data);
-
-	if (new)
-		test = v9fs_test_new_inode_dotl;
-	else
-		test = v9fs_test_inode_dotl;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
-	if (!inode)
+	inode = iget_locked(sb, QID2INO(qid));
+	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
+	if (unlikely(st == NULL)) {
+		retval = -EINVAL;
+		goto error;
+	}
+
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = QID2INO(qid);
-	retval = v9fs_init_inode(v9ses, inode,
+	retval = v9fs_init_inode(v9ses, inode, qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
 	if (retval)
 		goto error;
@@ -143,14 +99,15 @@ struct inode *
 v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 			 struct super_block *sb, int new)
 {
-	struct p9_stat_dotl *st;
+	struct p9_stat_dotl *st = NULL;
 	struct inode *inode = NULL;
 
 	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, new);
+	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st);
+
 	kfree(st);
 	return inode;
 }

-- 
2.41.0

