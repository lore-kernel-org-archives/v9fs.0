Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035631381
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYw8Z4v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA21C433C8;
	Sat,  6 Jan 2024 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507079;
	bh=QmhmTJ9+CP7sGiwWpHsE25lzjIh2Wbnu23GArt9Mmgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CYw8Z4v8sACHE7SUMAmKv+Ir1M6R19wpwB2vTaGrvAb6w1taUviooRBgpx/XdpVig
	 f0rVyKYjdKbIHnWlqXg9Vsvdag+Z5LuxwFwyVzNqwd8rEun7yuidIt9mXb6YRmRpeT
	 HNJoZJMEIaCCGf1pXd8LM3fXpWxXra25fewctah/Uj8WgSwr8Y9vbCWxEzyid4g/4s
	 5PFUP8s/dFE16CmBZjRpLGmodLaq9BDANaqVi95jKMKjtqOVfLRPjt+qFXikbdbzV4
	 lObNNLYWSaHnRCrLeH7xm+Al7pVlHg6Ya7wKOZ7rGuhdm1szuFGqUbb9Hg99+DvERy
	 4EAydE17zdr5A==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:16 +0000
Subject: [PATCH 9/9] fs/9p: Further simplify inode lookup
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-9-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9308; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=QmhmTJ9+CP7sGiwWpHsE25lzjIh2Wbnu23GArt9Mmgk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+ASFeAdN2ZVHu/sb2bvdrNopi168GyCrlE
 NryDa45Wn6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mIoWD/0dXYAjW4uKL+R3RiBVRTk1byYBR1CCvNN0x7dxMC77Cu/eKpO1AyJ5VPMU6pnhWXab1JA
 2yffHxn65KFITZJHFRDnk7yBkguQ72SjVHgxQS4OLOpQJf8EklHog/wc/Vu5d0BOSh/xatOPNwE
 nZJenIwohYvIblEvT4lMuyxwZLUmNikWEdXbf5QxcdCmWE4lHQjYdlcNjfaj3zJQvW3rA5CHM2+
 zXkSCmgVZL7P0jUzQWE5phFqL7XyQnACEMvC3j6Zrm2/zZuHeSC0U6TT6EvPsbgXeGOgyM8S0Zf
 db7Cy0lX5eTRWc8r1H6JHjntr+gZY+OSaL+Lrhud26gOMsl2FRAmc753AAc2LHunL/4Av2+FDOX
 GbXfdc/qXwVFKpkQUaex5CbvGZZ8hODPcfJaLficWziNEzw0oYj9c27QHKGzzowj1ZhL/HKKEY5
 PGi6Gm0ijTN3XwxH9oEkBoJjpN6ASDPhMRxIjPE/e5YL5MYehsJCYZWyUxzX+vJ+/8tkBJGd6zX
 VBwbqjSa4KCQKCLvIPxDvOrSeDWV8IgC0L+nQ0FIwYs4kEOIJx58xZCOiQ4mkrGaDNG8yvZTTST
 uT1ygYGiYkzroxQOdBFF2mfukz409OU7wT/l/xfsDZ+psZ15g1DF9FDl6R1zmYlUoVDBE2NdgHf
 xK2xxRCD/BSiqig==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Collapse function call chain and shortcut helper functions where
they are no longer necessary.  Move stat/getattr code into the iget
functions so that it only gets called when the inode doesn't exist
yet.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs.h           | 31 +++++--------------------------
 fs/9p/vfs_inode.c      | 46 +++++++++++++++-------------------------------
 fs/9p/vfs_inode_dotl.c | 47 ++++++++++++++++-------------------------------
 fs/9p/vfs_super.c      |  2 +-
 4 files changed, 37 insertions(+), 89 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 698c43dd5dc8..9defa12208f9 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,16 +179,13 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
-extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
-					 struct p9_fid *fid,
-					 struct super_block *sb, int new);
+extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
-extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
-					      struct p9_fid *fid,
-					      struct super_block *sb, int new);
+extern struct inode *v9fs_fid_iget_dotl(struct super_block *sb,
+					struct p9_fid *fid);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -230,27 +227,9 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 			struct super_block *sb)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 0);
+		return v9fs_fid_iget_dotl(sb, fid);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
-}
-
-/**
- * v9fs_get_new_inode_from_fid - Helper routine to populate an inode by
- * issuing a attribute request
- * @v9ses: session information
- * @fid: fid to issue attribute request for
- * @sb: superblock on which to create inode
- *
- */
-static inline struct inode *
-v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			    struct super_block *sb)
-{
-	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 1);
-	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
+		return v9fs_fid_iget(sb, fid);
 }
 
 #endif
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 766496579b28..76e40c057c56 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -362,37 +362,40 @@ void v9fs_evict_inode(struct inode *inode)
 #endif
 }
 
-static struct inode *v9fs_qid_iget(struct super_block *sb,
-				   struct p9_qid *qid,
-				   struct p9_wstat *st)
+struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
 {
 	dev_t rdev;
 	int retval;
 	umode_t umode;
 	struct inode *inode;
+	struct p9_wstat *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
-	inode = iget_locked(sb, QID2INO(qid));
+	inode = iget_locked(sb, QID2INO(&fid->qid));
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
-	if (unlikely(st == NULL)) {
-		retval = -EINVAL;
-		goto error;
-	}
 		
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
+	st = p9_client_stat(fid);
+	if (IS_ERR(st)) {
+		retval= PTR_ERR(st);
+		goto error;
+	}
+
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	retval = v9fs_init_inode(v9ses, inode, qid, umode, rdev);
+	retval = v9fs_init_inode(v9ses, inode, &fid->qid, umode, rdev);
+	v9fs_stat2inode(st, inode, sb, 0);
+	p9stat_free(st);
+	kfree(st);
 	if (retval)
 		goto error;
 
-	v9fs_stat2inode(st, inode, sb, 0);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
 	return inode;
@@ -402,23 +405,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-		    struct super_block *sb, int new)
-{
-	struct p9_wstat *st;
-	struct inode *inode = NULL;
-
-	st = p9_client_stat(fid);
-	if (IS_ERR(st))
-		return ERR_CAST(st);
-
-	inode = v9fs_qid_iget(sb, &st->qid, st);
-	p9stat_free(st);
-	kfree(st);
-	return inode;
-}
-
 /**
  * v9fs_at_to_dotl_flags- convert Linux specific AT flags to
  * plan 9 AT flag.
@@ -565,7 +551,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -693,10 +679,8 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	else 
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
-	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 2200c5f77d58..6f8cdbcef444 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,32 +52,33 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
-static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
-					struct p9_qid *qid,
-					struct p9_fid *fid,
-					struct p9_stat_dotl *st)
+struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 {
 	int retval;
 	struct inode *inode;
+	struct p9_stat_dotl *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
-	inode = iget_locked(sb, QID2INO(qid));
+	inode = iget_locked(sb, QID2INO(&fid->qid));
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
-	if (unlikely(st == NULL)) {
-		retval = -EINVAL;
-		goto error;
-	}
 
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	retval = v9fs_init_inode(v9ses, inode, qid,
+	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
+	if (IS_ERR(st)) {
+		retval = PTR_ERR(st);	
+		goto error;
+	}
+
+	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
+	kfree(st);
 	if (retval)
 		goto error;
 
@@ -87,7 +88,8 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	if (retval)
 		goto error;
 
-	unlock_new_inode(inode);
+	unlock_new_inode(inode);	
+	
 	return inode;
 error:
 	iget_failed(inode);
@@ -95,23 +97,6 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			 struct super_block *sb, int new)
-{
-	struct p9_stat_dotl *st = NULL;
-	struct inode *inode = NULL;
-
-	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
-	if (IS_ERR(st))
-		return ERR_CAST(st);
-
-	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st);
-
-	kfree(st);
-	return inode;
-}
-
 struct dotl_openflag_map {
 	int open_flag;
 	int dotl_flag;
@@ -261,7 +246,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -356,7 +341,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -793,7 +778,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 8d14cc0b3916..6d9a98c57185 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;

-- 
2.41.0

