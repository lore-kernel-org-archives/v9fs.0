Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467123;
	b=fX0oPJ/yMojcWg3yDtRGKfk4Au26uAVvU6jPHwL0ZJp9F5rSFalHWl+Do0aIitQPiLOb
	 noEbijlTDfWn7qh5TzWLbcuOE2OEmgZO8FX5Yh84FivbhKz7an1ppy3thNkD3531jzCji
	 ofEQqyhpmvY+vQFUHDGrVTD54ivA1whCbsXVfY9BFTRJ6wCOl9VD8hW17u5d2P1b9qCZp
	 +CSCBiSuq3PBonkVUjMjIdQLl3YwmHl+5aqjOF62ZTTWfmE7mag1Zz7Jwc1v0LFqYL6Dy
	 DcXT0qQ6R6Jn8zityMwx2b8JANubFTJLMIjqS9bZGomMwoiImb+a/HGst36ZQRysW3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467123;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eoFBuZX7cl9z83u/LMcI/j8Tx2rvqIARdyS6MqH8nbI=;
	b=rEzLM67yfwCyThc1EE8QgEndc4wVaRetKpOyCtggi4/UZjlydpq7+qyXtmsGb79OkDPK
	 doQlN/bN043w6EFX38GL8E+AiicuQUD2zxBVoHO0ErrG8qlOjVs6X2FUfQD2nsRJHM9FY
	 DaYhjzv5zB0ERiPGQdNEgGqdrFVF3m47vClkz9dV4jURIfdqDEA3kkbyTqdSMdV5ovU/u
	 hArhYUrbgpGTr3FEQpiNsQ4MyS6yruXXZsmYJ5i3JM+GQfgJkjKGA5oNoKrB2q3uOgQmw
	 f2GtBq/2oAVB85cGrwGw3tCWLDvN1f8ULpOCJzdAXiryKBjcZ3UdAuE+gE0T3XNb5Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=yyGK7Ykb;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCB606A32A
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2FCB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=yyGK7Ykb
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id BBA2B14C2D6;
	Mon, 23 Nov 2026 21:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795467117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eoFBuZX7cl9z83u/LMcI/j8Tx2rvqIARdyS6MqH8nbI=;
	b=yyGK7YkbpvEiGOvMLTEouavV1EopCvmE6S2Eucjf3YMnoWaFdsiBBq3fCIPJcq304G6zB6
	MGyyaWaVqej28o27zWOChlZJ8fixouayRSheV2+7Pxi48CeSakT9ldhZyOl0NNN1vP4/PN
	6Xzk2oYai4BAZWDJ2kSNeSIvcDSBj5LDJMXe2WW/6rxX7oL488+l5tUNuOOIMQKdQ0VjlK
	1E8HkWjyztBqcW5n9slVMPro/XOm6LGcNvAVixpvjd54KNhuw3an3elQcZIpp2eL+KcX2N
	LIjG9DAXiUV3qhB17rgBQo681ao8mfGGLTPMxrGpDSAxq8sy3Q2oAuQsbGb1Eg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id fffc9bb8;
	Mon, 23 Nov 2026 20:51:54 +0000 (UTC)
Date: Tue, 24 Nov 2026 05:51:38 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, nkapron@google.com,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: usb: p9_fwd: Send complete requests to the TCP
 server
Message-ID: <awSnWlnvyPkzYzJG@codewreck.org>
References: <20261120061937.98224-1-zhujun2@cmss.chinamobile.com>
 <awOQD-9KMTflKrd4@codewreck.org>
 <awRYqogEpIWuCN9-@line.checkpat.ch>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awRYqogEpIWuCN9-@line.checkpat.ch>

Michael Grzeschik wrote on Mon, Nov 23, 2026 at 04:16:21PM +0100:
> On Mon, Nov 23, 2026 at 09:59:59AM +0900, Dominique Martinet wrote:
> > Zhu Jun wrote on Fri, Nov 20, 2026 at 02:19:37PM +0800:
> > > socket.send() can return after sending only a prefix of a request.
> > > The forwarder ignores that result and waits for a response to an
> > > incomplete message. Use sendall() so request forwarding completes
> > > only once all bytes have been sent or a write error is reported.
> > > 
> > > Fixes: 673f0c3ffc75 ("tools: usb: p9_fwd: add usb gadget packet forwarder script")
> > > Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> > 
> > Thank you, picked up
> 
> gregkh already picked it to usb-next

Oh.
Dropped from 9p-next, thanks for the heads up.

-- 
Dominique
