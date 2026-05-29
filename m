Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891A3AC0CE
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038519; cv=none; b=uCHyblRaLbx9oq3c+yZ2xeQgXW1iKZea8xIr1MApWEMlH/xm9h6EqwQXW5O28eDLyyj+qFTxa0v7fFxL/ehj7UEFwuKeeMQHM3Wa3ErYEfB1Q4r6hBoxjIJAzGYkSft641Vpx2RPDQf91NILBshK4UP9rl/7Q29TnpzeosKUbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038519; c=relaxed/simple;
	bh=uwK3j17910hIEg9WKlMPWpM30NIo+r1kkcsSpNYmGWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyhPqWrEa2s5PxyxPp1S5G028n+svBp+e6cOrsxNM9CLO9sVTeyFjN+MmE3daNGtKnl0hO3E74mDrVpxT/8CfVfR5G23KQgieXF/gD6js1pFAY8tncxAxLsej82EY79f9YGLFrdIvgt6Dw8Po1Z//NzV+8X7qF942U8KWti4yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=VBU5UHTy; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="VBU5UHTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=8TXnv
	8zsGPYnwCJgXgRW0VwAiGLnXwZB1x8HRtxYlT0=; b=VBU5UHTydTUDSWwbcWADI
	utq7BqpWFfHiV4R0uWJX9jgmYeFpeTlBj8hGWG0GmIR4BsWrXhQe3iMwwPv5Jc2a
	YRWHt9ezzE6FtUzhOVwaDgp/EWiU/KqWsP/SNmWb6nuadrvFp7FDbpQ++5HIn9bO
	p2rpdGVQZqsTokj9eaNboY=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web3 (Coremail) with SMTP id ygQGZQCn85BmOxlqCDr7AQ--.42448S2;
	Fri, 29 May 2026 15:08:23 +0800 (CST)
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
Subject: [PATCH] 9p/rdma: create RDMA CM ID in caller's net namespace
Date: Fri, 29 May 2026 15:08:15 +0800
Message-ID: <20260529070817.76798-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCn85BmOxlqCDr7AQ--.42448S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy5uw1kWFW8JFy5WF4kJFb_yoW8Aw17pF
	W8ur9xAFWfKry7AayDta92k343Gr4kW3y8Kryv9asxZwn0gFyjkr10k3ZxZryDAFWkKryr
	ZFWjvrZ8Awn8ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvQ6LUUUUU
	=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgICAWoZNcAQmgAAsP

The 9p RDMA transport currently passes &init_net to rdma_create_id().
As a result, RDMA address resolution and connection setup are performed
in the initial network namespace, even when the mount is initiated from
a non-initial network namespace.

This differs from the socket-based 9p transports, which create sockets
in current->nsproxy->net_ns.  Use the caller's network namespace for the
RDMA CM ID as well, so that RDMA transport setup follows the same
namespace context as the process performing the mount.

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
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/trans_rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index aa5bd74..ea49b15 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -541,7 +541,7 @@ rdma_create_trans(struct p9_client *client, struct fs_context *fc)
 		return -ENOMEM;
 
 	/* Create the RDMA CM ID */
-	rdma->cm_id = rdma_create_id(&init_net, p9_cm_event_handler, client,
+	rdma->cm_id = rdma_create_id(current->nsproxy->net_ns, p9_cm_event_handler, client,
 				     RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(rdma->cm_id))
 		goto error;
-- 
2.43.0

