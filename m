Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9D33F5B0
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042719; cv=none; b=Y5dn7y8EIo83VVH+u8wwcTfzdOgibC+h/vPH86TwzSbVCGqB7c+0txNgTtv0731JIRgopkXyseUAoF3KSL9dJ76o/RwTyda1LQ1FgbD+ROSLQFAB2Jd4j5yPLRtuaNv7vJSycTc9IBQFac6+ygQ6OoeYOsBkV/4eJYAqIecwH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042719; c=relaxed/simple;
	bh=Gb8Vpr1P0cTJWmdIDFfP34ChLUY91ExMRsyiC2YQT5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ketm9cNNiiB+8LUif5CXuFoN+lfJIBu4D+imzh6KNQ9gh8iTxJSOsuPsdXj85gFsVNu+5YqhQHL7Dskh6VS/aorF00SE53zwqkTd/u49DDUMs8uUrmeXDBLDRzSgtKDfxlSiAYkAnlJPzGk1BZwZpXJ1bp8P4yHjVJYka5c675o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SUxzMxo6; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SUxzMxo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=cgjP4
	b1tWXzAyQSerqUgQowDPB6KIQASF8wVesagMRU=; b=SUxzMxo6Op5WA2HgOQv/V
	E6I9lGHlA3serSbTcwP6rHKsR3ipfG3I9AxWJ/uu50EpIBA0CI1/y852AgExD4Ww
	40zv05zoo2GQ3r65li58bySl6lkva0skKbJOHHOV4vlyjGPZeU9DZNb2AwT/pxFg
	4URoq5h1E8tfZ6/Cn93N0E=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web2 (Coremail) with SMTP id yQQGZQBnQprOSxlqX3bdAQ--.15689S2;
	Fri, 29 May 2026 16:18:22 +0800 (CST)
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
Subject: [PATCH] net/9p/usbg: Fix use-after-free in usb9pfs_free_func
Date: Fri, 29 May 2026 16:18:16 +0800
Message-ID: <20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBnQprOSxlqX3bdAQ--.15689S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DXFyrCF45XFyfGF43Awb_yoW8AFW8pF
	ZIkr4akF98Gr47Z34ktr4vv3WxCF4kAFyFgry0ka43uanxK3WxtF1vy3sY9rs8Aa9Fkryr
	tFZ0qryUAr1kCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbasjUUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgECAWoZNcA8vAAAsG

In usb9pfs_free_func, kfree(usb9pfs) frees the entire f_usb9pfs
structure which contains the embedded usb_function member that the
parameter 'f' points to. After the kfree, the code accesses f->fi
via container_of(f->fi, struct f_usb9pfs_opts, func_inst) and later
calls usb_free_all_descriptors(f), both of which dereference the
freed memory. Since f is &usb9pfs->function, all post-kfree accesses
through f constitute use-after-free on the already-freed usb9pfs
allocation.

Move kfree(usb9pfs) to the end of the function so that all accesses
through f complete before the memory is freed.

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
index 1ce7033..c30ef5f 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -725,8 +725,6 @@ static void usb9pfs_free_func(struct usb_function *f)
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
 	struct f_usb9pfs_opts *opts;
 
-	kfree(usb9pfs);
-
 	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
 
 	mutex_lock(&opts->lock);
@@ -734,6 +732,8 @@ static void usb9pfs_free_func(struct usb_function *f)
 	mutex_unlock(&opts->lock);
 
 	usb_free_all_descriptors(f);
+
+	kfree(usb9pfs);
 }
 
 static int usb9pfs_set_alt(struct usb_function *f,

--
2.43.0

