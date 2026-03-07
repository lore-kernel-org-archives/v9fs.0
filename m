Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF8248873
	for <v9fs@lists.linux.dev>; Sat,  7 Mar 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892507; cv=none; b=bNmcu8vCyfE6WZVlKSPxcui78YVwspH6Yub6O8nxcYSn2gIgkvTk0rCFVaML1/gPEWt60bdFQ7UvjA7I6W5Ok12kXSYN49TLjG7MiZoan/xueqR7GXTibGYCVj16aEL4PFscnD8JaEajgF6Z+cvVLd1tHkmmJ7mRhjC8bphGSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892507; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auNqHAs5jAq8E0Y4gCPGrVi2xW9IxUNn9AHUjeb/FMVzamErd0DomL9DJQr7GIgrYlaFdiF+6h9NaQhX3jr71Nvm97+lLkdjgN1q9ug+m8sMSaZ+oHGEKRAXP08cN10IDLtBJs7eappDXy3iI4TZ5Abd6J2eCSfqDwLTYUbpFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOZA0C4F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOZA0C4F"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829afe24fb5so607146b3a.0
        for <v9fs@lists.linux.dev>; Sat, 07 Mar 2026 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892505; x=1773497305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=AOZA0C4F02yX5PIYxowjwqRfbsjlU4Fhv0OCCLaKbzMWjZG5AJv0RRW73j0++zSpBz
         rn4k31PI2hwZl37YHBeOBx4h59/5t5v+CZlWrdQzemF5zucUezECeo7QzvMdXSbxYV1y
         Dh283kN0wYkZq1BHX7x7hZS8hhPmWuIv9kIR7wcyWRgJ6dwtVSo5q5Y18FntiL5+qGDz
         etmBkCD1Nr2mfO9jqOVH/OWJZ5zGUqerSeSr8gw7J7yOqgA4PIhBNtyfIiTV57vYYs5y
         OCApbHrf8ZgIMC/FVXC0oYYw3CzxhWKQlhMdnM0qD2SiNa7ze4ntLjOWkCIDeWOk8gRA
         xl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892505; x=1773497305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=nHaJV3a8xPFjitZOarBhagivLCb61/LUDwlzw8F/9ADSIwjj5acuI3cmQjgnD3/Wux
         GLeqoq29B3v6QvQ+/WwskXFCNXwHKdpZXP+zZ8gehpib8GUNz+tjjlcJAQz0udHF6hYB
         8cpDWTguchUHKqjs5HhzANjRYnuQDR5DRaCZmm5epsRygj5CukUXiyCOe/0mNB9AEbJX
         ZzdfHv4Hg6BrYJ+ju/Fhd+jO94KMUAS5QK+mbmRRtl9A+2jP0S+/qVSwAENSvaGfj5NI
         /Ri0YF7P7i3XEG/zEJYAAPz9FZlDYg9rfOLFvuHyrI4w5nvxzRS9uHtDtNJeP6EAguSD
         R4NA==
X-Forwarded-Encrypted: i=1; AJvYcCWjh9JG4pSPnzEbhPwsdV0dUwAXLH6jRA3L2IaPEvZDSGWO93mC5HjAaAct8uvNzDtXP+Dc@lists.linux.dev
X-Gm-Message-State: AOJu0YyN8yseWOpjsMFi20L/re5RtqpY0VDyN4Vil/MFZ2D0VH8/Gkg/
	2YovnQA1ZUkIGawK3cfHFq3PP5ge0ijdkr5m77VZBb204iIiAMI387/Z
X-Gm-Gg: ATEYQzzTtthsonjPVp1i+JOrml/3HI2UX/H4xVw86DPf6fOHNcFom4f8CX5yhk1ioU8
	XPzoE1J+HMhv7l45+kXstNtJN8Db4coirv0XhgsX924Jx7/n+iZfYptrZtMBittbXtEZxPmnJHG
	WV4qkTAXs1Ehtxmt0iJeJL+G4etWLdl5oRHhendTBnyyT2mXzyIKuKaODwqtubHSSloNQLoA8zR
	tOmhx6H9fO+FtFILHSCpzm5scwXWmCfyawo41S0zNEFHtCGKjXA0te41WNsZxljri+bghgRiUJl
	85DbNpw6JHGP6DoKCv3tV1aPWgCdgHbH1zlIOl9zybe04CFcxrmkK/pUxtLnKtpzbF22h3XlNbn
	qpuUQmRZdOpNQFq1fWIOuO7xb1hCXoRu6nqEQo6U/PhF2Ee3HIU+//H/Pkw/0gIt6equDR3dUGK
	BjaYu4oopmM37hJLHSKlLbZXF24lLU2KJUWsrxxYoJZXaUlxY+HbpiShc=
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4767475b3a.46.1772892505338;
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
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
Subject: [PATCH v5 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat,  7 Mar 2026 20:06:44 +0600
Message-ID: <20260307140726.70219-3-dorjoychy111@gmail.com>
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

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..e8847f7d416c 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR 040000000
+#endif
+
+#ifndef EFTYPE
+#define EFTYPE 134
+#endif
+
+void test_openat2_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = OPENAT2_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == -ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -EFTYPE) {
+		ksft_test_result_fail("openat2 should return EFTYPE\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0

