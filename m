Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466587;
	b=Us1G5KcS3osDPiOeY+Ya9MJdOPIu3L88BQraZQOnSogCjJLRlv4P/5Q2+Shyv4mlgBgo
	 5eSOnwTULTJpTmOE/qNLW1eTVARm1zba1F02bPyBW7Eeb/YFtmv7X1ImP51iB2ZdFmWuz
	 Ch9qpvzkVmb+wPq1f9VQt3K0q3a+gWdWgGYrwSvIS/PEQr7CBHwwt/ngQTS3MpHVz/sh5
	 8N5SThRrFNBRfDZ6REBon8nN2jfVQKYiQWUmWXcSEg08+l6o4TtUhTOenQ+FhfoXCRzD0
	 Zu4Mj/A9EbFPsY2md/EXYW3a4zfMWEL944uXgZtKwAahBOGIv8JsFMYXVJqdfae/30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
	b=2OQIXjmM3hUjGwQ3/QavIVjklS37a1zbeq2ed1SWlP6yFyhqTyTtdSVtl2TeTs5XscCU
	 KTAe9zYyHjkFbmGCm6XewNslnT6AFRWuPJR6gDTFGu69WJwfr9b/vkbXygphQroxjy2OG
	 La3jl0B96n6+tyNgWMoWwkPSQjBhKNf7eT+ySYW0s6EyrDVXkU4kyM0Yjqx+vrPFm+z+z
	 bj6tlHXYlVrNLQTXQcQuK6ATp0SOdOoK5j7+C+fM7/Dlu0bsiZwnm25waI1hKsbyFg6zo
	 EAVzIlu9KXiIDKReXyD+9K9Qp5a67/1ghaDBF3pTdARuhUlw+ekLDWaIRuHx7zhar/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WwPNhz4j;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46E606A32D
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF46E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WwPNhz4j
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38644aedba1so5695984eec.0
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466586; x=1796071386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
        b=WwPNhz4jjtZxe71PYBkX0xbtT7KbkbIzxzoUxMYVWkbcYU5cZr8ffJ0wyB33mfUAST
         A8UB4lxXakmgng5REvqyrNxUk7zVKhGzAtjoZmODlt4ytMYNWbsudu9dB5eeW47+ryyH
         aZ8JOTU/PYDp1xtJ3XPNd80HUkb/qFBWR/kHzE7kCntlkSSyumtBVOADHIq3NLaa9pYt
         3Jl5qBIpWALjVs+U0r5t3ORKL2BlqO42w5CFNmnBPLR0xNiPgPs3nfr2w6w9TlaDoqxo
         5ouKOnWFzMbHcFtZLK8gPeR/ZV7pl1P78lbEJQ6V/fRcQ40pTapKprBn3iq+mEQbUcpC
         Zh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466586; x=1796071386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
        b=Mfh0J6itKgccGtg1pn69B6TEbptueUjEQNG4Hg4D//hq+nNe9O6zVJCpS0BcnP3sBj
         ZEuGeSnddrMvQHRG5wSFMhARUu2tDUE40eDBUQXQTZF+K69OjWi8ku3Bf1Gc1oFONE9H
         STSB+Qvl3zQ9j9m6J5WoqZzTf5+nKnwoHfyCLOEmBAP4075+STur3AA5Gch9JVrm+Bo5
         6oSF638LxunWKfe8aRRbIUebkhk1so62xffW4de8Gt+HBcORn2WAy12htxD2YBoeXfBG
         GoTZP7QcOUJCNXq7IUX1m56q+ezH/6p8GKiy5kdE6jNeIis9YF58YraXHF+stXtUFwCj
         Cg8w==
X-Forwarded-Encrypted: i=1; AL+hErHYQEjWQFvkB1VcoNrhFgVFH/Z6CyrKdCa5JDpy0g6UfcQDvMmlgbB1L9d27JSdXTW/QCe9@lists.linux.dev
X-Gm-Message-State: APuU4Z9UYaGuocKJqOuzJikg6ekY2RClrcbfxoqdz/I5J0FouvBxXeh9
	jUfxXNVxyCw4fAPyHF2NeaghptwnK7VWBk6zHLA/qVDVKTf7RD2nqMm3GtMcbrCLqA==
X-Gm-Gg: AZFdTZf4Biw0M/TKOASG7n1Z6gV8F2tNpoUS+XnYTpw850NiOo+cJMWFd/VYkjY7p0B
	gp1UOI9SkkRgKgMYE1aZVXo8GHdM62/NebhrpGuhq+LRjN1gI5+QOrFm8a3gLUPrnYYxywfQ5e2
	j9/e6nSYqXRiurez4PaiJ55Cnm4EVGxOFnrS4Zf2vEDjftrKfzPSLjN520YXa7E6mCKPhli3JDH
	lxPkzv5IfN7L6FxiZ4+EeON7rzEEYICKoTEa1fRDpfoP+7hEJ2LWykHHr5xgtj3wWETXdIT4Q1C
	584xeXdMYTn72HVYUjngdjBR5AbVAO6kSYyJFB/en8N0/S4S05bi/m5CKUvr9bt3dg/eFRG5tzC
	yyEoMVLmOxuPU00ph2XQBeAvvoRdH9hGIcrg7cEAo4t7L5m1BGQti95VCYOtFCXnqOVfNJmLDAI
	zTmJWOaF2qhFswDf6J1aboSkxgvHXAdTsxREHAbTcYnqk+/nR9ZTuIXQNJFLad7Ax7jdyhRl4w6
	M4Hjzd7leK0nBc5tv89gNRK9Mqn6uSoTLvKsngqKTrkfXE03JR0IhWZjz6OPFknFbuzckybF7dT
	fWPCU01GmBcMuL3Ihr8XdxcSHHdZhcH4Cb3ZHA==
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b5568f03abmr11749247c88.36.1795466585475;
        Mon, 23 Nov 2026 12:43:05 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:05 -0800 (PST)
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
	Sashiko <netdev-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] 9p/virtio: move the error string of an RLERROR into rc.sdata
Date: Tue, 24 Nov 2026 05:42:54 +0900
Message-ID: <20261123204257.3055515-3-lian@is.s.u-tokyo.ac.jp>
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

p9_check_errors() parses an error string from both RERROR and RLERROR
when the protocol is not 9P2000.L, but p9_virtio_zc_request() calls
handle_rerror() only for RERROR. The error string of an RLERROR reply to
a zero-copy request is therefore left in the reply pages while the reply
size still includes it, so p9_check_errors() can parse the string past
the end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff888004b4c009 by task ls/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140
   v9fs_dir_readdir+0x2ea/0x730

Fix this by calling handle_rerror() for both error replies.

This patch is assisted by Claude Opus 5.5.

Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/all/179446998758.2199510.14994914047354508278@kernel.org/
Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- New patch.

 net/9p/trans_virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 53046668c16b1..8d9555e64490e 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -541,8 +541,9 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		// The device may report more than the buffers we posted
 		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
 
-		// RERROR needs reply (== error string) in static data
-		if (unlikely(req->rc.sdata[4] == P9_RERROR))
+		// RERROR/RLERROR needs reply (== error string) in static data
+		if (unlikely(req->rc.sdata[4] == P9_RERROR ||
+			     req->rc.sdata[4] == P9_RLERROR))
 			handle_rerror(req, in_hdr_len, offs, in_pages);
 	}
 
-- 
2.56.1

