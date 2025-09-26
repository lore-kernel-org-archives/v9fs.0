Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD6272814;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878860; cv=none; b=r6m680o5GCqm9truySclKabgnoLqqxs0zsFp8VT4Uy7T2OtyMMnDRU3pGkGWYrHEAgoFrZDP9Yg3hpzOQONPYWDEtqbh+ekKUJu3Y+SYeHe2RMAWSHoKLR6/+tHSQZ/EK3ocHKJDwkHbmyD9L/lJWt1DXBJRA6uIWYYY/u+wqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878860; c=relaxed/simple;
	bh=7+xo7yY62YsZx/1cxiYO/JwV9VBbH7OcQ+0UJ6TV3og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FN+/J9AYnaJMCaTq2pTsb0rbl+2I3Wshj5pHlbfHNywTdzSdVjsd4HaO2NKgfl+as5J1xD6G/iZuqI5IBPkkwNi4N7OVVUn77ECjzd2ZTCd3ica+LIHWaey0XbtDGQ5AChPFRfy+1cPT4jt9lHWAbqX2uYq/k5dsLTfbFOwPe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC+EiBDe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC+EiBDe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94AC0C4CEF7;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758878859;
	bh=7+xo7yY62YsZx/1cxiYO/JwV9VBbH7OcQ+0UJ6TV3og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aC+EiBDeL9pBQkl/l2G1zexDs1gNBE6pq2qL921lSn7ou2fnjmx50BPPCua+LODtU
	 FPwTmnWzHHsbXthY01wKoIHNH4gFDNpEniXe2aJTreDuq+0IB5JjJ/wEPp26BDpqHg
	 7ybAKELxzmIGMrVg81oZry085gdkmAb0K1T4xgs55z/8ZQulRDVBCwUKF8VhYs8hSk
	 1HxeEv0iEoC1YkMvrp1jrb02sVfHUqKC79nr7vQvyN6h/CR0XLTZcraz3ltlTPOcUD
	 X87FKDjbQ+UDddzJYnHYfzsGY+b4foDxSx1t2plxJrzb8eHTjrR3f8ua1PB3p7ew6I
	 y3sxXmRUEZXpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE67CAC5BE;
	Fri, 26 Sep 2025 09:27:39 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Fri, 26 Sep 2025 18:27:31 +0900
Subject: [PATCH 3/3] 9p: sysfs_init: don't hardcode error to ENOMEM
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-v9fs_misc-v1-3-a8b3907fc04d@codewreck.org>
References: <20250926-v9fs_misc-v1-0-a8b3907fc04d@codewreck.org>
In-Reply-To: <20250926-v9fs_misc-v1-0-a8b3907fc04d@codewreck.org>
To: "Randall P. Embry" <rpembry@gmail.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=957;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=gn+Wu50PLn45xmVoChT1EsToJxDhrtvpZbSqmSUmcd8=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBo1lyKQwca23NbZ83VZF2cYauPoOy1Y4BjyFq26
 TzZCllr0DmJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaNZcigAKCRCrTpvsapjm
 cDCkD/4q0ZBLaufKQhUuJnfMggUKocITlkvpCcrgSyBv60WkuSkHGAJ0mZ1tOTfXe07pV88nS02
 8oEb5W9IcQY1MUZkWVU3qET4xr4hYR0zWI62PrcewGaJgu5AT6HffWTsZyQPG0L00wI8W+0Qy2U
 J4eM1fX25aZj4BctIH6gtT/XVqY15A81A1tpGwtUKjw2MGiElF5kscHJYl6Ig7t42Obm0Qx1qer
 yy3J3ePk+1HlWiKxhHFH+3dXFh75ozwaTD3g9b6T8FIuJ2Sv3PdOavngMDn0DpbsfOJoZWOy9R0
 XAdy8Vy7EUjc7tok1kcQCCCN3TXzNvo4Mt4XaebtcrzU4eZJa+fX1uxcfFshOJClMu5Wr02Xmid
 zyKk60N78If1UP+xbWsh0Pf9aj2hahEVSfL5KfmB5kRd52hpNvR3kHp2jzrmo/24ssLkl9vnive
 3slrOeriFa9PbCDZxkWEMXcV19K1sc7qslTbg25F/+BxYNwxHglWvPEqzlSjYZs6OyKcnOvWwqM
 0gJWgHmBsx8qXnA6f16TLHPoKFXuCuyqdhA3lMJ5hpUkBr5Jqma/OZZ6vX1Rtx3CjjrSAxfNCPP
 HhMWv52p4sZQplWLZXvkjCeucFs+w8+hJ9l2z6j6sUBVPUaD3aVdzvE0yIv5G/LoV3ovLTmDDD9
 aYl8d1MiJ8g5VEw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: "Randall P. Embry" <rpembry@gmail.com>

v9fs_sysfs_init() always returned -ENOMEM on failure;
return the actual sysfs_create_group() error instead.

Signed-off-by: Randall P. Embry <rpembry@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/v9fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 4d289c56578fb15e45d8e94a264977898973cb31..a020a8f00a1ac074e826a728c5a2b1ef09ec87fd 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -596,13 +596,16 @@ static const struct attribute_group v9fs_attr_group = {
 
 static int __init v9fs_sysfs_init(void)
 {
+	int ret;
+
 	v9fs_kobj = kobject_create_and_add("9p", fs_kobj);
 	if (!v9fs_kobj)
 		return -ENOMEM;
 
-	if (sysfs_create_group(v9fs_kobj, &v9fs_attr_group)) {
+	ret = sysfs_create_group(v9fs_kobj, &v9fs_attr_group);
+	if (ret) {
 		kobject_put(v9fs_kobj);
-		return -ENOMEM;
+		return ret;
 	}
 
 	return 0;

-- 
2.51.0


