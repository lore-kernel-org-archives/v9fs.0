Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD431396
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbosWal0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C0DC433C8;
	Sat,  6 Jan 2024 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507071;
	bh=qAEe/zuz7QFmU8aeSwvtDvaxrGaMHawwSx4zO3XnwUI=;
	h=From:Subject:Date:To:Cc:From;
	b=TbosWal0af8e1D/wISxZOLg9H6ZLOYwPcWJbsdVgWS6EQ4E1wx77oxwjRt1tKmOHC
	 5L9Frz8QeQtD5ggR0HGkDaUjCp6CAW5pHL2NpNzdboNttbE5dihb8XnrDJ11hejumC
	 2924bGxtOyu8O5rAAteaFXLtXduSB+arFmamZI8W0xpsgrdQ0qBkuFxnYIl3RXeWhi
	 LV75JFENKOVT/gtP4AtP5WIAE5J0O5sK0Ucl2FnjfOJfe3SsrCIh8rrMX3HwBlKzii
	 o5oEe0Tzo4YHSvvmyaBljkLuiWZ+r9AY4eIchRr821KCIBbS/WtQ4JSgbVtB4MCvET
	 vy8O+w37KdGqg==
From: Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 0/9] fs/9p: simplify inode lookup operations
Date: Sat, 06 Jan 2024 02:11:07 +0000
Message-Id: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALu2mGUC/x2MuwqAMAwAf0UyG2irDvor4tBHarPU0qII4r8bH
 A/u7oFGlanB0j1Q6eLGRxbQfQc+2bwTchAGo8yotBpQdH8ljHyjtz4RhrM0jGo2k43OBaNB2lJ
 JjP+7bu/7AahoPCJnAAAA
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=qAEe/zuz7QFmU8aeSwvtDvaxrGaMHawwSx4zO3XnwUI=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa9ClwCWst1rMqfK63se0fDjQhGVifWHd6JK
 wBUPnnAwc2JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vQAKCRCI/9X7Sl//
 mAUbD/4mmjtHetQ+tOZIJaouv0KEah0LG5Q/1MxvvXMRcG3pK+OuvzYBLMHnHWFn08DEkFl3r19
 Y46Q2qAdS6GXwWAwjbJHfSVwK0eHjluEELJHM1Lydp4DqVDtN0nMHDLre8A/wTSNbJfzEgE9rVD
 xdVrOywE0oKf+/H+dxftFwTgDeedmjnQCO80EV5t88ecotVSBdXoJGUdnS5dfIgoROtKwu4TVUH
 pRWXHmpJZ/XZigdP3O4YBAVzy1FigWraW1dSqQkLhda8b3Oxl80e/Z921TNrbsWeJcgQowvcYlo
 eoEyRHSuG6Rgsc+32iRsN6czsc59zxpNIyS8hGRTBAhMV09eUvgeyM+jc7t6VP/4ulakKV1HJiH
 B5vnbo+jGrOlUunbNrxCunyH/jHihhd1S19swU2R/iy8qLvjN5ZT+ACTdSmUBHpNL1GdcweIz2O
 y1FiK6OGEMa/+sYAPWkc3pa1/J1WePkytjEU3rvEyA4+yd3mFxQr/5gcpqY5bsfqm47xe6VXBed
 eAtKDS6beRbdXK/7LlCSATi8dKTjWYe7kbFMtvIrUcp/pfT9ujRsqQd2SoBxSxIHmN6wh3CoVqZ
 4YG1WCIdiakqbElDheTchPKwlwhsaHGQZz/KdYqTzY0YhdKJEMAuY3/cWqjSmLxPB2lZuF8R5cb
 d2Ph2bQiK9/KiZQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This patch series takes a pass on the inode lookup-related
operations and attempts to simplify the code path, eliminating
unnecessary and/or redundant code and/or protocol operations.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Eric Van Hensbergen (9):
      fs/9p: future-proof qid2ino 32-bit support
      fs/9p: switch vfsmount to use v9fs_get_new_inode
      fs/9p: convert mkdir to use get_new_inode
      fs/9p: remove walk and inode allocation from symlink
      fs/9p: Eliminate redundant non-cache path in mknod
      fs/9p: Eliminate now unused v9fs_get_inode
      fs/9p: rework qid2ino logic
      fs/9p: simplify iget path to remove unnecessary paths
      fs/9p: Further simplify inode lookup

 fs/9p/v9fs.h           |  31 ++------
 fs/9p/v9fs_vfs.h       |  11 ++-
 fs/9p/vfs_dir.c        |   6 +-
 fs/9p/vfs_inode.c      | 148 ++++++-------------------------------
 fs/9p/vfs_inode_dotl.c | 194 +++++++++----------------------------------------
 fs/9p/vfs_super.c      |  29 +-------
 6 files changed, 73 insertions(+), 346 deletions(-)
---
base-commit: 5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
change-id: 20240103-ericvh-fix-cache-dups-f0925afbbd21

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

