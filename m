Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944F5013B3
	for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566858; cv=none; b=TZXp6SqvszkS2PW4LbrUmrJHqlT0F8KKIiDtciIuQSpE0O1jmpx6RCQAgw3F7m/UUMBGZeQZAipszIy6hWCuFXgrbjpr6UC5pkLERxsH5jciheMwdf8yj1cRxlAPM3accoa+eWbmHlYrnq97lOGa3cFjZ63f6ugy83rc8qYLulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566858; c=relaxed/simple;
	bh=gaP3oZ/AnBH8rs+Ktf9u2PAyvt0WSCNjXDKQ1OyNg/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjhKKrSSoIzkRohwBn49VILF6ePte9fA09bpCnHaCVgxp+wNcgLppxKmLIuf5xIVlLBt1jGvNG0ebSBZeCAc2IE1+IMJcxFPhn917Fy5jL30+w5TDr73knPrrPdY2MdBnOvb0d7osCuCK9zGhfr5N735S0KNZUlKmKm77Hyjges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwzEBfAg; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwzEBfAg"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2db33361b2fso38663365ad.1
        for <v9fs@lists.linux.dev>; Wed, 16 Sep 2026 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566851; x=1790171651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qc/rLQY/xgi48oS7JinasFyBURKLxLOAJ3bkaqo/Vho=;
        b=YwzEBfAgBVQJT4bXC5CZnW6sg/4mEne8wqdLK5/9FkzDYzbifGEXYBE8CFm2phgm/E
         TIj4VuAZer5FfnY06v8lpmtnm9Df7TWjX1O2RJhiCfvrM/PM5IG08l8Qu29y0uF4iPmR
         me5CGLPMv0i9pBaJYH/SmMdTaE2YWfU8EWxQUGvVemk2qKWR2prVqpBBZh92D61GFT4p
         ZEO8An9eaxtOXkHrfsl+Wh4z2IKJS6XIa+HqykDTlasHH+t6/dyK9YiRqefIu/r1yBlv
         zkQfcqWVD/d4/1+JDwu8vZlwspZdB9klGAalHfgsYcngc9SnX6gxW3chYdpNAr406ulE
         pNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566851; x=1790171651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc/rLQY/xgi48oS7JinasFyBURKLxLOAJ3bkaqo/Vho=;
        b=1drR8CTBpr9hb6nmkBachTiwHhJgnRVUWMWxWslz08zQ7hEzX1DkavemHIl5IkctEv
         LGSgD+KO/SGzyq9QClUp2KK/NFQBWpDebs13upx1JEupyaZrSxFfPbzT1+FFEewHQDIj
         JZ3khlr5E8aAYBC90wLv3wC1gA6eD+uHVl7LDflj8jxJADaUoaEDgBrKPDdXhNTYqcYA
         2dP7JW+U79J9dA7zvkx2OGyMraFlftiyU374YR6x7ulryhPTvU3C/+/uAavPsbM5Kjvy
         qe8q7YOmiq0PAoPXid/Ow4EqvZSe6YOXP6cunaeAt9V4fLppLvyMhrjNpYN7j3ehdaoM
         KIhg==
X-Forwarded-Encrypted: i=1; AKwUvBzrehHKyRpr7gEfLlHLj4wptIsNEOht9d04x9r8rEKNjCzHTG59Yu1ywr/eygr/Aeo1F6Im@lists.linux.dev
X-Gm-Message-State: AFuF++mNX18xQ/bRMPMhlNvlsoVrqFfwL5UY/G8NUtcFpgKq8lQhL//M
	asWKbLAK5u3Z4QiRiwox+WaD7laQsK88TIFqQFePGmS1PWBPG3eBfejt
X-Gm-Gg: AYBFou3DaiTwEY+Mtyyz7vV6JFCwrvj0YHthJy7JVc5eDdf4DWMiGRSPWMi7JLHDzre
	ZpI7SaYkQdtze2n1UyrBoZkGcYV8hBa8qfQsvgxMYsrVYNKCjfvZTSZuFe8/vCJY7tDzgHeNmKR
	iSmvz++Qd+9D2DIpW/maH44XWz+GjDDAmHqwmiIG+B5ui/xZj9hpF7FhfOtiPYWrFZz8ntHLDzu
	zno2hj0fiFe6WvgHKE7gYfYxc1yRz+0hhJEIj3ZXNCjuM4iNuZywEClpCgFwkFqbpArJwfAIlqh
	ZX31xorAheAuV7rzfxYAKQ+8CXVtZi+diHSbFfXn2vwDikivi21iCO2XH4NbtrwmtPReRLI1jM2
	AyIh5SzO6sAVcgZr0ftuyLKg742P/Of8au3/0vWuIaK6P6Twxf7wms1JxU6iTmzjePMy3R4+MXY
	GDu5uUfWAXtEl2Oa4Q+huUqf1R2UMfj4ow/QwOjgA13j3lkUJ6nFfe4I4dst9NQHrPR3L0P9bUN
	w7IJgwK6/HJCdiwVFKjFq4ij9MwrVTODvqANSA1G5BI2Hw6pmY=
X-Received: by 2002:a17:902:e551:b0:2d6:fee6:65ae with SMTP id d9443c01a7336-2dd8dd0a955mr59563295ad.4.1789566851371;
        Wed, 16 Sep 2026 06:54:11 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:11 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 0/2] 9p: handle long directory entry names in readdir
Date: Wed, 16 Sep 2026 21:54:01 +0800
Message-ID: <20260916135403.15789-1-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dominique,

Thanks for the review, and sorry for the delay. Here is v2 with the
changes you and Jan asked for; details below.

A host directory entry whose name is longer than 255 bytes currently
makes 9p's readdir fail with -EIO and hides every entry after it, which
is how this was noticed on WSL (Plan 9 shares of Windows drives).

Patch 1 drops the copy into the fixed 256-byte p9_dirent::d_name and
uses the string p9pdu_vreadf() already allocated, so the listing no
longer aborts.

Patch 2 then skips entries whose name is longer than NAME_MAX instead
of returning them to userspace, as discussed with Dominique and Jan on
v1: the VFS only enforces PATH_MAX in verify_dirent_name(), and nothing
can operate on such a name afterwards anyway.

Changes since v1:
- Use my real name in From/Signed-off-by (Dominique).
- Split into two patches (Dominique).
- Reworded the subject and commit message of patch 1 to describe the
  existing readdir path and clarify that no allocation is added
  (Dominique).
- New patch 2 skipping entries longer than NAME_MAX (Dominique, Jan).
- Dropped the bouncing sripathik@in.ibm.com address from Cc.

v1: https://lore.kernel.org/all/20260826064819.52523-1-853555@gmail.com/

Haobin Wu (2):
  9p: skip intermediate directory entry name copy in p9dirent_read()
  9p: skip directory entries with names longer than NAME_MAX

 fs/9p/vfs_dir.c         | 17 +++++++++++++----
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 16 insertions(+), 15 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.54.0 (Apple Git-157)

