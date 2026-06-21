Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04F1BBBE5;
	Sun, 21 Jun 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063055; cv=none; b=VDoQfo5ok+9qhKauy8zsEkfuevB8Io8NwoyEf04o7ehsje5/j36DxA/s40W38NX02wCPISizfvm8kup1YNoe5X1rcsydl3V4VHmXIxEOXWSNCSFV/O4XvQWbsk5l9YdIippqRsPaZ7cw+3CmUqZYaKJ9wASDtuW2/pwdVPhrBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063055; c=relaxed/simple;
	bh=sbGI0tv/SW4taB+npdsRjS3Hrhq1s3Lp9JKm95I/o2k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a0EGNQco+YmvXC169joPiq/yx4Z3+H3wXHoMTipvtemix/+9qee5MMAJ+Q8BcwJ6IFt5BmgkNo9cl9J6AmxvIeikTxuql2VKzCIM1WfCiTl+C5ZnuHsHj+Qh+xLTZ4/MHXC/MnYf/qJP3ivFo1k6QznI3STTQHzupXtWM3Q4o9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmjkX7tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmjkX7tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2759C1F000E9;
	Sun, 21 Jun 2026 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063054;
	bh=49+ax6ZatzmLLx9u3Mxnyp3axRZcs/JJf/JDqeWoTNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SmjkX7tMsTD0tWhcqKZ1GHQkjFPNKsLhDKsbVVzu8hl6pkZw52ZCVsHNXmr4901qA
	 ZvgSu9YXgEHLgWNQnPDGA05TFXuEw7EoqSDSx2pBZSFuLH2PwbJDZe6eJrpKPrzOOO
	 FMzpSh9haXwFZtzEWlB/Aq0xQplE2Lrhb8zHb+1Fp+kiMHL9zlgO5MzLGODF4zN3Xc
	 txThF92WiuworXXY9Ow3Mmz83OB1ibBFNoG7N7+2FqVeQ1ge6hYaOEXOK2Y3Cep6Jp
	 X2XMLc+yJqK6ZvOS/4NQ7n4u5MLO4KXFwxgin/MVpv98BqNqd5y4+8LbA9pCuIbaWx
	 XcM3t5pms5tUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D0C3AAA6E4;
	Sun, 21 Jun 2026 17:30:46 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajfkuS-kgmJXentl@codewreck.org>
References: <ajfkuS-kgmJXentl@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <ajfkuS-kgmJXentl@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-7.2-rc1
X-PR-Tracked-Commit-Id: aa88278693cbfaf7a2acf961379973fbb63b165c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bc18858358d7a4e263a63b59a12cbfd25c16670
Message-Id: <178206304530.449871.7463982446953774485.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jun 2026 17:30:45 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 21 Jun 2026 22:18:49 +0900:

> https://github.com/martinetd/linux tags/9p-for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bc18858358d7a4e263a63b59a12cbfd25c16670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
