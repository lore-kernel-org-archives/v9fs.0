Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15772DAFA5
	for <v9fs@lists.linux.dev>; Sat,  7 Mar 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892541; cv=none; b=A/ZIYDJVZq7zRPJQ0yIRaJAibxE9RbiexDIQsy3bc1794iHfhCtscZGc3M85Vm9JZmo4msnzXrj9mzabLIR+9a3W4qJZeaDm9gJQZP5olGs1ckXMP5FfG/HFBiFcXYJ+Za/OFKCurMozzulx007F9UaDVviEgjmPLwUZpJ6WaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892541; c=relaxed/simple;
	bh=EKC+gjybz5QCo3/A2SoLkAdJ9dHzP8glwvLLU31BmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knVu+x0EPriAdV8mTmAxxW9X9KZ3se8fmac7n+SKRyD0x6XRXepp8qZR6t35FbrGvHlxFcQhXYF/iC5D6LfvYbwxpQBrAbGVKjXFntdZ8DCWvySwtJR6WvTF3K1ghbD0LPLjjIfaZgA9z5C7Wya4j7Mu+aBTNbE4MvFzX2FaxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZaDVC2d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZaDVC2d"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8299f1ca894so992363b3a.2
        for <v9fs@lists.linux.dev>; Sat, 07 Mar 2026 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892538; x=1773497338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=BZaDVC2dLTbbG4ehtIIXwONtuzFTPRTZEAyO91fQxELnyoC5EFhT7Dw+Xw4z+2bqe1
         8kaVacFoW8lQJzTbvnatJtW0JeNxxx28XbNYltMp2P6skWQgo4T2yrzCx8RBjC9P7srM
         bnioiM9OSr2kbTnPn+t/gxjlK9K6zIwTyRRPVRDjPz8MBxsbZfaV38azvtShNUT2IDoR
         QX+ahlBiFfAr9u9SAY69iS5gOkGj7NNv2MoTXscfn+xrx94ZFMQvU+EM350SzgTDnDSZ
         TCVsUn3KHnHkZMBauU7sFfOv1C5KguBqCF6pyoT5M1VdAYGn0IRL+V9KTHotPOJDA9gt
         Pjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892538; x=1773497338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=cqckyoEEYRZR4IK/I3OyzuC3Cs4BpnPJzUI/4rtyNEzQDt6yC2qHbBBjPtBnEDOTDn
         KDhpS2Ch5leqEXby8YOe2UZL90d50hcWmI4T5RN1t6q0WjRgAqxFT2nMHnesgMV9wl60
         dadje6qQxHUV+IeXQ+3RncNtnkPVhg5c8Su4AsBHY44iOGaDvKXwRswUpducf5pMBzdk
         +vSYUfb0HiD7yiLjXvi7sq9aAORg0iT1e7mqdHYtOeNwSNN02gUiG61oVFl5EYdMh0v+
         WcS8GxGX4bEHsF/sVGLqdjz/YIPzRzzU2DrQkhh9RcJLctA67AdomaWj03QwDQgc8BKV
         ciGA==
X-Forwarded-Encrypted: i=1; AJvYcCV9tuBAwlfo53mkHPAKcrFttQou+0SRqEYdaS8M4lK1xtIhUOjwCYPPahj5ajtKJdr6sc7P@lists.linux.dev
X-Gm-Message-State: AOJu0YxefGMVXTqCVj6ha+DdJ6bo1TWRQ5WF917OD5Z3VkhRvhhmut8n
	m3QbKCyFvcwHNc/SCX4bjRavSX7KUkLgzs9rBCyr7OnQ1JbmkP1Djq+V
X-Gm-Gg: ATEYQzw/jy9YbaC12HgsF2ZgtrTpCwBvG3cEr+suni7sXxwnZRrphaydp75/uF7FZOy
	oOUQE+eESMnFRg1I0QKuVhVzKThdQ/wPMhXzkIGVwQKZMihgfYbk0NqEbKtYpqfq4y0g9h+qjoi
	sC6MuGvVPt+svk+rZK6xCg5oxh3eiOmdVZzO9nHX1LrQshwvEpqI4Py0c0Zw8XvFx4qHFohTyKb
	vP5HmrEpWXSfKt4PtmzxKi0U2wtpfln9RvMlWuoYP6jZUT86Dx+S+Ac6gsfnUBAgd6JnbeaOaa+
	H2Xf4spLvjwMK8rDwVJqYKaKcr6wIXYLmA+R04hUXD7AnfM0mM2HiV1GHxm+OB4CfAnbB3EpYh/
	7FesGykY/we6nNG1GP46Lh7MCc/2s6eKT5NUbAYlr0Tq8xW/o98xrDehMa/8hQF33Lg46fAZG/z
	XnREKjFYPXHP1wqT7074fjq1KCpDobC+oCD6Y4yWEW5CmdZydfADVRzTI=
X-Received: by 2002:a05:6a21:700c:b0:366:14ac:e20a with SMTP id adf61e73a8af0-398591082a4mr5640721637.72.1772892538431;
        Sat, 07 Mar 2026 06:08:58 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:58 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v5 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Mar 2026 20:06:46 +0600
Message-ID: <20260307140726.70219-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
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
 arch/mips/include/uapi/asm/fcntl.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..6aa3f49df17e 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	0000010
+#define O_DSYNC		0000020	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000200
+#define O_CREAT		0000400	/* not fcntl */
+#define O_TRUNC		0001000	/* not fcntl */
+#define O_EXCL		0002000	/* not fcntl */
+#define O_NOCTTY	0004000	/* not fcntl */
+#define FASYNC		0010000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	0020000	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	0040000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	0100000	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
-- 
2.53.0

