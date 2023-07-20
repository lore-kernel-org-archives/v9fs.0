Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0D17723
	for <v9fs@lists.linux.dev>; Thu, 20 Jul 2023 14:35:18 +0000 (UTC)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6FWQ28QmztR9G;
	Thu, 20 Jul 2023 22:32:02 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 22:35:10 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
	<linux_oss@crudebyte.com>
CC: <v9fs@lists.linux.dev>, <linux-kernel@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH -next] fs/9p: Remove unused extern declaration
Date: Thu, 20 Jul 2023 22:35:06 +0800
Message-ID: <20230720143506.33860-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected

commit bd238fb431f3 ("9p: Reorganization of 9p file system code")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/9p/v9fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index c7f774fe398f..d525957594b6 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -545,8 +545,6 @@ void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses)
 	p9_client_begin_disconnect(v9ses->clnt);
 }
 
-extern int v9fs_error_init(void);
-
 static struct kobject *v9fs_kobj;
 
 #ifdef CONFIG_9P_FSCACHE
-- 
2.34.1

