Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F68AD4B
	for <v9fs@lists.linux.dev>; Sat,  8 Mar 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741456077; cv=none; b=GSWLhdFqRXLt4g+JEL2Hzhx8KDOAVTljJtQZEb+ndfVWQP2o3Sdz74YV3o/6UqGW0xYHrrprOXqZmwl5cvw7ndYLD57NHIAdYThH1g1gFJaiRmrSSPr7amP/kE9vHJgESHcqyGjBH3o4AiSs4tiqv22W4BSCzjOsGsH0E2XdOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741456077; c=relaxed/simple;
	bh=p6InFRndnQU8EQckgN3pPyd05sWUsTAd05gohqs9UvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jX5OmMlWPVtDUCId4Bxdcw5wRWqC6FZ/N0W4jKJM01faZCsO95qOiQpP2hjUHBL8GSWR4WMaJekRcn2qZ5iLMjAE4LmxQg0oSmw+1xAJTI5gw1IrKCXuARtAh2vQU2DVdA/qmwdQL6ESYO+5CNDARfJEEbJsmnPGmo4KLuC1Ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=O9hBrwsU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="O9hBrwsU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741456072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iH+nG+xkzMrLIyIs8nUbB7bGFwyHx+ZLku2SBIZQKbo=;
	b=O9hBrwsUnzHE6nP8M7rR4LwDxH1racbMlTbDUxI6kt28RSBISHSGjPuqHN37y1AL9R5XmB
	KOkUSNNUTpalDqEGN3U7KJmovY0GMKzAJjOfnV4Whz/s+gAfEtlgykMaJCMyFw5k1VBPyh
	z6Ip+bhfw1m3qzFP7qw50PQrsCmyQ+5u4R80qdViQNzdfrLFE5vW/OEquCyzBb62MPNveJ
	FqHqNBIBwdZVBfEVuXMDr3oUKg9KCbggJ+rKvxsh1aA543ai7EY4R3hgKnqvKjAJT45/8l
	f7+rPrObKiw+ri8IP8BWRSu56arZgDZ8D9Xrwuf4uGM63B0dQKAr3rHPhn08Kg==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Sat, 08 Mar 2025 18:47:38 +0100
Subject: [PATCH] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com>
X-B4-Tracking: v=1; b=H4sIALmCzGcC/x3MTQrCMBAG0KuUWRuIkWLqVUSG/HxtZzMtExGh9
 O4Gl2/zDmowQaPHcJDhI0027bheBipr0gVOajcFH0Z/89HtE5dNlWHGGSqLck3vxJYKXLiPcUb
 MGdVTL3bDLN9//3yd5w/NHJ9gbgAAAA==
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
Hello! I noticed these syzbot reports that seem to repeat periodically
and figured I should send a patch. 

The read-paths look very similar to the one changed here [1]. Perhaps it
would make sense to make them the same?

[1] https://lore.kernel.org/all/ZTZtHdqifXlWG8nN@codewreck.org/
---
 net/9p/trans_fd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138af10e99ad04a76ee36a11f770c65..5458e6530084cabeb01d13e9b9a4b1b8f338e494 100644
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
@@ -673,7 +674,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		spin_unlock(&m->req_lock);
 		return m->err;
 	}

---
base-commit: 2a520073e74fbb956b5564818fc5529dcc7e9f0e
change-id: 20250308-p9_conn_err_benign_data_race-2758fe8bbed0

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>

