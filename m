Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2556146588
	for <v9fs@lists.linux.dev>; Sun,  2 Nov 2025 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127896; cv=none; b=eJ0WcFDBvfFYEjncJuZmvKk0ZpNtzpqoFlADPMg7FdormP4qDgeo51F1bU5Q3oMJPxvG3jMv1unG1CkA5iK4n1PtfcyBouyBH3SUTJEDaczfym/wM3TatxDlQmOqTltYxbospKIQ6J47ElCHWOmogr29ljHbDbQurRkGU6wwXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127896; c=relaxed/simple;
	bh=LSFB4fd8y3kKW9xjXYuw8h37cKrz3KxdwCuFl8Ti5nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mviclh4RAxM6TZRBKvMur1qCaziI9sNSrSoakeHrdhj+Aw/V5OpX1J2EA5RY1qAkAVp/34VbqcK/MJ63Ixir3yUh0ZbIzvPPGCoP8FnezcAp298C4xIL8HCik3HPyW28thXVzzwykqzXp/L/aXisvyF/cpkexEsynEBQGBGjtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LIcoOuEM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xIB5o9A1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LIcoOuEM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xIB5o9A1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BA66140006C;
	Sun,  2 Nov 2025 18:58:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 18:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1762127892; x=
	1762214292; bh=qIVMnlRNqGEtcv94TAb9qW0yw6fiYLCaP1fq/9yiMxE=; b=L
	IcoOuEM6CG/byFQV4vciXSZe4pkoyNR2BPTtT5zO6av/JbmU4IBtxex9G0gwUJ28
	rHIC1QciTLLA33pkXcmfJNE+fX8RAXYG9D9BaERV6HXLPxRGIIzPzt086GEo5bwV
	jaAvJ0PFSk3A1li+3hV3fLyQ9sQXmod721D8tJBo8e5+8GTWyh21UhAWDRUlYpc/
	gWm+dcEtWLotBaHx4jaWZnDuJ/D9WNr2TLEQ2w6ccLj4Li/gAdxn5rMviFmpBgBN
	L9NlmtZOZ3I5Gbak4x1mP4ATSPdYPmkNJXTka8hsEdV9zjb9IHC41g6E/qTvFOp5
	UXb6Kjp34P/ZJCJXmBniw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762127892; x=1762214292; bh=q
	IVMnlRNqGEtcv94TAb9qW0yw6fiYLCaP1fq/9yiMxE=; b=xIB5o9A1qAldy0SC0
	oCdA2srmY0R10e/0f3hGzbrkFo9whrOC3zyo2rUTpvSwKokuYlmd6g843UEKUDzE
	TD5dddTOWwv7N/YTHIN0uLd+YTGIuvlbCOpXtFv8cdaKM6Q1cN8evjLz9yJX2z1E
	tt7yzcYp+5H6bLfooMiPC6gWGKPtmqj0B/E4hBp9rNYym6vcrJQ1uJMW3eS2Yv1z
	aqds7M8qySQw8fQnHiKSdMC/rWKY7IasFRD9s9zrglzb8JRa1fALmJtEOYCtJ6hi
	sz/Z5Z9RlGwZXueB570R7raRkNzXWRR1IneUuCar3/qr0MgmQM+WWGFMeTtQOV0C
	o1/XQ==
X-ME-Sender: <xms:E_AHaaOWLS1_1UuDj_-h-xXQDZEH8OIV6Dk0kAAbcgKLMc2NNrbmtw>
    <xme:E_AHacrWdGEg61EoC3FgHPCEmnZTwDOotSRiT8h_gDrdIJLk6pC0vdQDGS6C7bArU
    uEqcZxiNJZvlpnZNjvhfxxnK2d08yoqRX7yjpk-mnAqsA-It9KlPA4>
X-ME-Received: <xmr:E_AHabFKtO52hFcebDk6Rp7-4wyz9mH_-2ayL3nKM15tm_uplHWsnSiuHFggj7J_-vi-9ib1m9lDhozQB7P0flpG3Audyoyqq8lP3xfSmg8XE5xdmkoFtKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepmhesmh
    grohifthhmrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshiht
    vgdrtghomhdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhssehlihhs
    thhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:E_AHaRpD-Npll2KgV40UJgGT_OJSe6reA2_a2WGonDsw7vhPa2Mi-w>
    <xmx:E_AHaUa9axbCVqT4K0q4Nc0yVbx_asMsIiMkmQz1I7y2MKvT_oVwpw>
    <xmx:E_AHaaWZpBfNDBrLG8vohqvpS0UY6a9HCeVoDLjMR2yanx4s20qq9Q>
    <xmx:E_AHad8fRLvnUWrh5ywUY3CCHQORDtnl6qGR0GEkI-gdxkFZ0VO-yg>
    <xmx:FPAHab96MaEIMFeY-x7aLDNkFfY88AxSxGacwYNdLTmcKFJtPUBJNGll>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 18:58:10 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Tingmao Wang <m@maowtm.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	v9fs@lists.linux.dev
Subject: [PATCH v2] fs/9p: Don't open remote file with APPEND mode when writeback cache is used
Date: Sun,  2 Nov 2025 23:56:30 +0000
Message-ID: <20251102235631.8724-1-m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aQfkMUncxteb9aPW@codewreck.org>
References: <cover.1762115015.git.m@maowtm.org> <ed2d3f0045f538e8ddbd2d0a151e31767dda87e8.1762115015.git.m@maowtm.org> <aQfkMUncxteb9aPW@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When page cache is used, writebacks are done on a page granularity, and it
is expected that the underlying filesystem (such as v9fs) should respect
the write position.  However, currently v9fs will passthrough O_APPEND to
the server even on cached mode.  This causes data corruption if a sync or
fstat gets between two writes to the same file.

This patch removes the APPEND flag from the open request we send to the
server when writeback caching is involved.  I believe keeping server-side
APPEND is probably fine for uncached mode (even if two fds are opened, one
without O_APPEND and one with it, this should still be fine since they
would use separate fid for the writes).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

I haven't done a bisect to figure out if this regression was introduced by
a change or was this behaviour always present - 6.14 has the same problem
and 6.13 did not compile for me due to some problem with bool / true /
false being a keyword in c23, and it could not compile with c17 either.

 fs/9p/vfs_file.c       | 11 ++++++++---
 fs/9p/vfs_inode.c      |  3 +--
 fs/9p/vfs_inode_dotl.c |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 612a230bc012..6f3880208587 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	int omode;
+	int o_append;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
-	if (v9fs_proto_dotl(v9ses))
+	if (v9fs_proto_dotl(v9ses)) {
 		omode = v9fs_open_to_dotl_flags(file->f_flags);
-	else
+		o_append = P9_DOTL_APPEND;
+	} else {
 		omode = v9fs_uflags2omode(file->f_flags,
 					v9fs_proto_dotu(v9ses));
+		o_append = P9_OAPPEND;
+	}
 	fid = file->private_data;
 	if (!fid) {
 		fid = v9fs_fid_clone(file_dentry(file));
@@ -58,9 +62,10 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 			return PTR_ERR(fid);
 
 		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
-			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
+			int writeback_omode = (omode & ~(P9_OWRITE | o_append)) | P9_ORDWR;
 
 			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
+
 			err = p9_client_open(fid, writeback_omode);
 			if (err < 0) {
 				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8666c9c62258..97abe65bf7c1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -786,7 +786,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~(P9_OWRITE | P9_OAPPEND)) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
@@ -1393,4 +1393,3 @@ static const struct inode_operations v9fs_symlink_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
-
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 1661a25f2772..643e759eacb2 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -282,7 +282,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~(P9_OWRITE | P9_DOTL_APPEND)) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
-- 
2.51.2
