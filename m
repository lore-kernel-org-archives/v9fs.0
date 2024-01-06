Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD31396
	for <v9fs@lists.linux.dev>; Sat,  6 Jan 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQNvKcCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF4AC433C9;
	Sat,  6 Jan 2024 02:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507072;
	bh=47TnaR0YpjvB8dI8+cTvzu4LpRGU8CyazbqtphNLNcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vQNvKcCNTITGQaNsdLcki4SnX0FdRQF0QhP3bdqEHi5vMteqcpWZaZvlPrjsVrD6M
	 2nBI8HP3Ak2czbqaFGTWxoHGMeJXEWCN3c95uV9QH7NRwNlCfgUdlhG7XBEfUJiIkR
	 pzzJdRGTxLXM3YvS+avZP1To5AxHfpOhvLwXEkuuEN97Ia0kGrvPq+BI0fbpopgndJ
	 ObOL97Xf8nEqa+RLDz5rosPyOkbWzz7H08j+Fgtufttf1/uruSoBPKpR3awrkM23y1
	 Cg5eT3pQvAA6zzWVKHKcI5wPjCbxpENsB+Z2p+WLa4Q+FicmVGVOulPan0BNe9a/rJ
	 c99J5dsZxE+SA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sat, 06 Jan 2024 02:11:08 +0000
Subject: [PATCH 1/9] fs/9p: future-proof qid2ino 32-bit support
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-ericvh-fix-cache-dups-v1-1-538c2074f363@kernel.org>
References: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
In-Reply-To: <20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org>
To: v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>, linux_oss@crudebyte.com, 
 asmadeus@codewreck.org, rminnich@gmail.com, lucho@ionkov.net
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=47TnaR0YpjvB8dI8+cTvzu4LpRGU8CyazbqtphNLNcg=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmLa+B+Pd7mu8rSkk+R7wVWqTra6cE0ZAxRrY7
 wBnnVP8RcyJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZi2vgAKCRCI/9X7Sl//
 mLJlD/4xO8NZp/8pCEhBQBa7+6brr5Z2tQCrqHybc4nmKp1twU0psbPD6cEYP5HKa2jZQpfB3Or
 lzmpS8QDw1fhfQvraQhSY1xcmfj+DAqaTas3C7GbH7/TkbKvj3+3DZVOONkUhSafWcwU1uIWr90
 10IkmM5zjOW+4AE1b6gCL6KXIZmFVfCI0njd0hnmZxT39jc7K4PqHgil2LvkjxTYev/mOBto+rB
 3cmYJTERy9WeHMWSv76CpninZw7Exq4Z2O313ESFm0KzcUaBX/0MKKCpk8o6Twdz/lOsj1w5X7A
 NL67Wpbn43OVsJQ1RHxlqi8sIf9k7NuwDcgQSBBCuh566baKuJoI8fgfKcjhCzq/5inw3ryqX7l
 RL9zkQZyuAzZYCBGn4LR4ohTnZ6EZs39u37sH222XGwii2wdlHzHAspBZaBv42nR50upOBLXRfH
 uubh5f8qc5qAvq0s5fPcCnw4yN7sWC0AWFTHCYsOI3choK/pv3eXCKb4RIT6vdjdCVA3+NO4dR4
 mPuyNKWuAMXyOMPkTaTGXfGgFttwAgH+3hJLHi57icUGRvGho0G7Zrlr6/hhpDLm/hZF7To3TXe
 cLEFk9BJiVyUk5Hjx1GpvKOOBK+tPdckv0mgY0l1NkVhLJCUqUYrQp9YkyPc9QII7e6/69dG/+q
 RhgjjY6meQtx1OQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

The qid2ino code had a check to allow a reduced precision qid to inode number mapping, but it only checked if the sizes were
equal.  Change to check if the ino_t is smaller than qid->path
before using the reduced precision version.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..6d149ba12bc0 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1192,18 +1192,25 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
  * v9fs_qid2ino - convert qid into inode number
  * @qid: qid to hash
  *
- * BUG: potential for inode number collisions?
+ *  We add 2 to qid->path to keep reserved inode
+ *  numbers reserved.
+ * 
+ *  Its possible in the future we will make qid->path
+ *  just a hash to lookup inodes, but this breaks too
+ *  much right now.
+ * 
  */
 
 ino_t v9fs_qid2ino(struct p9_qid *qid)
 {
-	u64 path = qid->path + 2;
 	ino_t i = 0;
 
-	if (sizeof(ino_t) == sizeof(path))
-		memcpy(&i, &path, sizeof(ino_t));
+	WARN_ON((qid->path+2)==0);
+
+	if (sizeof(ino_t) < sizeof(qid->path))
+		i = (ino_t) ((qid->path+2) ^ (qid->path >> 32));
 	else
-		i = (ino_t) (path ^ (path >> 32));
+		i = (ino_t) qid->path;
 
 	return i;
 }

-- 
2.41.0

