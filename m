Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D168BB
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE776C433CA;
	Tue, 18 Jul 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689713422;
	bh=2UE7/GpbCo0ZLCDtrowUpPJ2/RFcc5BlXQYiwH9D9H8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j5IlBFobm1C45XEvDknqzROzNQfPaWX0bWHKp0csPkt+XIXS3HvpQT7weNalAQBGd
	 444YCSDy5RF2bUDvqdrVbb65X7PeygRyBBxLB7Ry6+UkY7xdivw79Yq7poXZEDyDSs
	 nMtChEgicZ6SeBP+OypSJaQhiXwqv32D9m+sg5vBmMjLYemeXgJHDV+etm3tdPppgn
	 XYpNI7LtMHBbVtycvUHiESfWRyZ1sLGC+SvjH/uPBZ9RaaSO0dtc3vVGTYiI0+jppk
	 RLqa6rZ/UHkB5J/BwZattvsKraOY8Xl9AilFQPdITysBiOis6jtxCDxUAMEcVxj2Wr
	 Q6+WeH1OSUV9Q==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 18 Jul 2023 20:50:15 +0000
Subject: [PATCH v2 1/4] fs/9p: remove unnecessary and overrestrictive check
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v2-1-147d6b93f699@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=2UE7/GpbCo0ZLCDtrowUpPJ2/RFcc5BlXQYiwH9D9H8=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktvsMxhws6YtW15OsmDYDsLrt3VSaPGiYjno1y
 BPJ8rfcUaaJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLb7DAAKCRCI/9X7Sl//
 mB5JD/9jTRJO0ZCiXN97lvdEJl/K4A3/oYqIg+tEx3Eqz+D9M5xBYx6CnkB0dFTWVvVbgWgCrr3
 qB73CX0HY2Awao3H5CON5bH9+jA6mMhPNgs2N2sOnykog1/Mo+sUzik2OLgh/tKHal0euSArUAY
 PQC36KETj3/c1PmYD4BzWOaK2EtOIqSHUvibdQsiKBW0IuA4yylvy+Udq9tpfmLHHK+ZGdM8ltH
 PH+BfrNhtiffgeb3Qo6q1HIxwJMfV2e3H05xpjvCxBINHc2Vtxv9A8bo8r3PjTEAHdYHW6cwP93
 oAQGl0G78oKUV6btn2CO/qkStXzrailiktHxlTewZIUWmyAfaH/nuIYW81IdzNPBwb6/mqp57Qt
 RX+/1Iyn9HJVrLSAr3IxxPnIRQT+Biq0xBthfqkb2tqz7sOMt7Xg+J4QKVGckr6HLe923YmKZzo
 lyG1QIGj+I9/odfo/gSF+pzKDz6ya2V90ae1T9E7unM2tvwn/P6Z8FNbth6opOzFWpY3EpVEZoO
 OFdAmk9h2+sGL8zZ0o6XuviQUXRxMj6qIFxjzVMie6z8uyWIX0amZonHDVdRVWHLLhaI+pzy3Na
 VAoGAbD8WfWnXLDf+Ycdy1TYLquYOa9fbS7YljT3PDjBbSJTZK4o4Pt6Klj2FAYTuuICC3dO6uP
 tqyUECtCgkMna3A==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This eliminates a check for shared that was overrestrictive and
duplicated a check in generic_file_readonly_mmap.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 2996fb00387fa..bda3abd6646b8 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -506,8 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}

-- 
2.39.2

