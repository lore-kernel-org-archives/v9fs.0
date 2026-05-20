Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993832EBBA4
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244023; cv=none; b=Ksx88itZX5UKgx40OdjEFq/Ir5mo3mZat4wV6wbZ6rBdvvcVrWUZjZU5vz0mF+aCxtBHv/10uPci90BakFCG5eFhlK1STLsf2rrwuLv2VEemUJqBaSgi3HSqSxRbeWEaPppkhpfsoo3/OBiKH+d4DGsSvqq2LaM8bhW7f+5mjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244023; c=relaxed/simple;
	bh=rmZM/awopyaf49NiKdmpe6mp2TnPb/DbMRvC2qJeeX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JntZ0jkXeqBP85h9pCN+qhCpm3Sf91qBcgd9QvH+OSaceMB3OfpDIT7yVGDhbwu1A9L20u/gw+XehcWYfB2W5i+To35GlfQ+3BZdKmDum0tkcWu/ZC9NPiuUwX6PdhfiKPDr1x15aJw4bZe4e+5AgUcZEoHYRZb+RQwlq/Ruhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5dd3dc4453f311f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cfca9f8e-83ca-4b82-bf7b-fda473151785,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ee60e39eef676eeebddcc4ba1415b802,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5dd3dc4453f311f1aa26b74ffac11d73-20260520
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1665517054; Wed, 20 May 2026 10:26:54 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2] 9p: avoid returning ERR_PTR(0) from mkdir operations
Date: Wed, 20 May 2026 10:26:50 +0800
Message-Id: <20260520022650.14217-1-zenghongling@kylinos.cn>
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
Suggested-by: David Laight <david.laight.linux@gmail.com>
Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
change inv1:
- Add clarification in commit message that this is not a functional
  change, as suggested by Christian Schoenebeck.
- Add acked-by.
---
Changes in v2:
- Simplified v9fs_vfs_mkdir() implementation based on reviewer feedback
- Remove unnecessary 'err' variable and use ERR_CAST()
- Add suggested-by
---
 fs/9p/vfs_inode.c      | 19 ++++++-------------
 fs/9p/vfs_inode_dotl.c |  4 ++--
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d1508b1fe109..d2692bc20b08 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -672,27 +672,20 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				     struct dentry *dentry, umode_t mode)
 {
-	int err;
 	u32 perm;
 	struct p9_fid *fid;
 	struct v9fs_session_info *v9ses;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	err = 0;
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
-	if (IS_ERR(fid)) {
-		err = PTR_ERR(fid);
-		fid = NULL;
-	} else {
-		inc_nlink(dir);
-		v9fs_invalidate_inode_attr(dir);
-	}
-
-	if (fid)
-		p9_fid_put(fid);
-	return ERR_PTR(err);
+	if (IS_ERR(fid))
+		return ERR_CAST(fid);
+	inc_nlink(dir);
+	v9fs_invalidate_inode_attr(dir);
+	p9_fid_put(fid);
+	return NULL;
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

