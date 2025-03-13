Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68471E9B26
	for <v9fs@lists.linux.dev>; Thu, 13 Mar 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889325; cv=none; b=AhZDfJnnERaw0IpbPyjpU2wbrxvyGkJ5/YiPHsT1hkADdC4pFZ53RvMzw0p6eaCoYUxlPrUSKmWasXpOqMn59Ezdgvj5QfYEtqj7YyeroUZRJ2P0v6Ih/BW49Z/5yUq1iHaWBXpx+/WmCq+OLsJBbF5nzz+tBJ6DEx3dU0MdDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889325; c=relaxed/simple;
	bh=MXtePF6repqds/x6JPCzOwKs4bPaXnVnBSNXtX5OfIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MfWcvEHXrH9z2WQSduShKi48TT7ZLxqXFvBTmDkg8nzp/01/2e8DHHekNCb4FZs70uzBWaBPXDCvfYM/2zMNSsJigRlEUCXLoKIrgC0Mv9LhA+kKgJBJkxqR/BzgGtue1xT9kYYeEKp246tZw0xYVpfbfx9Tx8o3to2Ppm4Hqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=Ao39xEo/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="Ao39xEo/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741889320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oWH7hszwO9I5RYZpht/nXn68Y2cBdPRRedslDcO5mD8=;
	b=Ao39xEo/pSp/j5tAL4U5bRkiqX/8hAJD2h5Q3TQYeoM2KfRkAZOXysg68TccSm87i+b8UV
	kiREpjW7qU6Qz5NKsUVUQSnyPRUNScPmTvRmGLrA0zOQMJD51uK13Ub6Bq8SXcopsvd1VE
	7p3Zn+BdFU4Rjarkxrw6vR2AaFmrOwPBr8UlVsv32H+n6YPJ04zzwb7xuKMCLJB9l4PWdZ
	yBjQeWsgIXA8Fjn6KqCNIcpPA+5z0Y4LVRZ40AMGel90Z5xTXaDVtGl8rqS+TEXPS+AHHF
	K4lghj57TDh/oo+B50iD8d9RL/q4sqoc1cB84Av2UH7VZRWeFsP3gjRg8Pw/UA==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Thu, 13 Mar 2025 19:08:19 +0100
Subject: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
X-B4-Tracking: v=1; b=H4sIABIf02cC/43NTQqDMBCG4atI1k2JkWDsqvcoEvIz6iw6KRORF
 vHuTT1Bl8+3eL9dFGCEIm7NLhg2LJipQl8aERdPM0hM1UIrbVSnrHwNLmYiB8wuAOFMLvnVO/Y
 RpO6NncCGAEmJmngxTPg+84+xesGyZv6cb1v7W/8Mb61sZa8HMH0yttPhjkARyZdrzE8xHsfxB
 eL3bFzLAAAA
X-Change-ID: 20250308-p9_conn_err_benign_data_race-2758fe8bbed0
To: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Sishuai Gong <sishuai.system@gmail.com>, Marco Elver <elver@google.com>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com, 
 syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com, 
 Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Writes for the error value of a connection are spinlock-protected inside
p9_conn_cancel, but lockless reads are present elsewhere to avoid
performing unnecessary work after an error has been met.

Mark the write and lockless reads to make KCSAN happy. Mark the write as
exclusive following the recommendation in "Lock-Protected Writes with
Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
while we are at it.

Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v2:

Drop unnecessary READ_ONCE in p9_fd_request (that I added in v1)

-@@ net/9p/trans_fd.c: static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
- 
-   spin_lock(&m->req_lock);
- 
--  if (m->err < 0) {
-+  if (READ_ONCE(m->err) < 0) {
-           spin_unlock(&m->req_lock);
-           return m->err;
-   }

- Link to v1: https://lore.kernel.org/r/20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com
---
 net/9p/trans_fd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138af10e99ad04a76ee36a11f770c65..758eaeddf32b480e0a88914da66f923f7021e608 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -196,7 +196,8 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 		return;
 	}
 
-	m->err = err;
+	WRITE_ONCE(m->err, err);
+	ASSERT_EXCLUSIVE_WRITER(m->err);
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
@@ -283,7 +284,7 @@ static void p9_read_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, rq);
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	p9_debug(P9_DEBUG_TRANS, "start mux %p pos %zd\n", m, m->rc.offset);
@@ -450,7 +451,7 @@ static void p9_write_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, wq);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		clear_bit(Wworksched, &m->wsched);
 		return;
 	}
@@ -622,7 +623,7 @@ static void p9_poll_mux(struct p9_conn *m)
 	__poll_t n;
 	int err = -ECONNRESET;
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	n = p9_fd_poll(m->client, NULL, &err);

---
base-commit: 2a520073e74fbb956b5564818fc5529dcc7e9f0e
change-id: 20250308-p9_conn_err_benign_data_race-2758fe8bbed0

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>

