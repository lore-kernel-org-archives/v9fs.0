Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E88213D82
	for <v9fs@lists.linux.dev>; Sun,  8 Oct 2023 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 11702604A87F2;
	Sun,  8 Oct 2023 14:01:48 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: Su Hui <suhui@nfschina.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Date: Sun,  8 Oct 2023 14:01:39 +0800
Message-Id: <20231008060138.517057-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

with gcc and W=1 option, there's a warning like this:

In file included from fs/9p/xattr.c:12:
In function ‘v9fs_xattr_get’,
    inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
[-Werror=format-overflow=]
   55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

use "" replace NULL to silence this warning.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/9p/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..d995ee080835 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
+	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
 }
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
-- 
2.30.2

