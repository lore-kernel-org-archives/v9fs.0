Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51799188015
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737228168; cv=none; b=BNI0nTnaz0CxNrhd0+I4vuM+dJKwxZ7gMDtKrjR+qtkW9AwmoBJ1q4AYmbewTZ8lgYQbunPPw1ZuTRxDXcDH61kTGjmeGSCeattabdAPv8vgqNZD1xTFImb+fH9LM7nKKePW6sE0AVNHBYjH+g9sgssT0Gk1AUeYWuqrKZkvP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737228168; c=relaxed/simple;
	bh=uFtCfyj0JQO7P3f4iiZa0OTdPNxCzRac2TrCOcp0rB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dilcpMxoCOLoY6E0ukpgBe+f4cAHYvUrrggxQ4yD0fpNm/AF0s9sJN91SRy7hNa9dt9x4CZGOWbIkW9JfQ/m6Sbgk63giBSbhdFYN5DJiBhVxKfvBW2F+Fg0hy5Yz63pjuOr3nAGiA7HxZpog7BG/RyBARdtdF5O5LYLXTiREg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=PDo9D5hx; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="PDo9D5hx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E4C1B240101
	for <v9fs@lists.linux.dev>; Sat, 18 Jan 2025 20:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737228162; bh=uFtCfyj0JQO7P3f4iiZa0OTdPNxCzRac2TrCOcp0rB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=PDo9D5hxz//QHKyRP1myHPPEGWWDvSwq9xt7oZCoW6s5B55YQgjlA1joYKhkx5yvV
	 N8tg6cAeMjRhoSqO1C/VmGmfFvvtxwPO5t3NeLpmHsis5kHjPvDQSO8jCLdXZxUv02
	 fsqCKLR8eYhYxC4UZFdOfsUyJiaReKyyHyBCSoFSix0O7UV84349dI4Ui5um0lFM3K
	 YvkWW7qV/bx1n8Q0Fy9o7Q/BJNlDs83aqCRw/j/jUhAq986nxoz33B4hGs4SsN+qJz
	 b/4qe+wd8M6a79jM2hlwCF97QaVJxNzFqtEPs+b9MTd12sAk50wN1547qNT0zOjXmS
	 fLZ2Eu3QNlraw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yb61s6T16z6tm8;
	Sat, 18 Jan 2025 20:22:41 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	Joshua Murphy <joshuamurphy@posteo.net>
Subject: [PATCH v3] net/9p/fd: support ipv6 for trans=tcp
Date: Sat, 18 Jan 2025 19:12:36 +0000
Message-ID: <20250118192122.327-2-joshuamurphy@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows specifying an IPv6 address when mounting a remote 9p file system.

Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
---
v2 -> v3:
Replaced inet_addr_is_any with code that actually sets addresses.
Separated `addr == NULL` check to one before inet_pton_with_scope.
Removed no longer used function valid_ipaddr4.
Tested that connections to IPv4, IPv6, and privileged ports actually
connect.

v1 -> v2:
Simplified support using inet_pton_with_scope, initialized
sockaddr_storage variables to zero, and removed unneeded argument
from p9_bind_privport. 

 net/9p/trans_fd.c | 57 +++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6..fb9406370 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/ipv6.h>
@@ -954,64 +955,56 @@ static void p9_fd_close(struct p9_client *client)
 	kfree(ts);
 }
 
-/*
- * stolen from NFS - maybe should be made a generic function?
- */
-static inline int valid_ipaddr4(const char *buf)
-{
-	int rc, count, in[4];
-
-	rc = sscanf(buf, "%d.%d.%d.%d", &in[0], &in[1], &in[2], &in[3]);
-	if (rc != 4)
-		return -EINVAL;
-	for (count = 0; count < 4; count++) {
-		if (in[count] > 255)
-			return -EINVAL;
-	}
-	return 0;
-}
-
 static int p9_bind_privport(struct socket *sock)
 {
-	struct sockaddr_in cl;
+	struct sockaddr_storage stor = { 0 };
 	int port, err = -EINVAL;
 
-	memset(&cl, 0, sizeof(cl));
-	cl.sin_family = AF_INET;
-	cl.sin_addr.s_addr = htonl(INADDR_ANY);
+	stor.ss_family = sock->ops->family;
+	if (stor.ss_family == AF_INET)
+		((struct sockaddr_in *) &stor)->sin_addr.s_addr = htonl(INADDR_ANY);
+	else
+		((struct sockaddr_in6 *) &stor)->sin6_addr = in6addr_any;
 	for (port = p9_ipport_resv_max; port >= p9_ipport_resv_min; port--) {
-		cl.sin_port = htons((ushort)port);
-		err = kernel_bind(sock, (struct sockaddr *)&cl, sizeof(cl));
+		if (stor.ss_family == AF_INET)
+			((struct sockaddr_in *) &stor)->sin_port = htons((ushort)port);
+		else
+			((struct sockaddr_in6 *) &stor)->sin6_port = htons((ushort)port);
+		err = kernel_bind(sock, (struct sockaddr *) &stor, sizeof(stor));
 		if (err != -EADDRINUSE)
 			break;
 	}
 	return err;
 }
 
-
 static int
 p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 {
 	int err;
+	char port_str[6];
 	struct socket *csocket;
-	struct sockaddr_in sin_server;
+	struct sockaddr_storage stor = { 0 };
 	struct p9_fd_opts opts;
 
 	err = parse_opts(args, &opts);
 	if (err < 0)
 		return err;
 
-	if (addr == NULL || valid_ipaddr4(addr) < 0)
+	if (addr == NULL)
 		return -EINVAL;
 
+	sprintf(port_str, "%u", opts.port);
+	err = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, addr,
+				   port_str, &stor);
+	if (err < 0) {
+		return err;
+	}
+
 	csocket = NULL;
 
 	client->trans_opts.tcp.port = opts.port;
 	client->trans_opts.tcp.privport = opts.privport;
-	sin_server.sin_family = AF_INET;
-	sin_server.sin_addr.s_addr = in_aton(addr);
-	sin_server.sin_port = htons(opts.port);
-	err = __sock_create(current->nsproxy->net_ns, PF_INET,
+	err = __sock_create(current->nsproxy->net_ns, stor.ss_family,
 			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
@@ -1030,8 +1023,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	}
 
 	err = READ_ONCE(csocket->ops)->connect(csocket,
-				    (struct sockaddr *)&sin_server,
-				    sizeof(struct sockaddr_in), 0);
+					       (struct sockaddr *) &stor,
+					       sizeof(stor), 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket to %s\n",
 		       __func__, task_pid_nr(current), addr);
-- 
2.48.1

