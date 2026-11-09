Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221590;
	b=gkP3dbaQuRxcdZMN1wHaKfu2ttAblEPNiNiRo+Omu1UDvql0OCwrg+k4oJj5EU/Smqy0
	 xdYXhKup9nIFHwve0Rm1rgI82ixZx1DsVoCssJb6kaLXNGL18x+qy2Ztj0q4UkfSBiF4h
	 9W5FNT+VlPLiw2FADetYyc7Zre3/Z/Ag2gZV16hvuxM0oXfl+ijynvYD/ZgUva8zG/WqE
	 97S1zC7k3gLpIU6BAOmj7sLECea8LSB5OVdnIEtG5rO7IsoQfFfCe7dD5s0W/Lk4xuV9k
	 kmew6YHDUD8fbc47vRuES1XdUTLHTrg/4S9GenT6O/zrhfMo218ZVpQzX4tFASGS0OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
	b=xD3O2p69PbOIyqRfiQrYaMclOxd7GvxhUKgUwhcDXeNTjWbLSxsEQLpku8IGu7cDAwJ7
	 SCxXNSEUq2hyQKXYmF1VRXR0VbUIT0k7qtUEfFKas1ZDLSYde9K1F7QgPWMNlRx89RAOR
	 yjfjOjX1HRKpsE897h40W/2scM7E+/ZiCOgUNjRfnlPzZIn9Bmo+pTaH7VTkumRYgBAqQ
	 KoTiNuSMM+nkt019VDq6xtEoW1D9J82Uoo8BxCR7l/jfgAPuWi8+nsoWHDe1qDSqDBQwo
	 u+xXPvnSR5qJtlamCweAO8YdQWHI93BB6+KQ6dUEr6/K0yT32Hxjarna0E7RfPCPsqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=SZwXu0gZ;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B60606A33F
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 10:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B60606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=SZwXu0gZ
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so1347283c88.0
        for <v9fs@lists.linux.dev>; Mon, 09 Nov 2026 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221589; x=1794826389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=SZwXu0gZttB42fXsH0KsdDAxKG36AujmoQ/xH+YXscpAd1dDkVv05EeSx3sIaoTYwe
         ELH4iQZ2YUv96L+y88eDMz+4pXI7R6LYIOImpLId8GHTwM5NclLRCvPyqvk9des/go2/
         FPaDubifjuxC5FHy9G/mr2dzPeaaT3EGtBJsLOcdaibUgRXRQLVN4z3dN7+NYs+p+c3P
         JzaLcA18eD6PLQf1WSxq+d0isZbKa3meMuGKGJvjJiMe5Ux2fXRRlnX48NW3FdvGsJUb
         DTQ+5YpmzbKWgVcEla+h17/Ft7geQNpEJvHh/TwAcFP32OALZNwhI6W+M1MnDjgp0P9v
         8Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221589; x=1794826389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8wcRySJd/dlTtht6qCP4yFXYl/Td0vFc8lSf/i1WTo=;
        b=PMBCBtMwLbhCc4yqi7aLNky2ehmSG2T4quscFMeKEWW16yfgCsi1VV0GUxFOk2kxUD
         iI2+FP6UkRJ6PChGsFBQF0V0bACPv6vvyeAl48seIuYckEy8+fCLpvANiQg0sB2dIahz
         Yn3jWBCcd07onW3iauomQjdiFqpFoIysXah1O56L7lAS7P3sRkwqy6JJbbKMYBiUQF9Y
         R3/O2K/uaZAaAi4WC8a17UebmOfo7uO3iVSAJGbsEAXCdxpZQTv32y2ZeJTKyEy8Z6W0
         LONXH8eAmh3B5e47PI4nGvuxTNFIcXug0rMvYgxYx+wNRt6JXpMVzFI5WxEzsdP6Wdq9
         pQ4Q==
X-Forwarded-Encrypted: i=1; AL+hErGQpcGuFkuVRv+t8L3IVR3ASQHcDNAbQPf8P8W7en0d36/vNNjE5LrNBDcvS0lL8y96E2Jc@lists.linux.dev
X-Gm-Message-State: APuU4Z8h22paZnXFqABntHmAOKAbkUC5Pa5KKF6W7Z8rtGqAxaWhDaAm
	Aj9Sw8cxNYkzqr3Rr95mDi7fi5Acl5milNk6e1VRFCBxzjY6swy0dTRohgPVcWV2fA==
X-Gm-Gg: AYBFou3b5tVT+gPo0CxIjRwKHT8x9VIdi8nNprzPKWB1DwVmJmtwRMR28KVOkiialhL
	C+s8To2nftwCVd960/CxW6ZojaIITjjNvtxKFyFmXNyCgM/ucsDr//gFkbOvtw35Gkxovn5jw3V
	derLgx4IYaceRzWkL5r/Ng2DXzyaugUfcl8Sx7GMF+BKROOVpnEPmNRabs92R204YmrxMdep2dB
	eDVIlC5rjQmNjUvLimnMDzgBJuGrx3lraVODan+TfzlQ2lRIbKA9ljj2985SX2mrenGHZ9NUucB
	PPYzUVDGcInTOIbDCI7bZ0PPvwyhfJwsp4US9UJvXWKLAUvVJrNy1VVs9i9IaTrN/5sULmBqzaH
	nTlVKKaKeIq4b1YJBOAxs5wkI2TjgnMDJVQKo2jMwAabq0tn8Nr5puhRCP8Vqx8FnifE0g5M1qU
	8WC2MMmNYZGD9TpySrRS5posu/StpwJZXLYcvOEhtS3bz2JARAyPvqSWAk4Lz+JKwYD7+YmaDxz
	b1VkL06ErNkMK3GZuMpob4wr1a1ClscS7I8CaZxu5BKWvrWUoLu9zbfjvnXES06OT0+wU2r6ggv
	q84y4BCA7AooPV7rFpJoLVDqgn3GhD/mcQDrsQ==
X-Received: by 2002:a05:7022:150e:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1b39fe7f403mr6653083c88.12.1794221589238;
        Mon, 09 Nov 2026 02:53:09 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:08 -0800 (PST)
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
Subject: [PATCH 4/5] 9p: take the tag of a flushed request from the request
Date: Mon,  9 Nov 2026 19:52:50 +0900
Message-ID: <20261109105251.2545764-5-lian@is.s.u-tokyo.ac.jp>
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

p9_client_flush() finds the tag of the request to cancel by parsing the
header of oldreq->tc. For a zero-copy TWRITE, however,
p9_virtio_zc_request() adds the payload length to the size in the header
after marshalling, so p9_parse_header() fails on the mismatch with
tc.size and no TFLUSH is sent. As a result, a zero-copy write
interrupted by a fatal signal returns without waiting for the RFLUSH,
and the server can still write the data after the writer is killed,
overwriting a later write to the same file.

Use the tag in oldreq->tc.tag and drop the parse, so a TFLUSH is sent.

This patch is assisted by Claude Opus 5.5.

Fixes: d28c756caee6 ("9p/net: Fix zero-copy path in the 9p virtio transport")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 66980ad52bca8..15bb939087165 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -477,12 +477,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 {
 	struct p9_req_t *req;
-	s16 oldtag;
-	int err;
-
-	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
-	if (err)
-		return err;
+	s16 oldtag = oldreq->tc.tag;
 
 	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
 
-- 
2.56.0

