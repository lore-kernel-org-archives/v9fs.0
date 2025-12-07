Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D62D0C98;
	Sun,  7 Dec 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765126599; cv=none; b=lIGNElFFHRU2oK7tbVmsjcuIy1+N+2NPJ+Y+P3oOl3FmmBa8kw+dHHF1jE+mZL8DNoiAS2bj9u8oUR1KU65iQN4nFL/s+uDF8IKXdVowUtXIIpfPXtFcmxkLSw2KOZ7lxv5iHPjcaynMoa9tp6fCVhrxWS8y+HHJ3/sxGoWSlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765126599; c=relaxed/simple;
	bh=jHiXsfYVIukl5MuM8eFy/CVsiecycYnVWBzlLG00ygU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aIwW5EL3i0gofFbFrcoVI1Tk7YDkQkEEuNqM3fyOWNY+bdGya4Weu0t1JMSHmdvxuGaUNHVxarn+8GldRzyxo5pH08k7lm+QT58jKq0fAgO30KurJKdb9c4M8kR8aMUtiRccQE+XBqGvOmFSq5SV2hiZPtRCSx9GOlFO648tkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ork0DmiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ork0DmiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94CEC4CEFB;
	Sun,  7 Dec 2025 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765126598;
	bh=jHiXsfYVIukl5MuM8eFy/CVsiecycYnVWBzlLG00ygU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ork0DmiBMJ7nvElPFTYqsV382yd3EwDKj+JwYQ0dcu055zX8Sig7Tbe83LE9Pp6DW
	 I2e2AK7c3DotIQ5C2PkWl8OVDheR2rHJ7cwmi90rQ70bKRcpwCanWCpF9tDIyyV9Zb
	 PgXzSmgWtyoJ2iYofhS8prUF2Z3zJAap7lII+kKH4BQ3O4nmuhZ5TExYEQq6sArUD0
	 rNvMT8V0LJdbfIPv53ZdRjFkgsQzhUV+5uYeYValPiTepQ6e9KDNZjqJiDMIQzKvFf
	 LXxZKAJmO75omyEDYsr+tJ4UkVrVq/bjc5qE8VrBHOxyY9NU737K2pgHlDMMuIOG58
	 F6ym3nfULE29w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B9E3808200;
	Sun,  7 Dec 2025 16:53:36 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTV4nH9k3WGz9P4Q@codewreck.org>
References: <aTV4nH9k3WGz9P4Q@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aTV4nH9k3WGz9P4Q@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.19-rc1
X-PR-Tracked-Commit-Id: 3e281113f871d7f9c69ca55a4d806a72180b7e8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbbf7f32843b5788786cd8d91e9430823c2777c9
Message-Id: <176512641504.2480330.13679723557402440407.pr-tracker-bot@kernel.org>
Date: Sun, 07 Dec 2025 16:53:35 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 7 Dec 2025 21:52:44 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbbf7f32843b5788786cd8d91e9430823c2777c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
