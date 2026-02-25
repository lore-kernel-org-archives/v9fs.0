Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DB29AAFA
	for <v9fs@lists.linux.dev>; Wed, 25 Feb 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990744; cv=none; b=mAMLURC7LGB02lfbPe/HUWq+CZXfFRiodUBkIsxe+WFRAUnZQsJoUmrrFsElkgNtRQLyewvHtvyRSAblHASV+eoD8xR6dHvJIE+E5xvLG8s18e4Lvj0TChylMghwPKQg77wPiWsFyfJTQCN+QyVyFEGX4eDFZkNofGWVZuHev0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990744; c=relaxed/simple;
	bh=DIh8WtJKsYfFWmCLOMLa1uDVR3z6AtCB+KFcTxnsk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2MwDBB1h3mC7jB8LxrcfI5Wv3s4AqPzdk7eBmrxj2naZe0yP4yORdxL49OePNtCYRt+jNL8h9UcuKs40OrFt0HEAELVzWYpACtSQqrX0o1sjR+PzsbrSIgBY0Fq/T+pjSqanvUp7rZ6VL72Uvs7Zh40pE/uZTj4m2LFHCCt2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhDYHp4n; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhDYHp4n"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-358ed696623so565015a91.0
        for <v9fs@lists.linux.dev>; Tue, 24 Feb 2026 19:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990743; x=1772595543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=NhDYHp4nQzepspYByRT/7cu1FB56doyvZEU+elb8U1eCKOw0te8z5Ijrp2rpaa8dnW
         us5/QYK/+LnEjEadVdKI/RvX1XMwEJZozCuKIiItFdm3MdR1H5pFaJJNtFIFlcgRuQKb
         EOET8v1zG4GwZVg4a02GBs8I+H6VtxrEHqc5QSVqiKatT9U7B2FCn4LyDT7jp2RRfodG
         MQ6L8O2NiF1h52vVyjPkjeiDl2uH432fCP+qCgRJFD2TqZuPf1v9/xgS+jqOOOPhrBvs
         aaZAnqDtCHHceTqMxoiz7BCm1omYpT84Ub8PYOAYLbzA7mz6/Hje5YwY2CUaJKj8U80+
         BlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990743; x=1772595543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=nJfNKySMqjxyBTLrhyi7W7fxLtKPLxkesWnanU0/q3eSvG0V6BZu5PAMtbhBnYsIPF
         aEjso8BCLhB1p7Psisbm9HsS6nmVAZGG0LjmdLj+2UXH956/lDXcx1QPh9X54NbP1mWj
         AoAn2GKdKx+o5P9eExWBa3VmLD+VR88kdZzPQVHAI8vZxoU1AcgFY/UB9H3h3Rwi/LfS
         bYh87ZZbVyjtOhBFSLkJXKG+RBZCdVZSN5ua/AD+aiL4qsWZAY2gpYSDsGu58GEn4KnH
         mUDcT7mVBbyqT59vWBi1t32oE2K6AXY5Xh60lc7tb0CNsdK/3lEizpKu1fj07xhJnuA3
         iUeQ==
X-Gm-Message-State: AOJu0Yx9yjYDcvV8fEQnVGI77thvP0NOIYT4ZBu3HBhOY5KjfjJ27qL1
	KxtIb2O8cdsrzaL8D+R3lOqCbk07zyhXNFKqXm6ESU+3pMNjCJMn9uAY
X-Gm-Gg: ATEYQzwqvRdAMB0T5ZnDGgACBAYQ6sTTul3jm2ha2Nd90lW12a1JdZIUL+YJJLjNPNL
	1BrAG3L95IUcJcggMdkKMT4B3aGm9DKe0ZxE2C0uG8rSacHuMN8q8IXFK+2jCeAk6QLkQUwta3U
	pyKuB8uylQJiDCi0+ilPoYEhwdZl0ouJgLq0wDs4XcQXBewIU7vAtiJ0wdxOTaZArU+4DeLMQcx
	Fsw5dsDxat9Dz8Nen23EGTywcZoR0sae7go0q8xi4BzS5122mkGXO07Fq243X5T/4vJHBBk/4KE
	8iJ7zh04u36kB9prH1VI2tAwRXzlK2bq5Fy3gwn27YUrKG+3DdVKtkQ5QRvECCCiVPVsjA/x9nr
	clhRBD2O6EE7bPyQQ31DVEQnddJ/SwvdzmCy9mPdkv+I8wikbsTvyc8EqF3XQ4tewFMQFadtXB+
	gco3qUWXUTJyUmWGjQDp3F9ryWtprTN+5xG/2cYVJQlKAJI87eRo9kVI7L0OCv+lsWHFk6kQ==
X-Received: by 2002:a17:90b:3f90:b0:359:7eb:d922 with SMTP id 98e67ed59e1d1-3590f226ddcmr865260a91.30.1771990742896;
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 4/4] sunrpc: sysctl: replace simple_strtol with kstrtouint
Date: Wed, 25 Feb 2026 11:38:40 +0800
Message-ID: <20260225033840.33000-5-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=ericterminal@gmail.com; h=from:subject; bh=VO5IMzOC4K3hwnb1MwA7obneQq8hnuATlXNUArothF8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5NnFy7tzFYvrrwYZrvs0uTl0WyZgj17bh7bWXj9H ktUtqdnRykLgxgXg6yYIsvd//vm5nrdmnOd+3AuzBxWJpAhDFycAjCRB7cYGfYkbQsNc83T5D7V EcAdsUvkgG9N148DEm3V4R0XV915FMTwz9S6piw0ccG+fidP1kyRFuYGXW3ZZ3eK5hY4sX5+P2c LKwA=
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

Use kstrtouint() in proc_dodebug() after trimming trailing
whitespace. This keeps accepted whitespace behavior while enforcing
full-token parsing with standard errno returns.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/sunrpc/sysctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index bdb587a72..07072218b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
 
@@ -65,10 +66,11 @@ static int
 proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *lenp,
 	     loff_t *ppos)
 {
-	char		tmpbuf[20], *s = NULL;
+	char		tmpbuf[20];
 	char *p;
 	unsigned int	value;
 	size_t		left, len;
+	int		ret;
 
 	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
@@ -89,19 +91,17 @@ proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *len
 		if (left > sizeof(tmpbuf) - 1)
 			return -EINVAL;
 		memcpy(tmpbuf, p, left);
+
+		while (left && isspace(tmpbuf[left - 1]))
+			left--;
 		tmpbuf[left] = '\0';
+		if (!tmpbuf[0])
+			goto done;
 
-		value = simple_strtol(tmpbuf, &s, 0);
-		if (s) {
-			left -= (s - tmpbuf);
-			if (left && !isspace(*s))
-				return -EINVAL;
-			while (left && isspace(*s)) {
-				left--;
-				s++;
-			}
-		} else
-			left = 0;
+		ret = kstrtouint(tmpbuf, 0, &value);
+		if (ret)
+			return ret;
+		left = 0;
 		*(unsigned int *) table->data = value;
 		/* Display the RPC tasks on writing to rpc_debug */
 		if (strcmp(table->procname, "rpc_debug") == 0)
-- 
2.47.3

