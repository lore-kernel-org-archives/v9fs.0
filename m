Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E011C93
	for <v9fs@lists.linux.dev>; Wed, 19 Jul 2023 16:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440ABC433C8;
	Wed, 19 Jul 2023 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689783770;
	bh=dp2zlWprh3aQ0p8wXOlySBFvIkjzoKk6uAidRdDwNXI=;
	h=From:Subject:Date:To:Cc:From;
	b=AUzM88a3kKAsyHKScqsmBk/UMAx6Ok1+sNAlGfHXUCy6C4pTVJi/LxmhNFIvpX2ys
	 1Wrp7W1eVZWnmtJGQ6zruNMGNpIEblw6kwsAG5l7aF6Lb8DG3Meb2fP0pw9sKmrJvc
	 8JuZR7T9tgw+rEJvmpmGm5TiJGW2PgIEGxgV7FnF6zM9yxUmDBoPKQMrKYx1IvKDnd
	 k278pRPKQYAbkA2EXLsUBID+2DYvRc+9+BKHfBH8nZ5AOjYD58jTCp2S0B+oYLxl8C
	 K9cqTggXA89ZhZmfyYeY7Ff1woblBrEVkukBOf0Lg8Cjn5kbi8tiGA/sjtMgRM00iu
	 aOLWgOtvVDOvQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 0/4] fs/9p: fix mmap regression
Date: Wed, 19 Jul 2023 16:22:29 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUNuGQC/5XOzW7CMAwH8FdBOWOWjy4hnPYe0w5p69AISJBTR
 SDUd5/LDe0yDj78betnP0RFSljFYfMQhC3VVDKHbrsRwxTyESGNnIWW2kinLMR0wwqlIZ3vQFh
 nSsOcGsLlEq5gZNDmUyp0eyfY6ENF6CnkYVoVvjW06SMWgoy3ed24Ej5JHn//cJ5SnQvdnw81t
 Xb/e7spkCDt3vSayxv9dULKeN4VOoqVbvotTjOnOjdatqL1/g9n3uIMc85651XsXBfHF25Zll9
 z0jvbiwEAAA==
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, stable@vger.kernel.org, 
 Robert Schwebel <r.schwebel@pengutronix.de>, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=dp2zlWprh3aQ0p8wXOlySBFvIkjzoKk6uAidRdDwNXI=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3Y7VGJe3Yy1lpSSN/S6sDVpTeL+Bt6aFbc3
 G5BJ6HgECSJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2AAKCRCI/9X7Sl//
 mHqIEACDYSv/QQ1TqXoHfQZK/4fDGKu1yLW9c3tAWBwQxBNRFDmIlYYGwWkZTlJK/MaPvTblsr/
 DMXO5i96RGRV7EmxWBkM+G5E8/H35UavAN1Xwl12DdPW4GS4SdbPZ4ZYZf26B1QRXev2tAGGdKj
 /oLi4zA6gapFDeHC08e8WCSGi8AcMzX+g1W7WU5ayu0G+iCksGF2Qn6dTOs0MIYj1msSCHZ149k
 xvZOShPlRSH/xnELD8Ba2HWKhryhr/oTswuGh+vN8KCXfpkpa8po6J+87pQ2dumFaUkYj6QZe1p
 xEL6v+5g5gH5nmUhdcVLJN6t7Jl7Uu5Ql6qPd1B07B9oBIJLETW2fU7PzqvBKnt2+T2nzsf2WQR
 jRka4rUV9h18TqM74YWVpVZtwwO1YmThzd7C34C5WEbF3X3J4Q7yM2ClekFBEor81evYix9P+2K
 cJOtq6VYpMPQaGA2wgiRC3wiLzJhyAzkXfnM9903N+biQLnhKfhpPTN8iBpig++6Uk3ShheYkPO
 ioa66pXWaVOlhq/dXQX8/x7pL6P7SVYjG+tx1hyt14OHJRhBp+kYKlHFQYWwz20pu6HkiY/MWtL
 G7BUtCeQ3FdffImILWZGd8zLJMC/RB5s1B1TE/a4gdOIVlKzjwLQ/bVkNGHxYLbmnKQFVG4Enr+
 lRCqAbzzwT5ugiA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This series attempts to fix a reported exception with mmap
on newer kernels. 

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Closes: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v4:
- Another attempt to fix tags for regression and stable, sorry for the
  noise.
- Link to v3: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org

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

