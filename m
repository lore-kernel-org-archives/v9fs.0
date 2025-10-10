Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFD303A25
	for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132551; cv=none; b=WItmz8f+ET4QSdE3s1rov8Snj/w6oc7VPPDciGF5MXflNshu/CPGQBK0fex5GBhVcPKtyOvQm4I9dk3LvqrQSYe1OsebqR4LhNd1mT6IWuJB+Af0M4uYmHEU6egIltX/d8nQ2CQVwOW17jqwaySIFzV2d3fG8Tph+JvjHfbgjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132551; c=relaxed/simple;
	bh=iq2e/sv+Zi9ciUHjCrlUp5Jvva2s5vbwXLIaUxZ7+K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WDUcXxS14oR+EI2okn8RzLG+6YlkXi9AbkDVPs6AALQ+5CuLHI49WPTv73z7fJVypjjGG+qK5gbE7KHzjbaPrAyx95aZhtdtR5Ko39LlWqGhzEOguyAhYQQFLTgfcIVetY2v9LicjV3wxdWu4HNbmFeZTWEDBoqWMdFI8LMIvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8r/1WYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8r/1WYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
	b=I8r/1WYRF9M3t2HtWc3w4oPVx1UYx/YmhtXyhd35+6INtTkXFj8ofGSLQO2T9USpl5p0vM
	GAd9tuGJSUvBzSTtE8TA6DrLfUy6j5RwmYtqmWGKoWg1KIVN5NsVeMDs7g+KHh2ITDBfs1
	7+CZSU9tvJ2KEi862N4WQTAeHFf8juo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9nSfFwFkNSiYJ-s_krBI3g-1; Fri, 10 Oct 2025 17:42:27 -0400
X-MC-Unique: 9nSfFwFkNSiYJ-s_krBI3g-1
X-Mimecast-MFC-AGG-ID: 9nSfFwFkNSiYJ-s_krBI3g_1760132546
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f86e96381so89902355ab.1
        for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132546; x=1760737346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
        b=xBJNrEZjisU0fFwMTk5ei31My89rztGX+symkws2Y7HMrPzJ26+bo/O1OxhP8F3YsJ
         lYXOcRDNBlGeyOcVmuXV3CcvwL/d5Fz1utJrfe0nc+ewA05DtlAFPIc6rscJ8C/sWlsT
         RP4MGRrsSnJ1BGniRj4xzgNj1Ld4fXGx1wYj5n01v25ubpv+e3VNqkSGiZ2CmKEUb2pl
         d0QeA155GdFfwTeq6YW4cf2gruf9FcGgOo8jPz2oinfAtq22AHs36VI/+DwFyUll+HCK
         ioDf27pVt8+feqIVnGFwLVLknMRSLyYY54YHstWGow344aHqrqJYMAgDyzoDcIb91nRb
         3XCg==
X-Gm-Message-State: AOJu0YwuE09q2U4xqlCoA3DJisbjuByM0ZWvbk6bcGlizQ7ZrPAOnX3p
	pdV09DAP9Upp1M/9DlmMkJAzUIFgInM2KWkLxOkQHkam4EV3B6DtJovobLzZiF4nVd/2pZMKY5b
	oRj3u8UZn2gFtsm3xUPHluwzntTAStFi48zBHL/ebDqcjgjLHbfbauXej6PULD24IR90aC3ygp7
	jBb9N4l+Mx68sx4kEEGvJJ472dZnQ1ejg1M835PQ==
X-Gm-Gg: ASbGnct3Mq7FrZwuDZ5CJuABRL6Q8bXteIndf16UZvK96wiS50o1LZPm4jj8SbJ7X6O
	ALlZ6vCekSvkUOhM5KT5KNBYwKk+K3Til9q2n3/NAxzYIX1EATHzoiamDNBAkD4C85VcJ8Xj8KX
	QsyR6CSAEAW6n5t2CYJ7U54H1vyOQuDpz6t1jUDDWrJQbe54117RsFbsDPnmOWm0yM7EC+hdOU2
	cz7z5H50KAkZJiBiqOhZmHNFfuIRRlwzJEs9vhAl+dBp2XN48YAqg0jUkn+X/Gf1j7YTdxzFaIe
	POqwlgUA5QFSiAX4Ff8TCGRnGge7spArlR7ghiHjsytrdwD2qjEEISk=
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127614465ab.8.1760132546387;
        Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wowT6uDx6IYvItIFqvayc0HgxnQWRhznxzbTVphFWlfOlNrKFLBVqyZESk0W8ghcY0ggsQ==
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127613725ab.8.1760132545634;
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Fri, 10 Oct 2025 16:36:16 -0500
Message-ID: <20251010214222.1347785-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qCUwfBWFP9nBhKTU25N-tVDftY6QC8xnY4XTYfMAbk_1760132546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

296b67059 removed fsparam_u32hex because there were no callers
(yet) and it didn't build due to using the nonexistent symbol
fs_param_is_u32_hex.

fs/9p will need this parser, so add it back with the appropriate
fix (use fs_param_is_u32).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/linux/fs_parser.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5a0e897cae80..5e8a3b546033 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,6 +120,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
+#define fsparam_u32hex(NAME, OPT) \
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
-- 
2.51.0

