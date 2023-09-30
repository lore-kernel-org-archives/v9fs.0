Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532417C8
	for <v9fs@lists.linux.dev>; Sat, 30 Sep 2023 05:01:05 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c60f1a2652so10351715ad.0
        for <v9fs@lists.linux.dev>; Fri, 29 Sep 2023 22:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050064; x=1696654864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcuxStbjNijxSJq8zEaQg95VP+4PBlgl17JsgSzTRFE=;
        b=lBaTpCSt0Go2nSOXdjWfyjsP1DvVBfjxLzqENFL3F0Dbeb06zj6UbU00t3SqSWV0WG
         5Q8MmC3cnWY/P91CKeC+MYgMrzA9znVyqdw+XJJF4ARs7A/7E26sSmfTJOo2oTbaxRMQ
         jmiNi9yCKMZkbwkzWnuRyAvqyo6bD5zxEaCarbZ32CpCfu87pt0D21ZyfPHHVebhmB8H
         ApxlH8KQC5rFCPhXSBWsj4IY7EjFCrrwAf11KvtvV+KA9ylZb3T3DkrEn1+/6lV1YgZi
         FaA8zKVx0tBhQYLvgF3ZRZU/WZnwtm/fDHubuvzNvZSXo8Ow6UOQshh6M9Cw1/0UvvT6
         OtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050064; x=1696654864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcuxStbjNijxSJq8zEaQg95VP+4PBlgl17JsgSzTRFE=;
        b=lPShhXgkW2pAU57Z8Cs26vFAqMCM1lvUZd/Hb0LjSdWJjp6nPc0xl+D73pwTWcIakK
         iaNwiq1vm+5ugGf4GTI5YM9ysZ2kTLkQPb2pRNQlloKczM7yZX3GX46O472j+xmFHfKC
         UXIHsNC4worpXAGbkX8M4r+d5BSXYGh1MeTXpICYPN9cxJV0M9dDKOg1CbCaeHhwPFL1
         pQgnRwENa0jjnxOBQDUzcSxiNspGLJTjrJKVW4PvdzbUzX4BDZOoJQtm/g4rR//DivwE
         Kxm9BCkvnWQg//AHuTviBC68LX9SUYFIzJOESTlyCpTsCnL8YDij/V/mV5R9ys6+A4zh
         KK1g==
X-Gm-Message-State: AOJu0YxIk7f96y05s5nQGDoJRM9c6UCx2ZReMQ+qqbfdOdkNF0Pmkzz1
	NK7Sr2RMwWygz2Cs8VDgip4=
X-Google-Smtp-Source: AGHT+IHR/Z9vw2im73BCKMlfvXTH3LjrdswnqX7m/Xw1oMRvr5GOQ5Mq0e1yLd4AUBV/4jWIj0TlGA==
X-Received: by 2002:a17:903:184:b0:1bc:5e36:9ab4 with SMTP id z4-20020a170903018400b001bc5e369ab4mr9385815plg.21.1696050064402;
        Fri, 29 Sep 2023 22:01:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:04 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Date: Sat, 30 Sep 2023 02:00:07 -0300
Message-Id: <20230930050033.41174-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.

Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/9p/xattr.c | 8 ++++----
 fs/9p/xattr.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..053d1cef6e13 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -162,27 +162,27 @@ static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
 	return v9fs_xattr_set(dentry, full_name, value, size, flags);
 }
 
-static struct xattr_handler v9fs_xattr_user_handler = {
+static const struct xattr_handler v9fs_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 
-static struct xattr_handler v9fs_xattr_trusted_handler = {
+static const struct xattr_handler v9fs_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 
 #ifdef CONFIG_9P_FS_SECURITY
-static struct xattr_handler v9fs_xattr_security_handler = {
+static const struct xattr_handler v9fs_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.get	= v9fs_xattr_handler_get,
 	.set	= v9fs_xattr_handler_set,
 };
 #endif
 
-const struct xattr_handler *v9fs_xattr_handlers[] = {
+const struct xattr_handler * const v9fs_xattr_handlers[] = {
 	&v9fs_xattr_user_handler,
 	&v9fs_xattr_trusted_handler,
 #ifdef CONFIG_9P_FS_SECURITY
diff --git a/fs/9p/xattr.h b/fs/9p/xattr.h
index b5636e544c8a..3ad5a802352a 100644
--- a/fs/9p/xattr.h
+++ b/fs/9p/xattr.h
@@ -10,7 +10,7 @@
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
-extern const struct xattr_handler *v9fs_xattr_handlers[];
+extern const struct xattr_handler * const v9fs_xattr_handlers[];
 
 ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 			   void *buffer, size_t buffer_size);
-- 
2.34.1

