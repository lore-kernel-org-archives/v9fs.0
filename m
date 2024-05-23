Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88312127E0F
	for <v9fs@lists.linux.dev>; Thu, 23 May 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498036; cv=none; b=ugPQ+wO9eS1OKHIx5+New+tU6TpWfpyHpXWzJ+RtAWlRxHbWZUPqywucS6YqYsRyr8Z3P/focYbTlBkMq0Gfpp6gfx+QK2MNGmLe5ItaKDyJPTOLdNIf84ccyp4UFxN/RszzeJPCEbF7RNhM9Thu0vy2J74DYgsMqJCFhuHxaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498036; c=relaxed/simple;
	bh=M7s0vSWRDCFYfDbE+HleEFzeiaxWIsQ9hYliav9ZcNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClbR99lpCrN4M1UwQtGnFSaHHiYXCOk4ExbTa4kZSGf1LEhF5UqawLiQ+fq46VFoCJqO9QGaRvvAlFEn1mfQ9A/8KmGeSYFvYg9GRWqsFKFOFTV3kV5pOi/Q53aV0R66fo+SAbnspzBgSdsLpbAJIhIfPi6GSBgyeDTDh9H878M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ifSUja34; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ifSUja34"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3CE5914C2DB;
	Thu, 23 May 2024 23:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716498033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2tvRl1dT+9coVyGAznzC5MWLzknTsetbMaUwWFZ01A=;
	b=ifSUja34kWxBPSoFJmEKiM457nFHdQG+EVQ0ZwZxlUzkkxj+e08T+0CPgrWvVKb0PZRAyQ
	xhr9hCPcKuzpJHWOUI7e3X7dHgja5g8wXN3wizao9QuKLOyysvhB3y5R3MnQbjKrEciSQc
	KMCF45GEWwRtTd6uXUjGST9Kd1AFZvdb/+Jl3YO3Dd2K+DHoCWDLfsUM5cVobCY4mZMKdK
	cK2sHNsnWBad8qhnQGAhNOd9v/NWt30vNu+9JTaT1isQYE2MLehec0bQMUZqaOYQ6s3VNv
	qlYKcfFApOhd4NudoFeNWjkPeib031p7Jxgj8nrAg0j59AzK8N4EkbjPQV5ueQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 25b9365d;
	Thu, 23 May 2024 21:00:27 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] 9p: v9fs_fid_find: also lookup by inode if not found dentry
Date: Fri, 24 May 2024 06:00:23 +0900
Message-ID: <20240523210024.1214386-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523113638.1196299-1-asmadeus@codewreck.org>
References: <20240523113638.1196299-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible for v9fs_fid_find "find by dentry" branch to not turn up
anything despite having an entry set (because e.g. uid doesn't match),
in which case the calling code will generally make an extra lookup
to the server.

In this case we might have had better luck looking by inode, so fall
back to look up by inode if we have one and the lookup by dentry failed.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v1 -> v2: fix build error

Sorry, shouldn't send patches without testing even if I'm not planning
to apply them for a while...

 fs/9p/fid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..f84412290a30 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -131,10 +131,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-	} else {
-		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
+	if (!ret && dentry->d_inode)
+		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 
 	return ret;
 }
-- 
2.44.0

