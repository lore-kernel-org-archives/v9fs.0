Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5113EFE3
	for <v9fs@lists.linux.dev>; Sun,  6 Apr 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956393; cv=none; b=qtv80KsXV11JlVYobOTJsmqRCENHUMwO02WmtdbBZqCg4GXnDvVnozKUNkdq8mL0WC8JI4uJz52C9ITqBo/XdcYZy7sYjf37a44vadl/r9gnF9LER2QKYpuQMR0wmdAHyBlilivR4BcUoOTGv7zxpUvI7V468ytWF7PI/jYJNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956393; c=relaxed/simple;
	bh=fI3vkS+krf1U6BBkdYKQY/Hab6KZldsn+0ObTSBgNkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi1hnhZUWJTwytdMhXOPnR49aFVQC5CaAlFNvc7WUH3sM0iIKDh33RTxSysxd1+T2gqKaUvECgsOdat+d+fZUxI8mz/9IqplehpKK6FbPOv29wEbfgWSfNFErLBbI1g+5W2p47Xp2tQievLHz+3fcI7oagn1q9wJtb8NeLZemaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lxV1Bf6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/IhbFRB; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lxV1Bf6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/IhbFRB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id EAF781D41D73;
	Sun,  6 Apr 2025 12:19:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 06 Apr 2025 12:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743956389; x=
	1743959989; bh=j3If938ipgLaWPPC85FEdL9RC4alBIGT14T+blq0sIQ=; b=l
	xV1Bf6xYNZw2F3N62VVnUFYe03lJ66bBWRkfaxskcWieUgIqE4TrXWZVxcJtWrYl
	ea34IjpbK0UFbr99uYl+nd3aEOJwV76JDMcK/p64d2nFJGlgK5gj3wlif3eRIhab
	dEMR9DOResn9TZxsAoGS/wCnZa/yG7jEn0EnImxwRE25BFTdOCWysquOV/q3jgsB
	bdNmTfaq6ud+284SQ9AfqKJfFjLLF36ylSLJ7kMpBwwH9EROTrYzG6OjP+IapW9q
	1e3M8zuXXjzdKZHJNf7SKJpJpvkFDDgVNeWplQz4nHSz0trjCw2HM6ntFBSmvZ4L
	i45s7r1Wl+VFuL+8svyuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743956389; x=1743959989; bh=j
	3If938ipgLaWPPC85FEdL9RC4alBIGT14T+blq0sIQ=; b=b/IhbFRB+WYvVzsaF
	rbgu3LCc+SDz18c2yTLzIqPaSJy/6DMrLDXxRblqG0PTAP2g69udp+sUuQEh6crN
	6pA7QWZ4ss204OCLAhrLXem1DR4HQpMfjF9afXtRvGmdkLCF1vN2oTYshSc2Ypdi
	5AAKyt7LVrjhwDvh4v4BifcZ/ggNL/qvV0W0cusOFwk/n1wD16eFPX9uCn2SH3XP
	4BEp69ZsKYgjQNzy70QnrS+qGio5YG/e0WLFKje+5iVprMphSfSoS40dVLDiCO6u
	Wr0IE0Vqhn/ZD6XJwotc6QnqELObagToy4HUIaU6f8e0j114xut3+HG4k7e26zsj
	PmpGA==
X-ME-Sender: <xms:panyZ3H7lzLJ-JipQTbDmRL14Pbx0tEBqLDGtFiIhcKSrqmiCVujlg>
    <xme:panyZ0WxvygNd_w6rSFq-3U18WjVRHb1adkg0uB7ouu37vJ1Mn7lRJL-Jk1YsE7-k
    TKYo_r2eTNxG9l9oG8>
X-ME-Received: <xmr:panyZ5LQ3svg-68jWpKJ5rR5YBL4bH7NoSiGcJzOotIOsZd3wkoDhGHFA0v76-yTpZXG9KnQS00d4w_QPJI1_4EKY2tZRNitAdQs2LFtW_u9d58lrzqYQGo>
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
X-ME-Proxy: <xmx:panyZ1FmvSRLdZVgVst5z9P7Bgan5U5Ng4ofH-AJGheS81KcM1hwbw>
    <xmx:panyZ9UagZtWdrYbaTrIk1Vo2SO-5FCYHQbWPm3cr3IhhGbqAPdWQQ>
    <xmx:panyZwNnVidnc-H8z4BjVsFFJC-Ca1vRS62R3FlugbUFZiDUqLZ69g>
    <xmx:panyZ80fuGOvUe4KXokAo7AYIBCt6z-F5EX0xEPm2ISAhLScI7oTMA>
    <xmx:panyZ9jBkFEJPNtcjtDONY_YeNRsJZrpbja_T5GyT0iraYx3MF2BbGZt>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 12:19:48 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 2/3] fs/9p: Invalidate dentry if inode type change detected in cached mode
Date: Sun,  6 Apr 2025 17:18:43 +0100
Message-ID: <01afd3c77d5cda181780dc931baa8f3fc54562c8.1743956147.git.m@maowtm.org>
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

This is an extension of the last commit to cached mode as well.  While
server-side changes when using cached mode is not expected, when it does
happen we can get things like -EOPNOTSUPP.  With this change at least when
we realize the inode has updated (for example after a `touch` on the
client), we can get a new one.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/vfs_dentry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 7ba9e3498e85..38c494870ffb 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -97,7 +97,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 		if (retval == -ENOENT)
 			return 0;
-		if (!cached && v9inode->cache_validity & V9FS_INO_INVALID_ATTR)
+		if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR)
 			return 0;
 		if (retval < 0)
 			return retval;
-- 
2.39.5

