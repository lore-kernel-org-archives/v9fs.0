Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CF24167F
	for <v9fs@lists.linux.dev>; Sat, 27 Dec 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766824690; cv=none; b=I2tduufl7NG4WQ20xN0JO3wiih2dOHg6nvu56Iy7yoaqbgisTvdNy+H65zMSGh1oWJP62iP9kKPHOpura7fnak1fLXa1cgjxAlQjFuwtqMPcrF7lnngY1EBUE9KzTUT8A8V49Ef3+Ia+Q8RtjWRqi3leXBE7Tlm6NqZaPpqcXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766824690; c=relaxed/simple;
	bh=p+7+NIAOtTO2e1ENsQQD3inBeL7Ibrffz/ohV7uA7os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6HP5+J0M7fX9vNmIx4rG6qjfCnybO8WoJ/yCIhCu+rIwr/n0A0DCu619x/ptyoAH9uToPHSzUqF7RCluxJVaxEiQf4SiFlhtAPMZhbnnT0sH3nWbe6g/Sd+TVedS6bI2WB9rcW0j4aJ2+Rb3v2xHWXHPBztPzHCuS2QtGDMwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=CdcAcvxR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0F7r3FP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="CdcAcvxR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0F7r3FP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C55A14000EE;
	Sat, 27 Dec 2025 03:38:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 27 Dec 2025 03:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1766824686; x=1766911086; bh=xn25ldaZJYUvO0qMrQUEm
	NbIeDuM3Hc67+Y+veNQHZc=; b=CdcAcvxRyjUbe+25jxHSbaIaLPeZ5GKHy439p
	tLoaSR1u3PROskxRLLthQptVMlJF5/OJLInSxr9F7vrcptmwAAhi4XIq1bH6UATY
	bGTzNV45pJK3VaDh2eJY/GKgCBweoloGzaL0W8IZvz4ky2G3uH+C+2nQ+OGiXABK
	LgCAeOoFtnRViGbcgZOqwsxtmnTMuqTk+hPnToNPIuyyJTUHgMNjEAzNQsXet1Ai
	gXiTsGotzGfMacPnTH/823ADVgzR4bIswdYdsLT1xkxUZnDZUdL0JXyqTu02/hhG
	nNbNwBvr0o09lagG7Lm+/xB9eLjm4+T/wYjiX6bbTFttO2q/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766824686; x=1766911086; bh=xn25ldaZJYUvO0qMrQUEmNbIeDuM3Hc67+Y
	+veNQHZc=; b=B0F7r3FP9irp8YXbHiv5wSaLC3yt4Z36snwofo3hZXqOczROpFQ
	RCKoZ5ov8Thmvo9v7x6U7jXfFUiXgI7LDXDZ8IN/Y4/2Gchjy4LvMLcNbDKC8lm3
	X6lZ+uWGKc3JvBMB9qY7iaxpZ05XrvFTTVaSboO9OlgHOpwyR4A0AXaCAk/VbMFM
	PdKTOMi2X0sLxCxlbHAc1mAenQMJ7Pu7WvxZc8UL3+3JzTxRQROjsk+p/0w/sWam
	s5DwGg6tuTgmnVegLFdrIVAVktVlbTDeqMqSdi++kXo45LmarsT1EEzZCqksgtep
	sUXm0MyZRhifLMAQhhqPigLsrajSqhLwJSw==
X-ME-Sender: <xms:7ZpPabf_auVWhdeLyXziRbDvhfvZ818oE4tZZBQ3N4EzCRf6wvoNnA>
    <xme:7ZpPaR65sM2x9FH0eN55dZYkZS_2sXbJWU52BYf5b5GRvx1s5Zil1Mu91Bam7AtUu
    baApcHSOXagrTB_KSId5lyjEw23LgOT8jOh8aDn76tizQX8SyYP>
X-ME-Received: <xmr:7ZpPaSua7E1dsghrOynE6FM53yE7_vOE-hFJuUGAA7Z3EJzuVjVmqNRehxAbPRQqZ5AESwzwpNRQSp2E4h0XTBeonSllHtwfsk5YSqRFeLuVCfjfeEP9m14iKD03wozOhCIj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejtdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomheprfhivghrrhgvuceurghrrhgvuceophhivghrrhgvsegsrghrrhgvrdhs
    hheqnecuggftrfgrthhtvghrnhepueekiefggfelueeihedvtdfhvddutdejfefhueevhf
    ehjedvuddvgeevkeehgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtohepje
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhope
    grshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhig
    pghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepvhelfhhssehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvsegsrghrrhgvrdhshh
X-ME-Proxy: <xmx:7ZpPaRimMXwPlJllDdNZYUyjE6ZyCwIrob2a-QU3tFtS_5Mi_7C2Ag>
    <xmx:7ZpPadqjV95GLhlJicF8EKydCcuaq4l9F3HaUBU5caMzAkk6ppCisA>
    <xmx:7ZpPaeua5w--Qo4KzVrNGzRZS42_FrzZFGEKcKlwK2eBtueKL3RJUw>
    <xmx:7ZpPaQbW_AgCtSsBJVHVcgVg04ruC1mXywi2_q1bhBVyhgNAF2UHCA>
    <xmx:7ppPaQnMEvo2zhm9PgK1HHCnf8QQXq5wAKzGFkRxH026y2gjv__JIi9L>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 03:38:04 -0500 (EST)
From: Pierre Barre <pierre@barre.sh>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH] 9p: fix data corruption with writeback caching during concurrent stat
Date: Sat, 27 Dec 2025 09:37:51 +0100
Message-ID: <20251227083751.715152-1-pierre@barre.sh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using writeback caching (cache=mmap), v9fs_vfs_getattr/setattr have
two issues that can cause data corruption:

1. filemap_fdatawrite() initiates writeback but doesn't wait for
   completion. The subsequent server stat sees stale file size.

2. v9fs_stat2inode()/v9fs_stat2inode_dotl() unconditionally overwrite
   i_size from the server response, even when dirty pages exist locally.
   This causes processes using lseek(SEEK_END) to see incorrect file
   sizes.

Fix by using filemap_write_and_wait() instead of filemap_fdatawrite(),
and passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is enabled
to preserve the local i_size.

Also fix v9fs_vfs_getattr_dotl() to check for CACHE_WRITEBACK specifically
rather than any cache mode.

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_inode.c      | 11 ++++++++---
 fs/9p/vfs_inode_dotl.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1..f4c294ca759b 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -977,7 +977,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		return 0;
 	} else if (v9ses->cache & CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode)) {
-			int retval = filemap_fdatawrite(inode->i_mapping);
+			int retval = filemap_write_and_wait(inode->i_mapping);
 
 			if (retval)
 				p9_debug(P9_DEBUG_ERROR,
@@ -993,7 +993,12 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
-	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
+	/*
+	 * With writeback caching, the client is authoritative for i_size.
+	 * Don't let the server overwrite it with a potentially stale value.
+	 */
+	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb,
+		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
 	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
 
 	p9stat_free(st);
@@ -1058,7 +1063,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (d_is_reg(dentry)) {
-		retval = filemap_fdatawrite(inode->i_mapping);
+		retval = filemap_write_and_wait(inode->i_mapping);
 		if (retval)
 			p9_debug(P9_DEBUG_ERROR,
 			    "flushing writeback during setattr returned %d\n", retval);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..362a68a2bca3 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -431,9 +431,9 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 		return 0;
-	} else if (v9ses->cache) {
+	} else if (v9ses->cache & CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode)) {
-			int retval = filemap_fdatawrite(inode->i_mapping);
+			int retval = filemap_write_and_wait(inode->i_mapping);
 
 			if (retval)
 				p9_debug(P9_DEBUG_ERROR,
@@ -453,7 +453,12 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
-	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
+	/*
+	 * With writeback caching, the client is authoritative for i_size.
+	 * Don't let the server overwrite it with a potentially stale value.
+	 */
+	v9fs_stat2inode_dotl(st, d_inode(dentry),
+		(v9ses->cache & CACHE_WRITEBACK) ? V9FS_STAT2INODE_KEEP_ISIZE : 0);
 	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(dentry), stat);
 	/* Change block size to what the server returned */
 	stat->blksize = st->st_blksize;
@@ -561,7 +566,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (S_ISREG(inode->i_mode)) {
-		retval = filemap_fdatawrite(inode->i_mapping);
+		retval = filemap_write_and_wait(inode->i_mapping);
 		if (retval < 0)
 			p9_debug(P9_DEBUG_ERROR,
 			    "Flushing file prior to setattr failed: %d\n", retval);
-- 
2.43.0

