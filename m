Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CE3A2E33
	for <v9fs@lists.linux.dev>; Sun,  7 Jun 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834681; cv=none; b=kPs0cDiA+Mbqw3kld7q98STCTfreD1XwtHqgAV5ellqlDlqupRHaSrBEpKpYyQpjqnfh/2WyWkFZPftE+fVfoZrx2JhXq1J5aQLKdrt2aMb9zFiK6yITwWy/bdOI5hroCCxvnWJVDbyyHPPztagqvl0Li1XGA4S1o75MjT6UDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834681; c=relaxed/simple;
	bh=t2kT6ShKybkMO5M6yb/Apz3xgBUgTXClyy1kXUIo5eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gls8U+Q1npyZlFq3UUlN82zdA/OpLZ8qR564XZ3upen0oPECxowrfmSdNs3SBBhPxclucJ0BFDlRGZ4JhgPbLQgxjMlkBjINHRizLBROcJHM2W9L61p6JQUKjk6yjBpvjL2Z13vAaFj3+8KaExGsemI3dtGYZNuS4VDRViqQYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=FVr/s3P9; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="FVr/s3P9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Fixes:Reported-by:Reported-by:
	Reported-by:Reported-by:Reported-by:Reported-by:Assisted-by:
	Signed-off-by:Content-Transfer-Encoding; bh=F1YNUv9O1Yd4034X0Yct
	yewFcLtSLMDpTndmgPSX0F8=; b=FVr/s3P9lE2olx/DDcSgFmJbmH0Yqqjw2+N5
	KMkmhkblrGk6Gcs0QPSDfuyYtiRXy/0wGDwNxgn4OWKb82X53t/rx187JBPqPCAz
	jd8ZYgJZawcArro564LxtEmKdOLNkCBcm2x7GpU6ulyAonxXOJqLvGSxhFdEnGy0
	Mt+kr3I=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web4 (Coremail) with SMTP id ywQGZQA3HJxmYSVqva4TAg--.42907S2;
	Sun, 07 Jun 2026 20:17:43 +0800 (CST)
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
Subject: [PATCH] net/9p/usbg: fix prefix matching in device lookup
Date: Sun,  7 Jun 2026 20:17:24 +0800
Message-ID: <20260607121726.11749-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQA3HJxmYSVqva4TAg--.42907S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcV
	AFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280
	aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK
	6ryUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCF54CYxVCY1x
	0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj4q2_UUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQYLAWokna+E8AAAsF

 	list_for_each_entry(dev, &usbg_instance_list, usb9pfs_instance) {
-		if (!strncmp(devname, dev->tag, strlen(devname))) {
+		if (!strcmp(devname, dev->tag)) {
 			if (!dev->inuse) {
 				dev->inuse = true;
 				found = 1;
-- 
2.43.0

