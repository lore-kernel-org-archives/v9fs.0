Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131553AFAEA
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045607; cv=none; b=EugQEB5yVbYfeduDKW1pB08sD5ose14svgzNbWsgyJR6E5n5MOgAxjc3w0iDtabUXGAj/yaSoG9EsZXEnBTF825QWYuBQrJyx/3aFNC32SyZfjo8p2Q5jfuOc0JuKYSRjdvSo7cHhLyrXTg1s8idVvnhif9KDJBOe2Ga327GWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045607; c=relaxed/simple;
	bh=cWmlk+qqXH1sAX+h6bmugwm/hRHYo0EPwNmVuO3mWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpEoEIDZJu+5bMFLQVxgfyXli2qxjdMsiKQaIeJosDbCG7AEX3wmX3h4iFTk2gBflBeUyJkcsbmwn+rDvJsNPMXJOvEQvjfiN43WqTGAORnrWkKHaq01P4askYYqwoI5/X94E3Xsw2a30WB2aogcBKv6Qc0AbNRIaHA6hEs6AC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=gMiR/2uP; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="gMiR/2uP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=AWOX/
	QA4lxWbbgTp0kHZQSWyFT1DkSSDXx/yLXG6gH0=; b=gMiR/2uPqV9NSQhs2eAEQ
	ELlSt17/L7HhG+H29OOykY28KTH7uZP0cyMZDnI0/aiQH/6JlDJ00Qj0xG4jEo7I
	Z1nHheQOSs3EuDz9MPG6XAxFZz4s0ZUeotfJGe12Oprj85A9MnJ3pm4+/ZslhBxy
	FiJMQUmI2bD2Y5nNCPnm/A=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web2 (Coremail) with SMTP id yQQGZQAH4ZgVVxlqibzdAQ--.12846S2;
	Fri, 29 May 2026 17:06:29 +0800 (CST)
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
Subject: [PATCH v2] 9p: use fc->net_ns for network namespace in RDMA and socket transports
Date: Fri, 29 May 2026 17:06:24 +0800
Message-ID: <20260529090625.78761-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAH4ZgVVxlqibzdAQ--.12846S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UCFWrtr13JFW8Cr1DAwb_yoWrJr45pF
	W8ur98J3y8JFy7Zan8tayqk343Gr4vkayrGryvk3sxAFs0gr1YvF10k3yYvrW5AFWqg34j
	9FWUtFs0yr1DZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQICAWoZNVlhZwAAsZ

The 9p RDMA transport currently passes &init_net to rdma_create_id().
As a result, RDMA address resolution and connection setup are performed
in the initial network namespace, even when the mount is initiated from
a non-initial network namespace.

This differs from the socket-based 9p transports, which create sockets
in current->nsproxy->net_ns.  Use fc->net_ns for both the RDMA and
socket transports instead, so that transport setup follows the VFS
mount namespace context rather than depending on the calling process's
current namespace.

This avoids surprising behaviour where a 9p RDMA mount from a container
or other non-initial network namespace may use the host namespace for
RDMA CM operations.

Fixes: fa20105e09e9 ("IB/cma: Add support for network namespaces")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
Changes in v2:
- Use fc->net_ns instead of current->nsproxy->net_ns in trans_rdma.c
(per Dominique Martinet's suggestion: fc->net_ns is the VFS mount
namespace, more correct than current->nsproxy->net_ns)
- Also fix trans_fd.c which has the same issue: 3 occurrences of
current->nsproxy->net_ns replaced with fc->net_ns
- Link to v1: https://lore.kernel.org/v9fs/20260529070817.76798-1-zhaoyz24@mails.tsinghua.edu.cn/
---
 net/9p/trans_fd.c   | 6 +++---
 net/9p/trans_rdma.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index dbad3213b..868882258 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -887,7 +887,7 @@ p9_fd_create_tcp(struct p9_client *client, struct fs_context *fc)
 		return -EINVAL;

 	sprintf(port_str, "%u", opts.port);
-	err = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, addr,
+	err = inet_pton_with_scope(fc->net_ns, AF_UNSPEC, addr,
 				   port_str, &stor);
 	if (err < 0)
 		return err;
@@ -896,7 +896,7 @@ p9_fd_create_tcp(struct p9_client *client, struct fs_context *fc)

 	client->trans_opts.tcp.port = opts.port;
 	client->trans_opts.tcp.privport = opts.privport;
-	err = __sock_create(current->nsproxy->net_ns, stor.ss_family,
+	err = __sock_create(fc->net_ns, stor.ss_family,
 			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
@@ -948,7 +948,7 @@ p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)

 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, addr);
-	err = __sock_create(current->nsproxy->net_ns, PF_UNIX,
+	err = __sock_create(fc->net_ns, PF_UNIX,
 			    SOCK_STREAM, 0, &csocket, 1);
 	if (err < 0) {
 		pr_err("%s (%d): problem creating socket\n",
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index aa5bd74d3..b3d6c27d7 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -541,7 +541,7 @@ rdma_create_trans(struct p9_client *client, struct fs_context *fc)
 		return -ENOMEM;

 	/* Create the RDMA CM ID */
-	rdma->cm_id = rdma_create_id(&init_net, p9_cm_event_handler, client,
+	rdma->cm_id = rdma_create_id(fc->net_ns, p9_cm_event_handler, client,
 				     RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(rdma->cm_id))
 		goto error;
--
2.43.0

