Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE23BB123
	for <v9fs@lists.linux.dev>; Thu, 16 Jul 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187111; cv=none; b=CHLhhv3XNX9aCIAP8aWAGNhMRAaezhFiLykaIXPbhLddWyf2aTmRRYxdCXKlec+eB94WPjqzpCPlLqeEDUwckdO3s4pAaM3IGci6oZtS/JYuT9jn+gxCqN7n7mFdYhXhMqj71DQNv+djqdxwgQir3lLz4FYM/JGYKlwUJhTAe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187111; c=relaxed/simple;
	bh=wvOTet2COjQxObQt2JQi4y7BKSVg+1xPLpR5TuZYq+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrZ0HzUt1Glw1m+OPzwOaOfA+d9+fJgi8yvD1aeNw2ugZGCmOPPv2Zq6OBffHMlzahGN9iVxtBmXX2bYZgrt8SqAcYDh5SL1p/RFM6J1ol5FJvsS5KDoeii5/0yZusDqRzD/I1JZjTpScFSdHarR44q/5sqnfZcbUlgJsXe6scU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6269a1c280e811f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:08c1430d-7250-42ec-9231-691bd82a05d5,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:08c1430d-7250-42ec-9231-691bd82a05d5,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:559c1f64010f1d2917c446ad2bb6711f,BulkI
	D:260716153142MPI5CV9J,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6269a1c280e811f1aa26b74ffac11d73-20260716
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2133234266; Thu, 16 Jul 2026 15:31:39 +0800
From: Ze Tan <tanze@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze@kylinos.cn
Subject: [PATCH v2 3/3] net/9p: abort interrupted fd RPCs on fatal signals
Date: Thu, 16 Jul 2026 15:30:51 +0800
Message-ID: <ab39e9af6d4d3d31f9f4b4a85c17c5b905f7e4f8.1784186316.git.tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784186316.git.tanze@kylinos.cn>
References: <cover.1784186316.git.tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a hung task while a thread group was dumping core. One
thread was blocked in p9_client_rpc() on a 9p fd mount while another
thread entered coredump_wait(). The coredump path sent a fatal signal to
the blocked thread and waited for it to exit, but the 9p client sent TFLUSH
and waited for an unresponsive server to acknowledge it.

  INFO: task syz.1.4497:22259 blocked for more than 143 seconds.
  Call trace:
   __switch_to
   __schedule
   schedule
   schedule_timeout
   __wait_for_common
   wait_for_completion_state
   vfs_coredump
   get_signal
   do_notify_resume

Commit 6b4f48728faa ("net/9p: fix infinite loop in p9_client_rpc on fatal
signal") stopped retrying an interrupted TFLUSH when a fatal signal is
pending. The original non-flush RPC can still enter the TFLUSH path first,
which needlessly depends on the server while the task is trying to exit.

For transports that explicitly retain sent requests across an
asynchronous abort, cancel unsent requests as usual and mark sent requests
aborted without issuing TFLUSH. The fd receive or teardown path keeps the
request and tag alive until it releases the transport reference.

Do not enable this path for zero-copy RPCs or transports without the
required lifetime guarantee.

Fixes: 91b8534fa8f5 ("9p: make rpc code common and rework flush code")
Signed-off-by: Ze Tan <tanze@kylinos.cn>
---
 net/9p/client.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index b9860ccb224b..47353cf0750d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -538,6 +538,22 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return ERR_PTR(err);
 }
 
+static void p9_client_abort(struct p9_client *c, struct p9_req_t *req)
+{
+	/*
+	 * A fatal signal cannot wait for TFLUSH, but a sent request must keep
+	 * its tag until a late reply arrives or the transport is torn down.
+	 */
+	if (!c->trans_mod->supports_async_abort ||
+	    READ_ONCE(req->status) >= REQ_STATUS_RCVD)
+		return;
+
+	if (!c->trans_mod->cancel(c, req))
+		return;
+
+	cmpxchg(&req->status, REQ_STATUS_SENT, REQ_STATUS_ABORTED);
+}
+
 /**
  * p9_client_rpc - issue a request and wait for a response
  * @c: client session
@@ -617,6 +633,15 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 			goto recalc_sigpending;
 		}
 
+		if (fatal_signal_pending(current) &&
+		    c->trans_mod->supports_async_abort) {
+			p9_debug(P9_DEBUG_MUX, "fatal signal: skip flush\n");
+			p9_client_abort(c, req);
+			if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
+				err = 0;
+			goto recalc_sigpending;
+		}
+
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
-- 
2.43.0

