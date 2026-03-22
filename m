Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D37175A80
	for <v9fs@lists.linux.dev>; Sun, 22 Mar 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774178352; cv=none; b=jsbd4iTTv7PK8vz33X1LIhkeJDSdxa6oB0z+1NZ2oHv3/Uq+MLyrndwX8Kuy24LbFhbWKrlTDTS+d4lhDnWwuccEaMs/tmQ5fuIv6snFV2UDYnrrfV1biXOdxUepREjw3F1+XEarO1nNGpDnh6YM6Yucm9g2APyad7kZKfo/Ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774178352; c=relaxed/simple;
	bh=a4OneQuk562HQPe43TEMpcXX38g4+4czxvfIH7fmsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=BE7KTDijvNQdSp7vK1KyAoTm8knIFk2si+0K/Y9zsww0Fld6TXVbLIUS2lo+toolgYjLJF438S4al20In7kdkEbqPXJXeU7ty0DHj0xg5xDGyBiqYCFRCgLMVU+alIsBqlKeZEpuauBNxHKHlPLxQ9vckxbTeXxe7tjxSIQqZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MC5uJnNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC5uJnNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774178348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Ji7333s+3Gv2Csfphv4Wte2Ssxb62LRHJq7IxSIvYA=;
	b=MC5uJnNNZ8aFHJLWTaRci/E8L58g/KPdf6YpJJWLvjPMecMwZdO9gZabwOBoPVOQ147Quk
	1zxmceaIpzxIakg/MzbuX3rt1i7wLks9Ckb5eU8LJXNtEmkK7Rzy9QlbKC/IGDPwVY7ODq
	a8LB86bspUZ4MlFPYKxHZZPNQ3YY0uQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--p6LKQVUMBS9DLYdZT1fTQ-1; Sun, 22 Mar 2026 07:19:07 -0400
X-MC-Unique: -p6LKQVUMBS9DLYdZT1fTQ-1
X-Mimecast-MFC-AGG-ID: -p6LKQVUMBS9DLYdZT1fTQ_1774178346
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b079b4a8c3so253618235ad.3
        for <v9fs@lists.linux.dev>; Sun, 22 Mar 2026 04:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774178346; x=1774783146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ji7333s+3Gv2Csfphv4Wte2Ssxb62LRHJq7IxSIvYA=;
        b=gP1Yp0rCmCY0vYcA1tFZhLQSkaGoInp0C9+cUFSAKHr4ENBs1sQqmJur4hc7Y2LUHh
         /FwMiY/51/q24vu0rYHYTTWjSHieOgSiAw16//gsI9Y9Y9y+pK7TKRsDK0cG+0qfHMf8
         rXGTMaD0wcvfbva7X2YJwRVt3YtsG3jFCO0ZeY9ER15jGPfJScF/dPqYkn+OiuOS++ye
         CMj5MUrEuGq+eJQJBix+uzmST9B1qSnV09ZulL3S/PmYDkpckQB0A/yZYqiZBPNJOEHl
         Xs2y03GxfYhtjCAKgHTuwxSo2sNUunPBqCHpoV9jRCDKlTLHK8iEgUZE4GfkVJY9kBir
         z7AA==
X-Forwarded-Encrypted: i=1; AJvYcCWLFvxeyQi/3NsNJW4XQNxvPQdu+5ApF63lcsQyaxte0h+S8XDHPrJxGFS14enxfhjnCqAV@lists.linux.dev
X-Gm-Message-State: AOJu0YwliTh1fqtfx93CuGO5mRonqD2wQbJ/AUf/+rEip1cf9iVciOYd
	vcivlzFJRnpphFNIDMCDV72o2/th5EnQHIUKik2ZqHYbjtWsLiuKl7/kfQN1njpG2sg+JQvKuzp
	UO7mI0OqMr+ZuHe0oSUg6UattlekJnzE+hAFCeGJqA4pVvDU+KGL6sRc=
X-Gm-Gg: ATEYQzxgAqCnf4by5qOi5sLvE56YS+BlDz4KiI4u4KWzjWGkOWkidEHB0jMwfEfThx0
	xzRHO0Js+93ElatMIwdOHNKYLMlDwxCPcuDEYxBk9Xpw088ylIQz+4efunagePRy15RDRaUUdwY
	q14Hkpr3N/mlKX5rbI6yHJz5VlzQFiMcYwUkuZ6BDxrKUb8XbNLHWl7/6sf368UopfDKe6QseDE
	nyDJeQH22Nkg48kAy/MW15H/THezlly5gP3DeWmM8scbDvJrsOnUvAvdH1uDNUdgRwdtUaNjatb
	3tZkCvDO8XH6JoGzudQF4pZdAQxUzWiBPpU84+faO0IvKeA85Daeox0hlb9voK/2xRT1DCnRCV4
	aCU3yg/RG4tmdsJZ61QyhkE/uKdPwvYqjWezlKKoUDMyX/Q==
X-Received: by 2002:a17:903:32c6:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b0826d7421mr88536755ad.10.1774178345913;
        Sun, 22 Mar 2026 04:19:05 -0700 (PDT)
X-Received: by 2002:a17:903:32c6:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b0826d7421mr88536605ad.10.1774178345560;
        Sun, 22 Mar 2026 04:19:05 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836744a5sm76174955ad.63.2026.03.22.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:19:05 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Tuomas Tynkkynen <tuomas@tuxera.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: don't ignore fatal signals during flush
Date: Sun, 22 Mar 2026 20:18:47 +0900
Message-ID: <20260322111848.2837057-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hADcWrp1eH-YFzpte3OtSdMTDZ7haRlAN-UEhsGiBEg_1774178346
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a 9P RPC request is interrupted by a signal, p9_client_rpc() clears
TIF_SIGPENDING and attempts to flush the pending request by calling
p9_client_flush(). Since commit 9523feac272c switched the wait from
wait_event_interruptible() to wait_event_killable(), only SIGKILL can
interrupt the wait. However, the flush path also clears TIF_SIGPENDING,
which prevents subsequent wait_event_killable() calls from detecting the
already-pending SIGKILL. This makes the task unkillable.

When a coredump is initiated by another thread, zap_process() sends
SIGKILL to all threads. If a thread is stuck in the flush path as
described above, it never exits, and the dumper thread waits forever in
coredump_wait(), resulting in a hung task.

The same issue exists in p9_client_zc_rpc().

Skip the flush and the P9_TFLUSH retry loop when a fatal signal is
pending so that the task can exit promptly.

Fixes: 9523feac272c ("net/9p: Switch to wait_event_killable()")
Reported-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/9p/client.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f0dcf252af7e..28742f19041e 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -599,7 +599,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	smp_rmb();
 
 	if (err == -ERESTARTSYS && c->status == Connected &&
-	    type == P9_TFLUSH) {
+	    type == P9_TFLUSH && !fatal_signal_pending(current)) {
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
 		goto again;
@@ -609,7 +609,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
-	if (err == -ERESTARTSYS && c->status == Connected) {
+	if (err == -ERESTARTSYS && c->status == Connected &&
+	    !fatal_signal_pending(current)) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
@@ -694,7 +695,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
-	if (err == -ERESTARTSYS && c->status == Connected) {
+	if (err == -ERESTARTSYS && c->status == Connected &&
+	    !fatal_signal_pending(current)) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
-- 
2.52.0

