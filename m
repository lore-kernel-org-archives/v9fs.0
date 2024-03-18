Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35018374E9
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761181; cv=none; b=U7Jn4KV2UbjD+UM+DCKs4xOjmRRVCQqKK2M4D4sDF6zzILGt1hZUIxuNgWciPvjDCdkh//2Zv4O2lOydn18L5sudcJRr5225Rk/LBHmtQUSqM2lC2s2xonBuKlb73l0F0DzeDm6+eP7nVsxKs/N6KXLdxENVByBpz+xedZ8hGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761181; c=relaxed/simple;
	bh=fBoA/ZVuj4XXc9PmaJNvE74TYP0ZY+ZINlyMG3jYGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx5K/crXgsIdMFY3N23VcQ8TIkLGzSJrjxSjUoIAP7mfn7X0nCpJcBKlyOb3YL7Hbp+D9fsUPE8B/C0KomFKbgIRgisQ2nP/LYmov9mleDsrWtyTRMNhpq2O57ZgtFed42BiasBLF4NJ3OUhz3UM+1+fetETS6tMIn2v09HMfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=JQpg67tb; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="JQpg67tb"
Received: from localhost.localdomain (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 2775E32539C;
	Mon, 18 Mar 2024 12:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710761168;
	bh=GAOe8Cd9W5lYFDNnzzGvir5mykzKmwgzcDhPWyEG/Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQpg67tbYDKBIqqxP6SY3Y8m6eF2vTyWAZ5KOkepPelatB/qvlr9gly5WQ2elGYvn
	 CJjBcIOQybpBsqyGSn6QMJwmZR7vIMLLTbvr6J4/KleSbpQzSGWBmp9l3TXxYPuLMN
	 eaInDQeJymwMSemgLrGoxgB1przQz+kuAa/J+a5c=
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Cc: Joakim Sindholt <opensource@zhasha.com>
Subject: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
Date: Mon, 18 Mar 2024 12:22:32 +0100
Message-ID: <20240318112542.18863-3-opensource@zhasha.com>
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
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 941f7d0e0bfa..23cc67f29af2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -310,6 +310,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.2

