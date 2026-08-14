Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0C1A682E
	for <v9fs@lists.linux.dev>; Fri, 14 Aug 2026 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680577; cv=none; b=ZsBHRcZjuTme5wIpYLOjlpPLY0ehpoJ0p/nRx7zJsueajC8iIaUQFNGaTy5w//fF6Y0JNmccIb6T83tOoLYHR706tVUrrNNcT3W57S8G4qo56nBfb2qkmzGjtbXEy6qAWv3+OywI7YzcpraGweEyK3ORbFPZ7WUILYj+TbArAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680577; c=relaxed/simple;
	bh=tlVdFl6hUxGVjFRXuOznxbth6/nhaj9rJTNS8zrlhrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EF0LbZgUjzmSDvjY398jR4bcpXoFvH3tGNgXfe8ivpMAWk5QkWAyHcWMVEA9A+OmLrChN7I1PZlggW+oTSO34lasTwqCNJPNXfGCaCwBJXwbsLUexSqLr5wz7SenQoHU4hHmA5CNgFQutSb/eNJ1O7wfJFozCJn9OBGqFnuNkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=l/tlOVIB; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="l/tlOVIB"
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:3033:0:640:ec58:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 32B08C0079;
	Fri, 14 Aug 2026 07:09:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id M9IIFbad5eA0-qR4lmRfT;
	Fri, 14 Aug 2026 07:09:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786680564; bh=Qpsbks4+D1vK8OMuZD9dOsWGbGGdWD19O8XU8KIZoY8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=l/tlOVIB+df1rb2sQB61DJnXWGkYgJjZDpBybDKnmv5P8P25C6udSnKI2euvnoCQg
	 QIGOrKrsA83CdDGo76ilLrWZDQXmDO3RQ+A9Oua74fZgPZAYFOMAK3MiH71H+pYKvN
	 5nvum+2KIpcy3PprnXGAJ1ztU38b2zIjMSFBcLJA=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] 9p: simplify v9fs_cache_session_get_cookie()
Date: Fri, 14 Aug 2026 07:08:26 +0300
Message-ID: <20260814040826.1213127-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the convenient 'strreplace()' to simplify
'v9fs_cache_session_get_cookie()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/9p/cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 12c0ae29f185..cb0e5b61e131 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -20,18 +20,15 @@ int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
 				  const char *dev_name)
 {
 	struct fscache_volume *vcookie;
-	char *name, *p;
+	char *name;
 
 	name = kasprintf(GFP_KERNEL, "9p,%s,%s",
 			 dev_name, v9ses->cachetag ?: v9ses->aname);
 	if (!name)
 		return -ENOMEM;
 
-	for (p = name; *p; p++)
-		if (*p == '/')
-			*p = ';';
-
-	vcookie = fscache_acquire_volume(name, NULL, NULL, 0);
+	vcookie = fscache_acquire_volume(strreplace(name, '/', ';'),
+					 NULL, NULL, 0);
 	p9_debug(P9_DEBUG_FSC, "session %p get volume %p (%s)\n",
 		 v9ses, vcookie, name);
 	if (IS_ERR(vcookie)) {
-- 
2.55.0

