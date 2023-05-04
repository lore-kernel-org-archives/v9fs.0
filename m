Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B8C133
	for <v9fs@lists.linux.dev>; Thu,  4 May 2023 21:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0528BC433EF;
	Thu,  4 May 2023 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683237046;
	bh=WFw20QfDsL/6GRIEPbeM07zo/huuezcbqE4ZIGNkScM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W5laT6wzhQdLJudq8X/cBo1EovTGXsa8A/V5NhBYNlfqyAtlmPtd04UqjcpH8K6zw
	 bP0EJNipwDs2Ixlc2oHBxFt/ML/NLjdYGiGyHPYNY+7nyb0HRS3EneMEwbuP/lfeA9
	 NFk+zUbc+FmoBJNsEcbEubiActZJogU972sL9AJs6Nv7Q4W9XxVZO5EiXP7EPJXrUt
	 vcuFRtKgsuPoR3qkhwFeorvBhQxldT4w+zu2N0hTlFhh+PLMEzDLEwbXOmxC1XApQT
	 PFvTuxcjuEUKCyf4xN319zoABALisbcavpDhkx4bL0mvL+8pSbMHipRy3gX6eDJGdB
	 k4+xuJadDaNuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9D4BE5FFC4;
	Thu,  4 May 2023 21:50:45 +0000 (UTC)
Subject: Re: [GIT PULL] 9p patches for 6.4 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
References: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.4-for-linus
X-PR-Tracked-Commit-Id: 21e26d5e54ab7cfe6b488fd27d4d70956d07e03b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e15605be8baeb9e3957c268c7d6f901c327ad5c
Message-Id: <168323704588.23044.5518199268556560774.pr-tracker-bot@kernel.org>
Date: Thu, 04 May 2023 21:50:45 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 4 May 2023 00:37:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.4-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e15605be8baeb9e3957c268c7d6f901c327ad5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
