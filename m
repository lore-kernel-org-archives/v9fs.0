Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AD1A23A6;
	Sun, 15 Feb 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771181907; cv=none; b=LUYk26E/i59gkPPFPKdpQ5NKBjlNl1HsGQVT7fzUaUQa1P2JkjlKPGTHD4z+72eja3u9yWmU8cEe5x5mQy6XjZiBCrtFoYvh2y4+/rofU+N/QcJqKAUFiuddn15cQmSCp0ne/7fttPWst7clCIhzI/61EzI/gnIf+FyCQEud6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771181907; c=relaxed/simple;
	bh=kN5gG+MCYV6VKLrjN+hPAEMvI/rzYxIbbuG9FritWHo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=heEN1MBELEdxMs/+aGs8OAUjon9B0Ev0RToJwCcydDqn+8V5cgGvnw6nylmUTrHnMqHTGK1ETgBoARI3V6Dtwual8cV7/0nGbfazDKSsgFGmAc/WLIjpVPUyOpFHphacibTCKzNwBL1P/bbFW6BtR5RfGFQY/kQTb8pt6fRGn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Pftuaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Pftuaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE301C4CEF7;
	Sun, 15 Feb 2026 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771181906;
	bh=kN5gG+MCYV6VKLrjN+hPAEMvI/rzYxIbbuG9FritWHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J5PftuaaF9ju6wh2OifNp5gnU29bqHHhv8ElxG8zMSRn9cJxW9I1dGpFNRfRgdflu
	 MrVkTk1Tn4HJHu+ubgtS0m475s3KaG1qXh808o3VpgkyC6Zfkgddb1BLEhI2R/3Kvj
	 IVuuv7DkIjQWKdFTE2PFBSBqCraYg+cL5hZSKQO2U32rfeV3lC0N+0+nHpm67goUdF
	 UwRAM/jK3RNSr9j1De7d34HCqniQKxdPRhCnwyoYA8uwrLBi1+FzQPv1WjVIRnWVTW
	 y39RXdSQV7pSRInVRMuFl4uGH/CSHB5/SMQUeRnN0zDse6HhetNOhx5fm1NvTKVt1f
	 k0IF9yQjXh7ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C21A23930925;
	Sun, 15 Feb 2026 18:58:20 +0000 (UTC)
Subject: Re: [GIT PULL] 9p update for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZGNuohPlbuGjwaJ@codewreck.org>
References: <aZGNuohPlbuGjwaJ@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aZGNuohPlbuGjwaJ@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-7.0-rc1
X-PR-Tracked-Commit-Id: ce8ded2e61f47747e31eeefb44dc24a2160a7e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 011af61b9f7c9104eae7ad9951456330d950c771
Message-Id: <177118189931.3159544.4323362736152895354.pr-tracker-bot@kernel.org>
Date: Sun, 15 Feb 2026 18:58:19 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 15 Feb 2026 18:11:22 +0900:

> https://github.com/martinetd/linux tags/9p-for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/011af61b9f7c9104eae7ad9951456330d950c771

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
