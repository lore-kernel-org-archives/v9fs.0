Received: from e3i432.smtp2go.com (e3i432.smtp2go.com [158.120.85.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C531D72E
	for <v9fs@lists.linux.dev>; Mon,  4 May 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927061; cv=none; b=BxAZwDOa6kutlvE7Xo4nqj7DJlZbhJAqdMULzyM+KCKL8nqBU8V9OFV6AyFPVGYo+qFsfnEBFRB6HDu70Uj1Go19XAlAMZvdZW7zmEnfWwBgCOqXNGtXfM8vSsJzIG700EWOGKEysX+7G8DdTkZWrSuh4SDFfFJUhOoCZ4n/9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927061; c=relaxed/simple;
	bh=4Ltf5l6zcSTbf5sESaPGkA9/4n3csa1gEn3ekGkzDO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSOn55PqFXLkBIGUEVELNPw4Ub02ITbMIgBN+CQK3yT2JGAvMl0KXQzwzwdn+Grakcvw2jBU6IubEGeUdWomMv/U3gaSNOaMXUf3Ze+skKako9LiXbxNMRgD60y7BXHQQZtlqDtC5JxYUM5UisWc5yLljmMAm/8tfbqUsTo9VSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Kdz8xahs; arc=none smtp.client-ip=158.120.85.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Kdz8xahs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1777927054; h=from : subject
 : to : message-id : date;
 bh=T47Z9zAHslXwhn3i/I9muoHKSzhEdfWTrcBEzAMDVFE=;
 b=Kdz8xahszYwTCDjXD6sGmaPSPuC75ELXtYuD/xgjtqNN41EC+TfHn3sBLL47Mclv4Ts6T
 zS+tnJfvkAPcEsSSPwt5Ay4s5GgE9VBQLu7ZEW6jh1YAN6dQOSjK/ItM/39pgZhQ+9iwJj4
 dMOAnq5WaatICBuBgH3hIeDxPv6rjvhUIOrCxt/LCW50ji9Q9mF8S4D4DMc+EMAKn7rCDwy
 9GNa/4nB/XreirMqDYP6jf2xNzEuBAWtMrDcrxI8vvot2ZVMqwZVIUYQtsSfQApNycnx0Lb
 dOC37iDrcq/LnwDxg6kXFOXLbjIoDt56NWNl9Hy2Jh61cazXCKFeE14pAHeQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wK02n-FnQW0hPpv7Y-nAaK;
	Mon, 04 May 2026 20:37:33 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v5 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Mon,  4 May 2026 22:15:53 +0200
Message-ID: <fdf05eda35e0d095a5e8bb299e35127219c1c10b.1777923233.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777923233.git.repk@triplefau.lt>
References: <cover.1777923233.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s5MOZRDq24
X-smtpcorp-track: nTqGSvd0pmn3.-6h2BFDn5quP.6BtcyQFr_uV

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
+	/* If negative dentry timeout has not been overriden set default for
+	 * cache=loose
+	 */
+	if (!(v9ses->flags & V9FS_NDENTRY_TIMEOUT_SET) &&
+	    (v9ses->cache & CACHE_LOOSE))
+		v9ses->ndentry_timeout_ms = CACHE_LOOSE_NDENTRY_TIMEOUT_DEFAULT;
 }
 
 /**
-- 
2.52.0

