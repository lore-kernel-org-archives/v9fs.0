Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052A313E36
	for <v9fs@lists.linux.dev>; Wed, 20 May 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304451; cv=none; b=guZMO3GDGGwqHwOVwe46iBK2nd+chNR3upXeqqKS74MFR7Dow33Rxu8BpmSfG42X46NaLCZBYIb2wStA5kHJUZQDPT2NUoVI6A0vSYJHJmk0szLK1Pidr0efxPhccWVH+WhenJ1KRAFquS/8CvLgRxWaq10RymfKEItvNliySXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304451; c=relaxed/simple;
	bh=vodvvcswZRlbDFXfFUiY4r5AdgWfA3xto6hrwuObiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzMy9a72+zjIOVKcgNfmOTZCoRT9rdhm6wstMxYn+QBRMB5dPkC3fDbTsBF7LYPDs0iCWGbO3yXCChgDxBsFOaAP9s8XnqiQs5sn8fIbL1mchUQbhivxCAgIuzjZJWfzyVN+NDy1cgkSVxs6Sv+yGoLNQbYWZGxVlkOgTaA+BTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=gqVlweMv; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="gqVlweMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779303832; h=from : subject
 : to : message-id : date;
 bh=uCNwpibAseSDNQ68UeAV3DI4drw37VIBam9jpljEa7M=;
 b=gqVlweMvQG96ByWVnYm4ckUCnxU7i5pzQtvoeuSmjsaS/vLhggrEpgoaIKAUtdUS3YJ1c
 HGQyFThEg6WIiYHGeewh/renvGgkzl6ucjOaikVIPieaCT/l7Q+5ntewW+P1c8jNbRsNLaq
 WVxfG6FxfQv0cvCox30wn2wpp+ptRnxYeK3BIdp2T/QTC9TDsS1+KsxGqvsgcW5ckvO+3xr
 x+ZtfL05xFAT4LQYaETCjaSQTydbQQQE29TeHOIKvI56yBlPIr3Hy2aAv0LI0i5YfK2l7VU
 zbm/SI+SqEWbne5jMx1ZM2M/AWpGW8huSkbAvMFrY1h7ZFDPfzpbgfxTCfGw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wPmCw-AIkwcC8nAYK-KwqD;
	Wed, 20 May 2026 19:03:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Wed, 20 May 2026 20:41:39 +0200
Message-ID: <ca093dce1237b902fc8968672c16ecb952147192.1779302002.git.repk@triplefau.lt>
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
Feedback-ID: 510616m:510616apGKSTK:510616sfrOXB0SBC
X-smtpcorp-track: q2yd3p6J4n4g.JXMvMBc8Ky4R.l6OhxAP4iWO

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

