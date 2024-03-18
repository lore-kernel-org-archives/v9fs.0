Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF9374D2
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761181; cv=none; b=pR6x/ZavD84kPz582Jn9CbpByAo9mWI7l09kKco3gK0Mo+Fhl3Wwp4v+0s9oKZzKjb0qv44aPYWtyTHTp7g4/ZlP2UQiU/VMKepmxC0tAjywmfNU+I/znvL1mX9g/yCYKJGUUFmtizdlpf5jC/eFKjbAa/fTr1YWg9K7S2Gcax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761181; c=relaxed/simple;
	bh=w/o0rBrwx4L5j9FAAWuCiTxWCcWKc945olpJN0XZcSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQdsi+5EcaezmDWtqt/8EhbUMa33Q47mEDY16n9vAZt3LFuxKADMYs+qZ+jK1u430UN9rqPoOLtznov28QYzaycVqWzavjIFXdChMGrL5l/03EgBGK/saYcIbpOMtiFJSWgmA3mO1vRim5V5HGUY6YacK+oqfNV8h4dd0z1JdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=aYTXshMi; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="aYTXshMi"
Received: from localhost.localdomain (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 46C3932539E;
	Mon, 18 Mar 2024 12:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710761168;
	bh=bF7lYMPfodz2FpwZ3JfV1WLCrwViWNpA5vGulXInli4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aYTXshMijQ46yXAnBPO+AAlTDpYEC05gwGM1a4DBh167hdsvr7To3nVHgc1o4JMOB
	 AclFCYIVVqWrdaLi+pocjcUxT9e4DKm1uPa7HBJ8lXRP9d/8/BTLritVCIIFZ0RgdB
	 4kzH58H6gpRG8N770qtdOjduspiXhq8vrofurF9A=
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Cc: Joakim Sindholt <opensource@zhasha.com>
Subject: [PATCH v2 4/4] fs/9p: fix the cache always being enabled on files with qid flags
Date: Mon, 18 Mar 2024 12:22:34 +0100
Message-ID: <20240318112542.18863-5-opensource@zhasha.com>
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
 fs/9p/fid.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 29281b7c3887..0d6138bee2a3 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -49,9 +49,6 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
 	unsigned int s_cache, unsigned int f_flags)
 {
-	if (fid->qid.type != P9_QTFILE)
-		return;
-
 	if ((!s_cache) ||
 	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
-- 
2.43.2

