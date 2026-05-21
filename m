Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C51369990
	for <v9fs@lists.linux.dev>; Thu, 21 May 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357776; cv=none; b=rB+3JGfUslJB6h9KYyUMDDrfYVUfHQjzqNOoj7Cs81x5DkKFnVgF+enNFKFYT8NF0scVKSjkwKPdjSY5FQrNzUPPRPq7RvoP6ciQGQcMf19EeBDBEQaEZqsPq3dDmcfN1H4Vcyl9WFZ654agD8T3EU1JXjHrCFJZ0Rx7miaP3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357776; c=relaxed/simple;
	bh=I1588I/1fYv3RU4qRZ8PpNJ1gtZ11AAIoQ3cZ95uqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puhQbZuiwhaRoMECCzWuB/wH5NBTQ7n1XMzIgOfUL/IBEaOSLQf9OWInMbwaZQ2GHM3rcFBYnXHF7NZ/NqKLYTfxQ1kuVE4zlHoV7r3Fp4MSVLRs0BpUrFHJh/VosFaGJfIpKhEWeAOUtMvLwcAJjrz3OjUKpz2gYVYPrvBfw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=d7W21HL8; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="d7W21HL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779357774; h=from : subject
 : to : message-id : date;
 bh=T72YYyUlEQJZdzLS62UItGU7H4qC2PfTWsccTrhKodE=;
 b=d7W21HL85m9wrJz5NZcvgawetzJCvawk++JbKmvStMJsOHX+I5x0RvCjOFHHC2JDZECaN
 2VXfrnyEeZsL45fCY33IwtljW7JAaKwtuXpIYfiaQN6NR+Qb8O3NcJcFpFrMyeIyMLK8X6x
 iAUlVGGwzXk38v2XXMns3hN82znnnDTO8pH59/zD7VPyyicSGFHKZgt+SZAGwiBUij4Z5Da
 CbH9AdzKafrJaecljhgWnIx96bbYcgU2uNQn0KCTvFeUtwT+kxVUaIji6NvrRilvARg438W
 xm9EOH2RlhBN/vWJg8/NCFDBvdoka6YSK7fGY95hx5tDkp/+xql6YT36sJ8A==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wQ0Et-4o5NDgrlHTS-n0aL;
	Thu, 21 May 2026 10:02:51 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v7 4/4] 9p: Enable symlink caching in page cache
Date: Thu, 21 May 2026 11:40:32 +0200
Message-ID: <982462d17c0c0d2856763266a25eb04d080c1dbb.1779355927.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616swVnw_WQeF
X-smtpcorp-track: euCgbWkY06GK.48Ea1TdIlI-7.hQHOKg1eqpq

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 38 ++++++++++++++++++++++++++---
 fs/9p/vfs_inode.c      |  6 +++--
 fs/9p/vfs_inode_dotl.c | 54 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index c21d33830f5f..1ac0b3dcc077 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,11 +70,34 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
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
+		if (WARN_ON_ONCE(pos)) {
+			/* reading a link at a non null offset should
+			 * not happen
+			 */
+			err = -EIO;
+			goto fill_subreq;
+		}
+		err = p9_client_readlink(fid, &target);
+		if (err != 0)
+			goto fill_subreq;
+		len = strlen(target);
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		kfree(target);
+		total = n;
+	} else {
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	}
 
+fill_subreq:
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
 	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
@@ -99,6 +122,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +139,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 		if (!fid)
 			goto no_fid;
 		p9_fid_get(fid);
+	} else if (S_ISLNK(rreq->inode->i_mode)) {
+		dentry = d_find_any_alias(rreq->inode);
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
index 5cbbebafc24e..d29df0b2e89c 100644
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
index 141fb54db65d..3ca79f225709 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -690,9 +690,11 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%llu,%s,%s\n", dir->i_ino, name, symname);
@@ -716,6 +718,26 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
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
 	p9_fid_put(dfid);
@@ -857,16 +879,18 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -888,6 +912,26 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
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

