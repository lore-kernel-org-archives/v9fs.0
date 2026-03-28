Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED3391E7C
	for <v9fs@lists.linux.dev>; Sat, 28 Mar 2026 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718652; cv=none; b=hTf3PSJ/EzLVQB8CdBsANMbWYoxvO0EvHYw+GKRm8rddMxdvT/omDurGzaVOkLchwRblFxOlYdR7ufnoTm1qyG7ti6/7kZroiHDqZn28ku+TzkuY5riCN/CsGZLZA1FjKSQL+gvArX4ViPtAo1qcvZcgtKXbnJ+MFYnklTnNuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718652; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NR10s+JUui0kKIa5xh8Weo4GvkpzDpM5gP9J1A9TsZ8vZgRqiKTgigzvojyX3dh2KvXse49YwIF0I+4xadnlhznjVUNq3Tn44H0B57phfh4Ut0Wn6eXFrP1qqN+kp//Xvwew0B23/gVidWQfs95BugM35VhUzLARqdaPF7vTPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ+3DDnQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ+3DDnQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so353021a91.3
        for <v9fs@lists.linux.dev>; Sat, 28 Mar 2026 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718650; x=1775323450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=SZ+3DDnQcUcDuuUe4NuUXLpkbWbKObQe37XvNkD9B+mN4kWuSDgLA0FNCFza8XUoww
         bTIHUHz4wafHBPa4C6QAIifAbDL7LThJsT4/pqPrEc+hd9qGW4GnT5bZnQ6LSxncgC0C
         ZtxgqLwvhSx9b8EkuZlTtltRRHQlOOiboUSoX4X07tycXeUd8lUtoS6ooM9f4SWMvcEF
         3gEG0Bx8oXi/BZgUnn2jipOPxakui7fCzExK5KoBfyr1a8g34A0Sq2vsUjuYxTyIfLpX
         c3TKsF2ASGRAmuKr3wj3YE1S5LSe8tV3ctxe9xsOz+PAvRsBBaVBvDsvP5suhD2gQGPo
         w/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718650; x=1775323450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=WA812U0Y8nPUdbc2/u6AmIRQ1s158Mkq12cj6x0/fzLh6j5NwejJh7tlRtToQbXCSz
         UIfgvE0GYPnHOhiLvZ3GkSB5OP9wm7ox5XrsVpCruXyomOhY56hVAuW+2buTyvexufeh
         CTUIM4vx3e7+uYBjZv1MOsS8mZ3ehnERT20KiD4+cH3+psn95mM+l+pfeT199mypX8Q/
         Pr1fv8fZ8fjxI2rRlQRmLrjiHdOnvKj3Xuz0vyz+ti2grWyRNoeGXGIEo6ZNpkdNvRoL
         lYGC8LVfvYJxJudepZno3Erq9Y8M0qPVGXJkcxfL7kjcsZFdMb2+WrIpZ7+mG9WSlqZP
         n1fA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NTbOaHYFDZj1BhLYL7JVUYKJGsuklHKDUScAjN+dga7Y1C4wXHiAkm7YEBJVrZ3g+m74@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+Q26F5tS0IcfT66lKMxgCbqBSjY0AxZFheamJVRwkckoV+FpZ
	A3on1Wb+DU8qIEitnOtBD02ZzD5IBb46SPDajPZQK5DUDx3E67uYW+Fe
X-Gm-Gg: ATEYQzwOrHtdnsmaLE4ZOeugPFAWdSFBiHN8jIuD8AKdqmrqijKA7Tvoh0MHeQws7Xa
	8wl7CH5UuXL1I+/3MofjGBMN3LumsVUsO1X8AQ9pRwRbiR8uB6XGHw2PDs7cbXlOrNJ+NJ5zguG
	yxiux9kNNZXry98lxEcuFMQll04irNH+yhImym9tS4iUcUyYlMXiXl2KEg+GtMrinICkCRk7HOX
	2yQm9soeB/rgUUHYcZzzOM+c5ZlotFHrRURlydQBOI/hTAIgDZER5COFmILuv2iGzOPIpsvV0UI
	Ee+asxuGr/QoH16G6iZ4oBSMAL4+jr2eqnw2eZ+GiVkfeQMkHLZGrtNbOCE+erCg7knQajAwRXU
	4pXQLr3aJdUIzHfj2SDAOWFsKXkkdv0Xy9eKrsdGJsRBOGdKRqVjaJiWbpDxpRK2YQB9IRSu7+F
	zxS6hZ6R4BZQOH7MlIKSUB+8svkvwuUYhfuMfeb7stDBbyQNOcTvE0u4A=
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35c2ffb6610mr6349220a91.4.1774718649869;
        Sat, 28 Mar 2026 10:24:09 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:24:09 -0700 (PDT)
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
Subject: [PATCH v6 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat, 28 Mar 2026 23:22:23 +0600
Message-ID: <20260328172314.45807-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328172314.45807-1-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
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

