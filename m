Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0035C1A6
	for <v9fs@lists.linux.dev>; Wed, 15 Apr 2026 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231966; cv=none; b=nl+TvAcgcXu/gTJu7CuViQCpXIRfCYjg0vbheD8DXxWLnNqkJWOe1LEr+IFfO5zKxphGQzm4wgGLTtz9onJRgRJTKe8m/FbBywHYRc2+cFVM/L8hbmVreLqBongn+JIiCvU/1qsuky8aM7H5uiuadOcdLV1cw2yU/SpS/uCFdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231966; c=relaxed/simple;
	bh=bQ4hzo4aLD1PatKJPHYPPAwI02hTQ6R+6n+7IBQfeiI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=EuqaSrJYM1GT0g+I52/7KeUZ7xzhzTMfn95oozXApR23k/dDgyl7puv3NXxamxeInLoYNUwrJNm7Z//HTEdepbvTcswpg/Y6wzoipUFXsNZsSA31O9sB3pUFl+Ec1c1mP2HdDZKQirEiXcejJfNbT3EyQHl2+2TheFbffYqsNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=md70v55n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=II248KtL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="md70v55n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="II248KtL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22C037A01B2;
	Wed, 15 Apr 2026 01:46:03 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 01:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776231962; x=1776318362; bh=RK
	9ZLoaLKywcyvi9A6tiR/lDfk5nhl6XccwMuMNUmYM=; b=md70v55n8XLf+g+L6B
	P3g10QLx9QKkKoBQ4G58NQQVOx3wvlKmWq1oMnaKr0F7YfJWAwGy2n//EfBjPueg
	6VoXjSlHTE0FDYAQlF5hcqqBuBEY+RNMCdgH3iTQkezDUd6LPpXXMNZd1HTCJaVP
	6a8xQx3fj8ChH4X4DnmRh66kiqKo1Vtcw8aE51PJ/CDw3gUFI72MUhl1hP1cq1dS
	pVhOtLp9p4TnfaLqtCQfWGqWNuPHLFFHLWAy+wihAYOHoNM5YFdNzZzeMVGNVzG+
	0S3J12xx4oYmps0O5IFBEGOcQAYxBcuzMS1VIi4X4TQa/PjyfeT5ZfvakijGVkvM
	zHGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776231962; x=1776318362; bh=RK9ZLoaLKywcyvi9A6tiR/lDfk5n
	hl6XccwMuMNUmYM=; b=II248KtLa50FFOjHlve2dk4lO/zQTCTBL2fcgL26Oo9O
	hbaH/8h0JsyNpg2AuWVWShGKSufx7OXRNArfXjTGTOn2Yz81NaXnvfpGmyWon3h4
	5+QlNX3aSpC9IT46HOpuJIbOuUb6YIN7Z/anRziQp5wc7hKSS5d3vgkj31TaHwZd
	zl0dYZ96vY2JLFiN3r6gdvfF2iqJxcrp7F+tuoaFdv44a0YAuREjOMRSkBUtz3TW
	dZFD6KUvz3o1u3DoO5i/3esiPlmwcp0PaKP3Eh+M3efS7v7EJa0EGs6inXpLNkd0
	CAOjZdVYhlmZCWKwiqCn73+eahju+DDbgmVtkWsjRw==
X-ME-Sender: <xms:Gibfac6oaF2wb0JWCaOg3q_RYG5gOI9WSUvzq6CRGmk_saPRqkUzGQ>
    <xme:GibfaYvHr-qU_6py3VJXzH3ohpH-frP668FpTPnkf_MKQb66PF1zGh9RMtOISMAhr
    us3oJAN30_dz4k7jl511LnHhgXrrWXg35HBxYfgYXb0rM9HqPwCygM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdfrihgvrhhrvgcu
    uegrrhhrvgdfuceophhivghrrhgvsegsrghrrhgvrdhshheqnecuggftrfgrthhtvghrnh
    epjeffuefggfeuieehtdegfedujeektedugffhgedukeegfeeggfeludfhteefhfeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhivghrrh
    gvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpth
    htoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehl
    uhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GibfaZ6gfmjrmdO4m_zVBzrNB96CTBAW5PErv73_ugrgM7p6MjySYA>
    <xmx:GibfaR12EOcD4fqdVmdZ5wSFBRiN91ESwkyMmBSx5fklqkz9ypP4ww>
    <xmx:GibfaffO5ELcbuw57fJP-dzwWOJn20PuFvl2fw1hlS0ZIPzNQnx_vQ>
    <xmx:GibfaXcN4AldQfV99fsSREMbEGHg2JKJm_8PUFY1-LTfJyrtqZgzEQ>
    <xmx:GibfacV1qukU76hrhAv36DnjINJ1NcGkrKPwqP4kj5ZHpwayEQHI2hZy>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DC29B6006E; Wed, 15 Apr 2026 01:46:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 07:45:08 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <06399e04-b019-4c3d-b941-5771b6ac33c2@app.fastmail.com>
Subject: [PATCH] 9p: use kvzalloc for readdir buffer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

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
-               fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
+               fid->rdir = kvzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
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
-       kfree(fid->rdir);
+       kvfree(fid->rdir);
        kfree(fid);
 }

--
2.51.0
