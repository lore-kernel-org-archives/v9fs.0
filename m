Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D034A21
	for <v9fs@lists.linux.dev>; Thu, 16 Oct 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623256; cv=none; b=CfsaJirArdwnz8B7Dt1q77A9jcBWJXy6Phlxgt22Yg1nospwApvUY9b9p46X44LuLVAg8EuzSY7YWgyWZcacw2k4DBsMG3TOm4qnVrJqg3ptvNteE3YAIno2bG1xz3bkQjjpPViAUK5FeHgfbY+T2C/i9Z5XBxyWXdrhCiDOpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623256; c=relaxed/simple;
	bh=x3bhhFDeaKgcMsGIGXdd9mKo8LUoA+/5P1oZzvTMFs4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LXNpu1IMuKcwm+io9O9hg0y/3qKE+5SHJp0Tahu1jer7OdZZBsF2/byz4CfSTj+2IZD7qUHteNPsYC6mDMB3/LBVZhrslzyyCGhY1cS71gaST15mw0NAq5JLSGC9Ma0kQKOYwwZpRyinbq93Fh2m3bPdkKszWP8lCi47e3vPOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=GEai1RX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WlcM57Nj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="GEai1RX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlcM57Nj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D7AEEC0201;
	Thu, 16 Oct 2025 10:00:52 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760623252;
	 x=1760709652; bh=mOAWN36gnI+B2Uubin9XBzhtfpDIutS6dEBMKDovWhk=; b=
	GEai1RX6YQEdFS5RWY8RZFg91rtktvawhwD1M5t/oZWqXTFKlKAJvJZd2ICwVeNY
	YnP3r52SHCHCnru9JNAcq/Ltns+WWb2zO9mFWDY7ZX66uBLQiZAaxuAhrH/ha9Ti
	rpKiPCNJZkr7clvucAGpOnzAwTlVtIbeXTsk6PSUl4i/GMA19tKY+wc/EpekN8XX
	/MWAV6FQkY16uxBa5sxhO0Xt03Uz8IhVuBuzz20IJASQZD9SXH/SO7VA4iIUNqvp
	y5pTX9uTwp/UaSKDWEts8KmGkMUnHVcaUv4Kdfh8Vu1WoMTJeqpK0dnEPYzKa67i
	yMmSH1S56zkqR5QVBuhLnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760623252; x=
	1760709652; bh=mOAWN36gnI+B2Uubin9XBzhtfpDIutS6dEBMKDovWhk=; b=W
	lcM57NjVizXSBH342Zt6iaQJNdMIsZqBIANh+kmm6PMiETCXBBDOzO91xsYXn8a7
	lqs6Hv1/hQw11+YMJ8JWgHiOKrSmpDipPe501UjIVktljF/vzgGW6ZGqfSDAHVHO
	6NxUBFm/Sw/m6ReWygMURdO19D0j899rTYi9g/iJi6CNUVEJ/0e5qV7DbN0A0r8y
	L6ymy9V5/fQOHgwR3OvdNZKVlHJ/uQWoDVtwQR3ATUQAUu780uOBeOGGRD9XVerg
	EUBEMEiwrHXiyIIFgaSqSPJVKqcnijtv/zlCnsRPif9ncOJHGXhZl4tWiA0OWczy
	kf2sn+sgiHuYQ9aje4efw==
X-ME-Sender: <xms:k_rwaFaV0S2t7wrP77vwsXJxwaiNl7E_b5vDFDwHu-nw-8TcKysSOg>
    <xme:k_rwaHOtPundgXRnDzTrL2krl0zejnoRmmQeQvcxxJzXOFNVELlxV7LacN8aJHVMj
    pUpbPsBM5qVkaCjphuQjwtD629t0oTja3ExUXIa5Nrmc7jDTJHJe44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeigeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:k_rwaDB8j4plZ3r0fPJK3EHNwRt4Oy1nnT3NMIiJ20fe7rr5uG2g6w>
    <xmx:k_rwaDlgOFfLcnj8isnYWeAzIuTEHecgIqOSRnldbqLArnDsc15Rrg>
    <xmx:k_rwaOeJ2l-kZaG5KN3hLvS_oAII7Av4hOYoGPes5cbn9q5rCetlbA>
    <xmx:k_rwaHQ8Tynf4y85FfSW03DIfm66QwrG2NOPc5TUOFYhwPOVRFUSCQ>
    <xmx:lPrwaA-w5NMQ1A_YPA7obfuqk9xM0pahKqXhh0L7p3Obb6kh4Qv_QPHC>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 939C3B60074; Thu, 16 Oct 2025 10:00:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AmYx6M_OjcyJ
Date: Thu, 16 Oct 2025 15:58:36 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 asmadeus <asmadeus@codewreck.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, v9fs@lists.linux.dev,
 ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org
Message-Id: <d2017c29-11fb-44a5-bd0f-4204329bbefb@app.fastmail.com>
In-Reply-To: <5019358.GXAFRqVoOG@silver>
References: <1fb9c439-73f3-4a00-8a8b-45eeb85883eb@app.fastmail.com>
 <8602724.2ttRNpPraX@silver>
 <7005d8d9-d42d-409f-b8e3-cd7207059eee@app.fastmail.com>
 <5019358.GXAFRqVoOG@silver>
Subject: Re: [PATCH v3] 9p: Use kvmalloc for message buffers on supported  transports
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
Changes in v3:
- Added explicit .supports_vmalloc = false to DMA-based transports
  (suggested by Christian Schoenebeck)

 include/net/9p/transport.h |  4 ++++
 net/9p/client.c            | 11 +++++++++--
 net/9p/trans_fd.c          |  3 +++
 net/9p/trans_rdma.c        |  1 +
 net/9p/trans_usbg.c        |  1 +
 net/9p/trans_virtio.c      |  1 +
 net/9p/trans_xen.c         |  1 +
 7 files changed, 20 insertions(+), 2 deletions(-)

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
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index b84748baf9cb..6c5ad232c194 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -749,6 +749,7 @@ static struct p9_trans_module p9_rdma_trans = {
 	.maxsize = P9_RDMA_MAXSIZE,
 	.pooled_rbuffers = true,
 	.def = 0,
+	.supports_vmalloc = false,
 	.owner = THIS_MODULE,
 	.create = rdma_create_trans,
 	.close = rdma_close,
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 468f7e8f0277..2542ef099233 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -514,6 +514,7 @@ static struct p9_trans_module p9_usbg_trans = {
 	.close = p9_usbg_close,
 	.request = p9_usbg_request,
 	.cancel = p9_usbg_cancel,
+	.supports_vmalloc = false,
 	.owner = THIS_MODULE,
 };
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad5..12806207f4f0 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -803,6 +803,7 @@ static struct p9_trans_module p9_virtio_trans = {
 	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 3),
 	.pooled_rbuffers = false,
 	.def = 1,
+	.supports_vmalloc = false,
 	.owner = THIS_MODULE,
 };
 
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index b9ff69c7522a..4b1cec0ab829 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -258,6 +258,7 @@ static struct p9_trans_module p9_xen_trans = {
 	.maxsize = 1 << (XEN_9PFS_RING_ORDER + XEN_PAGE_SHIFT - 2),
 	.pooled_rbuffers = false,
 	.def = 1,
+	.supports_vmalloc = false,
 	.create = p9_xen_create,
 	.close = p9_xen_close,
 	.request = p9_xen_request,
-- 
2.39.5 (Apple Git-154)


On Thu, Oct 16, 2025, at 15:06, Christian Schoenebeck wrote:
> On Thursday, October 16, 2025 9:01:56 AM CEST Pierre Barre wrote:
>> While developing a 9P server (https://github.com/Barre/ZeroFS) and
>> testing it under high-load, I was running into allocation failures.
>> The failures occur even with plenty of free memory available because
>> kmalloc requires contiguous physical memory.
>> 
>> This results in errors like:
>> ls: page allocation failure: order:7, mode:0x40c40(GFP_NOFS|__GFP_COMP)
>> 
>> This patch introduces a transport capability flag (supports_vmalloc)
>> that indicates whether a transport can work with vmalloc'd buffers
>> (non-physically contiguous memory). Transports requiring DMA should
>> leave this flag as false.
>> 
>> The fd-based transports (tcp, unix, fd) set this flag to true, and
>> p9_fcall_init will use kvmalloc instead of kmalloc for these
>> transports. This allows the allocator to fall back to vmalloc when
>> contiguous physical memory is not available.
>> 
>> Additionally, if kmem_cache_alloc fails, the code falls back to
>> kvmalloc for transports that support it.
>> 
>> Signed-off-by: Pierre Barre <pierre@barre.sh>
>> ---
>> 
>>  include/net/9p/transport.h |  4 ++++
>>  net/9p/client.c            | 11 +++++++++--
>>  net/9p/trans_fd.c          |  3 +++
>>  3 files changed, 16 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
>> index 766ec07c9599..f0981515148d 100644
>> --- a/include/net/9p/transport.h
>> +++ b/include/net/9p/transport.h
>> @@ -24,6 +24,9 @@
>>   *                   we're less flexible when choosing the response message
>> *                   size in this case
>>   * @def: set if this transport should be considered the default
>> + * @supports_vmalloc: set if this transport can work with vmalloc'd buffers
>> + *                    (non-physically contiguous memory). Transports
>> requiring + *                    DMA should leave this as false.
>>   * @create: member function to create a new connection on this transport
>>   * @close: member function to discard a connection on this transport
>>   * @request: member function to issue a request to the transport
>> @@ -44,6 +47,7 @@ struct p9_trans_module {
>>  	int maxsize;		/* max message size of transport */
>>  	bool pooled_rbuffers;
>>  	int def;		/* this transport should be default */
>> +	bool supports_vmalloc;	/* can work with vmalloc'd buffers */
>>  	struct module *owner;
>>  	int (*create)(struct p9_client *client,
>>  		      const char *devname, char *args);
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 5c1ca57ccd28..2a4884c880c1 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -229,8 +229,15 @@ static int p9_fcall_init(struct p9_client *c, struct
>> p9_fcall *fc, if (likely(c->fcall_cache) && alloc_msize == c->msize) {
>>  		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
>>  		fc->cache = c->fcall_cache;
>> +		if (!fc->sdata && c->trans_mod->supports_vmalloc) {
>> +			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
>> +			fc->cache = NULL;
>> +		}
>>  	} else {
>> -		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>> +		if (c->trans_mod->supports_vmalloc)
>> +			fc->sdata = kvmalloc(alloc_msize, GFP_NOFS);
>> +		else
>> +			fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>>  		fc->cache = NULL;
>>  	}
>>  	if (!fc->sdata)
>> @@ -252,7 +259,7 @@ void p9_fcall_fini(struct p9_fcall *fc)
>>  	if (fc->cache)
>>  		kmem_cache_free(fc->cache, fc->sdata);
>>  	else
>> -		kfree(fc->sdata);
>> +		kvfree(fc->sdata);
>>  }
>>  EXPORT_SYMBOL(p9_fcall_fini);
>> 
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index a516745f732f..e7334033eba5 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -1101,6 +1101,7 @@ static struct p9_trans_module p9_tcp_trans = {
>>  	.maxsize = MAX_SOCK_BUF,
>>  	.pooled_rbuffers = false,
>>  	.def = 0,
>> +	.supports_vmalloc = true,
>>  	.create = p9_fd_create_tcp,
>>  	.close = p9_fd_close,n
>>  	.request = p9_fd_request,
>> @@ -1115,6 +1116,7 @@ static struct p9_trans_module p9_unix_trans = {
>>  	.name = "unix",
>>  	.maxsize = MAX_SOCK_BUF,
>>  	.def = 0,
>> +	.supports_vmalloc = true,
>>  	.create = p9_fd_create_unix,
>>  	.close = p9_fd_close,
>>  	.request = p9_fd_request,
>> @@ -1129,6 +1131,7 @@ static struct p9_trans_module p9_fd_trans = {
>>  	.name = "fd",
>>  	.maxsize = MAX_SOCK_BUF,
>>  	.def = 0,
>> +	.supports_vmalloc = true,
>>  	.create = p9_fd_create,
>>  	.close = p9_fd_close,
>>  	.request = p9_fd_request,
>
> Just for clarity I would add .supports_vmalloc = false to the other 
> transports. Except of that:
>
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
>
> Thanks!
>
> /Christian
