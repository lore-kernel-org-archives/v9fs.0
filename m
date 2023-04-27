Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D358256A
	for <v9fs@lists.linux.dev>; Thu, 27 Apr 2023 11:23:56 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
	id A0656C029; Thu, 27 Apr 2023 13:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682594634; bh=s+rCY3PhNsjKtAMo7ceBkqmXMZyC1GJyZBLyjIlkj7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BKMeJuqCAs7gz87ccJfjFExzkNjMiSf/Hrt+lG/vd7cp1BFvOaNAKkEYyEe6kvVlZ
	 wv8ZG02JYJpZsejUbhty0V8HrOXCq7QD+xn6lnvLzzrGQqG4RyU+kZqTnssQ43QS0n
	 bPYO4LfxDOPFbfCwuh87fJj9fEL0hb7w9PzQ1aR29UlOW2TIXLC0AoZ5VlU7mDcg7P
	 xWUWuLpe+hlxIpYWp0KtaX9D6aKuBrc3JifIBrNqMcuyaYgIWm59P0iHXG3o3oReIt
	 iVTBzVpY2Vad0a+BXN2E4f9SBwmRVOy3PTeXMwOxs+ICdtnAG77zniLBvvz1xIB/sV
	 I7y4tzwKLz2Qw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 11A22C023;
	Thu, 27 Apr 2023 13:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1682594633; bh=s+rCY3PhNsjKtAMo7ceBkqmXMZyC1GJyZBLyjIlkj7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZlmRSHYPRZOSAJgH54xjFLq2yzzElppfvubM0NynWTo1tmNsz3qHQbcee2Isz7ceY
	 3yZTE8Mq4ZakBNtUU3Z8JW+zsI0+DSqJJVDmSRze2XwOiaz+0HAcDpwo0KTz4ZnMRj
	 xW5UpirTNghyfFGznRoDpDfSKqDBV2VG2eF9WPOaZmZ30IJK7qBPrJQKZsZ1nF6GSz
	 IITwI9V4yauR7QtwkL+88D1Cch00cRg2I1Bhoy4I7JswnvdZfWwu2WwaGvRqhzlXWj
	 PjOvZbgBLlASMztmYMZkMIa79mkCUofMCdEtLZ79Kry7mT13q2+X5bK367zWB7+Bpu
	 aJPlWpR7W1OgA==
Received: from [127.0.0.2] (localhost [::1])
	by odin.codewreck.org (OpenSMTPD) with ESMTP id 224b0460;
	Thu, 27 Apr 2023 11:23:38 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 27 Apr 2023 20:23:35 +0900
Subject: [PATCH 2/5] 9p: virtio: fix unlikely null pointer deref in
 handle_rerror
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-scan-build-v1-2-efa05d65e2da@codewreck.org>
References: <20230427-scan-build-v1-0-efa05d65e2da@codewreck.org>
In-Reply-To: <20230427-scan-build-v1-0-efa05d65e2da@codewreck.org>
To: Eric Van Hensbergen <ericvh@gmail.com>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=uAxOy5RN+SshQ0IlB7WUwAUYTCBMSrvtKIu4Ytp0HO8=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkSls6sv0W5uY/qDr+rJzbHgv/8wIRfEH4Mb226
 8L3vvejGgOJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZEpbOgAKCRCrTpvsapjm
 cIY9D/sG6txif6f/ao9Jzx0NwqwbUftDmaENl23wBkDzshsr8eDrKr1JyNsvgNIy0v6ToBG4q+1
 aQ80V4X+/VM0nOAJ+fynVm4z21W1K2oNfgXRTdYzERfDUMkSPlzuiowECY/hJzeyFSoqyNaAFGW
 1lHtKoo6hdOmG9Wgr/0GmRXtQUYk+SXyl0fOX7et/7ASmTSv8XSZtazNY3FNX1SiFotyIJ7rxN+
 +TqIuai/zi4c/PeFTzOIUUUoTLUJYKleI0dMED7bGvTY1l4wqftWD15r76gcjO1zzbkFgrFn9DN
 vu8Srzkh7Ctmrw1aJR7p+ot7WeHZgD4sxxXcbySpZ24ziw4RRgaJuVd5HZsJ7fTuYwRNILXEfZD
 u3Yji+B2kJJqDi1PV6gn/9T9EbH8ftvqzUB7J8EU93kLbq/n4wF+trJoFD3FQAOt9LBP5ry+U/y
 KjdBLGKFgJGY1tpkOV+XXZnUCktQooqA2IH1zQNntrsjVfVujlYEnRRqVRbL/Ybj9S4qNEyAehQ
 SVVCiT9T9SXz+1h6t3lZU6RMrLPOtZq9qbKNmP8lQUJGUx2grjFs6GbSQfGjKvLVsBI9PqTqJ7l
 it7pKb4GSLaR56oan4Iy1BYy/bbGYcwxYbTmW73ZrahU5hD+KECcXRm3ORCS59QGNxiNtvY0pus
 ibuiffORyhotsvg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

handle_rerror can dereference the pages pointer, but it is not
necessarily set for small payloads.
In practice these should be filtered out by the size check, but
might as well double-check explicitly.

This fixes the following scan-build warnings:
net/9p/trans_virtio.c:401:24: warning: Dereference of null pointer [core.NullDereference]
                memcpy_from_page(to, *pages++, offs, n);
                                     ^~~~~~~~
net/9p/trans_virtio.c:406:23: warning: Dereference of null pointer (loaded from variable 'pages') [core.NullDereference]
        memcpy_from_page(to, *pages, offs, size);
                             ^~~~~~

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3..2c9495ccda6b 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -384,7 +384,7 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	void *to = req->rc.sdata + in_hdr_len;
 
 	// Fits entirely into the static data?  Nothing to do.
-	if (req->rc.size < in_hdr_len)
+	if (req->rc.size < in_hdr_len || !pages)
 		return;
 
 	// Really long error message?  Tough, truncate the reply.  Might get

-- 
2.39.2

