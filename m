Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBCC1CEE98;
	Fri, 25 Oct 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897175; cv=none; b=c/nGYoe2XJKAc8s0HeAotR9Rf39+uiD+BwUpztVEQBWW8KURoK87rXwekiGDZ1wqE5lmHbdYCAVeqMr9cSmlmVkKxaSd4NWY9DM6P0O53G6op4CajSqdq3ra5d4TzZTAL/sV4/MrUDSZmW+noFw0ufIitGETilFztZSvQ+Wioes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897175; c=relaxed/simple;
	bh=NTGgpjY12du3cbB1uiIDOxDLVnU8Dp47TfJiDstOOd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JjlD7o1hIKfZXopOQf5gDlgBBkSHgC030aUJ7Aizhn1lkRTmueG2MIb6GTEcr9bOuABnrVQbMDkLjkgcuAL6UzFzC7FpaNvwbW3u8vrCZylNgAYY0zXX+6/xa0TYARhXtmcAyYtK/Ld4L3DzDwL37zc5yE0qCSXKgdhP13Xpwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCfEWYZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCfEWYZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFC5C4CEC3;
	Fri, 25 Oct 2024 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729897175;
	bh=NTGgpjY12du3cbB1uiIDOxDLVnU8Dp47TfJiDstOOd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aCfEWYZQ3Hy+5b9oryznBXuJxhOp8NCrVO079e7+sA1hKbaLZuGKZFrA4hIME3B6v
	 i8HkfKPpkdDf5PPDA1GPNjRFavR5lw37ZQlR/CJ4LBDfmeQmSS0USHRL1pZ/170SFo
	 O1/gZePt+LFZSv5LRgVyDIDri+EUAdxnMycRrVZuV9Hl5O+qTSJ/b498Hqlnbe6qNi
	 YMhv/ajUyF4y3xQd47lcdbxJoyqv0mvp6oZF84fY1F5G26JPyk3oC6Uu2lfYInHRiF
	 XEaSbGLzIIymfLSXWreuwZaiOb25DPaT32dQQ1+do8nV3/eT8Q/8rbZrU47NT+aI54
	 VoFBEoA2VLDRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F773809A8A;
	Fri, 25 Oct 2024 22:59:43 +0000 (UTC)
Subject: Re: [GIT PULL] more 9p reverts for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxwPQTUCnbGEt1KQ@codewreck.org>
References: <ZxwPQTUCnbGEt1KQ@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZxwPQTUCnbGEt1KQ@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.12-rc5
X-PR-Tracked-Commit-Id: be2ca3825372085d669d322dccd0542a90e5b434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 850925a8133c73c4a2453c360b2c3beb3bab67c9
Message-Id: <172989718186.3095439.2377412556751777379.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 22:59:41 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 26 Oct 2024 06:36:01 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/850925a8133c73c4a2453c360b2c3beb3bab67c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
