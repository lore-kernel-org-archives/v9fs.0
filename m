Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7290399036
	for <v9fs@lists.linux.dev>; Sat, 20 Jun 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970811; cv=none; b=ILfn40d5Xn41vSrqlBjvBa6j1xQfelhk4RzUn1kK75hagq7+mcO9LCQeA4I6kyS0j4VX6QjUJPBhxhd5MhZLaPYKUp2aNYsS9e14eCbXPNc/arfJ2knJvh9h0Gk2pFMDywMOqtpgX8G8iQyCgk2kjIC02wmjKPbqVYe7nZD+9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970811; c=relaxed/simple;
	bh=H9BGZu0KEc+ApXW+umHvv2XiNYQ6HMXJHefDAgehv9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qnp8W1CRue+0vwaHB6EyeWOslGNlOMdFrfyVno/bhPlscEAMZvrsmzRgiu0CB6Nn9fksllVpGeGyuE1kQnJOr8XsdUhwIYGRyP0Qf6Ru+kj1qKDJ3apvdb8c4YrBYKs4V1SbozOwyh8LfTS712VgNrzKnHTpaMB4zLCWZe1fuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnyMJntzZq5D2dAA--.28310S3;
	Sat, 20 Jun 2026 23:53:14 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	rpembry@gmail.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] 9p: fix caches_show() out-of-bounds write
Date: Sat, 20 Jun 2026 23:53:03 +0800
Message-ID: <abfb65f4800634dafb08238bba20cb48797e796f.1781908090.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781908090.git.zzhan461@ucr.edu>
References: <cover.1781908090.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnyMJntzZq5D2dAA--.28310S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW7ZF4xCrWkZF4furWUCFg_yoW8tF43pa
	9I9ry5GFZ5ur1DG3ZruF12v3yFy3yDAF1UW398t3WkZw47Gr4Ig342gwn5XFykCrZ8Gw1Y
	gFsF9F98CF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEECWo2TVMCaAAAsl

From: Zhao Zhang <zzhan461@ucr.edu>

The sysfs show handler for /sys/fs/9p/caches appends cache tags with
snprintf(buf + count, limit, ...) and then advances count and limit by
the return value. This is incorrect for truncation because snprintf()
returns the full would-have-been length, not the number of bytes stored.

Once the accumulated output exceeds PAGE_SIZE, count can advance past
the sysfs buffer and limit can become negative. A later iteration then
passes an out-of-bounds destination pointer and an oversized size_t
into snprintf(), leading to an out-of-bounds write.

Use sysfs_emit_at() for the append instead. It follows the sysfs buffer
contract and returns the number of bytes actually stored, so the offset
remains bounded even when the output is truncated.

Fixes: 86db0c32f16c ("9p: fix /sys/fs/9p/caches overwriting itself")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 fs/9p/v9fs.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index acda42499ca9..0668bad681bf 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -17,6 +17,7 @@
 #include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
+#include <linux/sysfs.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
@@ -592,21 +593,14 @@ static ssize_t caches_show(struct kobject *kobj,
 			   struct kobj_attribute *attr,
 			   char *buf)
 {
-	ssize_t n = 0, count = 0, limit = PAGE_SIZE;
+	ssize_t count = 0;
 	struct v9fs_session_info *v9ses;
 
 	spin_lock(&v9fs_sessionlist_lock);
 	list_for_each_entry(v9ses, &v9fs_sessionlist, slist) {
-		if (v9ses->cachetag) {
-			n = snprintf(buf + count, limit, "%s\n", v9ses->cachetag);
-			if (n < 0) {
-				count = n;
-				break;
-			}
-
-			count += n;
-			limit -= n;
-		}
+		if (v9ses->cachetag)
+			count += sysfs_emit_at(buf, count, "%s\n",
+					       v9ses->cachetag);
 	}
 
 	spin_unlock(&v9fs_sessionlist_lock);
-- 
2.47.3

