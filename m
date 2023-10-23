Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD922EE8
	for <v9fs@lists.linux.dev>; Mon, 23 Oct 2023 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wpQP3XHQ";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wpQP3XHQ"
Received: by nautica.notk.org (Postfix, from userid 108)
	id A8335C01D; Tue, 24 Oct 2023 01:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104238; bh=U0OoYg7GbikTWZxa3iI1FGXi3z0etzMYaJtqHlCh94A=;
	h=From:To:Cc:Subject:Date:From;
	b=wpQP3XHQxfYe8j1OVBmZQ+UDiC0kdkNEArSLJ6tpMzgZdac9MaMoc3DI/7PqR4JJj
	 GofEfzEaX1njk39rCxCQKdiXvVQrRj5R0wOSDVoakDTM8wPvX9Wt/iF5/Ib3NI7uLV
	 IBr6I5ZurnFs8MKfdgJmJ6K0Is4zV13AUa4nyMGQ1T0F9DYGfVRbU6ELMPHVd7/TON
	 b1bmLLZ3D2zw3ZhZ1ijVWTtprBQu40E8qKPY7VvqjCsKNZjfIwAc4uxwRczH7f4DK+
	 KCBNZKP9fEKR4oSNFxqwWFSpRJGxQvWCPaY2u4YU0UmMCrkDEdQLjpQcc6Wetvrpk3
	 wN0XpZzgd0y1A==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 40B54C009;
	Tue, 24 Oct 2023 01:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1698104238; bh=U0OoYg7GbikTWZxa3iI1FGXi3z0etzMYaJtqHlCh94A=;
	h=From:To:Cc:Subject:Date:From;
	b=wpQP3XHQxfYe8j1OVBmZQ+UDiC0kdkNEArSLJ6tpMzgZdac9MaMoc3DI/7PqR4JJj
	 GofEfzEaX1njk39rCxCQKdiXvVQrRj5R0wOSDVoakDTM8wPvX9Wt/iF5/Ib3NI7uLV
	 IBr6I5ZurnFs8MKfdgJmJ6K0Is4zV13AUa4nyMGQ1T0F9DYGfVRbU6ELMPHVd7/TON
	 b1bmLLZ3D2zw3ZhZ1ijVWTtprBQu40E8qKPY7VvqjCsKNZjfIwAc4uxwRczH7f4DK+
	 KCBNZKP9fEKR4oSNFxqwWFSpRJGxQvWCPaY2u4YU0UmMCrkDEdQLjpQcc6Wetvrpk3
	 wN0XpZzgd0y1A==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id 2ef0606e;
	Mon, 23 Oct 2023 23:37:13 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: v9fs@lists.linux.dev,
	ericvh@kernel.org,
	linux_oss@crudebyte.com
Cc: lucho@ionkov.net,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/3] Small patches for 6.7
Date: Tue, 24 Oct 2023 08:37:01 +0900
Message-ID: <20231023233704.1185154-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the patches we got this cycle required a bit of re-work so I'm
posting them here; nothing big but please have a look when you can.

I'll also include these two patches:
https://lore.kernel.org/r/20230807141726.38860-1-yuehaibing@huawei.com
https://lore.kernel.org/r/AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com

This set passes my quick checks and honestly can't break much, so I'll
be pushing them to next later today.

I don't think I'll be submitting anything else to Linus this time, but
please point out if you notice anything I forgot!

Dominique Martinet (2):
  9p: v9fs_listxattr: fix %s null argument warning
  9p/net: xen: fix false positive printf format overflow warning

Marco Elver (1):
  9p: Annotate data-racy writes to file::f_flags on fd mount

 fs/9p/xattr.c      |  4 ++--
 net/9p/client.c    |  2 +-
 net/9p/trans_fd.c  |  8 +++++---
 net/9p/trans_xen.c | 13 +++++++------
 4 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.41.0

