Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D23C34
	for <v9fs@lists.linux.dev>; Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX2fZuzC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A97EC433C9;
	Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699126756;
	bh=BOZpFArWW1T5xfM9DHadV/pgH4GJEb9Dty1PKf4xMKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HX2fZuzCP1rovxZm6Tt3xYcp4AlYFZygvPgq2RbMhcfecSHqgUBNXEU0teX+5R+Me
	 ZSDX4tw5dG1530GTGWKFak264IHPw6MOY4ofFA3M9LaKbx+zvc9ZQaDg0rNLofGP+o
	 HNwyUIriTgBDmBUp1ZrBxxtxRIiGeojDQbjQWfw237Dyel6eho7RitmvKBlcQUzxp2
	 OlCVUnF4o/DyAhs9paI+DEEULHV/7MXxXCqz8yVQftpWB66EPHd2twcZZB1yuhT0hL
	 IgX7VZ5BQBjQo2cIXlurf0Fe95DMHQaTGT5xNz/DddOmcCyEtIdIRBe0UyfQRNhFQ2
	 EuSZGYdX1tjWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8A8C4316B;
	Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUW82S8bGg2BAeNU@codewreck.org>
References: <ZUW82S8bGg2BAeNU@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUW82S8bGg2BAeNU@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.7-rc1
X-PR-Tracked-Commit-Id: ce07087964208eee2ca2f9ee4a98f8b5d9027fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9b93cafb69cbbbe375de29c1ebf410dbc33ebfc
Message-Id: <169912675623.21555.5765396165383990631.pr-tracker-bot@kernel.org>
Date: Sat, 04 Nov 2023 19:39:16 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 4 Nov 2023 12:39:05 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9b93cafb69cbbbe375de29c1ebf410dbc33ebfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
