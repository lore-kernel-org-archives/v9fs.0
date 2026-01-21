Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CA3D2FF2
	for <v9fs@lists.linux.dev>; Wed, 21 Jan 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026435; cv=none; b=b5T98+Md9Qo3TFnGn1tSvQUIeQkNKWAHsJMfgxZG664Lafsn+TpmgyaRwj8BLKCWYJdAuNffIySfOdGv4K3r52oljcfyGRg87+8s/L1tjbzPQyM+dEd7Gk7sP7PT+GP60XPdBh3jISZj7J1ZHmNRX7/iakE0DZrJA3/G0VOet/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026435; c=relaxed/simple;
	bh=oXRQ+OIvRVA8lOdQTnWadsO0WEXGTxyNaHE7RJnSbuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/+MNLwa+keKYsOvvPPdoFUeu+UnDRrD4oCq8Ro9CBE0GOPir9u5wZV8RRdePIgzlwfp2EEjhnK1/lSYClfGXcpFaMN/pMDyX15xL0/lf/f+xINoQAUKvJ18/5wvOQB4snQs9hmYOwvos5bmHg61VcfmcLBg8BpR4lxorlJzV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=VhBj5vrC reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=l3zITVxg; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="VhBj5vrC";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="l3zITVxg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027333; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=1bBRb8rvUmXiBXLsNIGFcB0tqFd9sAVSXXO9H/xLowQ=; b=VhBj5vrC1QMLqWLoXlptW8Qav0
	Q1vNlvUr40JeK6OzmKXggCNe3xJOPrNJZCOqdmVFpjuyC/yxMFFF/F1vFC/ShoZSnwFZW8BQbj2r6
	2elDe5ULEyt403XcdqG4OAMt9pIXKdPndkyrgw9w4yZ76etJyCmnj0KQQlQQNRbEbNEqrI6ngEu11
	MFQxcI3KBu67IuDgyUIVPa8yNo0Mx+LWcG4ZyfJQmjsc1H85h7KmutowZZcmFGEj8O4ebBapMxodE
	WoW1RUtEfmKKmnP+1Za8JVQj+E5bMOecZi+0oWrEfV5ytZ02Nbce5/INyAz41iVzoSwomi8wFoAbW
	+TVogwxQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026433; h=from : subject
 : to : message-id : date;
 bh=1bBRb8rvUmXiBXLsNIGFcB0tqFd9sAVSXXO9H/xLowQ=;
 b=l3zITVxgSmL9G7Y3hxxtxTac2wdbCyYYvY7QXmaLayMdYK+YYz/bT5edqtKrLKOB+09Pq
 cEYSLypTUyYUx7SqbXnXD5j5oh75npWB8tfEtPrTmPH8IT/89XuU22qkYjTEI/Xnr6nQnKB
 cjisqU7sotJabWkBZrSdVWk3xJKNBtNbrACHycbDGgBwGqvwWwaTRzI53PEej49G6jnr12n
 PRAq1vSjPHR44m7qdQI90mu1Ntrx9F8AGyHoFly+u+PsZmVjtEpYoyu3u2BmQNRnx2q6vqa
 YpC26gMObmJ9ODCe4NgK5/ZE2bPU3D1cyQWOWJ6A70aN8x0zNcLsXaeRlqWQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaM-TRk2I3-Ta; Wed, 21 Jan 2026 20:13:50 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaM-AIkwcC8tEoU-IKfM; Wed, 21 Jan 2026 20:13:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Date: Wed, 21 Jan 2026 20:56:10 +0100
Message-ID: <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 8v1SRrK6G2Rd.LY1SpFzRQpK8.ew_rUQhDi7Z
Feedback-ID: 510616m:510616apGKSTK:510616sgw8awW5O5
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 24 ++++++++++++--
 fs/9p/vfs_inode.c      |  6 ++--
 fs/9p/vfs_inode_dotl.c | 73 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..ee672abbb02c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,10 +70,19 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
-	int total, err;
-
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	int total, err, len, n;
+
+	if (S_ISLNK(rreq->inode->i_mode)) {
+		err = p9_client_readlink(fid, &target);
+		len = strnlen(target, PAGE_SIZE - 1);
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		if (n != len)
+			err = -EFAULT;
+		total = i_size_read(rreq->inode);
+	} else
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -99,6 +108,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +125,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
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
index a82a71be309b..e1b762f3e081 100644
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
index 6312b3590f74..486b11dbada3 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -686,9 +686,13 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	umode_t mode;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
+	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
@@ -702,6 +706,15 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	gid = v9fs_get_fsgid_for_create(dir);
 
+	/* Update mode based on ACL value */
+	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
+	if (err) {
+		p9_debug(P9_DEBUG_VFS,
+			 "Failed to get acl values in symlink %d\n",
+			 err);
+		goto error;
+	}
+
 	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
 	err = p9_client_symlink(dfid, name, symname, gid, &qid);
 
@@ -712,8 +725,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
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
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
+	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
 	return err;
 }
@@ -853,24 +888,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -884,6 +918,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
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
2.50.1

