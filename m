Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD139D3E6
	for <v9fs@lists.linux.dev>; Tue, 12 May 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592087; cv=none; b=MkKUg+AtqrVzPFBV+xiopvPxjA3PWaIezGzYRANBBAYndlfOj5bUvLO/KOfEAGu/D9vxxmiQnq/F4JiuWhw1HL4UDkk8WkEgg1VbFRZ5xATPOW1rId5xcO3Q29mi9T33b3N6YJqlwoV4Ctb2sgzg0RhpoVuCN7D3w7WXMZfWxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592087; c=relaxed/simple;
	bh=XtLD0z8lR5U/yFwYPfxpVKCJPyxqfsaJHVRhC+tzcLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgLEkAxatsnMXvE0B+vttU73P7cvHXvGcNLJNZuHghKooS42SAeC99vAodF1mfKQSxiy5Ce06t9Yexro062dGcrRJOUfrXxMsOHt0ybiNWuQI4DxqD8UEZ1Sgdxz/q3DqAmYA3jG7BXMxASVitdkua2f0DuB4fENR4fuP2TFt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=eLdC2aEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MG7Ft76h; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="eLdC2aEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MG7Ft76h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ED9BEC022B;
	Tue, 12 May 2026 09:21:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 09:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778592085; x=
	1778678485; bh=XQ+8jlmZuWjqnoSKHB6Hv1BBPHGdrEZiyCM29b3RL2A=; b=e
	LdC2aELAbcNk3CH7c0adExkmlCd6GIXxSpQ7UjBQvqxjym0q/cxGRLh9ZFCS/Pjz
	RF+txRuWmAD/zr+VLxy/0gwwZweoKLYft7Mj7Jib5FKCtWEUbwFgwIOsggefh50Q
	sDNE72NvVn9crbigfGHa/7r2fDGI+m1tUfU7N6UkkFmgyqy1+pOdeYmUFNDWhiW4
	JkSAZSrzx472+5wTRZ/2XF6vR8brqQbDvBp90/WBbGyViQuLdqrfP1MDn8AxqvUU
	QPqPNcGtMYo2ao40g0c7N7KXzk10kTtbrsDu8KcGYBR0H0obkwPbrD69k79DyOjc
	IISKawyyuvuTVMSU4dVyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778592085; x=1778678485; bh=X
	Q+8jlmZuWjqnoSKHB6Hv1BBPHGdrEZiyCM29b3RL2A=; b=MG7Ft76hKkcTjx/cN
	+uP8TW+lTZJKMRJSPDYno4xdOkEb/KWOnRcPsbPQupJqHO35eaxMv35HGxN29jal
	jjAuodSJTWbRH9G+jxojSdPEn4AypHV1QFRL99PpfjJ2lmwMgvdv5XyJyqfoiHRt
	mhE/WgQ2uhJ/Zwn1N/kVGGsWriGqDkYMpkITdIzGSyAiGsxZNy4ioeGkF936NcjN
	c02bE4E2L/lNcjo3W45UCs9xt8QKQLJk/MM+/n1SpHvA4ZAjk9l9TPBN2esm+pOm
	fL6v7DBiu16X1V9X93tY+UoHpID/LaP46q5UaHwO9Oc5d2Y2fxBigLrsFIdikuxc
	nAvHg==
X-ME-Sender: <xms:VSkDaoFNDK8Tg8iQdKBY9Q3GCwpb7QBEViVu6Wn-W36lLLNL0TMEDA>
    <xme:VSkDarUDtFsRGsDRq2SkVcu6zZjKBjohDfuYeU5nuxWB3RuPxUaliyNronRhsH_hQ
    9r7ZCtvzxvjfbBMM4AIPbKIBr7qsB0KkKMj05S7pVUCZRVmLY4vuw>
X-ME-Received: <xmr:VSkDaozAFFAPEh7z9VDoAxG3sq8YIVWeFGctcEEIM5VfMbt9F-hMJEPlf4RHOLVHwkSLN4Imf5eTF5hUDXKq2GDl77STrY3wWFSXqqOWcNrDtReDX5Q-pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheprfhivghrrhgv
    uceurghrrhgvuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvghrnh
    epkeevgeelvdehudeuiefggffhveehteekjedtueekjedvteeihfefgfejhfffffeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhr
    tghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegurghv
    ihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehvle
    hfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpihgvrhhrvgessg
    grrhhrvgdrshhh
X-ME-Proxy: <xmx:VSkDaoTBm4eo-esM7oRWuEFk2uWwdWBmtO5pbPWD8GSfpXV7mHAgYg>
    <xmx:VSkDashNoQ3kk4hfXt3Ifg_5mm1kn4qEIKJoloDSOvOmq-gRIHLdpQ>
    <xmx:VSkDanmuoxBgvp-DPD0s1tFBOlLwoyn1oloa4_3DwU9NK_5KKioujw>
    <xmx:VSkDanvUG3GX13nNxgsbtnuOpQcYV3zHSuDfZ1EZTfbdekji2jxZeg>
    <xmx:VSkDavaAlAdFz7Mn8KtDvsiUSHXDK__s0TOb-SiJz1cBUVq319TnPWMQ>
Feedback-ID: i97614980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 09:21:24 -0400 (EDT)
From: Pierre Barre <pierre@barre.sh>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Laight <david.laight.linux@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pierre Barre <pierre@barre.sh>
Subject: [PATCH 2/2] 9p: invalidate readdir buffer on seek
Date: Tue, 12 May 2026 13:20:32 +0000
Message-ID: <20260512132032.369281-2-pierre@barre.sh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512132032.369281-1-pierre@barre.sh>
References: <20260512132032.369281-1-pierre@barre.sh>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-fid readdir buffer (fid->rdir) is populated lazily and only
refilled when fully drained (rdir->head == rdir->tail). userspace
lseek() on a directory fd updates file->f_pos via generic_file_llseek()
but does not touch the cached buffer, so the next getdents() iterates
the stale cache and emits entries from the previous position instead
of the one the caller asked for.

Track the file position the cached data corresponds to in
struct p9_rdir, and drop the cache on entry to iterate_shared when it
no longer matches ctx->pos. The 9p protocol's Tread/Treaddir already
take an arbitrary offset on every request, so a refill at the new
position is always legal; no .llseek override or seek restriction is
needed.

Reported-by: Pierre Barre <pierre@barre.sh>
Link: https://lore.kernel.org/v9fs/496d10b9-40fe-4f81-8014-37497c37ff63@app.fastmail.com/
Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/vfs_dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e82f60c1c854..323f85352f6a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -27,6 +27,7 @@
  * struct p9_rdir - readdir accounting
  * @head: start offset of current dirread buffer
  * @tail: end offset of current dirread buffer
+ * @offset: file position the data at @head corresponds to
  * @buf: dirread buffer
  *
  * private structure for keeping track of readdir
@@ -36,6 +37,7 @@
 struct p9_rdir {
 	int head;
 	int tail;
+	loff_t offset;
 	uint8_t buf[];
 };
 
@@ -102,6 +104,9 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	kvec.iov_base = rdir->buf;
 	kvec.iov_len = buflen;
 
+	if (rdir->head < rdir->tail && rdir->offset != ctx->pos)
+		rdir->head = rdir->tail = 0;
+
 	while (1) {
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
@@ -117,6 +122,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 
 			rdir->head = 0;
 			rdir->tail = n;
+			rdir->offset = ctx->pos;
 		}
 		while (rdir->head < rdir->tail) {
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
@@ -134,6 +140,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 
 			rdir->head += err;
 			ctx->pos += err;
+			rdir->offset = ctx->pos;
 		}
 	}
 }
@@ -161,6 +168,9 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 	if (!rdir)
 		return -ENOMEM;
 
+	if (rdir->head < rdir->tail && rdir->offset != ctx->pos)
+		rdir->head = rdir->tail = 0;
+
 	while (1) {
 		if (rdir->tail == rdir->head) {
 			err = p9_client_readdir(fid, rdir->buf, buflen,
@@ -170,6 +180,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			rdir->head = 0;
 			rdir->tail = err;
+			rdir->offset = ctx->pos;
 		}
 
 		while (rdir->head < rdir->tail) {
@@ -190,6 +201,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			ctx->pos = curdirent.d_off;
 			rdir->head += err;
+			rdir->offset = ctx->pos;
 		}
 	}
 }
-- 
2.51.0

