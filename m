Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7D18C03F
	for <v9fs@lists.linux.dev>; Wed,  6 Nov 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906533; cv=none; b=jVdZBIcIeU+9t8dm0TTSv0xcS0sNL4RtW5jXmo03skatLtyHAobo5o7JMavnOI3JiynhJXEfoxCZMGmlDz2wg8ddj2jvKrZrsbQW1LpI/pDgEqdcSpmZBt8TWSmGP1O/VbVnBedrjq2BSFd+UvjeJOPeJekPnQYYCz8Cn5krlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906533; c=relaxed/simple;
	bh=TegPHsJb8UtZrNvXmEc16dnLIaw0GbTMBePpl8yK+PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UyPTtiWNOXmoox3mYVVKsT1as+75gFSBiApwqScnBBXU/UscmZcYkqbyzYxB+81wY1PKqrrgNzwnNxWqypKu56uoJZ5WkyEjW2aluRLDzVf4nNtBQR7uS0YSVbaox6C3A/i8dd0dqkq4Fu0+pUw9FEDsyf34A8pZMX3PF3CvgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/FueGp3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/FueGp3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so6080614f8f.3
        for <v9fs@lists.linux.dev>; Wed, 06 Nov 2024 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906530; x=1731511330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojWgkBkJEMmCI62V4jCnf16CEFOk3HJMOucjebvfEik=;
        b=l/FueGp3yeJayIaxJ70gzTGU4ZCfNnpuK0PHx8khK1Eunw3tsO9B3GEqGkMi5k2j5j
         LIwgnYdjhGtmJRsc03aORK5DppBNduLcdIwjLL0XVL3h/TEAI4FAwGshPHVL943LR2DE
         zLA+4XEZjyqKgFQVO5Vzwigbmq/t58OF/JQMdltSCa7diaaiGKQI3Mq7h2TPRQNwyES0
         tdEAzPVmes1NvE4mYCdbJEqtSXovNXsVZXIiQCDHC2Wuc3nLKZ8XNYxT3SDjHtzwWI80
         wgKxOr8vziVuoPPcm9DdqbOFX/30AQNejc0EcbFCatcjQnFeldxrmn2J30jQ8lYNVVUL
         3QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906530; x=1731511330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojWgkBkJEMmCI62V4jCnf16CEFOk3HJMOucjebvfEik=;
        b=Doi02xxepwGYC8kb/vmYR0cZm+t4kBJTpc6buAx6IWLJNvbQfAw8QersnVXeF7TN7y
         PbPJYerwWDpVwOeOc8UpYBssdk8BDRyxD6f8MZvp66OxjOio9fN4hsxe0OPuAzjRyuoG
         AHbG2EzXBQekz91B8U45BWikqGxDDAvOsF5f+NEJ0gv0OidELUNqW7M+LxXPBYTDQiBP
         Bh4FrdZlQKt5G1F+Tr2fge3L2F4EdOCso28ytrX23ldSk2bkop0t6zv3rAoMpglttMFd
         xXoaKGGQXvE5mhKwyefagAbUym1gCHbdk5rNcR+RMVatT2MGJ2X0PouEFtbIdXLf1GiE
         M/kw==
X-Forwarded-Encrypted: i=1; AJvYcCWAikN4CWj6EQMnsxDYmESBFysh7hJT2MLElWeVCXgivFYeWSh7UQHeT7RBwedhkEofy26p@lists.linux.dev
X-Gm-Message-State: AOJu0YwO3DqJdvXdIXkNlzofb2kOocYAyQjzXN6/h6ZAtGwhu22WQWhe
	n9odA730qHWBpdtIgGamglUR3H0Z9XAGuVYt2V+CrXvHuK7GkoiZ
X-Google-Smtp-Source: AGHT+IH79nN8Lx5TC+3a80nhd8cyj+o9blu3nB5kz6aXwplTbMCxWrEQiYYSM8yIiy9mD69AcgA8pg==
X-Received: by 2002:a5d:5f8e:0:b0:37d:3705:84e7 with SMTP id ffacd0b85a97d-381c7a5d0d4mr21256608f8f.17.1730906530252;
        Wed, 06 Nov 2024 07:22:10 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e528sm19654399f8f.78.2024.11.06.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:22:09 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/9p: remove redundant variable ret
Date: Wed,  6 Nov 2024 15:22:09 +0000
Message-Id: <20241106152209.1626630-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The assignments and return checks on ret are redundant. Clean up
the code by just returning the return value from the call to
v9fs_init_inode_cache.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/9p/v9fs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 281a1ed03a04..ee0a374e0d9d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
 
 static int v9fs_cache_register(void)
 {
-	int ret;
-
-	ret = v9fs_init_inode_cache();
-	if (ret < 0)
-		return ret;
-	return ret;
+	return v9fs_init_inode_cache();
 }
 
 static void v9fs_cache_unregister(void)
-- 
2.39.5

