Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720F2BAEC;
	Fri, 19 Apr 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559594; cv=none; b=kgf3N4TM5WD6q6GNCMCO9xTJ44Q1G2q1sfRezlKEAnuYLsGF8ZJrxGW/oBWOHl9AuJyfZFD2/HHXN0M8sEE6ECOq+HsuFAsPSecD78wonL9qB0DEf8iDzVfDWGpd3YJ5IuYE5+6QyHd/EN+2hKEUEN25X33QYCLQRg1UYkFSAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559594; c=relaxed/simple;
	bh=KW9pVORQQdMNwNkKxWS8z1ix+MRs61AM6g6QKZYwprM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aXSogdiXrXiGzlBymLGKQpERWSVIzeCJTi6eVTwtV472YC/LcnKCOQZBIwzs7QjvFpP5M3ZJtmjOWSjwskgnvhGEQN2WtA7HNFUOcaq5ShSJf3fdrKPohX4EXArUFwgNtdUoUGDLWUPqpzulg1ZwTgB2V0ikkYWGD+tafJ4zEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxMzkoy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxMzkoy8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E01DAC116B1;
	Fri, 19 Apr 2024 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713559593;
	bh=KW9pVORQQdMNwNkKxWS8z1ix+MRs61AM6g6QKZYwprM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SxMzkoy8QRsrUrZ6/QTTD/Gix0Ult/xG5yK4rGgEXRQ6ktKQxyIto9yGQ9KiJCQK+
	 JCL9SXEhwInGOJUyumVtRPVwBnlZtXlEdeofzTtQRNait2opvaEM2ucwKjJUz9WsbQ
	 uRiNS/TRxn6EfQrMe58DhzNgWpmpwI6fZFpAXJOrV/Vem8V/tCmjwetkqoabw2I3Qk
	 LVFmG1P/SQRjLkjolatFFhm+c/w7uRZfjub/OMjZkfu/qwK35kpBMzWxbaOvFP13zX
	 QW8uVEqsPtquCCEbiPodgoXOrL0u4aAcriPG+h4KIzzblowfTHIV/lUTPDDL/RTTLL
	 zBNkj+lMXwQng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD8F5C433E9;
	Fri, 19 Apr 2024 20:46:33 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiKJ1Q7Ib6Fj6I9S@3f3e8491d9e9>
References: <ZiKJ1Q7Ib6Fj6I9S@3f3e8491d9e9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiKJ1Q7Ib6Fj6I9S@3f3e8491d9e9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc5
X-PR-Tracked-Commit-Id: 7fd524b9bd1be210fe79035800f4bd78a41b349f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46b28503cdf35e1c34d9d135d91da91d3649ebaf
Message-Id: <171355959383.22865.2989568451590709170.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 20:46:33 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 19 Apr 2024 15:12:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46b28503cdf35e1c34d9d135d91da91d3649ebaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
