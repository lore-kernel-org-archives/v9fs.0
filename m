Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329ED374D3
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761181; cv=none; b=E2qXr5hlFtEdy2Kf0gsKNBuXHf91NFBsGhlxG5JLkLLKTs6eBH2Hs+2iuwVDS9cbRgbvFAOmnGS+9FFMoJ3BS38Z783lyCn1d+k8GODjq6u+M0kNOquLJQX8MT5gp+3dMR08+AYTQcUJLgpQxi9rLoleyWeT21HpB9FvgpTvTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761181; c=relaxed/simple;
	bh=ngfGFDKdvJ4xtRZcFGSFN5zAf4TsRcN9PigOhDe32Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvhIRfUOWwR6vCUme0jL//ChVxBeO9K6ZnPgh83ciAWCgx2elSqaudPsiv/p1Gt5KTDk7uBB5DLcQ2eB2ScBzwLsUhflR22dvKwuBoGphJ6VNwZLsQ0JSIuAcPTUxX55301sFNEHCET9mgFJxKE6HKUvOYXexLByl2J/qUxbHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=OxZjLSUT; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="OxZjLSUT"
Received: from localhost.localdomain (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 370EA32539D;
	Mon, 18 Mar 2024 12:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710761168;
	bh=FwR84NY4Fq3RQ28ZavYtrBchBkoth35FkYRwVZ/Xe0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxZjLSUTXzyU+eFhb9yEXjmIDj/TfkOXUpwmM8mXAnS9PtvwX+xbO2Q8EbIUJ+hO3
	 ekycDGZYknLcPJ+lXb7Y9n+BAOuD1sc0EgulgHfREHj2D69q7Wa31CodnzW3vSb8kA
	 HEEgBhC3j+GE18DXqgE+UpF9HKqGn6KU/JPiacbk=
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Cc: Joakim Sindholt <opensource@zhasha.com>
Subject: [PATCH v2 3/4] fs/9p: translate O_TRUNC into OTRUNC
Date: Mon, 18 Mar 2024 12:22:33 +0100
Message-ID: <20240318112542.18863-4-opensource@zhasha.com>
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
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1180d1453a5a..8f2e0fcfb303 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
-- 
2.43.2

