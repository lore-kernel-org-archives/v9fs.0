Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC91EB9F2
	for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686030; cv=none; b=UaD0mlAdYPbFBhPg99FWrc5SneftumLnrxioj+IjLT2CYR9Rcv1JV0FISEIT8FNelfJDl3nNtVzc8M0xa7xir50/74bc3Bs8cte2KOaBAYFcVbPMhstdA4sGfpswMH4HVHXn9/BsRca3sPzqTkMOB7hJ7o+KTuWvZAvQdQWHL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686030; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFHoQH5lwZFCzzwu/pcmkhlfx4X7O5sOGnNA9Z/2ekjpwphSNiFxTqu5fLEYkLgDHInWoreL49tKVm3A/7gFe3sYX4Erj/xZ5ZtINe9woWpIMUahJuosL+95KwAHO7ebmqIgaq43wMAmhAf19kOHodDgqfvmc7vOOpLj1QF1xpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agBPZfPF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agBPZfPF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad22a5e245so20704015ad.2
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686029; x=1772290829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=agBPZfPFzSO+5Js7a4/Il8AU46gl6aK4jAY/5ikZjRaekxBYDfyA5LhYeJoPaHASZb
         Ia3I/sreCHXaIV3LtB6djJ3jfG7TqD0w/wlD4VDnqSENnmTdPXiaigPdATrZ0/Oehovc
         t5l+8EU46DcO56m6ImqMM1bFUXlndDGGMzjODXvIM+XoX1bxBNVDZGeAa7nGLVvdClqU
         io+aAdMCYRu40IWWI5n2j3f//jy5UyClK/JkdRClNYjIMq/KoY4GlefLcvofllQdz2jU
         czW9NKhrL46CvsPpzskUDKQ/4dGBpA51sA5oKmEiGnW3iGxQ0ttcG6iZHvJ7jyDAi8h5
         JlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686029; x=1772290829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=WYQNEbJofkuW5ktQbJ/8RYnKY/oEQFBTmmw0RAZbgwL7K+Sf9j9OS5CO90bh5grAbL
         INjSMHMiqxUjqt4WGp4CPb2+9KZGiHkV1depua0TYKFDiVkYERm3cgoDfaRGqZ//EoPi
         tL8vb04IHXi/owarTkfqCsIvCrAKy3KCdlrh+4ncwtYlo68AO6dPKNyBH0/kFEZ6lziO
         6xvb4lavmn+WI7Zi/fnEmHlnY/SRZUHtaNKOsA22y4KH1om+KsRCDROKqD8YaHyjPx+a
         oBcyNGoNqGMQI0mfsYtXUfG6Qd3MTK3x7bJw7cVFWNJcMGFqPd3sex4Wb0XTOMwdehyd
         YAUA==
X-Forwarded-Encrypted: i=1; AJvYcCX89h5zWmiot9gzQMmUvXJDDzBstoxG6yfPP2cnzJckvkuL2UCHjLTE08aLbXMfsPX/kN/R@lists.linux.dev
X-Gm-Message-State: AOJu0YxojFNlJjLEXz7R6fKPDWqcZw1BD0Ia/YdceDP1uSjGlKswfU3c
	d3TU8caCeZM0ojOGTGKSTAh0yPFZgPYnxjKUtZWBQk6DeLjW0bohUba3
X-Gm-Gg: AZuq6aLJ8vxriuc66J2Ls3Re0CoUNXuWP94U8o3q8gHFY+IfMiZBGLLJ1ZZJBr04b9s
	0QzOTDfb+yUfkKpeRuGBZtc9D+8Ys/Ee6t1JGUPuFPAyBIQ4R2wFMVw6qUME9ZoB9aK8ru3Fnad
	x13xXIF6zav94d/9luQig+p2xUW0il4e82zr6oRNIHDU5ZdogQsw9fkvnFWAYePBjQRPpu8LH1j
	kUtM/TuIGxbapH3/Op8ztvNyIH1eAroStCIq1abKGjH1TLmi1Yn/TRb2cysetjFG0zPgmUKk7CE
	Nn+CMoBF+dBhk6JULsVjvjZacEw/m6ttfgXaRzoFzPdq2VmaNMa9xC9InL/zVyKaNxoH/y5GuHj
	r9W/W3U/9TV72OKC/te4CzI0zak2SyE/M3KMpfINfA3Hs9S9RfKHfk03nipv1bSss4QdDgV0X4T
	ZPt0GN1PpFs8sVYoPSGxb4w78NkIbal9xAdVGLij64dO1pGmkyFF1TNsc=
X-Received: by 2002:a17:903:3510:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2ad743fe17amr28627765ad.5.1771686027291;
        Sat, 21 Feb 2026 07:00:27 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:27 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 21 Feb 2026 20:45:45 +0600
Message-ID: <20260221145915.81749-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0

