Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB213EFE3
	for <v9fs@lists.linux.dev>; Sun,  6 Apr 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956396; cv=none; b=sP+1dB5bJWG9Ghug/u8NibC77K3MZQpRHdonIE3TJhH50K3Af17SzZ8lJPE6Wp2zQ2FFAda1SuZDDxSjWlv9rnWD2tIo4At5L+B/enE6mPscZy9VYtGfYb999nZk2+tEAyh4pPo5oqlOFHsRanicrMXISSUiM9qNH2Nc7PoyoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956396; c=relaxed/simple;
	bh=lIn8UtqzdKq2gDobWj2dwSZb7FhYW99dRsr4XD/NQ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdZrBhw5+rO1ZVMW/xjK8hH158/E+T/21Cd5PzmS1ynX2P2AKCXbwI9c8jU8rg4wcEWRsyhDSH+1wcpUjXuBfKPzlFu79Av8m5GG4gx5AbR5hfucMkrRWcb0F4Qh/xhNeLM+Bb1Cm+04BZgwLO4t/6jUk322yyPchAKVm9BFAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cLXItSVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ub/7oQ/z; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cLXItSVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ub/7oQ/z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 60AF41D41A15;
	Sun,  6 Apr 2025 12:19:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 06 Apr 2025 12:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743956392; x=
	1743959992; bh=BeXfQsghkCsYRf2XAe2luXeuvCr4AKRkMSkzfqQlTTM=; b=c
	LXItSVVXC61/n7hYg8h6o9GG6QwD4NWSRzbEYcyWoDzmR8JQDxWHWeZKUp0Qd/Po
	ddYEobZiOkXcPuv5uqmcu2KKMR4TFa/A5+w81Btb+gcTfq7tiWOdsY0K/tl+x8OS
	EN/h7zrhTSnq2uC2VBuO4gjVeBy6+/U+/Pfilw3kCgqMRslDAcFxWz3/3yYM4igJ
	96nVxo8uJriZCFsHTtrLh2eLO4Hf9u7CVPVz2wIqk3i460EsUnYn2VP751uZKrID
	tyvg2klcv320DbwzfwFHR3RdQ4nUDcEDZnI/UC8QXYRsT7GWWTNIO+A/yvv+RB6S
	K02maMw16fw+qvcZmQLXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743956392; x=1743959992; bh=B
	eXfQsghkCsYRf2XAe2luXeuvCr4AKRkMSkzfqQlTTM=; b=Ub/7oQ/zs4lj7efbb
	PUJaraF38XeADl3CCu5vugko92I3fsP4NsvByTJi/raHokM0wtNDghxXddfbB3tX
	tE6MGJ59GKkg+f06vnJHLN69ha6EkZELOsjw9fkhuukrUtNgh7AFPpfUqit9zePi
	qxH0/+ADHFKUqdnpfRsntio0I2K4U9FTIsVmS3DBR45CDT9LxILg4FGh855/xihA
	ddzMH4cRoykcliTJuUhYq9wEL7+ia8Og2M9qDjeUmbzyhXHC+fVhd3S6asU4JKlK
	06I5N2QQbJqkG6lTX3yob4Pv5p0ueaLeOkLiPwZ8uZjjX51m37hJanojM6W2QKYv
	tCI/Q==
X-ME-Sender: <xms:p6nyZ71GcX-YaVg8kr0mooGrwgauXEDe-kA5reAmRHTrueL7ItynpA>
    <xme:p6nyZ6EI-2ydHhfcxx-rZLC8Rw0_6fyXId0BftK-TU3kudi5ZSCtwFdVmxfGS8ACi
    PSqo-h2-XjQQ9Y3iOc>
X-ME-Received: <xmr:p6nyZ76qb3ruZwC3JvTn2YccPSAXcD0v_boT4nuzZ7cSgoOyzG6vZtuo59trgJI02nxg7S2exqPEZFJh5_v8_XmAK_0fODNQUa4DaepjLIwKIFef1ZMiZZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleejjeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:p6nyZw3T_eQ0rjeqr8nrv0Ak2t8d1wX5ElXmZMp0KGSs5sBu2Y5CrQ>
    <xmx:p6nyZ-FO8J0c65FCEZqeldpCBm_dtGsh1z-KqXRVyJ0AX3ptQyCNXg>
    <xmx:p6nyZx9YgnzfaJQN9T7i3aHFzVAQ5qlWEe1tvzkB10NH_whdMTn5GA>
    <xmx:p6nyZ7nw3K-QNg7FaQUDWI3qhm-F9vkc9HTcl6Qb_tAxyTC82BvOuA>
    <xmx:qKnyZ-T8-K97xMOfm5jSfBDN4OWEOXu1yu-hasV1WyLI9-SpPEPVhg_I>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 12:19:50 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 3/3] fs/9p: Add p9_debug(VFS) in d_revalidate
Date: Sun,  6 Apr 2025 17:18:44 +0100
Message-ID: <00829a99549e33d26139fa4d756c466629f13e00.1743956147.git.m@maowtm.org>
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

This was a useful debugging / validation aid, and can explain why a
GETATTR request is made.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/vfs_dentry.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 38c494870ffb..0b940d595e34 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -85,8 +85,13 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		struct v9fs_session_info *v9ses;
 
 		fid = v9fs_fid_lookup(dentry);
-		if (IS_ERR(fid))
+		if (IS_ERR(fid)) {
+			p9_debug(
+				P9_DEBUG_VFS,
+				"v9fs_fid_lookup: dentry = %pd (%p), got error %pe\n",
+				dentry, dentry, fid);
 			return PTR_ERR(fid);
+		}
 
 		v9ses = v9fs_inode2v9ses(inode);
 		if (v9fs_proto_dotl(v9ses))
@@ -95,14 +100,25 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			retval = v9fs_refresh_inode(fid, inode);
 		p9_fid_put(fid);
 
-		if (retval == -ENOENT)
+		if (retval == -ENOENT) {
+			p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to ENOENT\n",
+				 dentry, dentry);
 			return 0;
-		if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR)
+		}
+		if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
+			p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) invalidated due to type change\n",
+				 dentry, dentry);
 			return 0;
-		if (retval < 0)
+		}
+		if (retval < 0) {
+			p9_debug(P9_DEBUG_VFS,
+				"refresh inode: dentry = %pd (%p), got error %pe\n",
+				dentry, dentry, ERR_PTR(retval));
 			return retval;
+		}
 	}
 out_valid:
+	p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) is valid\n", dentry, dentry);
 	return 1;
 }
 
-- 
2.39.5

