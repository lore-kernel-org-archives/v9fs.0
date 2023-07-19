Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118D13AF5
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62AEC433CB;
	Wed, 19 Jul 2023 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689779843;
	bh=37fxouyOhTLlN51p11xeLF2Xq6fH1PuX7PAunRa1+I4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fylAeVKuZFgjAnD1Rbim39U56NZuBKOVKurcYlSzFSYgdYzCcVRgdWKtmDP8BIb8X
	 irT9O6qEfUYfN7IkSyHpADgOlsW3uzZV8eJW/FPIeYTInOw3WZX04YljcvBdoQMtwX
	 LU9p+6lHxJpr+LRjd+o2jXa7BE2xZqgXOe/GQQ6EgswaUtdAY5/v3Sf1sawn1qT5Z7
	 TIafQfzfn11/SDxcpGw72B9Y8GcCUkmOsyrlqZPCiZ5nx9TVytCWLDMgtsl+KqfIW+
	 H0ZxOhNhsjhOwPJEbJRDp57+X4VCvE97Z8kEgfZqtf0QR+PUzfkjPfzhkARjREd6G2
	 JQMm85MEBwRkA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 19 Jul 2023 15:17:07 +0000
Subject: [PATCH v3 3/4] fs/9p: fix type mismatch in file cache mode helper
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, stable@vger.kernel.org, 
 Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=37fxouyOhTLlN51p11xeLF2Xq6fH1PuX7PAunRa1+I4=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5/NwNmg5qgKtbbcoMgW80FHdRrrxHqqWmhz
 2n1QoBKK2qJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fwAKCRCI/9X7Sl//
 mBamD/9iUHjCZ0miq5COrTtaDVZNcwtUvz0doOrSLg6zYoajcTbAiy4PdqPp8O4ZenpN7R/T29J
 sUGXZ8alc7Zr0M1ILxSqgok1y9mCY4Oa9Cm/SUv+rYxW29+id4od2wcEeDvui8Zmt9gsdr1DOcj
 j0dfZCuMqjQZX2sJSC8Ej66JcelxE7n19RES54JZIq66bOWL8e9goFce9R1kHP7XONEKipNL9Ia
 mrDsoXSC9fTK7Rr/FfLKDDuJaozbdM3mubfXOVDMvGY4LOElfs/B1Gq7VwFckXKIdjhAQkALify
 +UpIwqbK6jNppC21fXJLP97G4WIQzodpq/QTzBF+n590RKPvpiIMxrAIU5ReUhtrksDgVkw8ETp
 72YAhRXHJU+9m6B+Ld3TVI70Swj8uVp+0BSrjX0HRghg8JIedOD/lhMfnj3D/Vp7m4jUsTcTjxu
 GNknf78iSbzfOa0ZTpwpRm0Wg6XqbVT7FfoKddOp3KPARi2CYa6yoxWDinOtWJAO9wcF+MSsk6t
 DV6wcJrOqNUGe78rcSPyrqrqW18jazl/sloFJXmmGgz4iFnG8hob/a0AgYgJ/CnAenIG1k35W6v
 mNFDNcJbIVWHti3YwC+289Bfd0X7ayQ/AYSv/7lSRs9S26K8ZO8ARRcB1PvVAe4nw6ZAJV/+fly
 nIWB0prL0tfJ0Zw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

There were two flags (s_flags and s_cache) which had incorrect signed
type in the parameters of the file cache mode helper function.

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 297c2c377e3d..29281b7c3887 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
  * NOTE: these are set after open so only reflect 9p client not
  * underlying file system on server.
  */
-static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
-	int s_cache, unsigned int f_flags)
+static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
+	unsigned int s_cache, unsigned int f_flags)
 {
 	if (fid->qid.type != P9_QTFILE)
 		return;

-- 
2.39.2

