Received: from e3i432.smtp2go.com (e3i432.smtp2go.com [158.120.85.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84512DB7BA
	for <v9fs@lists.linux.dev>; Mon,  4 May 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927071; cv=none; b=mFouy3UvmpNFIt0UIb3iuqlsxKLmsyhQp8iveAtFemwvUPe9e3pfRDAqxC1JF0anaJjJwyf/MYbEdwgBG4SsPq7wDMXKHm7rQqdoXcmlyL+TCBZneVmnfwnS0tQrG9EG61Llm036tBns7IireWCbCPrehnKx8JbUV5Pb4n3m6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927071; c=relaxed/simple;
	bh=7sq7SHBWJdHT0eSNvp1j1nb28zM9OL85eMNabEonjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEizBkl9GLYuqPyqHDxivchOyK5cnxcj86kukmz5nNO+2gWlMk+8HGBv3eK6E3w5nReY3L5S4CVZz8ALwJOLMoFTj4pRtNG7KKFysGub6rZVFP7aq2PU+qUs9OgW2H6tKRD4QKqMuK+6tWQC2JQavu0Igt583H93WgiGmKhUVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=eqazfGJ3; arc=none smtp.client-ip=158.120.85.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="eqazfGJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1777927068; h=from : subject
 : to : message-id : date;
 bh=uDAt6/xVCH2VFIgfEJijCWT0uxeYOXemw2k6m4/TsY4=;
 b=eqazfGJ3Q31pT7/fSDjr3vyj9QNP9oGQVIJ51m7o/jryfYPWCNNfG9xjZgg3xD9lDpI4w
 nNaoCfS7KMjm1Z4+d5X00/JY6Aeu+OYuJpPnMtVynoFQFpSjgQ+eRNok0JTLzUXFz2iJuJj
 8mB68bWN0QUhjZP5vR1EEbSxBdJ02+ztb7qWHwwG7lMjfMsrWl1eFqmxT81zTSwJgptgL/H
 wFPAG3eeZw8VW92n4ltNsz3jRfF2ymyXfzxHvEzUh4L5IQlzaJ9ipsz/7Gt3SaTY2Hz9Keh
 3vKWUFvO/Dwmzi7EYc4h0l2xKmsEKI8d+HSxWwYSIjqYOvUiu88DoOiYuwUQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wK02p-4o5NDgrimN4-mUKu;
	Mon, 04 May 2026 20:37:35 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v5 4/4] 9p: Enable symlink caching in page cache
Date: Mon,  4 May 2026 22:15:54 +0200
Message-ID: <639c8934f2d7d278c24b0bcdb974a23726fd73c4.1777923233.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777923233.git.repk@triplefau.lt>
References: <cover.1777923233.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s7SJeZSiTc
X-smtpcorp-track: qvHYgKk7f7SD.Qg8rI_kgMFfy.ChEUsAEv9cH

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 35 ++++++++++++++++++++++--
 fs/9p/vfs_inode.c      |  6 ++--
 fs/9p/vfs_inode_dotl.c | 62 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..899224697aaf 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,11 +70,31 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
-	int total, err;
-
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	int total = 0, err, len, n;
+
+	if (S_ISLNK(rreq->inode->i_mode)) {
+		/* p9_client_readlink() must not be called for legacy protocols
+		 * 9p2000 or 9p2000.u.
+		 */
+		BUG_ON(!p9_is_proto_dotl(fid->clnt));
+		err = p9_client_readlink(fid, &target);
+		if (err != 0)
+			goto fill_subreq;
+		len = strnlen(target, PAGE_SIZE - 1);
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		kfree(target);
+		if (n != len) {
+			err = -EFAULT;
+			goto fill_subreq;
+		}
+		total = i_size_read(rreq->inode);
+	} else {
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	}
 
+fill_subreq:
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
 	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
@@ -99,6 +119,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +136,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 		if (!fid)
 			goto no_fid;
 		p9_fid_get(fid);
+	} else if (S_ISLNK(rreq->inode->i_mode)) {
+		dentry = d_find_alias(rreq->inode);
+		if (!dentry)
+			goto no_fid;
+		fid = v9fs_fid_lookup(dentry);
+		dput(dentry);
+		if (IS_ERR(fid))
+			goto no_fid;
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c82db6fe0c39..98644f27d6f1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			goto error;
 		}
 
-		if (v9fs_proto_dotl(v9ses))
+		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_symlink_inode_operations_dotl;
-		else
+			inode_nohighmem(inode);
+		} else {
 			inode->i_op = &v9fs_symlink_inode_operations;
+		}
 
 		break;
 	case S_IFDIR:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..72918f90b278 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -686,9 +686,12 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
+	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
@@ -712,8 +715,29 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	v9fs_invalidate_inode_attr(dir);
 
+	/* instantiate inode and assign the unopened fid to the dentry */
+	fid = p9_client_walk(dfid, 1, &name, 1);
+	if (IS_ERR(fid)) {
+		err = PTR_ERR(fid);
+		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
+			 err);
+		goto error;
+	}
+
+	v9ses = v9fs_inode2v9ses(dir);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
+	}
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
+	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
 	return err;
 }
@@ -853,24 +877,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /**
- * v9fs_vfs_get_link_dotl - follow a symlink path
+ * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
+ *
+ * To be used when symlink caching is not enabled.
+ *
  * @dentry: dentry for symlink
  * @inode: inode for symlink
  * @done: destructor for return value
  */
-
 static const char *
-v9fs_vfs_get_link_dotl(struct dentry *dentry,
-		       struct inode *inode,
-		       struct delayed_call *done)
+v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
+			       struct inode *inode,
+			       struct delayed_call *done)
 {
 	struct p9_fid *fid;
 	char *target;
 	int retval;
 
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	fid = v9fs_fid_lookup(dentry);
@@ -884,6 +907,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 	return target;
 }
 
+/**
+ * v9fs_vfs_get_link_dotl - follow a symlink path
+ * @dentry: dentry for symlink
+ * @inode: inode for symlink
+ * @done: destructor for return value
+ */
+static const char *
+v9fs_vfs_get_link_dotl(struct dentry *dentry,
+		       struct inode *inode,
+		       struct delayed_call *done)
+{
+	struct v9fs_session_info *v9ses;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	v9ses = v9fs_inode2v9ses(inode);
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+		return page_get_link(dentry, inode, done);
+
+	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
+}
+
 int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 {
 	struct p9_stat_dotl *st;
-- 
2.52.0

