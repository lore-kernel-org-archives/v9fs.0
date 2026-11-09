Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221584;
	b=Zh6eJpplIpGDrWrAbOw3b84BLyWEnpFymKT35/UrzDWkRl/LgPjPZ1hK2jYzAqGKY7/R
	 m0lhXNMHZ0ULnYHMxwsuyYKuQPVxLp/iwurOiVlrLRfnbEkOxt8QiRbywLjCCV3D8QKNI
	 O6dQd47V7G8ZMcNQeuyt1p0d7aj1Le5EiVAwIfvQnlG7zkMgRzUHNppF4XzVSqESC6i5Z
	 mf9jK/V3TX7HVxOOTUzH5MJDwzdT0jo98l377zzaPda1S6DlO2na/gS8VSvZNqhJbo26o
	 3Ay7NajpBor6egLTXwtM/vehiUyvl6IzJVFP3VKegRp0dFqug917753jzd9bG03TGWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
	b=J3gWLz31JJo2h8DFawLIsE0onHIGLmMpr2IJ4N/Hpy2kvQOVeAO05X0kevKFk0SdvVi3
	 oaLhmiYA79rwAZCSwkFqQdDZ+OkO+Ok27PNZGP53mFWnNsya13F+Cks+DxjlLKS68MCG7
	 oQhVRq3jg4ajfg0DX924B8n9uZvbKCc3fJYmU4SMd4TWjb07MgKciZkNVvSTs06ejEBQX
	 p0543WzM4qDxQCSsETYTkjbG1CJJ5yLPKHdEw8NNO72h2da/CxKyF5XEgs738hNYHxToH
	 aHsT+xojG8ZJhOiBbjtk283KJ2S7J/lk2XEYKEPsYVUoC3MSO0eg//9BgQ/OEqUGbcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=hwm+cKB3;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4A606A325
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 10:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA4A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=hwm+cKB3
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so1008401c88.0
        for <v9fs@lists.linux.dev>; Mon, 09 Nov 2026 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221583; x=1794826383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=hwm+cKB3estAmpEPvhPZedvckSQC05R6rZk1SGcrpuvfC9mzlXX6DpC/80WPDlUnND
         0xZjO9Bn/1V25f54PG99bTHLkOgacaoJ3nSpXdqetHiWbKrQCugAvQoR5kwI97DYkZz7
         i6uu0ypiqyuAL7fE0NW8GTArAHBxmIf3Y9xuWWyFMnSAuBd8WotH6yWRLUqO/Nt3O71i
         pz1AfaT6y9HCOqAch9+6z05k12eVbwP0qCeh4YZYA0UfXn8L7NPVZP/lyt/LTwiK8itQ
         ywr4dnFVaXWGC80QWVuQBAAee3mv6mL8y73zHHjN8I4KWcI2fl24eta07ZxmzLSkXSk1
         fcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221583; x=1794826383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=KiOCxbabcWG9VQE+2RB+TkpaovfZF8X7JfWvxpbWha2gZ07Vxjv81KPBUf5k70SqyE
         gUUXDbX+KTs9H16Ow9vdZibcaXbH9ZoEdhHlJPcR8PaRWbLcVvjAVFU2l+fnhXtznXGh
         ZXU/dlUM5zY+P45/EeH+Zw4/PROrRNLbF3AhPk/Hm3FrYFGEN16v4YuvbGJQ2Vdb0Wdf
         Wea3MIJDoUBPd2dBK/SS2EFVHbAnklHY1qvU6yWr1q19b6tiUnLzS08g4Yiq9ip/Ap2Y
         rXRDh1LaJdTx+VpxBonAOVxisrZJfjbz/jBMjSBMedroUT1s3KHd2dmOOtEUZLcoB3iT
         R7EQ==
X-Forwarded-Encrypted: i=1; AL+hErHDa0eIY0Aq+zS6Y7scCtBqD97vfgv4JppdwJsbwzsKDulE8V4kbwCR+ShpM3w8GKElm+Fu@lists.linux.dev
X-Gm-Message-State: APuU4Z9bCljbv7KVcXuSgjfciVa5lbRIrFCEUHSsRee9MS/q52vW6E4/
	UloqAKs6vyFi7vbWx5+5p/DhPByq8y28/tRS0Rh7K4Beh34MxOdSUaY2CWEsZIr3kg==
X-Gm-Gg: AYBFou1YBbDdvKNI+RXSNTlx+SCygVQ6lNftASW1Xa2YGas1IiRGNszZC7v9+pwdyC9
	Fs9nRRtI/blRA8jYRYtFzU6sPtZFXLbJhFJVQRKDvHiOJLM/6ashLutxbjbyqkm3k6t0vB38S8d
	IXJEP18XvkO41tUX2mwNhHMWaYc/4E75rA0VaNCj3GeuCP0OARq11KI45J5szkY+EG91DclI19y
	iltvwaRTh3a4qORnLD34kdi/dm0r5omQAGz5veO4yPLCkLQ9iBMGMSgbWqMJsZ1DdjxYATlKhwO
	qP2V1oA9Mtsff4tihSpXwZgELUvNk1mtAWbHaU8YHvHMxPleB59r70EOFMM5azmrjruAZ8B7fw+
	JEkMf/iDd6wL/lsrtlDt108ASnNi+xAfrRpwlH9s4xC9T2ENqr1Ht800tBVLdPcZtwleuEaaAAe
	oYGmR8dgJZlnINx4ibpaHfmMy8lDpOocZ5JPXGkpr3hKcut2f+06arNZIHQmozlhTEG08zsShZw
	3kbmeNsRac4NpQqZZV0Daj+Bcobc7cAHy+gLQT251NmkkSUrTd4CaD9wh3G1iNByFeI94TzrcD0
	Gup11gd+14pAT/J4vhE+xfCrkuBAcsM2J+yVMc3mTEqPmdXOqUpR7KIQgQeL
X-Received: by 2002:a05:701b:2214:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1b39feda859mr6171128c88.19.1794221582983;
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
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
Subject: [PATCH 2/5] 9p: ignore a zero-copy reply that arrives after a fatal signal
Date: Mon,  9 Nov 2026 19:52:48 +0900
Message-ID: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal ends the wait of p9_virtio_zc_request() for a
zero-copy TREAD or TREADDIR, the device can still answer the request
before the RFLUSH, and p9_client_zc_rpc() parses that reply.
p9_virtio_zc_request() has returned by then, so it neither bounds the
reply size nor moves the error string of an RERROR from the reply pages
into rc.sdata, and p9_check_errors() skips its size check for zero-copy
requests, so it parses the error string of an oversized reply past the
end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff888004724009 by task zc9p/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0

Also, the error string that fits within rc.sdata is parsed from
rc.sdata, but the device wrote only the header there, so
p9_errstr2errno() can print the error from uninitialized memory.

Fix this by ignoring the reply when a fatal signal ends the wait of a
zero-copy request, since p9_client_zc_rpc() already returns -ERESTARTSYS
when the server cancels such a request.

This patch is assisted by Claude Opus 5.5.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a853df..66980ad52bca8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -706,10 +706,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 
 		if (c->trans_mod->cancel(c, req))
 			p9_client_flush(c, req);
-
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
+		/*
+		 * err stays -ERESTARTSYS even if the reply has arrived, since
+		 * the transport moves the error string of a zero-copy reply
+		 * into rc only while it waits.
+		 */
 	}
 recalc_sigpending:
 	if (sigpending) {
-- 
2.56.0

