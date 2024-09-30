Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F4198850
	for <v9fs@lists.linux.dev>; Mon, 30 Sep 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722512; cv=none; b=MQyBPTsn9Ouz2avEyWhj0mwGILsXEklpYH0Lmmhceucf+hHl5lEwQ8H79EW/Mp7UmQdw3PjvmoJ4d9X/xGjg3sir6VmQOGGNKfIAjcBQAh67yUeSDQKQQA6Q/O50tEYkgLdiX24T2CdHbPqZwN6fAnHLSID6X62nA9nXq70vr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722512; c=relaxed/simple;
	bh=DncG/RMrnPEbFWH6D8LtrSW9LSny2ClSKkba5oLV8OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTey9RnRoqsF88OmnHnP2f9H1GkJ5XUxQNJ/r6Di9J9dEeijoJncSEzTVH6PW31QK6FCHsskZYwHHFwDZZVQbXgLrUHaTDJ0lp7SdltTWLT3MGr3rHSzE7DJq4AxkBs9Cj5eqKvhy61MbM+QhKklzHf4H6fziHwakGg1EzTXDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=RFolJnzI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="RFolJnzI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7dafb321dbcso238684a12.1
        for <v9fs@lists.linux.dev>; Mon, 30 Sep 2024 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722510; x=1728327310; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VAQ/SmVDfVAhynU7T94wopV4O6hecY0N9QDW6gOokw=;
        b=RFolJnzIywLJh9HHTM5wgtrzhSVCCXd1oTZGk1oQSc4eM2ZEdFxTTAWIgSn+ICTwHt
         BM8o4SR3tXLSGgvD8oDm+M3kQgyg92rXVwemlnwkj7E8fdxCWl8h8uIsS9sGtxLx6ozE
         Xyo0kLHL/ks6QzO25wbP/heOcaErSr60mRcPmuDkcPn6KaxCHKm4yPhCyL5JtRkkavNK
         EZFYMUjWgPidG6+xkB2LLf6+UlNvSugfqFPQIGmjK4wsJ5M91V6MiJlMM6p0AubnRupJ
         YGsiFQeCd2hQWIxcB3wmvDwWLJKddmARMrYZMml+mrYuMcLKM8Y4tk7SSi7zbdsKmA53
         PsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722510; x=1728327310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VAQ/SmVDfVAhynU7T94wopV4O6hecY0N9QDW6gOokw=;
        b=LX/oCpPTVhHidAF6l99ccCx6oIOPfuSEQjOO/fbmPF1TS5athE7hMljwAhdvCbA7lO
         qDTgiaROMMWCa80c10xJOn1jDyEOnAWRSEDuo31laZQ3rItB25d/mSl+1h0O1oSJZPH5
         AHOi1rrHWilGe3rxapkx3mprDS0QGh3KV2V2vrCRV23e7I0pNQoIhP1IUZLJiJVfo0L1
         50S2IaM6UDFY3Ii/VIIjns3i2w9czUHEeZFcAxaRochHI8heVKZHXPWniMjFL1QLAZAf
         9PMa/lm8/tt+A26z0kLVKTlqv9lqrJ81VY2kJsYBwroU3AIAoIJs0KRZDjw3/+mrmGk0
         uehg==
X-Forwarded-Encrypted: i=1; AJvYcCXi/MCwrfSFtDrXMBdVuNJF7QQcjYxrMMThFSt/SpxWvrNfv3ypB3DgLNxnkYXX08oppw3Y@lists.linux.dev
X-Gm-Message-State: AOJu0YwO2WIMUMhS2Si72bIc80Dpp3FYjewa3d+o5XJojQHzN162SirN
	Nii2AMGsDbQARdtbS69ch18yfqfT77TWX6JiUfcyYwS9Pfi60D5meTFEc/YrqUo=
X-Google-Smtp-Source: AGHT+IEHnADY9Lk/jZUl1YRpGsPuBms2JZDBO/xgFDkOwrdjxf+4j2N2oNKU13O1aDFUuC5vUMn2fA==
X-Received: by 2002:a05:6a21:3283:b0:1cf:4903:7f66 with SMTP id adf61e73a8af0-1d509b1c3dcmr6304093637.2.1727722510147;
        Mon, 30 Sep 2024 11:55:10 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc3ecsm6610976b3a.60.2024.09.30.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:55:09 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com,
	v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Date: Mon, 30 Sep 2024 11:55:00 -0700
Message-ID: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

iter_folioq_get_pages() decides to advance to the next folioq slot when
it has reached the end of the current folio. However, it is checking
offset, which is the beginning of the current part, instead of
iov_offset, which is adjusted to the end of the current part, so it
doesn't advance the slot when it's supposed to. As a result, on the next
iteration, we'll use the same folio with an out-of-bounds offset and
return an unrelated page.

This manifested as various crashes and other failures in 9pfs in drgn's
VM testing setup and BPF CI.

Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chantr4@gmail.com/
Tested-by: Manu Bretelle <chantr4@gmail.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 97003155bfac..1abb32c0da50 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1033,7 +1033,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
 		if (maxpages == 0 || extracted >= maxsize)
 			break;
 
-		if (offset >= fsize) {
+		if (iov_offset >= fsize) {
 			iov_offset = 0;
 			slot++;
 			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-- 
2.46.1

