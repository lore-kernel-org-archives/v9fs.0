Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FD1381
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaQbVMU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE744C433CA;
	Sat,  6 Jan 2024 02:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507075;
	bh=T5xc0bJrXcRdQKa0K3R9OxUailnaVit69f7Vx3zsyzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XaQbVMU9FwAqm2VGzMTGIzCmqhQpasXjaMIzjDwwwqLVbb5FVovzsa1/CP+x7OaXz
	 Tm5zBd1s6CaM0L4sX8F1S4H0g4tDQGYcI/H4lgBA7zZmmNq4Y71hugJxtWglZEBaQr
	 AQSe2wqSK7IlilLYCFuIv476ajNBktlKd3D3ez+kPJLcOxUDcVQfX2fKB11im8n1q3
	 jAttEc1IAuEx/NzEMD79FIK/rhIngiV5M/PbWBpc8qF962ojhHrK7C7l+ha3D/QisA
	 vH5dPulMBzuLInfvX9gX/1gV7ewFPXSwNO8KawT5L1mCunbvOHwxNcsCJ7Mb7DX8fU
	 jTJyBhYaC09lA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:11 +0000
Subject: [PATCH 4/9] fs/9p: remove walk and inode allocation from symlink
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-4-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=T5xc0bJrXcRdQKa0K3R9OxUailnaVit69f7Vx3zsyzU=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+Lp07SLiGq/GDLs5ljQv9/YcSNi8PCWkZQ
 IhmIk/TwfuJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mGJzEAC8FioHQcZhFzN0pJtM35MiXT3BWMOMf3uKcAeVfPWxU+oDcqDde66VphmlLuYrIwRDsth
 VEafIWMpojfaHVC08hv476ylvxHayfiS8kHaMBB5R51F9rFoxohMZFTiFAWhWGpEFxK5Ft6nH1l
 clesBGuQfvAi9uXZm/iUkO1md+vxYLHu9+QZlVPxENdvoQMSIocxVG3e6D31rQm/4fzgTZaEIJV
 kebBsM0KVCpO4QkEiBD9JCJK5XQLVbsmcrF6gi7PeX9maveQffmGVgX6GYMWM0hvFA3uvNMoYNb
 Kcy/F3RE186uh95VU8rFESRhooPcJj6GgctUK6i9JZ/Wjt1kN7bXYXTLhbzFWE2g7YL8NK12hNB
 Hq1gvVwYsWivsXdiTKUY9hqSS+ns2mXMXpMxBuvYATEWBMfcQBf8rs7lSnViT9o0niTJ8/waJR4
 /awKMaUV2XDEosS0NaOEBNN3ZFJl5Utke4LwgrUopYYTpFQHxb+xdYfxnn3pyDK4m3bjuQAR243
 4oS1HBAwlnN+SIVyTx3anOyjUsf0CcnnZ0CPcvY5ZkGY89ImZ7NuNWmjnCPcieMf42jOC29YE4o
 LMlRqqHHPtvmDWWwGlt1kqY4J91PxB9aHd/Ox1WUl/ftjFuH4x7kNiL4MOrTQPup0eDPoXDs2Ml
 omF+huHdvZZ6kwg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Symlink had a bunch of extra operations which essentially
end up discarded.  It was walking the fid to the new file and
creating an inode for it, but those semantics are part of
tsymlink.  This did prepopulate the cache, but that also seems
potentially unnecessary and frought with peril.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 981278d0788e..c435952f6355 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -690,7 +690,6 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	struct p9_qid qid;
-	struct inode *inode;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
 	struct v9fs_session_info *v9ses;
@@ -717,36 +716,6 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		/* Now walk from the parent so we can get an unopened fid. */
-		fid = p9_client_walk(dfid, 1, &name, 1);
-		if (IS_ERR(fid)) {
-			err = PTR_ERR(fid);
-			p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
-				 err);
-			goto error;
-		}
-
-		/* instantiate inode and assign the unopened fid to dentry */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_fid_add(dentry, &fid);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/* Not in cached mode. No need to populate inode with stat */
-		inode = v9fs_get_inode(dir->i_sb, S_IFLNK, 0);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			goto error;
-		}
-		d_instantiate(dentry, inode);
-	}
 
 error:
 	p9_fid_put(fid);

-- 
2.41.0

