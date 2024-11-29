Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441613BAEE
	for <v9fs@lists.linux.dev>; Fri, 29 Nov 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899117; cv=none; b=OPBq9H8X3o4uvXwq8e31SE8KFNKYyKZyyTY2mGPXG/GXlnLe/B38DH0nXBnnaHjpdamOeOCKzXB7jVK8YDcp0RGymPqnWVH/zC30LV3InPuS/8oIAHTWwuodNumtX7cl94caUTFOUZzO/rGoR732qgPgwM88DtKKFBPFpdXHhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899117; c=relaxed/simple;
	bh=d6NinvUuWTKaXw7mA/SrT0xN3cZpoKHINerF5cdEjKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SMcZNt19NFCvhpv/hdoOGlhDVP9//IP64N3Y5m7CoQ4y3XoQlwtWfGFA+yDWgPxHUTF31YlDcxQ93v1s8ktUkpE1A/BCzwFeGWJ35/s4EczySjYmn6nHG4CqMOJZ0j5Zk2Im92Mc5/nKZPYsjlaBAexFhS0+RBUpGn5l9f2qzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=fqX2TvD9; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fqX2TvD9"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C7CBC14C1E1;
	Fri, 29 Nov 2024 17:51:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732899107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=td5Pg2qCCZ84Cz1o4OZYGGXXxg/WaDPyDpc9W3ziyUI=;
	b=fqX2TvD9TNJNPZH+QbtKgFP5OHXV3kvsTTSgjiGjr53NdV1NYoukFtGz/XrfUKln9QyuEJ
	XDPVDozHlTZ+EahY5C0NGZfTjH7xMkCIwarDct/+wwbgy1wUfIlwGug9kOiBIBoN8f5bKD
	WIt+qqae7E7pPp5rtq4N7y1jqlltV3b1qmKJ58oprrH4pBG/G4MV80ao5W6CDDwRTGAtP+
	zGrsOzGyUSFvS2z1Ekv50ID+y2uw6QSNQ3dDIW35eB0iMShheR+s/5mB3m4Uaurvk7hJD8
	ZW6OnEWx7jWHFbzSZd2y6OCgo9RYSNe6q2M4oIsRnqWc6u1GYlZOEYZxDhrojA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3f466bd0;
	Fri, 29 Nov 2024 16:51:44 +0000 (UTC)
Date: Sat, 30 Nov 2024 01:51:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.13-rc1
Message-ID: <Z0nxET2etduwcfj0@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.13-rc1

for you to fetch changes up to e0260d530b73ee969ae971d14daa02376dcfc93f:

  net/9p/usbg: allow building as standalone module (2024-11-22 23:48:14 +0900)

----------------------------------------------------------------
9p update for 6.13-rc1

- usbg: fix alloc failure handling & build-as-module
- xen: couple of fixes
- v9fs_cache_register/unregister code cleanup

----------------------------------------------------------------
Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Colin Ian King (1):
      fs/9p: replace functions v9fs_cache_{register|unregister} with direct calls

Dominique Martinet (1):
      net/9p/usbg: allow building as standalone module

Mirsad Todorovac (1):
      net/9p/usbg: fix handling of the failed kzalloc() memory allocation

 fs/9p/v9fs.c        | 21 +++------------------
 net/9p/Kconfig      |  4 ++--
 net/9p/trans_usbg.c |  4 ++--
 net/9p/trans_xen.c  |  9 ++++++---
 4 files changed, 13 insertions(+), 25 deletions(-)

--
Dominique Martinet | Asmadeus
