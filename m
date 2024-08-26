Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A25228;
	Mon, 26 Aug 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634597; cv=none; b=E2tCxFjSFe7YMsqOUa+K2/0beSsRH3atgdC5Vrvr97xdJcg5BdfPjoCHwqOJ3Npe8ejFAEWLtos3H47nORd56z8c1ObRKMW7M1+jdr+baiEwwZ+kVgz2VUtq88lbN+v1aucWTrvcfFxltIbNPKIfhPQ0JuyKut1vLIV99J/hNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634597; c=relaxed/simple;
	bh=EfzpTOP5OovwHBqThSFBP/stRU1MypontvSDuMhO92Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGxAyAKSiqzZeWlGy7/n4pW0852Je+zTsfkGPzWaj9XXImGOUVdCMa1rPV/apuBQuyN4swRwNmeLEAKuf0kWVBrHYkQ9iUNUpXLhPsK7Lv5HVLPjuGR/POejjbiekPT6idMrAPZZOdaDJFVAq320nMtuV5QZUnVgkGWdNeIRJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkOwTB4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkOwTB4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11B9C4AF18;
	Mon, 26 Aug 2024 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724634596;
	bh=EfzpTOP5OovwHBqThSFBP/stRU1MypontvSDuMhO92Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkOwTB4iWHu2kittAe1VlEqwCb2YNsyZLPlvlJEP+RYDW9KeMjVvD8vYQk+WF67jD
	 3qp+u9jBYTPVHU08qIpJxIdw0GcvR0AOHRxcJWG1hWBlPMPPD/sAXUzSU5vJN4piIG
	 nFBUCvZx+2xxL2BbCuwZzyMgURoI1+8ko7MIapVAYR8zU6x7ZY6j6tqRbc+W9iNJKk
	 IMhp750UZOrZyWb5fp8LM5l0S9XVPTWpSCC03tv3BJGg0UU20/uJGtInKcTInYbZkg
	 nWPE7keih5viYr4mjSzAFTgwjt7GP+Bczg+arA/zEAXVuqi/4+7p3N3OcX1+dMpxd0
	 PJ1QKbo8NRhCQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: SeongJae Park <sj@kernel.org>,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Docs/filesystems/9p: Convert a goo.gl URL to original one
Date: Sun, 25 Aug 2024 18:09:49 -0700
Message-Id: <20240826010949.78305-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826010949.78305-1-sj@kernel.org>
References: <20240826010949.78305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Google URL shortner will be unavailable soon[1].  Replace a shortened
URL on 9p.rst with its original one.

[1] https://developers.googleblog.com/en/google-url-shortener-links-will-no-longer-be-available/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/filesystems/9p.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 1e0e0bb6fdf9..50dc82f33726 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -31,7 +31,7 @@ Other applications are described in the following papers:
 	* PROSE I/O: Using 9p to enable Application Partitions
 	  http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
 	* VirtFS: A Virtualization Aware File System pass-through
-	  http://goo.gl/3WPDg
+          https://www.sciweavers.org/publications/virtfs-virtualization-aware-file-system-pass-through
 
 Usage
 =====
-- 
2.39.2

