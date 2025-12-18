Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C2334C05
	for <v9fs@lists.linux.dev>; Thu, 18 Dec 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062589; cv=none; b=DfjpjVfPYfG3q0RK8d5W/83wjw+luBhtkiVki57cqstZYZ5NKjebgsxwuHvSlXS11e1SuoUyCZNyfh0N+Kc04d+1JFDeRSynOZGFd4De5j7SR2fY23n4SO8DedEqKX7iiqZBBZv5wfIaM10gWFK1y80UvqYBXTevoIgMd81LOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062589; c=relaxed/simple;
	bh=M4KjhCGHfX1xoC0h/cpOraTtyggKZTxeM/ULMPsN7Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcJypxTyG0SHcJgdh52PfZ33r0JMdfFNsTU5EUpNkohFZ7kd2g9MF6kdK1yB7yhhBd6NFsBcEjJSlfyCgf7oZtmZZ2LX2yXmSNla7ziNMDOb7tqw36FWu3PYnr7unWXpa6W4AXVL1+iT5E+8lP9jdpgQ2b5Jh5V4YpdB5Cel0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sQHNKcRx; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sQHNKcRx"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 710F514C2D6;
	Thu, 18 Dec 2025 13:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766062583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb9+d6HPYzh20OfW2SHSDbb9QmxdOTWI3i8ZXindXa8=;
	b=sQHNKcRxVEpcra+kPBvtuH3OVkGNfYI7hUUXaMLLiH92ICCrUgZ5tlFM2dWwVWTip4F6Ro
	+hYFDynl+kaZGaVf5XGS5CdsieaoSdKjh3qkStBfD/D+yjQtprXrgWh9zW5jsZ/hwHG/O8
	GUqitX7Uj9UU5Q3/WUO55xUWhrFc1RL9+3l4JiDgiXV+/AYqb9iqGtgYxLMqK+VCZcn5Z6
	EF0oCjSH3m1dJCGJNsubu5R+d9SWD3Vjs2isB1M56/NKh/fePSPT9BSeJoYZ2GB5dHrvG1
	m5QiLML6hxb745g3ul+HzVq7HN1dtPVALXUPlVJf9xH58yx8OwPU10jTgc1Upw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 37412a07;
	Thu, 18 Dec 2025 12:56:19 +0000 (UTC)
Date: Thu, 18 Dec 2025 21:56:04 +0900
From: asmadeus@codewreck.org
To: Tuo Li <islituo@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 9p: Fix a possible null-pointer dereference in
 p9_cm_event_handler()
Message-ID: <aUP55AOY3L_TLkE3@codewreck.org>
References: <20251218071012.7740-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218071012.7740-1-islituo@gmail.com>

Tuo Li wrote on Thu, Dec 18, 2025 at 03:10:12PM +0800:
> In p9_cm_event_handler(), rdma is checked in the RDMA_CM_EVENT_DISCONNECTED
> case, indicating that it may be NULL. If this happens, a null-pointer
> dereference can occur when complete() is called:
> 
>   complete(&rdma->cm_done);
> 
> To prevent such a potential null-pointer dereference, add a defensive check
> before invoking complete().

In practice it doesn't really make sense for rdma to be NULL here
though -- and we can make sure of it by assigning client->trans before
creating the cm_id and get rid of the other null check instead:
-----
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index b5ceae1cccbb..f2d81f3ef255 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -145,8 +145,7 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		break;
 
 	case RDMA_CM_EVENT_DISCONNECTED:
-		if (rdma)
-			rdma->state = P9_RDMA_CLOSED;
+		rdma->state = P9_RDMA_CLOSED;
 		c->status = Disconnected;
 		break;
 
@@ -541,15 +540,15 @@ rdma_create_trans(struct p9_client *client, struct fs_context *fc)
 	if (!rdma)
 		return -ENOMEM;
 
+	/* Associate the client with the transport */
+	client->trans = rdma;
+
 	/* Create the RDMA CM ID */
 	rdma->cm_id = rdma_create_id(&init_net, p9_cm_event_handler, client,
 				    RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(rdma->cm_id))
 		goto error;
 
-	/* Associate the client with the transport */
-	client->trans = rdma;
-
 	/* Bind to a privileged port if we need to */
 	if (opts.privport) {
 		err = p9_rdma_bind_privport(rdma);
-----

What do you think?
-- 
Dominique
