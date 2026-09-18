Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E683DA7E2
	for <v9fs@lists.linux.dev>; Fri, 18 Sep 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699761; cv=none; b=IC7j1xdajCuT19yEHYmy5r0OgutcgNB6CGT5fLI9TSMPJvC1ADTGDQdTV5Hwd3RrHUIKCEvMqOH12EHXY/Blnny5gZr+DbFonS56MBnbyEBr/3Qe5z+jP9iE6mt+B24K+ZVnZwea2ysR+sVqBIJRf2/qN/QF57KVL4JPNu4xm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699761; c=relaxed/simple;
	bh=7mZyvLsdD7rZFz20RtO0OYHMdBvBnkDzPt/82DlOJfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6olHe1HwDGflKpJyTeo5tzoDfwDGYeKL/FAH9iMguW5de7ehMBKdD2fU4TDC9mxw6BNGiX6YK8n/eo3DtcYZ/JhfieZBuz/CJVlscH6ZYaMN+3wQMBAuPUeD2gLq/AxaxknK595fI8TATim/6IkcB1uucyXzKUkmtHiVH7vn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt+xOSP9; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt+xOSP9"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso953435ad.0
        for <v9fs@lists.linux.dev>; Thu, 17 Sep 2026 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699753; x=1790304553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zt8G0xpIOOhfoNc/LpRJ6HNqd0QOLFO5B7X1F4wwr9s=;
        b=Mt+xOSP9mnBCLsAOerGaDbbI2aHqbmvq8Aw7OhLLa19yi9D8YeQg4W/ZGO0gKwuPRd
         3CGRQvryRwWJMUF3k+G7FwPKZplzXrsYhxYS73e7alPV27EfwsuISqSBReRWMQqEGQvH
         vgNgJ6Nq4Mr7MNeSR3H95kFM9dlmGk0BXCgrlfHNYQvWlc76J3rH8U0HsCXiZetjdmr8
         IvmoR1MUMCrIaHG0qLFtzKytTBTTaJ1zeL7L86JUi3UCs938ofFsg5zpoVR3eH5Fj9WS
         mr7aDXHmGgNQNEhZg1dcG2aH3yMsxQGdnmAuBwTIp7KwZ9K+TkVX9S/ZBDM3FXWe01e/
         JKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699753; x=1790304553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zt8G0xpIOOhfoNc/LpRJ6HNqd0QOLFO5B7X1F4wwr9s=;
        b=s9kfiiYXgsMKuDSCITmVt2DyEGUdvmGnXRgwyH8Tlb8x4kmmLkmLOhUW42LyTeBWq9
         VkEedqHbFFRRK8LTuwx0wnkRaOOTddpcFT+iOsSTn+7y2Oy2rJzp/++nTNg74kLXdPq1
         c5mRMaUWXDLgg6nGeRHwU2DLk45wqewb6jfu8L2+H8TplEjSlQJ9xTMUFmE8vENCpist
         Hh7k7YdDyYrKZzpvVmfHKcvfZxvg+bMfvN+bU6PTVjXrmxW336qhL+zcXiyLKGGFf5Nj
         xKnbY9FBeA4PtZ7i1X/OoGGMej3/fDTt/ClSIzHtvhsY5tvomX8NaN4Mukb1mLhzB+Qq
         7sXA==
X-Forwarded-Encrypted: i=1; AKwUvBzlh+KrxJrjZqHxoCDGEjW7yZtpK22HwNOHbBepBUBE7CnBbzEfFtKLDR9ciBRW36jgIA6G@lists.linux.dev
X-Gm-Message-State: AFuF++nMpzEpKDbx3IAxNNHfbX8c8+L1Byz4MC83Z3VQ75rTx+MuBFu0
	ZLwP8sLMTlWdqA6SlMLL4BuAofjb6W+D657n1BtcJzihMRMlYxdK0dqB
X-Gm-Gg: AYBFou00JBiNi3fujhlJFnrT/+a9zQJfAQ9+qvNFvuJ33YMXMBT1/G8V/kNfiTYNrv1
	OW+1moE2SLiIwJqwAf1ZIvBk7jxLA99M0XehySxu3eP9YSom4FeFCGIZZxY7YlRwdK7jfyj2tsN
	yTeeXCmc+4+oGUBC7jtyTibZ/PqWccxkTybKaWNkbcuB8iHrNrJoiNWmGwheJYaIqiEadDJ/sSl
	TE/wDs/JD6FXI4uZqfqHk0JXdwlRqkijRGiX/GC7CoZMn8BflmNh9gs8Glo7wtn51ARx9UCIX1z
	9QC389BCYTtqNbboIQJo347gzwT5cOQEzSGS2VD7j7MY82SVTZ7xuT50nDu0PazijAVLoDSFlQf
	ScpDKhu7oOBnARAzP5PK9QMaOZuLZOoKtFibKsy3tTE37urKmCNofhagtWGO6VdJbdX3k/7l7Oq
	UMzzAYfoTTEiJY0ZUBk52MP6S1WnsNjR63gi8aviUe7zjezkHeay3H1zhyPzDXQaO9aBCcqU2uT
	vpMIirfqwUGeZZmd2+Y9jF4uAMXaQabzxlt04aPx6wmxCsu
X-Received: by 2002:a17:903:46d0:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2ddb1b04363mr24129965ad.13.1789699753092;
        Thu, 17 Sep 2026 19:49:13 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.49.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:12 -0700 (PDT)
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
Subject: [PATCH v3 3/3] 9p: skip over-long directory entry names for legacy 9p2000 too
Date: Fri, 18 Sep 2026 10:48:51 +0800
Message-ID: <20260918024851.51229-4-853555@gmail.com>
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

The legacy 9p2000 and 9p2000.u readdir path, v9fs_dir_readdir(), parses
each entry with p9stat_read() and, unlike the 9p2000.L path, never had
a 256-byte name limit: a name of any length up to the wire maximum was
handed to dir_emit(). getdents64() therefore returned names longer than
NAME_MAX that no later syscall can use, and failed with -EIO for names
of PATH_MAX bytes or more.

Apply the same NAME_MAX check as the previous patch does for
v9fs_dir_readdir_dotl(), so both protocol variants behave the same.

Note that this is a behaviour change for 9p2000 and 9p2000.u: entries
with names longer than NAME_MAX used to be listed and are now skipped.

Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lore.kernel.org/all/3910569.MHq7AAxBmi@weasel/
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 08d1a3429654..31de9ac913f0 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -119,6 +119,8 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			rdir->tail = n;
 		}
 		while (rdir->head < rdir->tail) {
+			size_t namelen;
+
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
 					  rdir->tail - rdir->head, &st);
 			if (err <= 0) {
@@ -126,8 +128,16 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 
-			over = !dir_emit(ctx, st.name, strlen(st.name),
-					QID2INO(&st.qid), dt_type(&st));
+			namelen = strlen(st.name);
+			if (namelen > NAME_MAX) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "skip dentry: name length %zu > NAME_MAX\n",
+					 namelen);
+				over = false;
+			} else {
+				over = !dir_emit(ctx, st.name, namelen,
+						 QID2INO(&st.qid), dt_type(&st));
+			}
 			p9stat_free(&st);
 			if (over)
 				return 0;
-- 
2.54.0 (Apple Git-157)

