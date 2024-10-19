Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CA20E32F
	for <v9fs@lists.linux.dev>; Sat, 19 Oct 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328738; cv=none; b=cFfkB//aO5jgTNvrXO/k43jK/8g+Wum2VhxsO4i8ygHEgJIciuVjkw8UG+PURQ/XEGf5fWh6d7nw+R/Dd8Sav9Ynbz/4250uJ2/f69HinBAS+SicUfrOoffUyEvAOeZCEMUH37xf2wHNY0GMcqWh9MT4KmrvVb8XUbuhpcoUyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328738; c=relaxed/simple;
	bh=sll1pvU9oGSpnOezRYBcS3+Gds8wLTQ6SFKgbQE8vxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cw/xC9Hvg9Y4V4G87MMEGct/eiU3wKnWLy2lTRcNfxJU8JPFuMuukcdfMY6aT/a2wum6qFXqOI6Oz3450bdPjppVq4SEU7bLBnxCWMBOSmJexo7vOIBktqfRXibXF04cV65gevejX0Gc3H6T3aICtrzDsxmEniqz4lLq3XOxyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XVwbX2hLNz1T8SP;
	Sat, 19 Oct 2024 17:03:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B15E618006C;
	Sat, 19 Oct 2024 17:05:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Oct
 2024 17:05:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <ericvh@kernel.org>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
	<linux_oss@crudebyte.com>, <m.grzeschik@pengutronix.de>,
	<yuehaibing@huawei.com>, <gregkh@linuxfoundation.org>
CC: <v9fs@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 9p/trans_usbg: Fix incorrect error check in usb9pfs_alloc_instance()
Date: Sat, 19 Oct 2024 17:23:02 +0800
Message-ID: <20241019092302.212221-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

kzalloc() should use NULL check not a IS_ERR() check.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/9p/trans_usbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 975b76839dca..6b694f117aef 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -909,9 +909,9 @@ static struct usb_function_instance *usb9pfs_alloc_instance(void)
 	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (IS_ERR(dev)) {
+	if (!dev) {
 		kfree(usb9pfs_opts);
-		return ERR_CAST(dev);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	usb9pfs_opts->dev = dev;
-- 
2.34.1

