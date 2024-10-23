Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17319E97E
	for <v9fs@lists.linux.dev>; Wed, 23 Oct 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726183; cv=none; b=P9R9q4l0XTaVxrv+D1Sui/NGphtR0xut3SY0Qbx7CemUHuDW3/e8nXElTmoFeF4EzS2sYGXMtYYrg/zznWnZSEMWcTKSAFGiRoNr/KR9JMgMbUrxEg9CazmPFtudj8WMl47Y0lJvb+bpX5A7jqbiSDK5Z1d/J21kp7WZho6l7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726183; c=relaxed/simple;
	bh=C/cHuQE30YbjkwMC1uOTFNa62PXuoR1w3PoqwGmXaKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ejrsAeaS9Rc4PKWYjH5YIC9ow/qbh+mPJHNDxYs04h9+o9lK0BpYq+03G42vAgMTQmZWDGJ8Q+t5sC5FvCDG0Fo350bCypiwgm8BoQlP7VbzgfENMmD8F9ClktVXEUOA7rTMuasnnjhIfo0l0rppbbBQtnGHcqxN+YnOWKAo+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vZ2feB1/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vZ2feB1/"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1647214C1E1;
	Thu, 24 Oct 2024 01:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729726180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gSnSY+YXxO2YDaxOBzqQQYT/RIahqgxrQ7ekP/A+dfQ=;
	b=vZ2feB1/YxxaeAOuadedNlGhobgye5qXAZmqlCZgw2B+lNbufJ2WrUuzYyHMvbxRZP4e5f
	jEL5y6gs5yy60hMuNpMs8K9O4jpcygRY5h53iKEiEGLC8SCiWNmkCPn7U/zklK6rw49gzm
	uzzOwiUoYEa//4PI79cH+OLauE3KV8kaB2niXTrx3RDkD12IUx0vdbv6cgHw2Yyv27SjgB
	OY1CueydYkAnnuOnpLLLxM7Ky559HgpwG4mrIGIgib40sHuNVwvHOvq+I5WUdimdcWbtSs
	vMlMoBaPRNY44iXIy0W7y58Gjzd1vKgPZAUXdNAtQAtw1XWiZ6uYgiTGMEUCjg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 3dcee465;
	Wed, 23 Oct 2024 23:29:36 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 24 Oct 2024 08:29:19 +0900
Subject: [PATCH] Revert "9p: Enable multipage folios"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAM6GGWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINYFKkotKonPLc0pyUzLz8nM1zVONTQ0tzS3SDJNNlIC6isoSk3LrAC
 bGR1bWwsAHnXLymMAAAA=
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=C/cHuQE30YbjkwMC1uOTFNa62PXuoR1w3PoqwGmXaKY=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYbd5YTJuH2ea/xpY5j7iGyixsPyuAOcW0Iw6
 4v8yuQ5avWJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmG3QAKCRCrTpvsapjm
 cJmcD/48cuvEFEicbV6FT1Rx35VbK++pwsdxieRHNCXtdVPOMRbnXPtSfJtC1afcbtFeFFUMc9b
 +zjEyeuqXH4N5z3E07ZPAbluJZDzaqqPA1ZnHbEDgx3BU1aoh1gsCtddYiwx8vefYvifOP+tjpl
 ixWAuCBJR9hhDto6tFSrvAVKJOU0ztTWm526ckvkn5uL7P0tjCJq6yemrI3WatWP9554zlSm7h9
 sumlm4rgOJm+dWmt27ObhckMcs9R7zfC2Jd1f31wJaXZ+KnzKsbzYQTQiptoRKhiEojM3Y2RfW2
 qGMW7oN3JJlm4nj+MQ5KgiIWGgqpZ/ZunsGtaYqCL1Am9sZn7lUujdMgh12D5mhWBWc6trG0NA6
 KnSNQsLJcgaC1Cl8RCYnpgCUbLhMEXbMmfoi2+PGBTdGOTC4tAZR6gjY3Yzmbmjl6riIx2UP5pb
 bC5kHFz/xwZ9zNRsj1paY0dAlwKj/5Wyf1OyZxIaxpmTK1cjNTSGHH+BSBnLgpUsBToB6vKQ+Qi
 QLm4LVg2of9pZM9qAurA0Ss0cZN//qTnwM7YLcRkoBru22sW5+VzVbUy72gjM+wggFWu3wipX24
 iOEj4+bvkSaW1VWASF3qkThr6eLy+JnXPP5/DiHpSedXOMy8LUdlMNg+COpgIx4Mg2cjI/6Ji4o
 t6ItVIT9cr4VB3Q==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This reverts commit 1325e4a91a405f88f1b18626904d37860a4f9069.

using multipage folios apparently break some madvise operations like
MADV_PAGEOUT which do not reliably unload the specified page anymore,

Revert the patch until that is figured out.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 1325e4a91a40 ("9p: Enable multipage folios")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index effb3aa1f3ed..fd72fc38c8f5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -295,7 +295,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
 		}
-		mapping_set_large_folios(inode->i_mapping);
 
 		break;
 	case S_IFLNK:

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241024-revert_multifolio-3e117978b5c2

Best regards,
-- 
Dominique Martinet | Asmadeus

