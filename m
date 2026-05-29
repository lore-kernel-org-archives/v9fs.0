Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA840DF59
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042262; cv=none; b=TtOGEB8yhJ+3sdHy8hzsQxMS5U8Ed6SIUkRhBLC5OmQbn5NKZ8TiCErGfkcjjqAGyzAByqs1iKD9FydPt8qMmty4VmcxRHMSOkKf9K4UX2imz0SsJQTGIgsDDznRT6yDmp+PzL1zmW3oZGzVsUyKG5/hvuT7GYUH0jCzhuPZBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042262; c=relaxed/simple;
	bh=ITEBlMVQV23uhpIcHzjn7ubI5My9ug0oqJMfaXXgkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MI/C4Pzw0FGRv0ljNPGyVo/qt6+nJPa3NRS0HWBJlH/P/ptVh2We6yP8KEwgMs1+NfuoDpbirdVlkficovIj4kk+Winku+utrvD1VhIrlencqf+9CNhxi8kt2UBwMwU7IpsDMqrDdnsujompAhYCi8e4ETZuusCaFvdW5X6ZbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=TBW9J5ZK; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="TBW9J5ZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=C//xU
	g1N9wqZvnee7tLgvPUP+p1K4Vl1lKin6lXAIPI=; b=TBW9J5ZKlhglh8yVSLlwA
	GKKThsi0SSI8ISVB2LAjFaM5Iqw7uUepjpnlRv5Rk42fYiDwg8+PTwNsOu/jY7Fv
	pkCc5uR3S0ekFj+g0y+MWbXPKxUwulq1ApE+fV+rUANfI/bdjzl+LTSoeJZ64HfV
	FOpk3sovJ7DGTS8ratOqrY=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web5 (Coremail) with SMTP id zAQGZQAHvr0GShlq3_33AQ--.44568S2;
	Fri, 29 May 2026 16:10:46 +0800 (CST)
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
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH] net/9p/usbg: Fix use-after-free on usb9pfs_clear_tx
Date: Fri, 29 May 2026 16:10:25 +0800
Message-ID: <20260529081026.77732-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQAHvr0GShlq3_33AQ--.44568S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kCry7Cr15GF48ZF47Arb_yoW5JFyxpa
	y2krsYyF98Gr1Iy3yqyFyDJw18AF4kAayjgr1jkFn8C3ZxG3s5tF10y34kZrsxA3yIkr18
	tr1qqFWjyrn7CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjXTm3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgICAWoZNcA3gAAAsy

When p9_usbg_close() is called, it invokes usb9pfs_clear_tx() but does
not clear usb9pfs->client nor usb9pfs->in_req->context afterwards.
The 9p client core (p9_client_destroy) calls close() and then
kfree(clnt), so after p9_usbg_close returns the client struct is freed.

If the USB gadget is later disabled (e.g., host disconnect),
usb9pfs_disable calls usb9pfs_clear_tx again, which passes the dangling
usb9pfs->client pointer to p9_client_cb. Inside p9_client_cb,
p9_req_put(c, req) dereferences the freed client to access its reqs IDR,
causing a use-after-free.

Additionally, usb9pfs_clear_tx does not clear usb9pfs->in_req->context
after calling p9_client_cb, so a second invocation finds a stale request
pointer and attempts double-completion, further compounding the UAF risk.

Fix by:
1. Clearing usb9pfs->in_req->context to NULL in usb9pfs_clear_tx()
   before checking usb9pfs->client, so that even if the client is gone
   the stale request pointer is consumed and cannot cause
   double-completion.
2. Adding a NULL check on usb9pfs->client in usb9pfs_clear_tx() to skip
   p9_client_cb() when the client has already been destroyed.
3. Setting usb9pfs->client = NULL in p9_usbg_close() after calling
   usb9pfs_clear_tx(), to prevent any subsequent call from dereferencing
   the freed client pointer.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce7033..c75de5c 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -435,6 +435,11 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 	if (!req)
 		return;
 
+	usb9pfs->in_req->context = NULL;
+
+	if (!usb9pfs->client)
+		return;
+
 	if (!req->t_err)
 		req->t_err = -ECONNRESET;
 
@@ -457,6 +462,7 @@ static void p9_usbg_close(struct p9_client *client)
 	client->status = Disconnected;
 
 	usb9pfs_clear_tx(usb9pfs);
+	usb9pfs->client = NULL;
 
 	opts = container_of(usb9pfs->function.fi,
 			    struct f_usb9pfs_opts, func_inst);

--
2.43.0

