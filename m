Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A18374DD
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761179; cv=none; b=SRDd03HwkRNggMT6VZTLvlISwAC7ojfxOh6gbAzvkL+cZMhVH2Nr1CVKPQaE7RzHECAXrsX9Q3TuBF8ivUgI3DOA7jD5PZieghuKy4C8KnC29Mfr+kSlB/UMQR1cmI4aUWp4QF+pCDcaKcLQCSn5OugUZfMCsdscDZZ/7PapenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761179; c=relaxed/simple;
	bh=GYS0nu3GC7essOXSejgnPeacsgybApJ9o0PaktR7X0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FjYH8KSBK2c/P8WKHiA8OZCUkQBbdrDBorQyotySJImdyb4v8qzfn1jz70LDz8BQUlUc541a+CplkOv2aDd9C7xUUS7GdJZTg94kW8thd0iqJmDLoyW0d58XacRBevxns6TAd+60bMiRM9wIIvYnKRY1JdKBQdImqjBNxDsaN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=NSa2cudd; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="NSa2cudd"
Received: from localhost.localdomain (unknown [77.72.50.149])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 134D5325397
	for <v9fs@lists.linux.dev>; Mon, 18 Mar 2024 12:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1710761168;
	bh=GYS0nu3GC7essOXSejgnPeacsgybApJ9o0PaktR7X0o=;
	h=From:To:Subject:Date;
	b=NSa2cuddmoiNf1TkV/jbNSPlIdmEzYqyizEk6D4nKqTOYBN0FtrQeHdAR0s5dTq9p
	 ZL8qaEmlju+FQpKrC9AnJ3x52K1cRdwKYXRqvcMrMVggQHf17Mewal1L2rCCfY/V3i
	 H3y+QirRItIPAYPxN1ajfuaKLrN+dhPjFYIc7mzo=
From: Joakim Sindholt <opensource@zhasha.com>
To: v9fs@lists.linux.dev
Subject: Bugfixes for plain 9P2000
Date: Mon, 18 Mar 2024 12:22:30 +0100
Message-ID: <20240318112542.18863-1-opensource@zhasha.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


My apologies. I think I got it figured out this time, with the sign-offs
you asked for, Eric.
