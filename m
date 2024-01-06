Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52C15AB
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFFW3m8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD58AC433C7;
	Sat,  6 Jan 2024 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507074;
	bh=6J7EZJj9VWIpSwcWubGlaBSfbZNbY5oiwi0szyHJl2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pFFW3m8rQOi++GbL0FBo12fKix9MUwtwQNuEZgODI3esjivPQREnyPDNgZHg45I7N
	 L5MQaHrfUpKO1m+XqsxtFBOqwOCAdhgiTibJsy3BqNrJ88scrG4jsIF04PqwdkjCUd
	 oABU+Bgw+gd7lhq+P+sJLFvKlGibdkWALwjIJsJ6Dy/egr9b57c6qDPkHtARQfgRud
	 btnEq+6UD+89MDfSwgniN1EuaXxzktc/jys2/PKkSPi3r3VLJXgR65FpGcS+iPBo76
	 RQnwlepaBBQ3HFLZUxmPTN6LnvR7daEhnAVWVSq2TFlkq2ogvge/NpAJmQAOS5TBLA
	 CySdVVmFIbbHA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:10 +0000
Subject: [PATCH 3/9] fs/9p: convert mkdir to use get_new_inode
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-3-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=6J7EZJj9VWIpSwcWubGlaBSfbZNbY5oiwi0szyHJl2k=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+yTHWqJB9C3xBalia4vpyb7nOFLHx/qiEp
 KYMpjFmgM+JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mOLKD/9ucY0+lTqzhCgWYZ1aHAqQPDyxjbBK925EZEJfCBoEgbEAkyzA9JudcQGpm1oK01OLltU
 BfATyXh6WtypxRQrkOVKOV3RGdaOMer5vhC3wNxFm2KJ6Hf86oAatm3mymDDcZMh0S5Qt5x+aBK
 xp0MYMzhizAUQM1XxnqjmVp1S1wByQEn3IZ+/IsZlm5c3dm0JL37+PXTzEsNdUpvlUztNVzZNJ9
 6xVPR7IhciWW9Fzii4y2JdFHCkwioFXqm0sESmni/SsUHCL0bCCuqj1lTBUp/AuoC55DD02uqud
 lcORCuoTWKmExffLN64R3OtxWPIvgFCeBNwCVknNIdcuScAyi6vdspzOsKedb5IwBI1NDQy2Agg
 eZKWIyOUWKDto8A1ENxpM0gTu/X4vr5VvXU8lCMQrCR6YlK28Yt1gSsX1g8fqCjJgkuhnfWrxSz
 NKm+l/degcppPiHWF3PYn76eRZR5OFAIdgi3u54AHunZieH3swj9EmBd66/YwtKYZjVaEU02L9v
 BnHg9Imb+JNweF+Ti5NUZ6l0oJI4/a+FOzR2577ugziTtRG1TugS4pTsGVZSkriEoAF2GUphYdm
 soVeYzTX5bQYMcqQS0x+002bTwHp1N4dHxRaQwjEENe+oLVWjFIiUD9GYcGF8sZSiL4H2U1Ui3L
 xGOSWmco9uPYCJQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

mkdir had different code paths for inode creation, cache used
the get_new_inode_from_fid helper, but non-cached used
v9fs_get_inode.  Collapsed into a single implementation across
both as there should be no difference.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c7319af2f471..981278d0788e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -401,32 +401,17 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_fid_add(dentry, &fid);
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/*
-		 * Not in cached mode. No need to populate
-		 * inode with stat. We need to get an inode
-		 * so that we can set the acl with dentry
-		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, 0);
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
+	v9fs_fid_add(dentry, &fid);
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	d_instantiate(dentry, inode);
+	err = 0;
 	inc_nlink(dir);
 	v9fs_invalidate_inode_attr(dir);
 error:

-- 
2.41.0

