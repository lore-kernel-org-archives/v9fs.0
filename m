Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8E154BC
	for <v9fs@lists.linux.dev>; Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBE4C433B7;
	Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690569573;
	bh=ee5985S6KrQ/n6+xdUGQVtwY+R5s91pwni1DH5t8940=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xf5eTwJSynvWpHFgtMo6ScOZ8lVh3yppfdkSI/1xQO1DQqBWnwUtRNfg9aZyjHFqX
	 3tyeF/Akwg4VRNttMwkvaTg4fWbk9c+jVNKq06pYHd7X3FNPm/LQIKnZY6vluThm1S
	 AZSJOPNS3gDtAOhCR12ojr3yNTYgZbBNrTYadpjUXEVX1sl3CacAg6UHvdrADD1QV+
	 ghrPUUUQmwlvoPlrxBlgr0xK9lOBvf+flhZvbme9/cYK/Krl3i4IPauGJNAkkBupoX
	 kdpxSh1krKbDrydKpU9UjCL0NsK4uezF7lr2pKrfXoZiJws0tKCTLboL/+2FyeEkzn
	 4yvHXWBjzMh8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 158D4C43169;
	Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p fixes for v6.5-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
References: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next
X-PR-Tracked-Commit-Id: e6ab0b914c12acefbb0880dded48cb930ccab5cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28d79b746cf46e48e5c38c6904ea5faac217da21
Message-Id: <169056957308.21363.1664033774331422146.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jul 2023 18:39:33 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 28 Jul 2023 02:09:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28d79b746cf46e48e5c38c6904ea5faac217da21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
