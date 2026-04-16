Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A823384237
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330290; cv=none; b=V7mO/Sd0DgNmEPQ5ELKBSUF3vItKlQcHMgfe38m9wdS8fZLOCJu7/T1CYLVhmc5z6G1y36dWhwP/s6ConYx4Y3xVRlfLCQO2d6l+ACsdFZzK/PVmuC01BXPaO+NzTZcmYMD0MNRZOKyUNFiDPC0YwnXz8y2xv9J94WnRqSYCogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330290; c=relaxed/simple;
	bh=xFADogH/29XnzhsKtl5h1vUcQsc5r6HbJAkKVcssRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx4yN9zVMI54ov+qyyK0E7Iq2n/kFhtEfYnf7tHK5zLlzO90/EH5d4FcTeGTU77q1qlyAY4XGXglJtfuZ5uU1dRd4ErNXBqc+Y6isM6oA7brezdtsRwXz+8v8Gan07D80+OVmJGeP0NkgOF1bM4nWX9+UkdA7EvX/QF0x4LqaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B43Q+rib; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B43Q+rib"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so6041112f8f.2
        for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776330285; x=1776935085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4l6MiEafYZbPelSJ82SM6IlDLYy9fabNTGo/9W+w4k=;
        b=B43Q+ribDOHR8FjZAeupJxBoyCD7Cyzt16V5MxDvowffsuLVIzj5rXc3qJlIfomY4e
         zoI2kEcjjum8PjpFsiV5Cw273ht73YJaKASnPbCJRIQcyd2z8lz3wiaV0aGtXGOaU+L1
         4Tbd7ItnBIyQaOThO9Ko7MTVje9ABv+j23jeRV5GFkrttoRAcbWwc/7OBS+BR4EuWi+3
         gwt1zquPhPEOlz1fyBDCxug//5mA5QsfRvkcCFt7/GWbpc2c9A4h3iH+SMpdgYskfExd
         aqTx9BO395dRNy3/V3IXQ6u+yvkwFmEVwIKvS1Eymwoc0JfyvgKIIEWwcB9OR01aTfc3
         v/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330285; x=1776935085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4l6MiEafYZbPelSJ82SM6IlDLYy9fabNTGo/9W+w4k=;
        b=DgrBDxvJZpCxlczNwtqnaTPh2oP4CS/BGBgVjvkfsvfRn28/8hqfMvqzIGcUc0Oj6N
         LhiwaUV1I4NB8efdKcz55DZtCwDMstlyk2zW/YyapBPsfBVgcJ2mN3Oy/K4nsUCt+yxB
         QNCju9V9e9QXZ30mSXOcycaIHmyefjDh42HV85CruG+vTONCCnuFUQg/zGQvKRLwaXNZ
         emp6tnzbKCGYZvMSSqhzbfqf/IgNazI/HsDYRbj0XscEb7u8CyLQk93o17wt79Nox1Xf
         yh+AjyjWPBNSsjDKgdHvbNSAYHDPQoDcJmf7U9Knz4Pui1kpkuUVeZCle01uU4RItbwF
         6Rqg==
X-Forwarded-Encrypted: i=1; AFNElJ/giq3kxbmpF7iAkbxMvnPUOlHMVbSrSK+SuZ3E+QJvxqnSB3DXQBSmFB7qvszmwgHBBPFe@lists.linux.dev
X-Gm-Message-State: AOJu0YwIOrg/23+Ib5cjDgYoyhLNLSaqX4VAEr3ALw/rWVWRkaJHGMlx
	anDYMZXvOz38tTzvou7cIG9OKj9Q4Xz00tBmc+RvS9vkgG98CptB4WWc
X-Gm-Gg: AeBDievL0r+ikPqEf2F5jGLi9AbYI/4l1nlcX6t/d7DexTSb24uQTI5Hyqeh2JAyZwP
	KKa0P+3JUKgjxXqG99pFGqom7RxHDY5ILeUPttPK3ay3J1wnsnv2FC6C9qrafrYBfqYduniR8+c
	77cg1l5nXdCK0ZpEEH1IId0J8xLGxVWGXyK5pp4Z8/tKcvuDO05mEbXaztvlgi4rQ156uYdzymn
	mMI/zECIP9CeWRZJGsnR1+FlJeLq04Ow/YujaxXO0+ham8tztKsOOQcxTd5H1mR80q6bO0xPNss
	JVmo5vLNpt51PkHYquRMUoQyTYE3dLcEoyvMgodBvCHNTXkMQXEvTD4PTskNmRA0hUvKTaT64Zo
	b4ZjeZMSJM93COAi9Q7b+ETqxNMPe6+jjviv1iprZ/5rcic5Qpb1nOfeXS2EgYRpJoFSzX9Ki4R
	9rvp+5mzmAnK4UHruW8Tr62j7pLmtKlH6M11ngw2+5yBuhDAFbDBCYiWIEWh1NMoP8f/Vmbc025
	lVvoNsBInl6V94fUOPFhqDf
X-Received: by 2002:a5d:5d0b:0:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-43d642a7a61mr38001620f8f.28.1776330285188;
        Thu, 16 Apr 2026 02:04:45 -0700 (PDT)
Received: from localhost.localdomain ([212.154.124.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebd38sm12565221f8f.31.2026.04.16.02.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 02:04:44 -0700 (PDT)
From: Baran Arda <baran9arda@gmail.com>
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baran Arda <baran9arda@gmail.com>
Subject: [PATCH v2] fs/9p: remove unnecessary extern keywords from function prototypes
Date: Thu, 16 Apr 2026 12:04:38 +0300
Message-ID: <20260416090438.42844-1-baran9arda@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aeBOjl59tgjvGkU1@codewreck.org>
References: <aeBOjl59tgjvGkU1@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dominique,

Thank you for your feedback. In this second version, I have removed the 'extern' keywords only from function prototypes.

I understand this is a minor cleanup, but it is my first contribution to the Linux kernel and I am excited to learn the process. I appreciate your time and effort in reviewing this.

Best regards,
Baran Arda

fs/9p: remove unnecessary extern keywords from function prototypes

Remove explicit extern keywords from function prototypes in 9p
header files. This cleans up the code in accordance with the
kernel coding style.

Signed-off-by: Baran Arda <baran9arda@gmail.com>
---
v2:
- Restored 'extern' keywords for variables as requested by maintainers.
- Only modified function prototypes in this version.

 fs/9p/cache.h |  6 +++---
 fs/9p/v9fs.h  | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index ee1b6b06a2fd..25f0dd58122e 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -11,10 +11,10 @@
 #ifdef CONFIG_9P_FSCACHE
 #include <linux/fscache.h>
 
-extern int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
-					  const char *dev_name);
+int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
+					const char *dev_name);
 
-extern void v9fs_cache_inode_get_cookie(struct inode *inode);
+void v9fs_cache_inode_get_cookie(struct inode *inode);
 
 #else /* CONFIG_9P_FSCACHE */
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6a12445d3858..2d37505704a9 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -168,30 +168,30 @@ static inline struct fscache_volume *v9fs_session_cache(struct v9fs_session_info
 
 extern const struct fs_parameter_spec v9fs_param_spec[];
 
-extern int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param);
-extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
+int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param);
+int v9fs_show_options(struct seq_file *m, struct dentry *root);
 
 struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 				 struct fs_context *fc);
-extern void v9fs_session_close(struct v9fs_session_info *v9ses);
-extern void v9fs_session_cancel(struct v9fs_session_info *v9ses);
-extern void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses);
-extern struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
-				      unsigned int flags);
-extern int v9fs_vfs_unlink(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rmdir(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
+void v9fs_session_close(struct v9fs_session_info *v9ses);
+void v9fs_session_cancel(struct v9fs_session_info *v9ses);
+void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses);
+struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
+			      unsigned int flags);
+int v9fs_vfs_unlink(struct inode *i, struct dentry *d);
+int v9fs_vfs_rmdir(struct inode *i, struct dentry *d);
+int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
-extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
+struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
 					 struct p9_fid *fid,
 					 struct super_block *sb, int new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
-extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
+struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 					      struct p9_fid *fid,
 					      struct super_block *sb, int new);
 


