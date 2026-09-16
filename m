Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5E5013D0
	for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566866; cv=none; b=CK/EQ+ATFppY2gnCWHbb7bXV66ohWA4ycJVW3mv9q1t2cYG7G6S+aFj/95kc+xp9O90W6c5pFz4a1N9493UkkWauNGQ2AMFTSJ8hDe6ySJhtCpdK6mOBRXghCT59CapwT3NjtYnYqzgjEhKVeLtFIRnYNyEQ3NSrJ+LNy2v8DlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566866; c=relaxed/simple;
	bh=+07jS6PpQwh1XfOQpyTSGTMrH6P0pjfnNQhjeJqFLyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGvgPQEVS4il6p24AF9M+VcLSQdpcLKt1nWfE9nQNauu5wdgatueL/9jLxPk+5Dl3h3VWZNCICG5p84DWkzwaIcpHiRd90YB2Ui9SqSdW4WJOk5++Np1YLZovSEdTkKaXak2AXtUl8qvFZmkXBiIqgfIxjtxEbfPJJFQe+N+ejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXC0ixSZ; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXC0ixSZ"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd8923e7abso9131915ad.0
        for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566857; x=1790171657; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkamZhdfow2jKHw/yQZCsOWhCpUIj+tm8XFno6yYVFU=;
        b=HXC0ixSZ2Emq142rb8HQMgNK/aZ/4ZEvmqiop7Uy66qbuEBw+VDRxDYapNK6BES+lO
         tSyPBFzcH4wTT94CzFuV6qntP7D46bu/QP+hZwleeaT9Yg8Q4UY33F7T/Yyah+1fY0aY
         tTigxBOu2ogSGMc4Fo2tcTYIhDTVE38eI0IEpWI266XIDxbNy/vPKslYSAG+gOI3kFRT
         1BPO9WJSPi2Tzs6HeQx67JPSqa1cduzN/K9KW/9NRmSf4H7gVsZRgjXspTynJX5x7m0E
         yAFID32AYdRto9KkQ+o95EttZHlk0oHNFdxFappJULyXcvBT5AwX55gFSLZNk8On1Oz+
         slAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566857; x=1790171657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkamZhdfow2jKHw/yQZCsOWhCpUIj+tm8XFno6yYVFU=;
        b=Jq28SYxZ4m8iWDHqtaH+LRHndMRIi8CH77dmMEvxRFCVVUv1o62NELUA716d7hY0mc
         LburwkM1/hQVBhR60AlDVAcymLDqdHljUlAb7nrNi0C3hDSJOu3c19Qg0ZRDn3eboReM
         LOCB2VrgXWq+zAuxjyh2IoUHiN5WQq5D04rHZ8e74Zob4M5XtcEhLwwwbo9tri5RfSH1
         ArLGI0b5iR+UIIpyx7OgiFZQpJE6EHcM7/nE6vuhIvUk4BAcwylYM+39ieYMnDRzp5U6
         TnPjfzg3MsBmC1onJYkdJ/H8Xe7ketX/eoyqL89m9oRuXDmsVsdoOTEJ3KlZc8bw+tow
         FKZA==
X-Forwarded-Encrypted: i=1; AKwUvBy8sAoijvtsemMal4IF3D4Zv6/on30veruNfG7l0KagUtXjXs07PfUIDv9SeZ622tw9QosF@lists.linux.dev
X-Gm-Message-State: AFuF++kOKpCFu/peHG39o9V2dQSCb/HIMjnWN7QGL7gCOXOULwFeN9/b
	jrrRg9enYu0NBAiQBVh8wZHmcpxskqbs3wFFKHrxkD+v0LOu07irB1zC
X-Gm-Gg: AYBFou2dgXQkud1ICU3hCw1WDu61nQ7LmzIAWfoXf+KuIz9KHKzj3H/cXSgvoLELGiq
	0vfgblasEHmJDzu77FxMeHuGBUtjZrSn1FAxU/2ykrndet/qIX9jiLg6MVRsejINJGkabLDvSH2
	NdVC5o/gXPsRvfbnhEcSCl0qkv/Jck4lKah/v1zaFAr+wnEM9Nz1x/CWzObpSseAJ6wcZMX2chA
	UBsvFdOAhFhF+j5zP1KRwDTThQ27CaO+y+xMaEBFTAgEcCKxQ1GBtXnhQcx54VrvB7Ld8S9U3wr
	euILFiQ6lyBupwhWqFQhsXaJhqHqv8XNgHl0hGxS6GgU2HgEDJhnKqsBYKLARmYzv51fKs4SCIe
	0Wlv160i6KrWUkl3p9sfRB5MzTA20t58HmaPh5RcVGSfrtum7V1GZ/408w4IJAxxgDXMwL7pPpM
	xZ2/I3DZNEcirjSUMMICQeaY0YiysZgDJ5PK7hzmjV055nTxWQfrC6TQkLhnJq96H9Wh6sJ9utf
	e17vgd1teO6zX4bioB+QV+AuanXRX7p2gGHSepWzeKOPUXjkOVth7u15TE=
X-Received: by 2002:a17:903:2f82:b0:2da:eba4:b640 with SMTP id d9443c01a7336-2dd8dd1c7a1mr57691465ad.6.1789566857040;
        Wed, 16 Sep 2026 06:54:17 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:16 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 1/2] 9p: skip intermediate directory entry name copy in p9dirent_read()
Date: Wed, 16 Sep 2026 21:54:02 +0800
Message-ID: <20260916135403.15789-2-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916135403.15789-1-853555@gmail.com>
References: <20260916135403.15789-1-853555@gmail.com>
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
Assisted-by: Codex:gpt-5
Assisted-by: Claude:claude-fable-5-1
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

