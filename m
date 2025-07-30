Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066B1E5B99
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903522; cv=none; b=McsagBYnF52sTy4vw3gcJ1u2tzW417WgddJsvvi0l3shj9UX8OJ8vucEorr7PG58ZqlEezTL1EmwxdlR6+oDjfnr3IsWpV0mRuhJjG3qHpZC8Hs3Kuq2ykt+SqB7fnWuMKyF8w6o7seo5cpcxe765dNRhdEwNglSD3re5UKOuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903522; c=relaxed/simple;
	bh=rwq0k0RYZQX7GCPfsRHZ5S6owb8YHw7Jqnkl6ApF/Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DOnpbVQ80zPwmE4dXmcGvZyFc9rP/eXVUIFeWBORgz9tiSD7zsEafyTAGFTwrDGezZS99bmSSspn7rQpeIk6xJC+UnjTBgyztz5KzPfQePONhFQS+RQvaY/JgPziJcvjSJq9SGMe2l83XlMLg35vuIt5botIILzxohGQRkG3jbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro5f0I9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro5f0I9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
	b=Ro5f0I9M4pz7V2P9WwlKI0t9/F1IH99LpmpK/fbKKyIeS39tSOL/FSs+eMQVFz8Sw5wzN3
	eSDFKHI/RsIjA8FkU81r8R0459yD/ss1Mab/cacU+EDNYtamBDVDO9yt1fOB6RzKYqbM+h
	2lSZBhdG8/dR99AXccBuI5d5Mky+Ztk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-wosgwoCDN4S28A6T2WBqrw-1; Wed, 30 Jul 2025 15:25:18 -0400
X-MC-Unique: wosgwoCDN4S28A6T2WBqrw-1
X-Mimecast-MFC-AGG-ID: wosgwoCDN4S28A6T2WBqrw_1753903518
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8649be94fa1so15354739f.0
        for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903517; x=1754508317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
        b=L2zWLYzvSl0eT9qXiMYc1A83z8bkxY7bzDmDvDU5ELhmNZGTus+uQkv7Qvzf2q2Xe9
         J5FgJvNZS9tIIaIqzKkPoc+5dHs8Xx4GcRiJSJk2jn8bhkzVkpJt0x+zPrqzF3rzoV2/
         i6H9K8IuDR4R/WKIJPoLsZlpHK+j4yezuNRb8rZbT7XROz1CmbUv8gZsSRo5oByLZDpO
         a8p7ITmfV/sqWqyVLjlqxKTvHrQ4+uxqocUZl3uMSxoIjrhj4lNNqn6x45xZ5VF4PHRS
         9g+idaK60GQ51XXUdbp7DpbRn43K4oSjtiWaPgnX9Wb+l31X4Zqo+dTv7CH28JqRatgs
         yusw==
X-Gm-Message-State: AOJu0Yys76qA2p6aEaC6IFv/l1jtdflkSLjDlEh/QxbGT5rWJOFLynxU
	s2dDikg0aQUh0gInFIO0krCEHsWro3CGDCHTxPSDIWtVfxHkYGooQ/ryk8LKoxtwJbrAxa00d/h
	gJCA1PihIla6cX4T7293r+8kZfvt/OX0fULDSB4dVX5+JgfCLJSMWc80Jr1hRF/28XFV30/rOa8
	RVKRh5yTbJ6Uq2FigHHzhJsvvGfyGYg0gOhtTKm0GMlKQ=
X-Gm-Gg: ASbGncusLTNGlBj3kF8tUMnKsJRD4JdZnPRvjjXd4k7K7VZFkDJjVFMYOkPbfW/0314
	IvCSDw1RnvWpisSC++Dmk1ZlxmaBbqbzTZ6vOtfqpa5wa0ZdRRcWXTGUf3atGCGDJkE5TlXrGNc
	vKWEVpqo5t4V9iORKkjh6bz8kbnR4qh3zUcY0cv/qmfD8RbRtoDaFhBW5dcNhnw8bsrLObtYt4X
	dPoLDSiHEddoP1glgY8X4JNq5pthte8oNFe6HPfL4SrrW2ENQIQW2EBXJjAOmDhprUXoXUPbfm2
	VOuIEL1ncfu8VcfZwu2m9brJUpk69iycV6/iw9QFX1p7
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868055339f.4.1753903517352;
        Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSI5R0bI3u3DKzzNn3KOYViNQi9Qe6fU6AJs0MUhFISdXELzv3d0ZVqXPrG24JPPMCaPtNw==
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868049039f.4.1753903516975;
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Wed, 30 Jul 2025 14:18:52 -0500
Message-ID: <20250730192511.2161333-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XxgN2UAhc5nnbstTNIOi_pnM_2U99uL1LVkTh1Wb5e0_1753903518
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
2.50.0

