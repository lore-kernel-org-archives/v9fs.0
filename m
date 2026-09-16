Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8D51122A
	for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566870; cv=none; b=Yhy7QFKiwllwBCeMuymLJePJv8UDiw/Az47Ipx0uoJ/Vole7DixrwiqxJRhQkgQvDyFxJABIcBqbqUHxStQvNoQDxoFD/yT1ZqhE3WJGVTJUkW7maeEIk02Pdm7OZ7Le/LPlLkfFO6jpuyo7tD2k+ocdXcUzrWEZN6yEnxHBDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566870; c=relaxed/simple;
	bh=jC/eT3Fgr/1jGBrC1VIZPt9+PlqYd+hn/B8/vrobjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAvwLtRo1eEybWALfOUZEN92Brg5GJyZXlBBIhDMALEWlMyjxJwQz+hYZoFC3UV96XoCSQG7TbtRr2zyI6ZszhaWVH234XLJGEy3CYU9AXNT5A/pxA+XSlseCErWGtl4bh0Ha7og02nwNVA5ARwdXBglXaLO6pyCV6bDzmo96BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrtXfxmU; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrtXfxmU"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso21302815ad.1
        for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566862; x=1790171662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImWlbvVcHi4iWjIU7vTeQNiHcv8LdakD2zLIePBrQbQ=;
        b=nrtXfxmUXevXs1gdH9d+hpITKTTWhd3mHVPyXhkNLQODoVNSYDvdBWWBbGVUM+wVoT
         4IucgHnqOynfpBMzXRYml+mwT/ULgMFbJt586UQU1u23p6G2RVHBYUfBVdXqyJjQ/daK
         +DtYZyrwOliXo0Cgt+Ic/Sewet5/5z5hU1GZKpU5jlBFMkIco7CkPcrqMSAk7gVmHoYl
         zaO3U7/NifS3D4/KdPwAEfwUC+iHSsYUGKe59D9YNzf0Rr+31QShvDTWwm3gaNIK+twh
         4gzKGAagRVJnsT5gYe7Iankr1+8pp3XGSQImzF9gJid4skjMWs1mJK0oGBR83iivOmVz
         rtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566862; x=1790171662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImWlbvVcHi4iWjIU7vTeQNiHcv8LdakD2zLIePBrQbQ=;
        b=lh5O98u/52JCzH1dTQ8pv5BCCm8BBY1fs6lTVXub/E0T+UfBmKYO7++VoYFpbjKcjY
         WT8j+OgmWbZGGJYdxn7aFk5EIUgxLJHRPm4k3evw3Z484zMB0mGaGd0HTSddNT7p9JvY
         xtWA4oZs3NIB3ibMXiGV5qT+SRlLe6x72yb1Q5ndPLfhjk+5uoUsd+AR20UAlgotS4Pk
         XZY6DinXrfzQVgtpuwhyg55qdilfwiaZqMu20SHz0cR6m12u7UEK1YpZYLzQkfrK77FU
         8lNw8asMa/lMlH0aeP0eC2GZFGSL/xw+LGouJUjSAyMCrbOCIk9zIEMXnuzAl40EMNwG
         1VPw==
X-Forwarded-Encrypted: i=1; AKwUvBy5YOVIU4U9yS+prbnweGMDEENfz569Lt1uFCa/VcAZDtU1Jf7edYqfGeEIkdH4yeKzp0JC@lists.linux.dev
X-Gm-Message-State: AFuF++kp6uNU8QN/U4qOJTqpwWcbqKPssmxPkoJfjs9ooOq1112lzjYB
	79eG4vUg025iNLtVmlo3PBKqMGI1Mj0HufSvlfVQilxqhCojRizPAM0u
X-Gm-Gg: AYBFou3XVWsFlRg8u+EcBwzfXtPY3DPbMBOrHZP6SfMwvUwE2uBdeougcAYP+HngIhz
	2E9MKD+Z4o1YEgjlxUgxWUWlBHF2d7fRf2ySHGLm7sZzD7yREzMROmE5iA0H2xnEHBuwf8fCBjM
	MjzsgR2Te4EA4sIvd+RHKZatHtnCP3pv6s+p+Gzk8hHbCOu034YB0dtcjmtFacjUUvYeu5d0dYz
	QtY0m7UOsmSpvO9hhQXPMdQmaWxGtnDo43LPSgncG+9gzYxziI+w0YeL80Rkuwefw5gsT/SGFWa
	JpY2D7/VSClfLuhio58ai1S6tbrX6E6Hrjw01cqCioJ/1pOR6mscIulXIAF2oi6b+ePaBEVATDS
	4uS6d8bzWUfKaeotgajyGXigRF/r7DBu8fUhzdGQJgeg8HHISacHikJIaU77vOyfnPmbCSI+pJq
	v/L7O5Kd5TJo2c9sJLinc27mwqJW7r7Wu/kO3549Hu7U30TkpcKZVMZnqk4kcXGF1djAEnHn/ro
	2aujqZCzR/D4hhuJ1vI1ybacfBvsuTD1LhbtdIUWyPYJ/F8
X-Received: by 2002:a17:902:f64b:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2dd8dd0b0b9mr58603325ad.2.1789566862228;
        Wed, 16 Sep 2026 06:54:22 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:21 -0700 (PDT)
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
Subject: [PATCH v2 2/2] 9p: skip directory entries with names longer than NAME_MAX
Date: Wed, 16 Sep 2026 21:54:03 +0800
Message-ID: <20260916135403.15789-3-853555@gmail.com>
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
computed for dir_emit().

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv/
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af00b79d801e..ad6fdc99883d 100644
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
+				p9_debug(P9_DEBUG_VFS,
+					 "skipping entry with %zu byte name\n",
+					 namelen);
+			} else if (!dir_emit(ctx, curdirent.d_name, namelen,
+					     QID2INO(&curdirent.qid),
+					     curdirent.d_type)) {
 				kfree(curdirent.d_name);
 				return 0;
 			}
-- 
2.54.0 (Apple Git-157)

