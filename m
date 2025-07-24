Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC518EB0
	for <v9fs@lists.linux.dev>; Thu, 24 Jul 2025 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324429; cv=none; b=rTAWZpYCtu39Eb7J5qbiGgM+SCRP0ZBAs2F8B/jvy6k1bm9wl2yhmyajgbuqnOItanq8rm33f8dkO8VbA5Tb8jo+PyHFtxJmKn1L4BgevLCVVrCQh6y4LDbwInmiVQR7W4/mCu5E6mhvqOnB0NKavZeMW89KDZZ05XlwYLZOWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324429; c=relaxed/simple;
	bh=Vy142QIIQc7eKg6NoYh/cwAD1/fiXi2PqcVvkJdKoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VlcJKeeYermnDhR1FDnytIPBS2IAfD7Vaudv80sYaZqhcFHeHvCim6up4yCAETVY4jROJS4MFWWiMRcIncSvIthqpRpNSP0J1N8xjWTGwuOBwJt1qOFPHYinNEO3P6sgOaF2ml27owon0HNqbn7SoCehu/hnCpD3utYaLMkAxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JweNKzPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JweNKzPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753324427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6vtvg7qb/ihB0QXdFy49bBip+GNyD0QoOeaW5Nkcyg=;
	b=JweNKzPqc5SO+N7IKHHzg5zZwj8H+K+YHO6Ji5X7XhKCzHhDln64aodjyqBiMSpKwhYwO8
	IOGTaE15hXsasGre/JMVGRvxTzr+D2b8zZRIzdpPHKOfPq9lQlNNZQUCkMueA5cStdOqMQ
	pMEXU3PmemE1b3UyMniC86CKdgQ5D1U=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-aqDrHlwPNWerTDbxQ0c_gQ-1; Wed, 23 Jul 2025 22:33:46 -0400
X-MC-Unique: aqDrHlwPNWerTDbxQ0c_gQ-1
X-Mimecast-MFC-AGG-ID: aqDrHlwPNWerTDbxQ0c_gQ_1753324424
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a5def8869so128371139f.0
        for <v9fs@lists.linux.dev>; Wed, 23 Jul 2025 19:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324424; x=1753929224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6vtvg7qb/ihB0QXdFy49bBip+GNyD0QoOeaW5Nkcyg=;
        b=P9L92Yakzxp3JUooWshl86W24ff93f4iPyioKa6+pZ9d51gNVcsEtKEjqieU0EznFt
         jPSkmQX0tKz7D5RRdkIJMaYzzIAd1lfQW/+PgK+iuF2xd+UuXPHHONMssboLBo6SNcL2
         gQjVbkd7XfYs2vx7oarl3C2DJq6yE6hzP/TMJV3sR1OIT+Q2UUKqF7FbfjewA0itlnn4
         qU3LVGhb1wGvzuRfwvZPONIMG44Lta6Sb9Fn569edF96LYpBXF5M1Z0iYPQzTlo4dmoY
         gFD10i4xakMIoP6sojsnzO89YnAF9hMqA08AmyEd4vN35GQ1u7aSif4P3AyrcXmoiY6u
         67lA==
X-Gm-Message-State: AOJu0Yx7cxAwzgFDLaMBbcAETbvGVyVitDnpcbSRQXWD+uCwNv1EgAIx
	jtStRFNs3yYoRLbBdQi062FgMIVdat6hpbX96ZOdxYGzOvZrYMLmvbf7HqPPqKv1tsljTgGjvVU
	QiC/8Y2P21W/+sZ4YVfYon0nmVM8UlXGAz7XLFHGNYwSFAe62OxR7bLsU3CXs7i3yZCMukXsqBV
	EZlJU4jbvB8tdUCRmQSsg0O6zQ5Zl+XNYkNafuNA==
X-Gm-Gg: ASbGncuI3YZiSFc/Hl4iqgKt5NHRKx5LiWjsyfeGMBttFjmocA3NrbBctW03uQADPce
	t7We4ZQBuJpWJ0irGeld05E0cgTeeCxC3xYxDC8hWng8x/QtfbiYdmg50tNti5Mk1kf0874ha7u
	YUsdPwzJimciGzLiD98b2wE4MJReiqpgYJUzWI2/+dtE2R4ByyIeydQgpPInc0S02Wn8zK+cQnD
	e944bkM741WajIoBDuzlIniwNxdjdKnTS6DT4NPMCYddjag95T8/yGv3f4RjizRKVZGVRvIQmvE
	/45RgZa4klz6cO6WpMjut/W1U/aaIxfv1/VtTaorFlO5LbOVjG6MpizeBvR6bS1StO5DCq/r757
	GJr3/EOCDQls=
X-Received: by 2002:a05:6602:a012:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-87c64f9f4f7mr1206716039f.4.1753324424076;
        Wed, 23 Jul 2025 19:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNCAZyypNfTulYkCF8376sdfJeKPj8n3/x9G8K3bwNJY7fK3YAHc7vy7nIUzXXUj8FXz6WXw==
X-Received: by 2002:a05:6602:a012:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-87c64f9f4f7mr1206711639f.4.1753324423659;
        Wed, 23 Jul 2025 19:33:43 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aebd520esm137002173.65.2025.07.23.19.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:33:43 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [RFC PATCH 3/4] 9p: create a v9fs_context structure to hold parsed options
Date: Wed, 23 Jul 2025 21:23:56 -0500
Message-ID: <20250724023325.16178-4-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250724023325.16178-1-sandeen@redhat.com>
References: <20250724023325.16178-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xm4T1hylvOafn0RWvagopvAMUmcrWAzWE2rHENOB42o_1753324424
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch creates a new v9fs_context structure which includes
v9fs_session_info as well as p9_client, p9_fd_opts, and p9_rdma_opts
to hold all parsed options. The new structure will be used in the next
commit to pass all parsed options to the appropriate transports.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/9p/v9fs.h               | 49 ---------------------
 include/net/9p/client.h    | 88 ++++++++++++++++++++++++++++++++++++++
 include/net/9p/transport.h | 32 --------------
 3 files changed, 88 insertions(+), 81 deletions(-)

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
2.48.0

