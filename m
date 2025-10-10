Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C33043B8
	for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132555; cv=none; b=duYYfVb6QZSTkq7w4x+TGH5eu1u8ow3AQu5eQg6+66vNNbRc2LzRO+/wKchvOGKYIxOVId6z/HfUfgW9qMe7DvOs9UXZGTpJs+yzNaP+OVAPUIXhPcTErtWQLRZi8B4yPjX76fjM9Ez2AG4l+vTBbdo/An2Osy3Veutp4A8bzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132555; c=relaxed/simple;
	bh=GJryDFOsOloQjP7siK0zC0G7J45WHi1AB6btkM6QkBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qnTgArVG5wUjWBpW6M5XpzSlPEzmGLbfn1Lyy2iVHvjK0Pnud5ApLicw80cVSFG4yQDxfs3Qg2TSEMhqlfob2nZNn9uKx4MLzoszd6gIi9L3gEIhWYsU6V9UtpZIEzwpDvhbDFBBzXyIln+moQGAaPodlU6WCr3edf7mrzzi/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PltVS+sg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PltVS+sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HR7ws2UKD9+oIwfuUNn9Tl9ltcybskbjqnKMPXQbKgk=;
	b=PltVS+sgVWQIbU9Ao4930S7QrZ/iWw0FK3XkSLtr9b92yMLuviK7Nhy7gc1vNtLDjr1qx6
	be7ATQeADNuLKm4owjHAZW7dgqpn+EE7IuUdIHptzwI+9bPy4SdMb+xQX8lGwqycPrlvKg
	KKa9Cj05YBBQwfA5Y/DQIa1KzJHeBiI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Z3Obya_5OJixR2cZtXaSYw-1; Fri, 10 Oct 2025 17:42:28 -0400
X-MC-Unique: Z3Obya_5OJixR2cZtXaSYw-1
X-Mimecast-MFC-AGG-ID: Z3Obya_5OJixR2cZtXaSYw_1760132548
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f6639fb22so99521625ab.0
        for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 14:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132548; x=1760737348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR7ws2UKD9+oIwfuUNn9Tl9ltcybskbjqnKMPXQbKgk=;
        b=tnRa1omt0NMElI8vpegL+JR5PnFAe9UvkzjdTJRIaX5dekQTjedLXWFhrcHV2D2LeM
         rWum/+LyjVzakyH0ehkuCRl7v7ALhngW1UoWfrAExpActiOrXCmtqLAXGgQC9Nda5tO7
         vLKazQksjSq94FFLg71/lK8fuGmtyzuH+zKemyGBgcGZdbTGuYGdcz9YuFQzGgJmOVQt
         k7YpIEfGUBcH/9omaq3IKMWbnbi571gqCF1cUlKmlWRy9vN2teCZW6m4VdOPP/61eLLp
         wUket1OAuGBbp2vTCng1jXUEPI855rvahobrMQ4z8Rd6+8VKz7bCucXYQFHIimckRucB
         hhSg==
X-Gm-Message-State: AOJu0YzqUc6+X5c8VtZXYV60ien52ev1mAKF4k1RoNDIsVpx8hsVSZ9g
	YpOlxEeHvWrETZanywQCOGScdO6jdmADmTY86qRfAFCtGq8xgGM21psIj08DUWR9tqEFhY6M2Xq
	w58uCJDCZ4wGBvk1PTwnh7TJDYhKELRO9ZHA2GdwBbJ0vXDKO/VwQMIP1lIQJ3754g4tQyThdjT
	ZatixMJglwaoUN51pGgScSu5n7IPe84Q==
X-Gm-Gg: ASbGncvhfuwmezw6jaW3860N/ydelwiNjDv935hP62+2EfPn+b+lTER0BCMrSoK1GJd
	QrUQOwWrQY+CP7dU7ZvAgxF7b3433QuHNb6NX7ZzEyKUmThvIsz+EFnWR5k7vCMnuMcxktSgVNE
	z8nctac+QVrhqAEzBlN6FXYSP6Lf46VllzHu8XcmWP1nDmPGfue888rPFuXamz9fGl+Ps/K+lmk
	wThRR182e0VPcxG7PNfxUmDwKwVPAVe67PLGOJvmQq3Lkw2+W3TmAqakR3tGwL9Nyic9e9/MTuB
	Gm7A/V6TuOZwHnEBOchSowY=
X-Received: by 2002:a05:6e02:3c85:b0:42f:9ba7:e47e with SMTP id e9e14a558f8ab-42f9ba7e72dmr70053025ab.14.1760132547736;
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH44cVXJKsWaECfwgaloao72H4DmNC0TIRKAyNGZ6LB3b/aUsmISlSFdph6ZLlnpFd+FZr3Mg==
X-Received: by 2002:a05:6e02:3c85:b0:42f:9ba7:e47e with SMTP id e9e14a558f8ab-42f9ba7e72dmr70051355ab.14.1760132546767;
        Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 2/4] net/9p: move structures and macros to header files
Date: Fri, 10 Oct 2025 16:36:17 -0500
Message-ID: <20251010214222.1347785-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2rmm1NY4pJoEqv28eXxNqK1aXzF9vC2N4RjW2QBcehY_1760132548
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With the new mount API all option parsing will need to happen
in fs/v9fs.c, so move some existing data structures and macros
to header files to facilitate this. Rename some to reflect
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
2.51.0

