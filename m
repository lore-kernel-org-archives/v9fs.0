Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CD74BEC
	for <v9fs@lists.linux.dev>; Thu, 29 Feb 2024 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245374; cv=none; b=mLfeCUwLE+th97VuCO5cuPuDCDHSb+BkeXeIU4pCe/Ldk5shOHpfz8qnDaFrrN5GD+/PkEx2j1xluqLJ8FhD1/5k+QjoXDaHR+uXuTxi476YqQXE2SIAjZ9KDq363kngp9lYnwPFFbdGZnnH6oLBlNZ1VPwL9dLklLjeJQoKcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245374; c=relaxed/simple;
	bh=fDlp2DkTK60nwwej8ZSAlANPrk7Fhs+s/d381rtEG2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mycX8DKqbJZ/oauZIEJjN01iLEksEe2/GHJR5GWdjjAqF3gvx9mbP9FoQ2XmRg7jDEBX717D6c0lYQqdbWbMF0qj+odIizSF0CQ4+uhD+ROdyustw6f6paXI6XH0vlhIVhHMO4jY2nfEh+xkvZ4m+LnloQBXeZ0+EV/P44M7uNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXx7XXpS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXx7XXpS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412b246b386so10662135e9.3
        for <v9fs@lists.linux.dev>; Thu, 29 Feb 2024 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245371; x=1709850171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FbmS0/vnMiN5O2ElDtKte3cIBv6R/kEmABEvMifW8o=;
        b=CXx7XXpSBmyPX4nd+m69SfmuU2dRyyT3kMkccl8hNclt4ztmHKL+/YMt6p5mbKX1T1
         k5yyfx2hfWGkJ/lXaHt6rZ2RoB+gzuYgTdRTTUnSzie5rEo2qS+Thif+kul0hrGup2aT
         8KAriFjYPyK3knVpyXdnBOIyV3LzY54rdurL3791tWXMwUyAdk5jgeYI9/I8DZZKln0+
         XZCzgl/p7EqtB7caP6zTC36XF99IXIIxq2CPX/bVMlsypjsJp8QuoDeVQP06TknfQN+v
         m7VFK5sNeYJvDKf7dxfvOGObjIakNWWLtWvHyoAF3Jsy6X+h+UTJfVOuDSMisnu0ClYC
         o8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245371; x=1709850171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FbmS0/vnMiN5O2ElDtKte3cIBv6R/kEmABEvMifW8o=;
        b=eQaCpu4FZSupuP5ba1Rlc6ehHLkqfmi16i3pU4WAYvBweUOoTJgd88v14Q6zIR4+5L
         eZ4JC39PQpkcv86/Ui2NtoXkCI+9mLZNhyHEisXKOgpn5tneRUaCjwYApnHTMTJZBFVE
         nY+Ikx3N85O8gAgKBeLpKvGB/0yLUM08Jfj8hiWSwKNvpw0NO3ZqIhqa3PgVRDeqrIJk
         UcrbF+D3w9Mo8f1ekrnfRauXnmjC6/4zu/kLZtvfbYRjs53DK0atHobEcFEQ9hFkVg1s
         E0z1gsVAe1gGSmB+Fa19DxA/DYmI+dOb+fUWBnkp9MXKxjcSqCHWM/pMPNzCNMlF3H55
         sxvg==
X-Forwarded-Encrypted: i=1; AJvYcCV1+T1Lf1O/SJN4sD7pUAambFtb1Y9iIeyLEb3ev3DsJvv1FT2GpFwJgBl+1mK/gZ70NeMOogPeugTVtU8A+CN0TXxi2g==
X-Gm-Message-State: AOJu0Ywj4HwDZJgevVoGbwNGeYJOSeGwsL+1Q142JR1aSMAyBC/xeQKO
	biVJs8lHceucM2zIeXs8bFIvTf7fO3Vz9gEklRhAtYe5HOY7SHTs
X-Google-Smtp-Source: AGHT+IHASHiTZs+NNiCu2DblsLo6+JIqLJKP5xMXLvjCOoQZJQJhsdB9l6fQCvYM3CjKlcJdLnyaHg==
X-Received: by 2002:a05:600c:538a:b0:412:b767:7d5c with SMTP id hg10-20020a05600c538a00b00412b7677d5cmr7798wmb.14.1709245371252;
        Thu, 29 Feb 2024 14:22:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcb8d000000b0033ce06c303csm2815325wrh.40.2024.02.29.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:22:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/9p: remove redundant pointer v9ses
Date: Thu, 29 Feb 2024 22:22:50 +0000
Message-Id: <20240229222250.351322-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pointer v9ses is being assigned the value from the return of inlined
function v9fs_inode2v9ses (which just returns inode->i_sb->s_fs_info).
The pointer is not used after the assignment, so the variable is
redundant and can be removed.

Cleans up clang scan warnings such as:
fs/9p/vfs_inode_dotl.c:300:28: warning: variable 'v9ses' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/9p/vfs_inode_dotl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..7af27ba1c25d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,7 +297,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       umode_t omode)
 {
 	int err;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -307,7 +306,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	v9ses = v9fs_inode2v9ses(dir);
 
 	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -739,7 +737,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -749,7 +746,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 
-	v9ses = v9fs_inode2v9ses(dir);
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err = PTR_ERR(dfid);
-- 
2.39.2

