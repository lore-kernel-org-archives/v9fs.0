Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A92EA483
	for <v9fs@lists.linux.dev>; Thu, 25 Sep 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803307; cv=none; b=dKzvYE8bQ9kHYWwqYOe+pg6Wiq8OqrXtwTWHr6uD/fk0T7qtrWASsseQwJYbM7j0RvR3Qxu/bqdvu+x67SENvUEuSeAZeL3fsQwQj9YiFJiJvPG89j6TCTD4c4KkD0OlrIOycSqIaQDybaLl1nRq3LCW5FMtRbrA+fYCgSIttW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803307; c=relaxed/simple;
	bh=n+Npa7HxFe6GydJe9QQHI1j2Gl2iX/SizqTe5U1vWuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TVSJYBM6Nu6psfFvG82MB9kxpSyYhyMJWA/mJ4RTBH24HfZqaTyCc4pTQKpaMLaQOVYjc4buk4dKOocRx+CdnEUIntWWevcowEj8jWsaupkbfq8lmjyFd14TRdvGi/PgH+wilV5YHGuTrKQyWRTCBVr/zarmI7Sf1XIwc3WVtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGRhhpyj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGRhhpyj"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8e8f45829d7so78994439f.1
        for <v9fs@lists.linux.dev>; Thu, 25 Sep 2025 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758803305; x=1759408105; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPSfZsGw7TX5UGkY7/kJizo+KvLE8uMTFRrfjAd897s=;
        b=aGRhhpyjFiXEttWz0Kz8OqAEwv2I6rrEGWu3hxUWmY/kk/scIxOq2bH5Yqx0iD2NVT
         FloC1ZDgBZwSRtZY9Ke2VJYt7tBQJ+//UB1b6xhqau1de+9I4/2WZC0cY0r6xxcGGT5G
         XrsRwZuaaPZ2jLj6rbzIbp3vO1Sa8Mc8riQn7AvhyNgxOhd2moX7fp+VLv7k8+cyL85m
         pvmjNMYXtAMsRlp9TKu41L9b/ydGgmfijWwS2BFaBFM/Keh/9CRNVLgxwmsGy2rU2VG/
         t9FU8SeAPU8p39BAezZYKPoETebnsF2cVOHgiROqGMjYZxZ6Y25aYxWssGuPX8H1J76v
         vk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758803305; x=1759408105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPSfZsGw7TX5UGkY7/kJizo+KvLE8uMTFRrfjAd897s=;
        b=oGYbx6XjqOBYFrtb2RGaR78+uUr0PfwsQ3FhOPDj49DbTvnfC3gbeUWLNhv0WWkRC5
         yBmItC+9f2ap6teqzVescpvM9xdUPZ2jOmh/QlcoRILHzX6DKr8c0jbXCmXba2ZNsgXc
         coTb2HJYyuc7EYTzzwmxhjPQD2tvewBk2EJjrjyyTo8grdXjuEuixXjXN394HIHAPkIm
         vDOQIzOz47b/zo0qoxszhAtO+Gh4HD//2JNZqdd8DwPqXLgU1gJIaOao7ofBrzMiLM3s
         9RRaEMGf2jhD176Lt/RD5l8U/ca0Hsot4st6ioFXxtcOI9uHtDIxxv/zALQrorQAUUqV
         3EGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo6rd5YZ8A2MP9PKsnPNmu3yK+C23MxlwKGpw+P2Lhnd5huWbDRG+DZ/oDiXYWFXgAVB1M@lists.linux.dev
X-Gm-Message-State: AOJu0YzQqjW9B/tA5/LZRSnjTBIeRAelEXTszBgrviCtoBVAd8bVsNvC
	+S7J0yB1XO1x4wBGeNlRXL421lF3gJfgD9TASV53Q2dUigmn3Lhz8/ol
X-Gm-Gg: ASbGncuSE5pvIlR55xm4gacQnqzVNn7eky/zEjHdMt5RU5wqqP6Chug83op9rmNUYr+
	866fRlvIqLXHk5bidTO3/sk6m1CgfiSv9MO0XNtUBIuUADBLG8fVaTCFbwCmfKs0VlNIR13MWtx
	a4PS2Cy7UUoMY5iBrySIQxFCYjhsTS3d5gRsD/IzxCIhb6anGQrdmWK5ytfPoDos3ShPrfLWGpS
	mwbEQGbbkiZeNNDyGDj+vWPICKJTbjh2FbKMDEGVuLcXdGzdcgZ2X8F4aXH/tdVxsoPBTzZaMF6
	zvsNZg+9Xig7eK0s76NiOxK8b+KqPyk0Ml/TdO5AXJwzc0NYorWzdCn21q6NUSwYBH4T7ZBKP5n
	orgvEiDEKIGL2OuaTbNCVUyWxxF/1WlWmZsDFmq3QL3/ZbvbVb8YUmLlo
X-Google-Smtp-Source: AGHT+IEuMMUPS//JklNGnOQsAvqh7k2xGg93mFxoo3yy0fiAmwe3+/f1l+tIeLAmveKtS9CTO/DPqw==
X-Received: by 2002:a05:6602:2b8b:b0:876:adf1:b263 with SMTP id ca18e2360f4ac-90155d6f121mr523173439f.6.1758803304705;
        Thu, 25 Sep 2025 05:28:24 -0700 (PDT)
Received: from IU-KL9VVWHMWT.uits.iu.edu ([2601:801:180:e310:a9a9:ec82:aa70:f956])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-904100c3cfcsm70867439f.23.2025.09.25.05.28.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 05:28:24 -0700 (PDT)
From: "Randall P. Embry" <rpembry@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rpembry@gmail.com
Subject: [PATCH] 9p: fix sysfs output overwrite and clean up typos
Date: Thu, 25 Sep 2025 08:28:02 -0400
Message-Id: <20250925122802.72580-1-rpembry@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While diagnosing a UID mismatch issue with 9p shared folders
under UTM on macOS, I noticed a couple of small problems in the
9p client code:

  - caches_show() overwrote its buffer on each iteration,
    so only the last cache tag was visible in sysfs output.
    Fix this by appending with snprintf(buf + count, …).
  - v9fs_sysfs_init() always returned -ENOMEM on failure;
    return the actual sysfs_create_group() error instead.
  - a few minor typos in comments (e.g. "trasnport" → "transport").

These changes improve debug output and readability without
altering core behavior.

Signed-off-by: Randall P. Embry <rpembry@gmail.com>
---
 fs/9p/v9fs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..e3e6890718a0 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -438,8 +438,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 		v9ses->flags &= ~V9FS_ACCESS_MASK;
 		v9ses->flags |= V9FS_ACCESS_USER;
 	}
-	/*FIXME !! */
-	/* for legacy mode, fall back to V9FS_ACCESS_ANY */
+	/* FIXME: for legacy mode, fall back to V9FS_ACCESS_ANY */
 	if (!(v9fs_proto_dotu(v9ses) || v9fs_proto_dotl(v9ses)) &&
 		((v9ses->flags&V9FS_ACCESS_MASK) == V9FS_ACCESS_USER)) {
 
@@ -450,7 +449,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 	if (!v9fs_proto_dotl(v9ses) ||
 		!((v9ses->flags & V9FS_ACCESS_MASK) == V9FS_ACCESS_CLIENT)) {
 		/*
-		 * We support ACL checks on clinet only if the protocol is
+		 * We support ACL checks on client only if the protocol is
 		 * 9P2000.L and access is V9FS_ACCESS_CLIENT.
 		 */
 		v9ses->flags &= ~V9FS_ACL_MASK;
@@ -561,7 +560,7 @@ static ssize_t caches_show(struct kobject *kobj,
 	spin_lock(&v9fs_sessionlist_lock);
 	list_for_each_entry(v9ses, &v9fs_sessionlist, slist) {
 		if (v9ses->cachetag) {
-			n = snprintf(buf, limit, "%s\n", v9ses->cachetag);
+			n = snprintf(buf + count, limit, "%s\n", v9ses->cachetag);
 			if (n < 0) {
 				count = n;
 				break;
@@ -601,9 +600,10 @@ static int __init v9fs_sysfs_init(void)
 	if (!v9fs_kobj)
 		return -ENOMEM;
 
-	if (sysfs_create_group(v9fs_kobj, &v9fs_attr_group)) {
+	int ret = sysfs_create_group(v9fs_kobj, &v9fs_attr_group);
+	if (ret) {
 		kobject_put(v9fs_kobj);
-		return -ENOMEM;
+		return ret;
 	}
 
 	return 0;
@@ -669,7 +669,7 @@ static int __init init_v9fs(void)
 	int err;
 
 	pr_info("Installing v9fs 9p2000 file system support\n");
-	/* TODO: Setup list of registered trasnport modules */
+	/* TODO: Setup list of registered transport modules */
 
 	err = v9fs_init_inode_cache();
 	if (err < 0) {
-- 
2.39.5 (Apple Git-154)

