Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0742376A
	for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ldMR/5s1";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ldMR/5s1"
Received: by nautica.notk.org (Postfix, from userid 108)
	id EC9C3C01C; Tue, 24 Oct 2023 01:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104246; bh=DieO6nLmhMIqZKysrRjkquiB3ylJYMRIAY1/0apJM7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldMR/5s1aEDMSt/4JHtx3ytpCH02TK1IjzclsiD3vV/jGgHI5o4CAEEhdbe2VFiuL
	 ykV2SYqK0o+3+L/OuICoC3lDjOBVAqiiePcA7vPx7a4MZCKE7qTI4S1miw2pH4/6ed
	 8xfaPCcrejJKMtvSqj1aXXBAStHbpf2jmHahWlRZkaMz0X+uu70vqBIcZMGOncxpst
	 1fMe7I/m5YLEZC+ARzv/al35YRI36tAoQ2I8O48RVsL5kuf9qOUUlHElKPX46GWkBr
	 iPm3ZB1VHBNxcceiTYj9V15Svz0cq8saNQOZNa1zmc/vbE0f7fxIKy2bmERd5V+ZXM
	 gxtY4orBogjCA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 40535C01A;
	Tue, 24 Oct 2023 01:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104246; bh=DieO6nLmhMIqZKysrRjkquiB3ylJYMRIAY1/0apJM7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldMR/5s1aEDMSt/4JHtx3ytpCH02TK1IjzclsiD3vV/jGgHI5o4CAEEhdbe2VFiuL
	 ykV2SYqK0o+3+L/OuICoC3lDjOBVAqiiePcA7vPx7a4MZCKE7qTI4S1miw2pH4/6ed
	 8xfaPCcrejJKMtvSqj1aXXBAStHbpf2jmHahWlRZkaMz0X+uu70vqBIcZMGOncxpst
	 1fMe7I/m5YLEZC+ARzv/al35YRI36tAoQ2I8O48RVsL5kuf9qOUUlHElKPX46GWkBr
	 iPm3ZB1VHBNxcceiTYj9V15Svz0cq8saNQOZNa1zmc/vbE0f7fxIKy2bmERd5V+ZXM
	 gxtY4orBogjCA==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id c8ad982d;
	Mon, 23 Oct 2023 23:37:16 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev,
	ericvh@kernel.org,
	linux_oss@crudebyte.com
Cc: lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Su Hui <suhui@nfschina.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Date: Tue, 24 Oct 2023 08:37:03 +0900
Message-ID: <20231023233704.1185154-3-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023233704.1185154-1-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
---
I've checked this works as expected (getfattr listing all user.* xattrs
after setting some), so let's fix this warning.

As pointed out by Dan this makes the message les clear, so I added
single quotes to make it clear we're dealing with an empty string; I
think it's good enough.
Su, I made you only Suggested-by because of the extra legwork and
format changes, but happy to give you authorship if it's something you
care about; I'd just like to get it out during the next merge window
in a couple of weeks so please say the word.

This makes fs/9p build warning-free with W=1 on gcc 12

 fs/9p/xattr.c   | 4 ++--
 net/9p/client.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..d29907c378fd 100644
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
@@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
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

