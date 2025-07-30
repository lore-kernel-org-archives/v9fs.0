Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E162E3AE1
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903524; cv=none; b=UyctcQQ8T+WU20r2kFP1F1o0q2FAunmMgN/eytBpZeCI/OJkVpth1L93kPxgf+yb11GzucI4AzcQ7m30nhm1ezgcfbdxm3YWsaZdDUDieOve8xZ468cvTUdrMtW7pQnb3XWTxNrc/sgOgPFa9B1fNpDohmhxzTPsGoNiEB+9LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903524; c=relaxed/simple;
	bh=sN4ToRO/TAtEry+j6kPvuahk3sHm+KtIB9JP1RHY5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qDwAzdZ0kMtbZ1mNmHN7oT5PLF4g+7+kKJlEIqidvbEVVFPDwUNkH4gg01THOhQwbk3OWqH8ltOng8tVDNveqp/ADhbevSBWNae0xkgksp2fJZnQESrQSju/VWTd/4j1RxH0Esg8qFekiB7nSF2v2JWM0X8IcoeV0l05nUQboto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTiy051N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTiy051N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dddgV3m+UDepdnv1fS5DHQKgKnaNLuu+lwozlkmeSI0=;
	b=bTiy051NhGdEHxDdyn4R05fGHQg1OYvSlrFL4tcA1cZ3uyjy1xSh16K5GzbA0lFfuOMmvN
	ueZD5B//BWosITILHTWg7xyywyQLXoZ0+R/IRPskWki+5GReT2DNIoR3JzaYAqz5G5TiBC
	NH2apRDHWCoa3+VwLRXSaPnTeVrW4yU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-R1yfHYriNIS8LjuRntWzZA-1; Wed, 30 Jul 2025 15:25:19 -0400
X-MC-Unique: R1yfHYriNIS8LjuRntWzZA-1
X-Mimecast-MFC-AGG-ID: R1yfHYriNIS8LjuRntWzZA_1753903519
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c752fb0f7so20557739f.1
        for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903519; x=1754508319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dddgV3m+UDepdnv1fS5DHQKgKnaNLuu+lwozlkmeSI0=;
        b=iTsxLrymWVhM3lZF8ngOgQeO9k+a7a593ONMkaHz+JE1mudKc6o4VJShmC+BvpTQZE
         UQsUJjni9wqrABruDdIz7VpmRwv53cirPXPfiR9HAfA25MIkD2Ep11/xhcDaLDuNo0Wk
         BlcIhj3T+17p9aDRWJ1I697FC+gL8NRSIF04UgFwgsYW4nNSIehMOXrJZBngWwiccsjI
         kzRuaa+IqbgxrgDeXLEfvnb+7C5RogIH1u5vrOSmCc2M9r+g5fLiEUhRUaoGokeZORjf
         20fGChDaG+D+CENhPoqbYDbsvEijUywchQwgZCOifzsplPsFxlUXyR07elQURc5ZwMUu
         Dk0Q==
X-Gm-Message-State: AOJu0YyucxpAoBgLYuTY6++RJDtG9U1lZPwGYQJeIrFWYyu7UlJ6KySe
	dxjFLZhhpaCW02JjuSqo1RWRyVVkZsV4lE6WB37byRfiw9CbEiWpEEfy92fJHZt0EzuJtTngpTM
	MGXi+Rfn8upw4iqp8C1jz8+WcbdlvGAvt7hzrurnbMbOH3yPFqnR8ULgL0qbXyE6mRuoaid++Xh
	DekQZ4Dfcch8yOOq09+qOyH0XcKqUqYpzF8g84FG4zld0=
X-Gm-Gg: ASbGncuK0INfF/UBvRoAeGwdEXJuKrd8uzbqochn6u4sjVlFAWdS44wxWxAcQ2pnMni
	pOYfXjDtlsaDT/4WCPcP0s2erYH8XroW3360iMoWUMRhyixmU1SNYwH27Me2Dz3vf1Ca6tn8TAG
	EGU0abivXOeg6h0SRRMvMWjCmtCqj1VclnvcTwLRPA3Mp1Am/R6SbCvoNMHTcJbgnbd62wU4oOF
	pe2YfYWXUIO1WegTAg0umYKjtEm6wrRrWIqmrXYc3hfwiI0oBvdhtbT+1txv4ruZg7j76Stqe3W
	tmGgfjiS4UQAZ6QhbEhKcrJ0a+SnAhLBf8qzcxRQ0/NE
X-Received: by 2002:a05:6602:2dc2:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-88137c64e5emr832942639f.9.1753903518815;
        Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2EmN1zocAou4yHWVsA7mE9VKQl50MyU2Nxp4wt0HkZYlbJonqpM3EFK12/dg+xMJ4JZ9IuQ==
X-Received: by 2002:a05:6602:2dc2:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-88137c64e5emr832935339f.9.1753903518275;
        Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
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
Subject: [PATCH V2 2/4] net/9p: move structures and macros to header files
Date: Wed, 30 Jul 2025 14:18:53 -0500
Message-ID: <20250730192511.2161333-3-sandeen@redhat.com>
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
X-Mimecast-MFC-PROC-ID: HnBv8auAdhOcMzHnEFTH1doo4j19G4-gsUjZHWleNiU_1753903519
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
2.50.0

