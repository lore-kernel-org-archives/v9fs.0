Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367419;
	b=yqtHGNzR8AY5R3vW2xAv/TC/kS3dTFGbA+Mq7sTYZIq4PsMzsAgA6wVXhm5mC+bUh3Y4
	 IuxwgsEUhEBEwYGos93+FkbTxPjl233YENCvtfoPzajp93+dUFbriyamDDnzwQlHFg5b4
	 /6rHd6JcV+3rjuy5nY2QcjD0VvIJxNbKVlrGiEHtVtVy7+3iFdDVpGY9kbtqYN/wWWXZ+
	 OwniFK2VnLCJSn56OVRWlAxcTRlCvwyeLE6fwPkTFuaAuD380bhf+Gj14++Lr+8JDYk5Y
	 Yhv4MAwuSyFbaSGj6IRTfLlAngT+BhCZS6yALxMf9WTsZL8FOmwGBOhu2+0rG9PdJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367419;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jlaJm4LX2PMMKh5kI2WAJJdUG1atJ4HZp+uvQrPRAJM=;
	b=ZH4CVxtJkn1rJTgrcv2OkYxkQnqahjD0hoh3JVhKcOMLX7/pNdrQyYAHz77Z3dzEp6RG
	 ucElqSZnZGBZUI5mk6xd6nY7LlzzAEFiYWXDJCqMh4xnPJYeXoKKpNsjICC2k9/3l8AVe
	 u9LWC889KLUgyBGC1WrlPXyefAIq7y1cfrO/hO3I8oggDAKNzXo+6rGBeOzs+nPMxSRSu
	 /apjgaPrCXjcv/wMXRi/2fTZVJ4jhcPcJClTbPDO4JGtsdYz+gtsLkDjLS5oP7790NVs5
	 osN8C68zg2nVj02tdm7vJ7AVxfAGM4k8tXDkuksecWI1a5yGxD/CQM/TqVEfswaYIaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=p2lnXLPu;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616D606A33F
	for <v9fs@lists.linux.dev>; Wed, 11 Nov 2026 03:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D616D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=p2lnXLPu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794367409; bh=jlaJm4LX2PMMKh5kI2WAJJdUG1atJ4HZp+uvQrPRAJM=;
	h=From:To:Cc:Subject:Date;
	b=p2lnXLPuyYTldEtde83+5cFnxxOjz2F4wjzOeAb6zDW0mfDwqe3XHv8j7KV5VFhjf
	 LptNzhCMpnGr9jomi1MGz2d+vmgMLNIOfDtIEUeiK1L1abwP4EI6Q1Kkyt4sCbnxTP
	 mF9gcjCdRWGOnWc2MVMxUIYB5kVO+G1Izqh/wTUY=
Received: from DESKTOP-KS8HP5K ([59.78.171.188])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 5C9B5682; Wed, 11 Nov 2026 11:23:09 +0800
X-QQ-mid: xmsmtpt1794367389tlf7g5psm
Message-ID: <tencent_10059585FDBE07269A8A28C34F0D2574C00A@qq.com>
X-QQ-XMAILINFO: M5f61TQAi9/2YwMuGin0fOKcO6iVoQByQkFt6cLzCZqCVyW5ZZxLWLmGJEDX+4
	 KnZiGoftspIUCqZC5DOcFTQZ37P8tXoGfgBXFvcbeFQqVFS0kGYjWpX+u//ds8BSwBX2bwlmRxU2
	 OCNwpAtwXSu2WoOSM1rtaDKMkFJ7wqWwRADjtvvIKcVC+zXE85Omp9G1e17eqfkQpn5gDHbc4Yzi
	 8A8/hmYu9k8UeoDs41d2tTPfxM4pYYT2okOjC5QE7HrEelEgFNp02hfulcKMs5IYgGFrON7+29Q5
	 xzpzXhGnAKU+nw/JMzTMlyLNWmdOTIlD/bylipw3EyUs7UoKd3qiLCT3jCB0EyE2GqumJIdCAjjx
	 16J8Tr39NRJVPGxY4QmpXtpOpJVHQwdtKF6QvBmtwdBjNLbWNcy+PoM6c7MMPaCSz5WXHCVHnLpU
	 2ri4x6kL3ijYCTvV5lddDNTzYJ8Qv61951kLZtkxrrcRKE+f2jeq63wUJqxLlQFCQhNos6QIjvGc
	 E3mXY0zuiGQU9ogitDyONfTjmEgmfCUhFVv58jR5Tkz/PeWpC9xXWWsmq2N34FfZgM9l0dADIsix
	 hU4r3mC4TRsrOZ5XKWTW8NsMFl/nHLnQsQmRHrxlIgbjb+7SAZMrDOS0x4niEsOh99vLN68rOxsN
	 gV0xM5KGK6zwvekSjDP+plwN5LxhS6jeawNEl4+JTzW07780o6ju/qIEbw//cclwH/3WIP/maFT1
	 enOkyAvIlELRpOo8IswLh7Z/BWl0eh9zdqhQX6hGntN8J116VPpHv06/kUoZMt/F5eKL2ftVLMTB
	 6ojlheRO9yo66MDoXwdqPh1AYWE2xiEQtG4kYyklZk2tbZK9YER0vju8wmg7T5otcdfesnlKheFv
	 uqH86a6zsq0lzHhTgtlMrwWI3lISjz+fiBHC9bcOrg4CO8Vab3T7RT3sEAotA+rqcIxuhH6S+qX6
	 2AE3Bt2CLBideEehtqSLL/jWh8h5Gi2HBFacViL253QiPDOXmLdBYSoSnImYurFUl8n8RIiwJvDN
	 tIEgmUbPjgdaC/h9XE
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: usualtree <1340399194@qq.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rahul.priolkar@asu.edu
Subject: [PATCH] net/9p: publish fd cancellation error before status
Date: Wed, 11 Nov 2026 11:20:15 +0800
X-OQ-MSGID: <20261111032015.1948-1-1340399194@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

p9_conn_cancel() publishes REQ_STATUS_ERROR under req_lock, but only
sets req->t_err after dropping the lock. A waiter in p9_client_rpc()
can observe the error status and read the initial zero t_err before
the transport stores the actual error. The zero value skips the
transport error path and leads to parsing an empty response instead
of returning the transport error.

Store t_err while moving both pending and unsent requests to the
cancellation list. Add a write barrier before publishing
REQ_STATUS_ERROR so that the error store is visible before the status.

Add a read barrier after p9_client_rpc() confirms REQ_STATUS_ERROR and
before either the debug log or the error path reads t_err. Keep the
existing post-wait barrier for normal response ordering. The new
barrier covers a signal-interrupted wait where the second status read
is the first to observe ERROR.

Keep callbacks outside req_lock and preserve the existing list cleanup
behavior.

The issue was reproduced in QEMU using an fd transport mount and a
temporary delay after the early status publication. The waiter
observed t_err == 0 before this change and -ECONNRESET after it. The
delay and observation instrumentation are not part of this patch.

Kimi assisted with the reproducer, fix, and validation, based on a
request to find and locally verify a small 9P upstream fix.

Reported-by: Rahul Priolkar <rahul.priolkar@asu.edu>
Closes: https://lore.kernel.org/lkml/20260911092132.3328659-1-rahul.priolkar@asu.edu/
Fixes: 11c10956515b ("9p/fd: fix issue of list_del corruption in p9_fd_cancel()")
Signed-off-by: usualtree <1340399194@qq.com>
---
 net/9p/client.c   |  5 +++++
 net/9p/trans_fd.c | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a85..d68827af8c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -611,6 +611,11 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 
 	if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
+		/*
+		 * Pair with the smp_wmb() in p9_conn_cancel(): once the error
+		 * status is visible, t_err must be visible too.
+		 */
+		smp_rmb();
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 159d57e41e..5bfeaacbb3 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -172,20 +172,29 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
-		WRITE_ONCE(req->status, REQ_STATUS_ERROR);
+		if (!req->t_err)
+			req->t_err = err;
 	}
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
-		WRITE_ONCE(req->status, REQ_STATUS_ERROR);
+		if (!req->t_err)
+			req->t_err = err;
 	}
 
+	/*
+	 * The error code must be visible before the error status. Pair with
+	 * the read barriers in p9_client_rpc(), including the barrier after
+	 * the error-status check for waits interrupted by a signal.
+	 */
+	smp_wmb();
+	list_for_each_entry(req, &cancel_list, req_list)
+		WRITE_ONCE(req->status, REQ_STATUS_ERROR);
+
 	spin_unlock(&m->req_lock);
 
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
 		list_del(&req->req_list);
-		if (!req->t_err)
-			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
 }
-- 
2.52.0.windows.1

