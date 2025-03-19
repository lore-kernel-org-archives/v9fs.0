Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74D20DD74
	for <v9fs@lists.linux.dev>; Wed, 19 Mar 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383244; cv=none; b=qewy6Y+PCfaS7Tz7w3Z0mKMe1Kd7VFoXTvIj1PYqIFlj7btjfX6psmKVvad1gAvsNvFu62Gwh/wmpaqyfMXpkIkTpGpqsFbDSl6BuForVPIIrWnq5OOhF9OGdbtsCjw5m5jGtaw/lSORSwLezRxuTbTodoukRxmYt4xi6Zh7ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383244; c=relaxed/simple;
	bh=3J58Se8XDTl9BlGgRs5d+IlBlOxSoL35kOrUGSCwDcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k52QMzFlWbjTLKcv/sIVwktNZamiSXGnVbq5im5CC8A548pRKLA4H3hGpIgqhA9XHQ8pDtU62xEnXXkFxSZdO8xswLcGxZUVsn9kg72D3mvEBiW6DF2pdifpW0CvdDAciGM/6BYC9sqBWH3h4qKxirdQ3YdhkliAjoMTfaPK/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JIWEf3xH; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JIWEf3xH"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8BCF914C2D3;
	Wed, 19 Mar 2025 12:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742383233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lXpgVvCHByq70ntTWtHcQtsufg4U/O6aceBq0lCugzo=;
	b=JIWEf3xHy6HLfPcZIlPCTBJrwHhTuwPFgXkI/GHmE2gH9RHMNRh0EmG9zI97aKfeghRuPd
	oWIylvR+zhgWtwY8tPqWJm5labeLymHzTfzF+M1KFszHcnMmL8YzkedjiVf3uRCzZHmE8y
	jdGD5ih29L5UvjsUJG3i+lduNbDvVeR0SmPluroTBLvk9OZYb5dTF73YoFxzBg/SXQr/aO
	2lYO9WtPRYeCAgICU1nCYjZ1RU1MJISerFLgnOA3o0gymE+ciWeaacP6ZA29Dr3K3TzZad
	NZ6nfCwWzF7c/xMYuiPAQLt3HypLpUMbuV9OhEBH4DyMs3hZXVDZtXCwghMOrg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 0eaf4a6f;
	Wed, 19 Mar 2025 11:20:29 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Wed, 19 Mar 2025 20:20:15 +0900
Subject: [PATCH v3] 9p/net: fix improper handling of bogus negative
 read/write replies
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-9p_unsigned_rw-v3-1-71327f1503d0@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAG+o2mcC/3XM0QrCIBiG4VsZHmfo72zYUfcRMUz/bRLo0HLF2
 L3nBp0UHb4ffM9MEkaHiRyrmUTMLrngS4hdRcygfY/U2dIEGNQcAKga24dPrvdo2zhRJjolrZY
 gNSPlNEbs3HMDz5fSg0v3EF+bn/m6/qUyp5wK1KrhFhgz15MJFqeI5rYPsScrl+FDSCZ480NAI
 ZRttKq14geN38SyLG9uAfcH8wAAAA==
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Robert Morris <rtm@mit.edu>, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=3J58Se8XDTl9BlGgRs5d+IlBlOxSoL35kOrUGSCwDcM=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBn2qh5cq2NDOvwvpzA9OI2dfr364fxm3CO5+gvH
 nmwNPRPw82JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZ9qoeQAKCRCrTpvsapjm
 cNKWEACW+5TL7uCVj8SEfCusCrPdUEQN9InPwhuUGzxCUuUe0nnhUhuXbBpP9VOv6VhLSorIWzD
 qvPoimJdsOAeTY/4zczUyRQTXaVZjOnLFseCPvbecRnzTcEibivRetditsH0fpgt4y6MzgwEX5u
 qFUTgSGdcigUtztDej4X4R0/0CP6qhrw3Qdq4C3YycC9rmQbZvli2j3FCjyrY5ShK3v+IwGiTh6
 wDz3fxLz707fEQiz7tdrYbPzi+XX/fcf+II/ZBnaKJqUYYOL8OCVhxYN4FJpTQYRzi8GigTEOT5
 rUhhsVMlR3dqWDQQCtLvH36huPjswBOXjD0EP8L7WSSgwo/SKQlHEF/Dt55JdRD/YeCc5O7cWPu
 qaDOhpz5X+rBB1G5XWZ63OiadfwrRCeva9Jqu5mTQN3r9gdrNFAd0bieEenA7Q8+99p1r+OwF1Y
 RUUdAoSb0Z6aL4u2v163zM8uVLwAobwLqd+1mgDVL4rdqey6f74BCVfYNIutS4zHgjeZO/n6YOx
 VKMP+mu9kkRTG6hm7Mf09da9MZPughyZXNw9RMCHT5N6xR+vAQYrg4kyTdrAYR/vpOWKbT3qvN6
 tYbely5AXvdWuSa2/sRjJqlv0+3DmbgxLixxA5+/zUf6K06mC0JBtWwMZzIjht3XvPo0qJ4UFy0
 BfLSDrI5+CDPbSw==
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
Changes in v3:
- fix bad print formats
- Link to v2: https://lore.kernel.org/r/20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org

Changes in v2:
- fixed rsize to be u32 instead of size_t
- Link to v1: https://lore.kernel.org/r/20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org
---
 net/9p/client.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 09f8ced9f8bb..52a5497cfca7 100644
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
+		u32 rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);
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
@@ -2107,7 +2109,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 
 	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
-	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
+	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u\n",
 		 fid->fid, offset, count);
 
 	clnt = fid->clnt;
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
base-commit: 28e6f0643ff4431aac807e902ff0c8de16b2216d
change-id: 20241222-9p_unsigned_rw-03f95da525a0

Best regards,
-- 
Dominique Martinet | Asmadeus

