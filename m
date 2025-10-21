Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE3350A02
	for <v9fs@lists.linux.dev>; Tue, 21 Oct 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088641; cv=none; b=P0J6RzkpU4P5B3xRMh98oLMvdqGunDCr99oe92LbX83E3EEPaHT9xiJNuQ0mtUrr4ICUtoa3W+NQZvOgk9F3+13GMg6IqjbXfakQW38aHHNZL0d72l2R10S/b/gTJ25SKQGQGhn3l16/kSvebYm/4WZ3FTQq2tOOUgMHZnwFeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088641; c=relaxed/simple;
	bh=TA9Z2xjXmSPik79pd2nczCKbtFRPJOsg1yrzP0azcSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag73IPFJ+Y+/w/KD1khmfwvUBuhER8bC5aDCEL5Xld/0T9tEKTsF0kLXD0WQTwF14mc4dMIgfH2cXl3wkKD40L9TEMPSY3eckPuuASNLfkQ4AI/4Q8bQBvH297ru4Bs+Zr9wpNDkqAl0uWAONS+sPFTHCZgXT4+DEVhwbwdORRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jwn/V6Ii; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jwn/V6Ii"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C8C9714C2D3;
	Wed, 22 Oct 2025 01:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761088635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvdSOJwgRRDHWmISrEiJpRZTFo/MJ+TFfDsA9nuP/9Y=;
	b=jwn/V6Ii+on6aH/1miOeIiq0m1L3XX0jqMPiKZ+zTpSjH5aD3yRayNilm/4UIMKjlYP7dF
	zoOz+v0GrJ05h7I8SppFbiQpeyLssfgTHjZ8FtO4lk7MP8fykqRX2dg3lJEuE0ZEzUebif
	gR+jgU0xci9klWEuZnGFi+sUYtmfviiKj3sUi2OYxwa5hB71B26VKaZyDKXrwCmYn10gZx
	iJYmJmBuNb6+bFojVZ7vADN4auWx8tM5cGWPObQCeIlltxQ4/9HjGxUtLjySHbCfbaVsTV
	Hf/r9S9LKG4XRQPNZwbLh/Pev+o8HLa0MPQO5APw926IK3BRKDTBJ7pQN1A5DA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4ac624d5;
	Tue, 21 Oct 2025 23:17:11 +0000 (UTC)
Date: Wed, 22 Oct 2025 08:16:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Tingmao Wang <m@maowtm.org>, Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [GIT PULL] 9p cache=mmap regression fix (for 6.18-rc3)
Message-ID: <aPgUaFE1oUq8e1F-@codewreck.org>
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
 <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>

Hi Linus,

We had a regression with cache=mmap that impacted quite a few people so
I'm sending a fix less than a couple of hours after making the commit.

If it turns out there are other side effects I'd suggest just reverting
commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for
uncached mode too") first, but the fix is rather minimal so I think it's
ok to try falling forward -- let me know if you prefer a revert and I'll
send one instead (there's a minor conflict)

Thanks to Sung Liu for the minimal reproducer and testing, as well as
Alexei/Andrii and everyone else who looked at it.



The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.18-rc3

for you to fetch changes up to 2776e27d404684bc43acf023d7ca15255e96b3e3:

  fs/9p: don't use cached metadata in revalidate for cache=mmap (2025-10-22 08:04:05 +0900)

----------------------------------------------------------------
Fix regression with cache=mmap in 6.18-rc1

Will do some more testing as time allows but this fixes the immediate
issue minimally (only impacts cache=mmap), and is therefore an
improvement good enough to send right away.

----------------------------------------------------------------
Dominique Martinet (1):
      fs/9p: don't use cached metadata in revalidate for cache=mmap

 fs/9p/vfs_dentry.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
Dominique Martinet | Asmadeus
