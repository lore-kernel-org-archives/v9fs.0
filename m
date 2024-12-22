Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7E18A924
	for <v9fs@lists.linux.dev>; Sun, 22 Dec 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734875901; cv=none; b=nsJMOdJ8dmkZEM+lCbd5/sQcl5JNUxFxFxIQ9RkrQrQvfb3njPVJoqgB/X1nyaVbC1jQzW6eDSWdylRkljnuTlrz7WxjXnjethXysaptkf2S54mM56k5S87JvsU1ByJ7RfzLtZH0aO9QQsZfLjIC6M2PuUK+C7gpCBMDlaKcWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734875901; c=relaxed/simple;
	bh=byyOA68TOswL6wkkRELUWu6TIg1aIwVPizddEyXgZ/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eLFr/RtNVoKQ0dtS84lUZsN0iDCLjcZbVkiX4TlwMtImq/GH34EijBJ11yaFkyvOYcZs5sn93+1PbrE0ToZfNxassenj81oK2iGKJ+dBcNTMr0Zy5xWdd+Bc7LRXXHE+sXsKFytkZsmnkPo16FAdpobS7TY0x+BADhrygCtXdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hG7GJ/Nm; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hG7GJ/Nm"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2AAAC14C1E1;
	Sun, 22 Dec 2024 14:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1734875890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDgZ1hjLiLQOzalB2YFCMyefWx5UV1JtI+HzHCtCVFM=;
	b=hG7GJ/NmAIFOI8loQPdhAT6QfVhMGJKRi8ikNWpxOO7oyx8jXTx1uGvfXdkoPjbpnfvfMG
	VtNJ++58RgnCZQ5EuVSe72yagsVG8uFEis3Vp1XlOPVvfQi+wdhc0XrnosIyNepk/qP/y1
	6iPLlh4BColCCpb/5dofY0JqhiI3FmBw3G69mvk1jPxP297c1K3+sUJuptKZMgxlF7RvB6
	xT40YZzsds32qtQE7Zyq2mcjpvQOwVCMU0eS8GzKWlAKFmxovckERRKk1DNp0Gb1tfTBcT
	uJGW1h6Evwn//1wbfuOH7AeJgTWeNxUha4y9BrDIvmd21Ty2iNR0CvfeLEroeA==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 528d295f;
	Sun, 22 Dec 2024 13:58:06 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 22 Dec 2024 22:57:48 +0900
Subject: [PATCH] 9p/net: fix improper handling of bogus negative read/write
 replies
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org>
X-B4-Tracking: v=1; b=H4sIANsaaGcC/x3MTQqAIBBA4avErBN0yoVdJUIkJ5uNidIPhHdPW
 n6L914olJkKTN0LmS4ufMQG1Xew7i4GEuybASWOChGFSfaMhUMkb/Mt5LAZ7Z1G7SS0KGXa+Pm
 H81LrB/JV4ZdgAAAA
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Robert Morris <rtm@mit.edu>, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=4235;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=byyOA68TOswL6wkkRELUWu6TIg1aIwVPizddEyXgZ/c=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnaBru5T+XMBwvdsH2ucp7Bt6obLcb7ZlSKkLtc
 Fphq3qxb1WJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZ2ga7gAKCRCrTpvsapjm
 cFa3EACsKuokLDTbCayAC/ARpHNxtEV3rTs1n2hIGteeksTZRTrwxnEwne/RSz+hl6Mz+h8rt3j
 p5Jn2eifLigtR1761KPLo6yieUXX2DJR/2T7WhFvuJsRXec8nYr8j31uWX7ZZm4aEWXB43YxOV0
 cePLmdSWxqEUoYi66PPOridYFK4HkSWmetrSEYX60ttRffC3okSuh+xkKDhzmUIXkw+QebvIWB/
 r8eX+h0jgxgIOSl0P2TUEmD8qpD+4C4iFao+XrxFH+3U37bS4rW4lgh061Rqm5cOSnpKg+YlRbT
 KK4Br+iaa4mCfCbqpcKCsFHx/7QAuE/2UhbRs8OxF0QTdf7SySiMqHEw9iKhNQ60xuvPj3QRZR0
 CfglQninbsH2RB86jYRvOdmIOB2216K2MExH8HoRB1e+RtColS8t1rfSAfas6zXcKlO6kekw3ZB
 VOTWWADvyKyEaIp3dJoLV6wYLv5cGRX1CGQzfelFjA0lbUWOlxRbj+UzzJz181rdnRDKajSh0TD
 h9AUSgxefId0RBel7S50ID0uM3QwSbp9kPtbXrpfP/aRh5XU4+3VXO0ppdcPMyN2OnFc6Jlh7Z6
 UHjCWQH/yAHXINWrTvRx0Uajm9/6z3IVIaSdJZopzgls7m51l0vMNZA3Xpkxk8Dq8ePI1mrBcxy
 9lyu6deH3/djkiQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

In p9_client_write() and p9_client_read_once(), if the server
incorrectly replies with success but a negative write/read count then we
would consider written (negative) <= rsize (positive) because both
variables were signed.

Make variables unsigned to avoid this problem.

The reproducer linked below now fails with the following error instead
of a null pointer deref:
9pnet: bogus RWRITE count (4294967295 > 3)

Reported-by: Robert Morris <rtm@mit.edu>
Closes: https://lore.kernel.org/16271.1734448631@26-5-164.dynamic.csail.mit.edu
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 09f8ced9f8bb..c290d96e1bb3 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1548,7 +1548,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, received, non_zc = 0;
+	u32 rsize, received;
+	bool non_zc = false;
 	char *dataptr;
 
 	*err = 0;
@@ -1571,7 +1572,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 				       0, 11, "dqd", fid->fid,
 				       offset, rsize);
 	} else {
-		non_zc = 1;
+		non_zc = true;
 		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
 				    rsize);
 	}
@@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		return 0;
 	}
 	if (rsize < received) {
-		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	*err = 0;
 
 	while (iov_iter_count(from)) {
-		int count = iov_iter_count(from);
-		int rsize = fid->iounit;
-		int written;
+		size_t count = iov_iter_count(from);
+		size_t rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %zu)\n", written, rsize);
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
@@ -2098,7 +2099,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
 
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 {
-	int err, rsize, non_zc = 0;
+	int err, non_zc = 0;
+	u32 rsize;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
 	char *dataptr;
@@ -2142,11 +2144,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto free_and_error;
 	}
 	if (rsize < count) {
-		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
+		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
 		count = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
 
 	if (non_zc)
 		memmove(data, dataptr, count);

---
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241222-9p_unsigned_rw-03f95da525a0

Best regards,
-- 
Dominique Martinet | Asmadeus

