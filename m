Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30A2E4980
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903526; cv=none; b=YPTuS+z+tn8mYiqQTy80BFaUv78UYyf6GvMx3gUPjJy95VKDFcKO8REiuEKmG6JXS1mFnjiQwyw3sfrOazthMCnQsjwWD7BjM72YWun4ClPKZzq+mYboXBWJ5uiIxasHJ8ZJ26vVFs57BMWHXPr9iPB+4P7En0w3PMjAqRcFmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903526; c=relaxed/simple;
	bh=oiDgcYvrvT3546D/e9Vrs7slw1MEQeieAZNTId0DvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pmKcG4wJTDINY0tWWVPr6EKHVEco9JcWbokxvwkDgfvDPizlJepUIZyXuqLcGwQuVEwIg20ME/C+ZY+zz7UfyB3RwnSIc+tL9a6ftr62Oi9CrWYaL0LG62Pc9KbCrS6yHZNugxisTSv85dbGWcI6rkfZywnSiOvgBSqjKTG5v08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cC7Ideg7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC7Ideg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN+Bsu6yDWhJfBeAZ05eJQtu7vjCbJLVMgwwvykiSxw=;
	b=cC7Ideg7OtivVZf955TxLXGEeweWaxH55oRF0W0o+zyQFZlfoR785BMYZtQeAzOnTUQCvr
	5v41mkzM+f4Lnl2X0X4fvf3nPHaKCOPDc0rS8zjwLFAmgfL4msbfWXH5EkuHOVWNX0qTAh
	LveZVavMZ4IjBpIXviHSPABk375jGnM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-CjV7uMxuPtmYo5zWipU-IA-1; Wed, 30 Jul 2025 15:25:21 -0400
X-MC-Unique: CjV7uMxuPtmYo5zWipU-IA-1
X-Mimecast-MFC-AGG-ID: CjV7uMxuPtmYo5zWipU-IA_1753903520
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso20662639f.2
        for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 12:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903520; x=1754508320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN+Bsu6yDWhJfBeAZ05eJQtu7vjCbJLVMgwwvykiSxw=;
        b=GuyWimIafRRq9T6yDNLS5/+N5yR17gtZZ3Yw1V7Ofhpt6Ve6sHRUXE+dY433MAIHlJ
         pVd2Zvt++7vukfQG7OKH7T02TX2eafjMwJ3qTR/CMkZBAVwHpgUiJzR+DTSm/0+Ttc/A
         Pp00jr4CzW50iPWn6REouKpeZJ1P36eybLiCQDz9ARp1JgZWkGiMd78NRbJuuX+TqGEb
         T6CpDAna39/XzmNArcYUhTJJohMsnnWWIWM2ZkUQMIou8xdgSACC43fZZW+7Jk9lbFHL
         Uzx5hyFo2Y53oSyiKN0nbwTneNMmDWh1nK7GIFWiaKDl+uMoF+gNsB5K1Fh9yyRPnnoW
         w0og==
X-Gm-Message-State: AOJu0Yyi+/mY2niR5nHfGsepBNC2Cwrw414fWf+lz+8pE2MqvgcDpFcL
	dTshbNEYAnz/+UzIoki/rtiusma8s6oEcmWajjTLhdrUYKDhQdSMBYdFQ8jvCW0rFNWLPhtFFDR
	zHLPMgpZIKS6AUhq84zJtQ1z81h54bWaH+vSagsquQHxtxVLuo4bzDjs/Ui7Ces6618s2s54Joy
	VW827wVEMz8RcUdv5KzSThvrpFoZN4HiybV+zXgjq9QYs=
X-Gm-Gg: ASbGncud6Jt0G7u+jstCdYSs5oRktOj7RRwur8HG+rqiS8/Tx7AG4i1nenKEkEYDeSW
	JhP6Q3/d1kxxwH+w4xRT6/jX+N4WP89Rt8lx8HvSYs7YDg0efqiV/Q9gqa6HYbA5xlybhWzTv+Q
	rCrJaf1jbqwZ2PCPYVd5k7SbBrM7lpNRwU7hNbYhvij4v7BOZQjuT5aJKCiFxoZ5neJtIpcFniM
	99PitzUbqHpGr0WGXTQpnJaRmX78UBWhorubPaXWh9pwTiIJFKwOnhW5px3Rki2O44GH+GgTxsg
	dC/f+ad5vLeXVedesKaP99OgeLD/7liVTX9cHcj0orDN
X-Received: by 2002:a05:6602:14d3:b0:864:a228:92b4 with SMTP id ca18e2360f4ac-8813784e7bbmr822131739f.7.1753903520081;
        Wed, 30 Jul 2025 12:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZYPSSDTAvY/+0VmiQLnw0juAojPkb1HQxRSFH8oVfqkYBIsihewSMn+/6GqJT1s5ZvDE0RA==
X-Received: by 2002:a05:6602:14d3:b0:864:a228:92b4 with SMTP id ca18e2360f4ac-8813784e7bbmr822125239f.7.1753903519576;
        Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 3/4] 9p: create a v9fs_context structure to hold parsed options
Date: Wed, 30 Jul 2025 14:18:54 -0500
Message-ID: <20250730192511.2161333-4-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gMWB1dzZnt3euNgMUZ13oxdtkhfPqRBzx4QyqRGvwGQ_1753903520
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch creates a new v9fs_context structure which includes
v9fs_session_info as well as p9_client, p9_fd_opts, and p9_rdma_opts
to hold all parsed options. The new structure will be used in the next
commit to pass all parsed options to the appropriate transports.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/9p/cache.c              |  1 +
 fs/9p/v9fs.h               | 49 ---------------------
 include/net/9p/client.h    | 88 ++++++++++++++++++++++++++++++++++++++
 include/net/9p/transport.h | 32 --------------
 4 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 12c0ae29f185..1def4dec1dcc 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <net/9p/9p.h>
+#include <net/9p/client.h>
 
 #include "v9fs.h"
 #include "cache.h"
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..4b8834daec8d 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -81,55 +81,6 @@ enum p9_cache_bits {
 	CACHE_FSCACHE       = 0b10000000,
 };
 
-/**
- * struct v9fs_session_info - per-instance session information
- * @flags: session options of type &p9_session_flags
- * @nodev: set to 1 to disable device mapping
- * @debug: debug level
- * @afid: authentication handle
- * @cache: cache mode of type &p9_cache_bits
- * @cachetag: the tag of the cache associated with this session
- * @fscache: session cookie associated with FS-Cache
- * @uname: string user name to mount hierarchy as
- * @aname: mount specifier for remote hierarchy
- * @maxdata: maximum data to be sent/recvd per protocol message
- * @dfltuid: default numeric userid to mount hierarchy as
- * @dfltgid: default numeric groupid to mount hierarchy as
- * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
- * @clnt: reference to 9P network client instantiated for this session
- * @slist: reference to list of registered 9p sessions
- *
- * This structure holds state for each session instance established during
- * a sys_mount() .
- *
- * Bugs: there seems to be a lot of state which could be condensed and/or
- * removed.
- */
-
-struct v9fs_session_info {
-	/* options */
-	unsigned int flags;
-	unsigned char nodev;
-	unsigned short debug;
-	unsigned int afid;
-	unsigned int cache;
-#ifdef CONFIG_9P_FSCACHE
-	char *cachetag;
-	struct fscache_volume *fscache;
-#endif
-
-	char *uname;		/* user name to mount as */
-	char *aname;		/* name of remote hierarchy being mounted */
-	unsigned int maxdata;	/* max data for client interface */
-	kuid_t dfltuid;		/* default uid/muid for legacy support */
-	kgid_t dfltgid;		/* default gid for legacy support */
-	kuid_t uid;		/* if ACCESS_SINGLE, the uid that has access */
-	struct p9_client *clnt;	/* 9p client */
-	struct list_head slist; /* list of sessions registered with v9fs */
-	struct rw_semaphore rename_sem;
-	long session_lock_timeout; /* retry interval for blocking locks */
-};
-
 /* cache_validity flags */
 #define V9FS_INO_INVALID_ATTR 0x01
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 2d46f8017bd5..33b8d9a79fa7 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -132,6 +132,94 @@ struct p9_client {
 	char name[__NEW_UTS_LEN + 1];
 };
 
+/**
+ * struct p9_fd_opts - per-transport options for fd transport
+ * @rfd: file descriptor for reading (trans=fd)
+ * @wfd: file descriptor for writing (trans=fd)
+ * @port: port to connect to (trans=tcp)
+ * @privport: port is privileged
+ */
+
+struct p9_fd_opts {
+	int rfd;
+	int wfd;
+	u16 port;
+	bool privport;
+};
+
+/**
+ * struct p9_rdma_opts - Collection of mount options for rdma transport
+ * @port: port of connection
+ * @privport: Whether a privileged port may be used
+ * @sq_depth: The requested depth of the SQ. This really doesn't need
+ * to be any deeper than the number of threads used in the client
+ * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
+ * @timeout: Time to wait in msecs for CM events
+ */
+struct p9_rdma_opts {
+	short port;
+	bool privport;
+	int sq_depth;
+	int rq_depth;
+	long timeout;
+};
+
+/**
+ * struct v9fs_session_info - per-instance session information
+ * @flags: session options of type &p9_session_flags
+ * @nodev: set to 1 to disable device mapping
+ * @debug: debug level
+ * @afid: authentication handle
+ * @cache: cache mode of type &p9_cache_bits
+ * @cachetag: the tag of the cache associated with this session
+ * @fscache: session cookie associated with FS-Cache
+ * @uname: string user name to mount hierarchy as
+ * @aname: mount specifier for remote hierarchy
+ * @maxdata: maximum data to be sent/recvd per protocol message
+ * @dfltuid: default numeric userid to mount hierarchy as
+ * @dfltgid: default numeric groupid to mount hierarchy as
+ * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
+ * @clnt: reference to 9P network client instantiated for this session
+ * @slist: reference to list of registered 9p sessions
+ *
+ * This structure holds state for each session instance established during
+ * a sys_mount() .
+ *
+ * Bugs: there seems to be a lot of state which could be condensed and/or
+ * removed.
+ */
+struct v9fs_session_info {
+	/* options */
+	unsigned int flags;
+	unsigned char nodev;
+	unsigned short debug;
+	unsigned int afid;
+	unsigned int cache;
+#ifdef CONFIG_9P_FSCACHE
+	char *cachetag;
+	struct fscache_volume *fscache;
+#endif
+
+	char *uname;		/* user name to mount as */
+	char *aname;		/* name of remote hierarchy being mounted */
+	unsigned int maxdata;	/* max data for client interface */
+	kuid_t dfltuid;		/* default uid/muid for legacy support */
+	kgid_t dfltgid;		/* default gid for legacy support */
+	kuid_t uid;		/* if ACCESS_SINGLE, the uid that has access */
+	struct p9_client *clnt;	/* 9p client */
+	struct list_head slist; /* list of sessions registered with v9fs */
+	struct rw_semaphore rename_sem;
+	long session_lock_timeout; /* retry interval for blocking locks */
+};
+
+/* Used by mount API to store parsed mount options */
+struct v9fs_context {
+	struct p9_client	client_opts;
+	struct p9_fd_opts	fd_opts;
+	struct p9_rdma_opts	rdma_opts;
+	struct v9fs_session_info v9ses;
+};
+
 /**
  * struct p9_fid - file system entity handle
  * @clnt: back pointer to instantiating &p9_client
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 88702953b1ef..ebbb4b50ee20 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -21,38 +21,6 @@
 #define P9_RDMA_RQ_DEPTH	32
 #define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
 
-/**
- * struct p9_fd_opts - per-transport options for fd transport
- * @rfd: file descriptor for reading (trans=fd)
- * @wfd: file descriptor for writing (trans=fd)
- * @port: port to connect to (trans=tcp)
- * @privport: port is privileged
- */
-
-struct p9_fd_opts {
-	int rfd;
-	int wfd;
-	u16 port;
-	bool privport;
-};
-
-/**
- * struct p9_rdma_opts - Collection of mount options for rdma transport
- * @port: port of connection
- * @privport: Whether a privileged port may be used
- * @sq_depth: The requested depth of the SQ. This really doesn't need
- * to be any deeper than the number of threads used in the client
- * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
- * @timeout: Time to wait in msecs for CM events
- */
-struct p9_rdma_opts {
-	short port;
-	bool privport;
-	int sq_depth;
-	int rq_depth;
-	long timeout;
-};
-
 /**
  * struct p9_trans_module - transport module interface
  * @list: used to maintain a list of currently available transports
-- 
2.50.0

