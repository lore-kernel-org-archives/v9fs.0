Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D43D7D69
	for <v9fs@lists.linux.dev>; Wed, 10 Jun 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091733; cv=none; b=kzGOdm2hZIjzKqnWf+lAQF5o1mnvbbziG67wSCkNoP+bzkXwxDf2AJfOMYfH5uTdBPrBRtpMxW29SOQ+aTyrYUPEbBYU5PjGexIXxFoTM6V7clxmSsRLPL9OR1iFueXACvhZ/AEhvXAQwWIgWK5bGdvdKHx9lp4Gue+7unBZ9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091733; c=relaxed/simple;
	bh=jgKmE1kKV3b0d5YkmqgCMwOqD04XBbTPa52jDu60x38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tmh0ZOW//oHHNNAG68WpEV8TYCxhVkO4mZeMtWW9pRR/UhG7CO/zvqp4cbfQVy14iPFZFOsZm9hOYT96d6mizDulBts2E2j8gsDhD4lMP0cvqTzzyJZtK80AWInTwGrWZqR6niTftxFGEzrfyW9gmJAZax+3rhrwrl1WUlX1rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXMQki93; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXMQki93"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517b1f2c6adso34965401cf.2
        for <v9fs@lists.linux.dev>; Wed, 10 Jun 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091731; x=1781696531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=bXMQki93bgOHWWSI1qIU9XPp2HbPiCS1UW5+RoOBayuLKKQRm89oIYTmQE+LrUPlqU
         jUw/dok0+tfmsazit+otwJ4cClnUPqgRWxmheJ8vyo0VQWM4TlVU+r0Jmwl9kmY+MQOR
         ZzyouVMo5NlgkKQ9DgjuLfBoI4sSowsDl0sNvlchONWWIugzNcyxhv+qjTjYJ3wl7hYd
         HMjqCnJ+1tYwaSOSJP+J+2PwqkBp2DyGPR1te9p4WdHNjFjkmKYmp0YqfsZltvdfoiWY
         dhsu2diXsAsqI2leVmy+AVhGhuWTPXXJmwfEWANHMiyRGcQ9uu1VPotMmCxovkbCPGbE
         tvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091731; x=1781696531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=eqLKdHJ5gCNz1s4n7I1M7SsD6FGaNqHCX7Qu1Hthv5DM42tjFyI7cNaRMhZd2jbUzm
         fNqbzEbVn34Q8XIAMwMnk4r9A6Nzicjk6l2bbapnDVXFTkpOV9DSHzBRqgsylT3lgXwg
         Jl1w3p+G29vjKS296fkCcTLHIF71ASqyLN1zkxir5qs6QR1uZg2Sxx6xbPO3wfNVHgrW
         RZynnEsl0isTYQb4iisiWRCCgducsY0Rl6u099bhIq+QXn3j2BduUkmxQZgDpB1W6WVw
         rNiCqmwyxyA9CCFDeMGobK4iHzf2Z6FIyTW+T23UkE3YShwdgcf0Lt16pdIwXTnQbqLH
         SqzQ==
X-Gm-Message-State: AOJu0YwM1dFbEpMlbFsmx+jC5MQ2OqlyyoyAskJPgFNfexRvefVD6b/v
	TUvYXxajAAwGegffLtc3xL/lZKsYNK7my3muBsQjz17ElDY8FcTrIDQL
X-Gm-Gg: Acq92OFXvAR6e+QQj4Qmb0jF5/SgchSygSszOFiNBCtPspvZe11P7PafYe3uXwIpzee
	ghGURDezR+IgViHEygK40VDfT/e7VDfK1ID/H5nalrQjG9/1OD8c8bmQ/oKDyA3pnLtFq9fU8Pk
	M7xEhv0gGU2ObctoWtd3Xu6NiKrCOR52x+P5ewkvUisv1XdrNGdfIF+leZ5uCcd5YETE8r4a6JL
	ZLcWW9098JD1AnAxu3zz2RhMOxsZ1NymISswQR8MOpMwraLB50fmlet3+sUJS72qkagsuGu8Vdm
	ayAVlYUgX6NIBFkPGMm0xnZmnY1VUYQgCXZ4GfNm0VBveRm8vjNIWxMsxGVDRLtfdbOS7479h3z
	IM3jMhGxXJ61anFKVjG2DILXwfab9JKxxJsm47wE3ahXPV+nMrg6vAFRNC5ykMjPYyXpDzj2b7G
	g6LaL9rRA4GcVTwuf9XEhrlwaUl6hm8QArU7z0VMSc6oO8eUsIVuaJhZKlwFLv/51ZCLHvPhxo7
	I5Md67Ko15oIkUjrVI15zoP+owxv8M=
X-Received: by 2002:a05:622a:8d04:b0:517:a02f:171e with SMTP id d75a77b69052e-517a02f1fb5mr305363591cf.30.1781091730803;
        Wed, 10 Jun 2026 04:42:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm216095931cf.4.2026.06.10.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:42:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
Date: Wed, 10 Jun 2026 07:42:06 -0400
Message-ID: <20260610114206.3749904-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

p9_mount_tag_show() copies strlen(chan->tag) + 1 bytes into the
single-page buffer the sysfs core provides, with no upper bound. The
mount tag length comes from virtio_9p_config.tag_len, a 16-bit field read
from the device at probe in p9_virtio_probe() with no cap. Under the
confidential-computing threat model, where the guest does not trust the
host, a malicious or compromised host can present a 65535-byte tag with
no embedded NUL. A read of the world-readable /sys/.../mount_tag
attribute (udev reads it at probe) then copies ~64 KiB into the 4 KiB
sysfs page, a slab-out-of-bounds write of host-controlled content.

Bound the copy to the page size in the show handler.

Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in p9_mount_tag_show()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/9p/trans_virtio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 4cdab7094b273..b62aa7b309f1c 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -573,7 +573,11 @@ static ssize_t p9_mount_tag_show(struct device *dev,
 	chan = vdev->priv;
 	tag_len = strlen(chan->tag);
 
-	memcpy(buf, chan->tag, tag_len + 1);
+	if (tag_len > PAGE_SIZE - 2)
+		tag_len = PAGE_SIZE - 2;
+
+	memcpy(buf, chan->tag, tag_len);
+	buf[tag_len] = '\0';
 
 	return tag_len + 1;
 }
-- 
2.53.0

