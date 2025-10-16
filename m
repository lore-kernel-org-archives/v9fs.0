Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A823ABA0
	for <v9fs@lists.linux.dev>; Thu, 16 Oct 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598149; cv=none; b=sKPqndjv7T0kfhNfnQFMLCRi8y1yuYSDQZqo8NO1AsuoF4HyL2bTbH3tdPSSUI6Bah76PjFrHWtoAG+FLBQ9kVD1OeBeo3wzO1rOx/Twc9AXs2RJSVcQC4HNeLAUG/TMezLXQFL5hDntq+omzOJAq4ySfxQ0f6RBzGtTC3LvG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598149; c=relaxed/simple;
	bh=1PrPVQ7tfxwitGhjxegp3eCnWvSuD6p8uzDXLi+MxIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YxrOZnQXMh78xZO6MdJRV6V2Dq3k47V3ZwSdxgqZVKDVXiaEcdF+pzMpk3hmU6fdgxdspSfXZ4UFDVUla4P0iX901aZ+8s5p0EOKn/rK3FvFcXnY69htuEU80CRk3LWurZVixamoMEQpKj0RXFdh4CHVY38a4KWmIPzRXtVsS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=QXv85bKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGe70LZd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="QXv85bKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGe70LZd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9CD27A0070;
	Thu, 16 Oct 2025 03:02:25 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 03:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760598145;
	 x=1760684545; bh=gpIlGqw5HznXR71ZCuNL4OGNUmqi1KmyrMhUcOsX/wY=; b=
	QXv85bKi6cpaaWml7KcR2p2XKIJiBaFz0zvBLNA4E2Qe4REJGymw9nifJv32Jmpd
	aww6RbSb6l//EU8FcySe17kY5/MKUPHwF60matjudCtONorFW7S+Aw+ybIcP+CMQ
	B1ekvB7O7SIAm+El3jQCQfgZl5Omdi/rg0XBJC/3/ugrnXZmdnAi1O7YpOd1M7Qb
	zozsSSBG651EBctJJoiwY7omSrxPjV1JES0kj+fozjVad0yob97pAw1kK41zhQjl
	i7QeGXRqOso6mKxedQM1VFs5iEEWG+4swzKYq3VSybaMTi1JnH7AlRoA5iYoLqOa
	jROuLHt8JnNQX9OsSUFfRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760598145; x=
	1760684545; bh=gpIlGqw5HznXR71ZCuNL4OGNUmqi1KmyrMhUcOsX/wY=; b=X
	Ge70LZdApP2NbvT09LPxSIJKmvkKiJPW1Uw4M0bwYVDe/GunRIHyri2UszhCiDkh
	m5xlfb1ySg/hUoWSoPx/jmARbsXN0iuAYkl9WYG4vefSG1z8PaMDWG1P/wAzxzPE
	zeNr0kjK/DvTPWW6EHqXYqBB4+hzdnwdU+3YZ9ikxn9BMZBVYzz4u+JEy+uzTUgO
	rk8QD+/Dh7X+hLxROw0sAVne+9W7R8N+uLv5rXzHZ4R0X95drxLyooqG/cQS5kEq
	na3/1aIC4Vg60a7Efb9RywuuEHAxHEeNCkX83I+zi/PN5sTiKf7XjzJU96oASmhc
	tGoGtBQUCNJga07LMfZbg==
X-ME-Sender: <xms:gJjwaAvIZV_kA7w2F6lbgAqNWN2v_trzczsy8-zRWrYHPyZmZHiEUQ>
    <xme:gJjwaITiwt9PlGAyrz-Dli2ssBcyDJnU6oGN9G0VzDzfjXgttjqxsH29wSGkCrh8W
    GLpdeodjrckXr5cBrkFb5Nzp3i-nO86P2JJSxBdkQ-3F4stNyJ9ZuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegs
    rghrrhgvrdhshheqnecuggftrfgrthhtvghrnhepleeiffetleektddvffejveeflefghe
    ehfffhiedvleefteekvdfgffffuedthfdvnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpih
    gvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprh
    gtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehluhgthhhose
    hiohhnkhhovhdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gJjwaKXkVkAQEsTv4XQImryLRmNrJMxRZ8audDN0RaCHwuS4qpCVYg>
    <xmx:gJjwaAr41KZtEpzsfrpb0TOQ_XlXDAgIFXC3ZmsAv-lGnTsoMsVWOQ>
    <xmx:gJjwaOTzmCiTmxMTtCpjHhp7ArkWVDQHhGNfkSOBYJk3w_bzEuaXkw>
    <xmx:gJjwaC2r19AIe_lu92OAydFC_JZ9aD1-48N8GSdFg4LgGYvKBPFCHw>
    <xmx:gZjwaEyY7xCwydUvPuZNG9AoyQUAnjcD2EnDKvKDRRmXPpJzp44SdY7E>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 812F1B60054; Thu, 16 Oct 2025 03:02:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AmYx6M_OjcyJ
Date: Thu, 16 Oct 2025 09:01:56 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 asmadeus <asmadeus@codewreck.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Message-Id: <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
In-Reply-To: <8602724.2ttRNpPraX@silver>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <f08d5585-0a26-4c98-be1a-c0fd89ccd916@app.fastmail.com>
 <aJPMwqqchOaZFSqn@codewreck.org> <8602724.2ttRNpPraX@silver>
Subject: [PATCH v2] 9p: Use kvmalloc for message buffers on supported  transports
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While developing a 9P server (https://github.com/Barre/ZeroFS) and
testing it under high-load, I was running into allocation failures.
The failures occur even with plenty of free memory available because
kmalloc requires contiguous physical memory.

This results in errors like:
ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)

This patch introduces a transport capability flag (supports_vmalloc)
that indicates whether a transport can work with vmalloc'd buffers
(non-physically contiguous memory). Transports requiring DMA should
leave this flag as false.

The fd-based transports (tcp, unix, fd) set this flag to true, and
p9_fcall_init will use kvmalloc instead of kmalloc for these
transports. This allows the allocator to fall back to vmalloc when
contiguous physical memory is not available.

Additionally, if kmem_cache_alloc fails, the code falls back to
kvmalloc for transports that support it.

Signed-off-by: Pierre Barre <pierre@barre.sh>
---

 include/net/9p/transport.h |  4 ++++
 net/9p/client.c            | 11 +++++++++--
 net/9p/trans_fd.c          |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 766ec07c9599..f0981515148d 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -24,6 +24,9 @@
  *                   we're less flexible when choosing the response message
  *                   size in this case
  * @def: set if this transport should be considered the default
+ * @supports_vmalloc: set if this transport can work with vmalloc'd buffers
+ *                    (non-physically contiguous memory). Transports requiring
+ *                    DMA should leave this as false.
  * @create: member function to create a new connection on this transport
  * @close: member function to discard a connection on this transport
  * @request: member function to issue a request to the transport
@@ -44,6 +47,7 @@ struct p9_trans_module {
 	int maxsize;		/* max message size of transport */
 	bool pooled_rbuffers;
 	int def;		/* this transport should be default */
+	bool supports_vmalloc;	/* can work with vmalloc'd buffers */
 	struct module *owner;
 	int (*create)(struct p9_client *client,
 		      const char *devname, char *args);
diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..2a4884c880c1 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -229,8 +229,15 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (likely(c->fcall_cache) && alloc_msize == c->msize) {
 		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
 		fc->cache = c->fcall_cache;
+		if (!fc->sdata && c->trans_mod->supports_vmalloc) {
+			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
+			fc->cache = NULL;
+		}
 	} else {
-		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
+		if (c->trans_mod->supports_vmalloc)
+			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
+		else
+			fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
 		fc->cache = NULL;
 	}
 	if (!fc->sdata)
@@ -252,7 +259,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
 	if (fc->cache)
 		kmem_cache_free(fc->cache, fc->sdata);
 	else
-		kfree(fc->sdata);
+		kvfree(fc->sdata);
 }
 EXPORT_SYMBOL(p9_fcall_fini);
 
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a516745f732f..e7334033eba5 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1101,6 +1101,7 @@ static struct p9_trans_module p9_tcp_trans = {
 	.maxsize = MAX_SOCK_BUF,
 	.pooled_rbuffers = false,
 	.def = 0,
+	.supports_vmalloc = true,
 	.create = p9_fd_create_tcp,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
@@ -1115,6 +1116,7 @@ static struct p9_trans_module p9_unix_trans = {
 	.name = "unix",
 	.maxsize = MAX_SOCK_BUF,
 	.def = 0,
+	.supports_vmalloc = true,
 	.create = p9_fd_create_unix,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
@@ -1129,6 +1131,7 @@ static struct p9_trans_module p9_fd_trans = {
 	.name = "fd",
 	.maxsize = MAX_SOCK_BUF,
 	.def = 0,
+	.supports_vmalloc = true,
 	.create = p9_fd_create,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
-- 
2.39.5 (Apple Git-154)



On Fri, Aug 8, 2025, at 13:12, Christian Schoenebeck wrote:
> On Wednesday, August 6, 2025 11:44:34 PM CEST Dominique Martinet wrote:
>> 
>> Pierre Barre wrote on Wed, Aug 06, 2025 at 05:50:42PM +0200:
>> > If I submit a patch based on what has been discussed above, is it
>> > likely to be accepted? Unfortunately, in my current setup, I am
>> > encountering this issue quite frequently, and users of my servers are
>> > having a hard time making sense of the error.
>> 
>> Yes, sorry it wasn't clear.
>> 
>> I still have no idea what's the "best" allocation method that we'll be
>> able to use as either a vmalloc buffer or split into a scatterlist, but
>> there's little point in worrying too much about it, so please go ahead.
>> 
>> If it's restricted to trans_fd and there's a chance we can make use of
>> it with (at least) virtio later I think everyone will be happy :)
>
> Yes, sounds like a viable plan.
>
> Pierre, one more thing to note: kmem_cache_alloc() might still fail though. So
> maybe it would make sense to add a separate patch that would check the result
> of kmem_cache_alloc() and if it fails, falling back to your kvmalloc() call
> (if enabled by the discussed transport mechanism of course).
>
> /Christian
