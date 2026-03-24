Received: from e3i468.smtp2go.com (e3i468.smtp2go.com [158.120.85.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5034A3C1
	for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383530; cv=none; b=GgWwyHLGTIR50gDnAGPwyOB6gsTfPziLNpzu1rdShmdzRZ6ew2iMY48QszszfjpfWH5hFpQKbbJB9DGQiyFbbQkTrkeXqFbO9ZsfRdMt5q0QVf8RrzydI0tuyVq23YRVekXd8U+oWYr+moNfLFE9ClkhBNls9yf/X39Ean4NyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383530; c=relaxed/simple;
	bh=gSqiHBC8YoUX5EkH3JCIKah5749u/zPS3n5f8J2P/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmxpukhBpv6mKd/rpWicpMtYKzv9Do8cxnvYiTg/aggQ0gDzQi39IwzZb1kk4b3/CJzdtN9JtvZ5pgWs+BbYgQGIxbzQ/a7jpcQCSznWSrTHaJaLGaWmLJBy4j7y02n6N1+eKl51yVU/k6zjLWUPYsVL6dNCCW2tp7g9pkE2zZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=nVsz/MlJ; arc=none smtp.client-ip=158.120.85.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="nVsz/MlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1774382620; h=from : subject
 : to : message-id : date;
 bh=Q5XeYb3NItq0q8BeTQJa6q2tBtl1wKIGG37yUzrloyk=;
 b=nVsz/MlJSUMys+PC8CzuOxw6FYQql99rzfDmxwUzTvAal2hrmvEW2zvmrcNRUVBdJ29W8
 FAUdPtDeP/iQmxhtb/pkvRSQitUmAIn6gBLhPuv8oaHcpwp8R9fFSpzLOlGrZIkgw6owoAo
 yjP1IjzDwY5T9pvH2b9ghvZis97X20yKytVYIgw1/Th8qwDdn30q0d6qFWlCCm8l/MqLb16
 AA9V3cakkuQctzDEQM1vfngSoeKTWQw352hy59U8S75c+UfA3gxLaQ1GGaH0DVy6a9dBigq
 uz+JOfQ5WOBTZ5G5yJkT5odokDjLLUnARWIHkbO+9mDg+bon53LTAILw/ciQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1w57yU-4o5NDgrkYbV-pWp0;
	Tue, 24 Mar 2026 20:03:38 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Tue, 24 Mar 2026 20:43:33 +0100
Message-ID: <fdf05eda35e0d095a5e8bb299e35127219c1c10b.1774380535.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774380535.git.repk@triplefau.lt>
References: <cover.1774380535.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616seTnygqtFL
X-smtpcorp-track: 1hRoYKwdgXb2.-9xZa3_6bYfu.DL14FQAiF8E

For cache=loose mounts, set the default negative dentry cache retention
time to 24 hours.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index f16517be7fc2..79b6a8b82779 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -24,6 +24,9 @@
 #include "v9fs_vfs.h"
 #include "cache.h"
 
+/* cache=loose default negative dentry retention time is 24hours */
+#define CACHE_LOOSE_NDENTRY_TIMEOUT_DEFAULT (24 * 60 * 60 * 1000)
+
 static DEFINE_SPINLOCK(v9fs_sessionlist_lock);
 static LIST_HEAD(v9fs_sessionlist);
 struct kmem_cache *v9fs_inode_cache;
@@ -437,6 +440,13 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
 	v9ses->uid = ctx->session_opts.uid;
 	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
 	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
+
+	/* If negative dentry timeout has not been overridden set default for
+	 * cache=loose
+	 */
+	if (!(v9ses->flags & V9FS_NDENTRY_TIMEOUT_SET) &&
+	    (v9ses->cache & CACHE_LOOSE))
+		v9ses->ndentry_timeout_ms = CACHE_LOOSE_NDENTRY_TIMEOUT_DEFAULT;
 }
 
 /**
-- 
2.52.0

