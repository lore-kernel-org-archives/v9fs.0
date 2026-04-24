Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9836BCDA;
	Fri, 24 Apr 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063927; cv=none; b=uSsTBTBa5rnkOgiGCMgb9/T6Rv1ZuqFJIpthaeMUEIugfsRonFV4D2r5As/tmviv/dc8D+ok+/3AS0SvE29GzDEWu3kLaFEum15LkoIMDYLs4DWYIDGO0Eqp+Alnl7Ez5G93Pbi62QQbFc3zBflCKJWfQhr0ubPEm+GwNciPs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063927; c=relaxed/simple;
	bh=cg388ml4EScFgOP/TDmjm/2eyY34i7+PiNjKqS9Lgbg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EGSzSALtqtHZ4OeVYt3Ud4m1bPid4FrJnOpSF+p6WNjAnqfrbUQRsrm2SAOTXYGK8SM1nLhw4f/eRp08caYCDqPZd+JIh3NZ3FR6Z2fPXDXL99DuF1aXmzXY4jHisnUnNNz/mQloWi9NPle3upIoK5TiKWO4XWs3JJDza/m4LgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st7AsdJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st7AsdJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C50C19425;
	Fri, 24 Apr 2026 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063927;
	bh=cg388ml4EScFgOP/TDmjm/2eyY34i7+PiNjKqS9Lgbg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=st7AsdJXhfgstclLEvw9kfZ3I23v1UBFBgNKKR1zWt8M4te5C8nhOcG7NlCO1kTn9
	 +zMkAsvYjOBI/JFMsygolHzMMIBovHIT7zSOCAoNrdj5i3EOzNx+/PRvnFGN1B8YRU
	 sMQ6uJG/FWUAUbZBu7qvJ2Odu0jh8ONDtECBLjnMzpJVSu/5fvpoZ9WGm4BcrUUFdx
	 5QLwhrOAc6FR9IWU/6rKcYCArmhW4pMu8BP+S0KD11UR8H1MNvnTuymLsMigPBm1Bx
	 CuXvZf1Mg8I9aB+Mj65HlATdjMAUjSULe0NUV0J52EMbD45FjgoFl3pbFIURV6TcMp
	 OWi2z2puS9JPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC938119C3;
	Fri, 24 Apr 2026 20:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aetF4EENt3meh6lt@codewreck.org>
References: <aetF4EENt3meh6lt@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aetF4EENt3meh6lt@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-7.1-rc1
X-PR-Tracked-Commit-Id: 8fc518e489c1386fd0cf7f4256d055960ed6a2e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdcb864c719f7cf8629ada18450fd4efbb16afe8
Message-Id: <177706388780.1712010.7785444485079032322.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 20:51:27 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 24 Apr 2026 19:28:48 +0900:

> https://github.com/martinetd/linux tags/9p-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdcb864c719f7cf8629ada18450fd4efbb16afe8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
