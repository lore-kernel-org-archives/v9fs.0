Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B08F7D
	for <v9fs@lists.linux.dev>; Sun,  6 Apr 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956391; cv=none; b=b1nCJQDPpOVlWGQgcZcwSdlqjQEezwdelB/w3PvKULnxvu0BNiIslbfsbVNPGoqjQy0zWlO5QaiwRpkujwG1gziOpfVMc2aGLf50m/UF5eDIwxKU/RWyuwNLq5TxuZgPOfK8bAC2cUjJji5u9NRdwf08stTrNUWYLUVsmZdpo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956391; c=relaxed/simple;
	bh=QwgBKRqOOaa6XKwENYwuwFGW7dQ1LFO1U001UDfjcAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgVvPODvq6t8U7Hx/zbc63MaRk6LDiWv8vXZ8t1QlIgBNhoPAOIKCPOKihZ4OShwg69tMttxb/mvcV/ZLp5xgTTLPKD16sYMxlHimtoIkSirijFevdUpxLV+xKFDpP4kvUUemDk7t4DKAUeBTe+keUkMcckKm+RJg3dF+AC/ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=VzDTn9kL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQTAbrEG; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="VzDTn9kL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQTAbrEG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id D4DA11D41A15;
	Sun,  6 Apr 2025 12:19:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 06 Apr 2025 12:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743956387; x=
	1743959987; bh=iwH/QF/Ctp0KrjjgTmdRrmlkt9WJcBQcpU4nA7uR7AA=; b=V
	zDTn9kLD3tLLKoHb5kjEvD6wAgMnTFr/j2N1qXTWpIK4dJLvJqPCoeufQmLGDvou
	EaInVf9+xmfYWBOTbmzSrKMoH1CX9THiFCb9PWA/KyxXtRz8Q5bOQXmv12FGVBDi
	KfBRSEhqk0LZWWbt9OpKXOdzua3eAUNYxLTnvFND6Ow6Rkxzw3icw1J3Z4HROmh3
	t2nl2IADBGRLSllHXkt3NWIa5NM3Y+f0vPk7HHzrTpulx4kiDJLkdLR4ct4Nf6sm
	4vb8KFs2hGrdvOVqSDqv3yk851Zh1uinYsm71CLPa5NtgGrzTLlpbAUoVyOxyexa
	0zNxeQKng/EnFyUEGgUvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743956387; x=1743959987; bh=i
	wH/QF/Ctp0KrjjgTmdRrmlkt9WJcBQcpU4nA7uR7AA=; b=VQTAbrEGJmRnVv+Jd
	W2iqPQvkvEx8HU2I9eW+pT7KolFpjYP3JkHOA9kn3rmQhoIkgrYNdWMhnSX3Fr6t
	nnYAR6xOeDnkfZw74Wlx+XOx9hMKb8/58idxP5gq9JwK291zrcHLX+YMMzigPv26
	e5Or2qFKVwUJQwkTV6eaEarpo0b1nABfLAyAKd4gLzZXgf24ob8wKBPcNzdtldam
	5IEive2D1eEsZaYr0yoP3wOAN2bVCEtMY15fMwiwzuJ7cTTYPLu8AxeJfhlQjP1E
	fV5xKe7Oh1U+fYclpOC5pWdXpO0fWogdTQWUQJ4dfwEIVGzAlhVDjCYgj+OQh0LW
	Dud7w==
X-ME-Sender: <xms:o6nyZ02_P-a7CCJbY7ocTMCsMrfquJcy5tL55oRmjq76FdUBh31tjw>
    <xme:o6nyZ_G99bdps594bFLp0NVU-lBLQGJmutr_Ww_5FBRQ86igxNw5DXTX1toe078-9
    -1d8j43Ro7Ezc8plK0>
X-ME-Received: <xmr:o6nyZ8691CuBwNIQmHNdG4241tm5X1fpGPQ4EL_Djxzr6xS2JrXFotC2eq8VcwDyo6dagMT9JbWBhOQARZnGawSed4Bo4ttHH-g998zDVl1dRBKWwa60yR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthho
    pehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhnuhigpghoshhsse
    gtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhr
    tghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmh
    hitgesughighhikhhougdrnhgvth
X-ME-Proxy: <xmx:o6nyZ91Q566CDwtsh4ecPeO4MEh0MjBMBSk2TAfW4564KjiCvtDhMQ>
    <xmx:o6nyZ3HAI7nZwTsRh-iTf6DJgiPV-E4-G79sjpzK_Mw8UWGOhoQ_Kw>
    <xmx:o6nyZ28SMdprpaEyPZhZ7REzxUAl14EobpUYjojGTxA4uBh19nG85Q>
    <xmx:o6nyZ8kkZrB5nhpoaon83i7sIL7izuSOeQSzQCOiOOYEpW3ZkkNdlw>
    <xmx:o6nyZ3QCxPf6h-vUo-8N6rUZGCGIgBYo8tdZOsd52bYKCHWZC3F-gz02>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 12:19:46 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 1/3] fs/9p: Refresh metadata in d_revalidate for uncached mode too
Date: Sun,  6 Apr 2025 17:18:42 +0100
Message-ID: <bfac417f65cc1d6812be822f8913f0d4ba0c1052.1743956147.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743956147.git.m@maowtm.org>
References: <cover.1743956147.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if another process keeps a file open, due to existing dentry in
the dcache, other processes will not see updated metadata of that file if
it is changed on the server, even in uncached mode.

This can also manifest as -ENODATA when reading a file that has shrunk on
the server (even if it's re-opened in another process), or -ENOTSUPP if
the file has changed type (e.g. regular file to directory) on the server.
We can end up in a situation where both `readdir` or `read` fails until
the file is closed by all processes using it.

This commit fixes that, and invalidates the dentry altogether if the inode
type is changed (for uncached mode).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/vfs_dentry.c     | 11 ++++++++++-
 fs/9p/vfs_inode.c      |  8 +++++++-
 fs/9p/vfs_inode_dotl.c |  8 +++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 5061f192eafd..7ba9e3498e85 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -66,6 +66,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	struct p9_fid *fid;
 	struct inode *inode;
 	struct v9fs_inode *v9inode;
+	unsigned int cached;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -75,7 +76,11 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_valid;
 
 	v9inode = V9FS_I(inode);
-	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
+
+	if (!cached || v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
 		int retval;
 		struct v9fs_session_info *v9ses;
 
@@ -92,6 +97,8 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 		if (retval == -ENOENT)
 			return 0;
+		if (!cached && v9inode->cache_validity & V9FS_INO_INVALID_ATTR)
+			return 0;
 		if (retval < 0)
 			return retval;
 	}
@@ -127,6 +134,8 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
+	.d_revalidate = v9fs_lookup_revalidate,
+	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3e68521f4e2f..1640765563e9 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1350,8 +1350,14 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * Don't update inode if the file type is different
 	 */
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	if (inode_wrong_type(inode, umode))
+	if (inode_wrong_type(inode, umode)) {
+		/*
+		 * Do this as a way of letting the caller know the inode should not
+		 * be reused
+		 */
+		v9fs_invalidate_inode_attr(inode);
 		goto out;
+	}
 
 	/*
 	 * We don't want to refresh inode->i_size,
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 143ac03b7425..2d025e561ba1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -902,8 +902,14 @@ int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 	/*
 	 * Don't update inode if the file type is different
 	 */
-	if (inode_wrong_type(inode, st->st_mode))
+	if (inode_wrong_type(inode, st->st_mode)) {
+		/*
+		 * Do this as a way of letting the caller know the inode should not
+		 * be reused
+		 */
+		v9fs_invalidate_inode_attr(inode);
 		goto out;
+	}
 
 	/*
 	 * We don't want to refresh inode->i_size,
-- 
2.39.5

