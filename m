Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222726E01
	for <v9fs@lists.linux.dev>; Wed, 25 Oct 2023 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="05fdU/yQ";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ftS3Ik6j"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 5820BC026; Wed, 25 Oct 2023 12:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698230105; bh=3oLYARw9PzD4D8IthO/c8mEblFd4Phw87VXReD+sQhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=05fdU/yQjJiqOCG03enYdZacSd1qfY1SzIL0y5XgjDN/n0LF65kPG6JOT6GmAYiDB
	 70dDjRU9/fLJfc34yCCTceY4GbXRZPrZIgl+W6Cc4Al/PaMNTcNSPu4SCKtBQBT7MZ
	 dLeq4wQJq+fP/WYKq0SorF8NbnCr4/CRTahc9aAmIpuULiE1HIKASnaCxz/IstGNl0
	 a1hy6r9YHMTGuXUSF4+2ubF03vnaYuoDdmloNIprABlXFh83llzlmOHUVqR+fSjQoj
	 Ba0/v85njq3KJjQtwLCB3wzDl0Zk0NxWEmBU5Zq+oAq28s9vrZvgamw6+qLsYpOoX8
	 UI0CCtwa1d5Dg==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 702E0C024;
	Wed, 25 Oct 2023 12:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698230103; bh=3oLYARw9PzD4D8IthO/c8mEblFd4Phw87VXReD+sQhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftS3Ik6jc4yYla/PPazBt/OthUxEG067GBsfnsOqHJIz4AVJmp6GWCI0DVjHXif1T
	 wwSBh06ASdAHBj71eGJ98SXEU5O0BaiB7Bmofahi7qnXV6kwV6BB0i6vKv2A6u+0BA
	 WSJlBusYTdphzYsWVnjgGpWhAB1pbgw6C1db23FH3d3BtC9ZAQYjG0BQW2kJXgo/v7
	 DEH8sjt6hP9y+SdTncCP01hiKZK29SPn1nWLo8QIvIKAEJ3wL8iSaDy0FwuteaFCbD
	 dgZCupEqf9vgT7Zt+oYSz4Nri9vomfvsWVLF6kpaHiI01F22vtRoMUPT+hBKY9/l1P
	 Cl2IRDP2IEIUw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id 9e57d534;
	Wed, 25 Oct 2023 10:34:52 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH v2 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Date: Wed, 25 Oct 2023 19:34:44 +0900
Message-ID: <20231025103445.1248103-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025103445.1248103-1-asmadeus@codewreck.org>
References: <20231025103445.1248103-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W=1 warns about null argument to kprintf:
In file included from fs/9p/xattr.c:12:
In function ‘v9fs_xattr_get’,
    inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
[-Werror=format-overflow=]
   55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use an empty string instead of :
 - this is ok 9p-wise because p9pdu_vwritef serializes a null string
and an empty string the same way (one '0' word for length)
 - since this degrades the print statements, add new single quotes for
xattr's name delimter (Old: "file = (null)", new: "file = ''")

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
Suggested-by: Su Hui <suhui@nfschina.com>
Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
v1->v2:
- add comment that txattrwalk with an empty string gets the list

 fs/9p/xattr.c   | 5 +++--
 net/9p/client.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..3c4572ef3a48 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -68,7 +68,7 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 	struct p9_fid *fid;
 	int ret;
 
-	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu\n",
+	p9_debug(P9_DEBUG_VFS, "name = '%s' value_len = %zu\n",
 		 name, buffer_size);
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -139,7 +139,8 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
+	/* Txattrwalk with an empty string lists xattrs instead */
+	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
 }
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..9c2bc15e3cfa 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1979,7 +1979,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P,
-		 ">>> TXATTRWALK file_fid %d, attr_fid %d name %s\n",
+		 ">>> TXATTRWALK file_fid %d, attr_fid %d name '%s'\n",
 		 file_fid->fid, attr_fid->fid, attr_name);
 
 	req = p9_client_rpc(clnt, P9_TXATTRWALK, "dds",
-- 
2.41.0

