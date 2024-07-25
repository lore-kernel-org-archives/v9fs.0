Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEA23D0;
	Thu, 25 Jul 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930475; cv=none; b=NV6LLrWDSdcQtuZboN2tONqHrDMG+qWEbTAG3Zksa/k+DogtkD3yie/MP/uChaYqtfgokW0Plw32m4UsDyloYeVFUn6GiA/zD9S9KSz7UDRGa1TMwjSmQU3UrgzMAHGOosXxDUDBItmaosm7hBx7aXX6npMnv41CgzmptuLYwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930475; c=relaxed/simple;
	bh=CQWswAaKiUd/1H9VPf7BR5G0SCIN5b4m3hSctlgX3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cB7keWDJuO/CmBpTmX+v0S99Ywy9hsoUrAMqCw01RnpiFiBTJzjVT7zMmsOhNUD9fj/0TMNC0I9Ut/PSuB6fq+XEukUIpLWqwyWxr/6QRTqxEt6WIv1l5htvNo1X5pgC0yKnR/uqXf1iBBnCdD6XaZgNsUKuaT9D5OkzUv3Nc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jtn4yVW3; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jtn4yVW3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0OL4xG2f7OPGglRnI+nOrrSi0qdVFdIQOVDEO5YpO0A=; b=jtn4yVW3DhhxhBUw
	qWdikRA9VIGamBDT/1bZMXNEe+zxvdblkEIP4vBig9E6dlhZT6/ZTliT8yRtJS6baX7haqRqYD67U
	P3pN8xt1+iS4AIyAYHug0BHfifSi1uEPspFxE2CVdmxUsAW9OMX0il9KsugZj3S5Jk8cXhyg9iFCO
	6SBmZz7w4rRMmj4IgogJ4lSB512X+89uHdSY5+6HbqMRAGAVcuYze9fdUeBNHekhSqACllXo9vo3T
	j+wywhpB2uu2pvEcwiSsSJ4iFpYBqnMsBCvGChWF/hDGaI5+/HimFBi77xpxmT/mwwChzExsrybtE
	arI+pdQeUrZIctMk9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sX2lt-00DEap-06;
	Thu, 25 Jul 2024 18:00:57 +0000
From: linux@treblig.org
To: ericvh@kernel.org,
	lucho@ionkov.net,
	rdunlap@infradead.org
Cc: v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] Documentation/fs/9p: Expand goo.gl link
Date: Thu, 25 Jul 2024 19:00:41 +0100
Message-ID: <20240725180041.80862-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The goo.gl URL shortener is deprecated and is due to stop
expanding existing links in 2025.

The old goo.gl link in the 9p docs doesn't work anyway,
replace it by a kernel.org link suggested by Randy instead.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/filesystems/9p.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 1e0e0bb6fdf9..d270a0aa8d55 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -31,7 +31,7 @@ Other applications are described in the following papers:
 	* PROSE I/O: Using 9p to enable Application Partitions
 	  http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
 	* VirtFS: A Virtualization Aware File System pass-through
-	  http://goo.gl/3WPDg
+	  https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf
 
 Usage
 =====
-- 
2.45.2

