Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0952313E36
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304449; cv=none; b=Mymn5ceXnkwPflJJJ53Z6cwbcJzGuIQ2f0vjjHHIiC5bfAVLcdtv+2SW6DjAxfRuIRBNQL86KObPKRwXIKSS3iYZYF9yHEaMbMdsKMCuDH4ratGQdlnbjXI/VkWs6km7hnKD//Le1nRAXYHCzE2OMvSC+lw7/KGOutJDn2O5yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304449; c=relaxed/simple;
	bh=AAN255HdM3uZ4+It0uI52zgspk3PlnjRuFJ5Vkbr2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5sorVtyVU7VPCEO/7kHNJDJ4HhJPFDGRM9HuzOtLvMuib7itJlXVO0ruMJLIdmsSjC+ktI+GkUdiy5CLcgMMEXGcHfXklORBX3evX94zHiU1Rpn1O5a2kJ0ULoA+wxzJoXYvpoawamZO6l7WjftktYdCar25Am9qTGn3azkndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=bKM+3+Bv; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="bKM+3+Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779303829; h=from : subject
 : to : message-id : date;
 bh=Hc1ZS8wBS8cUwmC29S6NYs+RegvTzxi9h3if/SxiDqk=;
 b=bKM+3+BvVnAk8Rs7KUqPza6xwDMCfflzUZhFNq48L+kg0YPXsV9QmanERmvJNLcy65PMV
 eTPwKxRZ4mF5OP2t+AUhMiU1uKKa1ThAjRMwlq03qWF3w/Na176TJXiP/ASsNN0Oy3kpe1l
 whMQy9UtVsurBlZ3EwcEIICZr6Qg0qxtEs66lHunRxjcTj+brOwb8RD9Z6Ytn2eCvjbo2bd
 P/h5HfMIckEztF/Yto2Us5KzzhJYzOpGU6oJFEsNW+3euj2aKJLG483hZ8Tz+bvLYrdLtal
 0u+hvlHmSYCWq0Pjsrbu2ySMKDRu0OFM9p7hzjRH73W9/AnA3Inub4qPYBxw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wPmCt-4o5NDgrk2Nn-sXOx;
	Wed, 20 May 2026 19:03:52 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 2/4] 9p: Add mount option for negative dentry cache retention
Date: Wed, 20 May 2026 20:41:38 +0200
Message-ID: <789d65c8cd114b9af9061b821d645990972ef443.1779302002.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779302002.git.repk@triplefau.lt>
References: <cover.1779302002.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616swS8dw1lx_
X-smtpcorp-track: 5S2KQqgxYOA1._ojSfJevNy33.9XwXlQIGIU6

Introduce a new mount option, negtimeout, for v9fs that allows users
to specify how long negative dentries are retained in the cache. The
retention time can be set in milliseconds (e.g. negtimeout=10000 for
a 10secs retention time) or a negative value (e.g. negtimeout=-1) to
keep negative entries until the buffer cache management removes them.

For consistency reasons, this option should only be used in exclusive
or read-only mount scenarios, aligning with the cache=loose usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 Documentation/filesystems/9p.rst |  5 +++++
 fs/9p/v9fs.c                     | 16 +++++++++++++++-
 fs/9p/v9fs.h                     | 23 +++++++++++++----------
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index be3504ca034a..b014c7aabba4 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -238,6 +238,11 @@ Options
   cachetag	cache tag to use the specified persistent cache.
 		cache tags for existing cache sessions can be listed at
 		/sys/fs/9p/caches. (applies only to cache=fscache)
+
+  negtimeout    the duration (in milliseconds) that negative dentries (paths
+                that do not actually exist) are retained in the cache. If
+                set to a negative value, those entries are kept indefinitely
+                until evicted by the buffer cache management system
   ============= ===============================================================
 
 Behavior
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index be83744b75b2..3e758b66fefa 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -39,7 +39,7 @@ enum {
 	 * source if we rejected it as EINVAL */
 	Opt_source,
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_negtimeout,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
 	fsparam_u32	("locktimeout",	Opt_locktimeout),
+	fsparam_s32	("negtimeout",	Opt_negtimeout),
 
 	/* client options */
 	fsparam_u32	("msize",	Opt_msize),
@@ -159,6 +160,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->flags & V9FS_NDENTRY_TIMEOUT_SET)
+		seq_printf(m, ",negtimeout=%d",
+			   (int)v9ses->ndentry_timeout_ms);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -337,6 +341,16 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
 		break;
 
+	case Opt_negtimeout:
+		session_opts->flags |= V9FS_NDENTRY_TIMEOUT_SET;
+		if (result.int_32 < 0) {
+			session_opts->ndentry_timeout_ms =
+				NDENTRY_TIMEOUT_NEVER;
+		} else {
+			session_opts->ndentry_timeout_ms = result.int_32;
+		}
+		break;
+
 	/* Options for client */
 	case Opt_msize:
 		if (result.uint_32 < 4096) {
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index e630c5111d74..a462bcbfc7da 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -24,6 +24,8 @@
  * @V9FS_ACCESS_ANY: use a single attach for all users
  * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
  * @V9FS_POSIX_ACL: POSIX ACLs are enforced
+ * @V9FS_NDENTRY_TIMEOUT_SET: Has negative dentry timeout retention time been
+ *                            overridden by negtimeout mount option
  *
  * Session flags reflect options selected by users at mount time
  */
@@ -34,16 +36,17 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U    = 0x01,
-	V9FS_PROTO_2000L    = 0x02,
-	V9FS_ACCESS_SINGLE  = 0x04,
-	V9FS_ACCESS_USER    = 0x08,
-	V9FS_ACCESS_CLIENT  = 0x10,
-	V9FS_POSIX_ACL      = 0x20,
-	V9FS_NO_XATTR       = 0x40,
-	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO      = 0x100,
-	V9FS_SYNC           = 0x200
+	V9FS_PROTO_2000U         = 0x01,
+	V9FS_PROTO_2000L         = 0x02,
+	V9FS_ACCESS_SINGLE       = 0x04,
+	V9FS_ACCESS_USER         = 0x08,
+	V9FS_ACCESS_CLIENT       = 0x10,
+	V9FS_POSIX_ACL           = 0x20,
+	V9FS_NO_XATTR            = 0x40,
+	V9FS_IGNORE_QV           = 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO           = 0x100,
+	V9FS_SYNC                = 0x200,
+	V9FS_NDENTRY_TIMEOUT_SET = 0x400,
 };
 
 /**
-- 
2.52.0

