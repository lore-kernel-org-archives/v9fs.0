Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759287;
	b=omzmOYLGBL57tubz9bU4q07uN3hus1+XnnYFj4hSDbfcnmFIKMI9qH74kojLVuCj8U/M
	 jrlbGu68nf3yb0r6sxUkb0S74pRyViOkt1m2R+QvyyxWr9X0djHe4B+kKXQi1aerSIwge
	 0U4+g+ISYgsQsy8v+CtauPZXlWajfmJzYA1a820emCaIwT/KTlSxI0DDyZJBmXI9/zIGg
	 TXa6I8NCvIYnkf5ZjUvt0U886jp8ocS7JiCXvEAVGPxCk2681zsNM8YICtewAxD4SCjjq
	 7vzgmQsF9anqZjt++VeJAKy0m90vhDIBNBFR95/J2SFMyJcVBsSjk0AiffygG4hvySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759287;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=BguzeApHRl4b+y9uwqLXWv1DRqfKWfV3tJ5gTwlZcww=;
	b=IeK8kY7in2Qg4+8RE769UA43PoV8ikumMGnRms/HSdijhV2LdeEjFgaDttIGpscheBFv
	 O9eybsYJ1YiX/RmoWruy8N6xAs2tLdUXp2AtC9xtAv5MNEmyGQLGmHXgIZtITngG0w2O+
	 Ku/Od6ylS20ZK+BGW08F5rxx0JVmBwyOBHsR7u2cMzi5Oj5sIoDTsIj7dmVxUuRsMaEAU
	 5SdNcR2vVJgkhihBQnp0IBfUND3PqO3Yi9GljMA+G7JiQd8a65uUGOB2QiBd2W9DTj21O
	 pqkrZm6c3lG1p4s6ZUpz+sVZRcggYlUuJ7FtKDmHEgZ58qdEzMLxJd+a4UnI7oQY9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D0606A333
	for <v9fs@lists.linux.dev>; Wed,  4 Nov 2026 02:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE0D0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAD3H_oumOpqh5s+AA--.29137S2;
	Wed, 04 Nov 2026 10:27:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Subject: [PATCH] 9p: release the request when the response tag is not in flight
Date: Wed,  4 Nov 2026 02:28:07 +0000
Message-Id: <20261104022807.1484097-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAD3H_oumOpqh5s+AA--.29137S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18Kw1kur4fKFy3tF1DJrb_yoW8AF4xpa
	n8G390gr98Wr12yas7Jr4kXF10yFWfKw12gayIkw13Zan5Gw48KrWFgrW09F13Cw4kta4D
	Kryqqr97JFyDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUknaBUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIBA2rqY+TJdAAAs2

usb9pfs_rx_header() takes a reference on the request returned by
p9_tag_lookup(), but the shared error check returns NULL without
dropping it when the lookup succeeds and the request is no longer in
REQ_STATUS_SENT. That state is reachable: a cancelled request can still
be found in the idr with REQ_STATUS_FLSHD, and a duplicate reply can
arrive while the client still holds the request in REQ_STATUS_RCVD.
Only the parse and lookup failures may return without a reference.

Split the check and put the reference on the unexpected tag path, like
the other error paths in the function.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/9p/trans_usbg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..c677ca0e4440 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -203,11 +203,17 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 usb9pfs, rc.size, rc.tag);
 
 	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
-	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
+	if (!p9_rx_req) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
 	}
 
+	if (p9_rx_req->status != REQ_STATUS_SENT) {
+		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+		return NULL;
+	}
+
 	if (rc.size > p9_rx_req->rc.capacity) {
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
-- 
2.34.1

