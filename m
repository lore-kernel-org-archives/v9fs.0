Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB422BAC8
	for <v9fs@lists.linux.dev>; Thu, 16 Jan 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043839; cv=none; b=B5meKVix8qZVzQ4BuMnO2q+VVQifxJw4SKQ1THYRk6FUy7Kv3Qs2qFUz4SsnGoMCzKTi/2eY7clk41k7XytI/CX+xrZHrdkt9FAZzCSjTjzyEU3X/ACHWmtKVfOFwhQ0pIy2Vw1gQBc+iK33gegKkYPlkVPGC+pI7fuUHFq/mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043839; c=relaxed/simple;
	bh=9X1L4/7FkFuVTwnfkbqYsaceTtJKC9/AqQ6MFw/RUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzdlyP9hZgETLgFwYw3YStdIeAeD/RIsw4Tq6hApBerqIl9UhFETJ+3m6rF8iJXcg+D8nUx9tIQGvDXmQw81ghfz+c8oDykyHcc2rL1sZiWmuXxZY8jU3aLSy2r6ntnoxPAHCHt8MzZc5Wp0tVuykcNl5jtze2n6eFiq4U3azfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ThVz+yrL; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ThVz+yrL"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 01B2F240104
	for <v9fs@lists.linux.dev>; Thu, 16 Jan 2025 17:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737043829; bh=9X1L4/7FkFuVTwnfkbqYsaceTtJKC9/AqQ6MFw/RUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ThVz+yrLPeLr6q26htKXHnsB/ToGOuREJusnf47CiEyfo95tt2vNh9GVK0HIfrb6T
	 eTwazQJmGCjgTe4KXymrP9oyG7A0KDRCQWeJDX5y6ztMlhDzmvQxhhgL3PmGUAatFz
	 3b/qdig/qODTkbhEwRqUfH/XW7zebiPx5lvAKEgJceHK66HKPC2F9twhFu3P9i19lP
	 HJGpYD2n3+sJlm7KTJD6yTly4DoKGqTgn409lstRY4a9nUc//Y72RRbpqXy6bHff2x
	 0AuKlsfF2DlumSHgBu0gie7HZ1uRAN0f7tU1h6eQ9LCEiNGIWNv/cdVeHwTD5W7kBZ
	 N44utOxzgelXw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YYnrz4Qrcz6v0P;
	Thu, 16 Jan 2025 17:10:27 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	Joshua Murphy <joshuamurphy@posteo.net>
Subject: [PATCH] net/9p/fd: support ipv6 for trans=tcp
Date: Thu, 16 Jan 2025 16:07:03 +0000
Message-ID: <20250116160701.8024-3-joshuamurphy@posteo.net>
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
 net/9p/trans_fd.c | 50 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6..effd0261d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/ipv6.h>
@@ -971,17 +972,24 @@ static inline int valid_ipaddr4(const char *buf)
 	return 0;
 }
 
-static int p9_bind_privport(struct socket *sock)
+static int p9_bind_privport(struct socket *sock, int family)
 {
-	struct sockaddr_in cl;
+	struct sockaddr_storage stor;
+	struct sockaddr *cl = (struct sockaddr *) &stor;
 	int port, err = -EINVAL;
 
 	memset(&cl, 0, sizeof(cl));
-	cl.sin_family = AF_INET;
-	cl.sin_addr.s_addr = htonl(INADDR_ANY);
+	cl->sa_family = family;
+	if (cl->sa_family == AF_INET)
+		((struct sockaddr_in *) cl)->sin_addr.s_addr = htonl(INADDR_ANY);
+	else
+		((struct sockaddr_in6 *) cl)->sin6_addr = in6addr_any;
 	for (port = p9_ipport_resv_max; port >= p9_ipport_resv_min; port--) {
-		cl.sin_port = htons((ushort)port);
-		err = kernel_bind(sock, (struct sockaddr *)&cl, sizeof(cl));
+		if (cl->sa_family == AF_INET)
+			((struct sockaddr_in *)cl)->sin_port = htons((ushort)port);
+		else
+			((struct sockaddr_in6 *)cl)->sin6_port = htons((ushort)port);
+		err = kernel_bind(sock, cl, sizeof(cl));
 		if (err != -EADDRINUSE)
 			break;
 	}
@@ -994,24 +1002,34 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 {
 	int err;
 	struct socket *csocket;
-	struct sockaddr_in sin_server;
+	struct sockaddr_storage stor;
+	struct sockaddr *sin_server = (struct sockaddr *) &stor;
 	struct p9_fd_opts opts;
 
 	err = parse_opts(args, &opts);
 	if (err < 0)
 		return err;
 
-	if (addr == NULL || valid_ipaddr4(addr) < 0)
+	if (addr == NULL)
+		return -EINVAL;
+
+	if (valid_ipaddr4(addr) == 0) {
+		sin_server->sa_family = AF_INET;
+		((struct sockaddr_in *) sin_server)->sin_addr.s_addr = in_aton(addr);
+		((struct sockaddr_in *) sin_server)->sin_port = htons(opts.port);
+	}
+	else if (in6_pton(addr, -1, ((struct sockaddr_in6 *) sin_server)->sin6_addr.s6_addr, -1, NULL)) {
+		sin_server->sa_family = AF_INET6;
+		((struct sockaddr_in6 *) sin_server)->sin6_port = htons(opts.port);
+	}
+	else
 		return -EINVAL;
 
 	csocket = NULL;
 
 	client->trans_opts.tcp.port = opts.port;
 	client->trans_opts.tcp.privport = opts.privport;
-	sin_server.sin_family = AF_INET;
-	sin_server.sin_addr.s_addr = in_aton(addr);
-	sin_server.sin_port = htons(opts.port);
-	err = __sock_create(current->nsproxy->net_ns, PF_INET,
+	err = __sock_create(current->nsproxy->net_ns, sin_server->sa_family,
 			    SOCK_STREAM, IPPROTO_TCP, &csocket, 1);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
@@ -1020,7 +1038,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	}
 
 	if (opts.privport) {
-		err = p9_bind_privport(csocket);
+		err = p9_bind_privport(csocket, sin_server->sa_family);
 		if (err < 0) {
 			pr_err("%s (%d): problem binding to privport\n",
 			       __func__, task_pid_nr(current));
@@ -1029,9 +1047,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 		}
 	}
 
-	err = READ_ONCE(csocket->ops)->connect(csocket,
-				    (struct sockaddr *)&sin_server,
-				    sizeof(struct sockaddr_in), 0);
+	err = READ_ONCE(csocket->ops)->connect(csocket, sin_server,
+					       sizeof(stor), 0);
+
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket to %s\n",
 		       __func__, task_pid_nr(current), addr);
-- 
2.48.1

