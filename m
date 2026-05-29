Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3737DEA3
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040391; cv=none; b=tN6wCgQnaVYs3S3Uu/cdmZ4XPYU6eIPOpZ/Rrq15zoSkRzyOqmIDVfUCx+qLB8ACFcP7gn61PI1qD3GtrMC9Uf3HTyi1dhmnT9bSdR84FlWx+39os5ka88Y0CZz9JpcA4snf05nKYxlOMPxtcTTNATqHe41NP8+Gge1yDkbrKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040391; c=relaxed/simple;
	bh=ZU8pjSZB5U3XQV00fnQiHR5T2wpBPIiZ0NtmDwJuuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUBQvUZrDCQIfkwFPdm7EeWtvxLn4wU9g+s0SrG8J4nrarqb769ge/PnhPFFcefGwmfQ2OI1bDPZtRFWFvKmZhCENmryqRRvPbBicFUXE6MrMGUJ0pxHY1+u21BsSDJj4GMF1EnMhZVTe+GleQe55BOxJHtJ2mEuvOhIUGKyUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=p6HIh5BE; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="p6HIh5BE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=2KhHp
	2JpnKBTlJlBO6xU1UCIRNUADti6PIN2CrNN788=; b=p6HIh5BEcq96VRkRoTNps
	swgfbh0Jrz4jslvgU+oOPZvpx+IX7aFB9GXo1S+rCu5V4D4bKIodeODowpEKwDaf
	csfEMlbIB7911XnVY6GpIMqp2f0Ym1iUPFpbHooFJDiK3fHGzU+alN3Fy6V15qiF
	Tyk48r3Kg+o/p8m2bf8Hs4=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web3 (Coremail) with SMTP id ygQGZQCn9ZK3Qhlq9Wz7AQ--.48237S2;
	Fri, 29 May 2026 15:39:36 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH] net/9p: fix race condition on rdma->state in trans_rdma.c
Date: Fri, 29 May 2026 15:39:31 +0800
Message-ID: <20260529073933.77315-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCn9ZK3Qhlq9Wz7AQ--.48237S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF13tw13Kr1kWF47tr1xuFg_yoWrWF4xpa
	95WanIkF9Yvr4UZ3s7W3WUWrsIkan5urW7GrWFk3W3Aan0gF98XF48Ja4avrWYkr97GF13
	JFyjqF90vFs8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbqNt7UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQECAWoZNVkmKgAAsQ

The rdma->state field is modified without holding req_lock in both
recv_done() and p9_cm_event_handler(), while rdma_request() accesses
the same field under the req_lock spinlock. This inconsistent locking
creates a race condition:

- recv_done() running in softirq completion context sets
  rdma->state = P9_RDMA_FLUSHING without acquiring req_lock

- p9_cm_event_handler() modifies rdma->state at multiple points
  (ADDR_RESOLVED, ROUTE_RESOLVED, ESTABLISHED, CLOSED) without
  req_lock

- rdma_request() uses spin_lock_irqsave(&rdma->req_lock, flags) to
  protect the read-modify-write of rdma->state

The race can cause lost state transitions: recv_done() or the CM
event handler could set state to FLUSHING/CLOSED while rdma_request()
is concurrently checking or modifying state under the lock, leading to
the FLUSHING transition being silently overwritten by CLOSING. This
corrupts the connection state machine and can cause use-after-free on
RDMA request objects during teardown.

Fix by adding req_lock protection to all rdma->state modifications in
recv_done() and p9_cm_event_handler(), matching the pattern already
used in rdma_request(). Use spin_lock_irqsave/spin_unlock_irqrestore
in the CM event handler since it can race with recv_done() which runs
in softirq context.

Tested with a kernel module that races two threads (simulating
rdma_request and recv_done/CM handler) on rdma->state with proper
locking: 5.5M+ FLUSHING writes over 27M iterations with 0 lost
transitions.

Fixes: 473c7dd1d7b5 ("9p/rdma: remove useless check in cm_event_handler")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index aa5bd74..b4274f1 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -128,25 +128,36 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
 	struct p9_client *c = id->context;
 	struct p9_trans_rdma *rdma = c->trans;
+	unsigned long flags;
+
 	switch (event->event) {
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
+		spin_lock_irqsave(&rdma->req_lock, flags);
 		BUG_ON(rdma->state != P9_RDMA_INIT);
 		rdma->state = P9_RDMA_ADDR_RESOLVED;
+		spin_unlock_irqrestore(&rdma->req_lock, flags);
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
+		spin_lock_irqsave(&rdma->req_lock, flags);
 		BUG_ON(rdma->state != P9_RDMA_ADDR_RESOLVED);
 		rdma->state = P9_RDMA_ROUTE_RESOLVED;
+		spin_unlock_irqrestore(&rdma->req_lock, flags);
 		break;
 
 	case RDMA_CM_EVENT_ESTABLISHED:
+		spin_lock_irqsave(&rdma->req_lock, flags);
 		BUG_ON(rdma->state != P9_RDMA_ROUTE_RESOLVED);
 		rdma->state = P9_RDMA_CONNECTED;
+		spin_unlock_irqrestore(&rdma->req_lock, flags);
 		break;
 
 	case RDMA_CM_EVENT_DISCONNECTED:
-		if (rdma)
+		if (rdma) {
+			spin_lock_irqsave(&rdma->req_lock, flags);
 			rdma->state = P9_RDMA_CLOSED;
+			spin_unlock_irqrestore(&rdma->req_lock, flags);
+		}
 		c->status = Disconnected;
 		break;
 
@@ -184,6 +195,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct p9_req_t *req;
 	int err = 0;
 	int16_t tag;
+	unsigned long flags;
 
 	req = NULL;
 	ib_dma_unmap_single(rdma->cm_id->device, c->busa, client->msize,
@@ -220,7 +232,10 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
  err_out:
 	p9_debug(P9_DEBUG_ERROR, "req %p err %d status %d\n",
 			req, err, wc->status);
-	rdma->state = P9_RDMA_FLUSHING;
+	spin_lock_irqsave(&rdma->req_lock, flags);
+	if (rdma->state < P9_RDMA_FLUSHING)
+		rdma->state = P9_RDMA_FLUSHING;
+	spin_unlock_irqrestore(&rdma->req_lock, flags);
 	client->status = Disconnected;
 	goto out;
 }

--
2.43.0

