Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FD292B57
	for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903520; cv=none; b=Zp3XkxQ+rXxRKbUEz9bhSNSc49OpcB8vCRw2pI4LzNOfd9zjJkIOPVeVGBjuPr+L4BvbdI1qxcHFnuUEIPgrVYGPYT9qKn1+Yzg0A852pmy0JXLOTQDAPoAfO4L4yjrMvlZIAxkhM4nEBnL2akU5IvzDIizjtdvp9AcaIGWkqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903520; c=relaxed/simple;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=L+xTQqINP7mI2AxunovhqMfj68Z0aRdX716yXMQqx41GAoXCxjtkSp8mQL05VMrNeEjUyta35FgrYky6VhFZZeyggHnF2JCsU8CoU4XSCtHOw2Twq0jjCawk0oyhAtpJ0rDi4g4zDEXEmgpTaz7EUR9fuRlGqt8CgzUzl6Y9+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWbzCjj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWbzCjj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	b=hWbzCjj/QwfYJCwCc2dzezy8PmfjNbYSGQOsHKKQ2EtBK0oYPZaRMkbmhi9tOwT6usY68l
	1e/3gZW0UKNhlEjCxMrL5WpGWs/vhStEkaadZSh1Kh2RlchTl2S26YKFWbxvSsLlrDu3zp
	ixOx7OzAGS/xGBAhMtTEa5AMpMRrxww=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-lT9SNGZIPiyVhlOB5vHC_g-1; Wed, 30 Jul 2025 15:25:17 -0400
X-MC-Unique: lT9SNGZIPiyVhlOB5vHC_g-1
X-Mimecast-MFC-AGG-ID: lT9SNGZIPiyVhlOB5vHC_g_1753903516
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8812640a640so14498839f.0
        for <v9fs@lists.linux.dev>; Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903516; x=1754508316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
        b=KUyvldtFQfDjpVbbqcvj5e6isiovebi4DovFq6LOyT7FEQGw44HxR/lW630JA+FAwU
         jYeYhLP8v75xh/XtDbTIYnqv41QHEDyU3mFpLLxUBfbNPcOAhfGeH6GJyLnnzYlczqTA
         7KJ9AHY9xFMKWNEzERy7yIkt37hrmtNSqvtMr+V9bchGw6OymcGojP295J59yrcKEGbD
         IIKlNB+Ra0UzFhj9SfgH0xhxtC0KfPlGwlhyFEvUXRuFaIbX3v7ZXommkMIIo7HJk9hO
         iLXs0BH4lIdQULhDVobUybxzJhNND1ui1JDGFwFVdcDLvpy070sCTHQ2bOTYdVZkihVS
         cVXw==
X-Gm-Message-State: AOJu0Yx5kZ5ekVQXd9mE43O4fQrDjVVUBgdva3XglqwuTuKNqTMxbtO9
	aFETEvL3WXcVlAhn/D3CjUTUyz9/ffg61yOOKceu5l7RZGA2fWE8i5fAqiHIQfBf+S3rkGZxwQj
	eD+vR1O3gsojnTQP8oEW1ihFrgna/Im7EWML4pedVXQJz7B73QduHaeG4GdIqOhaMuxIGOB4QWW
	zrSfe9BH3CLOL4F6QAgF+DNXKnkGrIH9SYtB5JIJSYSh4=
X-Gm-Gg: ASbGnct+d0uilS+mjVV/e06mXgW6fdPjPK0XBVE986Ahf6e3xrB/29NmKjHWuZydg9n
	f5CQpuI6g4Rfoj+tUljVAacXkINGce2CM8J8f17Rd44ClzRoUemCWfOyYq6rsXcPUC6z4PBVWQI
	gTIp2rQ5fiR9cUcEHKw+Ugh08bZPo1NKnZ/jXiZEhH0YLjVZtEYxLJpCKYluyAZ05cG90aZ1Ajm
	+nTpXWqFAV0HvD8fY59iXWYJq/J9cYya/oJmRqKxYt9R0zOoswSJFC8SEVPCcMKSV0R76ujivb8
	C3jrdShN5VAUwSJZ/qjD+uFgh4S6iMVaIy8/7AZ1EkJX
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779531539f.13.1753903516063;
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpCFALf7IPXCoobyto93MhXLiAr8cMVLoJgoZHBK0x34eSoXpHWsaWyDpGqrEeEKztmMvPQ==
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779525339f.13.1753903515535;
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
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
Subject: [PATCH V2 0/4] 9p: convert to the new mount API
Date: Wed, 30 Jul 2025 14:18:51 -0500
Message-ID: <20250730192511.2161333-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zueFoB-hwELV1kfILg80pzqhzG9LCcXTTzalx_JV3R0_1753903516
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is an updated attempt to convert 9p to the new mount API. 9p is
one of the last conversions needed, possibly because it is one of the
trickier ones!

I was able to test this to some degree, but I am not sure how to test
all transports; there may well be bugs here. It would be great to get
some feedback on whether this approach seems reasonable, and of course
any further review or testing would be most welcome.

V2: Address "make W=1" warnings from kernel test robot, comments from
dhowells, and some kernel-doc comments for changed arguments.

Thanks,
-Eric


