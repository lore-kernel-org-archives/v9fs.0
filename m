Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AB381B7
	for <v9fs@lists.linux.dev>; Wed, 25 Oct 2023 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XxJ3AoCG";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="R+Mzl8Wb"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 51EF7C021; Thu, 26 Oct 2023 00:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698273081; bh=s0T4j+oFkJAnGVqQY6I6/eKO/edOXtDsKiM/6aI97S8=;
	h=From:To:Cc:Subject:Date:From;
	b=XxJ3AoCGAHfrjc+6Mnl5RGtPO76ic3hB6bpWyMM+t1YjD4dFBq2CWCy1dfNmIsqpJ
	 uLCPR1yDlEdb5D1940/5He/SrrXPtcoXvIWdbA3tVqqavLRaqhny2XwHRKaRGtcG+a
	 Kqq2lNt7PR4kP4wBXytJhdjA3TFst3LuHZiHo2WV6Yae4c8r2ZNuh3xJU9w5prKIq6
	 HQ3ANEoooDb0MMGERP9mip3lLTCGmt24oWRwkYcSH8zK5c2X7vjlnSyu8xINHX/UeX
	 Y/tzv/K7RmTqwJJmno+Z8nvsqElKvySTAAvAwRStNQkoIPPAXZNnpWYgJgXQAf8z+P
	 yG0qFoTIo6GSw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 4CB2FC01C;
	Thu, 26 Oct 2023 00:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698273079; bh=s0T4j+oFkJAnGVqQY6I6/eKO/edOXtDsKiM/6aI97S8=;
	h=From:To:Cc:Subject:Date:From;
	b=R+Mzl8WbtJ0nfZ/XHARYfwXiFd3Ys+O7yzFMZV1gZuR+LRKXyh6ODyPsv0Vcc616j
	 h3bw9GX9cDN3PDXWQzx2GE2dWcHmJ0B/y69Z77n1rAkwyIrdYykhFwP1TMh9Ob9MxK
	 xbaqKPVP0oZtU79IdCw3b7k4joVAEnmL7+V/TFDbCNgV0mYMQl660Y3DzQlJXhh69c
	 90nLxLlmjmUu7NdQMeLtgnK94Yfq6u2Rd2u1Jo0HJ43yd4h0ctSyXfGJP9+bDa5COm
	 wVl1HKQNrFvbUbM1GHh8knGqk/qUeKzdAhooraUPRd49KwOATIYcRRiWh0/TRqqhSk
	 W5zDqQ5lwBnhQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id cdd0c0cd;
	Wed, 25 Oct 2023 22:31:13 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p/fs: add MODULE_DESCIPTION
Date: Thu, 26 Oct 2023 07:31:07 +0900
Message-ID: <20231025223107.1274963-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix modpost warning that MODULE_DESCRIPTION is missing in fs/9p/9p.o

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Probably doesn't really matter after all this time, but noticed this
when double-checking there weren't any warnings left in W=1... Might as
well get rid of this:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/9p/9p.o

 fs/9p/v9fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index d525957594b6..61dbe52bb3a3 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -732,4 +732,5 @@ module_exit(exit_v9fs)
 MODULE_AUTHOR("Latchesar Ionkov <lucho@ionkov.net>");
 MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
 MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
+MODULE_DESCRIPTION("9P Client File System");
 MODULE_LICENSE("GPL");
-- 
2.41.0

