Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9B2222C5
	for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824578; cv=none; b=VS06sTmxTggF69Ess/BcMuZ50h427qSASAYFiP5oggS9XZBz7YEg1fq+OKL0P1u9cqt5awbzFLYlE0yuff2xmTGghftt7+Xwe8jQwAKkPmAybVyup30qlex5UVxbSBakZuud6zefb3kx6Ree7LyrDQLGmuGUHgYAFn/hBmzpOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824578; c=relaxed/simple;
	bh=XtiDZEkhpgxr/7/s6xHqE6JEe1Ck5RysQMC98z8366U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srl/xkzDtEKD21zmQ1DrJVczDhKAI3WcOFXV8mCc8pAUb28X0jX59+3hE8Pb9ryUJo3yp+xSGojdy5ZGdia17Z4luaZwmd56/o2m6eMt0ea5aAN08zztdHTpJVURmR7tPJe9m+K0StyAzA29rHz689ztbrpoIFpWxj8tTSwQVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijceL690; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijceL690"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so462997a12.1
        for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789824576; x=1790429376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDAB5rM7cgneI3xUOQ28RGJkgneXH4Fm0vRYATKjiUo=;
        b=ijceL690o+8DDaeiSGW8OYWyJSjq1wNhzS5+Y0WtKPVvJdWhztasGRrBBZUSt6IXYU
         l37hZlF+EaUs5kDCQpl3HOHzWMIiMEjUFai6GZ7pbDZer980OIszsbZtezcdA8YqqSkV
         nkscGOXfL7Nvuij0C/v2ogx1Dv7eF/IyRjsp77oPc5srC0Mmpj0wYgYgpnMAfgkEUQPE
         Vn1zL7ErX2prYzDUyMcOYlr6e0XiCnR6t84+dgwMkduGPk+/JnvYDgdx8rzycuT8exJH
         JrFGDbYvLTTHVqrUkN0TAPLaxiIpFFDKhI+42rCQFqYm7X5YinOc9YabMI5zSRatv/nV
         kpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824576; x=1790429376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mDAB5rM7cgneI3xUOQ28RGJkgneXH4Fm0vRYATKjiUo=;
        b=jv/vHDSWXkLCVIrteP+dC3oI3dSmY0PEtxS/juCknm4xz3j9aFypf5oLkUVcV5NKeE
         xBtwJ4+bwOh79QGbBN39s1WwuMHl/jdpjZ2ZAIbXLi9HUk4rpb2R+sfWcqCw4n4ypaEp
         7WceL79Bfb25VqEvlXUXw/6gjlWd+/Aoz7c6zqGP1gNNKQ77zgIqHnlg7N8ZvjCxjl2L
         xWe5NKLFC01ZDoq1cEM2Xe3ANJB8GECR/sye/9HlFE3qx/g0Y9WCyfmpIsUQWxNJaJR+
         4V3wcOK4boPJTtSigXqX/68tPUqIrJSCJwR8lV6xpq63a9zNA8JEAhrk0ByAHw3ooSMt
         7Ufg==
X-Gm-Message-State: AFuF++n6AESmGobmtdCHgV1Bofg5wZtrKubDhqiVH6pNNXc0DeU2n4+Y
	s5iO26UTq3HBnlCSOcyLxdrSgHm1WFCj1uikQSy3bd4JKpRyIj/RK7Fr
X-Gm-Gg: AYBFou38B4c2Ihp0t3Ec1YjY2k7Hq5Rz3K35dir3PMukdi/WEwjFmfEGFmYsnbzBQAE
	NuskZJsaSsLBk7CTylb2aI1C5k1IYp/TKizdcTvAzK2TQeDe8qxY4cLaGgCsXZSWLs+8/WAzCzC
	ZW7I5Badou5CNSGiQnkYg/N8vwiLIdivK2ChIVQiHsKk/Ai3mlT4iCa68KLD81eUzRGoVikBrxX
	KSeKhxFPs94wzPWwf3nveIbBsS9eftv7m1ST27zyyNX3qViyZU9V07jTnk1RZFxcIn1gTT4ZIB3
	pUOUgwwA6YB2lscj1Jb7tfPMmT/sDfgDrdutF9J08nRAvf4TqVXwj+nAhuDSzdtJWvdpwtn8rDu
	Vgp3f6k/dHPeunUMdklv0ag4f2CijGhqVP1nlhG5QI5cXzIReCextTWRPK2fSssrZs4tx9SG7uB
	cyj9EB2b0MQaEK0ZjYposMjfBdJnYHoU3/FOKEJT+TQ+3Q6zXY4/LGRw+8QnSFD0gR96soUHaTt
	V/3OVrmRH2i5lWKzX2RzANLd3Y=
X-Received: by 2002:a05:6a21:9086:b0:3dd:a196:ffd1 with SMTP id adf61e73a8af0-3dda1970073mr2909245637.33.1789824576434;
        Sat, 19 Sep 2026 06:29:36 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae71fe3sm988866a12.8.2026.09.19.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:29:35 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
Subject: [PATCH v2] 9p: bound the xattr size used to allocate the ACL buffer
Date: Sat, 19 Sep 2026 20:29:29 +0700
Message-ID: <20260919132929.238025-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8777483.NyiUUSuA9g@weasel>
References: <8777483.NyiUUSuA9g@weasel>
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

The allocation cannot succeed anyway and the failure is already mapped
to -EIO by __v9fs_get_acl(), so reject sizes above KMALLOC_MAX_SIZE
up front instead of tripping the allocator's warning. Larger ACLs that
kmalloc can still serve are unaffected.

Reported-by: syzbot+de6fd6789748a8aa64a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de6fd6789748a8aa64a0
Fixes: 85ff872d3f4a ("fs/9p: Implement POSIX ACL permission checking function")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Hi Christian,

Thanks, agreed: XATTR_SIZE_MAX would wrongly limit servers with larger
9p xattrs. v2 caps at KMALLOC_MAX_SIZE, which is already the effective
limit, so nothing that worked before changes; it only avoids the
allocator warning for sizes that could never be served.

v2:
 - Bound by KMALLOC_MAX_SIZE instead of XATTR_SIZE_MAX so that ACLs from
   servers with larger 9p xattrs keep working (Christian).
 - Reworded the commit message accordingly.

v1: https://lore.kernel.org/all/20260919102958.142460-1-ngocthang2710.1999@gmail.com/

 fs/9p/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 0dd7e72bbdd3..915877cbaded 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -29,8 +29,8 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 		return ERR_PTR(size);
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
-	/* the size is server-controlled; a valid ACL fits in an xattr */
-	if (size > XATTR_SIZE_MAX)
+	/* the size is server-controlled; it cannot exceed what kmalloc serves */
+	if (size > KMALLOC_MAX_SIZE)
 		return ERR_PTR(-E2BIG);
 
 	value = kzalloc(size, GFP_NOFS);
-- 
2.43.0

