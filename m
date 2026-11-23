Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466590;
	b=npmXAYabjhrAjZJinJCsYtc2p+8GYKrI1i6SBYwBfapej///f8VQsringYc35Za1wpQK
	 3+ujkynxvApjNr0+/pzzf4CCaQkgJFIBDCZgXop/gPg9RzUZrIrddSr59U1irBBMcWLqT
	 ngq5YCSp3dfmsSnio8W3KkF818XU6HZY5oe5mR6WAV+wWzJOvaR+AsV8vCNYdF6KN/663
	 WOijvNi5VkWaVbFtv2SrU5YV72+UG34Cz0RmXFMOsbiclau4TjSGy6o55kbVGcPyrjbA0
	 6XxcRmrequu31FohCXEAEuUjdAJKNZOQBuYsO/7ocYS6DIbJlA1mIsexELaDfwWtOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
	b=pyFKaKRWJnT7AmJcuuIfHz8BlwP98eBbjitS3iFfgZ49u8WzKzgANCcxYgqSwAUQ7jkq
	 D4Qzq5uQIOpkmnmntDN0pms0ldEGPCHCKXUOCeH2PNmC+3iUeBuwRTOs7h3MMGgGe5vuu
	 I28FW6n/G5/yDfczRnoo04Yzoz/euyIWPEW17i1soAbRb+rCqo9IBXQg4wW5UGYe7evNZ
	 OY/GAEjaMANeUXjwIJTStC/XiskIJNgcOConr+CKrwfFFDDGDgzOf8+YwNF3J4MZK5BGY
	 NOOgrhe0XzHJ2QD8u1/vVDbm8kXQg76Wbbw7veXJ5TqhjqPF485X5gSqyqa3VdHa8rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=To02+IGY;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC135606A331
	for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 20:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC135606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=To02+IGY
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so5336284c88.1
        for <v9fs@lists.linux.dev>; Mon, 23 Nov 2026 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466588; x=1796071388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
        b=To02+IGY3PJCYwMepQOvcQb+pnu/+jo6HrvKScUxgdmSpQ2urBw7YkkayWMl6y95b8
         3KnGF3qOOf/ZUZG6n2Sd7ZxALOoOqPUUyLo0xbGWn0MmxwEfUz/Nq40KEKHmtKWZpPKw
         mLzhhAUJyxrP961XtRYegmoyGTS9sPkmJSGrv7Z2gAxVNrDEy3Vjnhz6C5Sbi3igPZX/
         z2uzqLrrkrUmXEG9HEzT/jkI3yv9qzr2CBahxd0gKb+klmJvQSkyyXgslZvkJ3gr9LVr
         8bXrChPsj/e++HEkL0KIO+Qk9GinrediuuVtVM0U2vRMZIk8mYl0lJnXKkgrZd4IhmCw
         KVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466588; x=1796071388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
        b=u6snxNN45ZG3uspKeSPcvSwI26K+MmgP0SqwM/hFJrm54yqEQA4RRukJosB7k7Ugc/
         1d1BXWIO1rGC/J8MxYbYszAY6qqa0BYoT6CT4ThFYFwij6MPBRGckrz1zMgei+J4byG0
         OeAh9+/nsxkw5yiRm71onv6lPZ7WNFx/6xGEobsDm3IVCYuvndeqkPUMKeV9IfCE1TuE
         gxC9woymYCLdF9EZ3Z7SzzcegYWSqKllXQlNY3ST/CzrRmKrGTfRapUt7KW0stHsuAZJ
         aaSpuENrgdQMnuLWwyECf21SWLZANAmaFfD+ACYkT8EhwGIFEu4b1Eo8QCdKuk0RmQc/
         IlTw==
X-Forwarded-Encrypted: i=1; AL+hErGGF6RXdyE5BsuA9TWB/xtOTWOG8PLjBaC7B0kjl53WZ7s1pAzn7WH4UtYbThFSq2Nfm92r@lists.linux.dev
X-Gm-Message-State: APuU4Z/s/TRvfD814Rz0lN6v8Rj/fS9Cq0zCqeW8+/FuVXhpCoM2XoTF
	yScbfu/eZ1ROU/NDtGF0FTg2XtwpeujMw7BwTXds32icHMWE++ll3EykDKhoBqt3kQ==
X-Gm-Gg: AZFdTZdHFGez4L0wRenHRAKcrKOsEHG2tfcysY4Ejaf2BCs/Cq5Es6ylma7xaKePbiQ
	xVAsL3SEowcp5A0/vorFvQTrEVfKVCOLC8fKcILJma+xu8g7FVI37F7LtXqvIu5tMKYF7SfXcmW
	FYT3oL8mBraZTVeniFwHZv5J+mA8leUbOH6CDG3LihetC2BcruT3YsSwnsEI2aQMX3/NJ0c96dp
	9Uqc9xXVaU+8owaoG3w2Ul35w7wxi7yWvfP35tgG3Z5D4gbVQOGMYwz/LpX5bb0ATcuX+1eKUYX
	3rQTWj0kw1XsWVQLv1Z+k/57SiKz5FMf/JPVDC0LAYn5up3WEg0DetX2uxH5tpCxZxHQewYdCVe
	Urg++Rhcw6YTKp/nT8hBEQy8ShavHGl5MjhMLeCs0yWFB8cOGQvflP0OE3mP0/7oyJcuUzLNcfC
	L8IJAKTIcgsqz2VNnlZlkuzeqX1aUd2oy1CItAmfVJf7zXhn5MT2laGy8Hx4LSA9lJX7Uxwp1cD
	S6ZuKBda2J3wPyPpNguFzv8LTq6cZEoNtMRdHskLBoxZiC11MOt7pdoJxHynPE/eUfQxlTegfMk
	r+2b2bKVXVzYONwa1eKFo0MB1NL6pa6jc209vw==
X-Received: by 2002:a05:7022:b886:b0:19c:c396:37aa with SMTP id a92af1059eb24-1b5568e1d36mr11821108c88.22.1795466587986;
        Mon, 23 Nov 2026 12:43:07 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:07 -0800 (PST)
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
Subject: [PATCH v2 3/5] 9p: bound the zero-copy reply after a fatal signal
Date: Tue, 24 Nov 2026 05:42:55 +0900
Message-ID: <20261123204257.3055515-4-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal interrupts p9_virtio_zc_request() while it waits
for the reply to a zero-copy TREAD or TREADDIR, the device can still
answer the request before the RFLUSH, and p9_client_zc_rpc() parses that
reply. p9_virtio_zc_request() has returned by then, so the reply size is
not clamped and handle_rerror() is not called. p9_check_errors() skips
the size check for zero-copy requests, so it parses the error string of
an oversized reply past the end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff8880043f8009 by task zc9p/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0

Also, p9_check_errors() parses the error string from rc.sdata, where the
device wrote only the header, so p9_errstr2errno() can print
uninitialized memory.

Fix this by accepting such a reply only when it fits within the part of
rc.sdata posted for the header, and by returning -ERESTARTSYS otherwise,
as p9_client_zc_rpc() already does when the device cancels the request.
A zero-copy TWRITE posts all of rc.sdata for the reply, so a late RWRITE
is still accepted.

This patch is assisted by Claude Opus 5.5.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- Accept a late reply within the part of rc.sdata posted for the header,
  so the RWRITE of a completed write is not dropped.
v1: https://lore.kernel.org/all/20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp/

 net/9p/client.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a853df..e21d13e274691 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -707,9 +707,17 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (c->trans_mod->cancel(c, req))
 			p9_client_flush(c, req);
 
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
+		/* if we received the response anyway, don't signal error.
+		 * zc_request() may have returned without clamping the size
+		 * or handling RERROR/RLERROR, so only accept a response
+		 * within in_hdrlen.
+		 */
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			/* echoes to wmb() in the callback */
+			smp_rmb();
+			if (req->rc.size <= in_hdrlen)
+				err = 0;
+		}
 	}
 recalc_sigpending:
 	if (sigpending) {
-- 
2.56.1

