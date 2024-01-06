Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E715A8
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmUX8mlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD8DC433C8;
	Sat,  6 Jan 2024 02:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507073;
	bh=FzqC8vGfSQKqsymfIdQBKBTvSoDcKJkKyoEMFGNr5Uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PmUX8mlQqPM1Mz4Wz0JHkmAqAsUItLMY+Rn7Th4masyrIug+mHuihPlsDxAEtmY+8
	 CHsVLgm8+7qrMm+XK++DhxUzLctE9NsGFIGmdEYQ/BEUxrmDhLn23w+JVwD06dAj+U
	 zld1P1pVl7GhkXn4rjwDZSBywRCIhc6mEyW0ev2EjQmceapczrRncn81iGx+kTIF5I
	 StaQqf7rMLSW50pWJa0q+JMnCSrxcM7ZDewwLuTC3KKzNOWtXKOft5VFEDxTAvr/kj
	 cJtaZ/70HUj/GGDthaSdEdu8vCb02J9icMG/1HAmmEuPVo6FDOkGl5TVGXwBBBuRQD
	 6UnmRtm0e0mQQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:09 +0000
Subject: [PATCH 2/9] fs/9p: switch vfsmount to use v9fs_get_new_inode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-2-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=FzqC8vGfSQKqsymfIdQBKBTvSoDcKJkKyoEMFGNr5Uk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+bYyjavEwQ/+ZukjEm+V7H+sf6ybM2KmRg
 ZW3yZAynGOJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mOgDD/9kX9/H8C7vvNzApOIw6IUrlYymcTdsD/OJCaoK7ibzy5m15Jl8kSdsw2sO3QveAU3FJtz
 fRzuBLO4jiuwBa706HbjonN9Kd7LE24FbQ5YNlA36RJsTFzsiQjyHmXLh7xsai1tejfLOlDostY
 AebXgXuAkAiPDCoIAD3t5Gzk5nDg7g/g8+BNPsTSdJvR4kk3R1Lerh9Prwgkl65l9ywgzb1xU7P
 o2lsxAhPWnASohM648wPdpqsJqs3kUKLbu8L5MuKDGLX3A6qqz/LyTTWJuqc9kFD0/tOQkCtYpO
 gS9qaywrTDcOGtouA8WHjfSgdnS70skO9+Gw2Hw2iZmoVjYn8XV79fk3Qy5CUGV3qc3E+0NWiAK
 K9pvrlDbP8lWvzUFq5hhoo0YzbGC2AaW4sQPTqkneCUUOlUjCVIqbQLzEccYHBtXZhNRSDk+t6A
 FjhdGy1V6wT7v5/JaJk10Sh1OzC9lY5TfVkSRQ+PwI9bWPxEUhK7lIY9G9UHKWQvuvRg4tUsacr
 FDhYq3YJV927nEb3MwWZthdi8OT6wSSg20nuXYF/QYttExTnS9yZpElbs5s+s1WNmhUHoQnTB+R
 N6/B2PFNp/rxUYgqoJxxAOj62KwhUPw4nwVCpEWLyT2GbaaBtqV09HWr4bE8ImA9M5odMgqSYGa
 a8zAOsC/xllX3kg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

In the process of cleaning up inode number allocation, I noticed several functions which didn't use the standard helper
allocators.  This patch fixes the allocation in the mount entrypoint.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_super.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 73db55c050bf..8d14cc0b3916 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -110,7 +110,6 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	struct inode *inode = NULL;
 	struct dentry *root = NULL;
 	struct v9fs_session_info *v9ses = NULL;
-	umode_t mode = 0777 | S_ISVTX;
 	struct p9_fid *fid;
 	int retval = 0;
 
@@ -140,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_inode(sb, S_IFDIR | mode, 0);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;
@@ -152,32 +151,6 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		goto release_sb;
 	}
 	sb->s_root = root;
-	if (v9fs_proto_dotl(v9ses)) {
-		struct p9_stat_dotl *st = NULL;
-
-		st = p9_client_getattr_dotl(fid, P9_STATS_BASIC);
-		if (IS_ERR(st)) {
-			retval = PTR_ERR(st);
-			goto release_sb;
-		}
-		d_inode(root)->i_ino = v9fs_qid2ino(&st->qid);
-		v9fs_stat2inode_dotl(st, d_inode(root), 0);
-		kfree(st);
-	} else {
-		struct p9_wstat *st = NULL;
-
-		st = p9_client_stat(fid);
-		if (IS_ERR(st)) {
-			retval = PTR_ERR(st);
-			goto release_sb;
-		}
-
-		d_inode(root)->i_ino = v9fs_qid2ino(&st->qid);
-		v9fs_stat2inode(st, d_inode(root), sb, 0);
-
-		p9stat_free(st);
-		kfree(st);
-	}
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
 		goto release_sb;

-- 
2.41.0

