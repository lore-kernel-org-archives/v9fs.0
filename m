Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D02FE596
	for <v9fs@lists.linux.dev>; Fri, 23 Jan 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180781; cv=none; b=kg39vpnLrv7Tf+bkNw0p9I+PoYSP1d6hxGscH7wtbSl8ux0NWqRQBG1HsOLZI0OTEyhcqJwq6CN58SgvmnTGpF1+Ffe4I4i6ESzRf7MGDaLlJHlTd/FIkZjxg47oIXC+ve3zl1a4tPXje+ifkS/XxB2xAW2b+lB7SI7hPVStfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180781; c=relaxed/simple;
	bh=vjCLcCM2F3IicS+95q5ad2BGOrb3kOWYWjtQkuAY+fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxohKwLksNZV55NAitaKJVb6+xXl58YUUJcREoDayL13GGp9i1gpvN43ee8fMAofcRoO5K9I2mQzMyTPm861WDiXeJI016zAzLagMEXHTrGVEBRRkww80dbMuQKEua/uVeujg/7YsGuz86KUeUeFZiDL4hsWNhiVSs8txcDcE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=zP8ckDbS reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=HnBYnYkT; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="zP8ckDbS";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="HnBYnYkT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181678; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=6Y7DdxPq3eM3t0cx86EDuwdGb1aCri5BBH+ThrSGicw=; b=zP8ckDbSuaHXnAnZkFCWwTlCCX
	WUf2XQuZNvcpEIM3YfqW6ofLkd3M1SMsVUwIY9d9KApdIxnE/cnD2yl4NTf24oiZgxDepNmgmQQJq
	rkwWGHkfZqlGgE1ZIkbBUPrc2MlH/rtHYQtsiB+Sm8HcWU/E3d1EkRMq7Z1fmgUe25rHu7VW4Tk4l
	lqCnhe5xN05+fxpY5My/MrNh3e2HYuJN3DqTEU8safJo/9oykVihYk4tYHXK7S72UzNaZtSu4tp4E
	SZwOiZFQuCz1xr6BSZH4h2w/1RimxxpDJ40x5kqUM2a7nxIeRmWs1DgGmK3PdcPuFKg5oBbETsCuu
	tfGJOUvw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180778; h=from : subject
 : to : message-id : date;
 bh=6Y7DdxPq3eM3t0cx86EDuwdGb1aCri5BBH+ThrSGicw=;
 b=HnBYnYkTllAvTMgyT009rWQg89COsWvY3cAgdI+Rcn/Dcw3lgOxOBP39XmgHmoqyJNxDn
 dCxVd5yw5LomrWcL9VxLifNVAkUuuR9YQ0gsxIxpOonQuZvieIP7QeFcfeYuY162YXZZPUR
 jfUi0Q7Rizvd5kKpMII9EeVEtsk3gacBYa+08gZQnU6PgaPe0C1arIEJbBb8g92lMvo+PzV
 eBiR7XddSu3g7e203Nb+80krBgmZ11EAh0nXVWxJbRZOMsBLhXFiYtFhU1XjkaxUFK7ESZI
 /zMgDPU0TgGRxnUxowzUSJOBoOiL1IgQrJNIDxgWhHtwduv9Ir1CLrUlFUGg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjO-TRk3SA-Pq; Fri, 23 Jan 2026 15:05:50 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjO-4o5NDgrkAJF-qZA0; Fri, 23 Jan 2026 15:05:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 2/2] 9p: Track 9P RPC waiting time as IO
Date: Fri, 23 Jan 2026 15:48:08 +0100
Message-ID: <b8601271263011203fa34eada2e8ac21d9f679e5.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769179462.git.repk@triplefau.lt>
References: <cover.1769179462.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: uVDish6Q-Vy-.wYLhIdGyQwoj.zjlAEQOpw8g
Feedback-ID: 510616m:510616apGKSTK:510616sagCjD9iGE
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c       |  4 ++--
 net/9p/trans_virtio.c | 14 +++++++-------
 net/9p/trans_xen.c    |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f60d1d041adb..1b475525ac5b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -590,8 +590,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 10c2dd486438..370f4f37dcec 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -284,8 +284,8 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_killable(*chan->vc_wq,
-						  chan->ring_bufs_avail);
+			err = io_wait_event_killable(*chan->vc_wq,
+						     chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				return err;
 
@@ -325,7 +325,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
-			err = wait_event_killable(vp_wq,
+			err = io_wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err == -ERESTARTSYS)
 				return err;
@@ -512,8 +512,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_killable(*chan->vc_wq,
-						  chan->ring_bufs_avail);
+			err = io_wait_event_killable(*chan->vc_wq,
+						     chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				goto err_out;
 
@@ -531,8 +531,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err = wait_event_killable(req->wq,
-			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 12f752a92332..d57965e6aab0 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -136,8 +136,8 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	ring = &priv->rings[num];
 
 again:
-	while (wait_event_killable(ring->wq,
-				   p9_xen_write_todo(ring, size)) != 0)
+	while (io_wait_event_killable(ring->wq,
+				      p9_xen_write_todo(ring, size)) != 0)
 		;
 
 	spin_lock_irqsave(&ring->lock, flags);
-- 
2.50.1

