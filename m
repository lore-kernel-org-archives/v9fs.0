Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153603CEBA7
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050888; cv=none; b=NHoBNujzVkdWIepcHHSaAlzZOH0iIbOBzVYCRCjOv5nl7ad6apPeo6sA68Z5m+u5SsTWDgyPqjpJ90Is1evn/hWlAAXCqqhx7mYLhORvhle/y2wM9PmBUG2oNKfZM+xWEnGC/tCY3aBs495bTdmIaOCi23tXyJ2ZNppDa2qQZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050888; c=relaxed/simple;
	bh=apB7UWVudIhcvCYkDQZaxA+dOF2rDha0JrKplcLUz0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJmaYBhbLLn8xfS38YKSirRz+Q8Wo4bEpR6ivztGg9ETznxppm7LnzYJVNmUqiwezM3EfkqavdNGrjKMC49Ny6g/i2QjYqKg+5wePGdLTD70Z7pPeLivQDmn6prNdUymOi0VsDxXK2pTKVOABZFGMTd/2deSsV55vJxrrTNQMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=daVQw007; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="daVQw007"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=odjJw
	XKJYvoieuC6wwW6F9NYI05mPDG8W4gzYFAIsmw=; b=daVQw007auHph6v328aVV
	SfB4eFZVI9pJV7ockWrHclTR9Fk/occpskiOQK7EEndTQMatgVNLK8FAMXlGz+mi
	zKl7NgST/ngCe08CBKP0HBRwIK0teAjj52hKxVyKbiNh3RNOJh1H+yW1tanUYxLM
	MhoxG9ImR5Eklpl6C35tAk=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web5 (Coremail) with SMTP id zAQGZQB3McG4axlqRdX4AQ--.48756S2;
	Fri, 29 May 2026 18:34:33 +0800 (CST)
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
Subject: [PATCH] 9p/xen: fix use-after-free in p9_xen_request
Date: Fri, 29 May 2026 18:34:15 +0800
Message-ID: <20260529103416.81378-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQB3McG4axlqRdX4AQ--.48756S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45XF45Xr1fCF45ArWfuFg_yoWrWFy8pa
	18AFZ8AFWDJr17JFn5tFykZ3WFyr4kJry2gFy2yw4fAwnxJFykXFWvyryjg345ArZYgFn5
	Jr1DtFWUKFZruw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj_Oz7UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQECAWoZNVmO0wAAsB

p9_xen_request() looks up the transport private data in xen_9pfs_devs
under xen_9pfs_lock, but drops the lock before using the returned
pointer.

This means the lookup only protects the list traversal. It does not pin
the lifetime of the object. If xen_9pfs_front_remove() runs after the
read lock is dropped, it can remove the entry from the list and free the
private data and its rings while p9_xen_request() is still about to use
them.

Fix this by adding a kref to xen_9pfs_front_priv. Take a reference while
still holding xen_9pfs_lock, and drop it after the request has finished.
Make the remove path drop the list reference instead of freeing the
object directly, so the final free is deferred until any in-flight
p9_xen_request() users have released their references.

Fixes: f023f18ddf41 ("xen/9pfs: send requests to the backend")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/trans_xen.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 47af5a1..abdc652 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -14,6 +14,7 @@
 #include <xen/interface/io/9pfs.h>

 #include <linux/module.h>
+#include <linux/kref.h>
 #include <linux/spinlock.h>
 #include <linux/fs_context.h>
 #include <net/9p/9p.h>
@@ -54,6 +55,7 @@ struct xen_9pfs_front_priv {
 	struct xenbus_device *dev;
 	char *tag;
 	struct p9_client *client;
+	struct kref refcount;

 	struct xen_9pfs_dataring *rings;
 };
@@ -114,6 +116,8 @@ static bool p9_xen_write_todo(struct xen_9pfs_dataring *ring, RING_IDX size)
 		xen_9pfs_queued(prod, cons, XEN_9PFS_RING_SIZE(ring)) >= size;
 }

+static void xen_9pfs_front_release(struct kref *ref);
+
 static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 {
 	struct xen_9pfs_front_priv *priv;
@@ -128,9 +132,12 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 		if (priv->client == client)
 			break;
 	}
-	read_unlock(&xen_9pfs_lock);
-	if (list_entry_is_head(priv, &xen_9pfs_devs, list))
+	if (list_entry_is_head(priv, &xen_9pfs_devs, list)) {
+		read_unlock(&xen_9pfs_lock);
 		return -EINVAL;
+	}
+	kref_get(&priv->refcount);
+	read_unlock(&xen_9pfs_lock);

 	num = p9_req->tc.tag % XEN_9PFS_NUM_RINGS;
 	ring = &priv->rings[num];
@@ -165,6 +172,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	spin_unlock_irqrestore(&ring->lock, flags);
 	notify_remote_via_irq(ring->irq);
 	p9_req_put(client, p9_req);
+	kref_put(&priv->refcount, xen_9pfs_front_release);

 	return 0;
 }
@@ -309,6 +317,13 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	kfree(priv);
 }

+static void xen_9pfs_front_release(struct kref *ref)
+{
+	struct xen_9pfs_front_priv *priv =
+		container_of(ref, struct xen_9pfs_front_priv, refcount);
+	xen_9pfs_front_free(priv);
+}
+
 static void xen_9pfs_front_remove(struct xenbus_device *dev)
 {
 	struct xen_9pfs_front_priv *priv;
@@ -323,7 +338,7 @@ static void xen_9pfs_front_remove(struct xenbus_device *dev)
 	list_del(&priv->list);
 	write_unlock(&xen_9pfs_lock);

-	xen_9pfs_front_free(priv);
+	kref_put(&priv->refcount, xen_9pfs_front_release);
 }

 static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
@@ -421,6 +436,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (!priv)
 		return -ENOMEM;
 	priv->dev = dev;
+	kref_init(&priv->refcount);
 	priv->rings = kzalloc_objs(*priv->rings, XEN_9PFS_NUM_RINGS);
 	if (!priv->rings) {
 		kfree(priv);
--
2.43.0

