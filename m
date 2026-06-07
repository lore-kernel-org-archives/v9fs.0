Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD927E1C5
	for <v9fs@lists.linux.dev>; Sun,  7 Jun 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780841186; cv=none; b=byaRVbnEaZE4ijlRoJJWGia4T8eE+hjrB4ufmWiwH8NA0MHS1rgEWG9hImxbtrS9fhEWZHPGfENzMf75drYM2EcfgHoy77FmC5B6xxNwdlqdeuS1ate/YYNRqAPSFJJi35R0/mTIGpND6GJa80/53BRUF0jRc8/6K6VSRtfyPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780841186; c=relaxed/simple;
	bh=82cCKqg3MsQt7vqnMwzDOcjZFWNjFzl70JEqvhPLtKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKRo1anAVBNrdtAa1d5oYgjupqEq7bnsIdSSmqZ8jV3SjgVzQxfCATpv7a/6kgP56RRvNFgBajJlXcjMs5CzznIotnWHY1xq/9YJSicSRgSbcnvkyMQyXitjDLIRVosJV/Dy4w52NoEMiZ6KTGU3Qdpi7UcnKyuntyX37bK1TVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=BO66CT3O; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="BO66CT3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=xkBxb
	Q0JR0YQ17xyn75o2TAfaxhSYTjMP4T2rs5jitw=; b=BO66CT3OJnfNzJUf/ltWv
	LgD61H+ExFzHwOwIvSVQGcEfTJWQ0z+A5h5/KzeuU4ZMO2LXsP9kIELM7jgq/hJl
	C6trxodIlJ/OnpDJAO9ET0INhw/6V7PfvZCKMKqUh/dCytTW24XuqDJS08WTZ0tN
	S+Vy6+CxPYS7Dj/lQfLZiU=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web4 (Coremail) with SMTP id ywQGZQCnbKHWeiVqiTQUAg--.36200S2;
	Sun, 07 Jun 2026 22:06:14 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Date: Sun,  7 Jun 2026 22:06:01 +0800
Message-ID: <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQCnbKHWeiVqiTQUAg--.36200S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xAryrZw1rZF1ruF4DJwb_yoW5XFWxpF
	W5AwnayFZ5JFy2y3Z7Aayqvr47AFs3ArWxGryUZa43Z3Z8tFyIqFy0g34S9F4DCrW0gFy8
	trZFvryUC3WDur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0hSdPUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgELAWoknpuZngAAsF

handle_rerror() copies the variable-length error string of a zero-copy
RERROR response from the receive pages into the request's static response
buffer.  The amount copied is bounded by P9_ZC_HDR_SZ, so the data can
span at most two pages, but the helper is not told how many receive pages
were actually mapped.

If a malicious or broken virtio 9p device reports an RERROR length that
exceeds the remaining bytes in the first mapped receive page, the error
string is treated as crossing into a second page.  When only one receive
page was mapped, handle_rerror() still advances the page pointer and
dereferences the next entry, reading past the allocated in_pages array.

Pass the number of mapped receive pages to handle_rerror().  If the error
string would cross a page boundary but only one page is available, copy the
bytes that fit in that page and leave the response truncated, matching the
existing behavior for overlong RERROR messages.  Otherwise continue with
the second-page copy as before.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/trans_virtio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 4cdab7094b27..a71ce8870c53 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -377,7 +377,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 }
 
 static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
-			  size_t offs, struct page **pages)
+			  size_t offs, struct page **pages, int in_nr_pages)
 {
 	unsigned size, n;
 	void *to = req->rc.sdata + in_hdr_len;
@@ -398,6 +398,8 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	n = PAGE_SIZE - offs;
 	if (size > n) {
 		memcpy_from_page(to, *pages++, offs, n);
+		if (in_nr_pages < 2)
+			return;
 		offs = 0;
 		to += n;
 		size -= n;
@@ -535,7 +537,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
-		handle_rerror(req, in_hdr_len, offs, in_pages);
+		handle_rerror(req, in_hdr_len, offs, in_pages, in_nr_pages);
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
-- 
2.43.0

