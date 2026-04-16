Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6E379EFE
	for <v9fs@lists.linux.dev>; Thu, 16 Apr 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324437; cv=none; b=n7shiwFGTqfxMGUT+7BP1n9gRI6kliTBSwLmMd/Q6tZQwV8DwOdhVQu+0GWb6waGdEVHSfCYo6tuTuOvcOfnOkDcueoaaK7yJ1sdJ+9x/O8H6OuPxur5bf5URGjmm0GxmUUvk7vq5NX/YUOSl0b4ObG8zB9avXRSTZ32WIP+8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324437; c=relaxed/simple;
	bh=ZhMOLgpHN3yGIaFbzkPMqmq8a+N6nFyZrLu0eAaI2vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkOpmwgmzo1ssAGshLy3Dv+MbvXOhLkqRo3kVNccgMDhTOEErJZ2I19GYrnPsjicLSr+oB1GSVsOvQbtORk73dGoHzpwo01Ydm1b75JhN6NTyOAF+MGyBS9C+SbO9ZelUq5FPjhVTuTXIjhfNQQFD3Y2wiLBPegEO1IRc59wiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=mMWEOjbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A63FBYPt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="mMWEOjbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A63FBYPt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B4AC11D00276;
	Thu, 16 Apr 2026 03:27:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 16 Apr 2026 03:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776324434; x=1776410834; bh=RK9ZLoaLKywcyvi9A6tiR
	/lDfk5nhl6XccwMuMNUmYM=; b=mMWEOjbCrU1LcdzXl7Z2QLPXwOrJE+V0cW406
	NuzBtTnYzI7AKxwvUvc49FZGW3NQbYVZrB2CyUHYbpHvXTMVPQ0zXRYMTWEDNs56
	upibv0nFzi6tXysHXIwRQYEFvX5cCx+IYjd3ZX1KS4s+WbPNcyuVXg2TXMslg2wi
	Wfk6Ov48j6YO2Aex47hg1H/L3hYqiyrZQoSfWQ0fXT89YEwn2mWdKY/FvxBbdDIx
	u980J961+Wc0Vod6wTUQUZtsQm8XQakvoCmQeHsH9PfXbyxYdX6BlEeQmISMIG4f
	veFriNVftUH4RDllel3/jYYn7rPqGz1B68vnBnYnf24DfS7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776324434; x=1776410834; bh=RK9ZLoaLKywcyvi9A6tiR/lDfk5nhl6Xccw
	MuMNUmYM=; b=A63FBYPt/Hc9lpRKHeNCzVfFa+1TLb2bL8xP1fiXK1UI9aBmxvb
	BGIFylqWRTNsMWac4DN3ovhGAfrSu6PXhamYIB35s0L0mY01uEtmujJNYaRfK656
	G2m8XRlyf4W73uvLiyn8LKqYKNSKNXLtghNaPOLMp8d/UzjRCtAQhKj5C2HR0fPs
	BU0YCNnznv5urEpOYcOu3CHV1diaBQC80484YYpHAISAZmBSjx577KTc/zWsdEoS
	+bI68StifFz7LzZfi06ZI1ugHiVNx1YigQ5WEc33Q8LjSiU6y/ZQ+pdp1rf9NJOE
	w7F18hS5yROILbcIufbIQ13S5UGopkZT6Rg==
X-ME-Sender: <xms:UY_gabyfDSjUcDeMoNreo8iEg5pmsoNKb1Q58DNAMiCakD2haOr7IQ>
    <xme:UY_gaT9ZTyPqVmhmv3aqcKaxRSXHqOntljTtiLBxkJFjBUZeL2ClLKS70q3bISxNv
    fz2oxujbQOQ22r-BjzJJVdeBze-uE6Jo9H-xK1Fht6oSmvVfX4BmWsq>
X-ME-Received: <xmr:UY_gaThuwILz9yO82k4E-J_7ZDoEuLnhxQuDV-WDfhec7bQEeiO0ZISgZoWFMO4IoF3Zl6N3YtFpzlTHf_Vqqdluk7nJw0duZk2C_xHagoNYl4EpOb9OgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieegtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UY_gaaGd4gxkXb4drgXTmyr1JQ0_lwyk9RF-pdiXoZX_YySYQ2ts7w>
    <xmx:UY_gaS8fYnjjHZmV2pnr8y_CsIsNhFJcf4Fo_Shbpb4UlItvSiBV6g>
    <xmx:UY_gaRx8iHncQ18Se-Oy4zx8Hc3rs2O_ds1aoRE2063McFgk80ssyw>
    <xmx:UY_gaeO9-qMkresOW3LyFRzvSwNXIyILKqMXRRBeUXJZDJ-OdOCujA>
    <xmx:Uo_gaULexyfzbAyFwkFbRWSvXLPKt_5lrKY_J_sEM4nUg8OePRH9RXCU>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 03:27:12 -0400 (EDT)
From: Pierre Barre <pierre@barre.sh>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH 1/2] 9p: use kvzalloc for readdir buffer
Date: Thu, 16 Apr 2026 07:26:18 +0000
Message-ID: <20260416072619.14241-1-pierre@barre.sh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The readdir buffer is sized to msize, so kzalloc() can fail under
fragmentation with a page allocation failure in v9fs_alloc_rdir_buf()
/ v9fs_dir_readdir_dotl().

The buffer is only a response sink and is never pack_sg_list()'d,
so kvzalloc() is safe for all transports, unlike the fcall buffers
fixed in e21d451a82f3.

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_dir.c | 2 +-
 net/9p/client.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af7f72abbb76..487c177aae38 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -70,7 +70,7 @@ static struct p9_rdir *v9fs_alloc_rdir_buf(struct file *filp, int buflen)
 	struct p9_fid *fid = filp->private_data;
 
 	if (!fid->rdir)
-		fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
+		fid->rdir = kvzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
 	return fid->rdir;
 }
 
diff --git a/net/9p/client.c b/net/9p/client.c
index f60d1d041adb..6d9b9054841e 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -765,7 +765,7 @@ static void p9_fid_destroy(struct p9_fid *fid)
 	spin_lock_irqsave(&clnt->lock, flags);
 	idr_remove(&clnt->fids, fid->fid);
 	spin_unlock_irqrestore(&clnt->lock, flags);
-	kfree(fid->rdir);
+	kvfree(fid->rdir);
 	kfree(fid);
 }
 
-- 
2.51.0

