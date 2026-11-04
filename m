Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759287;
	b=OBE46wsqZr9ONi04xBZFlIQqQ1bqwI/zr7JnNU7bQpc9FVMT9sjvpF3Jw/aivt/fl57P
	 /DRQ7CT3rGLaT6wvjkSEyyJ6JAS65qcdZIwjUHpK1sBPmtsgOzmy4CEh4aNsLZwLJuI5K
	 fS32xbpzvmes+8Cj38RLGFDf4VdVw7Dfqx6XRgRruHCZCxl9alvsnAtCGtqW9+GPq47gb
	 Kce0noyx7Ln0RPYop4X7R6FYPpIcQM72JnGmxkUgxd2Uq1gfxIQ3jMlQ8KQlQLZFYZn9o
	 CNE655Ls1Fp4zKtSCl0xk198Ere0NcuV9Dr3NxohbyN7/YZhelyDe1+YNPbClqPSqYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759287;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=BVc4OK7RmNIYZFuj1qqTuiviezvtjGgWmyK9lGCYi9Q=;
	b=lbgXNmV+AY/eviEwL52vVKtTy2DRV9RxvHh8R2KLUKPt9N1rzn0P7FGb9PzZtY0IfyQ/
	 4QcxF+Hxmne67Pp8bCnIC6lOE9GbqZI6MZHFUiqTcUJBGGJ+6rQcAV6g4zIudykJdJC+C
	 L36CPEScS/zk/BvFlSSwSLGOR3V75LHglXMuv3sy8RZmy+uyVJ8e1AkrZTfUi9ZFJk4ih
	 mV3Ix7ybgrrH0+dtRctlH/wKd7HK3mSkNdHkBAbgpXnUFD9HTADAnTK9KPfZ6/0i539ON
	 bhEwGIF7ILZBX7FNHkhMa1/ARyu5/mvJl9VppvBESA/p5FYEI4gxvXj78NVRtGgR7ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E9606A334
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 02:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1E9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXgvwtmOpqgZs+AA--.9788S2;
	Wed, 04 Nov 2026 10:27:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Subject: [PATCH] 9p: put the request on a duplicate RDMA reply
Date: Wed,  4 Nov 2026 02:28:06 +0000
Message-Id: <20261104022806.1484080-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXgvwtmOpqgZs+AA--.9788S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1xtFWfKrWkWrWUur1Utrb_yoWkJrc_Cr
	4fW3ykWa4DJr1Iyw4j93W0yws7Kan7GFyrW3srta9Fga4DKFZFkF1qkr98GF1xJw4rArnr
	Xr1UZ34xZw13JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07b7a9fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQBA2rqY-nHQQACsB

recv_done() gets a reference on the request from p9_tag_lookup(), which
the normal path hands over to p9_client_cb() and that puts it. The
duplicate reply path jumps to err_out without calling p9_client_cb(), so
the reference taken by the lookup is never dropped and the request, its
tag and its buffers are leaked. A duplicated reply for a request that is
still in the idr is exactly what this path is here to handle, so drop
the reference before bailing out.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/9p/trans_rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index b4274f10fa44..6ebd55ff8b37 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -217,6 +217,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	 */
 	if (unlikely(req->rc.sdata)) {
 		pr_err("Duplicate reply for request %d", tag);
+		p9_req_put(client, req);
 		goto err_out;
 	}
 
-- 
2.34.1

