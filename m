Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2234E762
	for <v9fs@lists.linux.dev>; Thu,  9 Jul 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613907; cv=none; b=FeK3rlm5QAZmOhBj52qy94imsulUpWkN80dS1ZH4tPbC2nrOAJxGyB8sFo/G1YBAqWvAANgg/0mt0Ad8NdwXZq2iXMSw9DKfqvkRSMpeQj7RkXYLuWgcAmRzfUci+IxevjPM4OniLO2tof14ukWhUKBRkxU4lBzRv3veqt4cdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613907; c=relaxed/simple;
	bh=EmjAWbNWt74hMOxQoxIlKm6B5v14exXhQI/KiLtGVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hfh5+bub50W65u3gKDeefi9zWH/BHnUUYGZ0/ckkr4ChR1xsnrGiFA2f6FTxo/MJkDs01Fwcd7MBSOFWsYRhjaK9tKsZPzZXjV7ZKD6trR8N8w2pa8+L9aga7RK/Ab/uAuU9mbCjQV46T7hg6zwhb3uLUBNQ+GgLSE8zcwtkKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqXs1W9O; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqXs1W9O"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso54036f8f.2
        for <v9fs@lists.linux.dev>; Thu, 09 Jul 2026 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783613903; x=1784218703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PeVVk0H+a0Po6JmJkUEjXmGck39dmXcNcbPOH+gPzKE=;
        b=KqXs1W9Ol+CPq20kAunZNvC673Ai8+hI5py39kaWdnfbxR2ove+a1mg2VRTBtBj5Ar
         gZnWandvqjDeLs6u1iQP42JYMcjdKDPQPlczfbJELQtjeJ2Lfz+drvV3KMUOZXsQKkQQ
         UaRR6A+k2vvrmC6QgCLsEZ0qXyZ/OBlUEifxF86E2L55zbm94Kd5J9BTUol9qH+GFGYA
         oDFwAgsdyl5MDlTc6VPdJZtjG1tBXRElkDDAgGAq/AyCPMc2gjxSIbRMBfxGcBydD6ls
         hRctpOIlJIKB+G8FvLaU8CIYDwAa1jmGHe2sLznazX8S7f5pNKHHV5nGCWKADBR2NIJZ
         cfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613903; x=1784218703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeVVk0H+a0Po6JmJkUEjXmGck39dmXcNcbPOH+gPzKE=;
        b=rNyKazb77W8sGCdcGdqa14StknsI4ws3gNC5oPz7lcWkcrCXD2SN1IImHdEDL3K60w
         XbnKMkJxoCDlfAXQZECYCk3XSnl4JY3P83l3Hc/0Pfq2jVyRSG69B1OXYjPoNuFjU2gV
         AABlFE612lDfK9ROMcEHstEnBxfkEJnPBvYTU9THBGhByQlmcaguWhMbDBEj+QJJisCe
         q2v/bpKcJ8yfzPOeKUJj5wJOcci8+8eV3A+RwTOgVip4QIQ07Vw5QSw1srZGLamJvlWq
         mfgMtnW8p4jMjdi8LKppQ5fIqDbSrJv75FZDSUtxXCZeaaCA2ViyJSIu+e1EMdmm9kDz
         Y7SQ==
X-Gm-Message-State: AOJu0YwnXY5Nvho1prb/FjE60pDIepD2tzGZXrjo/y7niCegigKQghyD
	+Dp08bQ306+/6mGH2SEV2NKsZlgCPnSveRKls/M6EoNfnJBQ4yDTXKyJ
X-Gm-Gg: AfdE7ckskW0vrT01vnK7YVrCYaXwUDalaIAf8P97x69S7Io5dqW8gT2oAxvnAyC95c+
	T54W+0/9hK1UDMhKaSES69LCSuW3TW5O/FDWmMlgefzM7s/QQZPan2l3PhrJo5ikHzxzAuUVY2S
	Orir+nZx5H3m3T/QVR4lwsT7AfKkhZH0J7lgbdC0jJB3br39ULMuJOlvzW3aUisRdbru+2AtZ8i
	FV1OS+C3OlRjXJGmHaq5iljzWT2rXwtJemGF2yTzEOWJKQiaiGZFMGvtxN4/Ad8REe1Row5qQYa
	51fUGKGXOnAE+d9Jg2dAzXC1jnby9CdJGjyRhdqo0oOiruSTEGbWOfPoUsf9ycJCxRf7bwmteTe
	AKuXaYAg9XM4yhPeNHQx9Oxip5wytUt1bn/9ocHvahaGF7NiuVGM94+heRof39GnPHppvMKkhKA
	8Nofry9IS9AjcQNbZL7OO3M0r2nGAWd1I4yzn4vvPvXDMWiI8ATOg9q8Ue+vCd877Rbw==
X-Received: by 2002:a05:6000:4b0d:b0:47e:bf36:a612 with SMTP id ffacd0b85a97d-47ebf36a65bmr328937f8f.50.1783613903292;
        Thu, 09 Jul 2026 09:18:23 -0700 (PDT)
Received: from mskvarla-mac.redhat.com ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm48135950f8f.30.2026.07.09.09.18.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 09:18:22 -0700 (PDT)
From: skvarlamatus@gmail.com
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	stefanha@redhat.com,
	skvarlamatus@gmail.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com
Subject: [PATCH v3] net/9p: add vsock transport
Date: Thu,  9 Jul 2026 18:17:41 +0200
Message-ID: <20260709161741.15138-1-skvarlamatus@gmail.com>
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

The privport mount option is not currently implemented for vsock and
returns -EOPNOTSUPP if specified.

Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
into 9pnet_fd.ko. This follows the pattern where socket-based transports
(TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
(virtio, xen, rdma) have dedicated files.

Usage:
  mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point

Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
Changes in v3:
  - Add port= option to vsock mount example in documentation
  - Drop unrelated typo fix in documentation
  - Add TODO comment for vsock privport binding
  - Clarify privport error message as "currently not implemented"
Link to v2: https://lore.kernel.org/v9fs/20260701155922.95502-1-skvarlamatus@gmail.com/

Changes in v2:
  - Add depends on NET_9P_FD to Kconfig
  - Use #include <uapi/linux/vm_sockets.h>
  - Reject privport option with -EOPNOTSUPP
  - Use fc->net_ns instead of current->nsproxy->net_ns
  - Widen vsock port to u32 to match sockaddr_vm.svm_port
  - Widen p9_fd_opts.port to u32 and port_str buffer accordingly (in p9_fd_create_tcp())
  - Add vsock to Documentation/filesystems/9p.rst
Link to v1: https://lore.kernel.org/v9fs/20260527073447.86538-1-skvarlamatus@gmail.com/
---
 Documentation/filesystems/9p.rst | 10 ++++
 include/net/9p/client.h          | 10 +++-
 net/9p/Kconfig                   | 10 ++++
 net/9p/trans_fd.c                | 98 +++++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 3f65db648db0..44b9e1b5eab7 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -50,6 +50,14 @@ mount points. Each 9P export is seen by the client as a virtio device with an
 associated "mount_tag" property. Available mount tags can be
 seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 
+For server accessible over vsock (VM sockets)::
+
+	mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/9
+
+where CID is the vsock Context ID of the remote endpoint (2 for host from
+a guest VM, 3+ for guest VMs from the host). The port to connect to can be
+specified with the port option (default: 564).
+
 USBG Usage
 ==========
 
@@ -117,6 +125,8 @@ Options
 			tcp	  specifying a normal TCP/IP connection
 			fd   	  used passed file descriptors for connection
                                   (see rfdno and wfdno)
+			vsock	  connect over VM sockets (vsock) using
+				  CID as the mount source
 			virtio	  connect to the next virtio channel available
 				  (from QEMU with trans_virtio module)
 			rdma	  connect to a specified RDMA channel
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd25..c0eca56c1f5f 100644
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
+			u32 port;
+		} vsock;
+#endif
 	} trans_opts;
 
 	struct idr fids;
@@ -151,13 +155,13 @@ struct p9_client_opts {
  * struct p9_fd_opts - per-transport options for fd transport
  * @rfd: file descriptor for reading (trans=fd)
  * @wfd: file descriptor for writing (trans=fd)
- * @port: port to connect to (trans=tcp)
+ * @port: port to connect to (trans=tcp, trans=vsock)
  * @privport: port is privileged
  */
 struct p9_fd_opts {
 	int rfd;
 	int wfd;
-	u16 port;
+	u32 port;
 	bool privport;
 };
 
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 22f8c167845d..b0a6342e3475 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -32,6 +32,16 @@ config NET_9P_VIRTIO
 	  This builds support for a transports between
 	  guest partitions and a host partition.
 
+config NET_9P_VSOCK
+	depends on NET_9P_FD
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
index eb685b52aeb2..54aad5bb975a 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -28,6 +28,9 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+#include <uapi/linux/vm_sockets.h>
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
 
@@ -875,7 +887,7 @@ p9_fd_create_tcp(struct p9_client *client, struct fs_context *fc)
 	const char *addr = fc->source;
 	struct v9fs_context *ctx = fc->fs_private;
 	int err;
-	char port_str[6];
+	char port_str[11];
 	struct socket *csocket;
 	struct sockaddr_storage stor = { 0 };
 	struct p9_fd_opts opts;
@@ -966,6 +978,67 @@ p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)
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
+	if (opts.privport) {
+		// TODO: implement vsock privileged port binding
+		pr_err("%s (%d): privport currently not implemented for vsock\n",
+		       __func__, task_pid_nr(current));
+		return -EOPNOTSUPP;
+	}
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
+	err = __sock_create(fc->net_ns, AF_VSOCK,
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
@@ -1036,6 +1109,23 @@ static struct p9_trans_module p9_fd_trans = {
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
@@ -1073,6 +1163,9 @@ static int __init p9_trans_fd_init(void)
 	v9fs_register_trans(&p9_tcp_trans);
 	v9fs_register_trans(&p9_unix_trans);
 	v9fs_register_trans(&p9_fd_trans);
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+	v9fs_register_trans(&p9_vsock_trans);
+#endif
 
 	return 0;
 }
@@ -1083,6 +1176,9 @@ static void __exit p9_trans_fd_exit(void)
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

