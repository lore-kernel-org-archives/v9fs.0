Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABC15A8
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZGWYQiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37778C433C7;
	Sat,  6 Jan 2024 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507077;
	bh=kot4iF/QDarHM9VhmDTaiToyFbsFqA6zYYgEX2GnOSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fZGWYQiEPviuNuvmo7LVpC5/WcadIVgEpfdSmiNOWYC6ij7OQQoQq9aNQh1eRyele
	 D/Cjfuc0/+6C//jCJisNrpQ3UQ/npL61GHTdOoxWjH0U3G0OJAynNlsW4CGikbZT7O
	 mrcTLSWjqqciorXdaSCWTFYNfjnwWfYPxj4NKMcHHeGDpiXzS9SDLKIAA5M147FsgW
	 dxAOVdnSebW6bqjRZPac4GnPF5HjoFfqOpeqJCXif4vM0lTLvJJOTrIyhFrf4eyLIe
	 fDzqE5wQ3YLJFv4lYGwNZqUrq6k8xbvX1GzwEg1ZLKAbJt9ZR44tyG2RFrz2yw2NZX
	 z++Uf9klyNjcg==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:14 +0000
Subject: [PATCH 7/9] fs/9p: rework qid2ino logic
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-7-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=kot4iF/QDarHM9VhmDTaiToyFbsFqA6zYYgEX2GnOSA=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+s76PNA8hnOn4SFC1XN/QC0yHtb7lOgw8a
 QvYIP5gMQmJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mNmDD/9Ritvzq6Mrn66zZGFyaVSM3OrvYnKr6PRjcRrbfkXhaSGQBbvKY+PPCUyC8kdDSj77s8z
 ww3tKwZ/edGkwC+X+rF5rS2GJI2A2yetHByyiHOT3QNgwLPvu0iQeE1qp7EzwgKlJX5fweicZFv
 X5NeKIknyJJU810vyoZdIyeJlLMgar9e8DCxv8rkegPxm7B+0ZDuOU1XN1Fdd/yo3NfhVmEyY6T
 MyUx1EIX5/gS5ePuUuvpiz/3MwIY8W5I0ORuMtSFqop0AuLVp3epd1O1pW72u2NoUmKzl5BfNHB
 8ilqkQakPEXFinJYML8t9xUmP5qBuRTiAOCIo2KacYWyO6/OLmNi+yDhDlVepNytqdAbKDpkjeC
 8XqOvhnNf5p3L94dJyQIjqBukFj+UKbHX/Z4LJItNqcD8UNV4xr0yj/j0JpZCbfGghEWRDdz1R8
 hSXP9/oaFmoSyfDejc17ks92fgSWLdcSAVEUAIg9fB+DaADMdQKnBugGYbsYpsAHJivMuD3+HnE
 CSeGoy36Iy3kwxQ/oPPBbXP+jCkFU4qLFd5H3zVp/Ef8diBkGgAqNKijtHkpMtpLo+QM59kopO7
 eYtJq9nA3A1/9RoiHXbkR4GvbV8rFJSvLk5rdFIYxfYbn2sOKolanyi3WIpJvYXwj0NWW2GDW0n
 NmnxwrhVoRhl+JQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This changes from a function to a macro because we can
figure out if we are 32 or 64 bit at compile time.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs_vfs.h       |  7 ++++++-
 fs/9p/vfs_dir.c        |  6 +++---
 fs/9p/vfs_inode.c      | 31 +------------------------------
 fs/9p/vfs_inode_dotl.c |  6 ++----
 4 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index ad0310deb6c8..789e1188d5dc 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -43,7 +43,12 @@ void v9fs_free_inode(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
-ino_t v9fs_qid2ino(struct p9_qid *qid);
+#if (ULONG_MAX == 0xffffffffUL)
+#define QID2INO(q) (ino_t) (((q)->path+2) ^ (((q)->path) >> 32))
+#else
+#define QID2INO(q) (ino_t) ((q)->path+2)
+#endif
+
 void v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 		      struct super_block *sb, unsigned int flags);
 void v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 4102759a5cb5..13a53da75ec8 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -125,9 +125,9 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 				p9_debug(P9_DEBUG_VFS, "returned %d\n", err);
 				return -EIO;
 			}
-
+			
 			over = !dir_emit(ctx, st.name, strlen(st.name),
-					 v9fs_qid2ino(&st.qid), dt_type(&st));
+					QID2INO(&st.qid), dt_type(&st));
 			p9stat_free(&st);
 			if (over)
 				return 0;
@@ -184,7 +184,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			if (!dir_emit(ctx, curdirent.d_name,
 				      strlen(curdirent.d_name),
-				      v9fs_qid2ino(&curdirent.qid),
+				      QID2INO(&curdirent.qid),
 				      curdirent.d_type))
 				return 0;
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 02761009946b..fe8cbcdf4b5f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -407,7 +407,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	dev_t rdev;
 	int retval;
 	umode_t umode;
-	unsigned long i_ino;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
@@ -417,8 +416,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	else
 		test = v9fs_test_inode;
 
-	i_ino = v9fs_qid2ino(qid);
-	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode, st);
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -428,7 +426,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = i_ino;
 	umode = p9mode2unixmode(v9ses, st, &rdev);
 	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
 	if (retval)
@@ -1159,32 +1156,6 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 	v9inode->cache_validity &= ~V9FS_INO_INVALID_ATTR;
 }
 
-/**
- * v9fs_qid2ino - convert qid into inode number
- * @qid: qid to hash
- *
- *  We add 2 to qid->path to keep reserved inode
- *  numbers reserved.
- * 
- *  Its possible in the future we will make qid->path
- *  just a hash to lookup inodes, but this breaks too
- *  much right now.
- * 
- */
-
-ino_t v9fs_qid2ino(struct p9_qid *qid)
-{
-	ino_t i = 0;
-
-	WARN_ON((qid->path+2)==0);
-
-	if (sizeof(ino_t) < sizeof(qid->path))
-		i = (ino_t) ((qid->path+2) ^ (qid->path >> 32));
-	else
-		i = (ino_t) qid->path;
-
-	return i;
-}
 
 /**
  * v9fs_vfs_get_link - follow a symlink path
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 8eee13bae887..2699d7b3b8e8 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -100,7 +100,6 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					int new)
 {
 	int retval;
-	unsigned long i_ino;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
@@ -110,8 +109,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	else
 		test = v9fs_test_inode_dotl;
 
-	i_ino = v9fs_qid2ino(qid);
-	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode_dotl, st);
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -121,7 +119,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = i_ino;
+	inode->i_ino = QID2INO(qid);
 	retval = v9fs_init_inode(v9ses, inode,
 				 st->st_mode, new_decode_dev(st->st_rdev));
 	if (retval)

-- 
2.41.0

