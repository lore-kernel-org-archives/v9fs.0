Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36906374EB
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761179; cv=none; b=iNmpEZdg0/IJ4gPZscwWbw485WDCrAWogGxMymOdwgbIYTsyF994ezJuSRJE01S9Ouvtanltgdjp57WcePJ+Ss1hBHvR4R7y1TT4se3xDr+j4/AzVN/WftU3sg7Rkpbd1gsYIkomfTl20fseQkGlikJsDef05gkwgaRT5Thc1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761179; c=relaxed/simple;
	bh=WiD9Zf6gkKdRv7a04KqDRYGwN6FHh7IolBIC40I2SOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhbbTo6jlZlKvhRmZ2OR9JUewyK18gtdFn6WA++LM2/L99LmXfWPxH1xzaylJV+QncjdDiQ1Oa2weKpaCAy6+8ZV3QsntaYqZUKfV2ZNoD0h0lt1RpdKVY3RmnUJdrfZeVMfUNfhoWdzBirMPW2grj/yuZNe2sWatkJEklPeLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=RdbPde5J; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="RdbPde5J"
Received: from localhost.localdomain (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 1846D32539B;
	Mon, 18 Mar 2024 12:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710761168;
	bh=swXzucw9zpRyz/6vatGs1dOV16XHKiwYBQ13TCtb/zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdbPde5Jd2xKc9yBfoMrwkjFNYqGmdRwTNX9/bPEW5VNA/eYBGrJRE3vS1EflnkdJ
	 VrjXor54xaxJLA2uXpPjTYJEzdm95THm88BMRwBkhRjuFFOGT4YPM0CNHc3d3R2qYo
	 zQv+Qf1swJvTo/1q/gvDr3PUjVNlvjwkePCEK9m8=
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Cc: Joakim Sindholt <opensource@zhasha.com>
Subject: [PATCH v2 1/4] fs/9p: only translate RWX permissions for plain 9P2000
Date: Mon, 18 Mar 2024 12:22:31 +0100
Message-ID: <20240318112542.18863-2-opensource@zhasha.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318112542.18863-1-opensource@zhasha.com>
References: <20240318112542.18863-1-opensource@zhasha.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
---
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e..1180d1453a5a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -83,7 +83,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & S_IRWXUGO;
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.2

