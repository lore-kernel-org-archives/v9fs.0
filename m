Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF123741
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888110; cv=none; b=oxlMG7aOp8ZAGBw/ML/THKEHXHWGaqBISJT+5KihSxH85M/SvY+sEr357hVZ9QdduV8hVyZEIjERUq/a+vMCckzGzC84W7lqxzLGFXCzDVPp4QNSll7V9erREcQt9B8m1zdk3F2GZ8dCPwF98JdjDr1RrzJ6u1rSDEvsSPA0qdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888110; c=relaxed/simple;
	bh=0FzA23Om8AUORokOAVizgv82XYvBTGOjzN7zkNH2KI4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=ITENpzt5T7GcRdO4xTNnmiZlRidqmsXNE6RWTJJ5vYbLrwSLx7nvW6GQpkzpMkcv1KuBzJroTk1igMG/c3535dc4JKiO9PZdqPmUAl+AtDyiPOg7Db34OsRJgIq9T06knxOFBlPaKWb/xOa83S1KL+AQ3t1vIcGylhY5kg0q8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=cHCAV8SW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YT0DZL7t; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="cHCAV8SW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YT0DZL7t"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1E137A0095;
	Wed, 30 Jul 2025 11:08:27 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 11:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1753888107; x=1753974507; bh=RD
	OhIMdeMCATJQG9xZyLDQRpDZCu/otqHG/vWl7VfA0=; b=cHCAV8SWVTT7fLPmJM
	3bFQUPyk/seS9MyDLdVV/2JY//oCAzaVTdH93iRvvihbw5iwAzN64NsSxWffcoIE
	JE9U6AQiOOUnRdMSszcps9oSHQrdUIdw39dvj/obVEMfAldvH3WhQRPeT6/6Ggti
	AUOVN2icgKDsATlscgVsXU8rwg+iOvwtYOKJrVumtwlEzZQywBf75WfhQYdkF4zD
	lXO9hvBnPGFB1mmLWw77UM+oUQqq0WB0w0/6NbDD/Bt3khr9Ep5GSrHnI2pi2Pxk
	hvx6bSVPHn0aeys7Qwjm/gz4iec44w4i5vvEdcxdZ47ggGmupu5GIsdPZ/RWxOOZ
	bHlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753888107; x=1753974507; bh=RDOhIMdeMCATJQG9xZyLDQRpDZCu
	/otqHG/vWl7VfA0=; b=YT0DZL7tZtPOIXj1WJTPt5vpNglSJAnnF4kPiTrH9JtE
	o0VAY/ZYbiz2bq5bUejChRJHbaG9A5rTsgQ+QLHUQ9M3tRB6niajvLTo7UvYb3uM
	NZ1UCzvT55NuZk5Xsc3vkOyuFE86QjoYvhYeETEoMBJJjytPd83F1avyP0IDJXu0
	FoOcJYvPK5vkeeGHLryivtivGi1xDr/d8o2K30q0N1MyQ0eF7Z3qZZ778mxGV+vr
	dg0H/uVg2cGqcwAUAkArSX3SZagh1oIWFliMEkCkF2kONv6HKV2dhG3FWS5twRlT
	IapfunUwx2cr7EFkse7oRWrdxKTsa//3ws1jkMgfQw==
X-ME-Sender: <xms:ajWKaDp_ymmD3r336VIsRSba0rwl6pNxtE2a0T4H6u40ccK8axgsBA>
    <xme:ajWKaNpj9NZV3kbLOaQo_VF6eGk7_pNiXGl325j_k5EzBQgw-bjObH1BqPKO9rqSE
    Cmp1jkECSc7jw8MTOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkffutgfgsehtjeertdertd
    dtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggrrhhr
    vgdrshhhqeenucggtffrrghtthgvrhhnpeetfeevtdekjeetkeeujedtveefjeffhedvfe
    fgtdeiteefvdehteefkefgheefieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhivghrrh
    gvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpth
    htoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehl
    uhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ajWKaEQ02sgHGjL6Pt6mSZSbTI4gr0HpBrM_i2WvTN_0jQFNUHI_MQ>
    <xmx:ajWKaJLPlcQQKToG20AH7uaNhnYwtqu4N9aS3tlNtzmWW3sbJCzJ_w>
    <xmx:ajWKaHaRrEHZInZVnC-1Jk61pwFoC8qYLSsTqyJvDDhxm0tvqMtC2g>
    <xmx:ajWKaD_PNVmOGyfsZx5zxQhoGqxbKp2cX8FmHQ05NHZVuavD2pzqNw>
    <xmx:azWKaBrEeR5qBVTeQfeB3lAnjlW2_1zSQdHM6QWFfuFZn4RSgF8fQqQ9>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5036DB6006C; Wed, 30 Jul 2025 11:08:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tea62be34c8f8a220
Date: Wed, 30 Jul 2025 17:08:05 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, linux-kernel@vger.kernel.org
Message-Id: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
Subject: [PATCH] 9p: Use kvmalloc for message buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While developing a 9P server (https://github.com/Barre/ZeroFS) and testing it under high-load, I was running into allocation failures. The failures occur even with plenty of free memory available because kmalloc requires contiguous physical memory.

This results in errors like:
ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)

Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..f82b5674057c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -230,7 +230,7 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
 		fc->cache = c->fcall_cache;
 	} else {
-		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
+		fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
 		fc->cache = NULL;
 	}
 	if (!fc->sdata)
@@ -252,7 +252,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
 	if (fc->cache)
 		kmem_cache_free(fc->cache, fc->sdata);
 	else
-		kfree(fc->sdata);
+		kvfree(fc->sdata);
 }
 EXPORT_SYMBOL(p9_fcall_fini);
 
-- 
2.39.5 (Apple Git-154)
