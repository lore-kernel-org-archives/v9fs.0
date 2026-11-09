Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221581;
	b=bKujfh0/x/nLP2ed2njM6geWPV1g5ii45vy+nQiGW7zAOYFZ9z68oeYuODEn9cb9WN0o
	 lTDXHtQGlkqGWmtBkjysrNnGWHuS3+YGJDQT5V7sVLGtJPYT59xICmjNsehGCovNljbgS
	 p1+3E2ri1nQ6XQjappAFUUhopcd2NiY9dyh3u6k2LBzSPDv9R9Kj5FU3xZPa3q5LrEIoF
	 aD80Hwx5gYMKYCr3MLcLPyjhsMrJQLdcLfoLsIr/5U04fYE0RHBWoBDqTeswhcAARneIl
	 GGXC9yG+w6kq5/M1tJxYsM0umXLaZ933d0HMsSXNpP6X8PuE0e/joMZn5Dl4Udg87Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
	b=lOBKNuQ6ebP0949KWr3qSh+/rS+DniGGnUdRfXFkgVb/prfwGH0Pf/XuSnfexkIIA7eo
	 yjIeL/MN4H8oWlrO4F/FHa6rVyNQmCBM37IvSRKYZ3hobf8Jn/3VBzYx59NHS6HSDbBOY
	 YmMs91zdbEcYUJziXRYWl81TEdgY7Vsf9zoqiyRMZsdnW3aHtRXRsT/Kn2Uf4s6DLNjv5
	 zsnVZ7bkYUoLuaHajSdpKiVYsicBIz948kyx43jyvZg9Sr62Bg2aJeXKseszofOdmaHRI
	 ULlj3C2CX5BvSLLO6neDImaRASpVLYfH4+a0RfBeJmxP8znJRM0hROLhmRhciZg5xTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=CNmob+fK;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD344606A326
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD344606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=CNmob+fK
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so839910c88.1
        for <v9fs@lists.linux.dev>; Mon, 09 Nov 2026 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221580; x=1794826380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=CNmob+fKGACFYEXG8yc1Cl/8wxo+VyYKS4tPz1fReCXkqfeM3112S7uo3XRN7oC6jS
         u3tgkOo1279uo7mG+4bEzHkeF+swstwI/3a8eRn7EWfLkJEblXcCqp0iiLJRVGaThINX
         Et1USwOpHCIT0WdQAJ/X0OwqGZqpjvSX6LiZGSJV8gIJDawFrWwQJG1WGb6PS1aIiH4p
         VqPPoQxIaREg4wHKFfI9YVoAbJvApal+cVCzOHVYXh3jG6axq2HiR5Ktkm77uRA3inVr
         BnQxYDU5lW9N/Bl3TVG5kI0OmBqE6iFlo8V9W0RXvj2KEX5W0KyDo8hSopB+NMytEf0V
         6D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221580; x=1794826380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=fb3rsmPFHNkY887iUWWADKvYOcOq4/gUlLWKaALqnwl09pgXeoG8Nsjh+yqSrE7mOn
         I9XeB/vX5UcgosPAC8K23XFxDhCybbc1uUxpS0zzA/kq+9l7P3JPJkR/XoOPbl84uqeL
         ZYH0yoWdWa+R8eQw11UhFM+iWU9s9fWHuDbNX2hXpBEGks3pdiyueEfRdcBEQt+GsYor
         JAyN2xxWQGitoZI7rHx2tq1rffvgTcmXGSgc2xUWcZtsvofxQwJD/7EaGJcCaXdDoZoP
         bGyNmcO6R5pg1YFww57/v5v0lUs3MoYrPOZfUtfvjvhpncmW/RCVPu8FsQtlZaFuX4bt
         c+pQ==
X-Forwarded-Encrypted: i=1; AL+hErFzWS8iY9vP5volF2wNCwF/PLP+gbWkIwnrDzy4ENc1XhQgYq5qFlt6xhiYY0UFhUZC7uVJ@lists.linux.dev
X-Gm-Message-State: APuU4Z/244hPmB4yah4RScuTdNMzgnnXUtx99Lh9gjFgACIBA6LDNod/
	/Z6r4G4HduARiPHDPJPHxIpCJC8pQa4fsJ0LSyBb4fwS4rrMHBaLdLiWBdvbLdv6gg==
X-Gm-Gg: AYBFou3TGVXfF6pvwrXmsSytPlbdb/CfFJujEvIiSangGg6esp1ab6M6HFoWZy8Bo4P
	aefM3CBkyKk0WTIIYwaODu6AEfkUhUDQA7m6ACC0t3NdftvA+PKbvwMQOpJBV0bYUnCi5c0W7wf
	QnYR88628bElIV77LO2AKUWy+yVgZbx7fbZP4urFspGtbjTS48ODLZRPU2kZC7txq23p/ATdaQC
	tPSi6vl2XdHE0rg9/1JMZKZxSKPCHyT8wfSQFsRRmbokiFnc3j6YiIQ30mK2/KSDb2qxX5+JNkN
	cJ2Yj0R+6uodVwzdiCBwHdDr6dUHRTJSv+xN3rvu+6UShIxJD6hU06jGt/hWTaeuNg8bLR4NYRD
	AMLx83DCZTrKndqZ43eKnogQ8lpXtHBipEQcRQT2syUvH/qc04GNVgfMWF8gMnfRxDr179B6DnQ
	63ZDkVdfpu2WYNg6BS6JYnVZ5fdG/6PdlS5EgnTdBoUStcsyhsegniNcVxLw3O2E6Bk+9hyKFN1
	NcYtsFjt92KHXYQ2iGOIwQAoLsqtcrhYfC9jl6VDRX3781jKJDWpaeT46xui4F3dTdN+SscbfiR
	0cZgPRiIQLCY6URfujZQX2g3w6ghsjq7hRQElQ==
X-Received: by 2002:a05:7022:4588:b0:144:fb42:52 with SMTP id a92af1059eb24-1b39feb42f0mr8095312c88.28.1794221579708;
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
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
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] 9p/virtio: clamp the reply size of a zero-copy request
Date: Mon,  9 Nov 2026 19:52:47 +0900
Message-ID: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
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

req_done() takes the used length from the device as the reply size
without checking it against the posted buffers, and p9_check_errors()
skips its size check for zero-copy requests, so reading an oversized
error reply to a zero-copy request can overrun the posted buffers:

  BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
  Read of size 8 at addr ffff888003065768 by task zc9p/157
  Call Trace:
   handle_rerror+0x144/0x230
   p9_virtio_zc_request+0xb8e/0xd70
   p9_client_zc_rpc+0x21c/0x970
   p9_client_read_once+0x237/0x6c0
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff888003065760, ffff888003065768)

Also, handle_rerror() returns before truncating the reply size of a
zero-copy TWRITE, which posts no reply pages, so p9_check_errors() can
parse the error string of an oversized error reply past the end of
rc.sdata.

Fix this by clamping the reply size to the posted buffers upon getting
the reply.

This patch is assisted by Claude Opus 5.5.

Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Closes: https://lore.kernel.org/all/20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn/
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/trans_virtio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 9fa63e3ebf673..53046668c16b1 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -537,10 +537,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * threads - echoes to wmb() in the callback
 	 */
 	smp_rmb();
-	// RERROR needs reply (== error string) in static data
-	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
-	    unlikely(req->rc.sdata[4] == P9_RERROR))
-		handle_rerror(req, in_hdr_len, offs, in_pages);
+	if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+		// The device may report more than the buffers we posted
+		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
+
+		// RERROR needs reply (== error string) in static data
+		if (unlikely(req->rc.sdata[4] == P9_RERROR))
+			handle_rerror(req, in_hdr_len, offs, in_pages);
+	}
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
-- 
2.56.0

