Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FD2BCF46
	for <v9fs@lists.linux.dev>; Sun, 10 May 2026 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437761; cv=none; b=ilbrKSoO6FzjWxo39rJ+ZBAazXftxNU5O4kdC/Ikwrczd7V/q8k9UVkdj1tF3f79T2mWD9uU0W2b4qMNfqs/bk+9Z2FMPoErWrF122C2C/+o9deSqmoasxbP1I+VX8Efk+qz0X/Cg5RXEoMT+3nkV3TrW46n/qghzCAFbDouEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437761; c=relaxed/simple;
	bh=2t4BKL5zskePt+1AjmU14PUO6W6EBCK+AHcU3VCOQ94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InEQpsWT6hkg2v1kmsdcTR6H4qbPZbkOI+2BfxXLWveHv6j13pK/1rp7LHwiBG4Xf2RjqaeIZEZfRAGDqIs/BIdOyAbHd1a/C410DFwuQB2l6iH4mjciUXW28OiESgqWqSLHx1DzXOyAUG4tJjO/asdY+y9AwTRCgOotFfpIPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kex0ixYo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kex0ixYo"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8354461da74so1644958b3a.1
        for <v9fs@lists.linux.dev>; Sun, 10 May 2026 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778437759; x=1779042559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnjDtWjU+iUFnsNgB4AwO0xgeo8XnzRB7bbhA44EF8o=;
        b=kex0ixYopk13uSruA4ZM/oLBRjF5OvQDJl+34f0z4PpY2fhXydq4T5XnOo7m+A6EpQ
         zX9+UTZQeH6Yc+tCSyPwYx7kHGOss9wAzQosaWWacBUi9NRCEdDKaJa4HJZMlaK+f1ob
         8oUEl88udrvyUV3b0Oya+zt3Iz/a1cT7xLwrcutlOIb0ovLq49HQf6nHDtskLBsckUNJ
         zmM3NMz+PuXXo9ElRaC/2820IeBSTNKhxIbkHr2Jg0U8YashVJ/RfJsOsS1ks+i0feTj
         t6IXj4yp9JDlKVOU5NrWzy5BanW7OPFY2dpjaDs1Sgho2BU4b6MobNsxT1ZG4byRfHDi
         dWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778437759; x=1779042559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnjDtWjU+iUFnsNgB4AwO0xgeo8XnzRB7bbhA44EF8o=;
        b=WuDVisvacVzIhbRJSPDQivbfuiTyK4WkujtXkpIJvjmNfJ29AUm6mUnGKTJmKXL75j
         QiCVzxfnSDh24L+U+l4bvMNF4EAYmYj/9yQDWTJIUTjlFeg89smPHEp56t6MltrvhAPs
         jtcZg4OT9lmKBcfAA3/gbI9JU56bS1QLQ5c1ndjpku0MRKcn6WB9tHhbh6vl1kXPyxMo
         sQHK/aajrOKh0LzJ5/HYHqZOBqd5M5rVG5lNSK5rJ7/Um2BB3g8sxGc/2fRXOUoCy37U
         oOha277+v9XKvVAP5tWMpwkDPbNo5uvtz2L+6fhFjWXMbtr+vci09S+TWcAY+bq34t77
         /iUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fv16ib4jfaUgvaWWxjz5aPzsT8foqxaMeNBYh8IvAuIOKgZC99V7ZtMjWvZPxNX0RTSCq@lists.linux.dev
X-Gm-Message-State: AOJu0YxPbIphJcL15VX2I6m0qSP03mhvm9yb5jYuJ3hXjRVOCQUyPv19
	P+43rcxrmdv5L1MQ6vtIFF5g7Fb16J6GjdlFxv0BAJlrikmUvLJ75HBm
X-Gm-Gg: Acq92OGcgApKSecPVWN5qU4ImcvZ7aavANKh8faBxbQfifhFyBlgUD/HDP9g5Ri2tZg
	TYb/SJacyBjaYpVhpNpKHXINj3y4EQ/Xyf5Vd0i6GtBWMuJ/HxATWfOcV23jfllrayRbQMiQypf
	/L0Is2ak0pOCx9YJT+vYp/uTD/iL4OCtvIZfZynfyToI1ejdR/hmHBcMHUEVpvgFjsVOvYh4RTz
	oRF8iDVMqjgi01fdFNMTGLHsIKhmNhqsPd4L56os3ruMaNmspIU+0qp1BNtXMyLcmn9KdVT+KKs
	N8HgkzT2U8yXrYs7bEAHNDgqzH1fxXiuw84w0FjNryUJnT1Fx3SiGhKj6neALZfZ2IY8lTV0tmD
	gyF3Xq1PiL3fKaIlFZNcJrtvu6KsEpsD3PLPmfTJlgPKZMtrqoXgZd5mdkQu7rQX77MTlj6/LXB
	mA/aWXtdNj/D+hwDX31QPPCTYn257Poj7MIV4=
X-Received: by 2002:a05:6a00:4ac4:b0:835:7c0e:b529 with SMTP id d2e1a72fcca58-83e39c33441mr6531203b3a.12.1778437759341;
        Sun, 10 May 2026 11:29:19 -0700 (PDT)
Received: from fedora ([157.119.204.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a272asm18132388b3a.54.2026.05.10.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 11:29:18 -0700 (PDT)
From: Aayush Patil <aayushpatilsch@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Patil <aayushpatilsch@gmail.com>
Subject: [PATCH] docs/filesystems/9p: fix broken external links
Date: Sun, 10 May 2026 23:58:56 +0530
Message-ID: <20260510182856.17569-1-aayushpatilsch@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xcpu.org links for xcpu-talk, kvmfs, and cellfs-talk are dead
with no archived snapshots available on the Wayback Machine, so
remove them. The PROSE I/O link redirects to a dead server; replace
it with an archived version from web.archive.org.S

Signed-off-by: Aayush Patil <aayushpatilsch@gmail.com>
---
 Documentation/filesystems/9p.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index be3504ca034a..65809a1dad21 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -23,13 +23,10 @@ the 9p client is available in the form of a USENIX paper:
 Other applications are described in the following papers:
 
 	* XCPU & Clustering
-	  http://xcpu.org/papers/xcpu-talk.pdf
 	* KVMFS: control file system for KVM
-	  http://xcpu.org/papers/kvmfs.pdf
 	* CellFS: A New Programming Model for the Cell BE
-	  http://xcpu.org/papers/cellfs-talk.pdf
 	* PROSE I/O: Using 9p to enable Application Partitions
-	  http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
+	  http://web.archive.org/web/20110101152020/http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
 	* VirtFS: A Virtualization Aware File System pass-through
 	  https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf
 
-- 
2.53.0

