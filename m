Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E919D89E
	for <v9fs@lists.linux.dev>; Sun, 31 Aug 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668382; cv=none; b=IjrnOQ+1NTduSp89ItHdtwF049bJj/G4+QXPjusyTp5xAZJBnkqKLC07akkb/XaeyGcnly6cXJertic6rvkeQ8TlKoR8P43WHqt51SeA+Tavll20kv4gLFpUB/JoHHTrR/xzGseDDwS/jSt+Sp2EAeBtA9IRrhngSs4U78exJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668382; c=relaxed/simple;
	bh=DRcLIFuIOSuESQ2ofaXfG+0PDFNlbm73jo++sagk/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieWBjYdfCc82h6BKUsclu88rk6lNdjZupJUi3Ywl7uMHTG+ylz9X3071k6FbToSShJngDNkwgORtQinlkRtAryfO4oeqhP+dTv+QRVKvNLUkZgra1HDVv5zAbirpDbDfLq8Gy0nWDbq3LEsTuuH3vi18BrKXXIDMBnBuEYBu60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=QwZzsfOS reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=d035IRdE; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="QwZzsfOS";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="d035IRdE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756669281; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=; b=QwZzsfOSAxC71SK1wA4xApvbrk
	55Ok/S/zlHBoLoatJgaFh7SdQtUxFRPTgFMqbLeBe3eZvhiVkF9eeVDO5u1IY6NljozN5+a2t/J46
	v8kXmW2pujmQCvDkvT6YGB+knh7RizM2DcBxFqCdae1NHe+IKoIGmdTjIBKTol8nHY+Q3cYNouGlq
	6xWW2bVbSQ2FE1cKw4b6xWeQkWOM9NF8gZVF/k+TJk9SqAT1nNv+UKG59qas9wtFeUI5Nc8HPkc3B
	uA1AJrY+ceLfOlC+MJg7SgK4kz4iiufjZwCNQrRsvNfyz2LX6BvgHCSjGBu/f6nA4BvmlvoD3QKXE
	69gVI7DA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756668381; h=from : subject
 : to : message-id : date;
 bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=;
 b=d035IRdELrJyH1xmL1sMqzAduu9WFt+usEcj0A5qhKQYSckJnY7RZ6DBOH+4FkwAdel5K
 GPEWqDrGkfqUDQLGZMsIwxOP1zeTlUr5oOOY0SmF3xXO2pTfvXXl0plcVSqRGa40bJ7S6B0
 P1vCNP2DrwZphW9fWp9U6iqZjO2bbGZjvtFYEOcWx9NsNqvmvT6JNEGdPy6QB4XKapWLC6P
 EcO7eJlDUjhCo6tBEjVHtOrOmBQwucD7r90QqDm117LlV2Ra/HYwOz4MQZeLpqA6fqGDn9O
 J5B4G27sPGZLErs5ihNtMNJoGxBFNnMhX+U6Ac3XbJAZS6l0g6nD5RnPxQEw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYr-TRk4Kv-5d; Sun, 31 Aug 2025 19:17:57 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYq-AIkwcC8vNym-KDcR; Sun, 31 Aug 2025 19:17:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 2/5] 9p: Introduce option for negative dentry cache
 retention time
Date: Sun, 31 Aug 2025 21:03:40 +0200
Message-ID: <18f109c2d62d0529511957f3c2a492374d01e63d.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 7FwAmk2sxDG9.Q3f7atZUMEj-.rtopvAM8LqJ
Feedback-ID: 510616m:510616apGKSTK:510616sJVlOeeiTz
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add support for a new mount option in v9fs that allows users to specify
the duration for which negative dentries are retained in the cache. The
retention time can be set in milliseconds using the ndentrytmo option.

For the same consistency reasons, this option should only be used in
exclusive or read-only mount scenarios, aligning with the cache=loose
usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 422bd720d165..7c0c2201b151 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -34,7 +34,7 @@ struct kmem_cache *v9fs_inode_cache;
 
 enum {
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -52,6 +52,7 @@ static const match_table_t tokens = {
 	{Opt_dfltuid, "dfltuid=%u"},
 	{Opt_dfltgid, "dfltgid=%u"},
 	{Opt_afid, "afid=%u"},
+	{Opt_ndentrytmo, "ndentrytmo=%d"},
 	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
@@ -110,6 +111,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout != 0)
+		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -251,6 +254,16 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				v9ses->afid = option;
 			}
 			break;
+		case Opt_ndentrytmo:
+			r = match_int(&args[0], &option);
+			if (r < 0) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "integer field, but no integer?\n");
+				ret = r;
+			} else {
+				v9ses->ndentry_timeout = option;
+			}
+			break;
 		case Opt_uname:
 			kfree(v9ses->uname);
 			v9ses->uname = match_strdup(&args[0]);
-- 
2.50.1

