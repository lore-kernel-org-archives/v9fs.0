Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5A38A70C
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324448; cv=none; b=S5S80qDNvTHZYPf4lqddssIr7tdHdP7GdpyJDxJHCEjFlPspR2wQ+QdlnxOztaL4C7rEgxQiPPgidVy5QyRat2t60VD5TAVqRYCVDIdKKhvfM66PEaMa4cbLCmL/BIfCwa6N1iQ5+GXJ5eCawYzi5yVdQpg2ktRIR9lFfkYi2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324448; c=relaxed/simple;
	bh=yzyp5TtG8KO8PXFy2cNiXRvALkQJEbVPLcMuFJ6rabw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO0Xx0UtCwuzD3FKK+WHjumUmOeYFTWuMxKBN+gIBh5YTrgfBKOWKOfyrNbakCfkRTnoXwnDTO/G0Ur2R0ZBA+W176nX3nGISA5VqUZ+WbWvnYzd1Ol4vbUqVFTCt9KGrFHAjKD7/fBGMnePEcR+Tx7+DVcTrMPNECGk6AU+Ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=gn57vM3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4zBfNEa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="gn57vM3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4zBfNEa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BAA9A1D001B6;
	Thu, 16 Apr 2026 03:27:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 16 Apr 2026 03:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1776324446; x=
	1776410846; bh=dgvzRwZdYZ3Z6iSEHBbWUhlt8GLz6wdKPIaN9UoA0QU=; b=g
	n57vM3lpKO4xdtbix1QT5vlvByJWfdCXY6Z0AUqU7N80ZKVl8bzoXOpYKV27W4Yo
	O398JOViaMaCz0xkGnEfx7OdMaASGObrVJ9blchNQiKuhq7AXJupRw6BBsvMpIF/
	GveWB2nqVVXnicWXyNnKaaN0fSk8v1Iw/kf3x43DsAUUPe4CI0dPzSUnOkwXdCsd
	BL3G9GGGQZgyLXvkOrp0kix+Ssfdg1sHNvueBAw7VtELRN1cxHjRTv5q8NSBn2Y8
	tKFy6J1eqbRWbjmUNLrUralOBs286xYyTVYFvkrtGYcMxgaW5dIo0VA+f0BybaiU
	4SrjEf8qieDbD5Yzpc+Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776324446; x=1776410846; bh=d
	gvzRwZdYZ3Z6iSEHBbWUhlt8GLz6wdKPIaN9UoA0QU=; b=S4zBfNEalqRedLWNz
	swhbWsfYpeENZ46/VZRSAunFGG9r2LUqvItwyQwfhsoTlNSbGGCYhfiA6n0fyqyJ
	XMVCHFYgHthjiIrnOy5i3l5Yfe6ibcUvHwvuWg9g1KqVREugrGW7JlerhRGUNb+V
	Tu+LSPYjpwZebBZgLiZgvDRqfHF1nOo/6VMCt6S5G1h4voLj92uvITugjf7PPKl5
	8cuppHPoP07PdG96my0eiZf9al0RlOFerWrDaewJsqFbupjU7iLIg7sjyj3afaAR
	5pt6EDdBVrULjxQ1dm4eYxv9RWiCbCaL/poqjMoEGvcncniJfS6xEjce3p2bGBG8
	D7Mqw==
X-ME-Sender: <xms:Xo_gaX1rvRvJX4QEldxQWr9pgMUXlGP_SpKmDLJSinqKCKRwtUchcA>
    <xme:Xo_gaWyAJApiNbmWe-gkrnk4I-c_wzkLK-21Gk05Qji6czPqPQ1cUGH6HwnP2LtO2
    FyyHt1Vv7C07YrcNNjbvzz8yhD7QVsxngCMJJWe-vrSfC-LKuU5DuI>
X-ME-Received: <xmr:Xo_gaWGKMHBfYvVPLyFTnYFCSpKwv4jGFdQzcF7JHEnh3oW4DCMID_eb5oWrrH6ecOnfR72J-DKUs7dAl1DfmWjy0pnQT90l-3cs4gLtE_cpAQVGpB8vSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheprfhivghrrhgvuceurghrrhgvuceophhivghrrhgvsegsrghrrhgv
    rdhshheqnecuggftrfgrthhtvghrnhephfejfffggfehjeejgfekhfeludelheevieefge
    eugeffleetgeeuiefgueffheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtoh
    epjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtth
    hopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvhelfhhssehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvsegsrghrrhgvrd
    hshh
X-ME-Proxy: <xmx:Xo_gaRZxt2JFgJQy4Jx1N1dQxNzmhVyPv3wDRNw-X8BBh90bC5V50A>
    <xmx:Xo_gaQBG15-aaiX1SPw6OaQtOjIxs67waIZfJtKTzpXQadJmvho7sw>
    <xmx:Xo_gaRnJ9Y3DKD7cLny3RfElzn5D03tli-bCBySQmMt7a0DfBwuFew>
    <xmx:Xo_gaZzT6-gCB12AtEK3zZnHr-8PWQWhI6r0BbgeHyEHeTgc3jRgBw>
    <xmx:Xo_gaafU-8kLgEKeZ2lA9vALP8ZlByKDTJd0zVVxwXm00LmWixK6B2Hz>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 03:27:25 -0400 (EDT)
From: Pierre Barre <pierre@barre.sh>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH 2/2] 9p: invalidate readdir buffer on llseek
Date: Thu, 16 Apr 2026 07:26:19 +0000
Message-ID: <20260416072619.14241-2-pierre@barre.sh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416072619.14241-1-pierre@barre.sh>
References: <20260416072619.14241-1-pierre@barre.sh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9fs_dir_operations{,_dotl} use generic_file_llseek, which updates
f_pos but does not invalidate fid->rdir. After an lseek on a
directory fd, the next getdents64 continues draining stale cached
entries instead of refetching from the server at the new offset.
This causes xfstests generic/637 to fail.

Replace generic_file_llseek with a custom v9fs_dir_llseek that
resets rdir->head and rdir->tail when the position changes,
following the same f_lock pattern used by nfs_llseek_dir.

Also change the readdir refetch condition from == to >= to prevent
an infinite loop if lseek races with an in-progress readdir.

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_dir.c | 53 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 487c177aae38..b0f8913380bc 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -103,7 +103,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	kvec.iov_len = buflen;
 
 	while (1) {
-		if (rdir->tail == rdir->head) {
+		if (rdir->head >= rdir->tail) {
 			struct iov_iter to;
 			int n;
 
@@ -162,7 +162,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 		return -ENOMEM;
 
 	while (1) {
-		if (rdir->tail == rdir->head) {
+		if (rdir->head >= rdir->tail) {
 			err = p9_client_readdir(fid, rdir->buf, buflen,
 						ctx->pos);
 			if (err <= 0)
@@ -195,6 +195,51 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 }
 
 
+/**
+ * v9fs_dir_llseek - seek on a directory
+ * @filp: file structure
+ * @offset: new position
+ * @whence: SEEK_SET or SEEK_CUR
+ *
+ * Invalidate the readdir buffer when the position changes so the next
+ * getdents call refetches from the server at the new offset.
+ */
+
+static loff_t v9fs_dir_llseek(struct file *filp, loff_t offset, int whence)
+{
+	struct p9_fid *fid = filp->private_data;
+
+	switch (whence) {
+	default:
+		return -EINVAL;
+	case SEEK_SET:
+		if (offset < 0)
+			return -EINVAL;
+		spin_lock(&filp->f_lock);
+		break;
+	case SEEK_CUR:
+		if (offset == 0)
+			return filp->f_pos;
+		spin_lock(&filp->f_lock);
+		offset += filp->f_pos;
+		if (offset < 0) {
+			spin_unlock(&filp->f_lock);
+			return -EINVAL;
+		}
+	}
+	if (offset != filp->f_pos) {
+		struct p9_rdir *rdir = fid->rdir;
+
+		filp->f_pos = offset;
+		if (rdir) {
+			rdir->head = 0;
+			rdir->tail = 0;
+		}
+	}
+	spin_unlock(&filp->f_lock);
+	return offset;
+}
+
 /**
  * v9fs_dir_release - close a directory or a file
  * @inode: inode of the directory or file
@@ -238,7 +283,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 
 const struct file_operations v9fs_dir_operations = {
 	.read = generic_read_dir,
-	.llseek = generic_file_llseek,
+	.llseek = v9fs_dir_llseek,
 	.iterate_shared = v9fs_dir_readdir,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
@@ -247,7 +292,7 @@ const struct file_operations v9fs_dir_operations = {
 
 const struct file_operations v9fs_dir_operations_dotl = {
 	.read = generic_read_dir,
-	.llseek = generic_file_llseek,
+	.llseek = v9fs_dir_llseek,
 	.iterate_shared = v9fs_dir_readdir_dotl,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
-- 
2.51.0

