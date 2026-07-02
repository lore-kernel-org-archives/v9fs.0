Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AA4779A3
	for <v9fs@lists.linux.dev>; Thu,  2 Jul 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983397; cv=none; b=shEzWhaHOEwdnKCsB39e0xTgIpK6y6bxAMf0WMqJhnd+/4O6tch3cUYnt3yUKnQKR0PL7XgGLCdBoUTvJ7JpPD3ZexXrxfzLXEwdfbmwAEQ59TiuQDIissEWFLsf/mpgMVGu/qPdO3puNc1DTxZa/IW31JzIyW3HehMm/ENCfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983397; c=relaxed/simple;
	bh=X6kevZraK1RR6FVOJLEifcAgcM7lQtKM8zuaD58jkBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IlHKN2deo3E/X4e9eCBgXX9qWtaWn5tdW3fXmQuG1+ammxpdVu09e9UFGA+vV97YWITgNSIz3XylmZ9oRkSuWy3tANcDO6QQ/wKwefhniPP1276WFLfZd3y9Vs27xIhnEA8PMWcvqu53GOBowBziFHDwzi5bwVmhdHLtUJYXcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XM+/KSd5; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XM+/KSd5"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92e82060977so49291585a.1
        for <v9fs@lists.linux.dev>; Thu, 02 Jul 2026 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782983395; x=1783588195; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OEIsKx1YFXUdwec7xn+GP5SEzXKOgSZ1HtddneFwhs=;
        b=XM+/KSd5G537V9SUA0uQaZUtZYUgT9pW2PJHwuRQqVgrVnTVz0V31ivrYUDhHBAqFq
         xCjUw2IXvuZCOsoOHmyaJ96T+azpYT0pECuvQpMwuIe2EjqqKY3I8ILLEUumMwWDY4kC
         7FPWR3RMm7gbLHfPuexEBIa6XGe3jkq/MD6iN1ihQAvEcZ1iRmKZPKjmL64JbBPjOpHJ
         nH0xxVzv262yOMO+/gifSZYRmW2cLdxaZH7z2zrR8BxxFPgx1KSNQwMYQq80yCfQXJhF
         GhVr04x/QY4jasXxBM7/HeDf2vt13TKv/zcUoByIFWRXNVLuZS+owoZNsBxv95t4yIrj
         yzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983395; x=1783588195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OEIsKx1YFXUdwec7xn+GP5SEzXKOgSZ1HtddneFwhs=;
        b=IIDSudBrb1pkXWOmSCkgZwyrMyWC39x3asUL/U8UFBV9+v8G99Rw5U0W6M4/jNKNK1
         leBU2zzNXXCRXmftGxZw8AEhUXs/sBly5liDFbgXSSbXmyBRgW7rGH9UZmZQ5rj2+S+5
         MhQpUXvr9OC7UY/lR3t5jKyc7CQ7PNBY0/YzGmXYL8i/tv3jy/WlcRzO5ktHjec8M1/0
         JHjbC7H/vdKoTmSwzoy4M6k8vhmbAWBu6QpkVOyZ2hmJv4SucdjkzLkYJa7Z7dsuxF/I
         vRcOSV1V1Oo2qjkhRSApVrCzCYaPEtQ7OzJfdjPrMEjFsTHk/AQsbSBzw+j4AbijfO74
         P6WA==
X-Gm-Message-State: AOJu0YyTnLJWOwC46XEDIqJUQ7w36Ro2cunyvhQHIx8/XxF9WrsoPcuk
	hUdYSfC82e+m+QkAv4Ht/qd2AJOJVEUNm1AvshOIiAciDZrCTeI1UYJkSZwpECP5bL+yzWVCNg=
	=
X-Received: from qkd12.prod.google.com ([2002:a05:620a:a00c:b0:92e:6be9:84d2])
 (user=brho job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:444f:b0:90f:786c:4a82
 with SMTP id af79cd13be357-92e69836085mr1262935885a.39.1782983395404; Thu, 02
 Jul 2026 02:09:55 -0700 (PDT)
Date: Thu,  2 Jul 2026 09:09:32 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260702090941.1298188-1-brho@google.com>
Subject: [PATCH] 9p: treat read return values of 0 as EOF
From: Barret Rhoden <brho@google.com>
To: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If your 9p server shares a synthetic file system such as sysfs, the file
size from stat often disagrees with the actual file size.

Treat non-error reads of 0 as EOF, except in the case where the request
was for 0 bytes.

Tested:
	git@github.com:hugelgupf/p9.git, served "/" on 10.0.2.2

	bash-5.3# mount -t 9p -o trans=tcp,port=12345,cache=none 10.0.2.2 /tmp/foo
	bash-5.3# cat /tmp/foo/sys/devices/system/cpu/online
	0-47

Fixes: eb497943fa21 ("9p: Convert to using the netfs helper lib to do reads and caching")
Signed-off-by: Barret Rhoden <brho@google.com>
---
 fs/9p/vfs_addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 1ac0b3dcc077..df420b061664 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -73,6 +73,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
 	int total = 0, err, len, n;
+	size_t to_read = iov_iter_count(&subreq->io_iter);
 
 	if (S_ISLNK(rreq->inode->i_mode)) {
 		/* p9_client_readlink() must not be called for legacy protocols
@@ -105,6 +106,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	if (pos + total >= i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+	if (!err && !total && to_read)
+		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 	if (!err && total) {
 		subreq->transferred += total;
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

