Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874C2BAF7
	for <v9fs@lists.linux.dev>; Sat, 27 Dec 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858629; cv=none; b=X73t93cvC53FDcI6I7jpYhf2KXmkadCCoIkAzR57o6TAqikwMPMxTlAaUBeH46wPKdKnlsdhmieLJeznUU7XJFkNRxclFnfppfoueRTTd7QVvWHjmTYFAZiSoQyeKT+Po01juhAT7OOHk/Chr3jjBjbpFbPIYr2tMlgv3baHnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858629; c=relaxed/simple;
	bh=1iKk4TlQYaaPuFEkr999UB1HWYWKTOM5VBvK7CsTtEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HALJg5DlZTLsMi0UT18W4qkJY+4Cd7JbiE/GfF/RA67ppyLTOMcvjAagRPbMM7FlHokKtPUiypJ60Ym1BeBQoYk3Hvx45d9k2lMV7io4GR4yRgMf4NEG0t+2VLRx53Pb1Cv0O4K/Flh/IHuVEoSFQlf7zLl5QbWwinvRaM79ndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=L5+4a3zw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiRa6qb0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="L5+4a3zw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiRa6qb0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1E9C7A009B;
	Sat, 27 Dec 2025 13:03:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 27 Dec 2025 13:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1766858627; x=1766945027; bh=wsC30HRMM02X32a9o5jCY
	TRr4CIHL44A+GaMuiIgznE=; b=L5+4a3zwEqtuTBePIXQIiah1epxNkVRPXVhAY
	N2PCdleCSfKdM6hDQoIZK81jCjvaNTf/VDUAdUqdZcZYwyrmx2XcKk8+UkXLupXq
	PH1z7AnqO0lkCPeCUVH22y112t6hqLruKW/7XPFkbDrcgINyK9Rn115+HSyVxSkF
	7TD9etckEAeFxv50M+DxPa83dxy/CyvpSR2eDpCEM77m9L7UxLAC6Zy/mSTicoaG
	fwOsG/KWk592rLMqm/Fda6RfUK0RQkM70qDX+j+aYA5UcEFm5pzRftwQ3+6WlW7h
	e8JjQ3MXiLymXvTfGS+2yT4DaWvSzIyFqVJ50UHJLJ+IkG0XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766858627; x=1766945027; bh=wsC30HRMM02X32a9o5jCYTRr4CIHL44A+Ga
	MuiIgznE=; b=LiRa6qb00d6YyawYRGvXXZ7IpGb0y1NiU6SGqKavlvm+uuY/chR
	neLuVW+tXrZWjy0r/aD4BkPKamOLNlcE5Nl8ETHX8NAuYJdTqPRQj6vNrR2Sp7vD
	1PbHHl6rgvQkvVCnoBkVgDE2hYmScFFKg0WYvEnwtY+iG7tQ04Os0kRK3+YpibKT
	H/TAvKGSwFHVBWBNEhoCp2L2MWF2D8jX+WOlfyI1IzthVFGEa98MpKlqcUc4pIZ+
	BnZeSiYfwsxZFxKSpPwRxywO89I217RYD9knmCmwckygN4DZOEUacSZLHKHohP89
	ZTIcKMs4rx4M+1GI8jm4wU7DjBlOG2cOCtA==
X-ME-Sender: <xms:gx9QaegitCToSTuTXgxWYsqt4Jey63m3q8nuSKW98BS453r2iCI1GQ>
    <xme:gx9Qafu6nmRbFHCoHXnAI0kwKN6Tnqpz6cpWPvdyzayNArhL7VT4Oe1Hh1zZXjfd5
    tvr0ODvYHta3_B-rocOKMHvYeBegr6fHCVHTrUUj7jQf13fTtAreko>
X-ME-Received: <xmr:gx9QaUTzq8S8B9GleuRzIYWN-knxk72IIU6AyVwE6V0ryV5MMXrD8p9cr2SlgM8w83ZG1i0aat7rD2agyBkFsB0wJ5Kw4L6D80UIfMuRj-IAu9OXB7yKn1XbUvt2tFFFulbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvddtgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:gx9Qab0Lw8bu6cetKzCw0_F43Sm9lAyfXZueKPLDf-peEokCXhFClw>
    <xmx:gx9QaRsprgncCTX2TD6JROaqrd2ryU735uJkkq4zdhS0Y1-1D9gKWw>
    <xmx:gx9QaZi9YnW-DLlpCKUjhDGhsiNwvErBj2r0JCiFluqRYlJEvU9eEg>
    <xmx:gx9Qaa8HDt0Q22dWDfUYF69dNBSvIPlSTZIuw8NEac0yFB_t2MzLnA>
    <xmx:gx9QaZ5tTPwPH18UZgAO6ilG23QGviXLkbX19MazCOqxRsnNZaZ2ylip>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 13:03:46 -0500 (EST)
From: Pierre Barre <pierre@barre.sh>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH v2] 9p: fix i_size update race in getattr with writeback caching
Date: Sat, 27 Dec 2025 19:01:37 +0100
Message-ID: <20251227180137.730385-1-pierre@barre.sh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With writeback caching (cache=mmap), v9fs_stat2inode() and
v9fs_stat2inode_dotl() unconditionally overwrite i_size from the server
response, even when dirty pages may exist locally. This causes processes
using lseek(SEEK_END) to see incorrect file sizes, leading to data
corruption when extending files while concurrent stat() calls occur.

Fix by passing V9FS_STAT2INODE_KEEP_ISIZE when CACHE_WRITEBACK is
enabled to preserve the client's authoritative i_size.

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_inode.c      | 7 ++++++-
 fs/9p/vfs_inode_dotl.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1..bfba21f5d8a9 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
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
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..67a0ded2e223 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
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
-- 
2.43.0

