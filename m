Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325419067C
	for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686014; cv=none; b=HE45r9EJPYYAURkKceGuxJQU+mcq+0O5C3gauYVjIjoQIVCgs80IykGbsrttqRKWhv6or8RGOGoK0m4aBAuVSiGOU2eRiAb4cx1zGb2q3z4SeAfaya9q8BzZVEVF5dksjfrVISuJcOyJ5XdF7qz5/newhrp2Lsmz3GrfqAYJ7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686014; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8rsZ2FEE3JpCgHgraOUrzbdhmpS5NZzxq1L44SsM/zSz54SVHBxynOB0dNmPnKH5wNH35+Pl3mBLHR5/DLulOHnSZx19nIGAVs3X5K9vJNMpDZGMmBFPNulF0tNqL4UkE0vG68ORsWuhAMmTpDzqQROs8Jg61Q2NZ6i5LaahAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNCCeRMu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNCCeRMu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso19376915ad.0
        for <v9fs@lists.linux.dev>; Sat, 21 Feb 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686013; x=1772290813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=XNCCeRMuyqePWSwM6QDXEhpQgu6PLC7k1WpzzCCFfo4nnTEKjmajTDp0jvX4raQ+GR
         HMt5haSQj6FmgCoj/Znelt5/t3ycUDljLdM/cH3nE7sUFkt+otvzbkWXxD9jIK7vjGR/
         Daw8yP0pxlZBgGB9fTkLHrcyfVOFeMxJ9WNfY786wOl5yQn5KEZzuRM/FuAfN2lOOz1+
         NvxALA4YIMlmvs3wHACHS3yFXcjD7aE3hpcf7rAckRFVdfPNRgKU0pJM7FvW0ohxrXht
         uULlzBVxpMUm9WBIEYKIv5U1SM+J+hxC0tPwuaGWA1uTGP9PQHbu/4OWXWANeVrFLf36
         DWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686013; x=1772290813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=BsE7NyrEN0EUp2plY1dW4P/t7UjiVB581ictnCD+bdy3/dAdQ7ecmBcDwlLGAVjdmQ
         rBSBj7yUULzU/52r6ApxtRBJ+ty+PRX03TFcTOVOzctQKY+2R8hHV5fK17mrmPFi7Og5
         QtrpNHBfC7lCT6WRji/uzc+YKTE5mLsuug34e9XMebqJm86Y9s/OHx0tY1qs7Ku2VVph
         8lOZravdrRJ00H6TWyD/EWZLm07DU+K4MmJ/Ylx0xNpJkft0Ls4L4nTw3UdUM4x/OUsl
         0mRJwobbNB0F4lXJi4dPTFPfaPsioEuJN38YG2r7C+NENEHWImDbUqEw4WplLe/w4ORg
         yIww==
X-Forwarded-Encrypted: i=1; AJvYcCXEf7C09Ol3gASOfs5DBeTNRsPDlEWaPmFxNV+HaUt5dymf0QCKRoY+9SIBVkfTpkCfcJCW@lists.linux.dev
X-Gm-Message-State: AOJu0YzP9qMd7DYAk+39MwVXmwTbFxQbp+BAN9tVVdUAYn9H4L900lIi
	OwnuqrrLakVOE52bHdsWB22phjRsr6PCdolPmvToYetvUUgHvPICnVXp
X-Gm-Gg: AZuq6aLslwoqWgafhvxqFVf9/hM+SQ+30gprv7D9MD1TdNWCRVoVkUyWIv458uIsaPA
	hD7DnnS395ykFrAUn6z4l0l6Rvxx7QRxJAflvevaQ3OI9FFX5kasy5UMD9kfCa+GHdkG3Y0D5rp
	tLYFXqGjsWj2jDaPQK0DW0YOFawtFLO9GfKQZUGD7vLkw2xZ+BKkeOQfJ+ysVhQtuMB2q7qor7c
	Y1Xu+oLvwv8Be0AqD7ahguPKmFp+w/bN374GTzgGuSzHk77BaejH3m9wu11rY/eA1zApibYhoo0
	anMQu2qYLdhKm7CUPaCJrvN0o4tiu/ViMX3gGxyb1Ytbg1dazezY9MZcgqiKBIorrGxN23w+p1S
	sssg8atWWEW5xPR9d/9VxKx7QjSPJ1txlyuxSyu689g29ZAwZf4C+T4ItlNlPWQhdxqXevPhie5
	78S3gm6E2c1h99VJVeUXJJBXEYNi4ZLbWCH+bAiLNal/IKm/6+hvVQUPY=
X-Received: by 2002:a17:902:cf07:b0:2a9:322e:2473 with SMTP id d9443c01a7336-2ad7457e58dmr34715235ad.48.1771686012796;
        Sat, 21 Feb 2026 07:00:12 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:11 -0800 (PST)
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
Subject: [PATCH v4 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat, 21 Feb 2026 20:45:44 +0600
Message-ID: <20260221145915.81749-3-dorjoychy111@gmail.com>
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

