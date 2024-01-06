Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFC15A8
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8ymtrpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD40C433C7;
	Sat,  6 Jan 2024 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507076;
	bh=WcsBUkpy1F6mKEDfTEDSif8hiGN+jyga9xdAs/K/iAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R8ymtrpJI84+lHIxBZXpm1CYtsuHB8cnY87Gq7slkBTR3uf4yNdMztashh37Aw2kH
	 Gc5fFbKLafapA0+LD2bCzBkGOuxpPSDwFVWSpBM+dF3d6yq4OEbbESmg5p/nDH//dX
	 JXvd5y+YjUEE1nGobXO+Xi4B7cyOqHn6u+xkuTmyT3ExNhxo/jNniF/dmk/InToOUj
	 3DAuKJ/Mx5CnI/GAXFkAKguXY4fmZ5fucS+M4BSuKLQaVRnfEkdujW3CVhh9ekIktk
	 VDfoI31fvuy/DHw/yATPYjwWDj7fu6AIv2SA3cog0a3mjI7inWqNlVWnyuot3IQBJ7
	 3Mq1PMCCLZXQA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:12 +0000
Subject: [PATCH 5/9] fs/9p: Eliminate redundant non-cache path in mknod
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-5-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=WcsBUkpy1F6mKEDfTEDSif8hiGN+jyga9xdAs/K/iAk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+8BGcl1uMVYPJFJdC7DornzpLzqOdRQXZJ
 ELD5DAOvTmJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mDCJD/4rMjkVo2GqVPA5jqoPE1tLO9OVIfWtsPqb2jY3qJjUNbQihPbKdI8lFARpN5glFmnI8vv
 N/H/b4eFNHrswnFuJPU+PWTfBoAsJ5B0whyATMkc0F7X9rdvg7OZSuuGK6ZaXpCyeOPw65xm6PA
 WLgOAXxeW6f+gCeOD793l7Mp1qQwauyKnbJ0DY5JendolSsu2rFbJXYqf4NT9vv0RpahjJLXS/T
 YknmFrW5NmDoYPqGLhkTSqyMEj6wl773CRKfjPQ/Pd72FJ5Okb6ViVaxMsS2uEg/O6YhLhUGB7M
 f9k9/4d0EB40LI77JMbbpTw5vn1EzHHUrZmEcpwmX4N5Mqzo0d8KAiimJTEcjZzYsjPPKiAN69m
 Pgo/7MPX/sh3fP9Co2tPPObnbiI2oIjL8tg/VEikQOYisqf3fzKjoaQTmM1bliwqBpEH9wAZv2B
 l53KFM+wGMRHgj/Cyske2l/FZab/EXxDa9HXlxGcvHpB7XN2t4Dt8Q2hUksntbx/ZMZs7ZW5s+x
 iUGOJFFczh/2ywy2VW6IKm76SCzX8Y6r166xEPNCzxT9Xxppliryfb4s1w2yH+1Lk8dQCxZajGm
 jzZOxwhtgVS1o8wyPwSod2SW/v3EElyfc3vZGuyGw7RO4mv31rhDRMCwb16KBHOUParJcQcPVgo
 yj2VSeNW1Z4UW/A==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Like symlink, mknod had a seperate path with different inode
allocation -- but this seems unnecessary, so eliminating this path.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c435952f6355..8eee13bae887 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -838,33 +838,17 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-
-	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		v9fs_fid_add(dentry, &fid);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/*
-		 * Not in cached mode. No need to populate inode with stat.
-		 * socket syscall returns a fd, so we need instantiate
-		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, rdev);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			goto error;
-		}
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		d_instantiate(dentry, inode);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
 	}
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
 	v9fs_put_acl(dacl, pacl);

-- 
2.41.0

