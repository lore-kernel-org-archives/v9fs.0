Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B533DEFE
	for <v9fs@lists.linux.dev>; Wed, 24 Jun 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319761; cv=none; b=Wznon/AUYBC8juWOeCmlotbsncj6GEhBoakrAlS3MSkJwGNnkVz+oEs6R/+pvgqtJ3ryiI+XV5h1fnmWZfpalH9NcdJ/6K27djkHluCdbvzMyGEpEZ/sIl5EpoCT+GwmDjpclD11SDVh03cs0TaXZsqeoGdenNaPq27IqRVAS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319761; c=relaxed/simple;
	bh=X6kevZraK1RR6FVOJLEifcAgcM7lQtKM8zuaD58jkBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kecyb+X5yEd5m+KxNQi4QLmoBuVPomHKIMjLqc+TLD808FUTmJ3HzhM2jIVK5ZWeb3d1k+m1uarDBBTTxJpcmOgk0MCQGsrPCI6uZBErAza+gX8HVQELdfhrL8vmFttIEnC1GaPal3B/W9Isc0xwbSB/C5NXNRA4phjxjsX1OOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z58fDpxY; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z58fDpxY"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-9157f1be083so157260685a.3
        for <v9fs@lists.linux.dev>; Wed, 24 Jun 2026 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782319758; x=1782924558; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OEIsKx1YFXUdwec7xn+GP5SEzXKOgSZ1HtddneFwhs=;
        b=Z58fDpxYCxQGOyZ/6heopjHuzqCyabyYilWmdBudfTOVJIDy8UXLcXp1iih0pzlSiF
         D4740FpEJak9FZyZeJVqRo6Fahw1NABPNE6gH0BiHokHem9nATXjx4c+sByORTFYUED1
         gPYhAuaMUWa7XWIvtMDRURT7ZT57k1l6dHHWTuAvyLWRB1w5FzRmEqlnKG6LNafIydm7
         /w6ghXfW4nkLsIezHqXLXMaU65Kdhg+cOn5Ok4RT2YL/IoFu2AJhvO1BGxVNVlNiHAAi
         8CHm8fnc2b42V4SC7KWeNiwBgdO1fk4ThB94bYvIDWnRL2TifGDkIeDdU6PrHDdjAeob
         1N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319758; x=1782924558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OEIsKx1YFXUdwec7xn+GP5SEzXKOgSZ1HtddneFwhs=;
        b=CzAAJkKqfGm4ET8wTH6jAUW0tQrU1WE77Tgh6pDnTOaIVu9UW8j1YW5DWlHJi5dOdf
         gBLndxiOqjDObTve9Hj+7sZmAQcoOQ38xALm8ewSdagra5TuUu+dBgMHXjEba4gG0px+
         mLWXTkxgBnQdh0PCz7M5EWKYD/QSeCptB4bDbQXlH7n4lVSDKoq2yc1xevwbCIUctNyR
         lt6YTGYD429SCruRACOiQcqMQVIpyE28554ze39CCq71ifSeiNv8PbG5otD9ZZo0gBhk
         nL9xkmQ2gw+e8h7tZH2MNjv1qns3bPp892nmB5P6t5ucHuRe18SDPYl42OA7TbYBtRwH
         As6A==
X-Gm-Message-State: AOJu0YyamTAu4mFCAaD7wJ45WUEGcaiUJVafozdecOHLeBX0IMSiCbz5
	gfsomcht9DWhVfDVeooYrfSgfXAzOjuuyBGxtHn4aPmqMwXF3OetWZwNLai4tTD3bufPQex6xA=
	=
X-Received: from qknqj4.prod.google.com ([2002:a05:620a:8804:b0:915:96da:f339])
 (user=brho job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4445:b0:917:fcec:cfe0
 with SMTP id af79cd13be357-921d29f7718mr3068174685a.33.1782319757250; Wed, 24
 Jun 2026 09:49:17 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:48:49 +0000
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624164906.2877282-1-brho@google.com>
Subject: 9p: treat read return values of 0 as EOF
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

