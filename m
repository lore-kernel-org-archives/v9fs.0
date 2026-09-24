Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA33E1CED
	for <v9fs@lists.linux.dev>; Thu, 24 Sep 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267049; cv=none; b=X8M+KXQtK87HMvNvlft1s5ATHO6kVAbGLxoTcQKH4KUkrRKBZsFZzdEyulxTB4XxwnYoM+uNLmcLT/ExPtcv3kdMDKd7eQA/aMbWMFa4WEMwpN/+otWE0hi1Tw3upzQt9OMLw2H+HcOMHASTjoMhieOzFZO51ILTvTQc2Ayw3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267049; c=relaxed/simple;
	bh=nAPo4Hd6q4HOv5BJOTxweuhDAxzkP+TcF2Ok63wKh4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWY1rQPRZbzGlVMURxnnX7VeddBfjsqmaprt0jkNLZAyTGj4WRI31yi2AjT9OI1UnnAg0eAdC64q/mR1NZZVHcgtxTgRQWVD3hzA3Fc7xU69zhLexWjsvXjv7Om9IUGszKkTeTlOaaXXxJbcUkjPOGtXHmqla7w8mLPAJbM7dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/b+50tE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/b+50tE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790267048; x=1821803048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nAPo4Hd6q4HOv5BJOTxweuhDAxzkP+TcF2Ok63wKh4w=;
  b=O/b+50tEn2/Yqp5ENY5Ez1H14rLtajciVJehhRnf2/YBmRCBn6tKjWAW
   fgeXqJnA5zEuo+HWPvG1gW9lqqeHF3j4vuSsPNSn7NYAiZ8C64ZbXXHIT
   5Cv9yzigKCCK+HF+M9vj1nd20iq3CLKTBBdboju6CIhkAvIA7LYAyU4qa
   7uycIMgptcYf63xiGQ469UXuJ+/65xDXGrk6StCxHsk7jwLvvwpLJZ0/t
   1PnXaJmnBCmOO6YtZIqUWb3nAS7rSnZ8LW5ebGkPGjiOzwLJqyCuvC5gG
   RLJK43OEN2U5s2lJ7mLXXhrGHZj7W6xWvCgxXYvgj7U2s5sADrRjJO8Qv
   w==;
X-CSE-ConnectionGUID: qlsxugspRTS53aoB0eC+Og==
X-CSE-MsgGUID: 4MA424PWTIaOShg3zh1nFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90268885"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90268885"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:07 -0700
X-CSE-ConnectionGUID: f9zgz6YvQwGyqrDd4Y6yNQ==
X-CSE-MsgGUID: ORhiM1OLQBKz42Oe9fg6JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271897542"
Received: from aborzesz-mobl3.igk.intel.com ([10.237.140.166])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:24:04 -0700
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	mika.westerberg@linux.intel.com,
	andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	corbet@lwn.net
Cc: linux-usb@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux_oss@crudebyte.com,
	alan.borzeszkowski@linux.intel.com
Subject: [PATCH 2/3] net/9p/thunderbolt: Add native 9P Thunderbolt transport support
Date: Thu, 24 Sep 2026 18:23:32 +0200
Message-ID: <20260924162333.147033-3-alan.borzeszkowski@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
References: <20260924162333.147033-1-alan.borzeszkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add native Thunderbolt 9P transport driver which allows user to setup
simple host-to-host file sharing over a Thunderbolt/USB4 cable. Compared
to FD transport, it offers greater data throughput while being simpler
to use.

Driver uses blocking write to send data over Thunderbolt fabric and
dedicated kthread to read from it.

User may mount it like so:

  mount -t 9p -o trans=thunderbolt,aname=<exported_dir> /dev/tbstream0 /mnt

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
---
 net/9p/Kconfig             |   7 +
 net/9p/Makefile            |   4 +
 net/9p/trans_thunderbolt.c | 348 +++++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 net/9p/trans_thunderbolt.c

diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 22f8c167845d..6bbab10c0bea 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -49,6 +49,13 @@ config NET_9P_USBG
 	  This builds support for a transport for 9pfs over
 	  usb gadget.
 
+config NET_9P_USB4
+	tristate "9P Thunderbolt/USB4 Transport"
+	depends on USB4_STREAM
+	help
+	  This builds support for a transport for 9pfs over
+	  Thunderbolt/USB4 cable.
+
 config NET_9P_RDMA
 	depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
 	tristate "9P RDMA Transport (Experimental)"
diff --git a/net/9p/Makefile b/net/9p/Makefile
index 22794a451c3f..417ea999008a 100644
--- a/net/9p/Makefile
+++ b/net/9p/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NET_9P_XEN) += 9pnet_xen.o
 obj-$(CONFIG_NET_9P_VIRTIO) += 9pnet_virtio.o
 obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
 obj-$(CONFIG_NET_9P_USBG) += 9pnet_usbg.o
+obj-$(CONFIG_NET_9P_USB4) += 9pnet_thunderbolt.o
 
 9pnet-objs := \
 	mod.o \
@@ -27,3 +28,6 @@ obj-$(CONFIG_NET_9P_USBG) += 9pnet_usbg.o
 
 9pnet_usbg-objs := \
 	trans_usbg.o \
+
+9pnet_thunderbolt-objs := \
+	trans_thunderbolt.o \
diff --git a/net/9p/trans_thunderbolt.c b/net/9p/trans_thunderbolt.c
new file mode 100644
index 000000000000..95780ac24919
--- /dev/null
+++ b/net/9p/trans_thunderbolt.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * 9P transport over Thunderbolt/USB4 cable using USB4STREAM.
+ *
+ * Copyright (C) 2026, Intel Corporation
+ * Author: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
+ */
+
+#include <linux/file.h>
+#include <linux/fs_context.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/sched/signal.h>
+#include <linux/sizes.h>
+#include <linux/thunderbolt_stream.h>
+#include <linux/wait.h>
+#include <net/9p/9p.h>
+#include <net/9p/client.h>
+#include <net/9p/transport.h>
+
+/**
+ * struct p9_tb_conn - 9P Thunderbolt connection state
+ * @client: 9P client instance.
+ * @stream: USB4STREAM device.
+ * @req_list_lock: Lock protecting active request list.
+ * @write_lock: Makes sure only one write happens at a time.
+ * @req_list: Sent request list.
+ * @reader: Dedicated read thread.
+ * @reader_wait: Wake @reader when request is queued.
+ */
+struct p9_tb_conn {
+	struct p9_client *client;
+	struct file *stream;
+	struct mutex req_list_lock;
+	struct mutex write_lock;
+	struct list_head req_list;
+	struct task_struct *reader;
+	wait_queue_head_t reader_wait;
+};
+
+static void p9_tb_conn_cancel(struct p9_tb_conn *p9_tb, int err)
+{
+	struct p9_req_t *req, *temp;
+	LIST_HEAD(cancel_list);
+
+	scoped_guard(mutex, &p9_tb->req_list_lock) {
+		list_for_each_entry_safe(req, temp, &p9_tb->req_list, req_list) {
+			list_move(&req->req_list, &cancel_list);
+			WRITE_ONCE(req->status, REQ_STATUS_ERROR);
+		}
+	}
+
+	list_for_each_entry_safe(req, temp, &cancel_list, req_list) {
+		list_del(&req->req_list);
+		if (!req->t_err)
+			req->t_err = err;
+		p9_client_cb(p9_tb->client, req, REQ_STATUS_ERROR);
+	}
+}
+
+static int p9_tb_read(struct p9_tb_conn *p9_tb, u8 *buf, size_t len)
+{
+	while (len) {
+		int ret;
+
+		ret = kernel_read(p9_tb->stream, buf, len, NULL);
+		if (ret <= 0)
+			return ret ?: -ESHUTDOWN;
+
+		buf += ret;
+		len -= ret;
+	}
+
+	return 0;
+}
+
+static int p9_tb_recv(struct p9_tb_conn *p9_tb)
+{
+	u8 header[P9_HDRSZ];
+	/* rc.size needs to be set for header parse */
+	struct p9_fcall rc = { .sdata = header, .size = P9_HDRSZ };
+	struct p9_req_t *p9_req;
+	int ret;
+
+	ret = p9_tb_read(p9_tb, header, P9_HDRSZ);
+	if (ret)
+		return ret;
+
+	ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
+	if (ret) {
+		p9_debug(P9_DEBUG_ERROR, "error parsing header: %d\n", ret);
+		return ret;
+	}
+
+	p9_req = p9_tag_lookup(p9_tb->client, rc.tag);
+	if (!p9_req) {
+		p9_debug(P9_DEBUG_ERROR, "request with tag %d not found\n", rc.tag);
+		return -EIO;
+	}
+	if (rc.size > p9_req->rc.capacity) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "requested packet size too big: %d for tag %d with capacity %zd\n",
+			 rc.size, rc.tag, p9_req->rc.capacity);
+		ret = -E2BIG;
+		goto out_put;
+	}
+	memcpy(p9_req->rc.sdata, header, P9_HDRSZ);
+	ret = p9_tb_read(p9_tb, p9_req->rc.sdata + P9_HDRSZ, rc.size - P9_HDRSZ);
+	if (ret)
+		goto out_put;
+
+	p9_req->rc.size = rc.size;
+	p9_debug(P9_DEBUG_TRANS, "got packet tag %d size %d\n", rc.tag, rc.size);
+
+	mutex_lock(&p9_tb->req_list_lock);
+	if (p9_req->status == REQ_STATUS_SENT) {
+		list_del(&p9_req->req_list);
+		p9_client_cb(p9_tb->client, p9_req, REQ_STATUS_RCVD);
+	} else if (p9_req->status != REQ_STATUS_FLSHD) {
+		/* Invalid request - neither sent nor flushed */
+		ret = -EIO;
+	}
+	/* Ignore response for cancelled (flushed) request */
+	mutex_unlock(&p9_tb->req_list_lock);
+
+out_put:
+	p9_req_put(p9_tb->client, p9_req);
+	return ret;
+}
+
+static int p9_tb_read_thread(void *data)
+{
+	struct p9_tb_conn *p9_tb = data;
+	int ret;
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(p9_tb->reader_wait,
+					 !list_empty_careful(&p9_tb->req_list) ||
+					 kthread_should_stop());
+		if (kthread_should_stop())
+			break;
+
+		ret = p9_tb_recv(p9_tb);
+		if (ret < 0) {
+			/* Woken to stop, not real error */
+			if (kthread_should_stop())
+				break;
+
+			/* Prevent subsequent writes */
+			p9_tb->client->status = Disconnected;
+
+			p9_tb_conn_cancel(p9_tb, ret);
+		}
+	}
+
+	return 0;
+}
+
+static void p9_tb_close(struct p9_client *client)
+{
+	struct p9_tb_conn *p9_tb = client->trans;
+
+	client->status = Disconnected;
+
+	if (p9_tb->reader) {
+		/* Break a blocked read */
+		kthread_stop(p9_tb->reader);
+	}
+
+	p9_tb_conn_cancel(p9_tb, -ECONNRESET);
+	filp_close(p9_tb->stream, NULL);
+	kfree(p9_tb);
+}
+
+static int p9_tb_write(struct p9_tb_conn *p9_tb, struct p9_req_t *req)
+{
+	const char *p = req->tc.sdata;
+	size_t nbytes = req->tc.size;
+	int ret;
+
+	scoped_guard(mutex, &p9_tb->req_list_lock) {
+		WRITE_ONCE(req->status, REQ_STATUS_SENT);
+		list_move_tail(&req->req_list, &p9_tb->req_list);
+	}
+
+	if (mutex_lock_interruptible(&p9_tb->write_lock)) {
+		ret = -ERESTARTSYS;
+		goto err;
+	}
+
+	do {
+		ret = kernel_write(p9_tb->stream, p, nbytes, NULL);
+		if (ret <= 0) {
+			mutex_unlock(&p9_tb->write_lock);
+			if (ret == 0)
+				ret = -EIO;
+
+			if (nbytes != req->tc.size) {
+				p9_tb->client->status = Disconnected;
+				p9_tb_conn_cancel(p9_tb, ret);
+			}
+			goto err;
+		}
+		nbytes -= ret;
+		if (nbytes > 0)
+			p += ret;
+	} while (nbytes != 0);
+	mutex_unlock(&p9_tb->write_lock);
+
+	wake_up_interruptible(&p9_tb->reader_wait);
+
+	return 0;
+
+err:
+	guard(mutex)(&p9_tb->req_list_lock);
+	/*
+	 * If request has status other than sent, we know p9_tb_conn_cancel()
+	 * already handled it.
+	 */
+	if (READ_ONCE(req->status) == REQ_STATUS_SENT) {
+		list_del(&req->req_list);
+		return ret;
+	}
+	return 0;
+}
+
+static int p9_tb_request(struct p9_client *client, struct p9_req_t *req)
+{
+	struct p9_tb_conn *p9_tb = client->trans;
+
+	if (client->status != Connected)
+		return -EIO;
+
+	return p9_tb_write(p9_tb, req);
+}
+
+static int p9_tb_create(struct p9_client *client, struct fs_context *fc)
+{
+	const char *devname = fc->source;
+	struct p9_tb_conn *p9_tb;
+	struct file *file;
+	int ret;
+
+	if (!devname)
+		return -EINVAL;
+
+	p9_tb = kzalloc_obj(*p9_tb);
+	if (!p9_tb)
+		return -ENOMEM;
+
+	file = filp_open(devname, O_RDWR, 0);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto err_free;
+	}
+
+	if (!tbstream_dev_from_file(file)) {
+		ret = -ENODEV;
+		goto err_close;
+	}
+
+	p9_tb->stream = file;
+	p9_tb->client = client;
+
+	init_waitqueue_head(&p9_tb->reader_wait);
+	INIT_LIST_HEAD(&p9_tb->req_list);
+	mutex_init(&p9_tb->req_list_lock);
+	mutex_init(&p9_tb->write_lock);
+
+	p9_tb->reader = kthread_run(p9_tb_read_thread, p9_tb, "9p/%s",
+				    kbasename(devname));
+	if (IS_ERR(p9_tb->reader)) {
+		ret = PTR_ERR(p9_tb->reader);
+		goto err_close;
+	}
+
+	client->trans = p9_tb;
+	client->status = Connected;
+
+	return 0;
+
+err_close:
+	filp_close(file, NULL);
+err_free:
+	kfree(p9_tb);
+
+	return ret;
+}
+
+static int p9_tb_cancel(struct p9_client *client, struct p9_req_t *req)
+{
+	/*
+	 * Once p9_tb_request() returns, 9P request is queued on Thunderbolt
+	 * TX ring and is marked as sent. Return '1' to let 9P client continue
+	 * request flushing.
+	 */
+	return 1;
+}
+
+static int p9_tb_cancelled(struct p9_client *client, struct p9_req_t *req)
+{
+	struct p9_tb_conn *p9_tb = client->trans;
+
+	p9_debug(P9_DEBUG_TRANS, "cancelling sent req %p, tag %d\n", req, req->tc.tag);
+
+	/*
+	 * If request got flushed and we didn't receive response by now, remove
+	 * it from the list.
+	 */
+	guard(mutex)(&p9_tb->req_list_lock);
+	if (READ_ONCE(req->status) != REQ_STATUS_SENT)
+		return 0;
+
+	list_del(&req->req_list);
+	WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
+	p9_req_put(client, req);
+	return 0;
+}
+
+static struct p9_trans_module p9_tb_trans = {
+	.name = "thunderbolt",
+	.owner = THIS_MODULE,
+	.maxsize = SZ_1M,
+	.supports_vmalloc = true,
+	.create = p9_tb_create,
+	.close = p9_tb_close,
+	.request = p9_tb_request,
+	.cancel = p9_tb_cancel,
+	.cancelled = p9_tb_cancelled,
+};
+
+static int __init p9_trans_tb_init(void)
+{
+	v9fs_register_trans(&p9_tb_trans);
+	return 0;
+}
+module_init(p9_trans_tb_init);
+
+static void __exit p9_trans_tb_exit(void)
+{
+	v9fs_unregister_trans(&p9_tb_trans);
+}
+module_exit(p9_trans_tb_exit);
+
+MODULE_ALIAS_9P("thunderbolt");
+MODULE_AUTHOR("Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>");
+MODULE_DESCRIPTION("9P transport over Thunderbolt/USB4 cable using USB4STREAM");
+MODULE_LICENSE("GPL");
-- 
2.53.0

