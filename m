Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAD10957
	for <v9fs@lists.linux.dev>; Mon,  7 Aug 2023 14:17:38 +0000 (UTC)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJGK5lhFzNmm3;
	Mon,  7 Aug 2023 22:14:01 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:17:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
	<linux_oss@crudebyte.com>, <brauner@kernel.org>
CC: <v9fs@lists.linux.dev>, <yuehaibing@huawei.com>
Subject: [PATCH -next] fs/9p: Remove unused function declaration v9fs_inode2stat()
Date: Mon, 7 Aug 2023 22:17:26 +0800
Message-ID: <20230807141726.38860-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected

Commit 531b1094b743 ("[PATCH] v9fs: zero copy implementation")
declared but never implemented this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 fs/9p/v9fs_vfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index cdf441f22e07..731e3d14b67d 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -52,7 +52,6 @@ void v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 			   unsigned int flags);
 int v9fs_dir_release(struct inode *inode, struct file *filp);
 int v9fs_file_open(struct inode *inode, struct file *file);
-void v9fs_inode2stat(struct inode *inode, struct p9_wstat *stat);
 int v9fs_uflags2omode(int uflags, int extended);
 
 void v9fs_blank_wstat(struct p9_wstat *wstat);
-- 
2.34.1

