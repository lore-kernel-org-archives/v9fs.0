Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1038945A
	for <v9fs@lists.linux.dev>; Thu, 18 Jun 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785148; cv=none; b=SfbyO/aOMrbccv/wujwf2mje5uMxYSOa6/9qMI7jo+dqdWXpDb8xXuGwAJa2h3BP/OyBx3s7By2DvZef07V6iOIqkqXtec7usPkNi+LbSYSQ+O1QKSjQCdox6lfm6nXYhYZr4N5O3P35kK/tj5stm247gpNEQVyimqHJln662lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785148; c=relaxed/simple;
	bh=1h85HEiwu5SrvP6LXSFmCX8HYJCZmpF9jCx93UjL+R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1vZWbA2GHET3EZK8fB6L1Xrf4O3Xy5y3FBFDTwUz2oV0k0Y/VsQBgJGIJ8na6AUuplCh5UkJi9z6yoLEMlMn+b+kwmEtJ3KLb6a7wczhEZZtzHJHa+8rhdXvu6Cwbmhgo6GDJjjjgmh/C/fNrxyvUPhqI0LZpP9Fk21fClwtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku5Aiv8s; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku5Aiv8s"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so968762e87.0
        for <v9fs@lists.linux.dev>; Thu, 18 Jun 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781785145; x=1782389945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=Ku5Aiv8s7XRxxmduVs+0KDLzFa0d51pHSq7P/Q9QjE/4Aq6HRRX0m5N6tDXIP9t6u6
         AKVEcsiQWPmdvk2xx3/fGffPI2nBo7J/uvcMDzIRBeI2qr5gpL7vrhm226ZKzRLjq8DY
         N4pPVGW2psrPMsORXqh2usWvVXGY8y7oTN1PN0JI832lO8/qzeAl+JnJLglGNs5yowfx
         N/LXxdf0PRks/A1XHLZxVYWTF++00lh4MPdC0OvMWOGS4l8fac7D3NJH2XankpLE4Exp
         xZeoW2RiCUBrlFubCpqOptyRFB888bXgehHFR1deIw6YkIEG0IFy6g6Aq5pZz+eHOJq2
         u6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785145; x=1782389945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=BYesoAxt6VUFxszrfoiOa05c0VvI9VBCjbTKjlslzuFYjQPlOu+UXc5wKgQP5hDFmW
         hmQ5Gb7kspAFmHe2dHhbmL4A7pjT9wNFOV/5pV8dFE5TsnJcsb9K4A451ol8UE0e2xfJ
         bLVEo4GFmnNMIZEXNjp9L+FzHtHGzQOSc8lHaH6IUBtWbJWR64lKw+sKKZbF/e92GkX8
         zN11Q/Z803McjeeAB0ulViDsSxsKeSDqNyPuXKXViry67MeJ8sEnCMMjI3fDmHHQijzH
         P0mdXwVOLxC63Qfxe7p7q0Ot4HpqayP4zUEmTg2Xztdcdyp9S9eURaTBWzSr6nSuVoo7
         7u9g==
X-Forwarded-Encrypted: i=1; AFNElJ/b0/7ypvF5MwdKkx6dLNVHZSxOLhbx4zE0Qb7rVO3yoFRghXWW5UF3awwr+UIY7gvFnLTc@lists.linux.dev
X-Gm-Message-State: AOJu0YzQlzyCMNSO7dLASm0rXA57ta8IeNebZUyXcL/7NhTofcotwLql
	N4xNXZ4e89/IdRsFXITNX9/AKy7CzTDLPDpwKkZGEevFO8bWUWoL3+ay
X-Gm-Gg: AfdE7ckG2kZR+LhpCkGLTFOHqIC950BhDoJiFLpq7WOvFH5CIzkYkCSIX0t/Uw8FHxF
	5KVBdykkNF+Tm977fuGmNbR5LwHzEbvQfFhaUzY9kQhBiW6wxzeZYnqV6UydmPlmgeWmxnbA/Gl
	DMd+rCYqy5VhydWoz+zrnloj3SGQQNaUB96PiormOikhpwERBG+Iyr5DaLKNvzsmky++KhCCgu2
	E9LVXH40naFhIwmmVjYD6ihuI3JuTSXo3dGlQ5IOTcjmT6fPsD/4cFuFhgrbKjlrbdWICUwMwcX
	/JHcu/z30i8FJTz5Niz2DXjJn8UiP89PWFFWMMQe03593bI3lM2t/nKBKyatxBmPo1hrh1L/2AE
	+mbQz6E4qjq1rIViZARYQ88Hs0rr5oDEho3k1mRvG2EDuJrDQnrkxXDjjLGW7AjGJMTEEoHKDd/
	pUCGWB4B9GLXsflsj8Bbe5swwr6O+eHw==
X-Received: by 2002:a05:6512:3509:b0:5ad:3035:fa47 with SMTP id 2adb3069b0e04-5ad4dadd259mr879893e87.53.1781785144944;
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad4eb57734sm657424e87.34.2026.06.18.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs-developer@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Thu, 18 Jun 2026 15:19:21 +0000
Message-ID: <20260618151940.76321-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangyu Hua <hbh25y@gmail.com>

commit 4ac7573e1f9333073fa8d303acc941c9b7ab7f61 upstream.

p9_req_put need to be called when m->rreq->rc.sdata is NULL to avoid
temporary refcount leak.

Link: https://lkml.kernel.org/r/20220712104438.30800-1-hbh25y@gmail.com
Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
[Dominique: commit wording adjustments, p9_req_put argument fixes for rebase]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[Alexander: this branch doesn't contain 8b11ff098af4 ("9p: Add client parameter
 to p9_req_put()"), therefore the parameter is removed from the added line]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2022-50114
 net/9p/trans_fd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 40d458c438df..bd6a54e6f427 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -346,6 +346,7 @@ static void p9_read_work(struct work_struct *work)
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
 				 m->rc.tag, m->rreq);
+			p9_req_put(m->rreq);
 			m->rreq = NULL;
 			err = -EIO;
 			goto error;
-- 
2.47.3
