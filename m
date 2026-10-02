Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8077341660
	for <v9fs@lists.linux.dev>; Fri,  2 Oct 2026 03:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790913529; cv=none; b=Td0SHRmpielMF9m1/YZrl7KHNV3Hh/sPpfFvLj5cJz/HAcIo3E5QzyDkJ5TelA8WDLMhT8AlLLVac0xp/+Vf4nwMbHuzq+0mhTha2I2Y/n6A+FHEAkp6dOrWMR1jLFwwvfhPo3qOshJCNkVHPTcF8+z9SNV635ylagyrF+j4p+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790913529; c=relaxed/simple;
	bh=wMnyD5HW/0+oeOMABNSibQxEPNUGvv38NIwnLfvPREU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/AvR1yN8OgT6fIeSQKNqz/BkaopYY0fN6l2OMvpv5f9hF8VRuhCiWEYafK9g80on6sNbHyHsJA2/pT4SCv+HjqVpFcYzRXUh32FpaH+/QuDPVIIXTPV7VwMVpTDXzTv/qHuw/w6Y7lZWgOWESViAyft7DqDejMCMXmxCmCctb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nESgUWKD; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nESgUWKD"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe625404so382775f8f.1
        for <v9fs@lists.linux.dev>; Thu, 01 Oct 2026 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790913526; x=1791518326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpDDKCvPSY4yYLTf3+YiBg6CMQROJc3t3myCmtwmjZQ=;
        b=nESgUWKDafJDIJvu/AgqCQOSaF06teGWYbCEHyXXT7TDPj+QKz5Rm4QA+gBfimNEbw
         bI1Zkgf7ybMBV0MxJOwfAaNzjsPqn5F8zWEDRDomlDMEkpMXxLHov7DejdrpGVyTqshK
         yHnghp/5TmsEX4ZdhHan1gSdJh6NPuvVB7PVy/HaSjhQvlQ2cfMVW4IDc8vlP0W/L3xY
         OvkOqIPMW5emnKNu1dOkLSqUVr8iiA2MVGZJu3/dBhFi7+trFHld536tHE4SD9nhtL/P
         TJOyHcfBSpHB/hLRHFtlFYTKWNU/xyzjLMpAmyqA4X0QetHuGaFtzwx1UvXSA1rcuCAP
         X1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790913526; x=1791518326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpDDKCvPSY4yYLTf3+YiBg6CMQROJc3t3myCmtwmjZQ=;
        b=L+kQglPpVE6/X2PHiZvXa3QBEqdqgo94qV7Gccve+eBnhkWABTbJ3mrh1lCZFSv5qj
         k3qi11dasyfUeJh5o8OLoq2wW1OHUiRFewTY42l2aqwrjtbjCvyuTOyt5XEYPnJBkfZb
         Pp7a/GtcwfmZg/drycPZtHpVslO098HGg0sy7UqVnaFvNwoXcZ2cq4jgS17MMKpZgGS3
         wqNMwxJ76XDGsl3MuhwfZCPpXMFE3TRO8IPmskznyP3xPWK9rJZAOlMMARk2rvXwl7vA
         hvCeZXEZLT06gGhjT0xANIgRgKmkEzWC49B2m8ViU/UkMZlSWhARjiz3E1FlCFWmFs5E
         SC9A==
X-Forwarded-Encrypted: i=1; AKwUvByJjhfDH2KI4T+0xLIVMENpcthFweE8BzGQKGSBXOSlWc041kxg3eZquRuasLk4xI0Wn/0B@lists.linux.dev
X-Gm-Message-State: AFq9FYIgcu4U80gTjVtfrT6qEcRPPxUIROyTd6dmR8KtKwtVHwMHs/j0
	vWUTqDGTXmJy4r2XIRn27f7AEQddtkcGf/uk3aFV7tgWW22kO3sIS3G2
X-Gm-Gg: AYBFou2gfJk3z30rqkNU1hapM+2WVQTe176h9Q0C4wXRQM+Cjw9WF6GO6+qUatRY6ua
	zY1y/uEP/445wlN5By0jK9dQZdrP7V0F8dRmoWKYZkhnmCLURFEo9StCU5wDa+ZI5tYn1B/7+5M
	Wu8rYn6CviMUOC0l9Nd9Xax6ijIQTsPMOALcZ6pgTM/GyolShcN27XafsdDB6P1P8qAjh9dksX2
	DA0r5n+f5/mLuc0DOTbW5MhoyxbSb4QkPCPYSVce/FZBIdZsLkVs1lWip7j10i9ixxR7uQ+Xlfh
	7rSSwsWRhjev/qWp1OhpXeInS1eGiHG91Nm3P/NM6vzCEYPNdH33RLaRnKbo3TIIXpNcUwOraj7
	p6u3Fe3kJdr3rbrwwKLdTificRm5+DtJ74L30M/vvoZUMdxfC9uoINFx1xMgW+GZ97abvuLTyGq
	O7l0xGm7vTQtRClgH0zKVqgemYEFYg/CMPggcvWvVKbY5Wcw0o4mlarp7DK3lp97zcOt23vOTKj
	40SRFkyz7P887wFAoOHNQ==
X-Received: by 2002:a05:6000:618:b0:48a:f41d:846 with SMTP id ffacd0b85a97d-48b12719b80mr2478947f8f.3.1790913525869;
        Thu, 01 Oct 2026 20:58:45 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253e5bsm1998601f8f.1.2026.10.01.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 20:58:45 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: ericvh@gmail.com,
	aneesh.kumar@linux.vnet.ibm.com,
	jvrao@linux.vnet.ibm.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	skhan@linuxfoundation.org,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH] 9p: fix kernel-doc warning for enum p9_session_flags
Date: Fri,  2 Oct 2026 04:58:37 +0100
Message-ID: <20261002035837.39703-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc cannot parse enum p9_session_flags, since its documentation
comment is followed by #define lines instead of the enum declaration:

  fs/9p/v9fs.h:31 : error: Cannot parse enum!

Move the three #define lines below the enum whose values they are
derived from, and give V9FS_ACCESS_ANY and V9FS_ACCESS_MASK their own
kernel-doc comments with the descriptions they had in the enum comment.

Also document the four enum members that had no description, using the
corresponding mount option wording from
Documentation/filesystems/9p.rst.

Fixes: 76381a42e4a5 ("fs/9p: Add access = client option to opt in acl evaluation.")
Assisted-by: LLM
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 fs/9p/v9fs.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index a462bcbfc7da..2f18e75f0ed0 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -21,20 +21,16 @@
  * @V9FS_ACCESS_SINGLE: only the mounting user can access the hierarchy
  * @V9FS_ACCESS_USER: a new attach will be issued for every user (default)
  * @V9FS_ACCESS_CLIENT: Just like user, but access check is performed on client.
- * @V9FS_ACCESS_ANY: use a single attach for all users
- * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
  * @V9FS_POSIX_ACL: POSIX ACLs are enforced
+ * @V9FS_NO_XATTR: do not offer xattr functions on this mount
+ * @V9FS_IGNORE_QV: ignore qid.version==0 as a marker to ignore cache
+ * @V9FS_DIRECT_IO: bypass page cache on all read/write operations
+ * @V9FS_SYNC: flush writes synchronously to the server
  * @V9FS_NDENTRY_TIMEOUT_SET: Has negative dentry timeout retention time been
  *                            overridden by negtimeout mount option
  *
  * Session flags reflect options selected by users at mount time
  */
-#define	V9FS_ACCESS_ANY (V9FS_ACCESS_SINGLE | \
-			 V9FS_ACCESS_USER |   \
-			 V9FS_ACCESS_CLIENT)
-#define V9FS_ACCESS_MASK V9FS_ACCESS_ANY
-#define V9FS_ACL_MASK V9FS_POSIX_ACL
-
 enum p9_session_flags {
 	V9FS_PROTO_2000U         = 0x01,
 	V9FS_PROTO_2000L         = 0x02,
@@ -49,6 +45,20 @@ enum p9_session_flags {
 	V9FS_NDENTRY_TIMEOUT_SET = 0x400,
 };
 
+/**
+ * V9FS_ACCESS_ANY - use a single attach for all users
+ */
+#define	V9FS_ACCESS_ANY (V9FS_ACCESS_SINGLE | \
+			 V9FS_ACCESS_USER |   \
+			 V9FS_ACCESS_CLIENT)
+
+/**
+ * V9FS_ACCESS_MASK - bit mask of different ACCESS options
+ */
+#define V9FS_ACCESS_MASK V9FS_ACCESS_ANY
+
+#define V9FS_ACL_MASK V9FS_POSIX_ACL
+
 /**
  * enum p9_cache_shortcuts - human readable cache preferences
  * @CACHE_SC_NONE: disable all caches
-- 
2.43.0

