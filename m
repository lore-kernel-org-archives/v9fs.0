Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0937F74A
	for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856261; cv=none; b=LNc6iN7oKVbw6VI2ZfL35uh4H/8bQ6BGQig3CgX7iQXbfvUbLgw/H0xLFSdxr40AB9fyvvAvz9FEfnAUzY6n8nZSy2wnggNb3VrfuEqlqBEHcv3UkxJgRht87tvgvz+l819+V6e9244Qm+bMkS9Cv34Rwo6fHVm5cWd2G459IU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856261; c=relaxed/simple;
	bh=izERj7mMYMZP8a58ghw1dMcUDgkI25VI8ILJPRKWBIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJAXRurdfEjrbmPyXFYF2GkoLJmo/DYtIybX18WaeLxGxxZ/E1srDSf5b6KIm3iNfB7+BmJ78baw9TUMga9mQvdBvamWM9wjRijATpX9/3cTX0Sx/xEhn2oTbb9B69rzEpIoB1sgNTnmH3rIy+nGCSnHfq6weKDJiQmHK9XGJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0O7I4ir; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0O7I4ir"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a1676000so1563522a91.2
        for <v9fs@lists.linux.dev>; Sat, 19 Sep 2026 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856256; x=1790461056; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FF3mgttlrX3lpY2tZYfCgtrWlE9NaF6532nlaa/wgVQ=;
        b=g0O7I4irkdw2zxkjzRwHpB/K+b4f9omPCHNcI/XFYn7jxBu0z1AKtoZ1ljjxDdBbt5
         7H/2UY7217SMGviTSSdj4EZPjxLxen/m0XnlryKNS4ipxR8MhW+dl4ZoUzV9I6Lk28mR
         kiK0Nk6OQN/MFCNNHyJGQTCB10YcEgxPgVv7HLo+EUg+w4rthrHcTarzq6qzOSjxdF3s
         yiW0ST7Oi4IVeAsgDVWGcWXYJz/gxnKamdDouLSaYQPFVoBLZe20Z1Oi0a2zPq8vPu4Z
         wmD+6w3x7OoSuwDXrmZoHZEVNdPS62o/v+ziQeh+a+/MDaumXzz9pDUjf4sCCYwKFsOX
         WC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856256; x=1790461056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FF3mgttlrX3lpY2tZYfCgtrWlE9NaF6532nlaa/wgVQ=;
        b=WT2zcAbYCyHpDJbnbNKpPrWb+9FrmMHkwgCUVdjmOTF4b56FTTHE36EXGAufFZs08i
         ThIcYrbHNKjgkchFXJ5VyMwYocBfrskom5H5e2yrQt0Zf9tmzID3hWDQz4RL7UbMdaeN
         lx/alzH6H7Ow9NxNYBuLo5Y9ELIlzyvD3V64ZDWWX8xoREg8huNqJLitmU+mgXMT1R7L
         il5H4nqwLfs1kDiQI0fDFes8MLZwhfEjMWUM//K+LQ3ZyakKY09D8wmNBy8ONwyFsGds
         SDLoDPoi6dg2qKmPslYJDV1OgBHq4pB/K3YKL8xvKJLcyhiJDgAcNfTiW0GZwDIHsdga
         K1Zw==
X-Gm-Message-State: AFuF++ncX8AQf9z4/g9RtrEm87VS7EiiX/5OMkEtGdvuQ+i998NKf9xN
	DVtVmBN9AdEi/5gMdkfxep/izUkPXgzg2NgGo+J7A62Hk+ij9yRpoTQIkhR4mG66
X-Gm-Gg: AYBFou3NcGUD4JwD6WyRl0HbqDtw0exW2KD2WI0YZiXZA3tc38Y4s20cKrcmpYPPS4x
	LxA8gJQMlgKUbS0EwO665CWR5N8UjI+HEZ6YQjLXXH6bDOkB9RCHwXfsXmd++tgWEKIzKsSrRQs
	m9CPBodRxn3wJffXQc73z7kHMgOdhh/pUEwCnNBm0gw7fUrMLaBqYZ/tq0Gv/dPw0kZ7sh1JMiN
	wDNuKxcDR54tTn+5+37j/rZCpdvAbdxbrmDxKGouypMxwe9yAJoARNu1zNj04ncwF5PDWv/DPya
	LlBJaQrQL4rhnvdwHFRYMpd8McdjsuyM74mF5WeYC9JP+dB9FKYvyoGJVEpQYSurWq+rqGxTeo6
	JFKzF0LPTPU+Cs4vYtqfraiST7tFn0ti+/xyLbFFB0qTiB2Jpd+pLmAHtlF88Hgkv/vdfXg/qf2
	X6oqMcT8PqEs8BJTbDMH3ap7liacyklPnU9zLeB8yT0KgAutKn1X47KoYn3Dxz4FeFB23ziJFF4
	+52/RHy9cbFRjUGXMW04r3acnp2D3kdXpsRDz3sUAZ+oSqZQPXv1CKbNheljrDD+lI0cJ3r9BeF
	2OK7gpfbXVB5wcY5nz0Z
X-Received: by 2002:a17:90b:57d0:b0:39e:6c69:f479 with SMTP id 98e67ed59e1d1-39e6c69f5acmr5095649a91.56.1789856255528;
        Sat, 19 Sep 2026 15:17:35 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm5925296a91.0.2026.09.19.15.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:34 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: reject RERROR/RLERROR with zero errcode and guard 0-link drop_nlink()
Date: Sat, 19 Sep 2026 22:17:34 +0000
Message-ID: <20260919221734.3708000-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in 9p client and VFS inode handling:

1. In p9_check_errors() (net/9p/client.c), a malicious or buggy 9p
   server returning P9_RERROR or P9_RLERROR with ecode == 0 causes
   p9_check_errors() to return 0 (success) while leaving the unparsed
   response payload as if the expected reply message type succeeded. Map
   ecode == 0 on RERROR / RLERROR to -EPROTO.
2. In v9fs_dec_count() (fs/9p/vfs_inode.c), only call drop_nlink() when
   inode->i_nlink > 0 so unlinking an inode whose server-reported nlink
   was already 0 does not underflow i_nlink and trigger
   WARN_ON(inode->i_nlink == 0).

Fixes: bd238fb431f3 ("9p: Reorganization of 9p file system code")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3829554ca369..12db5ff61554 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -503,7 +503,7 @@ static void v9fs_dec_count(struct inode *inode)
 
 	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
 		return;
-	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
+	if (S_ISDIR(inode->i_mode) ? inode->i_nlink > 2 : inode->i_nlink > 0)
 		drop_nlink(inode);
 }
 
diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52..e63e8c2a853d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -448,6 +448,9 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
 	}
 
+	if (!err)
+		err = -EPROTO;
+
 	return err;
 
 out_err:
