Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADD3EBF3E
	for <v9fs@lists.linux.dev>; Sun, 15 Feb 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771147157; cv=none; b=LbAGsRAIl1Kq3C5Hsq1C+I6xlebfMB+ixdmgjcyI+5jLShQO9en5wYzUHZmI5hiU0uuZMMw9sXFKXUyY9BzseP2iq6MvEYN5i9TdX516crZJXFZNDijqwndrTBYV8MBXuAyQRTpZP0PVNs//dRmHXhz8VmTxne8NDEfi8waWjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771147157; c=relaxed/simple;
	bh=wymwmBUtUCiL0dx3ucSf7HlGk3LlHCD2csvPq71Uo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V6Lfy1nV4Uwhz2tbNQjGKVuVpBNV4W1NrFYvXa3GR4hRahWzAlAt5KD4AO76TDy1Xqe3wV2otSEi5R41QlXh4iqOk4FLWWrvsb1kWK3e7FZPAOcnpNQpbQGWEiHMR62kfC4aa3OzEZlLyLTsOnT562RoodomaJUc7N73Ehv+ux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Lg5r3c1f; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Lg5r3c1f"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4706C14C2D6;
	Sun, 15 Feb 2026 10:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771146700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T70wG6N4tuVQIbL1Fh9spJAx62d7VuI8gkpaY99bNbo=;
	b=Lg5r3c1fbJQaScNUlfYWhCIMmfo9idzcUgwG4c3TYC5EUA4ieLekYyJ0DCBPBZ9I+jJVCt
	MnoGpmdLCK5i/fJyrrkV+Q3pqdqcVU4KBwVkwTrMfy7Vc31CIn5px6/5FIprzJL4u+y64M
	QfLPuox9qiqM0Vt57H4vIqwbsnOumvgivVc2PY+xqJ7DAnCe7ZHKMv2jo53SL8QOw/Ezex
	uKFWZUndwd0US56n5HAJ6tRFs+e7hKquC8jC0h77apzWURkHrfKPPBNMUmIyrv1EvtcYGb
	GOV8azwVsLSWeSsUWYCWUXatPzYGzqsXZmqXNnPlE0V9LaEqZfjaw/YZi4KN9w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b3e33f71;
	Sun, 15 Feb 2026 09:11:37 +0000 (UTC)
Date: Sun, 15 Feb 2026 18:11:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p update for 7.0-rc1
Message-ID: <aZGNuohPlbuGjwaJ@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

There should have been a bit more but I haven't had enough time
lately, might as well send what I did pick up though...

Thanks

--------
The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-7.0-rc1

for you to fetch changes up to ce8ded2e61f47747e31eeefb44dc24a2160a7e32:

  9p/xen: protect xen_9pfs_front_free against concurrent calls (2026-01-29 23:48:33 +0000)

----------------------------------------------------------------
- 9p/xen racy double-free fix
- track 9p RPC waiting time as IO

----------------------------------------------------------------
Remi Pommarel (2):
      wait: Introduce io_wait_event_killable()
      9p: Track 9P RPC waiting time as IO

Stefano Stabellini (1):
      9p/xen: protect xen_9pfs_front_free against concurrent calls

 include/linux/wait.h  | 15 +++++++++++++++
 net/9p/client.c       |  4 ++--
 net/9p/trans_virtio.c | 14 +++++++-------
 net/9p/trans_xen.c    | 83 +++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 4 files changed, 67 insertions(+), 49 deletions(-)

-- 
Dominique Martinet | Asmadeus

