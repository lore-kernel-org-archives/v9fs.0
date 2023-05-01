Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A833E6
	for <v9fs@lists.linux.dev>; Mon,  1 May 2023 19:06:19 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-74d2597fdb2so119971185a.2
        for <v9fs@lists.linux.dev>; Mon, 01 May 2023 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967978; x=1685559978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7SjFUEVHFEjNXjqk3Wy4WFYpwQq7tXRNuaA2WillKc=;
        b=qwmwpYuP3xJ5FM+y+ACsPfCdOO8roj6KCkX910r3xQCCDNB97gVQgj+ELmYPvVkL/7
         RrTK30prgoCHSUlLvbOIsVHh7eOGhigLXhKRJ3tO0PqkzKA2eZpM68o71hHQ+IItwzff
         e7DlmC+daNuiKB//KopiCzWx9tUvQVIAmX1REGR6EiU82MkSLkFeD/3r9/TDQ74tWZSv
         tEX6APB86Fb/Np4x0eIDA1qLprguHcdCEc3VUlJ/0ThofuXK8MrFeuGP7MFg3PziJJc1
         oGdVw+6lqPFJ11IiBnJv/rpayHkPDP1lHSFAMp42KlUYqkeozj3MSLUF8zY9ttCc13Go
         SS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967978; x=1685559978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7SjFUEVHFEjNXjqk3Wy4WFYpwQq7tXRNuaA2WillKc=;
        b=BXBoJJLRBZMY9tBzgZRnLEMl1qVaRwEIWBsHVPkhh7UTSD3lsqqj8TQtpk3M4xpnHP
         QmHEWrflCYysLeYwIEfVg8woChZ5VFUjMBkD3OHTLR177GYX+4aZK5/7ZIUHqHfMQEFS
         twIUV2RMu4eDmGBPKyHfMEUMmIHlp7KP1w9NbgFS2/sD2uEZ7f+Vp5Io8u+zYb2r8Y3V
         5WsxyyjZ2lW1+BPW2MDpedYpjjaBjFvyDJ5lKpfrFXd6lSVBXkhg05eq4EBeAqZGO+WE
         MlqLp+bm9ceYZjIgWIV7WL/Uvz1nG0a0Jk6A4kAF8MoM5OZcVYlpgkSgzWgZpOY6bstI
         Us8g==
X-Gm-Message-State: AC+VfDzK/mwkS1/9b0LBCv0enq7J8Uf8zr0rohLs0KnDGX4TCQZsBDXZ
	sWzcYiO3q9dVvj1eZ2A0R8kh60ll17w=
X-Google-Smtp-Source: ACHHUZ7xIwiZkmlPBcLiddlfv4WObvEczwG21UftYy8+tFHEyD8EmHDM/h9Hd/lsgrr2BarWWtut7g==
X-Received: by 2002:a05:6214:5019:b0:619:ca55:970a with SMTP id jo25-20020a056214501900b00619ca55970amr1613558qvb.47.1682967978378;
        Mon, 01 May 2023 12:06:18 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id g7-20020a0ce4c7000000b005dd8b9345casm8918208qvm.98.2023.05.01.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:06:15 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Jason Andryuk <jandryuk@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/9p: Remove INET dependency
Date: Mon,  1 May 2023 15:06:00 -0400
Message-Id: <20230501190602.86281-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

9pfs can run over assorted transports, so it doesn't have an INET
dependency.  Drop it and remove the includes of linux/inet.h.

This allows configuring 9pfs over Xen with INET disabled.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 fs/9p/Kconfig          | 2 +-
 fs/9p/vfs_addr.c       | 1 -
 fs/9p/vfs_dentry.c     | 1 -
 fs/9p/vfs_dir.c        | 1 -
 fs/9p/vfs_file.c       | 1 -
 fs/9p/vfs_inode.c      | 1 -
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/9p/vfs_super.c      | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index d7bc93447c85..0c63df574ee7 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config 9P_FS
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
-	depends on INET && NET_9P
+	depends on NET_9P
 	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 6f46d7e4c750..425956eb9fde 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -12,7 +12,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/pagemap.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 65fa2df5e49b..f16f73581634 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 3d74b04fe0de..52bf87934650 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -13,7 +13,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/sched.h>
-#include <linux/inet.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/fscache.h>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 44c15eb2b908..367a851eaa82 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -14,7 +14,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>
 #include <linux/utsname.h>
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1d523bec0a94..502ac74e4959 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 331ed60d8fcb..a7da49906d99 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 266c4693e20c..10449994a972 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -12,7 +12,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/sched.h>
-- 
2.40.0

