Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A43B9DA2
	for <v9fs@lists.linux.dev>; Fri, 18 Sep 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699755; cv=none; b=qb2ktfO/1A2uUxOq7+D4D4qYN3sfZKhS4FqMdKXdIjn2/2JS2+OwsUKNBvV75BGI3L4zMWcbVfcV6t0AkcOZouMCmorEOc+5mFDSOgDWlBcojgaliuM16S2B0Ojd8iAsvHD9FxxmgjGS8TGcY1I0uB4yxBtXxlCqgrn718ND0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699755; c=relaxed/simple;
	bh=S4Vuo8YtaM3fxM4JniOrdvLWoJgGdyu8cvpbGNZfQnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukqNX2O7EvnQU+8ssR2mlkGWP2p2nwcWihnMn+AqXErYBDmsUq3qvfqbkpYpPExHumXiU5IPjUsLk9l9TBWNlPhnvoMypC5Rag3h2A/L6CUBfsAyBH/Jh247+k2xDKj+0WRthPFK7sMRjHq516iGkzL8TuqRx28gbxOVVJ5HAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol+QpkCh; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol+QpkCh"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so243395a91.0
        for <v9fs@lists.linux.dev>; Thu, 17 Sep 2026 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699744; x=1790304544; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTdSu3rvffDl6KxCGguwZ5xbCq9qGNFXPPkm/ugbL5A=;
        b=Ol+QpkChoyIplZOuO4cki3nMM0QP+zM/0aSUT46GxTGg82OO+7/bfqxtX+oiNaUMuF
         bdQHOu007Ygmmj6FH4IrMh3yRADCkn9AgHQzZGXY2/XevOB0Lt28f/U7KOlJnZimxvBQ
         wJ10l8IDUESAh6r/bkAynlPhDM+5pCB50okwRtWA4cjbpXYo4Bq2G6jPJzvEn1Py0ebC
         07qRxDFZVkLDcmO86/zuD9g4S8qvY6ZRaarTyRx46ZQ3xk+nvOPSMmu9RaItrj7uCpNb
         orKCeoNvgOmnVrVzk91K8ySJLnwvWV/2eGUdSnJiUDZ7q6uQeOYleLyPeanEm1IvExY8
         FTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699744; x=1790304544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTdSu3rvffDl6KxCGguwZ5xbCq9qGNFXPPkm/ugbL5A=;
        b=YwUNqc4mkLhRpydzlc9oS+4/3RJNkbSyRnv3URnamRi4tVMVKKjxJjb6a0VhLzgCf0
         hnVI9cwb/lVzJnD3EuzWjwkKvcNBl7BZlSh3G79eMGKva3SWA7Ah9oCfKxsY0F1rl04Y
         I++fcZ545uJ/J3lNVphEBDxzsa7KbFr472geVD4z3qi2j5NSTSYfdiWXxQkBm6xj9rJ3
         aOwm8o3qndj8WVL7nWDgAa3rDZnBMBo9U9g7dvJnY7vGb25V3LH6iWeem9x6G6+eEnI8
         c4kNPs31/mHkVVMKEHEM9+1GJbYQhOdhUMQV1yo5jsNcLrNFmmpXFYQgB3KnHmut/hHp
         hg1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmG1ab527AKPS3Lc3TMpQaRanvb6vtQ+q5xw5wCSPOMZVcYwPJV1a+b7iUl+//Z3QmoUG0@lists.linux.dev
X-Gm-Message-State: AFuF++lzZzaq00wNuyD+5EBl05yaNl81gFPRCKIAE8veEGOcAAPRmUYv
	Yf+/+94U3ZFjyfLYzro6vQoF3BVJ+45XtL7HG7CvTkGOym4bVOHOb0gs
X-Gm-Gg: AYBFou1+AxgOeh8dErrq+ZE4Nl23563Bazipyi7tSS626FDmYpHPVaThsw17qtNbDD8
	yP0T8ce/7vj5iscBRwF+Dsf3GrJDJtZOud8WybXlNUpiOhEhCZM8Q1rCt4IzgoeSu0L0hf1ZlNr
	yxed1WihNCL6UqJhXf4OAafIWcN9E4W5I8Rf8NneOCR5HVUDilnyDlQhgw8APV09TOmjzqxFRIk
	kYMuy62ljbrxMouiB0qNZRF2x9bSSx3JzaaoMPhMcGPbP/aszv4o1ign0QuqxeHZqMs2cb4LpUj
	osXaInKeshWS+feGcNv1odZSSwyzs18fpZOMiBzJYa5UZJjrA/O4qmjAMpCuF82Ix+KHSVK0s8r
	bza3rGApIAKaolVDeiieNuU52beVte2yrxe3buBE4w+d+2EBbX6Vu/YRQevPXxQBYREq5wO5pZ2
	6V1Z08bTPQI9AfN46JcnoITBV9eeuChF12ycjKYQKmLVWiqmUej/y0w9YU+mnZSKEIAt5pLltC/
	jkJMU/NyM4t5SiYVAyjMOy23+rJEOg9gmNnstrRQJGwGn6f
X-Received: by 2002:a17:90a:e707:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-39e54cf11c2mr2532091a91.23.1789699743563;
        Thu, 17 Sep 2026 19:49:03 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.48.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:03 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	jack@suse.cz,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v3 1/3] 9p: skip intermediate directory entry name copy in p9dirent_read()
Date: Fri, 18 Sep 2026 10:48:49 +0800
Message-ID: <20260918024851.51229-2-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918024851.51229-1-853555@gmail.com>
References: <20260918024851.51229-1-853555@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9fs_dir_readdir_dotl() decodes each entry of a Rreaddir reply with
p9dirent_read(), which parses it through p9pdu_readf("Qqbs"). The 's'
conversion in p9pdu_vreadf() already allocates a NUL-terminated copy
of the name from the wire buffer; p9dirent_read() then strscpy()s that
copy into the fixed 256-byte p9_dirent::d_name and frees the original.

The wire format carries the name length in 16 bits, so a name longer
than 255 bytes is valid on the wire and may well be valid on the
server's filesystem, but it makes strscpy() return -E2BIG.
v9fs_dir_readdir_dotl() turns that into -EIO and aborts getdents64(),
so every entry after the long one disappears from the listing.

Drop the second copy: keep the string allocated by p9pdu_vreadf() in
p9_dirent and let v9fs_dir_readdir_dotl(), its only user, free it once
dir_emit() has consumed it. p9_dirent is a short-lived stack object, so
the string's lifetime does not change.

Note that the VFS only rejects names of PATH_MAX bytes or more in
verify_dirent_name(), so after this change a name between NAME_MAX and
PATH_MAX is returned by getdents64() even though any later lookup on it
fails with -ENAMETOOLONG. The next patch skips such entries.

Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
Closes: https://github.com/microsoft/WSL/issues/41192
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c         |  6 +++++-
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..af00b79d801e 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -185,8 +185,12 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, curdirent.d_name,
 				      strlen(curdirent.d_name),
 				      QID2INO(&curdirent.qid),
-				      curdirent.d_type))
+				      curdirent.d_type)) {
+				kfree(curdirent.d_name);
 				return 0;
+			}
+
+			kfree(curdirent.d_name);
 
 			ctx->pos = curdirent.d_off;
 			rdir->head += err;
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..9f3079c6f386 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -268,7 +268,7 @@ struct p9_dirent {
 	struct p9_qid qid;
 	u64 d_off;
 	unsigned char d_type;
-	char d_name[256];
+	char *d_name;
 };
 
 struct iov_iter;
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 67b0586d807f..d4335884e0c0 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -770,7 +770,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 {
 	struct p9_fcall fake_pdu;
 	int ret;
-	char *nameptr;
+	char *nameptr = NULL;
 
 	fake_pdu.size = len;
 	fake_pdu.capacity = len;
@@ -785,15 +785,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		return ret;
 	}
 
-	ret = strscpy(dirent->d_name, nameptr, sizeof(dirent->d_name));
-	if (ret < 0) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "On the wire dirent name too long: %s\n",
-			 nameptr);
-		kfree(nameptr);
-		return ret;
-	}
-	kfree(nameptr);
+	dirent->d_name = nameptr;
 
 	return fake_pdu.offset;
 }
-- 
2.54.0 (Apple Git-157)

