Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556E154452
	for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214669; cv=none; b=kprLKlwI5slC29xkex5Beq8DBezthRX3ZrHHwbpKWL65KB9Ib+X1YaajP8GWBo8SOTGVD5fiRM5rDKazq3As9Q3TOtmyuXae4t2tr931CEVR8HxWxgdyOmS/88oiUgSyQ31f3HPjigwDYyfYB8JJMy3W4k7IGRVkn/QAH5cQHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214669; c=relaxed/simple;
	bh=20V7YXMqgrka9BLf1a9TzHQD85Oi5Vnr528xww8s8ok=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qmvpD2Wi7y08j7H3i+ex5AJ/w12SxDdk61bEhT1DzTyEJ4NuAfIAxOnP3rSrIxAVf45U2qdKYDhixOPaFQL0hFT98zmH6dPyNe2/xU2pkRaHm6wA8Y8y9JxpPGMiZWgCJRLz1+8Kcp3UpVtyHlozHSW8QLBGD63j/1Ej5+4wVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0TQmz9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0TQmz9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74678C113CC
	for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713214668;
	bh=20V7YXMqgrka9BLf1a9TzHQD85Oi5Vnr528xww8s8ok=;
	h=From:Date:Subject:To:From;
	b=r0TQmz9gJMk7gjwHEOHLpL4pX/C9eyNTSitiXFFnJrgZGR21UxYohC2TBP6c/qDtG
	 mn2zenLS8fAMW9i23P66jKkyMh9QXyTv0D82WT4MftQIqMKewGENGarQSXKU4VoRZ0
	 GWzAHh19w8B8l3DZ4wQ8l40u2+mGDS8FHHgZdka2PRdB1R//a2R2/QNii/Q4HVYOFw
	 +eAjFVjuS0FOTM2+f/XT7oDgcv7k/gN6/gSW+5wrBWs79wQthxUwJEed43cbn0tqLV
	 bcPcTdh87rs7/fJZJBLk+I7HyDyUwvwcHrURHNJl2S+giJ8soxGFpi61UjYeSal5Ii
	 4Bz3xEPJ8LIyg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61aed4a91d6so841717b3.0
        for <v9fs@lists.linux.dev>; Mon, 15 Apr 2024 13:57:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YweZqH79daCdLjjqRZa7opROsSMxMMOhS8bYgQNdMlOS/FIXAR7
	I1iHoNIrUaH0F2aL8zrKEwRNmUoCJPDoGIqH4t00mTZwQ2rxOGvF4F327y2KWDDwQo1zAhaVQMm
	6ifepsYT8VhqjsRWcUIotpsWg1AU=
X-Google-Smtp-Source: AGHT+IH1j045R7aOq8F4kGYeUsA99ZleVfj+BJcVw1PDQJeR4va16l1xuTEEhC8425PKzNuAT2EXPqPYa/mZw6FTbCM=
X-Received: by 2002:a05:690c:6111:b0:61a:b3e2:45e6 with SMTP id
 hi17-20020a05690c611100b0061ab3e245e6mr7342276ywb.10.1713214667683; Mon, 15
 Apr 2024 13:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 15 Apr 2024 15:57:36 -0500
X-Gmail-Original-Message-ID: <CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com>
Message-ID: <CAFkjPTn7JAbmKYASaeBNVpumOncPaReiPbc4Ph6ik3nNf8UTNg@mail.gmail.com>
Subject: [PATCH] fs/9p: mitigate inode collisions
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Detect and mitigate inode collsions that now occur since we
fixed 9p generating duplicate inode structures.  Underlying
cause of these appears to be a race condition between reuse
of inode numbers in underlying file system and cleanup of
inode numbers in the client.  Enabling caching
makes this much more likely to happen as it increases cleanup
latency due to writebacks.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs.h           | 11 ++++++-----
 fs/9p/vfs_inode.c      | 42 ++++++++++++++++++++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c | 28 ++++++++++++++++++++--------
 fs/9p/vfs_super.c      |  2 +-
 4 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 9defa12208f98..1775fcc7f0e8e 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,13 +179,14 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
                           struct inode *old_dir, struct dentry *old_dentry,
                           struct inode *new_dir, struct dentry *new_dentry,
                           unsigned int flags);
-extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid);
+extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid,
+                                               bool new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
 extern struct inode *v9fs_fid_iget_dotl(struct super_block *sb,
-                                       struct p9_fid *fid);
+                                               struct p9_fid *fid, bool new);

 /* other default globals */
 #define V9FS_PORT      564
@@ -224,12 +225,12 @@ static inline int v9fs_proto_dotl(struct
v9fs_session_info *v9ses)
  */
 static inline struct inode *
 v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-                       struct super_block *sb)
+                       struct super_block *sb, bool new)
 {
        if (v9fs_proto_dotl(v9ses))
-               return v9fs_fid_iget_dotl(sb, fid);
+               return v9fs_fid_iget_dotl(sb, fid, new);
        else
-               return v9fs_fid_iget(sb, fid);
+               return v9fs_fid_iget(sb, fid, new);
 }

 #endif
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 47bd77199e20c..4cf69135d1073 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -364,7 +364,8 @@ void v9fs_evict_inode(struct inode *inode)
                clear_inode(inode);
 }

-struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
+struct inode *
+v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid, bool new)
 {
        dev_t rdev;
        int retval;
@@ -376,8 +377,18 @@ struct inode *v9fs_fid_iget(struct super_block
*sb, struct p9_fid *fid)
        inode = iget_locked(sb, QID2INO(&fid->qid));
        if (unlikely(!inode))
                return ERR_PTR(-ENOMEM);
-       if (!(inode->i_state & I_NEW))
-               return inode;
+       if (!(inode->i_state & I_NEW)) {
+               if (!new) {
+                       goto done;
+               } else {
+                       p9_debug(P9_DEBUG_ERROR, "WARNING: Inode
collision %ld\n",
+                                               inode->i_ino);
+                       iput(inode);
+                       remove_inode_hash(inode);
+                       inode = iget_locked(sb, QID2INO(&fid->qid));
+                       WARN_ON(!(inode->i_state & I_NEW));
+               }
+       }

        /*
         * initialize the inode with the stat info
@@ -401,11 +412,11 @@ struct inode *v9fs_fid_iget(struct super_block
*sb, struct p9_fid *fid)
        v9fs_set_netfs_context(inode);
        v9fs_cache_inode_get_cookie(inode);
        unlock_new_inode(inode);
+done:
        return inode;
 error:
        iget_failed(inode);
        return ERR_PTR(retval);
-
 }

 /**
@@ -437,8 +448,15 @@ static int v9fs_at_to_dotl_flags(int flags)
  */
 static void v9fs_dec_count(struct inode *inode)
 {
-       if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
-               drop_nlink(inode);
+       if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2) {
+               if (inode->i_nlink) {
+                       drop_nlink(inode);
+               } else {
+                       p9_debug(P9_DEBUG_ERROR,
+                                               "WARNING: unexpected
i_nlink zero %d inode %ld\n",
+                                               inode->i_nlink, inode->i_ino);
+               }
+       }
 }

 /**
@@ -489,6 +507,14 @@ static int v9fs_remove(struct inode *dir, struct
dentry *dentry, int flags)
                } else
                        v9fs_dec_count(inode);

+               if (inode->i_nlink <= 0) { /* no more refs unhash it */
+                       remove_inode_hash(inode);
+               } else {
+                       p9_debug(P9_DEBUG_ERROR,
+                       "WARNING: unlink inode %lx %s qid->path=%llx
w/i_nlink==%d\n",
+                       inode->i_ino, dentry->d_name.name,
v9fid->qid.path, inode->i_nlink);
+               }
+
                v9fs_invalidate_inode_attr(inode);
                v9fs_invalidate_inode_attr(dir);

@@ -554,7 +580,7 @@ v9fs_create(struct v9fs_session_info *v9ses,
struct inode *dir,
                /*
                 * instantiate inode and assign the unopened fid to the dentry
                 */
-               inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+               inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, true);
                if (IS_ERR(inode)) {
                        err = PTR_ERR(inode);
                        p9_debug(P9_DEBUG_VFS,
@@ -683,7 +709,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir,
struct dentry *dentry,
        else if (IS_ERR(fid))
                inode = ERR_CAST(fid);
        else
-               inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+               inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, false);
        /*
         * If we had a rename on the server and a parallel lookup
         * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 55dde186041a3..4b7f40b954daa 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,7 +52,10 @@ static kgid_t v9fs_get_fsgid_for_create(struct
inode *dir_inode)
        return current_fsgid();
 }

-struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
+
+
+struct inode *
+v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid, bool new)
 {
        int retval;
        struct inode *inode;
@@ -62,8 +65,18 @@ struct inode *v9fs_fid_iget_dotl(struct super_block
*sb, struct p9_fid *fid)
        inode = iget_locked(sb, QID2INO(&fid->qid));
        if (unlikely(!inode))
                return ERR_PTR(-ENOMEM);
-       if (!(inode->i_state & I_NEW))
-               return inode;
+       if (!(inode->i_state & I_NEW)) {
+               if (!new) {
+                       goto done;
+               } else { /* this deal with race condition in inode
number reuse */
+                       p9_debug(P9_DEBUG_ERROR, "WARNING: Inode
collision %lx\n",
+                                               inode->i_ino);
+                       iput(inode);
+                       remove_inode_hash(inode);
+                       inode = iget_locked(sb, QID2INO(&fid->qid));
+                       WARN_ON(!(inode->i_state & I_NEW));
+               }
+       }

        /*
         * initialize the inode with the stat info
@@ -90,12 +103,11 @@ struct inode *v9fs_fid_iget_dotl(struct
super_block *sb, struct p9_fid *fid)
                goto error;

        unlock_new_inode(inode);
-
+done:
        return inode;
 error:
        iget_failed(inode);
        return ERR_PTR(retval);
-
 }

 struct dotl_openflag_map {
@@ -247,7 +259,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir,
struct dentry *dentry,
                p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
                goto out;
        }
-       inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+       inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
        if (IS_ERR(inode)) {
                err = PTR_ERR(inode);
                p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -340,7 +352,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
        }

        /* instantiate inode and assign the unopened fid to the dentry */
-       inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+       inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
        if (IS_ERR(inode)) {
                err = PTR_ERR(inode);
                p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -776,7 +788,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap,
struct inode *dir,
                         err);
                goto error;
        }
-       inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+       inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
        if (IS_ERR(inode)) {
                err = PTR_ERR(inode);
                p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 55e67e36ae682..f52fdf42945cf 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct
file_system_type *fs_type, int flags,
        else
                sb->s_d_op = &v9fs_dentry_operations;

-       inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
+       inode = v9fs_get_inode_from_fid(v9ses, fid, sb, true);
        if (IS_ERR(inode)) {
                retval = PTR_ERR(inode);
                goto release_sb;
-- 
2.41.0
