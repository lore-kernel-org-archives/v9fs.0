Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466593;
	b=Rnd+BhCdmAocijC2ZcMV8UtibnUPj14fe4ifL8wWT4KM7GbJWGSRit8sCh1WOpWE5Y8B
	 /SJeRySxxoAm9m/G8RW2PUofOZo6QOwnhcP7nxk6RhBiLB70UmLPNm4Zw8QMcUzYFtuxp
	 KeNi/zu7pjJSfuwu6R6rnreeARgBouYj1Ih6IX8Bvy070YuJmYjavNXXb99rJ65aIA4F3
	 CULSGSuRCC4ChNgg73PZOccd32kF/Cukbe8wNN5CaDvPoqPM8o5jsZOLhqiPGISGSm/55
	 ZVOd9vY15sT8nLJdk4HI3SAPONCeE5Qm8Rw0s3Y6JDHsOcvdZgQ7oeohUl7LxOSRXgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QtiZhwkGYCfkjpfowIk4zYjE3fkt+c8PM5KV3KV1qLA=;
	b=jWpu1nQpYx+clR2/b9zZ+zGdtWCYffHh/whdJEez7uGUR9goqvvIiTNSqq1IeT4jl+gr
	 +Fp1hRkLdsIuxJBk6c4PxLpnri/0mkexANVFe5VTLA/9e9hqLDKiGgt4V3SXyk/eAvuV3
	 RccGc9Kup3iu/zNvR3f2ikLNb9nmxsoHYKUjWwYxhG50JNmDq1+RR8f3wn8tSo5R+sMa7
	 CkiH7+zg2ZGHX0XDGOEvlXWWHzG7yzkg5/ZctYnliDvIoliVm1/TN40sRvVKAIM3zxWE9
	 3UfvVqmZi6/iWE0QdeH10hQXr2axqeHQf/SU9bM4fZ762QqXqjG2LuVj92oW83JyAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=tJ9Ljgdx;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD92606A32A
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD92606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=tJ9Ljgdx
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3acec6677so5336380c88.1
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466592; x=1796071392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtiZhwkGYCfkjpfowIk4zYjE3fkt+c8PM5KV3KV1qLA=;
        b=tJ9LjgdxfDFkqhZpmLAgF+8PU/nBPAj5SR8YXOz6TvID2p1xjL6RXi4R3CAqShMZiO
         fcaDshqB90LCYgfEIW47NHfVO21SozshUt8P8zcbfbUED7ui2bIrGa3sn8c2EE6gD8W3
         tOCvpSaiPLAR5T1fFQD1vEj5vjimcIK/e7nA3AnZUFHn6okTo6S4QG9u29Ih1ClvyaAE
         PtjqBuY+RjS0dHbbdibIHJq1s8BMoNpkFOjC7H0j0LnKndvFxdp863jxZw6l2M7a6/TS
         tIKiv0CS7IJRQk1EBLgSSkgNPjLTn5SBuL/fGQkHnKUFxfxZ1U9pTgrtApPcZQMSmtZv
         Xgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466592; x=1796071392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtiZhwkGYCfkjpfowIk4zYjE3fkt+c8PM5KV3KV1qLA=;
        b=NPB+PHDp2NaIJ/ETIpWm/YlL8+hBirtT+pJj6VDSxWA0INYqsQYi9xaFmv02jy/kZg
         FvLSApY08Jz52YKsNDUbC/FclBrehKBKf9POG7n25/WnAZXA5yuvSgQAHehcstNvKLCf
         1dQXTElbNVMx1grBciChroSrHKTA31ZJGXUrw9U8Ip2uL6lA+7dd37WYawtN2hUfEoo3
         psENVofPG5ECxysWJ3nQpAtF+4wigxVkRzvlbiN50DFrUphl4mHxaOBbdIA3qLRhpfw1
         CYZlhMhn01Bg8pPaeEFeeSsiiPxV71HtCzs4r4qoQOvCsqmEnNqP4os8OfTGZvkMS031
         81DA==
X-Forwarded-Encrypted: i=1; AL+hErHZxoM+GzCbuhIYKyuU2Dpsjxwnyvb+6vGWQNMUU0DgcJcnTXIr6D5Kp/JbFuxLeQ6DliSX@lists.linux.dev
X-Gm-Message-State: APuU4Z/TC7Hyv9MwYWaWYwnqcYYadfMaYZv6AjhHTHMHJhyDrfxHIFtW
	pPhe03Sz5WIH7YPvRqYGZQs2wHdZUWpfDXZWxPHWQYhfLIS6TpgatjajBX6oetrQwg==
X-Gm-Gg: AZFdTZd+buSluI82UfHKYGhZyMAvUWdPAyC0ptU96Ojv+2mYemKr3/7yaI3t05LUZID
	p97R+NOCzcVAbwUEnacLuvgyj1r7My0csYPQH0+01rHXzXLnI68VQkiJYsqULTechwuXqYKchjA
	1E/+qBy+/CI3ZohXEgS4Mvry1JFGgdY0a8Z8CFT0EzzfvjKsc2GQOwcefSfkOPgjsZHUyMCQQEh
	uqdzSS8BU1breLp8uyaeb1ibG7b6fIasGZkQzfYPcIWJPCM67lkT2+jQP5H18Cb2Wpc2jx4aMVR
	Yj0meyq+ocoKgmAmay0pBr24pNru4Z5A7N84HYtwDqCHEeRvzmgDO+9imKNKyRFTRtBHuJNkuaW
	uEUt6PYlyOGz66+JApOKTh5uuNstsgpG85Bl9x2bD6VF0REh2Nfpmwpu2VUCndvz2JEsol5k8zu
	z2dfn+YlNzj4FEDn33J2ILdDmXfMUP5zDY+a6WwjAiwU4K4DmB9UYWI5C/YHQMOP1czIenm3C9u
	GK/FFe7CO97PWhqZvfgf8AWqXj2vfFtx0TyryZJ0GmSPzYnI+80KCVDYqTEwoX+BwgeninP0laR
	w3E6YUcy5f0YUUqM+Zkp/PGxvvP41C3/+/Z4Mg==
X-Received: by 2002:a05:7022:ea8d:b0:1b2:373c:997 with SMTP id a92af1059eb24-1b5568f3c7bmr11869653c88.25.1795466592370;
        Mon, 23 Nov 2026 12:43:12 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:12 -0800 (PST)
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 5/5] 9p: initialize ecode in p9_check_errors()
Date: Tue, 24 Nov 2026 05:42:57 +0900
Message-ID: <20261123204257.3055515-6-lian@is.s.u-tokyo.ac.jp>
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

An RERROR of 9P2000 has no error code, so p9pdu_readf() returns at the
"?" of the format "s?d" without writing ecode, and p9_check_errors()
prints the uninitialized value with p9_debug() when CONFIG_NET_9P_DEBUG
and P9_DEBUG_9P are set.

Fix this by initializing ecode to zero.

This patch is assisted by Claude Fable 5.2.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206901@kernel.org/
Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- New patch.

 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e21d13e274691..482be6f375234 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -400,7 +400,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 {
 	s8 type;
 	int err;
-	int ecode;
+	int ecode = 0;
 
 	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
 	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
-- 
2.56.1

