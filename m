Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466584;
	b=mC6aw73Ylliq7svRhG/ow83cf3Ru3RuX+702M69OrcDj4I2/V68xdNjhS0tdir+BfxjC
	 HF3nkkZs/099IBB3c7DsZIYmnr6MJWEmPRLxrmV0hXs6v6DZF5pVKy40XBVDvkZiQqDV7
	 1uwf1r025MkHOah2fm6qRXe9BK5ST/FhCoM+AquMlJwfqJG9HyfHJGDcWYoMixtElSVC4
	 VB1q3eVetWfu1dylQhy15Ge1hxse1G+F1uP6M7JO21wXXV1K//OP3uqaCYjXh8wJ5XMaj
	 YOne9qavIZK688EdEj3+8N9srnmNI9ED2Zp/pigXPEX/HA1t0lYTD2YgEslDDKxYnBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
	b=0UEOFTyChaESni7qHFTG6BFAZC+P/YIvKBpDOJnSiSFxFNTJ1T3AwLadZKbBxG82VBKV
	 n78Gt/DZBLgZYKfq365t8sTnylQ33fs3B2H2xH/BCLNOn6kAtbTuoMxh3eNuZMs/VeZEc
	 5+Zmps+cnaRvfkxAIIao5mcZRPNOpWBqfoQ53j8qXfAhvPcVwh/Lxe4YU++d+/yB1t8Qo
	 UHs52lRwJZ1wmyGZBbubEMvD84P4R5Z5+tIzCJkcOpb0Va1qCgbK6wukWPNZ7Mar2yyUE
	 +YUXwWjY4j/7lkpDIdP2wmVaV+GFl/7uCWZCcgui3Ng24xdPCl4fQv4t3Af1pdL0/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=JVU6HiUc;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85C606A327
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A85C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=JVU6HiUc
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso2918928c88.0
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466583; x=1796071383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
        b=JVU6HiUcVSEi1OO17HXC4v241g1CKRg7gA+uHjxyYsTvZjJft3udKMiKQm4qL9ARqJ
         fNfhd/hKtF4L3jJ50vrdbdwvWcX9t+JVm6Uto8J3He5dLPkDpWfb9eM8i+Hu/EItbLoI
         2ayFL1yHAv6JkfTa4m2H2+mEmwUv3fomjEVHu4iRD3nXP+3+lTC6ba4ivP5swHuJ2HTR
         0CYZwktuYOw7RBGfP7DuqOxAgqFyE4xn1GJJDpeAYmCKdzrzfK5X8RLCBUXJOkvef4HK
         vf2j2LdpNQZsHYNJNsNI6wQnRp6rjSopNXAwzPMolOLsB1ZQ4ogxn+0sM5kO0QpiatA/
         BsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466583; x=1796071383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
        b=la+3GQZF0pIJoXzgMdR2NP4O3+/THrkVMVArPMs5EYLktmTGfF6FYE6aSC7LQZNsy2
         7A+gpMT1JVy3cTRXkMjbGV9tyRoJPx9G94JJaP+NM9CM/stmvH+S2kniFjKreRZQ/Jmd
         PtNdZMoQu6hNoi0ejrLrrofahbGywN6esbMTJElnJWd7xU5XA1nxtEwVAmObKO3Vqa3P
         Ln70mBA+ngiohvp4PIAxpzNWZH+NTR2VzOwNoCJ+Wwp91qNzq+OxqR5vOFlZnNyruvCC
         WO0mBZe2YXn1wVxbBYC/lt2EOznjG9nTSdC/5idTDbGvLvnAUXe95p/xiQKq8AHRroA9
         BANA==
X-Forwarded-Encrypted: i=1; AL+hErGRW6J+HcpxQmkYIuODtv2/EUH8YbzdWzziopggYzZEYdlg3z/WMmeHBQaHmIFqAKheT+kl@lists.linux.dev
X-Gm-Message-State: APuU4Z+LsIq9xHhdhTLjvD4bxUawMMiMCo2geae6zggPJ42kSBv20ZIf
	dWZNB8bkHq+hKg1+RH+bvOhf7gWTBIr8Em3d94EQsJdOjJQfVQAQWxZndfC7FQWLaA==
X-Gm-Gg: AZFdTZdblyrC/XrMacAW0uclWxWC81N2czLfxFJfKXFVgfmonel/4IJ7NlnxXSZMgAz
	XyVN6hzUEF1BkIoX/SCN9Mv60AT8kb+5G1F3y2YvrV7GmLt+xqPtNh5vL9BpYIqoJYbdirOILwu
	XxGh4GI/B0hXHuioJwumxb6WcXEUUC3pdLR1EieQVP+etYc5uYwyYs4mGIZXl9yE2nLkg2Rd3m4
	/k/QCJbAb/0t2lu13M9ojSZP8rC7tkJ4slvZ3K58E6vhDqB/21PRvm3URVKowhwd+4wRmB0hq+D
	Elm0DVjkt8ELN15Kqt+wH7V1Oa0vr5y7sXEzkkqzI3JC2VhkkEZXF1TiCqWngejBKnrapWV5YT6
	/vTYCmG+9kws3ZyN7T4J9hzlui6xJ8EmiJcO4aemrVWxmTKYgkovrzcahQF5+a92VKmmhs+JWyF
	wZFhVPclrkGVhKKiA4txHhRnR7fV+7IqxkUjr2EdWyeXBmwxWLnWoJamKYFaI+fjY5KW91HzqwA
	neUq8LgPmHHIk3KW/mVfK9OkypC8HEQ7ZtBLWKMeuO18tIHh6Kte23aqGv6zb4BSgCcli3vojpb
	VIlWExCScGbVExJDXxGaF4xDanBVeR4A4x6blw==
X-Received: by 2002:a05:7022:b0c8:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b556911007mr11278105c88.34.1795466583163;
        Mon, 23 Nov 2026 12:43:03 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:02 -0800 (PST)
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
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] 9p/virtio: clamp the reply size of a zero-copy request
Date: Tue, 24 Nov 2026 05:42:53 +0900
Message-ID: <20261123204257.3055515-2-lian@is.s.u-tokyo.ac.jp>
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

req_done() takes the used length from the device as the reply size
without checking it against the posted buffers, so handle_rerror() can
read past the in_pages array when copying an oversized error reply to a
zero-copy request:

  BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
  Read of size 8 at addr ffff888002ee02c8 by task zc9p/155
  Call Trace:
   handle_rerror+0x144/0x230
   p9_virtio_zc_request+0xb8e/0xd70
   p9_client_zc_rpc+0x21c/0x970
   p9_client_read_once+0x237/0x6c0
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff888002ee02c0, ffff888002ee02c8)

Also, handle_rerror() returns before truncating the reply size of a
zero-copy TWRITE, which posts no reply pages, and p9_check_errors()
skips the size check for zero-copy requests, so it can parse the error
string of an oversized error reply past the end of rc.sdata.

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
v2:
- No code changes. Reword the description of the KASAN report.
v1: https://lore.kernel.org/all/20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp/

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
2.56.1

