Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32171D54D8
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753415; cv=none; b=MLrUN7HYniBaMF7VSvGnumfqvJN7jpuW7F28wrGPys9Pp4O6dZD3hBTeQm+Dbr8eI6eXaLW/PyD6GLGKXFkffCddcCC+zXX0JQ3M+7oWAWSQjzhjwScFKhP381cUfFvF2MFvYLrn/J01dD3zDvp5SUecp7ZsnM6ryL2kCFn3TaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753415; c=relaxed/simple;
	bh=UBeZXdicUjxTcLqfi5UqrN5fpkbIPKB2BDHkKQpKT24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkDIBy9JbA60U8I35ZsCQRFxy3O+1/jL9VjtRSgtY8cx+yha7GlegKNom3j7Pi6ZT4z7uxMpQWT8BX490nayNxM0ZbAPr0SO5FKo1W3okHWvaUrK/ya+cqi7yWAqvplRl5tOiDeuSz2377V8c35tIdw/SS+G4xX+Kv0t8zdJPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=NBJ6VK7v; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="NBJ6VK7v"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2FB01240101
	for <v9fs@lists.linux.dev>; Fri, 24 Jan 2025 22:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1737753406; bh=UBeZXdicUjxTcLqfi5UqrN5fpkbIPKB2BDHkKQpKT24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=NBJ6VK7veADFgrPVyZ1LX+W7gloXUIX/z5ggr1Cghv2/R2mYuk6BTn3L7yRSj3bA7
	 0EGnwjG4NKjQTIKPFd2BMpEU0LxeWXFXP0Saw1iI0IFSNxxQbDRqjLR18KRb3SfA93
	 i7Tkg0gGIkSLJVotAQYGZkj1IydLZ9/g1pVU4Y/j3StF25UmtOsCOBb4O30VEnZiLV
	 IVkHGQe4YnB4Q9CJutlY1GbbuKidFMFZs0VntxuVXT1TRdmQJ4p0aXkCb4DKMb86Kj
	 ObnxznnwiPqQrumXSQn/F56sGbyk1WeYj8mAAPIFJihVUwaJGWf9Om1j/V74M/0AnA
	 26bPofpD/lCbQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YfrGh6M6Lz9rxF;
	Fri, 24 Jan 2025 22:16:44 +0100 (CET)
From: Joshua Murphy <joshuamurphy@posteo.net>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	Joshua Murphy <joshuamurphy@posteo.net>
Subject: [PATCH] net/9p/fd: change port to char *
Date: Fri, 24 Jan 2025 21:14:34 +0000
Message-ID: <20250124211432.5698-3-joshuamurphy@posteo.net>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The port variable in the option structs is changed to char * to
remove the conversions from u16 to char *.

Signed-off-by: Joshua Murphy <joshuamurphy@posteo.net>
---
 include/net/9p/client.h |  2 +-
 net/9p/trans_fd.c       | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 4f785098c..62be2073e 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -114,7 +114,7 @@ struct p9_client {
 			int wfd;
 		} fd;
 		struct {
-			u16 port;
+			char *port;
 			bool privport;
 
 		} tcp;
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 2fea50bf0..2874c7348 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -31,7 +31,7 @@
 
 #include <linux/syscalls.h> /* killme */
 
-#define P9_PORT 564
+#define P9_PORT "564"
 #define MAX_SOCK_BUF (1024*1024)
 #define MAXPOLLWADDR	2
 
@@ -49,7 +49,7 @@ static struct p9_trans_module p9_fd_trans;
 struct p9_fd_opts {
 	int rfd;
 	int wfd;
-	u16 port;
+	char *port;
 	bool privport;
 };
 
@@ -746,8 +746,8 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	if (clnt->trans_mod == &p9_tcp_trans) {
-		if (clnt->trans_opts.tcp.port != P9_PORT)
-			seq_printf(m, ",port=%u", clnt->trans_opts.tcp.port);
+		if (!strcmp(clnt->trans_opts.tcp.port, P9_PORT))
+			seq_printf(m, ",port=%s", clnt->trans_opts.tcp.port);
 	} else if (clnt->trans_mod == &p9_fd_trans) {
 		if (clnt->trans_opts.fd.rfd != ~0)
 			seq_printf(m, ",rfd=%u", clnt->trans_opts.fd.rfd);
@@ -804,7 +804,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
 		}
 		switch (token) {
 		case Opt_port:
-			opts->port = option;
+			opts->port = args[0].from;
 			break;
 		case Opt_rfdno:
 			opts->rfd = option;
@@ -981,7 +981,6 @@ static int
 p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 {
 	int err;
-	char port_str[6];
 	struct socket *csocket;
 	struct sockaddr_storage stor = { 0 };
 	struct p9_fd_opts opts;
@@ -993,9 +992,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	if (!addr)
 		return -EINVAL;
 
-	sprintf(port_str, "%u", opts.port);
 	err = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, addr,
-				   port_str, &stor);
+				   opts.port, &stor);
 	if (err < 0)
 		return err;
 
-- 
2.48.1

