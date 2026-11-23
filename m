Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466592;
	b=RNJZgQdUy+4ueYpRwodwdrNlXzs6r5bdYCG1DQcOoQU35XNMZewUoegPz1TVMdRaQPQ9
	 d8j4ajCkwwL1VkXyVLQD38HKnoWiGG74ndr93tZ+53gK8IPLYTC5aIsQkIG/iW3g4eboL
	 wGs8FJnkzqK7zoc7gkhz9DZfpoQMHFytujkKFPD0lMpA1zRHANcImYkdm76g5Vxw3UQOi
	 vA3Dkv2g2hGejSJP+JK0FvkRiQ0NfWgetmFrq0/xwaFmKShyjlnsZjfphWkTmyNfYtwkz
	 3D9Y5X7QKeoy7J3o6TcRc6ZKIFIIHp4ll8vNSugalLBKE4+vse8vpRqJFYtXLBA3uOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
	b=uSgmNCH1a+OiDqP6/YK7+iEH8AWW5h/QdOdK8TFq0JbU+dCIbJxneBVGmsHlwObf7+2l
	 /6L9LmCWWUh1cZW1LC0Ya8N+D2VKNJ7GNSA4s6dTJ0KpC72l/0JXMwKBXRmbkkSw78+Vu
	 Ezfdj5w+PPYuCN2FHhDrti8rI57fBhnTtwAO7F5Df4+KkLlJU98sH9zPDNaK7uCyPAMv9
	 WV4yFEWCfhDJDQdy9GeH/jFPaukg7DU8GHoj9B8TvB6/2v6h/YnXFq3A0O7+thErOPDiM
	 oxEV6F8tVTcHLFlDOVjqHqLP/7Ybm4gQB6uTwjMhgKpgDheiJsA0xfcKalt/dbk+iCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=MoCMOw18;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9F606A335
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA9F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=MoCMOw18
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4680762c88.0
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466590; x=1796071390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
        b=MoCMOw18+BOLggIlrL7d8l75SLk4sWIZYgwIoIiwEGWUokPsmge+kou8GD03Sb+TVi
         irSlC28RE+3d1Xc9sSJJcxyaYUXxIhLTQX6DlQKJ8p/vthg2DzArhNN/ZOT9WQf6FkrC
         I/UWtHIfakEK0TFK9Az2fAMCRTU6xAn5pkYIQ+E3TKKlAyz2UMTLMogQAIGHlqtMYeiO
         4QCPLs2AmxGasLjLUkdbjNo5bC6qdX3xFeI0HgWW9oApthe3wbTDW1uivvpNSP1IAFUd
         BrBoH1T5Tc8KWb9QUzfUd86OmnZfv9KsoA1UF18FDpofQBHBX3FxAeq0yfsuLsh6nVdg
         504A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466590; x=1796071390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
        b=FkFHJ+0hawVBJB0VJ23y2ft4Xul49EkDH9+MYfub/slryW5IYX2rLsMTCkn4Ocg7Mj
         t3uIly+BuTbWlWKo56Jl+njTm03/c8MGPZmPIJsuQg/H6fPLHt85prg00EtmV3iK7iam
         vLMu5nBh0uoTxhwsz3/J2DxtCZxBa7RuhXWor0Lc7pm9i1Tp2GV9+Y6nOs0XVXyyKoko
         bBVZ+2ixtCj2xg7IlXjbMjQhPLXdARp32IfrHKrou5FFl1eq8WMJwY0Q93pplyqUG9iO
         Lt8iAXI9cfHKp5GKAkdmomeLmBVzF3QmEIpbfh61sxXCjMFmefNR93Z534glwSpIwS2p
         oGzw==
X-Forwarded-Encrypted: i=1; AL+hErHx3IUd3dt1MkDLy9w3C1sqgTXu6FaOa0gYmx5Q2bcKOrgUkfyn6gBet74FGl9OMb8KQWyp@lists.linux.dev
X-Gm-Message-State: APuU4Z8RTKizwLLKR73xMTKoKJ9l/L7kDUkQJDy82m6n9xsuouLyfKQl
	aa692s9nWXe1ea1KYmqujpi2alISYhk7+CEuNy6IHF0tN50vG3TPlHNEMLK/K/sTJl5l2W6ToE5
	aGVQ=
X-Gm-Gg: AZFdTZd5yR0n5pwjtTXrCLmVOTVW1xL9VoRfSfZrCik3hh+0CRTtIgatzNuAxsnWpbX
	ichToIZ68rwc+ygD3UDNsv8GeZrkpr+LYGBeE+0g2Eh03nk/gjGn/q3dcoebQ2JOojTnt4/Andz
	TsQd80SfeG/uDZPnWDIZvZ5yRg6i/0dJ9q5rz2UvbIageoWo3ot/Z1ejfzKk3y43jnA9x9fVoS0
	YFa2Rnag3ccvYo8gfb/HKCD7jvchaMcm27IAevj3jz8a6ALvEzgOVyDsfah9hs3Bj13ikkKoU8k
	5+4KZ+a2vEFu8cVMc57MwHcIhLdahiC7eJ0I8yrhJCAyNa+3ePDEwCP4fNDv+U+uiA43K/NGwCE
	EDbYLTqqFL62IXH2y4WDC2iOPk4V6ed8j8a5BzPNyyaMbpr6zI2eGp6BrMYBf89HDJd+ZCgs+wZ
	JtUAo3IgSGkX9To0mCuquMrhnlkgcVnFWE4tmDXGvEE/SUyqOCy6pXWk1ugCJ5wMW1pn92Y3LQJ
	7PF3M83A0iSK3yfXTMEz1w1EnZSva/gw0OgkBQ9JJo7erEZ3BCUkmRE5VQIHT3Bw8A1dcMMx8mC
	zRuub8x9g9MVZDNbhX/LJ39AR7ruvMtxYDCOcw==
X-Received: by 2002:a05:7022:3a8c:b0:1b5:3490:d715 with SMTP id a92af1059eb24-1b55691e0camr12826076c88.34.1795466590192;
        Mon, 23 Nov 2026 12:43:10 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:09 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] 9p/virtio: set REQ_STATUS_SENT after adding a zero-copy request
Date: Tue, 24 Nov 2026 05:42:56 +0900
Message-ID: <20261123204257.3055515-5-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
References: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_virtio_zc_request() sets REQ_STATUS_SENT before adding the request to
the virtqueue. If the wait for the ring is interrupted by a fatal
signal, it drops the virtio transport's reference to the request, since
the reply won't come, and returns -ERESTARTSYS. p9_client_zc_rpc()
flushes the request on -ERESTARTSYS, and p9_client_flush() calls
p9_virtio_cancelled() for a request in REQ_STATUS_SENT, which can drop
the reference again:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: dd/314
  Call Trace:
   p9_req_put+0xe5/0x190
   p9_client_zc_rpc+0x537/0x980
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140

Fix this by setting REQ_STATUS_SENT after virtqueue_add_sgs() succeeds,
so p9_virtio_cancelled() is not called for a request outside the
virtqueue. The status is set under chan->lock, before req_done() can
set REQ_STATUS_RCVD.

This patch is assisted by Claude Fable 5.2.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- New patch.

 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 8d9555e64490e..6d1e6093db095 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -467,7 +467,6 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			inlen = n;
 		}
 	}
-	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 req_retry_pinned:
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -526,6 +525,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			goto err_out;
 		}
 	}
+	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
-- 
2.56.1

