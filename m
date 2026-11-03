Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724759;
	b=TkqEZ06BxhApzoF+t7NxYfOxI7W74yGNDGgd56PqxXUf9xY6/O1LmBawtPAgL4Us5Z01
	 hhByeilN99vYKHsRbYOlbrHH6YUrIQcKB+LpB35gG48mwGujalYFl6Dl3J4KI+nH4ploh
	 fR/lZbuf0Or4LE3w/98mzTDgFBJ6KKLbImoVl23OaWebJd8OOr6BMD9EM2rvXOYj7wiIS
	 lWl67ywSo/iSEgZRKXF0hL5USK3thBU+4rtr9qGGy0+ExWi2yzoBRf76cnWsQcaJEtHff
	 l39l0jZvwp+URSJeQkJW1m0E8tixoRgEHx7VguvlSlRf+f/UF5YDyE4QjIHCcO7Kj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724759;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=0g9dEUSEI5x5REmXFQDg69jxmtFS1t4EqLRxPPkxmf8=;
	b=43tAOgyM2AFFpkQWlRYizBx6L/mjnMC2KzPtrRdsUTD6RVrHngkpL7RPqy5sxv8lt9ae
	 +ttINHrrsRezks2f5tUmjeM6BpHH5HvVsOYk5KdyCezDkyzVDqPAGZffOhCJuIbQ6AXpO
	 pvuAImclI5uhG744LYch9to9NwL8Ec4mR3KYtFIgwiFzzJbopEFFTiXMbxkDrYUzy4JKp
	 OvZ+/a+wysQGY9hhYJCztzTuwgg6LVhwMXJ9FnEWRqFeHmKjiaMRiyFb6ObuONg7QgwbC
	 VYDXxV6bRsTIDmhPlR3V6YREKBlwdvlvPZPXuc18QCZonrtjPIiTIH8uyAaBnhXr88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Op88QJ/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB51606A334;
	Tue,  3 Nov 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op88QJ/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91721F000C1;
	Tue,  3 Nov 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724758;
	bh=0g9dEUSEI5x5REmXFQDg69jxmtFS1t4EqLRxPPkxmf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Op88QJ/EohVbq+/GrKi/jArzmVpzn/cXomFqWpUiWbavzfsnpndCICnOxunvAWoxI
	 hjYq6HPM2zH+Q85x2xUhw0i/FstK5851aM1fWI7Rs+HqRon/r7wlDfA46Qos7BUIsM
	 ZwdoVuFmn3sg7/AjPWNGDtT9oxvmqVeohfp2Ue44tFqYXGHqKsIICL0b8jyFOhYYRd
	 xs2ypox44VNDNJFX0pnrOcTST1Y+tLUQO0AFDI2Eekv2YOzPHt9UDKVDaIJGFhktBX
	 f2fc8fiYfj13BdG2uYdjkUWquSCV12Qy2DFH5EpLdki7t+XF7EEcC5K4II7LkLQo2p
	 pxaU3Apf5iw7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2F1391AFFF;
	Tue,  3 Nov 2026 16:52:38 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aunQAEOa6mn2E5wm@codewreck.org>
References: <aunQAEOa6mn2E5wm@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aunQAEOa6mn2E5wm@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-7.4-rc2
X-PR-Tracked-Commit-Id: 35ecd40c0d7e4f772d00dfec9f7077315ba5ca82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d1471e50943196f909674d2d22eb4196c7df48e
Message-Id: <179372475729.1755341.2720045239524431603.pr-tracker-bot@kernel.org>
Date: Tue, 03 Nov 2026 16:52:37 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Tue, 3 Nov 2026 21:13:52 +0900:

> https://github.com/martinetd/linux tags/9p-for-7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d1471e50943196f909674d2d22eb4196c7df48e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
