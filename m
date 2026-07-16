Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A943B895E
	for <v9fs@lists.linux.dev>; Thu, 16 Jul 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187107; cv=none; b=LzJx4pqyZuBGfvIEH2DYUBEQvz5/X/YrWUJiqgJUF85SnLrMWI6aB4wI0SdxPk5/Ox6xdMt9LKmY1KJLaUcI1kUHBxtmM+zPgMUoItulwNpdiRJHk0q093dZKO0BkLiEYFrc2Ef8BJ3r7ePdj+3uncIwn4dmLalRpsrNLiBKXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187107; c=relaxed/simple;
	bh=MyByETTfMejsFg2h/7TBNRF1/JzJWW5gx3cnCd+bm6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMEUc3fY5v/aWIYmq3CGEa1Z6LTocxDQt0V28Mg6sI4sYqG/nL+19LYazakm2edHvKAorO1o/dpXiNnqKAixX6mozm6FNYR0mOK7CoK4zx5xbGzBpcf4fP4x93hujJvmoyhpFQU0TWOA3j8RJV4wvXBjy2pkSK8b/T6vs8pVWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 620d7fbe80e811f1aa26b74ffac11d73-20260716
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
X-CID-O-INFO: VERSION:1.3.12,REQID:fa48a989-bdec-4bf6-9678-e5f6ac5a2b58,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:fa48a989-bdec-4bf6-9678-e5f6ac5a2b58,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:dca8558546fcef295ed8be98c05a617d,BulkI
	D:2607161531394NT1ASB1,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 620d7fbe80e811f1aa26b74ffac11d73-20260716
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1490481796; Thu, 16 Jul 2026 15:31:39 +0800
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
Subject: [PATCH v2 2/3] net/9p: prepare fd transports for asynchronous aborts
Date: Thu, 16 Jul 2026 15:30:50 +0800
Message-ID: <01635c2204d8181058bb808ff4b13df52df98a16.1784186316.git.tanze@kylinos.cn>
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

The fd transports keep their request reference while a sent request is on
the receive list. That reference is released when a reply is consumed or
when p9_conn_cancel() tears the connection down, so the caller can stop
waiting without freeing the request or reusing its tag.

Add an explicit transport capability and teach the fd reply path to
consume replies for requests whose caller has aborted. Leave the capability
disabled for transports with different request or DMA lifetime rules.

Signed-off-by: Ze Tan <tanze@kylinos.cn>
---
 include/net/9p/client.h    |  3 +++
 include/net/9p/transport.h |  4 ++++
 net/9p/trans_fd.c          | 10 +++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd25..700dcb37c1dc 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -58,6 +58,8 @@ enum p9_trans_status {
  * @REQ_STATUS_UNSENT: request waiting to be sent
  * @REQ_STATUS_SENT: request sent to server
  * @REQ_STATUS_RCVD: response received from server
+ * @REQ_STATUS_ABORTED: caller stopped waiting, but the request keeps its tag
+ *                      reserved until a reply arrives or the transport closes
  * @REQ_STATUS_FLSHD: request has been flushed
  * @REQ_STATUS_ERROR: request encountered an error on the client side
  */
@@ -67,6 +69,7 @@ enum p9_req_status_t {
 	REQ_STATUS_UNSENT,
 	REQ_STATUS_SENT,
 	REQ_STATUS_RCVD,
+	REQ_STATUS_ABORTED,
 	REQ_STATUS_FLSHD,
 	REQ_STATUS_ERROR,
 };
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index a912bbaa862f..93349fe33dff 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -34,6 +34,9 @@
  * @supports_vmalloc: set if this transport can work with vmalloc'd buffers
  *                    (non-physically contiguous memory). Transports requiring
  *                    DMA should leave this as false.
+ * @supports_async_abort: set if a sent request remains referenced by the
+ *                        transport until its reply is consumed or the
+ *                        transport is closed
  * @create: member function to create a new connection on this transport
  * @close: member function to discard a connection on this transport
  * @request: member function to issue a request to the transport
@@ -55,6 +58,7 @@ struct p9_trans_module {
 	bool pooled_rbuffers;
 	bool def;		/* this transport should be default */
 	bool supports_vmalloc;	/* can work with vmalloc'd buffers */
+	bool supports_async_abort; /* keeps sent requests alive after caller exits */
 	struct module *owner;
 	int (*create)(struct p9_client *client,
 		      struct fs_context *fc);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index eb685b52aeb2..d5cff8c2c88c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -293,7 +293,9 @@ static void p9_read_work(struct work_struct *work)
 			 m, m->rc.size, m->rc.tag);
 
 		m->rreq = p9_tag_lookup(m->client, m->rc.tag);
-		if (!m->rreq || (m->rreq->status != REQ_STATUS_SENT)) {
+		if (!m->rreq ||
+		    (m->rreq->status != REQ_STATUS_SENT &&
+		     m->rreq->status != REQ_STATUS_ABORTED)) {
 			p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n",
 				 m->rc.tag);
 			err = -EIO;
@@ -332,6 +334,9 @@ static void p9_read_work(struct work_struct *work)
 		if (m->rreq->status == REQ_STATUS_SENT) {
 			list_del(&m->rreq->req_list);
 			p9_client_cb(m->client, m->rreq, REQ_STATUS_RCVD);
+		} else if (m->rreq->status == REQ_STATUS_ABORTED) {
+			list_del(&m->rreq->req_list);
+			p9_client_cb(m->client, m->rreq, REQ_STATUS_ABORTED);
 		} else if (m->rreq->status == REQ_STATUS_FLSHD) {
 			/* Ignore replies associated with a cancelled request. */
 			p9_debug(P9_DEBUG_TRANS,
@@ -996,6 +1001,7 @@ static struct p9_trans_module p9_tcp_trans = {
 	.pooled_rbuffers = false,
 	.def = false,
 	.supports_vmalloc = true,
+	.supports_async_abort = true,
 	.create = p9_fd_create_tcp,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
@@ -1011,6 +1017,7 @@ static struct p9_trans_module p9_unix_trans = {
 	.maxsize = MAX_SOCK_BUF,
 	.def = false,
 	.supports_vmalloc = true,
+	.supports_async_abort = true,
 	.create = p9_fd_create_unix,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
@@ -1026,6 +1033,7 @@ static struct p9_trans_module p9_fd_trans = {
 	.maxsize = MAX_SOCK_BUF,
 	.def = false,
 	.supports_vmalloc = true,
+	.supports_async_abort = true,
 	.create = p9_fd_create,
 	.close = p9_fd_close,
 	.request = p9_fd_request,
-- 
2.43.0

