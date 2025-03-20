Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F01DED47;
	Thu, 20 Mar 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482334; cv=none; b=pv0dnjgbp6BDF+K6VXrmVMxEotVpT4AIKG0BribvEsD2IHK4HjsQj8T8Uc1BU5jC0fPwYzCMT7D6GHcfENrKWowllvssz6l4KxJBdlMLYWRAE/Ddba2xt3ZBvwjyzJ/KTs87KK5EFKnlBafSpmrLwoVCw3dhGCrkgXsyHMUiQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482334; c=relaxed/simple;
	bh=GICyxcRx3/pVhs6pTz7UKNZiPZK/RiZuJgS7cozIW34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nsJWNnopOdwXAC4VhTwpv7MAFamm52dKsOrrCUHFOU0d3FrcQumgco1Fqjv/pbOvvEBY3FLzM0BUf/pc7ycUFLc8Gc+PefEPbinew+uINuqIYlITDmkyTefiL4sj6+4W6dZNQC8hndpgW7qr+v7Z9OHKRo1r1kXZydT7sqYxxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO/dktcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO/dktcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54052C4CEDD;
	Thu, 20 Mar 2025 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482334;
	bh=GICyxcRx3/pVhs6pTz7UKNZiPZK/RiZuJgS7cozIW34=;
	h=From:To:Cc:Subject:Date:From;
	b=EO/dktcORDSeTi3XS7WwUI0rnCkuZcDhAgCzt1WJwEEnsjZDW7WAUfFmNI1bsvM97
	 d9oI+1nn5RNeWziBr6fRX5IShI52KZ3jLOnkmTBxbyR3svdgDmJhS+4yxPXhI189kR
	 fC4urMnUdvv7KCQblrzJD0RMFRq4ZN4MvAEZagi1kHD14M/4h+efmTqjHj1NAg3I69
	 CEjR+nSHIQcz79EXk/60HXdQZw4Tqh3mYxQc+/1feoLXcFHJ8vUSP505iy9odYQOcX
	 qqJDY6d055qKfEp3HsZoKbdj3Q9xCYizSAhz44LZ+EPMdQpDr87pBPVk+nQQZRK8Ud
	 y0oKerTIIRwVg==
From: Sasha Levin <sashal@kernel.org>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] 9p: Use hashtable.h for hash_errmap
Date: Thu, 20 Mar 2025 10:52:00 -0400
Message-Id: <20250320145200.3124863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert hash_errmap in error.c to use the generic hashtable
implementation from hashtable.h instead of the manual hlist_head array
implementation.

This simplifies the code and makes it more maintainable by using the
standard hashtable API and removes the need for manual hash table
management.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/error.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/9p/error.c b/net/9p/error.c
index 8da744494b683..8ba8afc91482d 100644
--- a/net/9p/error.c
+++ b/net/9p/error.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/errno.h>
+#include <linux/hashtable.h>
 #include <net/9p/9p.h>
 
 /**
@@ -33,8 +34,8 @@ struct errormap {
 	struct hlist_node list;
 };
 
-#define ERRHASHSZ		32
-static struct hlist_head hash_errmap[ERRHASHSZ];
+#define ERRHASH_BITS 5
+static DEFINE_HASHTABLE(hash_errmap, ERRHASH_BITS);
 
 /* FixMe - reduce to a reasonable size */
 static struct errormap errmap[] = {
@@ -176,18 +177,14 @@ static struct errormap errmap[] = {
 int p9_error_init(void)
 {
 	struct errormap *c;
-	int bucket;
-
-	/* initialize hash table */
-	for (bucket = 0; bucket < ERRHASHSZ; bucket++)
-		INIT_HLIST_HEAD(&hash_errmap[bucket]);
+	u32 hash;
 
 	/* load initial error map into hash table */
 	for (c = errmap; c->name; c++) {
 		c->namelen = strlen(c->name);
-		bucket = jhash(c->name, c->namelen, 0) % ERRHASHSZ;
+		hash = jhash(c->name, c->namelen, 0);
 		INIT_HLIST_NODE(&c->list);
-		hlist_add_head(&c->list, &hash_errmap[bucket]);
+		hash_add(hash_errmap, &c->list, hash);
 	}
 
 	return 1;
@@ -205,12 +202,12 @@ int p9_errstr2errno(char *errstr, int len)
 {
 	int errno;
 	struct errormap *c;
-	int bucket;
+	u32 hash;
 
 	errno = 0;
 	c = NULL;
-	bucket = jhash(errstr, len, 0) % ERRHASHSZ;
-	hlist_for_each_entry(c, &hash_errmap[bucket], list) {
+	hash = jhash(errstr, len, 0);
+	hash_for_each_possible(hash_errmap, c, list, hash) {
 		if (c->namelen == len && !memcmp(c->name, errstr, len)) {
 			errno = c->val;
 			break;
-- 
2.39.5

