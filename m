Received: from outbound.mr.icloud.com (p-west2-cluster4-host1-snip4-10.eps.apple.com [57.103.69.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52B2777E0
	for <v9fs@lists.linux.dev>; Mon,  8 Dec 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765223529; cv=none; b=pK9+lQ8/2Rz9vC5RE9AnyOGnm2ZVio0PYPUEG31RvaRbacNsbzE5JCZdekJOQk8F5IHMr0YZjvtw/v8AscK2U6BYpSAWELb8olcfonuEOr42uY4jzjzuYRippA4KrF70BYXwwegWb2WPqH7lj4UJp5dE5/2znn8HfcrK3B0kRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765223529; c=relaxed/simple;
	bh=W8s8d+IpYsHDQWqqQ7JvWmMvGU/yyn0x5yMIBkiVupc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RabcTXrTtjIMRYz9vuvX9g4P+wsSfblSDmciROa/yltpryhFJo3//bxA3b2UDvSTyT2G7pwZ6O+nTAJpzS1Wivnge8gt89rwwvtX2vR81nN1ZW9MnaM7WnYI8ZTTeBMiGtJK26OlnnPSNip+OhyxQ6V8/vkYJfcmwb+JRCfAAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space; spf=pass smtp.mailfrom=ariadne.space; dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b=Ir977hqJ; arc=none smtp.client-ip=57.103.69.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariadne.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b="Ir977hqJ"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id B1C3518013A5;
	Mon,  8 Dec 2025 19:52:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariadne.space; s=sig1; bh=DvHhgkq2dJ0sklVse1aa7ik+cqkwTEL9gjApsPpOcPk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Ir977hqJXy+lPFMRIZJUBmuyolPNe+HhmMPQZDPQX/VOLSpIOwxl2t5H81O04yy8iANqNwjm56wDLwTXV6g86kDtzzvMfGvCBqFYxZUP8Ra6fCblx8KNbXeor4hDEdZijL7GaOZliIH+T7/FbaCrZSeTdACflFevxgA5NWp/C5fLpdL38YDBr4c0Kz/r+lwnfw4bIB1v5SspHkjekSTVeT7OYUDmkrdN+/NMs/kbgE7OlATsjsmfBw1Mxm5KfBZ+JRaT1BtlSnlZUGuN6IlTGShAafOXyahs2VFMgxTPvuY0iDy6gqoBEazf2McqQJiGM4sd0L6jSluKhF5yVrFHPA==
mail-alias-created-date: 1688796967087
Received: from phoebe.taild41b8.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id 9A3A01800138;
	Mon,  8 Dec 2025 19:52:02 +0000 (UTC)
From: Ariadne Conill <ariadne@ariadne.space>
To: v9fs@lists.linux.dev
Cc: xen-devel@lists.xenproject.org,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	ericvh@kernel.org,
	Ariadne Conill <ariadne@ariadne.space>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>
Subject: [PATCH] 9p/xen: mark 9p transport device as closing when removing it
Date: Mon,  8 Dec 2025 11:51:55 -0800
Message-ID: <20251208195155.27473-1-ariadne@ariadne.space>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EX3QNWAq4p9Q36IVYhk4hN6tDjCVJVgw
X-Proofpoint-ORIG-GUID: EX3QNWAq4p9Q36IVYhk4hN6tDjCVJVgw
X-Authority-Info: v=2.4 cv=f69FxeyM c=1 sm=1 tr=0 ts=69372c64 cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=k0M0V4IRsTHp1vcmCjoA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE2OCBTYWx0ZWRfX5xZ2+rgn0Y/4
 Qv7tsTi0IKi0zb2IZUVafW6TZF9iFY9745vHH0rxoUZvI5ygfjgeuSlmwmMGR/yPc2bNFVFjfaN
 TjdKpfdefNGdjBSKQCabjDGhQnWejGiOy9JTO4/B6Nfw249HywEG1W4qLT/tO0nDMTYD1nUHr1C
 B7Bbc/YNuqReFBKLyoSJSNl402ka8P+ZFIEb0uLu/pqcvOO9/TWpnRlUECRAaqddrX3QEeolmEm
 A3xn/J03tuNQyYi2NnO2yFX8fH8jyeWd0DHFx0MQ2wCb4E/NTfS3nw18imfVoTYDEqWjh+oTz+C
 /iWPrTcyIRg+yS+PXcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1030
 adultscore=0 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080168
X-JNJ: AAAAAAABmt3X/758cjYAQS8mYvsy7oEhS4QHglaBA9kiQvxB0XGgJqzOok1JcvHOGX3vNJSCA9RPAF3s3p7S6EEL/PgZOu8MdVGipaCDUNImHK2A9oXfxB9buA6dwgVIYulZGSnBaK8bLmEsQIjUyNXnTYFNw83wfB53TRrBY8oMwkN07qL4ukyeoLwkwJYWYDcIN5ybEZ9SKbNVPTtN3WYCkT0IpdJMzgG8LkgcAqHAv0Ti3jNG5uHTcCcKwYG5cvbTrXit2atGiwTaqxgPUI9AK0LcKxbY2YPrJVkOI23TF6sXbGphr8F1hcJGbeZe41MYGTxYvZEPPDjxMKURxGETa0QhEKR2psrpY2dSZyqeoYFAPWBNAX13DYo4ObWAikfyJmgnUidCZDpkcemckAkD15jr5OeVUovjHxrRvbr0AYPMGckY2BTr8QWHJfRT7IpVulcQih/sML9gTy/aDmjUwe1vLCxkZt8xe91NHlLm04/81NhExbX7Lf4zc5LBpZhyymwFbgKl64VjVY2f8PaSQ8RBVQExFnUUCgIBqIPXGgqO22btw9QG0E1ZJ1yfV2bjH+3lX+mwcW/gmln8B2VRPYP0wSpa784xeDEcwCq6Bki9bv8te4BOmVFuo70/ZWe8OpI/D9+2EoXbmSiojVUJ2D1ZGc/zk0Khk4xMglfGeFjgwFO0FyC4iEDj0Jak+1EwVts78Z703xQURQm5uBwwuAk0IG/IeajulQ8=

We need to do this so that we can signal to the other end that the
device is being removed, so that it will release its claim on the
underlying memory allocation.  Otherwise releasing the grant-table
entries is deferred resulting in a kernel oops since the pages have
already been freed.

Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
Signed-off-by: Alex Zenla <alex@edera.dev>
---
 net/9p/trans_xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index b9ff69c7522a..cde283c42dc6 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -312,6 +312,7 @@ static void xen_9pfs_front_remove(struct xenbus_device *dev)
 {
 	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
 
+	xenbus_switch_state(dev, XenbusStateClosing);
 	dev_set_drvdata(&dev->dev, NULL);
 	xen_9pfs_front_free(priv);
 }
-- 
2.52.0

