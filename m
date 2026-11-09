Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221601;
	b=33hcR/JhM7lew94HHby3s9xFgySutKRXVPVyxoDoBRCQkjW2Hr2dVS4kh1cnooWw0+mH
	 S6jfjMdLOQAVY/uqEYd0Mf4lazZ6mj5JhlxxRBhOg52m/b4McXUWfIBcpBlppF1fN/kub
	 M83aKZ9fWBwWTV+QZpikYs05Epuqn0bdn0payieZ+ZU1bJcAW6w3ngJug9IxWLcxN1H1P
	 UgfFfk8zb+/4LM7UJUGY7giIs6I36GMlLHSjoJ98Wjg2Otpi7jju+1chGcPpGA7Guc/8F
	 qYPgUHJqnTKCueCywXRVhjMcBLKKxvhmqyrKqkoKIaiLFsz8aWEyDO5HrxoC/QA/CIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
	b=CXkkDndTPumV0EYe1mwFYbfrFqNWFNn6pMa/mJMtfjEmKyLWLb2qOQ0sacZE4ta5iVh0
	 ZzXrsWqJ4qChcMsEnhHM+SH3gE6Pyt2XLg4jD4uusXsc4pruZB4rNFHDmD+6qG9Ths2Ds
	 BZC80M5o4ZHLQYrCqiaQGSb4E9347IyRrfmbn0kLCOBA+qrKz5GogL9PTmbJ0Urdbm+iz
	 6sGTsnc3Qua3d6XYpc1QLmUq68dzZyiC7DR6iY+y+RlGiv1oGmf37NgOIoE4PHilQEyeQ
	 UGjwGeYdGGGOu1yndjk4vSPNPHFHIteSktlQVOtvwhNcHPWvMLkpes+FMGVS6T/AAPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=T+JsP7Td;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4D606A338
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 10:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F4D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=T+JsP7Td
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so1347226c88.0
        for <v9fs@lists.linux.dev>; Mon, 09 Nov 2026 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221586; x=1794826386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=T+JsP7TdOuLxVBnkfnHWPPHfwpSTLsoHgxsQbn23JEAt7ZH0YNCkvmNzP4BTNIQTsl
         dcWGN8dQjwgnOhP4D6kGUnZjJDDlSFSSwPMbZqkFVfK0uWAyGwjx+WlONRcFx6Gr3DIt
         qYbRWf6l42Ahohb8AtttvdwxbwAx1nUjEftjXjPqfglBQJ/Pmmm7dY5//pcGjb6mfhaW
         0dJseNdXZMSGmxIabAh2NvmTbfjlf8wKNwNKangk4d/4FuYmrnHEM/UhvOFvAdhcrlMk
         MG0oh2OLmzam2V4KMDy8TiPKTkiynYZj1/96i837H18N+gUnX1bp0PJa3Fzf4Y4Jekpp
         HP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221586; x=1794826386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=Y+hChNCZ3Yw8eGx9xw4/0qKcWAzt5sfAiwUDb+jREemez/lQYpAbXZEPyeIXSZTJoD
         ZXRs/ha6QSlUVcrlm2cd/RQStTDUqtQ3d3taBzQ7PMiG+9Pw45b8sm1avr1y3pxp4ti8
         k7pHNOLOEFivLqWJo1saaGUydVn/8v0jq9ZaJdDxiNa8ASw5dZ6kcS70BxA+wEzO2yru
         FXlOKmKvUb2101HJ56BKH+zLYDbv3Yrpbsj/AAGZn3fFI/1fAO6x7FyMfD3D/uhS7D6X
         kRHcJsXRvHwvzous3C63MTRiAwR48agHJeU1HFZ6ikhVarpQgAdq1Wo3Z3UfDRoxz2c2
         bUhQ==
X-Forwarded-Encrypted: i=1; AL+hErEmTcO2/4DC0ESneRAMzbyHf4unBT8M3F9fkGhmpxvqGWwwtsP6b80rRhXWFE7/rKEDd1lJ@lists.linux.dev
X-Gm-Message-State: APuU4Z+lgYQc4FFZW2RNbIMj58RIpt0FyNivP8T7yR6fQNGO+aKXr5RP
	eNIpcEUj0sS6WvCefs/piua5YcK25HTpdCXIL6wD4Uu3Vzn7iHYtbxnT7MpUbYX3bQ==
X-Gm-Gg: AYBFou0bPlQycwwcSUJetzswBrBHCyxKQold9LIpusJ9rQc+5AHTO1RUZhg/jdGsMLF
	usvMtDLiJ1WPuCc5uS4P1UdGqa2hgvRFxzY6pb6qmRS+xFF6WCYaxVwB7wOP1yF/emKKUNCImVU
	Y4UeL++Jyo0rsQX9vyJ/eLKL+mpPr7hFCJgDy86S2EdKfVfWVy6WruOxrxbI+3APNJiXcRdkZV4
	MaO8FW5pqmGMQhjudPCs5uc013Hi6+LKPKNiDiqJUpzEg5Ys6SAvU6RzPDxRV3+3VOyijwUhlo9
	AsC81RmsZiRb8yPnEW3LnFPIJoSlPlWJxuev09oA1nFsdWiMFfKOcvmzJo2JrkktkyR8FOTAiw1
	K6dGiw/n1y144CRVKRUyf2rPfYl+295yVUUVcGrVUyvzO13kM+CAEPNfR07FUOSYln2P+yfF/ns
	ofPZxkN2VyomzBS2BW96mApSLTfFxVLTanboqJbLuU+I9qKS9YMqseD7IuYONo5vxlJ3iES1kzv
	m8AWLUX0jwH8xqKKWLLScBoGbHOOBxVlEtASUNoluR6IyK8P4onFhp4qrEKOweGSxtYjHJOIUZA
	w0hEGUQoaaY0Mqb4L8394lVz4LycS/YYExv0sw==
X-Received: by 2002:a05:701b:2705:b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b39fe946b5mr6255466c88.19.1794221586094;
        Mon, 09 Nov 2026 02:53:06 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:05 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] 9p/virtio: keep a request until the device returns it
Date: Mon,  9 Nov 2026 19:52:49 +0900
Message-ID: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

When the RFLUSH of a pending request arrives, p9_virtio_cancelled()
drops the virtio transport's reference to it. However,
p9_virtio_zc_request() has already dropped that reference if a fatal
signal ended its wait for room in the ring, since the request then never
reached the device. Such a request is still flushed, so the reference is
dropped twice. This can happen when concurrent requests fill the ring
and a waiting process is killed:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: dd/293
  Call Trace:
   p9_req_put+0xe5/0x190
   p9_client_zc_rpc+0x52e/0x970
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140

Additionally, a misbehaving device can return the request after the
RFLUSH, so req_done() writes into the freed request:

  BUG: KASAN: slab-use-after-free in req_done+0x1d9/0x280
  Write of size 4 at addr ffff88800392d758 by task swapper/1/0
  Call Trace:
   req_done+0x1d9/0x280
   vring_interrupt+0x32a/0x540
  The buggy address belongs to the object at ffff88800392d708
   which belongs to the cache p9_req_t of size 136
  The buggy address is located 80 bytes inside of
   freed 136-byte region [ffff88800392d708, ffff88800392d790)

Fix this by dropping the reference in req_done() for a buffer without a
reply as well, since the device can return a flushed request without
one. p9_virtio_cancelled() is no longer needed.

This patch is assisted by Claude Opus 5.5.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/trans_virtio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 53046668c16b1..68c3457bec401 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -145,6 +145,9 @@ static void req_done(struct virtqueue *vq)
 		if (len) {
 			req->rc.size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		} else {
+			/* No reply, so put the ref that p9_client_cb() puts */
+			p9_req_put(chan->client, req);
 		}
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -195,13 +198,6 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
 	return 1;
 }
 
-/* Reply won't come, so drop req ref */
-static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
-{
-	p9_req_put(client, req);
-	return 0;
-}
-
 /**
  * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
  * this takes a list of pages.
@@ -806,7 +802,6 @@ static struct p9_trans_module p9_virtio_trans = {
 	.request = p9_virtio_request,
 	.zc_request = p9_virtio_zc_request,
 	.cancel = p9_virtio_cancel,
-	.cancelled = p9_virtio_cancelled,
 	/*
 	 * We leave one entry for input and one entry for response
 	 * headers. We also skip one more entry to accommodate, address
-- 
2.56.0

