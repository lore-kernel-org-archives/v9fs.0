Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271373;
	b=F6nMjBl+Bk+lTZBUGSsbKbG1E2qB8xqRCsgirGlDZYn2yraxF/ztbY8SBgCSppkOUT1Z
	 HtgSSlkI29DvI93EQ7GrqemCTDQ6dc7QxNn1+N+bYRCcuUllta2vs7tjm6UKNiy21ppix
	 GDgd3lvHs30J8zXEPBqEmsLLWvquWvQ7biEnET87iaOrrAT0n9cqCyv/kEwRVdsNog3O2
	 WR+eZVjGDCP5MLtepT+eRseByGdKJRZGYQbNWVQvqX+rWWqQ0kzgQYBYIlV6XpLJY+oX2
	 AKkADu0fu13zJqrmczB+/S+oQ9jTA3ht6Neapef0MNZs7X+IfsoLoPLoyegyWhHoc2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271373;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=EXqNzBB5vpavjyBNQAV3mjvkLPwAjt6dir4BzaGhbIA=;
	b=hO4yziU1vhGQaSBe6wxDTr60e0DZ8PAZT1VtFlyBC6+5X4aUF2pSmRxNUU108F0Jq6Ck
	 0rw4psXk/CArl0k7ztzQv5D0j2lTJiUfuZIZG3nYxjZMPwXAL4u3+kOghNfLyu7cZRHUp
	 KnkEN3qnaPBNziKk8okJeP6LA7lPxUTPL+3sHe9LpU1Hk1ntJp6/2hojYBqvF5P/WBrTr
	 12Mlg6Z3dkb4/1SDDMyvr7VeI8HqJEx+dYXyeM6Pctjy7R64RuIdeDByQ180GD/tFXB+T
	 F7XSQb+KdDGWOt08HMrKXlEmQuA/qhbDoT+QcQstWowAQuDF2T5Hib3mlXGIjJTCs2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=bBSykGGu;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB6606A31D
	for <v9fs@lists.linux.dev>; Thu, 29 Oct 2026 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABEB6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=bBSykGGu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EXqNzBB5vpavjyBNQAV3mjvkLPwAjt6dir4BzaGhbIA=; b=bBSykGGuUIhl+cO0nULg4GSnSz
	MpLSTSbKWFR3SmkvGa/YX11FWGBLyU1PfCurq9r3vZUtP85raWMojj9U/Uyspi6eMPmKykg3OGRYH
	sZr0felJYT27OP0/AUpBeIXyBdz0PA/iHWfOWbOXfsL6ZOi24U/7tkVLn5lchLBmUNatZUXyYlBrL
	qiiyz3b2RTvgfNJMnFr8NdjVo+EmXOE0Ow+DGBz0QSKIqXiW2ZhNbhHC3dxWm3z95vL8t84RuV6wi
	Dt1f0Fk6XgL5Ul0MMPnC8mLlsYbDsI42lWMETUgUNfKDTRURL13gsJIuvidBeowAXPQxbkIeDo3Mk
	BXqrb9+g==;
Received: from [::1] (port=39374 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xMNni-00000009KUn-08vp;
	Thu, 29 Oct 2026 11:56:04 +0100
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 11:56:03 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] 9p: pin request under client lock in p9_tag_lookup
In-Reply-To: <auLejxGRgVLKlLuL@codewreck.org>
References: <20260930201357.590469-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <auLejxGRgVLKlLuL@codewreck.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <08dad2f67457cf97eedff42e57312bd2@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-29 06:50, Dominique Martinet wrote:
> Jérémy Jean wrote on Wed, Sep 30, 2026 at 08:13:58PM +0000:
>> 9P clients keep separate request tables but share one request cache.
>> p9_tag_lookup() can race with the final p9_req_put() and pin a request
> 
> Ah.. Right, just checking the tag isn't enough, we also need to check
> the client... I'm not sure why I had assumed the caches were not 
> merged,
> they're only not merged with different types..
> 
> So technically we could add a reference or some kind of id for the
> client and check that, but given SLAB_TYPESAFE_BY_RCU is hard to grok I
> guess it's much simpler to just take the lock and be done with it...
> (in that case we can get rid of SLAB_TYPESAFE_BY_RCU altogether, the
> lock is enough guarantee that the memory is valid until we get the ref
> here)
> 
> It's far from a new bug so I'd rather not rush this just to go back to
> rcu a few weeks later, give me a bit of time to check how much impact
> taking the lock here adds so we can decide. There's enough leeway in 
> the
> p9_req_t struct that we can check the client for free if we care...
> 
> Meanwhile, if someone else has an opinon feel free to chip in

Hello Dominique,

Thanks for the reply, and I'm happy to discuss the best way to fix
the UAF.

I am not so familiar with that code base and I have a hard time
deciding the actual impact of the lock. As you said, it might be
possible to keep p9_tag_lookup() lockless by storing the owning
client in each request and then validating both the client and the
tag after successfully incrementing the refcount.

The two helpers refcount_inc_not_zero_acquire() and
refcount_set_release() should ensure that the client and tag checks
see the newly initialized request state after reuse. Then, the
mismatched reference could be dropped through req->client. This
should stop a stale lookup from mistaking a recycled request from
another client for the original one.

Below is a tentative patch that applies this strategy. I have
verified with my reproducer that it indeed fixed the UAF. What
do you think of it? Let me know if you'd want me to send a v2.

Best regards,
Jérémy

---

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd254..a46187833cb8d 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -84,6 +84,7 @@ struct p9_req_t {
         int status;
         int t_err;
         refcount_t refcount;
+       struct p9_client *client;
         wait_queue_head_t wq;
         struct p9_fcall tc;
         struct p9_fcall rc;
@@ -333,7 +334,7 @@ static inline void p9_req_get(struct p9_req_t *r)

  static inline int p9_req_try_get(struct p9_req_t *r)
  {
-       return refcount_inc_not_zero(&r->refcount);
+       return refcount_inc_not_zero_acquire(&r->refcount);
  }

  int p9_req_put(struct p9_client *c, struct p9_req_t *r);
diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52a..31e4bfa4901e3 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -181,9 +181,10 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint 
t_size, uint r_size,
         p9pdu_reset(&req->rc);
         req->t_err = 0;
         req->status = REQ_STATUS_ALLOC;
+       req->client = c;
         /* refcount needs to be set to 0 before inserting into the idr
          * so p9_tag_lookup does not accept a request that is not fully
-        * initialized. refcount_set to 2 below will mark request ready.
+        * initialized. refcount_set_release to 2 below will mark 
request ready.
          */
         refcount_set(&req->refcount, 0);
         init_waitqueue_head(&req->wq);
@@ -212,7 +213,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint 
t_size, uint r_size,
          * callback), so p9_client_cb eats the second ref there
          * as the pointer is duplicated directly by virtqueue_add_sgs()
          */
-       refcount_set(&req->refcount, 2);
+       refcount_set_release(&req->refcount, 2);

         return req;

@@ -243,12 +244,12 @@ struct p9_req_t *p9_tag_lookup(struct p9_client 
*c, u16 tag)
                 /* We have to be careful with the req found under 
rcu_read_lock
                  * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to 
get the
                  * ref again without corrupting other data, then check 
again
-                * that the tag matches once we have the ref
+                * that the client and tag match once we have the ref
                  */
                 if (!p9_req_try_get(req))
                         goto again;
-               if (req->tc.tag != tag) {
-                       p9_req_put(c, req);
+               if (req->client != c || req->tc.tag != tag) {
+                       p9_req_put(req->client, req);
                         goto again;
                 }
         }
