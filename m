Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A414495538
	for <v9fs@lists.linux.dev>; Wed,  1 Jul 2026 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921597; cv=none; b=YPZbAfC1AVopHgftYEQH2nYyOh8fSzeEoMr02UAzKXK7VEKf6Wc57ps7P5euje1dXsFag2eiTlz+Ln8pzIjuyvD27kEQJd2mkpZI8gprZiTnByByd9EfndegJWlvExloRI6UfQn0LsApPxj6Gu6DmBHiVEZ/eQcxge8PVAyC1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921597; c=relaxed/simple;
	bh=/Rbzez6OSn0Ne6QpmaCrOlRbTea9JTBQjVIlOTIm5aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw4FbbZxuOGWoPdUHdKuplO6+Z6hPtbtYYYk/mcvKO+vzoRzVgeVSqd0GaXCPopHQ4JSuJomAAJjhlrxHPhb8icXSzvVyjlrJC3Cane3+ZCcejHWgWa+8pCOs/RBXwAzjaXpQFaQDtuplJjWhe4pexQmHSrx3Gb3Aw4wRtfdnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaP92aO8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaP92aO8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4939a809b24so8038415e9.1
        for <v9fs@lists.linux.dev>; Wed, 01 Jul 2026 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782921594; x=1783526394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Zv4szbiOCmaSd10e4M4H4VKLp4KVo+EvzxqVVVejA=;
        b=VaP92aO82fUxQ+FWI2XAEVS12gFTjyDxYhbJFkpHKJOJXKWiC8Kng1qTtsLqoEh5b6
         L2R8ZwZHyMh0X1VmXmN0LuiUUFUleCA7IPqiUjlhvkvi3xPMWlNEXNVNHz1x8wo0VCyj
         cE/BVzEt7nMMcj07bVUB21eGhnoDRGWl5wKtf5nUO3u4aRYbbkUibIcGvQMc/2dUtT+I
         axZ139ekm7tO7N3eqHKq7ipFx00EPcmDBpkceJZ9fdCfIHscHeAGAN3rxXCShDOL9d6R
         nhg0f8rmK8MoxC4MpMw+eTodjoP+kUw5K9JyCcJR95nmo9ytx3uEjiuHgXd1Wlzl76aA
         Qkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921594; x=1783526394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0Zv4szbiOCmaSd10e4M4H4VKLp4KVo+EvzxqVVVejA=;
        b=qNh7i7enAcx/2ovrvriYbn2k9AXvvfg+RyiemaX8JZGcxoS0ZA79E8w5F2AD40NvqG
         MVnbnZBSaoFTtCl7m+xBTxt0m0OyMJi+Zzydbag6QVOYwU6d2ZhwpfK5qFdU87nPKwAy
         imrhEEV9G7JeM6vIcz7YPFUuHm7rc+OLvJF+/d1/3jphizmEZuKYAumgUTCwCzPTzDk4
         ss2ummyfT6igh1Hqqw2pWQvERmuq/9xX8H6EmBKnfqt1MzxyRIb5iuxbn2znvny5bwqF
         b7v2A5mPs3jDSQWtlmpb5JjFAKFPxeOR3Hf0ePtqfIdTcJZ/+aXqOjkPmad4sbchclxr
         oqAw==
X-Gm-Message-State: AOJu0Yzz8EZcCQnUyJA4y4gxa1YUjyRobs9jEgfjk+mae/xTh/zwXqla
	Dh/d3xFlkNEaliITp5akt+b7WGE5CGCxiOwBkjSlQaylzXdA4fbOssb0
X-Gm-Gg: AfdE7ckQ/g/Or0dXyqBnPZReCJ+191CtfO/ngiFxcRXKBmTHBM6PDhN3UuzDik/hKTi
	mRuksTHsYzHfWnXC1vZeU6ydg1Af9Nak4MFNh8UBjyUhdD9WoeKXmjUV1WON/oNZRJMuOetn+Iv
	2EFldsmhpgKPzTwlq/5yUaTdP5i56r9UzLIEWS/ShZ2Hx5pOSJ9thO4Elh+njGMFDOR7h2NAr/5
	t9BSuHx2Wb8svjl9FUIkwPh5sU9t48A59Mw9IvP9cL+oJ5s8QZjHtHpIkVTxtl5Epsdqq/LgEkX
	y5T4Qu10i810MRewM5JfasBO/TmtN+6Khdufd1g1Vl981rN92d6xupmHvkluqfdlWzMwoCt0WJx
	PW5i2MnQFvaO8M4XnrsV5CCZEFBfzv7XqDtvvedojh40Fo9sj/AkJJ83ioqI2hO5uvbYvZ1k9of
	Ho7fdOnXM9l7PNMoSDE+qAfELdTp8YT+l3aNO9WaMpLakCR8Yl/NaC0pgbQ68pf2GITpOSNRs=
X-Received: by 2002:a05:600c:8b61:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-493c47f3c63mr5632275e9.5.1782921593630;
        Wed, 01 Jul 2026 08:59:53 -0700 (PDT)
Received: from mskvarla-mac.brq.redhat.com ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810bafsm79724475e9.10.2026.07.01.08.59.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 08:59:53 -0700 (PDT)
From: skvarlamatus@gmail.com
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	skvarlamatus@gmail.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com
Subject: [PATCH v2] net/9p: add vsock transport
Date: Wed,  1 Jul 2026 17:59:22 +0200
Message-ID: <20260701155922.95502-1-skvarlamatus@gmail.com>
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

The privport mount option is not currently supported for vsock and
returns -EOPNOTSUPP if specified.

Add CONFIG_NET_9P_VSOCK option that conditionally compiles vsock support
into 9pnet_fd.ko. This follows the pattern where socket-based transports
(TCP, Unix, vsock) share trans_fd.c, while specialized hardware transports
(virtio, xen, rdma) have dedicated files.

Usage:
  mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/point

Signed-off-by: Matus Skvarla <skvarlamatus@gmail.com>
---
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
 Documentation/filesystems/9p.rst | 12 +++-
 include/net/9p/client.h          | 10 +++-
 net/9p/Kconfig                   | 10 ++++
 net/9p/trans_fd.c                | 97 +++++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 3f65db648db0..d1bac30b3c9d 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -50,6 +50,14 @@ mount points. Each 9P export is seen by the client as a virtio device with an
 associated "mount_tag" property. Available mount tags can be
 seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 
+For server accessible over vsock (VM sockets)::
+
+	mount -t 9p -o trans=vsock <CID> /mnt/9
+
+where CID is the vsock Context ID of the remote endpoint (2 for host from
+a guest VM, 3+ for guest VMs from the host). The port to connect to can be
+specified with the port option (default: 564).
+
 USBG Usage
 ==========
 
@@ -115,8 +123,10 @@ Options
 			========  ============================================
 			unix 	  specifying a named pipe mount point
 			tcp	  specifying a normal TCP/IP connection
-			fd   	  used passed file descriptors for connection
+			fd   	  uses passed file descriptors for connection
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
index eb685b52aeb2..3e094ece863e 100644
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
@@ -966,6 +978,66 @@ p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)
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
+		pr_err("%s (%d): privport not supported for vsock\n",
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
@@ -1036,6 +1108,23 @@ static struct p9_trans_module p9_fd_trans = {
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
@@ -1073,6 +1162,9 @@ static int __init p9_trans_fd_init(void)
 	v9fs_register_trans(&p9_tcp_trans);
 	v9fs_register_trans(&p9_unix_trans);
 	v9fs_register_trans(&p9_fd_trans);
+#if IS_ENABLED(CONFIG_NET_9P_VSOCK)
+	v9fs_register_trans(&p9_vsock_trans);
+#endif
 
 	return 0;
 }
@@ -1083,6 +1175,9 @@ static void __exit p9_trans_fd_exit(void)
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

