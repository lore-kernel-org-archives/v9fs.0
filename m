Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C93C5DA1
	for <v9fs@lists.linux.dev>; Fri, 18 Sep 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699759; cv=none; b=OcduNlNW+N/wbIiONotoXwdP8/27QpmzM4/TngZ1hVHQOeX0eac1ooBMRN1NiW4zvOLgZjSV7SKnQaNuWiX3bq0mAPmk3lhxOTlrongi1aP+D84IaZ87PlzWNq+mNfY3O+uzH+GFDeHZiGusE0N+BhSxAjo7X7nrnP6f8cjXMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699759; c=relaxed/simple;
	bh=yjmkwbpeQMdmXCBXESN5xDVi7K/v6oHuMoxkmkDC8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/GulKz4IM3xXOCcN09FRblXajnkcZi2K1qIOVA20spwiOG32DnzaofXI/J3xJHNkYcGsF1hoFwkSBOzO3FO+LIRQY1KKBit2oEpl+aCLdTTSZGrAmtyF77J7vQHUnYaRnT4W/FBn1huSL41+VzkeP/gsgoQCqOpb3/6jT+Rl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmeqE9ON; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmeqE9ON"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso136566a91.0
        for <v9fs@lists.linux.dev>; Thu, 17 Sep 2026 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699748; x=1790304548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V75GajmH07UG7qaYgZOmgqCDwlXfTM0MKIoEOxgI2Ys=;
        b=YmeqE9ON/q40icoXCZwMsDE7JIbzQFlFpAzLhL3u+Z2byzvHo5tuvZtoszyq0C2AFd
         y3Ml+1sb/rAVYw9QSR0FdhPuhqpmvJBxIbC8gOrmkienKqK+vthonX8KblE5a42jRenG
         uLJiUvm59AWonH1NydoC1cUlGJEwUqp9+Yx6Q/ERSXq6XTvGJDDKRez7fpl4ZtABIdiy
         tc6oeUQIL4IeiJaNAxIhPstXrf/WZY79kCPKLGPaGARQ4JM8h78bL7REnJE6cbdVSRQi
         o8Je6+1fcseqLVEKAV5mhAXxQAb475z5efAC+w1GJ439xGau/U6ejfPAV2BCVpF9nmb5
         NjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699748; x=1790304548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V75GajmH07UG7qaYgZOmgqCDwlXfTM0MKIoEOxgI2Ys=;
        b=T6X/3wjk2olmYeK16Wg6yj6I83gYhqHHfZ0fxdhhSSo91vzFMbLwHUTduUa/07Hem3
         6Equqdf7eB9jxrQcwpEPOWNB8BVE6DbuGg65YSw9GZj3jWBMcrzrdB8foTEOuT5wSl0T
         3NVWYqE009MfejoKcE/0pyzGMse8F1tYIWseN7KRwS/FpPJgl8vdPn1BhvtJpdEn0ybf
         hYRHp+MUT+gjhQVConb1M5hMmvWXKhSyq4bU+3DH5ujzKjvcn9DLF5jrAXSU2Y9xVqPT
         ClaBLwUAy6h14QSq6wmi80X/qdOmYWzGeS5fRtDmsT7+Eisiw6PepoTsgyCQgpg5q00o
         sB7g==
X-Forwarded-Encrypted: i=1; AKwUvBxQ9ZaHtqUXybBj5JlR1R1oIUMZ3OZz9lwZRJb2KciHQAd8z4mqbjvaVcyFnCL55UbRzgu6@lists.linux.dev
X-Gm-Message-State: AFuF++mkNj/s+Ckv+n1uvyjtkUSp6fNvRmVMCgypp4bYsKEmA0cDUdr1
	fEdqaMZCLQC4fy2o3f8MCk/Z28wUUcr/+/CPSRyfhnzy3mpN6faMQBeh
X-Gm-Gg: AYBFou2CfvRsbKZAXdl0mlObfy7ViMi47RYLD2w38zPW5zdM7lGEUhMUDqL155jxqnI
	jTNAML12jglIR3tetao8H0z+a16kvBXGDakJmfmVQOS3b0P+UWOty9rOFydZdXi0Q8oMrMkTPdU
	iWb7QQGgvqpq7CPff1kOU9Ad3OfHo1b6F1+h3q8Xlwv665vhFe9NvIOshde/p1Sa+zEB2xnrWAt
	uoXnl98M5aqp5s73OsWcv4WI5z7yYV4bzA6S65us7lpArmW6PJOfhIWhL+HHiw+cqm/9jmHE1Ll
	94A5/6yTOnFnXSxF3G2bcIU4InDzMtFpECjoHBYd/k9a6AI81HUhUhTh/XwM5Ts9FX5aWfYiaHj
	bMsizo+CkzZnhJzpWphSRaBFmamwgCg1EJAheboQFkueh7mug+1CpgqTf6R8oHYzeriHz0QqE3I
	A3En2tqPenfF4y/x8FGXQQfdJb1xUR0D7j3age0DDAqQUz9z7zoP52N8/k/Vz70t2Va+hdBcMA6
	J6xAe7G9qSeouaOcwWr/hUZD/dAdQ4Gm+jzb6I3+ybp1VZ/
X-Received: by 2002:a17:90b:2649:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-39e54dce754mr2452791a91.14.1789699748336;
        Thu, 17 Sep 2026 19:49:08 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.49.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:08 -0700 (PDT)
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
Subject: [PATCH v3 2/3] 9p: skip directory entries with names longer than NAME_MAX
Date: Fri, 18 Sep 2026 10:48:50 +0800
Message-ID: <20260918024851.51229-3-853555@gmail.com>
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

The 9p wire format carries directory entry names of up to 65535 bytes
and nothing on the client checks them against NAME_MAX. Since the
previous patch, v9fs_dir_readdir_dotl() passes such names straight to
dir_emit(), and the VFS only rejects names of PATH_MAX bytes or more in
verify_dirent_name(), as -EIO, which again fails the whole getdents64()
call.

A name between NAME_MAX and PATH_MAX is therefore returned to userspace
even though every later operation on it fails with -ENAMETOOLONG, and
POSIX requires readdir() to only return components of at most NAME_MAX
bytes. Nothing can use such an entry, so skip it instead of returning it
or failing the listing, reusing the strlen() result that was already
computed for dir_emit(). Log the skipped entry at P9_DEBUG_ERROR, the
same level as the strscpy() failure message this replaces.

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv/
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af00b79d801e..08d1a3429654 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -173,6 +173,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 		}
 
 		while (rdir->head < rdir->tail) {
+			size_t namelen;
 
 			err = p9dirent_read(fid->clnt, rdir->buf + rdir->head,
 					    rdir->tail - rdir->head,
@@ -182,10 +183,14 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 
-			if (!dir_emit(ctx, curdirent.d_name,
-				      strlen(curdirent.d_name),
-				      QID2INO(&curdirent.qid),
-				      curdirent.d_type)) {
+			namelen = strlen(curdirent.d_name);
+			if (namelen > NAME_MAX) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "skip dentry: name length %zu > NAME_MAX\n",
+					 namelen);
+			} else if (!dir_emit(ctx, curdirent.d_name, namelen,
+					     QID2INO(&curdirent.qid),
+					     curdirent.d_type)) {
 				kfree(curdirent.d_name);
 				return 0;
 			}
-- 
2.54.0 (Apple Git-157)

