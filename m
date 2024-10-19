Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BE2F3E;
	Sat, 19 Oct 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729353670; cv=none; b=slfwOI9HRHN/E9JoBQP+w2lWPXTeCsm1xuDzXJWqDw7FWR5vlZESR8azeNXIIb4DqENm7TrQ34aJ3hWdIWAcw18Yu7PBfImjLj6hPAsVsV0BjVwENgE716YcW2Dz52JkBh1mZM5wyf03HeO/MLGgo4rlpkvdv6Aa4m61CS6fwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729353670; c=relaxed/simple;
	bh=/B9ZLsaqPtNdTkvYo1MlOsWm47YFrbAT50kqlmkdQrM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UjE/jz2HTkmjg9O/lzkxUcUsGQbwGYosF2Q6hhO6cz9mDSQtrXn/VAjNNeZzAl9RX5n1rFNRlUpuD7mdmg/BN1TYpZxXvcAIfLgEMWyvDDxcuqtxf3ZT5t/yHU/cL7Laj/RznAIaZ84LRqY9u+dAQQy9RoIQdMhLo5c2qKGZr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEpgdDt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEpgdDt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B6DC4CEC5;
	Sat, 19 Oct 2024 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729353670;
	bh=/B9ZLsaqPtNdTkvYo1MlOsWm47YFrbAT50kqlmkdQrM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NEpgdDt7K7XRQePhSGdO5N0ANSHv6sQhCKN5Bwr+TYmgDeL4P6yEiT2FuaoYop2SE
	 vRwe9Qy3qaDWBQuWte6MlCuFTCl1//Q4QCUKpmTXVWnrH4kZAi47hVu2hndp+PBeoH
	 5olOHNiUhow2W+1u7d0zVPFgaRcFRrJijxdedElbI1AdzBu1NYyy+KPIJlElRDEy2q
	 +hxFgpVH79unNBYYt9biLmj0pAXYki6VpI0/BRHYj8NXLfLUZFQF4jfOaFJg/eg4/E
	 bpWqcs9Y8rnQVt2jbZzNdAONH6Eak+HXdRkgY6JMBUuml5XKPtCBxtENTELN44NUz3
	 N+LV9IInIOFng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC023805CC0;
	Sat, 19 Oct 2024 16:01:16 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxL0kMXLDng3Kw_V@codewreck.org>
References: <ZxL0kMXLDng3Kw_V@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZxL0kMXLDng3Kw_V@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.12-rc4
X-PR-Tracked-Commit-Id: 79efebae4afc2221fa814c3cae001bede66ab259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9197b73fd7bb263084a95d1c578b7ee0ad54dfb3
Message-Id: <172935367545.3434115.15709053125208214309.pr-tracker-bot@kernel.org>
Date: Sat, 19 Oct 2024 16:01:15 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Pedro Falcato <pedro.falcato@gmail.com>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 19 Oct 2024 08:51:44 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9197b73fd7bb263084a95d1c578b7ee0ad54dfb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
