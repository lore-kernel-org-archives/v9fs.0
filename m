Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A74303C94
	for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132553; cv=none; b=j4oI8PQfqtlEYw/TeaoYwEoTkMQJTC0mDk873IMDt4L18zwf4mWLDsN9apSyPeCHKqCTFV2AeE3MBz0GAdawIOnu4pJ6ZBBVA5NLijmqVPCboFytme0D/Q7zwhSscxTKlLZuWIEpSKjBOTv9nK0TWTh6SMyDQTHvBC0Q3QiiEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132553; c=relaxed/simple;
	bh=50iMg4cjhPiTK7ZC9StdXLuoYu4mQzjFec4yy2wlFUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=heVL2iz+IzUUNGmVhqZE4RTeXy5sgcRF/y/BRIEkyOhUfhj3mT4WfRaWP5vakasFv8E6MZc0BrDLpuOMZdZcUp1QqYwUW0DQJ+Sx268Ue8WHof0UqQsNPRNH4oEST0s59Xw+vW4hZonojLNJI2AAbDxRw4hE2DHDwZAYBBROaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAGaWUnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAGaWUnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPCYbFFACQ3Rv/ZhYJDcxm0pSUm0LvajwjZxksg70Jk=;
	b=hAGaWUnTSNKScoG+e9fmsLI1x+nLFAS7CpnTAx7rczi9WMX1pSD7DPX9uJdIHmPuX/PfYT
	u4gYOvOg04s1sIKOSG0+fQMI/5ThfTjUBCB2sMp0saATxlPiVsdqO/RwHepl5zTHhS3spE
	vUao8tVqwHArA26tjITPgP2mNhbFdWk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-MAB_IcneMfy-pIYbTUrpYw-1; Fri, 10 Oct 2025 17:42:29 -0400
X-MC-Unique: MAB_IcneMfy-pIYbTUrpYw-1
X-Mimecast-MFC-AGG-ID: MAB_IcneMfy-pIYbTUrpYw_1760132549
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so56647555ab.3
        for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 14:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132548; x=1760737348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPCYbFFACQ3Rv/ZhYJDcxm0pSUm0LvajwjZxksg70Jk=;
        b=m9J2bkM2125lTkwlGW+7xu1qZBS82VYzpuvu63saYoK6U5a2xMBxMnuSqyPrNCO/5g
         YVKAq+bGjB/jvNyYStkH40rrLhr6UVJZ6Rg1agyyhWNK4z5LjQmI8qVJJgZoQyD5JzKO
         ZnPqQYDoPOWBk+JYAryL6XdpCTe9YrTT/ZfHjx9VDYtCsj38M0iATsNl6yAF3qHsokAo
         WrQMSs77gayKetmFjdVI7m/FJdK4skIt8vaeeAs/+tfS6LvMUIGXpkibjT9JNTaOHu2H
         1SZQRMaWVgdGTEb5GdfgxRBkzIuGIXDPfghgtpZyhuhqniFKV9AZfkjsNmpuWuhgJ7qr
         r57g==
X-Gm-Message-State: AOJu0YxEGCmNcCyR9XCQsTs1IL0fym9AjqXDkZN4lSEM4bAW7aqaAi8W
	4YddawtwqUpHp+EpH8s1vEssV0H+ve1oBUs5CHhMg7nIF+Fyo6oR5LAXAA0mdRuAOpq6GdewTUV
	FnuEopx6XLLgQ1jM4HJV8C24SAa8Ra16ih0ZgQtwCCbSC27052SF20LNuGPzRzuJfQanrtYHWRJ
	PSC1Nn7FBdEvn9yTR8ADZ/JiEDhDi2XQ6gl5KnVA==
X-Gm-Gg: ASbGnctuGeoltm2oLXiaLFybArkvJi5SMTXN92JpjwtHiN8x/bGK4zgkAugq+JsG9CR
	Q63SuDBM/xNFIrXWZzTkeWOQ6eBMQ8wWtIxOlChbnOWiLFBPhRgU6WMTXDS31GlrkQYPzYmpAAy
	qAqwIJiFtim9S82eAiZe1+zub8SxwC4O/G4M1ZhxcF2R7DJf6718tALu2rOSsjv69i8KNHNz7VN
	pCOMrlao0N43syfZilX61JtDlxJIW3bEO8sIYHcMWO9Hd0fUiczvMw4VNFhembKsQXM3JZF+Mcj
	yaLNRnI4BZfrvlOFbUH0hAvcC82mMgqRlRExUuZJU0LE+h2yUSxvlpQ=
X-Received: by 2002:a05:6e02:178b:b0:425:744b:52d3 with SMTP id e9e14a558f8ab-42f87380d9dmr144056585ab.11.1760132548212;
        Fri, 10 Oct 2025 14:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN9W2IC/SA0+yMXYj+bexcHnyhvZRXEQnWhjpte5lw9OnE4asaSu6KQ3Uaia/qiH+7I5ocnw==
X-Received: by 2002:a05:6e02:178b:b0:425:744b:52d3 with SMTP id e9e14a558f8ab-42f87380d9dmr144055155ab.11.1760132547477;
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
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
Subject: [PATCH V3 3/4] 9p: create a v9fs_context structure to hold parsed options
Date: Fri, 10 Oct 2025 16:36:18 -0500
Message-ID: <20251010214222.1347785-4-sandeen@redhat.com>
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
X-Mimecast-MFC-PROC-ID: bSY6Z3ZGrFqVCoam1jCyDuRLmLX46GdBOmSz6QuTV_8_1760132549
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch creates a new v9fs_context structure which includes
new p9_session_opts and p9_client_opts structures, as well as
re-using the existing p9_fd_opts and p9_rdma_opts to store options
during parsing. The new structure will be used in the next
commit to pass all parsed options to the appropriate transports.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/net/9p/client.h    | 90 ++++++++++++++++++++++++++++++++++++++
 include/net/9p/transport.h | 32 --------------
 2 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 2d46f8017bd5..cc18443f7d51 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -132,6 +132,96 @@ struct p9_client {
 	char name[__NEW_UTS_LEN + 1];
 };
 
+/**
+ * struct p9_fd_opts - holds client options during parsing
+ * @msize: maximum data size negotiated by protocol
+ * @prot-Oversion: 9P protocol version to use
+ * @trans_mod: module API instantiated with this client
+ *
+ * These parsed options get transferred into client in
+ * apply_client_options()
+ */
+struct p9_client_opts {
+	unsigned int msize;
+	unsigned char proto_version;
+	struct p9_trans_module *trans_mod;
+};
+
+/**
+ * struct p9_fd_opts - per-transport options for fd transport
+ * @rfd: file descriptor for reading (trans=fd)
+ * @wfd: file descriptor for writing (trans=fd)
+ * @port: port to connect to (trans=tcp)
+ * @privport: port is privileged
+ */
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
+ * struct p9_session_opts - holds parsed options for v9fs_session_info
+ * @flags: session options of type &p9_session_flags
+ * @nodev: set to 1 to disable device mapping
+ * @debug: debug level
+ * @afid: authentication handle
+ * @cache: cache mode of type &p9_cache_bits
+ * @cachetag: the tag of the cache associated with this session
+ * @uname: string user name to mount hierarchy as
+ * @aname: mount specifier for remote hierarchy
+ * @dfltuid: default numeric userid to mount hierarchy as
+ * @dfltgid: default numeric groupid to mount hierarchy as
+ * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
+ * @session_lock_timeout: retry interval for blocking locks
+ *
+ * This strucure holds options which are parsed and will be transferred
+ * to the v9fs_session_info structure when mounted, and therefore largely
+ * duplicates struct v9fs_session_info.
+ */
+struct p9_session_opts {
+	unsigned int flags;
+	unsigned char nodev;
+	unsigned short debug;
+	unsigned int afid;
+	unsigned int cache;
+#ifdef CONFIG_9P_FSCACHE
+	char *cachetag;
+#endif
+	char *uname;
+	char *aname;
+	kuid_t dfltuid;
+	kgid_t dfltgid;
+	kuid_t uid;
+	long session_lock_timeout;
+};
+
+/* Used by mount API to store parsed mount options */
+struct v9fs_context {
+	struct p9_client_opts	client_opts;
+	struct p9_fd_opts	fd_opts;
+	struct p9_rdma_opts	rdma_opts;
+	struct p9_session_opts	session_opts;
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
2.51.0

