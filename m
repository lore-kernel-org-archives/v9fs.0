Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FC18EB0
	for <v9fs@lists.linux.dev>; Thu, 24 Jul 2025 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324427; cv=none; b=Cz683RjIk66qv0aQeTo7gnMcZgQrALGPfcW4YcvYn3kVghpKf4tu7OuLxaFO15CKn02yLbLJYM642lrdYq76830euUMzlcgaLNvxOfkSMyTq4B3Cj4L0N+1ewOTfAa/5SJ+uwE6oiKGdAtR8CXPKwWS4HJKHlfX1qhMAUinnhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324427; c=relaxed/simple;
	bh=2J+2/S2HvuthVWcnpxYxuZVTl0Tdh86F4tdG3gSiOUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=sCZSx3TZsfoFEP0l6ov5VfcFGgdvCJ5EYbCXC/m+8ItiduJz2nItYLXxj0kYLx5KpUP9bmfOhq/MQf7e8RHcxEWF5f6pMobQitmSzQVKZtJusRsLB7dDPm4ro9DvhkgV1Mqu5703qj2fEbKeoYEYQ6UCFj6Vtohcx8w918vYCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj6LFpLq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj6LFpLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753324424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2J+2/S2HvuthVWcnpxYxuZVTl0Tdh86F4tdG3gSiOUc=;
	b=Bj6LFpLqxW8c0ZYmjuhrFNgZmCyPRNb8lQytY3ibR8Y1mS75/oIVgNEynXrkPmp0iDdTIk
	egyT1dp5VNssd+p1ZxNsTcyXl+zJBURTNP+erzI6+7uXmlcDSjTwNmZctWpxD15K2x0aRv
	webiqU4UVLjCrYTW5A8KTeRH3JP7Zjw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-vBhcd4KgMCqfRpXWUtclrA-1; Wed, 23 Jul 2025 22:33:43 -0400
X-MC-Unique: vBhcd4KgMCqfRpXWUtclrA-1
X-Mimecast-MFC-AGG-ID: vBhcd4KgMCqfRpXWUtclrA_1753324422
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e29aabc9cbso5438125ab.0
        for <v9fs@lists.linux.dev>; Wed, 23 Jul 2025 19:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324422; x=1753929222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J+2/S2HvuthVWcnpxYxuZVTl0Tdh86F4tdG3gSiOUc=;
        b=lc9dC4Y0eQYt7U6tA9i9RwuRO2iwuNYEQPTaJ+EXE2M0unDkqm4bWsJ/eb1wO2M19/
         O+avX9lJ6xEB2xp9JcokguZE5saJdXqMWSzjFT6n9VjFaGTLONk/n/uetwY2Hm3ZGn9z
         aOnRU7VUGvhkPDE+dkzuV113UHlGewsJdALfQK2vR7wIAtBFlss7E7L1wchbsGyhVXJx
         QQIAhljIgmc3K/nRXLcnnHBWKdEIOk4l6ZnnvvxIStdpOougKKYX3Js94H6H9gH01Szp
         8qN3JAg7uZJZOg80XuJMQ6xX+31Li9CvAlh43iTamJJJTC5CUMeq7ggJfNsOuRgd1k7o
         5HTw==
X-Gm-Message-State: AOJu0YwjJOFCoUEWsq54XADM+30kt1JDTC+FMp/otHq1/Vp7yLwpdKbb
	0U3jR7JRRU/JyKtk0O6uaxeHRWAgwcM5c/PL4iyj6ZrI25xJqUd9VJJ1WVUH9drLfsQKbAwU0JT
	8/H2pMqwJAJqnUJJ3iRgT34kjFKgfsAPD9Dj3ImDQ3UJsLbC8hJSRTgPl1u+/4KW19m2s6602cj
	XFvrCGMzTLJU3Ze1f3g8K60IgLuqaFyKG96zkhOQ==
X-Gm-Gg: ASbGncuEVCzrLOtTHB9vJEfVD4zhZlZCvAL+oAdeFnBK2fBPll7tvgnG5SzAgyYbIWQ
	4B35e9fPIshIe/B2G6Zc6X4wr1VWmyD43wpJPZb/pcCtuzGppmMxg/HWqxz2PIiAgkqF6uggyXo
	s16aFgg1MnASj9gCv7Xg6d6BopMFwl2kJdXELfDA1s4s8LIBPH+MCHeuMIE2iVeQS+YyaCTS+D+
	qNpG/fDALWr5Co4Gm8hcOHYpTaqc3jVmIS0xPSaR8oZ+EXNGGvcjyq+xmQYjXQ93M9mY2xzpPAm
	Ay8FiqBGvlGZZVs1d6IfJhQEKlhyEjJCZYF+tPOsTnD/WibzJfCTOKVyi1JdthrxkJE9n8la6fs
	ZZzxYuYWKs/Y=
X-Received: by 2002:a05:6e02:4516:10b0:3e3:3ea7:279c with SMTP id e9e14a558f8ab-3e33ea72849mr68928835ab.18.1753324421956;
        Wed, 23 Jul 2025 19:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ul4/vIy9Ag5YdBXWqanXskqOHNhjtEGEHhFsPxnG27rhKpBXCOxeJXxiqWeUWC6PlXbMmA==
X-Received: by 2002:a05:6e02:4516:10b0:3e3:3ea7:279c with SMTP id e9e14a558f8ab-3e33ea72849mr68928585ab.18.1753324421518;
        Wed, 23 Jul 2025 19:33:41 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aebd520esm137002173.65.2025.07.23.19.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:33:41 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Subject: [RFC PATCH 0/4] 9p: convert to the new mount API
Date: Wed, 23 Jul 2025 21:23:53 -0500
Message-ID: <20250724023325.16178-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 49jFnGEvUVK_TatJ9rqxfbuVuOjzDO52ShM-v19_ksg_1753324422
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is an attempt to convert 9p to the new mount API. 9p is one of the
last conversions needed, possibly because it is one of the trickier
ones!

I was able to test this to some degree, but I am not sure how to test
all transports; there may well be bugs here. It would be great to get
some feedback on whether this approach seems reasonable, and of course
any further review or testing would be most welcome.

Thanks,
-Eric

