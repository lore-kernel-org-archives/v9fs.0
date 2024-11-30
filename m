Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645231A76D1;
	Sat, 30 Nov 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991928; cv=none; b=EvjTIFBmI8+xQUfQzghaWWjNX8FWP3vMXXXOOmSNgHIv8p98W/0jnGJrooyV4pV1Kz/yzdgOX6aBrZAYA91BJ/sPwjKKOTDZTRLt1G0pdzv708Ij4wXMQTs9fnpRiUlTbGxdUZ4QGyDLrdHjP8PU2MZh6TxKz0TGTi6QmBvSBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991928; c=relaxed/simple;
	bh=QHqcs6Hv6d0ys+NG4iu6CiT261jXzaJk20qAU3K/1OA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F0N3KH0X2YZ0s79UmU8PISL6jRDiq9spdHr+zcF1K5eTzA3A9uu+SurFIpbVrmCbDA9dlky1veAeGnKVpRLaWUBn7NYvvOXesMkkKFuU9iEO9lP6zcatq6lbAjVFI8M1VWbgch+KOwy8gOy2iwFMqCf32iXjvJUExyLj6EiyaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZTBSQqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZTBSQqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41169C4CED3;
	Sat, 30 Nov 2024 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991928;
	bh=QHqcs6Hv6d0ys+NG4iu6CiT261jXzaJk20qAU3K/1OA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SZTBSQqq/L1hpWFA4HgTwkJzmnmaxgDke6PbKEqIKe42+i0IuqGYMvFb6GLj2u4WG
	 kPAeHj8+MlFrDv8r8tyeXpB6AWK0WRQ3ji5g/uXN31pwrIwQwXtBw4Xc/+1toJB78m
	 PvrDRXukMoW3HdJktOoJgCXP+eUwaW1i/bDYiyaxVYPLOYiqdb6/bIhqHKmgyAmL+v
	 QEIddVJzjQPnpQSp5+LGr/SR2UbBauDk2MVDhUhIB1hXD6OTNjwexvAzQDFv867XZJ
	 frx0TLm9K6LwPSNhjOeh3qDlh9a7urQucua0u9zk4k348VcdGKkvjml69CyOm/oNnl
	 itu4J+XhnqIJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342A9380A944;
	Sat, 30 Nov 2024 18:39:03 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0nxET2etduwcfj0@codewreck.org>
References: <Z0nxET2etduwcfj0@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z0nxET2etduwcfj0@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.13-rc1
X-PR-Tracked-Commit-Id: e0260d530b73ee969ae971d14daa02376dcfc93f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e864effa1fe240473e023fc8e8d243045a7763e0
Message-Id: <173299194161.2451487.12983152164622795358.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:39:01 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 30 Nov 2024 01:51:29 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e864effa1fe240473e023fc8e8d243045a7763e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
