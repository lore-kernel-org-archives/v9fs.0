Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115278F3E
	for <v9fs@lists.linux.dev>; Thu, 24 Jul 2025 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324428; cv=none; b=lKCXDzxIOJRovpI3eDKu+kdgFYfaU6l5bobPVdfm2f/cSl+c3UQ7ra2vv8hOuX8h4Y3L6J56Y0vdxKUDQg9GD5mt40328vEJdMA3ZXuIWpRgJhefiU8KI893BPwiN5BVIrLU4NZGQ/97ipGeUKqdAiosvgaV5iAqdu/qJlz/7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324428; c=relaxed/simple;
	bh=+QfMDqSREE53aUyerk3ybPV9yI41CDlWzbJO3aank0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=htbuIRdFgj6g4SeBk4tDvgxECd/nBw82RQ5BMHNlmJkkCuaeq0me/PdQMpHMyzrj8LIqgxHYyZug/SpREw0nqzTici2Iyqjr1/6hB9BKMyC6JW1ELtDd0MOfPriY8UmkW+sJdE6FeUxkQMVAYw2SFYckV+6OvGjEqZ9L20MqK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr1lCfMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr1lCfMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753324426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dt6oSzgDXuV7EoFlJMQFWBJrJNfm1Va0y5vJxs7MmPA=;
	b=Vr1lCfMlHCY+O2yL24b/vPztz7XoY+qDuZSRPa+CIQuy4iE5pUd2iXuIqm7JmNMvVc89O6
	RKtMj+03nPBHx8w1DTdzi0rhv1N629hjeaN6q7k8YMckpD8Uxper2AQL+TWTR7HTQisu23
	hP0duI0NsTelOpHwqtmHL+owQVFxMk8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-YQRahnCcMv6EGhQGt8321A-1; Wed, 23 Jul 2025 22:33:44 -0400
X-MC-Unique: YQRahnCcMv6EGhQGt8321A-1
X-Mimecast-MFC-AGG-ID: YQRahnCcMv6EGhQGt8321A_1753324424
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c33c0b62eso57375439f.2
        for <v9fs@lists.linux.dev>; Wed, 23 Jul 2025 19:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324423; x=1753929223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt6oSzgDXuV7EoFlJMQFWBJrJNfm1Va0y5vJxs7MmPA=;
        b=CHXUTYl7gr6M/8siLm9wZnfp6mWFQeTwGyMzkF9vN+LIjRJeICrwqlUmaTViIMHsIj
         I+cw6Ft+TJpR+NfZN02shZj+o9iyO11tv4hNFKIoe4bJNuwtr0dQUp9JSmP2v+Pl5G9h
         mYl9McDGfTQl5b3v6sd5aOmy2MjOmLvGjqqvBbSgiaRR/DpsNmB4dxh8nxPMCCIU7TNU
         7noIj0p4ea/BvZPHxk3Wc+zg/Mny5m79u55iZY9LUOh62LBmyLmNsglXrl7e8rEDvRy9
         QAC8BcW3BaEsdFvkBosBcJt8WJU2znf2QGsuoT5GipP+RWAgJv/F+8XteOOxXn7QbJzS
         rdtQ==
X-Gm-Message-State: AOJu0YxyU1hCoce/PX4dAe1wMIng/q8HwcvvT/sbiRJ7cUJp6WFM62vw
	HFRbjE+278fv0X0UJLU+Sw6PUefj5psMwVqN0f+yxJFRO3If10p7z8L3YuTU1xfzgTsoAvxxnE5
	ZafsYX8JDUWL5UuWyurDGv0yPP+LiQBm3Ov53P5CDeX/cfNs79mx+156gFbku4sX/ZvloKnxDj/
	uhpBEcVsYddEh4WkBr97fUKEtwjtAAaKEAWkQJuw==
X-Gm-Gg: ASbGncttXrf8+dJD7MKuangWeyBHe8IRn+yGw/Gray+0ngLXGLM3hHXmGFAkWLApS4G
	RWpxmsDJkh0+Kkdx5Y4vNF9RXeDiBPZrXpxkltGRuWhnz6DATrCfk7X7WbdVERV/1WsLiFhRJTL
	sDha9+zHIk3Fb6opR6CuUtlMZ8L66q5zip+g4rnUHsFNcu34x7CnNHXadJm+M0YDzj32pNs1FKt
	0v0+OdmAU4hOUHU8X4S95HxNxyNTIvuS5U+bs4NEbhhMMmyB719EDOXBDDSZRdH6Q+kg5MVb3jk
	Su1pRlHwd6cVwXmnbb3sb1rVrXkh1XIyOpwKbeP2FFdMZpq0i4Nxw3fe6p5m4JSIS7IhE9mbr5I
	So9/eAfpXTZo=
X-Received: by 2002:a05:6602:3891:b0:876:1c5e:8c50 with SMTP id ca18e2360f4ac-87c64f7bb29mr945481539f.7.1753324423401;
        Wed, 23 Jul 2025 19:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/GfxyezQclDrSoXamhdqvergutXFhfsA4mTiCx1VGYTj3A8JdwGxwgAF3cGTQ+HPEBkGq2Q==
X-Received: by 2002:a05:6602:3891:b0:876:1c5e:8c50 with SMTP id ca18e2360f4ac-87c64f7bb29mr945477839f.7.1753324422913;
        Wed, 23 Jul 2025 19:33:42 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aebd520esm137002173.65.2025.07.23.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:33:42 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [RFC PATCH 2/4] net/9p: move structures and macros to header files
Date: Wed, 23 Jul 2025 21:23:55 -0500
Message-ID: <20250724023325.16178-3-sandeen@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 7MJ6vLk6_uPAK-urmliCISZLR-gYoCj0jRtqtX3CuH0_1753324424
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With the new mount API all option parsing will need to happen
in fs/v9fs.c, so move necessary data structures and macros to
header files to facilitate this. Rename some to reflect
the transport they are used for (rdma, fd, etc), for clarity.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/net/9p/client.h    |  6 ++++++
 include/net/9p/transport.h | 39 ++++++++++++++++++++++++++++++++++++++
 net/9p/client.c            |  6 ------
 net/9p/trans_fd.c          | 20 ++-----------------
 net/9p/trans_rdma.c        | 25 ++----------------------
 5 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 4f785098c67a..2d46f8017bd5 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -16,6 +16,12 @@
 /* Number of requests per row */
 #define P9_ROW_MAXTAG 255
 
+/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
+ * room for write (16 extra) or read (11 extra) operands.
+ */
+
+#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
+
 /** enum p9_proto_versions - 9P protocol versions
  * @p9_proto_legacy: 9P Legacy mode, pre-9P2000.u
  * @p9_proto_2000u: 9P2000.u extension
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 766ec07c9599..88702953b1ef 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -14,6 +14,45 @@
 #define P9_DEF_MIN_RESVPORT	(665U)
 #define P9_DEF_MAX_RESVPORT	(1023U)
 
+#define P9_FD_PORT 564
+
+#define P9_RDMA_PORT		5640
+#define P9_RDMA_SQ_DEPTH	32
+#define P9_RDMA_RQ_DEPTH	32
+#define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
+
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
 /**
  * struct p9_trans_module - transport module interface
  * @list: used to maintain a list of currently available transports
diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..5e3230b1bfab 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -29,12 +29,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/9p.h>
 
-/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
- * room for write (16 extra) or read (11 extra) operands.
- */
-
-#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
-
 /* Client Option Parsing (code inspired by NFS code)
  *  - a little lazy - parse all client options
  */
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..9ef4f2e0db3c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -31,28 +31,12 @@
 
 #include <linux/syscalls.h> /* killme */
 
-#define P9_PORT 564
 #define MAX_SOCK_BUF (1024*1024)
 #define MAXPOLLWADDR	2
 
 static struct p9_trans_module p9_tcp_trans;
 static struct p9_trans_module p9_fd_trans;
 
-/**
- * struct p9_fd_opts - per-transport options
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
 /*
   * Option Parsing (code inspired by NFS code)
   *  - a little lazy - parse all fd-transport options
@@ -749,7 +733,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	if (clnt->trans_mod == &p9_tcp_trans) {
-		if (clnt->trans_opts.tcp.port != P9_PORT)
+		if (clnt->trans_opts.tcp.port != P9_FD_PORT)
 			seq_printf(m, ",port=%u", clnt->trans_opts.tcp.port);
 	} else if (clnt->trans_mod == &p9_fd_trans) {
 		if (clnt->trans_opts.fd.rfd != ~0)
@@ -775,7 +759,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
 	int option;
 	char *options, *tmp_options;
 
-	opts->port = P9_PORT;
+	opts->port = P9_FD_PORT;
 	opts->rfd = ~0;
 	opts->wfd = ~0;
 	opts->privport = false;
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index b84748baf9cb..46ee37061faf 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -32,14 +32,10 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
-#define P9_PORT			5640
-#define P9_RDMA_SQ_DEPTH	32
-#define P9_RDMA_RQ_DEPTH	32
 #define P9_RDMA_SEND_SGE	4
 #define P9_RDMA_RECV_SGE	4
 #define P9_RDMA_IRD		0
 #define P9_RDMA_ORD		0
-#define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
 #define P9_RDMA_MAXSIZE		(1024*1024)	/* 1MB */
 
 /**
@@ -110,23 +106,6 @@ struct p9_rdma_context {
 	};
 };
 
-/**
- * struct p9_rdma_opts - Collection of mount options
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
 /*
  * Option Parsing (code inspired by NFS code)
  */
@@ -151,7 +130,7 @@ static int p9_rdma_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	struct p9_trans_rdma *rdma = clnt->trans;
 
-	if (rdma->port != P9_PORT)
+	if (rdma->port != P9_RDMA_PORT)
 		seq_printf(m, ",port=%u", rdma->port);
 	if (rdma->sq_depth != P9_RDMA_SQ_DEPTH)
 		seq_printf(m, ",sq=%u", rdma->sq_depth);
@@ -178,7 +157,7 @@ static int parse_opts(char *params, struct p9_rdma_opts *opts)
 	int option;
 	char *options, *tmp_options;
 
-	opts->port = P9_PORT;
+	opts->port = P9_RDMA_PORT;
 	opts->sq_depth = P9_RDMA_SQ_DEPTH;
 	opts->rq_depth = P9_RDMA_RQ_DEPTH;
 	opts->timeout = P9_RDMA_TIMEOUT;
-- 
2.48.0

