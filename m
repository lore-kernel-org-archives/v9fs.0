Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD842D0603
	for <v9fs@lists.linux.dev>; Mon, 11 May 2026 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480323; cv=none; b=M/pTVgiPQ8bzzpyLMYVlLV7vOhCoil0eHTRQacZJkjVW3Yx6bXHmDn6nBY07WZsFFWTM8zp5Oh5ux1ZnrR6k7p3fq409F60csPh96KqofNuV2BXd6kAWuUWef/Ct9eQH1G5LtYpVBhXsIQFAxQdN7Bu8Lx2hLFxjD91L9yPa0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480323; c=relaxed/simple;
	bh=zyPAEDxHBYLH2kL15jS7ZQfleltQuucQMytlIoxWEf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tulpzojZBkCc/Hx8Y6RbuwpVTos+YFy73Gn8xnfEHQelqiDE42aNsVX+NNdiGXv+fa/J6g7XMDyPaOcnu6GzpVgu7K7ApyRzXHJumHZ1mjZDZ4VMOcGtGwMoj6e5zZ5wit83YFo6s5DuFPOzUVZq7gx/Ubv4F/4Hekn/8xSVWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3dce95684d0111f1aa26b74ffac11d73-20260511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:22af7682-7646-4788-a084-700a8a19678a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:249d9fa06bf9af5b94279e0b1524f438,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3dce95684d0111f1aa26b74ffac11d73-20260511
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1650687147; Mon, 11 May 2026 14:18:35 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v1] 9p: Fix mkdir to return NULL on success
Date: Mon, 11 May 2026 14:18:30 +0800
Message-Id: <20260511061830.38373-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mkdir succeeds, v9fs_vfs_mkdir_dotl() and v9fs_vfs_mkdir() return
ERR_PTR(0) which is incorrect. They should return NULL instead for
success and ERR_PTR() only with negative error codes for failure.

Return NULL instead of passing to ERR_PTR while err is zero
Fixes smatch warnings:
  fs/9p/vfs_inode_dotl.c:420 v9fs_vfs_mkdir_dotl() warn: passing zero to 'ERR_PTR'
  fs/9p/vfs_inode.c:695 v9fs_vfs_mkdir() warn: passing zero to 'ERR_PTR'

This change does not alter the runtime behavior since ERR_PTR(0) and NULL
are equivalent. However, it improves code readability and silences static
analyzer warnings.

Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
change inv1:
- Add clarification in commit message that this is not a functional
  change, as suggested by Christian Schoenebeck.
- Add acked-by.
---
---
 fs/9p/vfs_inode.c      | 5 ++---
 fs/9p/vfs_inode_dotl.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d1508b1fe109..d2d18c796b58 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -672,13 +672,12 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				     struct dentry *dentry, umode_t mode)
 {
-	int err;
+	int err = 0;
 	u32 perm;
 	struct p9_fid *fid;
 	struct v9fs_session_info *v9ses;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	err = 0;
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
@@ -692,7 +691,7 @@ static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (fid)
 		p9_fid_put(fid);
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 /**
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 71796a89bcf4..83a52a85ce08 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -349,7 +349,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 					  struct inode *dir, struct dentry *dentry,
 					  umode_t omode)
 {
-	int err;
+	int err = 0;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
@@ -412,7 +412,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	p9_fid_put(fid);
 	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 static int
-- 
2.25.1

