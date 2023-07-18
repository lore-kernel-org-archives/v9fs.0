Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4B171C6
	for <v9fs@lists.linux.dev>; Tue, 18 Jul 2023 20:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEACFC433CB;
	Tue, 18 Jul 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689713425;
	bh=scxEmsmSS3yAw8Pb9vs+lLcPVOwcbwDaNQFx5fsoDzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gQLfe2sZU78/8tGyOQjHfsxtD3oQUv+Px5p2nKSG2zOFChi/ssTKr3JBCzye1qq+8
	 7VNbb0lJBrjlbHvzinxbFVOanGpdbgiFHSIpmwpcfz6sOowDLYcJFdexcC5UZQl2rc
	 SIWcIec7RA+pcZhOZbMmxW1u/MvG+Q55kF3HcCJ4d2fWg+ORaLXnpXhqrJATV5Jpvc
	 KfFkXep5yxpZYkcOYus1diAFXr7sFso2FEF81FqQIm89o1eGkiPbDOy+41kVGnGr5w
	 peJolAYeeC7dwcwWHCBKcGrmv9x7qJfarLKKD29P63QWodHBhllrC+vUff5TJ5SVm8
	 HgB8WgpmNxWwg==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 18 Jul 2023 20:50:18 +0000
Subject: [PATCH v2 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v2-4-147d6b93f699@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=634; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=scxEmsmSS3yAw8Pb9vs+lLcPVOwcbwDaNQFx5fsoDzg=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktvsM6EaD3uQIChje/362palMFSayDgR3qaOWO
 dsMdF9cc6qJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLb7DAAKCRCI/9X7Sl//
 mLrFEACWjUV9pX/ivEzfBsAWNxyETtVIY4AVufEY6ephLHNpEIegrcmzupnJ+Jz7uFRLdTLMF7c
 9GQPcjG9oq8tu7JxTsvRJd5dRRDunPi+caDam+5BmpVMVJ4JjJEoTyX/EwSylM7BX8zGcYtgcBc
 BOYOTznWqLKc7O6QGewfAl19EbsbZL8d6EFAo19p/LEo7sMR1Jy0u4c0/9gPniZ+3HDMZtz3Hs0
 SXLwNi9gr06sAlxc2jBFyy7cgSbXWHzD/+Wp4WWsIqeL7h7jUHKfH6WYmsIbYi2fPMejghZeNsI
 IDyxbaHm4jSNYnLulLDuTK7JeO/03t1zyZryLh4UfVBeYSXSotY9HycOXQWjDGue0ScZddviXU4
 hxV9+wq5j6Zn2AIpej8C07r5xQ1oNAYRG7xtmbETUYSDUQP+D5fTJHI4JWnZCbRZriNzbgW0TyF
 d6sh9ARoaoyUNabFuzxwobOkuS9w78MPfA7WNOfje2aGsul9v4YT497597CijRYqnRsnudf8Wsg
 ay0c2ME8h8RatfPVZV1GtmqrOTDf5ZzQdforHXTSl99X9VzlunbiDn3dJa50gVc27bOuQ7w6eHi
 m8jBvuxPu6Sb7gDTRshrje4uv32/pYL+0vwN17BLFnq6bYlMSmKqW2ejcx5MNQouF33jBJaX18e
 hUNzK/SW/afmSsg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

There was an invalidate_inode_pages2
added to mmap that is unnecessary.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index bda3abd6646b8..3809f3a531499 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -506,7 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}
 

-- 
2.39.2

