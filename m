Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9D13A41F
	for <v9fs@lists.linux.dev>; Thu, 24 Jul 2025 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324429; cv=none; b=WMrcu5dg2BMUUumxuvkVYP+474KsA9kisPaoG6CyFB/z+1VkXvZqRv4lsWtMGkWbz1rCkmgrYO44kAG9BaOm0FedbljTFtEDM9u20lJJzrdc94xyGIaGxeuth281CVeYay9BQ4DehEzYQfMh8h/pN51l101S56wkKCX3G7vxZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324429; c=relaxed/simple;
	bh=m7vb4Cb2y7cHbLW2qbMhrq9PjZhWfX2FT7+MmJ+iarE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ihtj/qYQLMCSmcA5bcDXD3cuFBJsmiaGrYcBQ/iEo5wlnTRs0fwIFS/rHeBAu+yMFo8t5LXr16mUimqeLQJC+0F9HS71z1h1y/03+nzoNSvilAVQmK6nbDTXA1e/+/VzRNmusHjtDDXTGogao7gQNyKT1IkG9spxLchZGN6Qb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVN7g1Nu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVN7g1Nu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753324425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpOi2PrZWSRDfI9zt+a35FvQgblhKZQFlpwPqpv1hQo=;
	b=JVN7g1NuFglhjILuv9oqG8NY/DpQ2YdERk12DvOt6wjyf+VipS3JocpjH8NiuGKAejWeVx
	9dgPrr2y8GrvvFriAggdqFcLbss02CFwOWKHdlWFS+SOMCQby59t0bGgtrXDgzROIBnTzX
	Xosn9uRof5bP/3x2J/94T/pG7EOHDPY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-q0OJR3bdNUekUg9AataoiA-1; Wed, 23 Jul 2025 22:33:44 -0400
X-MC-Unique: q0OJR3bdNUekUg9AataoiA-1
X-Mimecast-MFC-AGG-ID: q0OJR3bdNUekUg9AataoiA_1753324423
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso8082745ab.0
        for <v9fs@lists.linux.dev>; Wed, 23 Jul 2025 19:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324422; x=1753929222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpOi2PrZWSRDfI9zt+a35FvQgblhKZQFlpwPqpv1hQo=;
        b=SYLjlofeyzJ84XTz39J7XAp61yikfmQDvl8fhqjuneUveygnbrW2Z5lSoNnElFIPRz
         +TnJeJ8yzt3+bPOaKGglhtSuzRIx0g/Kox1q1CAe/9HbCe5pILNGAlgVASsb5fADX9iy
         Jm6RrDWPmhXtSRZyOSxK5GJ2QVL7+avZYOM9mAn9kOJKsUx768360TEOu1ilfdLuLXkG
         ezybBzZyhzStrVezGAChzO0O+8gc9dfappsTMpsuW+8T9sEF39lfYUAXqCi8d1SvMMI1
         1JfeYHruIvmJ7FmkvMPAsDN+1GZtPyc6NrG7Coow9+/907t8Yi261IYycNV8I0nMyFyY
         2HdA==
X-Gm-Message-State: AOJu0Yzeli1JjJLZxbr56kwDU5cR2/WljG8JPYXVB41Z1DBtMLzKpGYw
	WSbzDC8eV6fRmCj0m647SIOgrMBshBovIHeQNNV2JcPI+LGhrV9KESfjj3hx/mqfr12oBqMfrWY
	Ai7rXVRJeIFTb1Dn4qp0qdeTNqvmeS/iduqmgZIIfP5djPGT8ZQIuFZO5CwPuCeOiUy6ORSq8SJ
	bF/hpa26W4pP6Ig313Q3mauzhIwHw9ILTZ0yHxWA==
X-Gm-Gg: ASbGncuxT+oU5jmcYiMtdl5PZYQt7DaA2ZPhXfHIR/qkqNuFv4tgyiHCnDQL+XVsJ9m
	+qUL00EkarvxVTH2q0eF8xMR2SBinAUya/tpXgR6TmAwVfMbc0CupYquLw1AMjNKmM2mA+63AzS
	LIDNMqghE4TzdFv5k1GghPRYMpJuf7U6jJHlSixkf641usb0NYV1MJLfXa/EkN6MlZy+9FQ9/v1
	Zr750e/KKYl174Cm4QqgN4scgE+FIRXZmn+3OVLpCsxpUk6C1OkRHUKgXqjTxzBh30mTU2tp8mH
	G/eIa7HodSkCktxxVb5N9k4pONs/UxSgIqdzlJZ78ZbvM3OczN95AY423xGGVtdHSuM0jrp9S97
	79MX2GJcWgTM=
X-Received: by 2002:a05:6e02:144b:b0:3df:29c8:49ff with SMTP id e9e14a558f8ab-3e335592633mr90477505ab.22.1753324422677;
        Wed, 23 Jul 2025 19:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCiX1ODnXD2jddzK/b1PnivAxeTrkSYZWQRCx/KYLrieUW5b8hWrJKBLc5XKm62IZ23tjPYQ==
X-Received: by 2002:a05:6e02:144b:b0:3df:29c8:49ff with SMTP id e9e14a558f8ab-3e335592633mr90477025ab.22.1753324422227;
        Wed, 23 Jul 2025 19:33:42 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aebd520esm137002173.65.2025.07.23.19.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:33:41 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [RFC PATCH 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Wed, 23 Jul 2025 21:23:54 -0500
Message-ID: <20250724023325.16178-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250724023325.16178-1-sandeen@redhat.com>
References: <20250724023325.16178-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d2tTiVye9QWusFCUR5629RdmFKkP7n_XvnQ9R3B0fGg_1753324423
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
2.48.0

