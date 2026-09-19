Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70F471401
	for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789813806; cv=none; b=daSFTPyRAGmZESBV6+ULXTEalq4S2Apaeot06C/Xg2NRxs87nLdc1almxG3+ytI4FOn+vitLE4GrNy7eG5ivaheAxx8tMF7GnrHy7piQ02u7Qv4iaR6h8w5kt5+0PRyIaSYIVRkuGsliEozD56RAoVNX5NESxPzt7gvLhmdME7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789813806; c=relaxed/simple;
	bh=10aNR1/OzVSg92vw+9r9iv8RYBFynhvsIll+J1ZdnXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN6I9//g/KCOpl+Ky5QAo8qlLyux5ONv1zhBuB7+5NS9FV3cP26t5z0MmC+z1NFUqAzDnq8DMAbWK1HYmCNARWB1ynr+mekmK0uuA3EOvRaVFqAs1WiXpIVEwGDAI5vvjnx/OX7O/HjZazVmpCdq9CaZqA+EqVQCkc2ZREGId9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn9bdzrc; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn9bdzrc"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso1114650b3a.1
        for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789813805; x=1790418605; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DJwFYYvkh3jDIq+va/i9wZ56mvOt+2gnEp9WZYEzLE=;
        b=Nn9bdzrcE2J9m6QuUpbchLUIIdQcnqNhGjNq7rQGA1Z07tPjKRMVPrQc4KBVeQDwox
         pyKrqiIkHOSRVbfjAs/S5aQfChr+cW3tVZFENQrwcEgixiA7I9Dze4P+93QJjBLM7QVj
         KPnx56Z5nh9ULzL6r71z0FsKilm90pPIZQbwjtDDvwcaIDVxtnUKajtORbqGxgMSE5Ig
         9rMUFPBiX2SMdm3e9eIsqfONQOXOEiuvV9dCQ/4DUf4syEDIRS3nyoYGDK5bhiINNWSH
         e/Sb9O/f6MtO7xeeW65he3c4U4LKM/prjTZuu2qx5KWl4Sg7tY2JRIGb5XQyperojuDb
         IrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789813805; x=1790418605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DJwFYYvkh3jDIq+va/i9wZ56mvOt+2gnEp9WZYEzLE=;
        b=zb+63kLy9rI/CJbYaFkQ+W4cAPEQT76XphomhKa/JyKA8QqnN6q9EtKGD/uj50Tws6
         Mye1ggnewfrGj2V9Qf3c7SwKTwpHYqh5yfhZBWX/1Lp2f9dySELDWjv4aepMHJPZuQlo
         YrQWMsxtDHvHu02zXL/n2AhAuPcf554hdDa3TRsjncXRC2755H5p78pvzrYrvrynpQqz
         g4wQgHU7Zm4AlKIqaQzGOOWSfjMhyLY8UrCRmBnvExG7dKqc+42Qf8P45MONB4bYYiM+
         UKI+J4eIWpRPcWsJhe6WSdYUEmsDdTA1vl4vL+k2C3VbG8CFnNUys0CF5Wn4JS8To3+o
         Bb2A==
X-Gm-Message-State: AFuF++krF7ve1rxEcVxEmyy4E0P1MEKWcKtSUiyp3sS44nAtE9p3jRWb
	Jez3AMm6fDUm/k1MadedsrUwGU6W172VDmqEOiMBv7jCabwdEf3FQYDGC7jLkQ==
X-Gm-Gg: AYBFou1xK2IflVmBC+iDXs5CS51TnKU6Qy1MEBEaR1IufsE9nf96AE8RPUs6t3KRkpd
	0EREnb1oKJ9Lyhar519rbPB3zLr4CnT3c91zJbPu/dU0gIaCdVVEcO6RhYxByyL+JOLHOt1fHGa
	L89NZ6hgwakrPx6es7Hqs73bhGg+fZj0Sav4p5s/6CJHcGEO1gfzGqPKdRgZUe8udZZrq3FPIJz
	BnYZjhoqpMKmGQfrjFrFbBKABtEqY80aOJ7y9mc23IpTpXpeFVFlszEynz/fqm9NjOXSo8P2JiT
	9ArRDGUDJ/pMHFpii1NU+eZmQfHV0BqanssJMLCRPv5BtIR3rlUL1WoMnGmBCOsbJu2oLs8oaPq
	GYLpyZf4E8zS4iMpH4OKXxzrPM7d/QJUQrkmxoE+NRt7Oa3IL/MwwkVabSQRWqWKQsBLlRuhWDf
	4W8ANhLfd9dl7kgBO44HWteUWYXRR5/XwaGDRxlPFbfchJeAVE2n/Ajsv64xUqqyFM02njQuU6G
	1Op3NJ9VO3tCppM
X-Received: by 2002:a05:6a20:438c:b0:3dd:a197:735f with SMTP id adf61e73a8af0-3dda197740fmr3383216637.56.1789813804679;
        Sat, 19 Sep 2026 03:30:04 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aefa9c0sm797164a12.29.2026.09.19.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:30:03 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
Subject: [PATCH] 9p: bound the xattr size used to allocate the ACL buffer
Date: Sat, 19 Sep 2026 17:29:58 +0700
Message-ID: <20260919102958.142460-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9fs_fid_get_acl() sizes its kzalloc() buffer from the xattr length
reported by the 9p server. A server, or a syzbot-style fake one, can
report an arbitrarily large value. When it exceeds what the page
allocator can serve, mounting with posixacl,access=client trips:

  WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof
   ___kmalloc_large_node
   v9fs_fid_get_acl
   v9fs_get_acl
   v9fs_inode_from_fid_dotl
   v9fs_get_tree

A valid POSIX ACL always fits in an xattr value, so reject sizes above
XATTR_SIZE_MAX. __v9fs_get_acl() already maps this error to -EIO.

Reported-by: syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de6fd6789748a8aa64a0
Fixes: 85ff872d3f4a ("fs/9p: Implement POSIX ACL permission checking function")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/9p/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index ae7e7cf7523a..0dd7e72bbdd3 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -29,6 +29,9 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 		return ERR_PTR(size);
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
+	/* the size is server-controlled; a valid ACL fits in an xattr */
+	if (size > XATTR_SIZE_MAX)
+		return ERR_PTR(-E2BIG);
 
 	value = kzalloc(size, GFP_NOFS);
 	if (!value)
-- 
2.43.0

