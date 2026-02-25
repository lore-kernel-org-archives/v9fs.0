Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB83D1CAD;
	Wed, 25 Feb 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027868; cv=none; b=qo49PG2cTC/wrKRuqajeHAARt2c/Rjzv7v5t9U1oKZ0+6mUi5XGEoRe0ILG0Y/BoF3G25K5UKPqaySRYXm6gIy3Po2lNZ/+BYTKoNDFutAh26iMTF/z5R/pe2Es8YK5f91dw9n2IxIkoNfeJojz+L8TtrhYwtsrEsoBcfSbYvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027868; c=relaxed/simple;
	bh=jArpq8fW2tvyAK6bKALdlGIGmADDgGsoKnC8lH3PmDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWYDAVrh8bX3F9+ma/eYgKjAP23mDMpebRtL+r5MGXQn6N88l2QVHoUKeRLYm9JAUsSJcCaJExXY9ZNomqFUtsqmYYqQ+B/6ufo5h8DbgG8YzLz4NLtVNXCg274eYm6VYl9H6CAv87/Jaqbe2JNea248G+ZMoHXh7l2Y1iFbpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlHBOnLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlHBOnLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B485FC116D0;
	Wed, 25 Feb 2026 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027868;
	bh=jArpq8fW2tvyAK6bKALdlGIGmADDgGsoKnC8lH3PmDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BlHBOnLyIsLxXHK5IEg5QJvjAhFTWbfTXQ6ZxISLgQMh5BZOQQMnstL6hT5ln77op
	 1HxOM9Knn+AD3W+trmp09lpxXDbm2btFZyrcT3M8eL9R9AggY2f7oDUS1j7hYkD/9G
	 MX7vew0KZr30dN4bvldJrTarEKm2pi/h9XSnsTfWplrBbD7O+LIIgp5KdTM6vOOn0o
	 qql9ZPAkf3xhffQ7skMxLaSL0MFOYkLSS2GYjvIvBYWJ6IgYeDsdgBSglBhXkCRpS0
	 5tqbSDE+CUnJCci6WqQKK6esUbYguj2OLzdvk2Y1yoAn0vw3qZR7bb7lzSXsnje67F
	 RZePGJ0rAJ+aQ==
From: Sasha Levin <sashal@kernel.org>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	sandeen@redhat.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] 9p: fix memory leak in v9fs_init_fs_context error path
Date: Wed, 25 Feb 2026 08:57:45 -0500
Message-ID: <20260225135745.351984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the assignments of fc->ops and fc->fs_private to right after the
kzalloc, before any fallible operations. Previously these were assigned
at the end of the function, after the kstrdup calls for uname and aname.
If either kstrdup failed, the error path would set fc->need_free but
leave fc->ops NULL, so put_fs_context() would never call v9fs_free_fc()
to free the allocated context and any already-duplicated strings.

Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 0a1c4f7cb001d..431f24938a1d3 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -312,6 +312,9 @@ static int v9fs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
+	fc->ops = &v9fs_context_ops;
+	fc->fs_private = ctx;
+
 	/* initialize core options */
 	ctx->session_opts.afid = ~0;
 	ctx->session_opts.cache = CACHE_NONE;
@@ -345,9 +348,6 @@ static int v9fs_init_fs_context(struct fs_context *fc)
 	ctx->rdma_opts.timeout = P9_RDMA_TIMEOUT;
 	ctx->rdma_opts.privport = false;
 
-	fc->ops = &v9fs_context_ops;
-	fc->fs_private = ctx;
-
 	return 0;
 error:
 	fc->need_free = 1;
-- 
2.51.0

