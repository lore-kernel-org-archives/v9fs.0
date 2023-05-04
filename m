Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7111C95
	for <v9fs@lists.linux.dev>; Thu,  4 May 2023 19:47:31 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-61cd6191a62so4281686d6.3
        for <v9fs@lists.linux.dev>; Thu, 04 May 2023 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683229650; x=1685821650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VXMMoQpmmLLTqAMK/HVD6CSjpNQIit8KTC+MR0S3So=;
        b=kC+uuqSY01yFv7otF/TCzd5ztxBa3KWC+PzsGqMUr+4fuCZYgDUbctV5Vu8D8kbpaI
         QCJBlq3XnAHiRV8eGxrg/lHtwErOvEck6ejQNn8yek0DFvCPnwQN0shWSe2iswQ28Tz0
         S9VQRisxTkJfiqZxi+QBeYqXw3UR5MPLoFQMgQoENRQBG9t7KD0wrOzLHHVGCmwmoDf3
         QlUSBzA7NWmuW3tLOcPgycXjLZ8/V6AqMpESI5hrfvPeAjVyjhRORMYtyQRDMaKaDyZv
         IIPeEP6XfQKRH4X/Tiy+rjefrVruq9O5+7Q+WlSqXJ22b9vRvrlrn1rl7Tkc6+8VgLET
         Lzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229650; x=1685821650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VXMMoQpmmLLTqAMK/HVD6CSjpNQIit8KTC+MR0S3So=;
        b=JUfEDnP1WjWoWWoi96JkD1vC74lq/pPJtBqtoKzbeyUqGHAMhtMpQ1awjj4MYbuUw4
         WjYhJUw1ejxwT5tOMpS9LOyShL6lp0GSZWtL0jwdrqoSGol6FbOn4OCV1o2zYwOzsjjo
         vJ06GCkse8a9b96O6geIN2yYLrt0ww88nmgbKyBx2G1huRJ0xoy91SlQs89Csww3qttq
         TK9TQtZkJ2lKFj8dV3OQs8jM3Gs32qUChaym45ArjIEwbXV5XmvDX61ilqErkBJmYkH0
         HtJLkwvyC+80UNX+LYuOPhQd3qmVOnjulteuJraiXQ2roY/YX5+i692/uGpiSb4Ap/Zv
         pP0A==
X-Gm-Message-State: AC+VfDxMmSwL+Em9UoW7IUCkypYchxI4sUeDd6CQNgzd/MsRPfa3e0KZ
	MMpXxF1eIWwnHl72NIE6l7s=
X-Google-Smtp-Source: ACHHUZ4uWSbbxncNGTC0bS6QLcwxmysVOskKXs82cMchY6pJ8W2C2JSPuNmQJKbRNVwTySact/rF3Q==
X-Received: by 2002:a05:6214:1307:b0:5ef:4ecb:cf9d with SMTP id pn7-20020a056214130700b005ef4ecbcf9dmr19293065qvb.6.1683229650575;
        Thu, 04 May 2023 12:47:30 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id k12-20020a0cf58c000000b0061eaef8ff84sm354723qvm.28.2023.05.04.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:47:29 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Jason Andryuk <jandryuk@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] 9p: Remove INET dependency
Date: Thu,  4 May 2023 15:47:23 -0400
Message-Id: <20230504194725.546460-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

9pfs can run over assorted transports, so it doesn't have an INET
dependency.  Drop it and remove the includes of linux/inet.h.

NET_9P_FD/trans_fd.o builds without INET or UNIX and is usable over
plain file descriptors.  However, tcp and unix functionality is still
built and would generate runtime failures if used.  Add imply INET and
UNIX to NET_9P_FD, so functionality is enabled by default but can still
be explicitly disabled.

This allows configuring 9pfs over Xen with INET and UNIX disabled.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v3
s/unusable/usable/

v2
Add imply INET and UNIX
---
 fs/9p/Kconfig          | 2 +-
 fs/9p/vfs_addr.c       | 1 -
 fs/9p/vfs_dentry.c     | 1 -
 fs/9p/vfs_dir.c        | 1 -
 fs/9p/vfs_file.c       | 1 -
 fs/9p/vfs_inode.c      | 1 -
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/9p/vfs_super.c      | 1 -
 net/9p/Kconfig         | 2 ++
 9 files changed, 3 insertions(+), 8 deletions(-)

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
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index deabbd376cb1..00ebce9e5a65 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -17,6 +17,8 @@ if NET_9P
 
 config NET_9P_FD
 	default NET_9P
+	imply INET
+	imply UNIX
 	tristate "9P FD Transport"
 	help
 	  This builds support for transports over TCP, Unix sockets and
-- 
2.40.1

