Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88A3C945B
	for <v9fs@lists.linux.dev>; Wed, 27 May 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867359; cv=none; b=oHxVjlXjpkdzD8BvoAppsQvvoCTIu6EHtxS8KL3eNPe+jzjGFo93RjWyeN1SWuRV8DPiIFE+Z1HSyeJyA9aJ0vxS/EpHu2EtdHB63fX6FoX8u036N4iObmtDP9sTtoE5XfQBC6rP2TOQ6Kbnjy+BbXf5afz4/ABBum21OI0e0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867359; c=relaxed/simple;
	bh=95HnHOyqOINvjhWLLDfxwBPhBQcWUvKy0U1swjgf3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBRhgyZiWLV5h3tfum8hhCI0lXRfye1KUQ7cyIp0sODkFOVos/r7+p3jR+duFamkVVNvc1FslVwSo7rV4AXwbEOgQtkIjmpthuMCnphHLUPnJPaY26PMVFuq8YcTLHhafEIWlpMqga6uOLAMZK4RrRR6cEfByJ+FvLSmG5vVuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/74ii49; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/74ii49"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so8062981f8f.0
        for <v9fs@lists.linux.dev>; Wed, 27 May 2026 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867356; x=1780472156; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upSidzI1HiHWnTdIHNUKK7ENeiQ5Ygw4Xf7ujn3gz7Q=;
        b=S/74ii49Gz34JBe/SUfMjobPNooh7YTpK0XH/UFRQXIxuypRiWZp0Fxpz/WU14AARZ
         wsBNrB2I5Oyu7JGjFlasMgOOCSpg5ETcIybFP/3okpABKV7eH+jK06dF1B8FXzrxpp9T
         milpmeSeGK1UTn7nnesPPRNV5jF7uS4q42B0mnJJQTMq3EB4wKNZHQ8vKCc4xC8LKuDm
         6Y2gRJ6J+h6V9jFVRIlcUjtbdPfR+dke8r+vYp29d3WnqpkFEuU8n7R2qaALDo7MyifX
         cfHzJM7xXbKskojdshMEGhNy0b0iPIC5nDe9zT6sWvWJZ1N6PjR6iEOujHN5BteNo2XD
         G+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867356; x=1780472156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upSidzI1HiHWnTdIHNUKK7ENeiQ5Ygw4Xf7ujn3gz7Q=;
        b=eMzHZx8bsUt6LjNC5W4OZeI15zlad1X+4Zv6xIeuMXlNUPbTMEqk1CL5Iuv7lDPKKc
         Xyff7DVEsjeYFgQJiCXqbZRf3iRE18jS4o4slYqLM50OrrACEfOws02X96vmh9OW5KsK
         3gproJI5bgqh8SAwN8JlUVRFXSdFoCyH/VkhsiKEtHBPz0GQYklxBZ5F2FCw1CpNH4yE
         RZqd3n+a4SMM8kWr+48CvlSeYDBz0elPbnqRow6U1qn53brLU0vDTJI/P4bOqAbx1h4W
         yhKo3YDbnQL7ojBnE5e6DdLKlbwoBS7MaKh0CJmxlCveVqpDQqWgSrc11i9gMGyxUPkq
         D+5Q==
X-Gm-Message-State: AOJu0Yx//BbBxu55KfZ0ptZfe+Y1PN+HpdUTc3IRAA9GUxQmuro/x1Id
	dKPWJmiHKIFrz+hQAlZPuS+/bhEOBn7hsHb9pNw6t8M+kmW/BRSaiN6O
X-Gm-Gg: Acq92OFMsq/lhHBmnrMinQGWfMNArwDNzbcTaDrI8+cC/WrPxfOBy7HWUOnrVxTXv35
	H7QydzWL2ArR7Xh6JsvXy0FfAyOwoTv9rLUwezXRJvwT8DwLJDZtRKh7bvbtYUoFPreJFvSGUe2
	rqo45NluxqVRLJPOiPa/flYmGoFqVE+ke01vsDieX3lG7AF9Chd4IYqpU10LzB8B4VvuVyqbNK1
	CJ35L0GfLRRnPIm6ms44ZCcQTifnJAqa3qVHu6T0fPUMcRoGFcM0yquTmc2xddtCUGAOvC48eob
	FK6WCvK0iq6V0mw6wxB8++naFVnL6BJfnlF8sb0SaogV040d1EcXmMOs7oNTy0ycfTcv1+Hlp8l
	E7IOyhzaOCXJFExGEmdg8dwfLx507zPxkeIyhq3722aAtLNGnNmJFE1UwLz1MA/z+CgdaYrTQ2Z
	oxaEAz7e7XXDq4VLdHoqOY8uTFtIvxue9gLHmiTYhxJZWq+xQVYPVccJ3p0+19k/RMXJwKRbkCr
	WlUeSd1vhqzxb23LIZzilAFI8gR0U1GKeWnZV7ClQ==
X-Received: by 2002:a05:6000:18af:b0:45e:9304:a4c3 with SMTP id ffacd0b85a97d-45eb333aa31mr32344076f8f.19.1779867355828;
        Wed, 27 May 2026 00:35:55 -0700 (PDT)
Received: from localhost.localdomain (85-193-33-119.rib.o2.cz. [85.193.33.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558449sm3783408f8f.13.2026.05.27.00.35.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 00:35:55 -0700 (PDT)
From: skvarlamatus@gmail.com
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Matus Skvarla <skvarlamatus@gmail.com>
Subject: [PATCH] net/9p: add vsock transport
Date: Wed, 27 May 2026 09:34:47 +0200
Message-ID: <20260527073447.86538-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matus Skvarla <skvarlamatus@gmail.com>

Add vsock as a transport option for 9P client connections. This
allows mounting 9P filesystems over VM sockets without requiring TCP/IP
networking or additional userspace tools.

The implementation extends trans_fd.c with vsock support, reusing the
existing socket infrastructure. A new p9_fd_create_vsock() function
handles vsock connection setup by parsing the CID from the mount source,
creating an AF_VSOCK socket, and connecting to the specified endpoint.
All other transport operations (close, request, cancel) use the shared
fd transport implementation.

Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
into 9pnet_fd.ko. This follows the pattern where socket-based transports
(TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
(virtio, xen, rdma) have dedicated files.

Usage:
  mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point

Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>
---
 include/net/9p/client.h |  6 ++-
 net/9p/Kconfig          |  9 +++++
 net/9p/trans_fd.c       | 89 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..4eb2f6b22496 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -122,8 +122,12 @@ struct p9_client {
 		struct {
 			u16 port;
 			bool privport;
-
 		} tcp;
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+		struct {
+			u16 port;
+		} vsock;
+#endif
 	} trans_opts;
 
 	struct idr fids;
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 22f8c167845d..63a5b5b25063 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -32,6 +32,15 @@ config NET_9P_VIRTIO
 	  This builds support for a transports between
 	  guest partitions and a host partition.
 
+config NET_9P_VSOCK
+	depends on VSOCKETS
+	bool "9P VSOCK Transport"
+	help
+	  This builds support for a transport for 9pfs over
+	  virtual sockets (vsock). This is useful for communication
+	  between virtual machines and their host without requiring
+	  TCP/IP networking configuration or additional userspace software.
+
 config NET_9P_XEN
 	depends on XEN
 	select XEN_XENBUS_FRONTEND
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index dbad3213ba84..6f35f2d84313 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -28,6 +28,9 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+#include <linux/vm_sockets.h>
+#endif
 
 #include <linux/syscalls.h> /* killme */
 
@@ -36,6 +39,9 @@
 
 static struct p9_trans_module p9_tcp_trans;
 static struct p9_trans_module p9_fd_trans;
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+static struct p9_trans_module p9_vsock_trans;
+#endif
 
 enum {
 	Rworksched = 1,		/* read work scheduled or running */
@@ -714,6 +720,12 @@ static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
 		if (clnt->trans_opts.fd.wfd != ~0)
 			seq_printf(m, ",wfd=%u", clnt->trans_opts.fd.wfd);
 	}
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+	else if (clnt->trans_mod == &p9_vsock_trans) {
+		if (clnt->trans_opts.vsock.port != P9_FD_PORT)
+			seq_printf(m, ",port=%u", clnt->trans_opts.vsock.port);
+	}
+#endif
 	return 0;
 }
 
@@ -968,6 +980,60 @@ p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)
 	return p9_socket_open(client, csocket);
 }
 
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+static int
+p9_fd_create_vsock(struct p9_client *client, struct fs_context *fc)
+{
+	const char *addr = fc->source;
+	struct v9fs_context *ctx = fc->fs_private;
+	int err;
+	struct socket *csocket;
+	struct sockaddr_vm addr_vm = { 0 };
+	struct p9_fd_opts opts;
+	unsigned int cid;
+
+	/* opts are already parsed in context */
+	opts = ctx->fd_opts;
+
+	if (!addr)
+		return -EINVAL;
+
+	err = kstrtouint(addr, 10, &cid);
+	if (err < 0) {
+		pr_err("%s (%d): invalid CID: %s\n",
+		       __func__, task_pid_nr(current), addr);
+		return err;
+	}
+
+	csocket = NULL;
+
+	client->trans_opts.vsock.port = opts.port;
+	err = __sock_create(current->nsproxy->net_ns, AF_VSOCK,
+			    SOCK_STREAM, 0, &csocket, 1);
+	if (err) {
+		pr_err("%s (%d): problem creating socket\n",
+		       __func__, task_pid_nr(current));
+		return err;
+	}
+
+	addr_vm.svm_family = AF_VSOCK;
+	addr_vm.svm_port = opts.port;
+	addr_vm.svm_cid = cid;
+
+	err = READ_ONCE(csocket->ops)->connect(csocket,
+					       (struct sockaddr_unsized *)&addr_vm,
+					       sizeof(addr_vm), 0);
+	if (err < 0) {
+		pr_err("%s (%d): problem connecting socket to %s:%u\n",
+		       __func__, task_pid_nr(current), addr, opts.port);
+		sock_release(csocket);
+		return err;
+	}
+
+	return p9_socket_open(client, csocket);
+}
+#endif /* CONFIG_NET_9P_VSOCK */
+
 static int
 p9_fd_create(struct p9_client *client, struct fs_context *fc)
 {
@@ -1038,6 +1104,23 @@ static struct p9_trans_module p9_fd_trans = {
 };
 MODULE_ALIAS_9P("fd");
 
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+static struct p9_trans_module p9_vsock_trans = {
+	.name = "vsock",
+	.maxsize = MAX_SOCK_BUF,
+	.def = false,
+	.supports_vmalloc = true,
+	.create = p9_fd_create_vsock,
+	.close = p9_fd_close,
+	.request = p9_fd_request,
+	.cancel = p9_fd_cancel,
+	.cancelled = p9_fd_cancelled,
+	.show_options = p9_fd_show_options,
+	.owner = THIS_MODULE,
+};
+MODULE_ALIAS_9P("vsock");
+#endif
+
 /**
  * p9_poll_workfn - poll worker thread
  * @work: work queue
@@ -1075,6 +1158,9 @@ static int __init p9_trans_fd_init(void)
 	v9fs_register_trans(&p9_tcp_trans);
 	v9fs_register_trans(&p9_unix_trans);
 	v9fs_register_trans(&p9_fd_trans);
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+	v9fs_register_trans(&p9_vsock_trans);
+#endif
 
 	return 0;
 }
@@ -1085,6 +1171,9 @@ static void __exit p9_trans_fd_exit(void)
 	v9fs_unregister_trans(&p9_tcp_trans);
 	v9fs_unregister_trans(&p9_unix_trans);
 	v9fs_unregister_trans(&p9_fd_trans);
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+	v9fs_unregister_trans(&p9_vsock_trans);
+#endif
 }
 
 module_init(p9_trans_fd_init);
-- 
2.47.1

