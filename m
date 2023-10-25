Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F922266C3
	for <v9fs@lists.linux.dev>; Wed, 25 Oct 2023 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="n4J43Ocj";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0UFC36EI"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 4A2FBC021; Wed, 25 Oct 2023 12:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698230099; bh=WMmE+1h6Xwn1xLkMKQHwODUtDZc1edPW0I8KanvCU4M=;
	h=From:To:Cc:Subject:Date:From;
	b=n4J43OcjALjXziE7yaAGF03U1OP8mDpOhObvXl36vrglDt92fFWnjRimMkCfpX/0m
	 VA9JdAIVhQ19Ty1NF+jbJXquzaYpuNPk3EQdKMoSbafpUFMIeabnd19Q9bTBBe1y0B
	 rOpCkUy9ikzRF4+AjJLxBRy5yVYRM24m8C5ks2yYVXfejw/AWmROU0Q8+pS4+l9XxQ
	 iYaPoBbrTFOVbzkyljWAG81FgipDBGu82Raj/+fB+pMG6A5baT+R6cnoh3Fb0ffP9k
	 swNSZtkJcjmgClH5dcppc9aX2b77677Dgfb2hpvRgDMVGkFSnTMFxlNGRn52pYiTTv
	 O5nkYaDay9Pqw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 6DE23C01C;
	Wed, 25 Oct 2023 12:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698230098; bh=WMmE+1h6Xwn1xLkMKQHwODUtDZc1edPW0I8KanvCU4M=;
	h=From:To:Cc:Subject:Date:From;
	b=0UFC36EIExrT623/E5YD4kWC98wdcQIxvuWxRoUMUrtMY+ygAqx4LV/oprP8zC4Br
	 cxQz/geWp84quDE4D5GTH+J8nARa7H7Lx/WVHsg5niBF/JMs8pRNI/EWx9qpsg2x/c
	 rvLbcwlHjbB52t1y04hVjoltBUres7EGoW6jSxD0UquJnHgC1QHL2px3Dnjhdj+pfk
	 boPjSRiQWtQnVNRbf/1as5QVYxEDDoDg0X7vvL0jzbGEecbgPsw4+BsDLvbEkZDNP7
	 DTcZb6TUmCtCLAMYdXxctutXwqj3h2qbC4Ytsmv9CfaUEdZfzo6419zGxVIzSckRL9
	 U+gJwkfYABf5g==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id 2192dabf;
	Wed, 25 Oct 2023 10:34:52 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 1/3] 9p/trans_fd: Annotate data-racy writes to file::f_flags
Date: Wed, 25 Oct 2023 19:34:43 +0900
Message-ID: <20231025103445.1248103-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Elver <elver@google.com>

syzbot reported:

 | BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | value changed: 0x00008002 -> 0x00008802

Within p9_fd_open(), O_NONBLOCK is added to f_flags of the read and
write files. This may happen concurrently if e.g. mounting process
modifies the fd in another thread.

Mark the plain read-modify-writes as intentional data-races, with the
assumption that the result of executing the accesses concurrently will
always result in the same result despite the accesses themselves not
being atomic.

Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/ZO38mqkS0TYUlpFp@elver.google.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v1 -> v2:
 - reworded comment as discussed
 - adjusted commit subject line to match with other trans_fd patch

(there is no change from the one I sent yesterday, I'm just resending
the whole set properly now there's been feedback on other commits)

 net/9p/trans_fd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f226953577b2..1a3948b8c493 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -836,14 +836,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		goto out_free_ts;
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
-	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	/* Prevent workers from hanging on IO when fd is a pipe.
+	 * It's technically possible for userspace or concurrent mounts to
+	 * modify this flag concurrently, which will likely result in a
+	 * broken filesystem. However, just having bad flags here should
+	 * not crash the kernel or cause any other sort of bug, so mark this
+	 * particular data race as intentional so that tooling (like KCSAN)
+	 * can allow it and detect further problems.
+	 */
+	data_race(ts->rd->f_flags |= O_NONBLOCK);
 	ts->wr = fget(wfd);
 	if (!ts->wr)
 		goto out_put_rd;
 	if (!(ts->wr->f_mode & FMODE_WRITE))
 		goto out_put_wr;
-	ts->wr->f_flags |= O_NONBLOCK;
+	data_race(ts->wr->f_flags |= O_NONBLOCK);
 
 	client->trans = ts;
 	client->status = Connected;
-- 
2.41.0

