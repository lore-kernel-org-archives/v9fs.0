Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6B13AF5
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD20C433C7;
	Wed, 19 Jul 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689779840;
	bh=ysLR5wobitKPf8JrxKamS+gYhvSQgQK2wwYl0cnu1PE=;
	h=From:Subject:Date:To:Cc:From;
	b=PlfNTQDW0Gmv1RaV4rPthVL3t4AOzNBSe2PJ0jVSvxy0kjIwITjPjKKJouIh1KU/e
	 9PfAGONXixqLgNcte3cw1giWGhzXYiuaK00okYWrYxum7nPVSHltp4Dgu+y71HT0Wl
	 480g1FRkkdVzHe2enOVkrtl9XXqfoDpMHZwLE7GYWAPtymS+hZ4Mc4vTUmNBXYeIhx
	 TAwGqSwPljSqps0B3sl1hkiQWxS0/oAs99M30vQxitiXf3qK/FoIagDIQUofb6DMuL
	 n+z7jOIDfKV2Bz3Z0Bs6EtXC2/1XRMXDeKIQpfj9fSKI6NcphUpPlEQZTsn13RoK42
	 H64ate9P+8CRw==
From: Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 0/4] fs/9p: fix mmap regression
Date: Wed, 19 Jul 2023 15:17:04 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHD+t2QC/5XOzQ6CMAwH8FcxO1vdh4J48j2MhwFFFmUjHVkgh
 He3cPOmhx7+bfNrZxGRHEZx3c2CMLnogudg9jtRtdY/EVzNWWipjcxVBo0bMUJISO8JCONArhp
 cQug624ORVpuzVJhfcsFGaSNCSdZX7arwrSq1xyYQeByHdaMn3Ege3x+cWxeHQNP2UFJr99fbS
 YEEmV1MqbkKo28vJI/vQ6CnWOmk/+I0c+qU1xlbTVYUX9yyLB8YSRoFPAEAAA==
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, stable@vger.kernel.org, 
 Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=ysLR5wobitKPf8JrxKamS+gYhvSQgQK2wwYl0cnu1PE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5+El6+7oA1ENNSlafzPFG0wmMLyaf10zHKO
 KWsRc4dp4eJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fgAKCRCI/9X7Sl//
 mO6xEACdcMUN6ZONVl6MaUH4zg1r7hs4oqp5fDM3fn8ui/ETaXv0yxqXw+83ZrrnnXSrBps8ZgR
 1IfxSsVTKB9A99KTDMxmH05ONKLIQ15qKzBlU7EZV5H2dbr56ddxluJB8SyQbCFPbHHQWR1vAel
 rcj3wNMDwlc1+fp5KQ4q1w+guaAy9XttjbL1gmS57n+GHWKwHXrxJZO5HiKd/oZHNxq+AlkA21J
 xuQGN95iYlsCTSA0mD2e1kpdRapz5sQyjvV0E4SGSlcGoxWTon5fecCze0N7addPooP3k+B+xJL
 eYPXKXecjvUfMcTtJhyyBiCypXzIBKLvECpn6ZpINTY+iaQv6Ug56m7qtpJlTy0vvIyh4+MAPLo
 lsrpsOSvE3M/VDeYu47prGkPzao1l2ntCWtFByH36KVtfP1cBgd11HphNccsa7qhyxz7H8Dcv+V
 GaXMwlTDp5KUGCuL7NZ0LOa2xW0p4KmPF2qhIG94K+9+g7RbfMzkNgHqN+BsQRMH2e6tXNrWcPN
 yt71qf/Sfu4jcURrM+R+NdqzF/9q7j0HkHSgJLn/2gB2A+qg7cC/hXZe8iv90g8EvWC10zCchKh
 A1laxFV0o0iO2e3Dfn9v6CGCJyv82Jvvmo6GQfgNLS15jk7jJ8tUj5hvZuPCvhUE2yAgC3e8F77
 HMR7H6s7Bpwim3w==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This series attempts to fix a reported exception with mmap
on newer kernels. 

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v3:
- Clarify debug print to read-only mmap mode versus no mmap mode in
  v9fs_file_mmap
- Fix suggested regression tags and propagate across series
- Link to v2: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org

Changes in v2:
- fix requested changes in commit messages
- add patch to remove unnecessary invalidate_inode_pages in mmap readonly path
- Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org

---
Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

 fs/9p/fid.h      | 6 +++---
 fs/9p/vfs_file.c | 5 +----
 2 files changed, 4 insertions(+), 7 deletions(-)
---
base-commit: 95f41d87810083d8b3dedcce46a4e356cf4a9673
change-id: 20230716-fixes-overly-restrictive-mmap-30a23501e787

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

