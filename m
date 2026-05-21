Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDC37FF5E
	for <v9fs@lists.linux.dev>; Thu, 21 May 2026 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357783; cv=none; b=uiRrmBHeehvnszFIoJoBu23Nmh/p2zxatjAj0UAmQrJqsmbTvmbYLWFk3AsHBZG1e1oLI7wTEWFGJ+MUqHKs0K2A35FHS2YsYD727trt4AxwctyE7RUnrTE7r0BqwDfGr3ICSFqpNn+8KnSMg7g0vB91JAmrR9U3jcgRvTENvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357783; c=relaxed/simple;
	bh=vodvvcswZRlbDFXfFUiY4r5AdgWfA3xto6hrwuObiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fro29lPqEXnzSNTYEiqbqGEiOh6fVLo4wr2+KxwQgibgzCyW0V2Rc+Xh40MHN8uy7frCQt76rNK8EGFMTdZgGBMR65nFB+PmqbICkU+HipmGCD3QJPB1ia62U3Hg/DsORhQfrxUaIHjaE6Fj2i1GvdD7DWx5DJNqfbt7FpdhOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=EO1QMzEn; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="EO1QMzEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779357780; h=from : subject
 : to : message-id : date;
 bh=uCNwpibAseSDNQ68UeAV3DI4drw37VIBam9jpljEa7M=;
 b=EO1QMzEnnlfMCKYHC+In7kSMfqh9Uoh7CGkuPzhwScBPbyOrHqijDEOOQAbqIQx6s0MLl
 af4ZuF4wLatQLIOp9zb7u4+yi6FD1omLsTqno5/TA61KI3zwTrpPhqA3yWgu61VHoKszjRv
 h+NI2BZamJo9EmW17VpBAhUIJVcTt2cW9lsKhH4hcis5YF9pZzgHV4rhtgEvuFGDPM3JN5M
 221+SkAoHBrd8n+5gnOTjkHKkngy+SuL2/g72dnk4NDawfyCeVkzTYH+frwhxLdkWjRiRuP
 lemMEanAt3mNjK71yx212TsQaZci419Fymf9JMH9j3/PJAvensnnE5OIddjA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wQ0Eq-FnQW0hPzify-nxIq;
	Thu, 21 May 2026 10:02:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v7 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Thu, 21 May 2026 11:40:31 +0200
Message-ID: <b5beca3e70890ab8a4f0b9e99bd69cb97f5cb9eb.1779355927.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616skA0ZlBRBB
X-smtpcorp-track: k8q0SMmqmQgP.N96PCuyuVye3.AfLC3AEEsbd

For cache=loose mounts, set the default negative dentry cache retention
time to 24 hours.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 3e758b66fefa..274c5157135d 100644
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
@@ -441,6 +444,13 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
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

