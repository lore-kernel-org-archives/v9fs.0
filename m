Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F72E8B62
	for <v9fs@lists.linux.dev>; Thu,  9 Oct 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015990; cv=none; b=OiZterxcG1KyLzKY7ymujm/lNfjT96HTYsz3797O1VuheQOcN1KMB0Psa4pyZb5G37HBf220NHBTPEXHppM63gB+DsjscWagGvdt6N9TorWlCSXrcGEE+i3YW2pKgV902R+rDZlaSQZx1iry+0jhoZkupVRbk6jzCFIQUouQRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015990; c=relaxed/simple;
	bh=rNLTq1LQFw8bHXqJQapbXIlJpzZHUR76vAyHIGqeW78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F/yTvsLrMSjYSIYbyt3aCfPXYOaMSDiLgprelabPxi/dr19BZOrn0Nc1MD3Ve+ktVhf9AFLgcQk8IpEXBojjvBkRuR85kWikRSBxPygSl/vh6zzVzUuOz3n4G/95zuBdHOXu/seRCteCbqVQz5pY2vY5ofpSc+rs39CxTDLS/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=GCvq1v9a; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="GCvq1v9a"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0B97014C2D3;
	Thu,  9 Oct 2025 15:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760015441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RSEzej2rMgZ/3dQXyeaxr2uE3jRK8E8SdoM2KwIIHvc=;
	b=GCvq1v9aTg5FpSIPtWoorqiXzwQTMz83nHwr/4YiNUtsosP4PtDdQtyKlMjJFVNLWRXwLV
	5pnPNYZm51/Dmf1pV9l9MvYOczeVYDkiqyIX+PA15TD2crMPIrjaH/dXUBJ8UD9ZZCwtLf
	sgWLGkcREcmQKFin31e0cR/WPDTvGUrD8iSOCuJqKDnypCzg3WOtyT4JompyaylcOUKViK
	rF3irMq8qBXy+e5hGpsbdjpWMHqMCWGII3O/pMKSvsgVyL8zn3ylJLxd+XZjbFoG30mUNV
	YKVkLetDEpxD28O+CQ50axVPIM1flLCATD9Hj6M+wwbZ57DOaMbzqqaXW0qUKg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ec0f6332;
	Thu, 9 Oct 2025 13:10:38 +0000 (UTC)
Date: Thu, 9 Oct 2025 22:10:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.18-rc1
Message-ID: <aOe0P8ixMEg4ul5K@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.18-rc1

for you to fetch changes up to 528f218b31aac4bbfc58914d43766a22ab545d48:

  9p: sysfs_init: don't hardcode error to ENOMEM (2025-09-27 21:44:38 +0900)

----------------------------------------------------------------
Bunch of unrelated fixes

- polling fix for trans fd that ought to have been fixed otherwise back
in March, but apparently came back somewhere else...
- USB transport buffer overflow fix
- Some dentry lifetime rework to handle metadata update for currently
opened files in uncached mode, or inode type change in cached mode
- a double-put on invalid flush found by syzbot
- and finally /sys/fs/9p/caches not advancing buffer and overwriting
itself for large contents

Thanks to everyone involved!

----------------------------------------------------------------
Dominique Martinet (1):
      net/9p: Fix buffer overflow in USB transport layer

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Oleg Nesterov (1):
      9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

Randall P. Embry (3):
      9p: clean up comment typos
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Tingmao Wang (3):
      fs/9p: Refresh metadata in d_revalidate for uncached mode too
      fs/9p: Invalidate dentry if inode type change detected in cached mode
      fs/9p: Add p9_debug(VFS) in d_revalidate

 fs/9p/v9fs.c           | 16 +++++++++-------
 fs/9p/vfs_dentry.c     | 33 +++++++++++++++++++++++++++++----
 fs/9p/vfs_inode.c      |  8 +++++++-
 fs/9p/vfs_inode_dotl.c |  8 +++++++-
 net/9p/trans_fd.c      | 17 +++++------------
 net/9p/trans_usbg.c    | 16 +++++++++++++---
 6 files changed, 70 insertions(+), 28 deletions(-)
 
-- 
Dominique Martinet | Asmadeus
