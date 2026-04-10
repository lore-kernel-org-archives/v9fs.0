Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D237F8B1
	for <v9fs@lists.linux.dev>; Fri, 10 Apr 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852821; cv=none; b=H3j1iKFxDa+HiquR2STT+iYx06t6c0bedVySRQVfdE3OGOGRRUWoGVGEkWBRfgx4rL4f35SWQOMw5O8PXyt9EonqZBf/WbSzhp8f029vtHkA1kPRagKfGDOMU2Z8tDZTKcqNASY3Y21VyTXVYw7exlg0Q2bIK09HXGmekAniOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852821; c=relaxed/simple;
	bh=WV6rS5mHsYIoscMOpj3AODRzSoktaNgVJ0h1MK2nX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQtkhUMMVcaF37Sa+1hO2XoDqQuhZxVfeEyQQzwvSFPcDPXA/cwahOwUDucn8VIeomm7rTwP9Wua/IQewZcjYoxF7smOlGWVf5oHaw1+y3Kjs5Hcd1jSTjLymTJXJ7o9SbjQ2GW2NpOAykVE2vSJ75Q0lwnJ5a6qe0M2Pse3dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3m5hEuE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3m5hEuE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso35996585e9.3
        for <v9fs@lists.linux.dev>; Fri, 10 Apr 2026 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775852817; x=1776457617; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYy1fnWTcRZBMXRzE8Qr9b3HU+y64sqLNj7mMpB6ZxQ=;
        b=q3m5hEuEqX4ZRmnOmzucErfegEHvAvquD7wA9X1HizNrC5/bdXPv3RJXE+i+ofjeFV
         fDoHAEOg0Xeg5bNwWu5l/6MxEyE8CQaDrbj+49FAYYnahqrDNjq7E3B1ltqgftRFPjq+
         ch3ElHVDdrVCZxi5/JIfeI5NQAcPg/P2ze0Fb5hTZV9yXwU0/SdlDcXvq2KHbiBAH1DE
         zQtH89whGInM5eIyblsxtTofVxYiPcvU4OXlUh9Uwy8f6l9KrZ/jUF/KexGotzDUSWRT
         UMeFF3o1NETBpz83okP83wFfjNKHtl81jfggIFh66Af79jf3AUeRTNNZUdfU/AF3Ghtz
         C4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775852817; x=1776457617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYy1fnWTcRZBMXRzE8Qr9b3HU+y64sqLNj7mMpB6ZxQ=;
        b=nZPesj/aqvsUg9wvt9KSiibFmEEGWDFL5xIuXeEskhJJmpYxLuwqnp8uSiOxX5HBqG
         TgPc5eFSvVJk+nSXwS6Z3co8SMTTUHkWhkchR7fCrpiuMjaROggyDzQlUZt5Oh9GsO/n
         yVZU6Njml2v5s/w8Jr/WqERppJ7ZXtiuvIRsjRzgmc4p/oalgjv46xnaKZN3N7PFcRnR
         dAvYdRsp2hUIB/fCnkW54kxq56YgitZhz564SKQLsyeYRXj5Xqcaejzh8S3T7e+Her8l
         N24dtkwHeoVPXG5O0+t3MuX9LQC2EYGp/NdHJNnLBqMxAvLNcKeRYq5uoQOVdVCJiiL9
         ce6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdePJ0cDZ8hyBLaO5peCOa3zuZ26vkkRXCovOneTfl3wtJUWE6sEAS7FsKbSIoeC0m5bze@lists.linux.dev
X-Gm-Message-State: AOJu0Yy15ZUUFnhZflUUD59rU9HQgk0A0bH5flOTpJdIlCODSuAKH5RM
	12lypRrDZzS3oAXgIpyIWlqtM8ZKm28x87ZWcq4TtiAHqJXGedzp//G+
X-Gm-Gg: AeBDievdDaASFuUCKuB1SNYSXJStaHDnVhacvJ2UvxjNsSQjFD+b60F0vL1RWc8J6gO
	m0kxf24GvIKvKxFjcYb2ay13uwMC51r+o4ved2YufgAgzaAJeyeY6+4uNic0ABLR3+YGxkbfxQ7
	WhkvqwxlB1YKmWaQduaY0vruW3czXzmVM/2f0XgWlqoiy/shqg2Ed+dCV5Isk9BaUlhCjiTIK3v
	PRYMY4+SRiZVWxti01qQ7ycB31EQxAOlPQQJYYI/IFSvtoqQoWeozi7re5EP+oxwOH+cs7CeMn2
	JwYy2d3x5UZgC0+0UwbgIXl4TddHhh3eynllOxEVxcABEHdIhrJ581tkmKvJXHUzBrOGqLUolzy
	d7lNkYVdAzfkXzut5thAOfr2fByTYhYSMrVlCgPNXw2VtsVKw+N8sZv4bdCj0NnoQ5P4RRoosA8
	bZ8qFNwk1RSHf8XYqtYPA/Lz/Ez/NVPcukT/qnEPj6uOGVQCL3Jh/WyxlLioMoJ6Sfco3E73Gdb
	5nTVBk3mHQ=
X-Received: by 2002:a05:600c:a311:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488d68607fbmr46331985e9.20.1775852816617;
        Fri, 10 Apr 2026 13:26:56 -0700 (PDT)
Received: from localhost.localdomain ([31.206.191.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm131909295e9.3.2026.04.10.13.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 13:26:56 -0700 (PDT)
From: Baran Arda <baran9arda@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baran Arda <baran9arda@gmail.com>
Subject: [PATCH] fs/9p: remove unnecessary extern keywords from header files
Date: Fri, 10 Apr 2026 23:26:51 +0300
Message-ID: <20260410202651.60818-1-baran9arda@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove explicit extern keywords from function prototypes in 9p
header files.

Signed-off-by: Baran Arda <baran9arda@gmail.com>
---
 fs/9p/cache.h    |  6 +++---
 fs/9p/v9fs.h     | 32 ++++++++++++++++----------------
 fs/9p/v9fs_vfs.h | 18 +++++++++---------
 fs/9p/xattr.h    |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

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
index 6a12445d3858..cd58acdd3fb5 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -166,32 +166,32 @@ static inline struct fscache_volume *v9fs_session_cache(struct v9fs_session_info
 #endif
 }
 
-extern const struct fs_parameter_spec v9fs_param_spec[];
+const struct fs_parameter_spec v9fs_param_spec[];
 
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
+void v9fs_session_close(struct v9fs_session_info *v9ses);
+void v9fs_session_cancel(struct v9fs_session_info *v9ses);
+void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses);
+struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 				      unsigned int flags);
-extern int v9fs_vfs_unlink(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rmdir(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
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
-extern const struct inode_operations v9fs_dir_inode_operations_dotl;
-extern const struct inode_operations v9fs_file_inode_operations_dotl;
-extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
-extern const struct netfs_request_ops v9fs_req_ops;
-extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
+const struct inode_operations v9fs_dir_inode_operations_dotl;
+const struct inode_operations v9fs_file_inode_operations_dotl;
+const struct inode_operations v9fs_symlink_inode_operations_dotl;
+const struct netfs_request_ops v9fs_req_ops;
+struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 					      struct p9_fid *fid,
 					      struct super_block *sb, int new);
 
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index d3aefbec4de6..a8f09063e0d1 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -28,15 +28,15 @@
 /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
 #define V9FS_STAT2INODE_KEEP_ISIZE 1
 
-extern struct file_system_type v9fs_fs_type;
-extern const struct address_space_operations v9fs_addr_operations;
-extern const struct file_operations v9fs_file_operations;
-extern const struct file_operations v9fs_file_operations_dotl;
-extern const struct file_operations v9fs_dir_operations;
-extern const struct file_operations v9fs_dir_operations_dotl;
-extern const struct dentry_operations v9fs_dentry_operations;
-extern const struct dentry_operations v9fs_cached_dentry_operations;
-extern struct kmem_cache *v9fs_inode_cache;
+struct file_system_type v9fs_fs_type;
+const struct address_space_operations v9fs_addr_operations;
+const struct file_operations v9fs_file_operations;
+const struct file_operations v9fs_file_operations_dotl;
+const struct file_operations v9fs_dir_operations;
+const struct file_operations v9fs_dir_operations_dotl;
+const struct dentry_operations v9fs_dentry_operations;
+const struct dentry_operations v9fs_cached_dentry_operations;
+struct kmem_cache *v9fs_inode_cache;
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
diff --git a/fs/9p/xattr.h b/fs/9p/xattr.h
index 3ad5a802352a..ffba83163400 100644
--- a/fs/9p/xattr.h
+++ b/fs/9p/xattr.h
@@ -10,7 +10,7 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
-extern const struct xattr_handler * const v9fs_xattr_handlers[];
+const struct xattr_handler * const v9fs_xattr_handlers[];
 
 ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 			   void *buffer, size_t buffer_size);
-- 
2.50.1 (Apple Git-155)

