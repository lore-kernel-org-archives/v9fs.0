Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBD39AD45
	for <v9fs@lists.linux.dev>; Tue, 12 May 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592084; cv=none; b=D+qXvXhNJHuca2Nq19+d1mKIymXl1DQs7RtiPehB9MZahs0/HI6J8TefWl2yxSYJHsIa95sBcpA8IgnxCsYS7lMtHjkzQ58mfr4+aUU8A29v5VSAXeW6OLUVt09gD5VBq9mEj6quzbm5nnTK8UEmkK5fL3h945DkMzg5hiYvAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592084; c=relaxed/simple;
	bh=BqLRv4jYYmb9hrGgeldOh4VKeaHh4+RsjmrUUhS+q58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrOTeiB96zE8X8qMPgPp/ZSGIfQN+pMv2hFXV7KUz0NwJisoU7a30LkdLIX1EPCXS0py+OM18+aLOrIWaS+rVxo4uyXQhTpqjTgLuExKwwD+wTCPPWB+HT/wgsN3yRq4VPjvsI8UxTQ6dZcytWQeevDRTR4diTpjQbo7PeUWFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=VdyNRAIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DINUjjc/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="VdyNRAIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DINUjjc/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D4CAEC0233;
	Tue, 12 May 2026 09:21:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 12 May 2026 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1778592082; x=1778678482; bh=Vz2sgJ2ouPOtvi6/CAJEr
	s2Nbhqc0ozMU5qbUEbLAcs=; b=VdyNRAItGEl2no535uSofVGqPfJobOabn2D0X
	Gl6/1/Kx2v2ymBfoWI3AOW08YHWAtQdzGuYPNjx0jnHnqsIpjSPcw3FPNmjyhFXP
	LzZ+0R5Lj826n2khwA6f2fyfon/GLkDteT+TvRJWYnc5v3gmZ/D9vbEFJ/FSYZtJ
	mcvcDeLEKWRbZLj4FFta6Lr4zRZPQyeXvoX460alzrtr2sVhDmKtAD7/ecpwPSNZ
	E04FgDzRnnFhhSrvo/8IdakHuitZRpkaRxeRF8NPKIcZOAiWX5kAjnjfxTrMeK8v
	NoiNGTfe9IUUtg1Dr36hjzd8K9RRjpytFN+uzt03uDYC6sUQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778592082; x=1778678482; bh=Vz2sgJ2ouPOtvi6/CAJErs2Nbhqc0ozMU5q
	bUEbLAcs=; b=DINUjjc/1krpLc2u/2MGfkp1IPkT5m9Ol5GffeMnm+TZL7yWpUe
	vgwWBfU5YZccGH7OKYIv8V5cLLbogUNTaN4nJFPIQ2F+gWZmKhh++iOfvfhn3Dsq
	R91hfmofMqUXJTSDUJ8gMcS1buzUCSWKBIC1SVdZmZU0S4gZSHI8S5/qqMSQ8Kmw
	0vFX0kwpLYrGIFfhUwwOk43Fju28/uPEkK9i8d7Tsl7IBdSvP7LGfhLe6Lev5PBO
	vWvywVVPQ5WODOL9EPBLwOyggw6to8yWQ68fGXAs+FSJVhQKQScx74o06Z4oPf24
	DJvk2X03po6l2hzGBoGN6iyaKyRcIPk3y6w==
X-ME-Sender: <xms:USkDal0EwLIqo-x96N-OYRFJ3UJjdf3a-sqkAOI0KuxXPSmMpSsOSw>
    <xme:USkDamGHUsCurUXE2dFrLgVS97ppzY3KNBcKhLMay8oReacKHzCr77Nr0_GQbnpQN
    suHi85YZYH6vfTfw50PDySkcisg7biPvHQsHd_yq8P-Y2PfdTGSoN2x>
X-ME-Received: <xmr:USkDashYbxwfH30mIOyuUag4BJ6672Y2dHGW9b5JpCXSx2mLcMMs2AeywQwnKLPBHgPUaDQxoISPLTjNDEVop1ol4ehXfH5G7Ct1rTk5baRYsg-CJtjKsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprfhivghrrhgvuceu
    rghrrhgvuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvghrnhepue
    ekiefggfelueeihedvtdfhvddutdejfefhueevhfehjedvuddvgeevkeehgffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhivghrrhgvse
    gsrghrrhgvrdhshhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgthh
    hosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihr
    vggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrd
    gtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhivghrrhgvsegsrghrrhgvrdhshh
X-ME-Proxy: <xmx:USkDahB7RE7zM-cp05K-PSyQGucF9HEGFsMhc4oAdylOeRaSOJq6Bw>
    <xmx:USkDamQWPK9dt2l04WWZfd_mNXMS0PhOEolv5E_yyamirFH_cX-uBg>
    <xmx:USkDauVAlycbeM5XHd1NdugD1wJJK0ofsPvE1CyUERSggRud21dnJQ>
    <xmx:USkDanc07q8dNrBIkXjeQEOMICbzzyBv-c5SSRHhw4_0BHrkwg9nwA>
    <xmx:UikDatKvdEBQkHiIZ3btjv7GJgd5_Lt_Td85ic-cfHKizInQ1rZIA2CO>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 09:21:20 -0400 (EDT)
From: Pierre Barre <pierre@barre.sh>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Laight <david.laight.linux@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH 1/2] 9p: use kvzalloc for readdir buffer
Date: Tue, 12 May 2026 13:20:31 +0000
Message-ID: <20260512132032.369281-1-pierre@barre.sh>
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
fixed in e21d451a82f3 ("9p: Use kvmalloc for message buffers on
supported transports").

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_dir.c | 2 +-
 net/9p/client.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..e82f60c1c854 100644
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
index f0dcf252af7e..b7d947910037 100644
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

