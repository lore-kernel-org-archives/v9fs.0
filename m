Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D571750
	for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150756; cv=none; b=bS2sj0hLq0cKhcPrwclpeKUbqmDXCpJ5tqKNARt+Lsu6kIXyrJ5JMDFuDW2axd2hpn/Y1mhGkWvWaK7VZeCy5C835vgTqkUyDQ3fJJ56/FfVkvAehASO6+zo2w2jZAMTfEK7bfByPerZ4463b+dZSliUE3ZF0GjiqtOB7JncQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150756; c=relaxed/simple;
	bh=e+gg/myfELzcSTxooWS7t+deCwKlkhzvZzDwqnFT+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yx23u71JCc9Fg7wHlV7eSYuKiMuLAeChnxcW3TYEnhsEUA4OivvzJXUr3pDsVndsvSqMDuRSZiBcWJLYohohoro3qhNInlJnFTJe/uhlf7ro/ljr/rpt93XQ6AdmjnIaTR/c342p/ZYzMH4wPMbDYvZgwck/uWR+mz6i5txIdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=c754QBqd; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="c754QBqd"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D8D7E240103
	for <v9fs@lists.linux.dev>; Fri, 17 Jan 2025 22:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737150745; bh=e+gg/myfELzcSTxooWS7t+deCwKlkhzvZzDwqnFT+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=c754QBqdrPnxmA9ewMSNudNFYyliAcdtWTIlgeldwZC2ku3hmW378zqGcQtEKoyUZ
	 0gIzrzgZPhdGa3q3mp6tjt9EriMlUCsurVzJu/r9S5gXhUstTHcFdZtXwSQWZFqBlF
	 E2vTD8LAvbsHgezbekaBsIyliwlQE1+LdnsOxXiIJpmVggpWIzBZrydv5v29awb/Gl
	 wQDZisibhBDVIQt0I+aJKYQEfmibJpPYEjBcIrr2elC5YDGoIh4KSCfGi+03UxfLw/
	 KRF4IZm1gsi/4JD8x7+1hNYyQVSZ4wsZSSDZR2PvAjuQWlTYGqW7YRkzsrmaMbIgU2
	 9CdEAuhRUIo1A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YZYP43ndNz9rxB;
	Fri, 17 Jan 2025 22:52:24 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	Joshua Murphy <joshuamurphy@posteo.net>
Subject: [PATCH v2] net/9p/fd: support ipv6 for trans=tcp
Date: Fri, 17 Jan 2025 21:44:46 +0000
Message-ID: <20250117214943.6368-2-joshuamurphy@posteo.net>
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
v1 -> v2:
Simplified support using inet_pton_with_scope, initialized
sockaddr_storage variables to zero, and removed unneeded argument
from p9_bind_privport. 

 net/9p/trans_fd.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6..eaf72067e 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/ipv6.h>
@@ -973,45 +974,48 @@ static inline int valid_ipaddr4(const char *buf)
 
 static int p9_bind_privport(struct socket *sock)
 {
-	struct sockaddr_in cl;
+	struct sockaddr_storage stor = { 0 };
 	int port, err = -EINVAL;
 
-	memset(&cl, 0, sizeof(cl));
-	cl.sin_family = AF_INET;
-	cl.sin_addr.s_addr = htonl(INADDR_ANY);
+	stor.ss_family = sock->ops->family;
+	inet_addr_is_any((struct sockaddr *) &stor);
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
-		return -EINVAL;
+	sprintf(port_str, "%u", opts.port);
+	err = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, addr,
+				   port_str, &stor);
+	if (addr == NULL || err < 0) {
+		return err;
+	}
 
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
@@ -1030,8 +1034,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
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

